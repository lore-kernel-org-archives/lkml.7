Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D79EC43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 16:18:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6198D206C1
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 16:18:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbfD0QS4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 12:18:56 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:54386 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbfD0QSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 12:18:55 -0400
Received: from localhost (unknown [12.154.31.190])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 6471F14C711BA;
        Sat, 27 Apr 2019 09:18:54 -0700 (PDT)
Date:   Sat, 27 Apr 2019 12:18:50 -0400 (EDT)
Message-Id: <20190427.121850.1265777273042838957.davem@davemloft.net>
To:     laurentiu.tudor@nxp.com
Cc:     netdev@vger.kernel.org, madalin.bucur@nxp.com, roy.pledge@nxp.com,
        camelia.groza@nxp.com, leoyang.li@nxp.com,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/9] fsl/fman: backup and restore ICID registers
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190427071031.6563-4-laurentiu.tudor@nxp.com>
References: <20190427071031.6563-1-laurentiu.tudor@nxp.com>
        <20190427071031.6563-4-laurentiu.tudor@nxp.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 27 Apr 2019 09:18:55 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: laurentiu.tudor@nxp.com
Date: Sat, 27 Apr 2019 10:10:25 +0300

> @@ -1914,7 +1936,10 @@ static int fman_reset(struct fman *fman)
>  static int fman_init(struct fman *fman)
>  {
>  	struct fman_cfg *cfg = NULL;
> -	int err = 0, i, count;
> +	int err = 0, count;
> +#ifdef CONFIG_PPC
> +	int i;
> +#endif
>  
>  	if (is_init_done(fman->cfg))
>  		return -EINVAL;
> @@ -1934,6 +1959,7 @@ static int fman_init(struct fman *fman)
>  	memset_io((void __iomem *)(fman->base_addr + CGP_OFFSET), 0,
>  		  fman->state->fm_port_num_of_cg);
>  
> +#ifdef CONFIG_PPC
>  	/* Save LIODN info before FMan reset
>  	 * Skipping non-existent port 0 (i = 1)
>  	 */

Sorry, I'm not OK with littering a networking driver with arch ifdefs
all over the place.

Please create a proper abstraction and set of interfaces.

Thank you.
