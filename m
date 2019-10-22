Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8F32CA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 10:14:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A912E2075A
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 10:14:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fRFiFu91"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731747AbfJVKOW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 06:14:22 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41783 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727101AbfJVKOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 06:14:22 -0400
Received: by mail-wr1-f67.google.com with SMTP id p4so17371833wrm.8
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 03:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ecp7w/hJmXBVWFySg3KpzIRhvM49DSx8lFHehzy7hk0=;
        b=fRFiFu9115aCE+SgtQZi4fJ3gGrz7s99XoenJ0ll+4BbNyYVHfehhS/TgSO8/MNxiK
         wwecmTwAPsjrc+Hj/hgjLWz11X+sweN1cPESRp41Q150VwGfLDHW1SmKZMk8JZPJTXs7
         3SV6wGOX1b5QOcslTm2aou+1oRmAwbePg1zZZYbqzBdSNMhHb/ParUdwX0haH4Sf4COA
         VgW0Q8mE9zp4LoCF0PT/p9QoFC9Ox4117lV60UZCcmcZi78FU5qPf316/I5JCC2/VZPR
         3rRBedVtPBkiORU65dNmroqlaRDNYzYYJcPqrbW3vT+Y3sAigm1A2YxAi91Jv/+NZvvj
         PbTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ecp7w/hJmXBVWFySg3KpzIRhvM49DSx8lFHehzy7hk0=;
        b=niTmHPELKSegksMpgblmGCPk0N9fgujESavtew1dTbUbDzO9x56LsXdGPsGT1nivp1
         H57fxe2mbBZMWgFrRxtfFg1YcZLbvzBESMkfXfmYlXKQbEbenS25+XYRc3YfhFv+x4+f
         mU9Rk6JJ9r0a3NwHkakv+Cf8plx7PXkQK4FemnhG8HkGNOQsVvxKQ/lmeoBYmfF9MeRS
         D10MXMhD9diRfxoxDFjUYTRwJAewa4w1tiNCJ40/0vXDsC2TEzpkHOu4jOJcvpaBL8Z2
         RGY8Ky6dTtYj34Q50pLzXLDZZVPJInIs6ayJfKubgOhqy2PsvXdpi2amNbJnToa3QwDo
         EwjA==
X-Gm-Message-State: APjAAAVXfjgq6xOXIX2h9i3C2/5a6L9c/2/jY8s1atLZsmyOuRCGjipu
        LmoAiwVmwS2jhY9duGkNTIBR7A==
X-Google-Smtp-Source: APXvYqy69MSDwMGJydjlO5jDUJHbFqo/+EKRl4bhfBg3eHvYxjqMrge6DsMg/kqLwPmoSguq6vUTyw==
X-Received: by 2002:a05:6000:1288:: with SMTP id f8mr2667048wrx.111.1571739259892;
        Tue, 22 Oct 2019 03:14:19 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id l7sm8333986wro.17.2019.10.22.03.14.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 03:14:19 -0700 (PDT)
Date:   Tue, 22 Oct 2019 11:14:17 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jacopo Mondi <jacopo@jmondi.org>, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v7 3/9] backlight: gpio: explicitly set the direction of
 the GPIO
Message-ID: <20191022101417.24zkd3htnyfg3hy6@holly.lan>
References: <20191022083630.28175-1-brgl@bgdev.pl>
 <20191022083630.28175-4-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191022083630.28175-4-brgl@bgdev.pl>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2019 at 10:36:24AM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> The GPIO backlight driver currently requests the line 'as is', without
> acively setting its direction. This can lead to problems: if the line
> is in input mode by default, we won't be able to drive it later when
> updating the status and also reading its initial value doesn't make
> sense for backlight setting.
> 
> Request the line 'as is' initially, so that we can read its value
> without affecting it but then change the direction to output explicitly
> when setting the initial brightness.
> 
> Also: check the current direction and only read the value if it's output.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>

> ---
>  drivers/video/backlight/gpio_backlight.c | 23 ++++++++++++++++++-----
>  1 file changed, 18 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/video/backlight/gpio_backlight.c b/drivers/video/backlight/gpio_backlight.c
> index 3955b513f2f8..52f17c9ca1c3 100644
> --- a/drivers/video/backlight/gpio_backlight.c
> +++ b/drivers/video/backlight/gpio_backlight.c
> @@ -25,9 +25,8 @@ struct gpio_backlight {
>  	int def_value;
>  };
>  
> -static int gpio_backlight_update_status(struct backlight_device *bl)
> +static int gpio_backlight_get_next_brightness(struct backlight_device *bl)
>  {
> -	struct gpio_backlight *gbl = bl_get_data(bl);
>  	int brightness = bl->props.brightness;
>  
>  	if (bl->props.power != FB_BLANK_UNBLANK ||
> @@ -35,6 +34,14 @@ static int gpio_backlight_update_status(struct backlight_device *bl)
>  	    bl->props.state & (BL_CORE_SUSPENDED | BL_CORE_FBBLANK))
>  		brightness = 0;
>  
> +	return brightness;
> +}
> +
> +static int gpio_backlight_update_status(struct backlight_device *bl)
> +{
> +	struct gpio_backlight *gbl = bl_get_data(bl);
> +	int brightness = gpio_backlight_get_next_brightness(bl);
> +
>  	gpiod_set_value_cansleep(gbl->gpiod, brightness);
>  
>  	return 0;
> @@ -85,7 +92,8 @@ static int gpio_backlight_initial_power_state(struct gpio_backlight *gbl)
>  		return gbl->def_value ? FB_BLANK_UNBLANK : FB_BLANK_POWERDOWN;
>  
>  	/* if the enable GPIO is disabled, do not enable the backlight */
> -	if (gpiod_get_value_cansleep(gbl->gpiod) == 0)
> +	if (gpiod_get_direction(gbl->gpiod) == 0 &&
> +	    gpiod_get_value_cansleep(gbl->gpiod) == 0)
>  		return FB_BLANK_POWERDOWN;
>  
>  	return FB_BLANK_UNBLANK;
> @@ -98,7 +106,7 @@ static int gpio_backlight_probe(struct platform_device *pdev)
>  	struct backlight_properties props;
>  	struct backlight_device *bl;
>  	struct gpio_backlight *gbl;
> -	int ret;
> +	int ret, init_brightness;
>  
>  	gbl = devm_kzalloc(&pdev->dev, sizeof(*gbl), GFP_KERNEL);
>  	if (gbl == NULL)
> @@ -151,7 +159,12 @@ static int gpio_backlight_probe(struct platform_device *pdev)
>  	bl->props.power = gpio_backlight_initial_power_state(gbl);
>  	bl->props.brightness = 1;
>  
> -	backlight_update_status(bl);
> +	init_brightness = gpio_backlight_get_next_brightness(bl);
> +	ret = gpiod_direction_output(gbl->gpiod, init_brightness);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to set initial brightness\n");
> +		return ret;
> +	}
>  
>  	platform_set_drvdata(pdev, bl);
>  	return 0;
> -- 
> 2.23.0
> 
