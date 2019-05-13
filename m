Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD292C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 13:57:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E8E0208CA
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 13:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557755879;
	bh=0b/jDEfpoVdoWOpuMQmVLT3oBJA7MsEV00f4hRjuEXA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NY1yPoKISd3cdNmW+fm45D3LHxHudSz1Bw0GepQLv7tYfI79S+mKWUU8fYaRrtLLw
	 jje6Gku85MKTCiDN5l+bKB9PfzIkYllqoed0wdejk8TLx4jxtVx2QFQ1yjgBBaeYBA
	 vXsH9hAfy6aJ+BqEYOpD++Ta6PVHIyHIId3DXEac=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730290AbfEMN56 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 09:57:58 -0400
Received: from mga06.intel.com ([134.134.136.31]:63895 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727272AbfEMN56 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 09:57:58 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 May 2019 06:57:57 -0700
X-ExtLoop1: 1
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga008.jf.intel.com with ESMTP; 13 May 2019 06:57:56 -0700
Date:   Mon, 13 May 2019 07:52:35 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Akinobu Mita <akinobu.mita@gmail.com>
Cc:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        "Busch, Keith" <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        "Heitke, Kenneth" <kenneth.heitke@intel.com>
Subject: Re: [PATCH v3 6/7] nvme-pci: trigger device coredump on command
 timeout
Message-ID: <20190513135235.GD15318@localhost.localdomain>
References: <1557676457-4195-1-git-send-email-akinobu.mita@gmail.com>
 <1557676457-4195-7-git-send-email-akinobu.mita@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1557676457-4195-7-git-send-email-akinobu.mita@gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 12, 2019 at 08:54:16AM -0700, Akinobu Mita wrote:
> @@ -2536,6 +2539,9 @@ static void nvme_reset_work(struct work_struct *work)
>  	if (result)
>  		goto out;
>  
> +	nvme_coredump_logs(dev);

If you change nvme_coredump_logs to return an int, check it here for < 0
and abandon the reset if true.

> +	nvme_coredump_complete(dev);
> +
>  	if (dev->ctrl.oacs & NVME_CTRL_OACS_SEC_SUPP) {
>  		if (!dev->ctrl.opal_dev)
>  			dev->ctrl.opal_dev =
