Return-Path: <SRS0=TpO6=UA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4A0CC28CC1
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 21:07:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A89122773F
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 21:07:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbfFAVHE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Jun 2019 17:07:04 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:33925 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbfFAVHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jun 2019 17:07:04 -0400
X-Originating-IP: 82.246.155.60
Received: from localhost (hy283-1-82-246-155-60.fbx.proxad.net [82.246.155.60])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 0904CE0005;
        Sat,  1 Jun 2019 21:06:53 +0000 (UTC)
Date:   Sat, 1 Jun 2019 23:06:51 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] video: fbdev: atmel_lcdfb: add COMPILE_TEST support
Message-ID: <20190601210651.GB3558@piout.net>
References: <CGME20190530123016eucas1p2e18747b8ac1d156657232eab52876a61@eucas1p2.samsung.com>
 <69cd6b8b-1fd1-86fa-2070-99d0ce15a868@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69cd6b8b-1fd1-86fa-2070-99d0ce15a868@samsung.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/05/2019 14:30:19+0200, Bartlomiej Zolnierkiewicz wrote:
> Add COMPILE_TEST support to atmel_lcdfb driver for better compile
> testing coverage.
> 
> While at it fix improper use of UL (to silence build warnings on
> x86_64).
> 
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

> Cc: Ludovic Desroches <ludovic.desroches@microchip.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
> v3: fix build warnings on x86_64

Hopefully, no building errors anymore ;)

> 
> v2: add missing HAVE_CLK && HAS IOMEM dependencies
> 
>  drivers/video/fbdev/Kconfig       |    3 ++-
>  drivers/video/fbdev/atmel_lcdfb.c |    4 ++--
>  2 files changed, 4 insertions(+), 3 deletions(-)
> 
> Index: b/drivers/video/fbdev/Kconfig
> ===================================================================
> --- a/drivers/video/fbdev/Kconfig
> +++ b/drivers/video/fbdev/Kconfig
> @@ -855,7 +855,8 @@ config FB_S1D13XXX
>  
>  config FB_ATMEL
>  	tristate "AT91 LCD Controller support"
> -	depends on FB && OF && HAVE_FB_ATMEL
> +	depends on FB && OF && HAVE_CLK && HAS_IOMEM
> +	depends on HAVE_FB_ATMEL || COMPILE_TEST
>  	select FB_BACKLIGHT
>  	select FB_CFB_FILLRECT
>  	select FB_CFB_COPYAREA
> Index: b/drivers/video/fbdev/atmel_lcdfb.c
> ===================================================================
> --- a/drivers/video/fbdev/atmel_lcdfb.c
> +++ b/drivers/video/fbdev/atmel_lcdfb.c
> @@ -673,7 +673,7 @@ static int atmel_lcdfb_set_par(struct fb
>  	lcdc_writel(sinfo, ATMEL_LCDC_MVAL, 0);
>  
>  	/* Disable all interrupts */
> -	lcdc_writel(sinfo, ATMEL_LCDC_IDR, ~0UL);
> +	lcdc_writel(sinfo, ATMEL_LCDC_IDR, ~0U);
>  	/* Enable FIFO & DMA errors */
>  	lcdc_writel(sinfo, ATMEL_LCDC_IER, ATMEL_LCDC_UFLWI | ATMEL_LCDC_OWRI | ATMEL_LCDC_MERI);
>  
> @@ -1291,7 +1291,7 @@ static int atmel_lcdfb_suspend(struct pl
>  	 * We don't want to handle interrupts while the clock is
>  	 * stopped. It may take forever.
>  	 */
> -	lcdc_writel(sinfo, ATMEL_LCDC_IDR, ~0UL);
> +	lcdc_writel(sinfo, ATMEL_LCDC_IDR, ~0U);
>  
>  	sinfo->saved_lcdcon = lcdc_readl(sinfo, ATMEL_LCDC_CONTRAST_CTR);
>  	lcdc_writel(sinfo, ATMEL_LCDC_CONTRAST_CTR, 0);

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
