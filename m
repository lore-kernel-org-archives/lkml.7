Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CE3AC4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 11:19:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7355D20673
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 11:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571051960;
	bh=X4elw6jF/r4VfM2UfZRGiJqLv8Hs7zS8c7dDfGSQ9A4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gEFOeR6kWt+Sd8qDbY9XhaSmSk/Rp1aE+bMNzB5p7F+Xvsy/kUVCJRTdm3zsZWvNy
	 nQh1s5nV26E4k4mmL//T7cjcMqAKUtiGIViYOIAfrKEXyNL9O3R/UiHdnzNHGgtVfC
	 ELViHzHpnYQCSIaexThHSg5M+o0PLHv2cGIVG0tA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730100AbfJNLTT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 07:19:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:35962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726351AbfJNLTT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 07:19:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7FA482084B;
        Mon, 14 Oct 2019 11:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571051957;
        bh=X4elw6jF/r4VfM2UfZRGiJqLv8Hs7zS8c7dDfGSQ9A4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jo10PZ9Sm+Ga5zLRKPLd3NKFnZ1Syr5sULG0QmLomIzHkX8ybMLQxIlHlFEKORAuW
         E6AAeQCXCkJFGqc0jDJTPJf5ahJvm2yRMOAP1Pd3bkQMKUlhEbHEwYdVgLpfXc/r4V
         xbl+IBP1MGyo2qqhGTQ1kszbGGSSMfEtbwNKGAkY=
Date:   Mon, 14 Oct 2019 13:19:14 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Jerome Pouiller <Jerome.Pouiller@silabs.com>
Cc:     zhong jiang <zhongjiang@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RESEND v2] staging: wfx: fix an undefined reference error
 when CONFIG_MMC=m
Message-ID: <20191014111914.GA35354@kroah.com>
References: <1570811647-64905-1-git-send-email-zhongjiang@huawei.com>
 <5DA13F17.6090409@huawei.com>
 <2927969.oKuMf0pyRb@pc-42>
 <2864258.2Qbmp6UNZe@pc-42>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2864258.2Qbmp6UNZe@pc-42>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2019 at 10:06:25AM +0000, Jerome Pouiller wrote:
> On Monday 14 October 2019 11:53:19 CEST Jérôme Pouiller wrote:
> [...]
> > Hello Zhong,
> > 
> > Now, I see the problem. It happens when CONFIG_MMC=m and CONFIG_WFX=y
> > (if CONFIG_WFX=m, it works).
> > 
> > I think the easiest way to solve problem is to disallow CONFIG_WFX=y if 
> > CONFIG_MMC=m.
> > 
> > This solution impacts users who want to use SPI bus with configuration:
> > CONFIG_WFX=y + CONFIG_SPI=y + CONFIG_MMC=m. However, I think this is a
> > twisted case. So, I think it won't be missed.
> > 
> > I think that patch below do the right thing:
> > 
> > -----8<----------8<----------------------8<-----------------
> > 
> > diff --git i/drivers/staging/wfx/Kconfig w/drivers/staging/wfx/Kconfig
> > index 9b8a1c7a9e90..833f3b05b6b4 100644
> > --- i/drivers/staging/wfx/Kconfig
> > +++ w/drivers/staging/wfx/Kconfig
> > @@ -1,7 +1,7 @@
> >  config WFX
> >         tristate "Silicon Labs wireless chips WF200 and further"
> >         depends on MAC80211
> > -       depends on (SPI || MMC)
> > +       depends on (MMC=m && m) || MMC=y || (SPI && MMC!=m)
> >         help
> >           This is a driver for Silicons Labs WFxxx series (WF200 and further)
> >           chipsets. This chip can be found on SPI or SDIO buses.
> > 
> > 
> > 
> 
> An alternative (more understandable?):
> 
> diff --git i/drivers/staging/wfx/Kconfig w/drivers/staging/wfx/Kconfig
> index 9b8a1c7a9e90..83ee4d0ca8c6 100644
> --- i/drivers/staging/wfx/Kconfig
> +++ w/drivers/staging/wfx/Kconfig
> @@ -1,6 +1,7 @@
>  config WFX
>         tristate "Silicon Labs wireless chips WF200 and further"
>         depends on MAC80211
> +       depends on MMC || !MMC # do not allow WFX=y if MMC=m
>         depends on (SPI || MMC)
>         help
>           This is a driver for Silicons Labs WFxxx series (WF200 and further)

Yes, this is much easier to understand.

thanks,

greg k-h
