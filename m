Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5DB5C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 21:55:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A69C0218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 21:55:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733268AbfB1Vz0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 16:55:26 -0500
Received: from asavdk3.altibox.net ([109.247.116.14]:34903 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbfB1Vz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 16:55:26 -0500
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id CDB7F20053;
        Thu, 28 Feb 2019 22:55:20 +0100 (CET)
Date:   Thu, 28 Feb 2019 22:55:19 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Claudiu.Beznea@microchip.com
Cc:     lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com,
        Ludovic.Desroches@microchip.com, bbrezillon@kernel.org,
        airlied@linux.ie, daniel@ffwll.ch, thierry.reding@gmail.com,
        devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Sandeep.Sheriker@microchip.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 6/7] drm: atmel-hlcdc: enable sys_clk during
 initalization.
Message-ID: <20190228215519.GE30188@ravnborg.org>
References: <1551284609-14594-1-git-send-email-claudiu.beznea@microchip.com>
 <1551284609-14594-7-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1551284609-14594-7-git-send-email-claudiu.beznea@microchip.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=dqr19Wo4 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=kj9zAlcOel0A:10 a=XYAwZIGsAAAA:8 a=e5mUnYsNAAAA:8
        a=2RQu7XLWcUR9zxScWdkA:9 a=7Zwj6sZBwVKJAoWSPKxL6X1jA+E=:19
        a=CjuIK1q_8ugA:10 a=E8ToXWR_bxluHZ7gmE-Z:22 a=Vxmtnl_E_bksehYqCbjh:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Claudiu

On Wed, Feb 27, 2019 at 04:24:40PM +0000, Claudiu.Beznea@microchip.com wrote:
> From: Sandeep Sheriker Mallikarjun <sandeepsheriker.mallikarjun@microchip.com>
> 
> For SAM9X60 SoC, sys_clk is through lcd_gclk clock source and this
> needs to be enabled before enabling lcd_clk.

We have "ownership" of the clocks in the mfd device.
So it would make more sense to let the mfd device handle
the base clocks.
In other words - what about pushing enable of perigh_clk and sys_clk to
the mfd driver.

This may have the nice side-effect that we avoid
that both the drm driver and the pwm driver enable/disable the periph_clk
as it is today.

Another comment - fixed_clksrc is used to determine if sys_clk is enabled.
But that flag is about the clksource selection, and it is just a coincidence
that the same flag can be used here.
Why we cannot always enable sys_clk? Do we need to do this only
for sam9x60?
IF yes, then add a new falg. If no, then skip the flag.

	Sam


> 
> Signed-off-by: Sandeep Sheriker Mallikarjun <sandeepsheriker.mallikarjun@microchip.com>
> [claudiu.beznea@microchip.com: add fixed_clksrc checks]
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
> index 0be13eceedba..8bf51f853721 100644
> --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
> +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
> @@ -625,10 +625,18 @@ static int atmel_hlcdc_dc_load(struct drm_device *dev)
>  	dc->hlcdc = dev_get_drvdata(dev->dev->parent);
>  	dev->dev_private = dc;
>  
> +	if (dc->desc->fixed_clksrc) {
> +		ret = clk_prepare_enable(dc->hlcdc->sys_clk);
> +		if (ret) {
> +			dev_err(dev->dev, "failed to enable sys_clk\n");
> +			goto err_destroy_wq;
> +		}
> +	}
> +
>  	ret = clk_prepare_enable(dc->hlcdc->periph_clk);
>  	if (ret) {
>  		dev_err(dev->dev, "failed to enable periph_clk\n");
> -		goto err_destroy_wq;
> +		goto err_sys_clk_disable;
>  	}
>  
>  	pm_runtime_enable(dev->dev);
> @@ -664,6 +672,9 @@ static int atmel_hlcdc_dc_load(struct drm_device *dev)
>  err_periph_clk_disable:
>  	pm_runtime_disable(dev->dev);
>  	clk_disable_unprepare(dc->hlcdc->periph_clk);
> +err_sys_clk_disable:
> +	if (dc->desc->fixed_clksrc)
> +		clk_disable_unprepare(dc->hlcdc->sys_clk);
>  
>  err_destroy_wq:
>  	destroy_workqueue(dc->wq);
> @@ -688,6 +699,8 @@ static void atmel_hlcdc_dc_unload(struct drm_device *dev)
>  
>  	pm_runtime_disable(dev->dev);
>  	clk_disable_unprepare(dc->hlcdc->periph_clk);
> +	if (dc->desc->fixed_clksrc)
> +		clk_disable_unprepare(dc->hlcdc->sys_clk);
>  	destroy_workqueue(dc->wq);
>  }
>  
> @@ -805,6 +818,8 @@ static int atmel_hlcdc_dc_drm_suspend(struct device *dev)
>  	regmap_read(regmap, ATMEL_HLCDC_IMR, &dc->suspend.imr);
>  	regmap_write(regmap, ATMEL_HLCDC_IDR, dc->suspend.imr);
>  	clk_disable_unprepare(dc->hlcdc->periph_clk);
> +	if (dc->desc->fixed_clksrc)
> +		clk_disable_unprepare(dc->hlcdc->sys_clk);
>  
>  	return 0;
>  }
> @@ -814,6 +829,8 @@ static int atmel_hlcdc_dc_drm_resume(struct device *dev)
>  	struct drm_device *drm_dev = dev_get_drvdata(dev);
>  	struct atmel_hlcdc_dc *dc = drm_dev->dev_private;
>  
> +	if (dc->desc->fixed_clksrc)
> +		clk_prepare_enable(dc->hlcdc->sys_clk);
>  	clk_prepare_enable(dc->hlcdc->periph_clk);
>  	regmap_write(dc->hlcdc->regmap, ATMEL_HLCDC_IER, dc->suspend.imr);
>  
> -- 
> 2.7.4
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
