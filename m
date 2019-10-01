Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC3ABECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 14:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9515D2086A
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 14:29:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ab78udnP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388917AbfJAO3Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 10:29:24 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36983 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727018AbfJAO3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 10:29:24 -0400
Received: by mail-wm1-f67.google.com with SMTP id f22so3509359wmc.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 07:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Zbs/Q3MsdenwE0g7FlmKiMlk/SOvniNFvpDInB7/8lg=;
        b=Ab78udnPe3CRWuo1p82gth5GZPwVCa619kuHOdLyJPwlTZWd8o67QnPGzfD0g5txa/
         Hgmc/jnJuqVkWi7VwGXZ8lnqFcojAh6LTJrrJsydA11V+jKR6g2nJ0wuW/S4lTboC/SW
         bKo1z1nPOemI8ZG34YVv5PlBByBjHVtciX91NVR8dL7DIiy+x5UgDPi2wQ1vDO2VxRbo
         /LSQmlDGgjSUsQ9KL2o+b0G21XyHl0ICmPWF5a+VKrekFyLvwoa18e0ac+vetvM4EHav
         V6wM6F4HzCA1IGEfa0dNVeVcb5gPTSNz9p4iL163mCfdf3Xyy3seTMimN6B43VNWdJQD
         8H5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Zbs/Q3MsdenwE0g7FlmKiMlk/SOvniNFvpDInB7/8lg=;
        b=DfEMSIhLSLVrLdo45sjizRZBSXywdTY9uToOpJHlt8WseMyUwkZF5nTwJJafl2yhOz
         mE0H6ftuOU+qC3L9o9nOrR1GmTf7LqxJDw+pWOkstrh3ssdT7e33q+TU7+ZiQLhcUDvo
         MCsiDAgXVtNqnkcxaxZNJTk7IsmHm5iTgtK1ryR3G0+4mNhcDynTOfTxv5nuQqsun//n
         hMFyLhHYDc18zrrcn28QnKAsl8QJ16laqEHSqz9YKEtOEhB7TVuj5achQ6jusDmZSLGT
         xYjw9m/0dqxMLrS5LBQnbo1Rq4POX5wMNu91TRU8ui0Jv/7oFt/DDlD49SSzqJTCrqXs
         uC3A==
X-Gm-Message-State: APjAAAV9G960v/Zje+ZmMRQ+IW6NiO21THNwvvfVCm7SoYGs6GpiDQAs
        B3EegFmJCfjyWRfxKBG8m90koA==
X-Google-Smtp-Source: APXvYqxXALWaJtwvVfsLlZFYYua2CQBoHGuUym/bKHxQZ190WXx8BwxxVFOpKgosan9NU4AewmAYlQ==
X-Received: by 2002:a05:600c:2290:: with SMTP id 16mr805781wmf.161.1569940160774;
        Tue, 01 Oct 2019 07:29:20 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id l18sm15404308wrc.18.2019.10.01.07.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 07:29:20 -0700 (PDT)
Date:   Tue, 1 Oct 2019 15:29:18 +0100
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
Subject: Re: [PATCH v4 1/7] backlight: gpio: remove unneeded include
Message-ID: <20191001142918.gjifvlkz574dbihr@holly.lan>
References: <20191001125837.4472-1-brgl@bgdev.pl>
 <20191001125837.4472-2-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191001125837.4472-2-brgl@bgdev.pl>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2019 at 02:58:31PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> We no longer use any symbols from of_gpio.h. Remove this include.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>

> ---
>  drivers/video/backlight/gpio_backlight.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/video/backlight/gpio_backlight.c b/drivers/video/backlight/gpio_backlight.c
> index 18e053e4716c..7e1990199fae 100644
> --- a/drivers/video/backlight/gpio_backlight.c
> +++ b/drivers/video/backlight/gpio_backlight.c
> @@ -12,7 +12,6 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> -#include <linux/of_gpio.h>
>  #include <linux/platform_data/gpio_backlight.h>
>  #include <linux/platform_device.h>
>  #include <linux/property.h>
> -- 
> 2.23.0
> 
