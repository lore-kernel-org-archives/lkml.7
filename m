Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 114AEC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 20:34:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0CDD2077B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 20:34:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbfLJUeZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 15:34:25 -0500
Received: from asavdk3.altibox.net ([109.247.116.14]:47468 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbfLJUeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 15:34:24 -0500
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 960AF20061;
        Tue, 10 Dec 2019 21:34:20 +0100 (CET)
Date:   Tue, 10 Dec 2019 21:34:19 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     bbrezillon@kernel.org, airlied@linux.ie, daniel@ffwll.ch,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        ludovic.desroches@microchip.com, lee.jones@linaro.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sandeep Sheriker Mallikarjun 
        <sandeepsheriker.mallikarjun@microchip.com>
Subject: Re: [PATCH 5/5] Revert "drm: atmel-hlcdc: enable sys_clk during
 initalization."
Message-ID: <20191210203419.GB24756@ravnborg.org>
References: <1575984287-26787-1-git-send-email-claudiu.beznea@microchip.com>
 <1575984287-26787-6-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1575984287-26787-6-git-send-email-claudiu.beznea@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=eMA9ckh1 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=XYAwZIGsAAAA:8
        a=vRqltxJg2XVFi9nfVjoA:9 a=CjuIK1q_8ugA:10 a=E8ToXWR_bxluHZ7gmE-Z:22
        a=pHzHmUro8NiASowvMSCR:22 a=Ew2E2A-JSTLzCXPT_086:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Cladiu

On Tue, Dec 10, 2019 at 03:24:47PM +0200, Claudiu Beznea wrote:
> This reverts commit d2c755e66617620b729041c625a6396c81d1231c.
> ("drm: atmel-hlcdc: enable sys_clk during initalization."). With
> commit "drm: atmel-hlcdc: enable clock before configuring timing engine"
> there is no need for this patch. Code is also simpler.
> 
> Cc: Sandeep Sheriker Mallikarjun <sandeepsheriker.mallikarjun@microchip.com>
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>

Getting further in the patches tells me you looked at the
patch I referenced in previous mail.
Please squash the two patches together - that would make it
easier to follow what is done.

With the two patches applied sysclk is enabled only in mode_set_nofb()
and atomic_enable(). And disabled in atomic_disable().
This is simpler and we drop the conditionals. Also good.
So the end result looks OK.

	Sam

> ---
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c | 19 +------------------
>  1 file changed, 1 insertion(+), 18 deletions(-)
> 
> diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
> index 8dc917a1270b..112aa5066cee 100644
> --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
> +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
> @@ -721,18 +721,10 @@ static int atmel_hlcdc_dc_load(struct drm_device *dev)
>  	dc->hlcdc = dev_get_drvdata(dev->dev->parent);
>  	dev->dev_private = dc;
>  
> -	if (dc->desc->fixed_clksrc) {
> -		ret = clk_prepare_enable(dc->hlcdc->sys_clk);
> -		if (ret) {
> -			dev_err(dev->dev, "failed to enable sys_clk\n");
> -			goto err_destroy_wq;
> -		}
> -	}
> -
>  	ret = clk_prepare_enable(dc->hlcdc->periph_clk);
>  	if (ret) {
>  		dev_err(dev->dev, "failed to enable periph_clk\n");
> -		goto err_sys_clk_disable;
> +		goto err_destroy_wq;
>  	}
>  
>  	pm_runtime_enable(dev->dev);
> @@ -768,9 +760,6 @@ static int atmel_hlcdc_dc_load(struct drm_device *dev)
>  err_periph_clk_disable:
>  	pm_runtime_disable(dev->dev);
>  	clk_disable_unprepare(dc->hlcdc->periph_clk);
> -err_sys_clk_disable:
> -	if (dc->desc->fixed_clksrc)
> -		clk_disable_unprepare(dc->hlcdc->sys_clk);
>  
>  err_destroy_wq:
>  	destroy_workqueue(dc->wq);
> @@ -795,8 +784,6 @@ static void atmel_hlcdc_dc_unload(struct drm_device *dev)
>  
>  	pm_runtime_disable(dev->dev);
>  	clk_disable_unprepare(dc->hlcdc->periph_clk);
> -	if (dc->desc->fixed_clksrc)
> -		clk_disable_unprepare(dc->hlcdc->sys_clk);
>  	destroy_workqueue(dc->wq);
>  }
>  
> @@ -910,8 +897,6 @@ static int atmel_hlcdc_dc_drm_suspend(struct device *dev)
>  	regmap_read(regmap, ATMEL_HLCDC_IMR, &dc->suspend.imr);
>  	regmap_write(regmap, ATMEL_HLCDC_IDR, dc->suspend.imr);
>  	clk_disable_unprepare(dc->hlcdc->periph_clk);
> -	if (dc->desc->fixed_clksrc)
> -		clk_disable_unprepare(dc->hlcdc->sys_clk);
>  
>  	return 0;
>  }
> @@ -921,8 +906,6 @@ static int atmel_hlcdc_dc_drm_resume(struct device *dev)
>  	struct drm_device *drm_dev = dev_get_drvdata(dev);
>  	struct atmel_hlcdc_dc *dc = drm_dev->dev_private;
>  
> -	if (dc->desc->fixed_clksrc)
> -		clk_prepare_enable(dc->hlcdc->sys_clk);
>  	clk_prepare_enable(dc->hlcdc->periph_clk);
>  	regmap_write(dc->hlcdc->regmap, ATMEL_HLCDC_IER, dc->suspend.imr);
>  
> -- 
> 2.7.4
