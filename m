Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44FB3C76190
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 15:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1922C204FD
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 15:22:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SW2BLq/I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728795AbfGVPWL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 11:22:11 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40729 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728288AbfGVPWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 11:22:10 -0400
Received: by mail-wm1-f66.google.com with SMTP id v19so35765569wmj.5
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 08:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CjN06kskuSN63zvz3I8U6ASqKJRxwYLJel4cw/9K0lw=;
        b=SW2BLq/I4O/PnHgn1NA2q1TeVho/oHOeDcYpL3qFIQggNojxG22k4aZiFGmAg3qjZw
         sNH03/H7fUd1hP+JYWFhSUX8oVoTRU3bnRNRtsbc1lJviN3M++fuo80AkU9hWv+dRbu6
         mg0kIKTw66qN8Z3uRv1t8IVBOT8WAVgLsmzb74vtLhqfx+4hcnmk6kNrJvkgbtcno8JY
         0FDCNFNg9zgMDxr5NKN1TXvrZYwVniccPCYF6S1oN3eH/gHp9jUbauxk12vI4YbezNDT
         UsyQt5Z+DG/nC780HdW0gYFTNsc/rKkiLemjOICIiX9L0i2dF+lRJlhDPXFtvtYGgReH
         kIiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CjN06kskuSN63zvz3I8U6ASqKJRxwYLJel4cw/9K0lw=;
        b=dWgQPSKD1JnCQyqOouY/7jIlOMzKkZXrjC8CiE9+cSFtBzrLTvAXe9pLQVcUm14TuO
         AoYrSaPndJzlSqCscpDiZBWhana1s5E0xLgJgraQnbUeewLquiH6dzx/apTgCxdFCCas
         2foPtUcFV0DAR2gWm5aS4zCSyGGpHER15QV6kkvzhawWgEz7OGo3FsBPBGMlHJGyWQL3
         dhC8N16PAydoQSASgtQVMoXv6dUT1QydCVqfbsTUJ8g/vt/2L67VWj2xMaOKSvVyp4Bu
         X3otbYARFewKdDSOIKw0dkArImHRc+vQdX8ECvlngCTvO750Fp/0VTMQc0deDco6Tv7F
         Gd8Q==
X-Gm-Message-State: APjAAAX58xbWrpH3rksQQI4y80VUKGr2iJz55vWZHIGn9+vfH7ocke8G
        PMn6OTzkOPwtsn5XYtkSiRHoGw==
X-Google-Smtp-Source: APXvYqxEqJt2WlO+GoY0nM0FoV0BovseVpbAQSrNlFd4NlDuP4uXJmvali/FscgOt4YbJnNBVzR6bg==
X-Received: by 2002:a7b:c74a:: with SMTP id w10mr61057896wmk.99.1563808928497;
        Mon, 22 Jul 2019 08:22:08 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id i18sm51360450wrp.91.2019.07.22.08.22.07
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Jul 2019 08:22:07 -0700 (PDT)
Date:   Mon, 22 Jul 2019 16:22:06 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v2 6/7] backlight: gpio: remove def_value from struct
 gpio_backlight
Message-ID: <20190722152206.bfjlws53yknq3xv4@holly.lan>
References: <20190722150302.29526-1-brgl@bgdev.pl>
 <20190722150302.29526-7-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190722150302.29526-7-brgl@bgdev.pl>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 05:03:01PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> This field is unused outside of probe(). There's no need to store it.
> We can make it into a local variable.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>

> ---
>  drivers/video/backlight/gpio_backlight.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/video/backlight/gpio_backlight.c b/drivers/video/backlight/gpio_backlight.c
> index 70882556f047..cd6a75bca9cc 100644
> --- a/drivers/video/backlight/gpio_backlight.c
> +++ b/drivers/video/backlight/gpio_backlight.c
> @@ -21,7 +21,6 @@
>  struct gpio_backlight {
>  	struct device *fbdev;
>  	struct gpio_desc *gpiod;
> -	int def_value;
>  };
>  
>  static int gpio_backlight_update_status(struct backlight_device *bl)
> @@ -61,7 +60,7 @@ static int gpio_backlight_probe(struct platform_device *pdev)
>  	struct backlight_device *bl;
>  	struct gpio_backlight *gbl;
>  	enum gpiod_flags flags;
> -	int ret;
> +	int ret, def_value;
>  
>  	gbl = devm_kzalloc(&pdev->dev, sizeof(*gbl), GFP_KERNEL);
>  	if (gbl == NULL)
> @@ -70,8 +69,8 @@ static int gpio_backlight_probe(struct platform_device *pdev)
>  	if (pdata)
>  		gbl->fbdev = pdata->fbdev;
>  
> -	gbl->def_value = device_property_read_bool(&pdev->dev, "default-on");
> -	flags = gbl->def_value ? GPIOD_OUT_HIGH : GPIOD_OUT_LOW;
> +	def_value = device_property_read_bool(&pdev->dev, "default-on");
> +	flags = def_value ? GPIOD_OUT_HIGH : GPIOD_OUT_LOW;
>  
>  	gbl->gpiod = devm_gpiod_get(&pdev->dev, NULL, flags);
>  	if (IS_ERR(gbl->gpiod)) {
> @@ -94,7 +93,7 @@ static int gpio_backlight_probe(struct platform_device *pdev)
>  		return PTR_ERR(bl);
>  	}
>  
> -	bl->props.brightness = gbl->def_value;
> +	bl->props.brightness = def_value;
>  	backlight_update_status(bl);
>  
>  	platform_set_drvdata(pdev, bl);
> -- 
> 2.21.0
> 
