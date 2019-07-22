Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AAB4C76188
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 15:17:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19548204FD
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 15:17:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MgpdRRFk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728292AbfGVPR2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 11:17:28 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39504 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726759AbfGVPR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 11:17:28 -0400
Received: by mail-wm1-f67.google.com with SMTP id u25so25367806wmc.4
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 08:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GbAfGOTx5uPd3P7pdI3V2Y+OXjJAt27xs5pTCM/ndWc=;
        b=MgpdRRFk8scefg+/0pPZIHcbPXO1LH97uDm4TTqToX4GmOnbDelZiPNUu7+lBa/Cr4
         t8OrNQ97pctTIdzl1RUUUAJbFrqgF0YDr0MYUdgKUYsMvfhCJkRbjPEVvPstNRhwkjDU
         zhglpgLVpQwMtSTwF3OO8YUfbQwIhDZJCxw7ldDzAGxolEKzTZ19xSBuSeVjOg6XA3b1
         oUx7eCEKAH8x8NNKJUJlb5wg6RWueukCXwkiyDMzLXnCaGRcgT4D0Rg/SSD0lT7ZEB4z
         oXgavso/ntpSoOkFf8uS0F1sXIjOMi/wQU19YhLmp/V24kAwtW3QsKEzy3DhcdpopgjP
         xRcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GbAfGOTx5uPd3P7pdI3V2Y+OXjJAt27xs5pTCM/ndWc=;
        b=NbSLzconyCasOlP+tF520s+ymSxzdu/AA8gMfIPqUtewaMo+O/i8TcTQ4A61pRMX01
         xjp5GI/vEqcjv16HTrp2X5i4QuSwVTCzc4CcazfWU0eOWt7V5KgZQ+todpb4ubYOtLE1
         uiUhWMBZyf51ckQRB+jspQhal5gleyQIVLcnrQsvCJ0qEtN/IoW1aKdPpzJx4Ot3KZeI
         UjSHk4ZTbR8Q53fQDVGQK+CpWXLAKnzqF3Tpi8aVyHzf7+9gSKrJTkL2nU3ucUHqhTUg
         TNV3VkDdwBj8LwXImX2r8I7nFV0WoX4BFZ5dXhtUq4zCwKlr68L4+hieQqTcu7zX50xj
         4cuA==
X-Gm-Message-State: APjAAAXFVvVVCYStzAfnFRJDYkYlbq6+KHittkybLi6V8NlW/8g8wo4z
        bMtgAKwumsyujPjyoi+FqnSQogLTN6hMSQ==
X-Google-Smtp-Source: APXvYqy42hWTID0bFA3QzP8fzY5mWnSbZYD2/zRcCvPejKXa4LoD8z4hz4WNCVE/zW2BaDMan2yWng==
X-Received: by 2002:a1c:f409:: with SMTP id z9mr57053507wma.176.1563808645564;
        Mon, 22 Jul 2019 08:17:25 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id z19sm28648885wmi.7.2019.07.22.08.17.24
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Jul 2019 08:17:24 -0700 (PDT)
Date:   Mon, 22 Jul 2019 16:17:23 +0100
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
Subject: Re: [PATCH v2 2/7] backlight: gpio: simplify the platform data
 handling
Message-ID: <20190722151723.cfvlphcw2dtwsa7z@holly.lan>
References: <20190722150302.29526-1-brgl@bgdev.pl>
 <20190722150302.29526-3-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190722150302.29526-3-brgl@bgdev.pl>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 05:02:57PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Now that the last user of platform data (sh ecovec24) defines a proper
> GPIO lookup and sets the 'default-on' device property, we can drop the
> platform_data-specific GPIO handling and unify a big chunk of code.
> 
> The only field used from the platform data is now the fbdev pointer.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


> ---
>  drivers/video/backlight/gpio_backlight.c | 64 +++++-------------------
>  1 file changed, 13 insertions(+), 51 deletions(-)
> 
> diff --git a/drivers/video/backlight/gpio_backlight.c b/drivers/video/backlight/gpio_backlight.c
> index e84f3087e29f..01262186fa1e 100644
> --- a/drivers/video/backlight/gpio_backlight.c
> +++ b/drivers/video/backlight/gpio_backlight.c
> @@ -55,30 +55,6 @@ static const struct backlight_ops gpio_backlight_ops = {
>  	.check_fb	= gpio_backlight_check_fb,
>  };
>  
> -static int gpio_backlight_probe_dt(struct platform_device *pdev,
> -				   struct gpio_backlight *gbl)
> -{
> -	struct device *dev = &pdev->dev;
> -	enum gpiod_flags flags;
> -	int ret;
> -
> -	gbl->def_value = device_property_read_bool(dev, "default-on");
> -	flags = gbl->def_value ? GPIOD_OUT_HIGH : GPIOD_OUT_LOW;
> -
> -	gbl->gpiod = devm_gpiod_get(dev, NULL, flags);
> -	if (IS_ERR(gbl->gpiod)) {
> -		ret = PTR_ERR(gbl->gpiod);
> -
> -		if (ret != -EPROBE_DEFER) {
> -			dev_err(dev,
> -				"Error: The gpios parameter is missing or invalid.\n");
> -		}
> -		return ret;
> -	}
> -
> -	return 0;
> -}
> -
>  static int gpio_backlight_probe(struct platform_device *pdev)
>  {
>  	struct gpio_backlight_platform_data *pdata =
> @@ -86,6 +62,7 @@ static int gpio_backlight_probe(struct platform_device *pdev)
>  	struct backlight_properties props;
>  	struct backlight_device *bl;
>  	struct gpio_backlight *gbl;
> +	enum gpiod_flags flags;
>  	int ret;
>  
>  	gbl = devm_kzalloc(&pdev->dev, sizeof(*gbl), GFP_KERNEL);
> @@ -94,35 +71,20 @@ static int gpio_backlight_probe(struct platform_device *pdev)
>  
>  	gbl->dev = &pdev->dev;
>  
> -	if (pdev->dev.fwnode) {
> -		ret = gpio_backlight_probe_dt(pdev, gbl);
> -		if (ret)
> -			return ret;
> -	} else if (pdata) {
> -		/*
> -		 * Legacy platform data GPIO retrieveal. Do not expand
> -		 * the use of this code path, currently only used by one
> -		 * SH board.
> -		 */
> -		unsigned long flags = GPIOF_DIR_OUT;
> -
> +	if (pdata)
>  		gbl->fbdev = pdata->fbdev;
> -		gbl->def_value = pdata->def_value;
> -		flags |= gbl->def_value ? GPIOF_INIT_HIGH : GPIOF_INIT_LOW;
> -
> -		ret = devm_gpio_request_one(gbl->dev, pdata->gpio, flags,
> -					    pdata ? pdata->name : "backlight");
> -		if (ret < 0) {
> -			dev_err(&pdev->dev, "unable to request GPIO\n");
> -			return ret;
> +
> +	gbl->def_value = device_property_read_bool(&pdev->dev, "default-on");
> +	flags = gbl->def_value ? GPIOD_OUT_HIGH : GPIOD_OUT_LOW;
> +
> +	gbl->gpiod = devm_gpiod_get(&pdev->dev, NULL, flags);
> +	if (IS_ERR(gbl->gpiod)) {
> +		ret = PTR_ERR(gbl->gpiod);
> +		if (ret != -EPROBE_DEFER) {
> +			dev_err(&pdev->dev,
> +				"Error: The gpios parameter is missing or invalid.\n");
>  		}
> -		gbl->gpiod = gpio_to_desc(pdata->gpio);
> -		if (!gbl->gpiod)
> -			return -EINVAL;
> -	} else {
> -		dev_err(&pdev->dev,
> -			"failed to find platform data or device tree node.\n");
> -		return -ENODEV;
> +		return ret;
>  	}
>  
>  	memset(&props, 0, sizeof(props));
> -- 
> 2.21.0
> 
