Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62B68C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 15:33:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D9D02080A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 15:33:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ANnVaIBD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404989AbfFKPdV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 11:33:21 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50920 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404969AbfFKPdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 11:33:19 -0400
Received: by mail-wm1-f68.google.com with SMTP id c66so3457135wmf.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 08:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FmwHZkaa1R0JoHSUEfjn8cTTt9MbvZmF4XV1+i5dOJs=;
        b=ANnVaIBDr6Rb5Xsy1nMlf077F1PNYlhLezpJGfv7aBrYbK22g3kJp6XwGIux1Kh8n6
         V7ZOcLfjxLSjhmpy9ZfRr4eDyLiQxBKFVgdMtC9ojjT3tceGUlFRWriQP3cOyOQA2vlm
         GMYqOabbuikmafaZWNZ8njzM1O0vfh4ZLrt7JRPZjPr+TQH8N6d9O3Q7NxhbTFMXtEdP
         Jl1/zTxFFKlLoH999beuymasml+5nggdIFRQs6ud2BqCAb8h+uro7JnWsTuLOJIN3EOP
         VmEbBti4O3KodEQEXhxcn/8dUFgrxd+cgGJpJf3A8AR3428B8ltO2mTuZ+qYNQhW0Afl
         8ITg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FmwHZkaa1R0JoHSUEfjn8cTTt9MbvZmF4XV1+i5dOJs=;
        b=RL/czLdJs6WSO3JC8jFKl0w/VjDEWcFeKRkMgaOM1lRGifj/qo557OdeUgkpOx24NT
         4b+VHv1ug++M0dA8exlKYkpCaOZp6C+yPRuMpndt4m+WspMFGnK/nyPS8Rtp4eVtiR+W
         0iRq6fNzwl0dwnU5m7c4PNKo+L+Bt4gvw0nsOacqVrWNQ60KsDSGu/axlkJjntsL+Yvm
         t0EdUxj2GNj1NRgjg5j4TrWV0eSU4u2QfKCbrnYGOEFAYkykZlZMTpQ5eT9X+FuRCfmC
         iP9Kf7QhEeQLfvUBIruttRRErTCMeXHOFT/rsksEjQnDOJp/VO/gHGI9EOk3bVVBrnEL
         fpVA==
X-Gm-Message-State: APjAAAV7IP4hZn1VDacsHcsMtFG8aagMDAOVNzwEPt2PzoXJ703QIyQM
        mofFCINAzol9GWCl6hr8Hwx2hQ==
X-Google-Smtp-Source: APXvYqydNj7AmRzG+3Qq8PgQaX6j7i/7O6nhWJxUKhU1e4OKdBd242MaaJf6tFbi0H/lTqVYqTGtUA==
X-Received: by 2002:a7b:c455:: with SMTP id l21mr18854700wmi.114.1560267196506;
        Tue, 11 Jun 2019 08:33:16 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id u25sm3379121wmc.3.2019.06.11.08.33.15
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 11 Jun 2019 08:33:15 -0700 (PDT)
Date:   Tue, 11 Jun 2019 16:33:14 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH 2/2] backlight: pwm_bl: Get number of brightness levels
 for CIE 1931 from the device tree
Message-ID: <20190611153314.cj6j6l4kcl4kk4t2@holly.lan>
References: <20190610233739.29477-1-mka@chromium.org>
 <20190610233739.29477-2-mka@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190610233739.29477-2-mka@chromium.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 10, 2019 at 04:37:39PM -0700, Matthias Kaehlcke wrote:
> Commit 88ba95bedb79 ("backlight: pwm_bl: Compute brightness of LED
> linearly to human eye") uses pwm_period / hweight32(pwm_period) as
> as heuristic to determine the number of brightness levels when the DT
> doesn't provide a brightness level table. This heuristic is broken
> and can result in excessively large brightness tables.
> 
> Instead of using the heuristic try to retrieve the number of
> brightness levels from the device tree (property 'max-brightness'
> + 1). If the value is not specified use a default of 256 levels.

I'll look at the code tomorrow but why 256?

To me it feels simultaneously too big for a simple 8-bit PWM and too
small for animated backlight effects.

I certainly agree that an override could be useful but I'm not clear why
deriving a default based on the period is bogus (and the description is
merely concerned about uselessly big tables).

/*
 * Once we have 4096 levels there's little point going much higher...
 * neither interactive sliders nor animation benefits from having
 * more values in the table.
 */
max_brightness = min(DIV_ROUND_UP(period, ffs(period), 4096);


Daniel.

> 
> Fixes: 88ba95bedb79 ("backlight: pwm_bl: Compute brightness of LED linearly to human eye")
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  drivers/video/backlight/pwm_bl.c | 59 ++++++++++++--------------------
>  1 file changed, 21 insertions(+), 38 deletions(-)
> 
> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
> index fb45f866b923..2913cbe9cfcb 100644
> --- a/drivers/video/backlight/pwm_bl.c
> +++ b/drivers/video/backlight/pwm_bl.c
> @@ -194,38 +194,19 @@ int pwm_backlight_brightness_default(struct device *dev,
>  				     struct platform_pwm_backlight_data *data,
>  				     unsigned int period)
>  {
> -	unsigned int counter = 0;
> -	unsigned int i, n;
> +	unsigned int i;
> +	unsigned int nlevels = data->max_brightness + 1;
>  	u64 retval;
>  
> -	/*
> -	 * Count the number of bits needed to represent the period number. The
> -	 * number of bits is used to calculate the number of levels used for the
> -	 * brightness-levels table, the purpose of this calculation is have a
> -	 * pre-computed table with enough levels to get linear brightness
> -	 * perception. The period is divided by the number of bits so for a
> -	 * 8-bit PWM we have 255 / 8 = 32 brightness levels or for a 16-bit PWM
> -	 * we have 65535 / 16 = 4096 brightness levels.
> -	 *
> -	 * Note that this method is based on empirical testing on different
> -	 * devices with PWM of 8 and 16 bits of resolution.
> -	 */
> -	n = period;
> -	while (n) {
> -		counter += n % 2;
> -		n >>= 1;
> -	}
> -
> -	data->max_brightness = DIV_ROUND_UP(period, counter);
> -	data->levels = devm_kcalloc(dev, data->max_brightness,
> +	data->levels = devm_kcalloc(dev, nlevels,
>  				    sizeof(*data->levels), GFP_KERNEL);
>  	if (!data->levels)
>  		return -ENOMEM;
>  
>  	/* Fill the table using the cie1931 algorithm */
> -	for (i = 0; i < data->max_brightness; i++) {
> +	for (i = 0; i < nlevels; i++) {
>  		retval = cie1931((i * PWM_LUMINANCE_SCALE) /
> -				 data->max_brightness, PWM_LUMINANCE_SCALE) *
> +				 nlevels, PWM_LUMINANCE_SCALE) *
>  				 period;
>  		retval = DIV_ROUND_CLOSEST_ULL(retval, PWM_LUMINANCE_SCALE);
>  		if (retval > UINT_MAX)
> @@ -233,8 +214,7 @@ int pwm_backlight_brightness_default(struct device *dev,
>  		data->levels[i] = (unsigned int)retval;
>  	}
>  
> -	data->dft_brightness = data->max_brightness / 2;
> -	data->max_brightness--;
> +	data->dft_brightness = nlevels / 2;
>  
>  	return 0;
>  }
> @@ -272,8 +252,13 @@ static int pwm_backlight_parse_dt(struct device *dev,
>  	 * set a default table of brightness levels will be used.
>  	 */
>  	prop = of_find_property(node, "brightness-levels", &length);
> -	if (!prop)
> +	if (!prop) {
> +		if (of_property_read_u32(node, "max-brightness",
> +					 &data->max_brightness))
> +			data->max_brightness = 255;
> +
>  		return 0;
> +	}
>  
>  	data->max_brightness = length / sizeof(u32);
>  
> @@ -565,13 +550,10 @@ static int pwm_backlight_probe(struct platform_device *pdev)
>  
>  			pb->levels = data->levels;
>  		}
> -	} else if (!data->max_brightness) {
> +	} else if (node) {
>  		/*
> -		 * If no brightness levels are provided and max_brightness is
> -		 * not set, use the default brightness table. For the DT case,
> -		 * max_brightness is set to 0 when brightness levels is not
> -		 * specified. For the non-DT case, max_brightness is usually
> -		 * set to some value.
> +		 * If no brightness levels are provided use the default
> +		 * brightness table.
>  		 */
>  
>  		/* Get the PWM period (in nanoseconds) */
> @@ -591,12 +573,13 @@ static int pwm_backlight_probe(struct platform_device *pdev)
>  
>  			pb->levels = data->levels;
>  		}
> -	} else {
> -		/*
> -		 * That only happens for the non-DT case, where platform data
> -		 * sets the max_brightness value.
> -		 */
> +	} else if (data->max_brightness) {
> +		/* non-DT case, max_brightness value set in platform data. */
>  		pb->scale = data->max_brightness;
> +	} else {
> +		dev_err(&pdev->dev, "max brightness is not specified\n");
> +		ret = -EINVAL;
> +		goto err_alloc;
>  	}
>  
>  	pb->lth_brightness = data->lth_brightness * (state.period / pb->scale);
> -- 
> 2.22.0.rc2.383.gf4fbbf30c2-goog
> 
