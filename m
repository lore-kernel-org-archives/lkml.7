Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBF8BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 21:39:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E13F218B0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 21:39:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731063AbfB1VjG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 16:39:06 -0500
Received: from asavdk3.altibox.net ([109.247.116.14]:34519 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727545AbfB1VjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 16:39:06 -0500
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id E9F6520053;
        Thu, 28 Feb 2019 22:39:00 +0100 (CET)
Date:   Thu, 28 Feb 2019 22:38:58 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Claudiu.Beznea@microchip.com
Cc:     lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com,
        Ludovic.Desroches@microchip.com, bbrezillon@kernel.org,
        airlied@linux.ie, daniel@ffwll.ch, thierry.reding@gmail.com,
        devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/7] drm: atmel-hlcdc: add config option for clock
 selection
Message-ID: <20190228213858.GC30188@ravnborg.org>
References: <1551284609-14594-1-git-send-email-claudiu.beznea@microchip.com>
 <1551284609-14594-2-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1551284609-14594-2-git-send-email-claudiu.beznea@microchip.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=dqr19Wo4 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=kj9zAlcOel0A:10 a=XYAwZIGsAAAA:8 a=E3GQLJsnf6gl6KnigtoA:9
        a=CjuIK1q_8ugA:10 a=E8ToXWR_bxluHZ7gmE-Z:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Claudiu

One more reply to this patch...

On Wed, Feb 27, 2019 at 04:24:16PM +0000, Claudiu.Beznea@microchip.com wrote:
> From: Claudiu Beznea <claudiu.beznea@microchip.com>
> 
> SAM9x60 LCD Controller has no option to select clock source as previous
> controllers have. To be able to use the same driver even for this LCD
> controller add a config option to know if controller supports this.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c | 12 +++++++-----
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h   |  2 ++
>  2 files changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
> index 8070a558d7b1..17a7a18f6a07 100644
> --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
> +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
> @@ -78,7 +78,8 @@ static void atmel_hlcdc_crtc_mode_set_nofb(struct drm_crtc *c)
>  	unsigned long mode_rate;
>  	struct videomode vm;
>  	unsigned long prate;
> -	unsigned int cfg;
> +	unsigned int mask = ATMEL_HLCDC_CLKDIV_MASK | ATMEL_HLCDC_CLKPOL;
> +	unsigned int cfg = 0;
>  	int div;
>  
>  	vm.vfront_porch = adj->crtc_vsync_start - adj->crtc_vdisplay;
> @@ -101,7 +102,10 @@ static void atmel_hlcdc_crtc_mode_set_nofb(struct drm_crtc *c)
>  		     (adj->crtc_hdisplay - 1) |
>  		     ((adj->crtc_vdisplay - 1) << 16));
>  
> -	cfg = ATMEL_HLCDC_CLKSEL;
> +	if (!crtc->dc->desc->fixed_clksrc) {
> +		cfg = ATMEL_HLCDC_CLKSEL;
> +		mask |= ATMEL_HLCDC_CLKSEL;
> +	}
Maybe this is just too late to look at code, but I do not get this.
If the sam9x60 do not support selecting the clk rate then I assume it is either
fixed to used system clock or 2 x system clock.

And we have in the driver code to adjust the "div" value.
The value of div depends on the CLKSEL configuration, so there must
be one part of this that is not valid when fixed_clksrc is true.

>  
>  	prate = 2 * clk_get_rate(crtc->dc->hlcdc->sys_clk);
>  	mode_rate = adj->crtc_clock * 1000;
> @@ -132,9 +136,7 @@ static void atmel_hlcdc_crtc_mode_set_nofb(struct drm_crtc *c)
>  
>  	cfg |= ATMEL_HLCDC_CLKDIV(div);

It is the following code (not visible in this patch I talk about:
       if (div < 2) {
                div = 2;
        } else if (ATMEL_HLCDC_CLKDIV(div) & ~ATMEL_HLCDC_CLKDIV_MASK) {
                /* The divider ended up too big, try a lower base rate. */
                cfg &= ~ATMEL_HLCDC_CLKSEL;
                prate /= 2;
                div = DIV_ROUND_UP(prate, mode_rate);
                if (ATMEL_HLCDC_CLKDIV(div) & ~ATMEL_HLCDC_CLKDIV_MASK)
                        div = ATMEL_HLCDC_CLKDIV_MASK;
        } else {
                int div_low = prate / mode_rate;

                if (div_low >= 2 &&
                    ((prate / div_low - mode_rate) <
                     10 * (mode_rate - prate / div)))
                        /*
                         * At least 10 times better when using a higher
                         * frequency than requested, instead of a lower.
                         * So, go with that.
                         */
                        div = div_low;
        }

Am I missing something obvious?

> -	regmap_update_bits(regmap, ATMEL_HLCDC_CFG(0),
> -			   ATMEL_HLCDC_CLKSEL | ATMEL_HLCDC_CLKDIV_MASK |
> -			   ATMEL_HLCDC_CLKPOL, cfg);
> +	regmap_update_bits(regmap, ATMEL_HLCDC_CFG(0), mask, cfg);
>  
>  	cfg = 0;
>  
> diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
> index 70bd540d644e..0155efb9c443 100644
> --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
> +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
> @@ -328,6 +328,7 @@ atmel_hlcdc_layer_to_plane(struct atmel_hlcdc_layer *layer)
>   * @max_hpw: maximum horizontal back/front porch width
>   * @conflicting_output_formats: true if RGBXXX output formats conflict with
>   *				each other.
> + * @fixed_clksrc: true if clock source is fixed
Be specific here. Tell if "fixed_clksrc == true" equals system clock or 2 x system clock.

	Sam
