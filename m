Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A666C7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 11:13:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E34E42190F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 11:13:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KNjXtO5n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbfGXLN2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 07:13:28 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39701 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726981AbfGXLNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 07:13:24 -0400
Received: by mail-wr1-f68.google.com with SMTP id x4so46493666wrt.6
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 04:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NvtrvMV4Nt63Balca848q6E3+ZhiwJtTkFp748N0uOg=;
        b=KNjXtO5njYFUIck/ozHOGMIWJ6z+FSABuu2c1L59UTM9K87f1GzdoroCF41tDBxyrR
         7k+3fRTPUuhaq3B9Hijc4O3kz+rsb715JXcHhmvy1cm/35kj00R/EzG/AUcxC0wYxppv
         iBNLNR0Qu5clqaICWCeBMs7+LCiY7oa2wyFkQ4Nr6JaJiBv0yc9XgOn8jvykpYj4jW3W
         V7sQmX8uE7OD2tdKkFLBFOh541lVAexffqWUb9dR4X2gRStG/Mh45aD1PUGXtyWMOwnB
         /9zrSd3j+rQ0U9jRbeOYdTkoQdGX8XweZvzgaNJlPlXtjl8+spgMq1rkvRyuwBZuvav9
         Bcfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NvtrvMV4Nt63Balca848q6E3+ZhiwJtTkFp748N0uOg=;
        b=jw4FiWZtPFvS9vNBLXUqanWi8cfDBLrrKBgIYNgpZvEaNfxNIaULdrh5qYiIG+pAXw
         DMt22QVuMdXeVGOuWSEV80cJ59sMIjMcTDq6EgCdHIxMRC89wp0jTvqK2aVEBEe28LXH
         qIbqXWDMBb1Xe6oD7GUhfHeBVtp96HPIYd7IfIIJmiM13o8mJWI1m1JkxGXxw2AroAmK
         A7JORuTE44cEM9YeMCm7bnZcWlNlJW4fbwSEKU2p+XeBzkfPrBi/F5+2K3fos86gjU3R
         gjLYxYWIochyzIOvaTn1xFCsQeeKYqA4qB5liH7XOLJJx1CGUh1CDoDHWCW0lDS4QhFu
         DzNQ==
X-Gm-Message-State: APjAAAWOSKENPyvexum1ZDAgE1EfvFvprl0MsW113kAcIJ5QFKtaC+ii
        zZHifIN2qOXWwOFKm0AkzS0zbw==
X-Google-Smtp-Source: APXvYqx/dJQm29UHdXc22ek+l/R3WZ8DvlqPT7fB+ZSBlOpP1Vt6kKQ09cwEg8JrNSUsNUX8cyM6bw==
X-Received: by 2002:adf:ed4a:: with SMTP id u10mr93203495wro.284.1563966802936;
        Wed, 24 Jul 2019 04:13:22 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id c30sm80678542wrb.15.2019.07.24.04.13.22
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 04:13:22 -0700 (PDT)
Date:   Wed, 24 Jul 2019 12:13:20 +0100
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
Subject: Re: [PATCH v3 6/7] backlight: gpio: remove def_value from struct
 gpio_backlight
Message-ID: <20190724111320.wqcquhmlylgfkv6f@holly.lan>
References: <20190724082508.27617-1-brgl@bgdev.pl>
 <20190724082508.27617-7-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190724082508.27617-7-brgl@bgdev.pl>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2019 at 10:25:07AM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> This field is unused outside of probe(). There's no need to store it.
> We can make it into a local variable.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

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
