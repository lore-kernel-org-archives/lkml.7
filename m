Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60551C7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 11:13:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34F2C22ADA
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 11:13:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zjqzTsV3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727580AbfGXLNR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 07:13:17 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37754 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727554AbfGXLNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 07:13:15 -0400
Received: by mail-wr1-f65.google.com with SMTP id n9so21456367wrr.4
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 04:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7Vbm5wjodc/SiuXfd2hEHkZgRHnDrgsvnClch0dv500=;
        b=zjqzTsV3sC2VxjWuPXKIKiVPljJPuNhPm9Eo3muadrJX0uOfyeRP1+0z8ruC5+uBE8
         kVQXypwUufH1EOWhSVEgvJXaLmrs0dD55o0bQZSbPtok43uPOWIpgx/J9ZAgKcMaFDvL
         Q40uZcOODl7gy7dZ7D8EvD3qHOxoegPBkNvZbDy2dht2yPpcz8YA3FqP8NlU2lS2Msop
         7sLjI5SyXrArFojZqSZa/e/oXEezqOZOSvnXHGQv8PbPyAG2kVKvRxQ73NEGep2YjF3P
         9dVHmIOtgEXHiVWyCgsdpGlyQcxDu6ipd0Rj/NtFnYRAUHak5chJc/jqi6L4LTZESixq
         xvvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7Vbm5wjodc/SiuXfd2hEHkZgRHnDrgsvnClch0dv500=;
        b=id4twSYZ1W7Msb0FUoeHcvSZSVZzA6VCKfzpkCaBKSQY7aZ1orM3811jMRHvcYq39z
         LnX8lk7YMvVT6QfwBYLNu9dGtvaE+dPbrAfc7D7de/79JdLnLSwkRfwRsjJ9QdaajCpA
         X9jichB7iY71zg0j0uU36OFzdylvmwXqBfkqSYXDCdUEmuCQR8XE7JWMyF58lWUrF3aD
         03DfWW8mWxLpIK0syz9E6av3PC6lIgJiKcNfgTDO0fa3/dZSzPTRdAhljm0EmsEhaHGF
         RbFTc9qhXLnENT23p12IQX90GaJFqZXqAH7fHCkQ22BWnVvvQuPfsU4AdUIQrrUYTRkZ
         8zYw==
X-Gm-Message-State: APjAAAVwGD6zy0W1663nBf6E2MVo/XCuv0KmXghhZCgrR3haAWhHY4DM
        Sui88Zj0b6bxtxzDwFoEQOrpSg==
X-Google-Smtp-Source: APXvYqxXj3Bvg1DEF4zdhtIcF4p/ecaSTdTJ//QjjR1Lmf36EMffI7ShBaIJZCpNdPfg/rB/y9TOjQ==
X-Received: by 2002:adf:e8c2:: with SMTP id k2mr72432053wrn.198.1563966793314;
        Wed, 24 Jul 2019 04:13:13 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id g10sm33641138wrw.60.2019.07.24.04.13.12
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 04:13:12 -0700 (PDT)
Date:   Wed, 24 Jul 2019 12:13:11 +0100
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
Subject: Re: [PATCH v3 5/7] backlight: gpio: remove dev from struct
 gpio_backlight
Message-ID: <20190724111311.zkhc4qzdktrw4sak@holly.lan>
References: <20190724082508.27617-1-brgl@bgdev.pl>
 <20190724082508.27617-6-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190724082508.27617-6-brgl@bgdev.pl>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2019 at 10:25:06AM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> This field is unused. Remove it.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>

> ---
>  drivers/video/backlight/gpio_backlight.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/video/backlight/gpio_backlight.c b/drivers/video/backlight/gpio_backlight.c
> index 01262186fa1e..70882556f047 100644
> --- a/drivers/video/backlight/gpio_backlight.c
> +++ b/drivers/video/backlight/gpio_backlight.c
> @@ -19,9 +19,7 @@
>  #include <linux/slab.h>
>  
>  struct gpio_backlight {
> -	struct device *dev;
>  	struct device *fbdev;
> -
>  	struct gpio_desc *gpiod;
>  	int def_value;
>  };
> @@ -69,8 +67,6 @@ static int gpio_backlight_probe(struct platform_device *pdev)
>  	if (gbl == NULL)
>  		return -ENOMEM;
>  
> -	gbl->dev = &pdev->dev;
> -
>  	if (pdata)
>  		gbl->fbdev = pdata->fbdev;
>  
> -- 
> 2.21.0
> 
