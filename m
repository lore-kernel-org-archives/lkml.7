Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEEBEC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 03:34:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 776CA20B1F
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 03:34:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="idEkbiUL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729702AbfDWDeh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 23:34:37 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41325 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729097AbfDWDeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 23:34:37 -0400
Received: by mail-pl1-f194.google.com with SMTP id d9so846797pls.8;
        Mon, 22 Apr 2019 20:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ui4DTlvvsTyvZplA6sq6N91nIHR2APQX8fBAVRQsWC4=;
        b=idEkbiULEDagNGekBxqTWtLZA6xkWXzX0Gj2qmRr7+ZPCQHXyZUMSU98AanknUBBUE
         6effExBlQerih+Vh2K5x+r8rG1MQrxfZNP0c8hakLPYvGezE5r20OU4mJF2BJ8QrBQKh
         S1hmM+B1PCzI8E5dqcugfdno20mt4ZVF80JYFNzPFf1lIQ5D0catBIShLTBpHJpFZQ1g
         g1TTJepd+YYm7zPrkdZxm0IqbVhVIKwEbr/d0E9FwcuRNwBG2WmOtnQshXSnwGrbVB5g
         fso8tV71WULITxamc7Gx0zWHq8WS5uXqvH6Vc5Zs9ITVTU/C/YbYxxr5dHEf9j/7Gysw
         IZZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ui4DTlvvsTyvZplA6sq6N91nIHR2APQX8fBAVRQsWC4=;
        b=MD8IkiM3Mh3YgiMLxC10JBsNEJlv04IiGLq7t2AiokBiB9UZZrCicPqqiWcsqajUWc
         Mz0JN9uTo2Mk939Qa02AJzOIvJOt8WSGVOeH+w4bbJsqNLS45Z+6vJBdWoVQOl61f9a6
         hcZeg1UKbMAIlFHhcaWWBpjRFTEU6aKZ1+9xywe0ZxrrCHeoduY7hVrB9paYdrrF/m3r
         2+1aOdnTT8exJ0aMBZ23wIj/0iGGV6MGOv2rVt52rcQI/CtfNTan+Cb9fSdjqgnSOr0I
         70DBdvtBNGEg1kRvA0SnJCqbM+ISMWL5WiN1KAVkduxFNgkO08gEtsG6IE72FMGbGkqn
         6Qrw==
X-Gm-Message-State: APjAAAXEWNJnXB0UxNmpDHs417/vpC5TCe2c6qDTKePoqrdqfMcY4cAY
        vuTL5jDDj6607NPvwaAnXhc=
X-Google-Smtp-Source: APXvYqxhFR6CzsDFxnwMI66hi5/JgBUuz8KqcHBfbcznBbecdYLFC9tYRcQOPR+MmF/YAVv+nAlatw==
X-Received: by 2002:a17:902:e393:: with SMTP id ch19mr23903010plb.117.1555990476586;
        Mon, 22 Apr 2019 20:34:36 -0700 (PDT)
Received: from localhost ([172.56.31.226])
        by smtp.gmail.com with ESMTPSA id d20sm18826127pfo.77.2019.04.22.20.34.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Apr 2019 20:34:35 -0700 (PDT)
Date:   Tue, 23 Apr 2019 03:22:26 +0000
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Hartley Sweeten <hsweeten@visionengravers.com>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Stefan Agner <stefan@agner.ch>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] ARM: ep93xx: keypad: stop using mach/platform.h
Message-ID: <20190423032226.cqbik3hicjomgzqs@penguin>
References: <20190415192734.935387-1-arnd@arndb.de>
 <20190415192734.935387-2-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190415192734.935387-2-arnd@arndb.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2019 at 09:25:24PM +0200, Arnd Bergmann wrote:
> We can communicate the clock rate using platform data rather than setting
> a flag to use a particular value in the driver, which is cleaner and
> avoids the dependency.
> 
> No platform in the kernel currently defines the ep93xx keypad device
> structure, so this is a rather pointless excercise.  Any out of tree
> users are probably dead now, but if not, they have to change their
> platform code to match the new platform_data structure.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Please feel free to merge with the rest of the patches.

> ---
>  drivers/input/keyboard/Kconfig              | 2 +-
>  drivers/input/keyboard/ep93xx_keypad.c      | 5 +----
>  include/linux/platform_data/keypad-ep93xx.h | 4 ++--
>  3 files changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
> index a878351f1643..b373f3274542 100644
> --- a/drivers/input/keyboard/Kconfig
> +++ b/drivers/input/keyboard/Kconfig
> @@ -194,7 +194,7 @@ config KEYBOARD_LKKBD
>  
>  config KEYBOARD_EP93XX
>  	tristate "EP93xx Matrix Keypad support"
> -	depends on ARCH_EP93XX
> +	depends on ARCH_EP93XX || COMPILE_TEST
>  	select INPUT_MATRIXKMAP
>  	help
>  	  Say Y here to enable the matrix keypad on the Cirrus EP93XX.
> diff --git a/drivers/input/keyboard/ep93xx_keypad.c b/drivers/input/keyboard/ep93xx_keypad.c
> index f77b295e0123..71472f6257c0 100644
> --- a/drivers/input/keyboard/ep93xx_keypad.c
> +++ b/drivers/input/keyboard/ep93xx_keypad.c
> @@ -137,10 +137,7 @@ static void ep93xx_keypad_config(struct ep93xx_keypad *keypad)
>  	struct ep93xx_keypad_platform_data *pdata = keypad->pdata;
>  	unsigned int val = 0;
>  
> -	if (pdata->flags & EP93XX_KEYPAD_KDIV)
> -		clk_set_rate(keypad->clk, EP93XX_KEYTCHCLK_DIV4);
> -	else
> -		clk_set_rate(keypad->clk, EP93XX_KEYTCHCLK_DIV16);
> +	clk_set_rate(keypad->clk, pdata->clk_rate);
>  
>  	if (pdata->flags & EP93XX_KEYPAD_DISABLE_3_KEY)
>  		val |= KEY_INIT_DIS3KY;
> diff --git a/include/linux/platform_data/keypad-ep93xx.h b/include/linux/platform_data/keypad-ep93xx.h
> index 0e36818e3680..3054fced8509 100644
> --- a/include/linux/platform_data/keypad-ep93xx.h
> +++ b/include/linux/platform_data/keypad-ep93xx.h
> @@ -9,8 +9,7 @@ struct matrix_keymap_data;
>  #define EP93XX_KEYPAD_DIAG_MODE		(1<<1)	/* diagnostic mode */
>  #define EP93XX_KEYPAD_BACK_DRIVE	(1<<2)	/* back driving mode */
>  #define EP93XX_KEYPAD_TEST_MODE		(1<<3)	/* scan only column 0 */
> -#define EP93XX_KEYPAD_KDIV		(1<<4)	/* 1/4 clock or 1/16 clock */
> -#define EP93XX_KEYPAD_AUTOREPEAT	(1<<5)	/* enable key autorepeat */
> +#define EP93XX_KEYPAD_AUTOREPEAT	(1<<4)	/* enable key autorepeat */
>  
>  /**
>   * struct ep93xx_keypad_platform_data - platform specific device structure
> @@ -24,6 +23,7 @@ struct ep93xx_keypad_platform_data {
>  	unsigned int	debounce;
>  	unsigned int	prescale;
>  	unsigned int	flags;
> +	unsigned int	clk_rate;
>  };
>  
>  #define EP93XX_MATRIX_ROWS		(8)
> -- 
> 2.20.0
> 

-- 
Dmitry
