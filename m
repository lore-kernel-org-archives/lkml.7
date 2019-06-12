Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C492FC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 10:26:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94633207E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 10:26:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Lhh3bjCi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407305AbfFLK0W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 06:26:22 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37429 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405987AbfFLK0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 06:26:21 -0400
Received: by mail-wr1-f65.google.com with SMTP id v14so16280147wrr.4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 03:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WOZgls7V/J5HLYwy0qbOPqukCLjTUBeaw4pQKR6aMhA=;
        b=Lhh3bjCi9LPQOsYgV2u5hHUquMAX8JaWupSQ0JJTR6kRfdaSHWk58EUThXr5aoduGG
         ZaDBW5Rgxtx5MA3vhep8sB0LIJiKcNNOZvWeos4oEZNcCqrv3Dq4Jgo/l7SNmtJpqIh0
         eCN2+hUuhLKq356XSn10+47M5mvGcNQfRhYqLLd0GQ5+vy5cM3GZl8K6bFe8Zx+Mf1Op
         vb+mljL6fOKjJ7mN7cDXb9OdK3XStpJYR2ptBCaYVB5YwVwpVE915mtXtLVw6vMxWcZz
         SYHfU+fjaW2cicwf823jWJjZ0GQ2uFsjxWf0So9lW0hsRof5D2cWQXXzbfFJf0lc6Vtq
         iSrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WOZgls7V/J5HLYwy0qbOPqukCLjTUBeaw4pQKR6aMhA=;
        b=FwqlUR/cqUFB4V/+vEIVMnN8D13qFxAjrmPxm4TNz1Pr6Vh2YiubuS5xiY9VS3RFKo
         co5CXJFoqvvh8Rys0/Uq70KxLSnTVsqNFDC3IY+lDE4JSFTWXwE7dkmt1Wd0Wt2pmE22
         d+7vUu2Mp0o7BRdWKBx6ZxwmwwY281e8Om5oJ/kFVJZMST0J29HWaFwtBHHWWOhsFGIb
         ITw6biPywESmcp97zQB4oEUWV0V96BBN4Ki8MnTojFNg80NvtfckPmynBOQxltR+AmYP
         Ix1+bhvOgRF0h8W9JQqTd3V2B2iPDaJYCJW2r4j1ipkX6JJcZt7jxzsSMZNgeyWeM9Vw
         rapg==
X-Gm-Message-State: APjAAAX+fIfipW84SZPgmFl2MO43Rva9m6M7AKo1mX+4Ev6390cwAQs8
        OseQM7IM/BPsGaQbzhVEiBmwUA==
X-Google-Smtp-Source: APXvYqy2ExsmO9A/pnY9mOCCX4rJ8sv2zoGHwjcelZMJjAJyJZBRrQByS3dzi6opNGCwn+DrY/Df2A==
X-Received: by 2002:a5d:6644:: with SMTP id f4mr40097019wrw.51.1560335178466;
        Wed, 12 Jun 2019 03:26:18 -0700 (PDT)
Received: from holly.lan ([185.80.132.160])
        by smtp.gmail.com with ESMTPSA id c16sm15265578wrr.53.2019.06.12.03.26.17
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 03:26:17 -0700 (PDT)
Date:   Wed, 12 Jun 2019 11:26:15 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Shobhit Kukreti <shobhitkukreti@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] video: backlight: Replace old GPIO APIs with GPIO
 Consumer APIs for sky81542-backlight driver
Message-ID: <20190612102615.f4zbprojjxfuahqc@holly.lan>
References: <20190612043229.GA18179@t-1000>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190612043229.GA18179@t-1000>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shobhit

Thanks for the patch. Feedback below...


On Tue, Jun 11, 2019 at 09:32:32PM -0700, Shobhit Kukreti wrote:
> Port the sky81452-backlight driver to adhere to new gpio descriptor based
> APIs. Modified the file sky81452-backlight.c and sky81452-backlight.h.
> The gpio descriptor property in device tree should be "sky81452-en-gpios"

That is contradicted by the device tree bindings. The property should
remain "gpios" as it was before this conversion.


> Removed unnecessary header files "linux/gpio.h" and "linux/of_gpio.h".
> 
> Signed-off-by: Shobhit Kukreti <shobhitkukreti@gmail.com>

What level of testing have you done? Is this a fix for hardware you own
or a cleanup after searching the sources?


> ---
>  drivers/video/backlight/sky81452-backlight.c     | 24 ++++++++++++------------
>  include/linux/platform_data/sky81452-backlight.h |  4 +++-
>  2 files changed, 15 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/video/backlight/sky81452-backlight.c b/drivers/video/backlight/sky81452-backlight.c
> index d414c7a..12ef628 100644
> --- a/drivers/video/backlight/sky81452-backlight.c
> +++ b/drivers/video/backlight/sky81452-backlight.c
> @@ -19,12 +19,10 @@
>  
>  #include <linux/backlight.h>
>  #include <linux/err.h>
> -#include <linux/gpio.h>
>  #include <linux/init.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> -#include <linux/of_gpio.h>
>  #include <linux/platform_device.h>
>  #include <linux/regmap.h>
>  #include <linux/platform_data/sky81452-backlight.h>
> @@ -193,7 +191,6 @@ static struct sky81452_bl_platform_data *sky81452_bl_parse_dt(
>  	pdata->ignore_pwm = of_property_read_bool(np, "skyworks,ignore-pwm");
>  	pdata->dpwm_mode = of_property_read_bool(np, "skyworks,dpwm-mode");
>  	pdata->phase_shift = of_property_read_bool(np, "skyworks,phase-shift");
> -	pdata->gpio_enable = of_get_gpio(np, 0);
>  
>  	ret = of_property_count_u32_elems(np, "led-sources");
>  	if (ret < 0) {
> @@ -274,13 +271,17 @@ static int sky81452_bl_probe(struct platform_device *pdev)
>  		if (IS_ERR(pdata))
>  			return PTR_ERR(pdata);
>  	}
> -
> -	if (gpio_is_valid(pdata->gpio_enable)) {
> -		ret = devm_gpio_request_one(dev, pdata->gpio_enable,
> -					GPIOF_OUT_INIT_HIGH, "sky81452-en");
> -		if (ret < 0) {
> -			dev_err(dev, "failed to request GPIO. err=%d\n", ret);
> -			return ret;
> +	pdata->gpiod_enable = devm_gpiod_get(dev, "sk81452-en", GPIOD_OUT_HIGH);

As above... I think the second argument here needs to be NULL in order
to preserve the current DT bindings.


> +	if (IS_ERR(pdata->gpiod_enable)) {
> +		long ret = PTR_ERR(pdata->gpiod_enable);
> +
> +		/**

Nitpicking... but no second star here. That's a trigger symbold for
documentation processors.

> +		 * gpiod_enable is optional in device tree.
> +		 * Return error only if gpio was assigned in device tree

Also nitpicking but I had to read this a few times because
gpiod_enable is not in device tree, gpios is.

This is a common pattern so the comment can be very short. Something
like:

    This DT property is optional so no need to propagate ENOENT


> +		 */
> +		if (ret != -ENOENT) {
> +			dev_err(dev, "failed to request GPIO. err=%ld\n", ret);
> +			return PTR_ERR(pdata->gpiod_enable);
>  		}
>  	}
>  
> @@ -323,8 +324,7 @@ static int sky81452_bl_remove(struct platform_device *pdev)
>  	bd->props.brightness = 0;
>  	backlight_update_status(bd);
>  
> -	if (gpio_is_valid(pdata->gpio_enable))
> -		gpio_set_value_cansleep(pdata->gpio_enable, 0);
> +	gpiod_set_value_cansleep(pdata->gpiod_enable, 0);
>  
>  	return 0;
>  }
> diff --git a/include/linux/platform_data/sky81452-backlight.h b/include/linux/platform_data/sky81452-backlight.h
> index 1231e9b..dc4cb85 100644
> --- a/include/linux/platform_data/sky81452-backlight.h
> +++ b/include/linux/platform_data/sky81452-backlight.h
> @@ -20,6 +20,8 @@
>  #ifndef _SKY81452_BACKLIGHT_H
>  #define _SKY81452_BACKLIGHT_H
>  
> +#include <linux/gpio/consumer.h>
> +

This heaer file should be included from the C file... it is not required
to parse the header.


Daniel.


>  /**
>   * struct sky81452_platform_data
>   * @name:	backlight driver name.
> @@ -34,7 +36,7 @@
>   */
>  struct sky81452_bl_platform_data {
>  	const char *name;
> -	int gpio_enable;
> +	struct gpio_desc *gpiod_enable;
>  	unsigned int enable;
>  	bool ignore_pwm;
>  	bool dpwm_mode;
> -- 
> 2.7.4
> 
