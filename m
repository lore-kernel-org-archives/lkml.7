Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0E79C3A59E
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 00:06:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BA8D216F4
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 00:06:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728643AbfHVAG5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 20:06:57 -0400
Received: from verein.lst.de ([213.95.11.211]:41942 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726828AbfHVAG5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 20:06:57 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id AEBD168C7B; Thu, 22 Aug 2019 02:06:52 +0200 (CEST)
Date:   Thu, 22 Aug 2019 02:06:52 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Marta Rybczynska <mrybczyn@kalray.eu>
Cc:     kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Samuel Jones <sjones@kalray.eu>,
        Guillaume Missonnier <gmissonnier@kalray.eu>
Subject: Re: [PATCH v2] nvme: allow 64-bit results in passthru commands
Message-ID: <20190822000652.GF9511@lst.de>
References: <89520652.56920183.1565948841909.JavaMail.zimbra@kalray.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89520652.56920183.1565948841909.JavaMail.zimbra@kalray.eu>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2019 at 11:47:21AM +0200, Marta Rybczynska wrote:
> It is not possible to get 64-bit results from the passthru commands,
> what prevents from getting for the Capabilities (CAP) property value.
> 
> As a result, it is not possible to implement IOL's NVMe Conformance
> test 4.3 Case 1 for Fabrics targets [1] (page 123).
> 
> This issue has been already discussed [2], but without a solution.
> 
> This patch solves the problem by adding new ioctls with a new
> passthru structure, including 64-bit results. The older ioctls stay
> unchanged.

Ok, with my idea not being suitable I think I'm fine with this approach, a
little nitpick below:

> +static bool is_admin_cmd(unsigned int cmd)
> +{
> +	if ((cmd == NVME_IOCTL_ADMIN_CMD) || (cmd == NVME_IOCTL_ADMIN64_CMD))
> +		return true;
> +	return false;
> +}

No need for the inner braces.  But I'm actually not sure the current
code structure is very suitable for extending it.

> +
>  static int nvme_ioctl(struct block_device *bdev, fmode_t mode,
>  		unsigned int cmd, unsigned long arg)
>  {
> @@ -1418,13 +1473,13 @@ static int nvme_ioctl(struct block_device *bdev, fmode_t mode,
>  	 * seperately and drop the ns SRCU reference early.  This avoids a
>  	 * deadlock when deleting namespaces using the passthrough interface.
>  	 */
> -	if (cmd == NVME_IOCTL_ADMIN_CMD || is_sed_ioctl(cmd)) {
> +	if (is_admin_cmd(cmd) || is_sed_ioctl(cmd)) {

So maybe for this check we should have a is_ctrl_iocl() helper instead
that includes the is_sed_ioctl check.

>  		struct nvme_ctrl *ctrl = ns->ctrl;
>  
>  		nvme_get_ctrl(ns->ctrl);
>  		nvme_put_ns_from_disk(head, srcu_idx);
>  
> -		if (cmd == NVME_IOCTL_ADMIN_CMD)
> +		if (is_admin_cmd(cmd))
>  			ret = nvme_user_cmd(ctrl, NULL, argp);
>  		else
>  			ret = sed_ioctl(ctrl->opal_dev, cmd, argp);

And then we can move this whole branch into a helper function,
which then switches on the ioctl cmd, with sed_ioctl as the fallback.
