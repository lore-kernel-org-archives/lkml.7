Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB559C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 21:26:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85AF620657
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 21:26:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729623AbfB1V0E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 16:26:04 -0500
Received: from asavdk4.altibox.net ([109.247.116.15]:40997 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbfB1V0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 16:26:04 -0500
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id E2A27803B1;
        Thu, 28 Feb 2019 22:25:59 +0100 (CET)
Date:   Thu, 28 Feb 2019 22:25:58 +0100
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
Message-ID: <20190228212558.GB30188@ravnborg.org>
References: <1551284609-14594-1-git-send-email-claudiu.beznea@microchip.com>
 <1551284609-14594-2-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1551284609-14594-2-git-send-email-claudiu.beznea@microchip.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=UpRNyd4B c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=kj9zAlcOel0A:10 a=XYAwZIGsAAAA:8 a=7gkXJVJtAAAA:8
        a=jifw5M_3MUKJ8-mDzlMA:9 a=CjuIK1q_8ugA:10 a=E8ToXWR_bxluHZ7gmE-Z:22
        a=E9Po1WZjFZOl8hwRPBS3:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Claudiu

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
Here cfg and mask has initial values.

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
And here mask is bitwise or with ATMEL_HLCDC_CLKSEL - fine.
But cfg is directly assigned.
If cfg was bitwise or the ATMEL_HLCDC_CLKSEL value then the code was prepared
to have extra flags added above these lines.

Only a small change and no functional difference.

With or without this change:
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>

