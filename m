Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9684CC76190
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 15:18:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FD86204FD
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 15:18:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R8xbBrGP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728481AbfGVPSd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 11:18:33 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37404 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727356AbfGVPSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 11:18:32 -0400
Received: by mail-wr1-f67.google.com with SMTP id n9so14775691wrr.4
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 08:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kJIZoXmnEJk2nuaDS1euaSfVjq7bZa7xFpx8vg18ues=;
        b=R8xbBrGPGLYEg+fbDVZlVqU0/MX8qvpSvYM5BRrRcMJmaQWlDvQBjOsDvzqzGXi2yL
         +F3P+mSXQKXvOQoHCKXasn3T1fKDwZI/8NRNHQH99OC/bjHPY5Brw9h3HzyBUF5fANth
         vzD6QvRsuvJayURHV5qrDxjdcVlQ4/klfZPoQrFYz1iOQnEp83H/9Gw+MJKr02S9/HzB
         OgkAX5D8NuBKqrR0L4PUno1eo72I0a9hBErXyVDYlP6Xbym+ED8A825MqdjJS7SglUvb
         bJiD5TdhG7qS+kInVSG4SBIJ4CShOp0/+WlLnNtiskli0KzGOT5v3fVRkSJV1LQHqL3d
         Xcng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kJIZoXmnEJk2nuaDS1euaSfVjq7bZa7xFpx8vg18ues=;
        b=QBkBjXPgaR4gg/eY4CMniHrdc7r9OidWEKr/L8Vn3N7uiUVupuF4wg+ZoOjWRYFGoD
         qb8XvAvnD9YlIu9Fn0K7ENEUlNly8IKRVvXx364nP+DoaCNu4bELdnhwP2GvgiUun1Yt
         ljR9Fk1KWH3O9Z8nsZ1jN6b7Ri5HkCjYeRcLuff2KjjBtt3r4HcDoE9aR7aCoukgHl8V
         Lqsx/RouRFBJMqICXQD2yV1VIDgMT/RA0bFjynFZbOgPwm/KhknZqGNZ1mIsBC+l45qz
         TQLjVO2+KxwGPxnWgrF1ky7qbq4Xb/O8LcdckIjuv9f9F4m2jIMSDF3eevbjh/jaY+lY
         wMBQ==
X-Gm-Message-State: APjAAAWRx2V3qXXI0Yo3Oaz24a5LdvAci0ayKb5+E1K33QMYQbQmQmke
        T0xpvgcPgRIFtOQ+sKFtrWNc1Q==
X-Google-Smtp-Source: APXvYqwzssx9bi+kpuqmBQK4Q0zcUFYDYs9ctyDAvKFt8l2MfJ1utjL2AT+NQh6yZBGaAgBoipYLhA==
X-Received: by 2002:adf:f8cf:: with SMTP id f15mr73952371wrq.333.1563808711047;
        Mon, 22 Jul 2019 08:18:31 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id b5sm33232438wru.69.2019.07.22.08.18.30
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Jul 2019 08:18:30 -0700 (PDT)
Date:   Mon, 22 Jul 2019 16:18:28 +0100
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
Subject: Re: [PATCH v2 4/7] backlight: gpio: remove unused fields from
 platform data
Message-ID: <20190722151828.sefbqj5vf5vtrik3@holly.lan>
References: <20190722150302.29526-1-brgl@bgdev.pl>
 <20190722150302.29526-5-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190722150302.29526-5-brgl@bgdev.pl>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 05:02:59PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Remove the platform data fields that nobody uses.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>

> ---
>  include/linux/platform_data/gpio_backlight.h | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/include/linux/platform_data/gpio_backlight.h b/include/linux/platform_data/gpio_backlight.h
> index 34179d600360..1a8b5b1946fe 100644
> --- a/include/linux/platform_data/gpio_backlight.h
> +++ b/include/linux/platform_data/gpio_backlight.h
> @@ -9,9 +9,6 @@ struct device;
>  
>  struct gpio_backlight_platform_data {
>  	struct device *fbdev;
> -	int gpio;
> -	int def_value;
> -	const char *name;
>  };
>  
>  #endif
> -- 
> 2.21.0
> 
