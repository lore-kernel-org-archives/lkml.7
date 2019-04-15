Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBD9DC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B7F320848
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:45:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rNDRwrQm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728574AbfDOTp5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:45:57 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34216 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728136AbfDOTp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:45:56 -0400
Received: by mail-wm1-f68.google.com with SMTP id r186so686155wmf.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 12:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=04DWe/xZXO2vebg07NW4Uo1JSGyUisfSp7Q5P6SPexg=;
        b=rNDRwrQmkC92rnSJmJKzpbpNtW8R/JaAZyB2pBKunv3kfna/tiIj/pn5Rx6fCjgy+e
         6HrinGSTGvoQ83n+U4i7j2FpKyBEpK1UBJ3Hd8W38F00BzcM+DaARwC0hCoJ+zTngjZi
         XzUdKtiEnNEN9bqLv1hvminxtrUyl8jSw8v5g4roLmlHb1cRFvKeI0q8CuL6AqW69Sot
         +KQZKzGgN1ZlLwYwwAlAt266AUrzoAZJkCDsuV+uXRiWNt9SfGTR9FTxaEmvBSXavVyL
         bDtTC1k7LtHxI+2Jn3JULtgJ1uNDI7Htqt16Af0F+fdUQibwOeM5G57aO05giipJFEYE
         nZgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=04DWe/xZXO2vebg07NW4Uo1JSGyUisfSp7Q5P6SPexg=;
        b=Dny4yg42LWa12P1r/w0kSchU8ZiV3w5LvgWNrxjRzAgJFmU+e/LcfMqfD4YqaeO9ak
         mdAbxpiycgmLNf5ETDqGlc8SHJVQ3icUN3yVvCHq1xung3g1qXAFRqj5Z35U/3EhYIHV
         QBiYVgtN74vZl+e/ipz/qpzUo8t3PSR27ceuoAxKEnPBnWyf8Fgxtt7yutDXpbkDyrq5
         winD0kwLnN8abYyEy3IlDu9YZxeH8f1G9je2ahsL71yhpWeAj2oQHIWrGfMHXbT6FvlW
         Jr7UzhvtREOayVO3YmM+ErZ0N8cg7Pqn/XZyE1S7n+luUOpUfxK7SulrxIq2nTY2TBy+
         yFLA==
X-Gm-Message-State: APjAAAVSSoBU3351wQc47d5dSkNdg51o39yl/XK9j3QaTpO/XKvAmb/B
        Pi1JZZSGKa7h4xOB1WRnZ4WwvHiG0qpUmQ==
X-Google-Smtp-Source: APXvYqymtw2aCAQLiRM3/QUWozuPgaogqURRX36+mpXdkU8onIIhK5YgUe3uq8Yx3Qz1SmESQRk+CQ==
X-Received: by 2002:a1c:5f06:: with SMTP id t6mr24428586wmb.7.1555357554373;
        Mon, 15 Apr 2019 12:45:54 -0700 (PDT)
Received: from [192.168.1.221] ([195.245.38.118])
        by smtp.gmail.com with ESMTPSA id e7sm18281215wme.37.2019.04.15.12.45.53
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Apr 2019 12:45:53 -0700 (PDT)
Subject: Re: [PATCH 4/4] ARM: ep93xx: move private headers out of mach/*
To:     Arnd Bergmann <arnd@arndb.de>,
        Hartley Sweeten <hsweeten@visionengravers.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Lukasz Majewski <lukma@denx.de>,
        Olof Johansson <olof@lixom.net>,
        Mark Brown <broonie@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20190415192734.935387-1-arnd@arndb.de>
 <20190415193231.936070-1-arnd@arndb.de>
From:   Alexander Sverdlin <alexander.sverdlin@gmail.com>
Message-ID: <8d7c7aac-2cb8-fbff-e428-c01085ef7fbc@gmail.com>
Date:   Mon, 15 Apr 2019 21:44:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190415193231.936070-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/04/2019 21:31, Arnd Bergmann wrote:
> gpio-ep93xx.h, hardware.h, and platform.h are only used in
> arch/arm/mach-ep93xx, so we can move them one there and no
> longer expose them to device drivers.

Acked-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>

> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/mach-ep93xx/adssphere.c                      | 2 +-
>  arch/arm/mach-ep93xx/clock.c                          | 2 +-
>  arch/arm/mach-ep93xx/core.c                           | 6 +++---
>  arch/arm/mach-ep93xx/dma.c                            | 2 +-
>  arch/arm/mach-ep93xx/edb93xx.c                        | 4 ++--
>  arch/arm/mach-ep93xx/gesbc9312.c                      | 2 +-
>  arch/arm/mach-ep93xx/{include/mach => }/gpio-ep93xx.h | 0
>  arch/arm/mach-ep93xx/{include/mach => }/hardware.h    | 2 +-
>  arch/arm/mach-ep93xx/micro9.c                         | 2 +-
>  arch/arm/mach-ep93xx/{include/mach => }/platform.h    | 0
>  arch/arm/mach-ep93xx/simone.c                         | 4 ++--
>  arch/arm/mach-ep93xx/snappercl15.c                    | 4 ++--
>  arch/arm/mach-ep93xx/ts72xx.c                         | 4 ++--
>  arch/arm/mach-ep93xx/vision_ep9307.c                  | 4 ++--
>  14 files changed, 19 insertions(+), 19 deletions(-)
>  rename arch/arm/mach-ep93xx/{include/mach => }/gpio-ep93xx.h (100%)
>  rename arch/arm/mach-ep93xx/{include/mach => }/hardware.h (96%)
>  rename arch/arm/mach-ep93xx/{include/mach => }/platform.h (100%)
> 
> diff --git a/arch/arm/mach-ep93xx/adssphere.c b/arch/arm/mach-ep93xx/adssphere.c
> index bda6c3a5c923..5d3a3e302012 100644
> --- a/arch/arm/mach-ep93xx/adssphere.c
> +++ b/arch/arm/mach-ep93xx/adssphere.c
> @@ -15,7 +15,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/sizes.h>
>  
> -#include <mach/hardware.h>
> +#include "hardware.h"
>  
>  #include <asm/mach-types.h>
>  #include <asm/mach/arch.h>
> diff --git a/arch/arm/mach-ep93xx/clock.c b/arch/arm/mach-ep93xx/clock.c
> index 9f43362eb62d..b9f523d9dc8c 100644
> --- a/arch/arm/mach-ep93xx/clock.c
> +++ b/arch/arm/mach-ep93xx/clock.c
> @@ -22,7 +22,7 @@
>  #include <linux/clkdev.h>
>  #include <linux/soc/cirrus/ep93xx.h>
>  
> -#include <mach/hardware.h>
> +#include "hardware.h"
>  
>  #include <asm/div64.h>
>  
> diff --git a/arch/arm/mach-ep93xx/core.c b/arch/arm/mach-ep93xx/core.c
> index 3d245668846d..cc1382f879af 100644
> --- a/arch/arm/mach-ep93xx/core.c
> +++ b/arch/arm/mach-ep93xx/core.c
> @@ -39,13 +39,13 @@
>  #include <linux/usb/ohci_pdriver.h>
>  #include <linux/random.h>
>  
> -#include <mach/hardware.h>
> +#include "hardware.h"
>  #include <linux/platform_data/video-ep93xx.h>
>  #include <linux/platform_data/keypad-ep93xx.h>
>  #include <linux/platform_data/spi-ep93xx.h>
>  #include <linux/soc/cirrus/ep93xx.h>
>  
> -#include <mach/gpio-ep93xx.h>
> +#include "gpio-ep93xx.h"
>  
>  #include <asm/mach/arch.h>
>  #include <asm/mach/map.h>
> @@ -125,7 +125,7 @@ void ep93xx_devcfg_set_clear(unsigned int set_bits, unsigned int clear_bits)
>  /**
>   * ep93xx_chip_revision() - returns the EP93xx chip revision
>   *
> - * See <mach/platform.h> for more information.
> + * See "platform.h" for more information.
>   */
>  unsigned int ep93xx_chip_revision(void)
>  {
> diff --git a/arch/arm/mach-ep93xx/dma.c b/arch/arm/mach-ep93xx/dma.c
> index 88a4c9b089a5..821427107b11 100644
> --- a/arch/arm/mach-ep93xx/dma.c
> +++ b/arch/arm/mach-ep93xx/dma.c
> @@ -26,7 +26,7 @@
>  #include <linux/platform_device.h>
>  
>  #include <linux/platform_data/dma-ep93xx.h>
> -#include <mach/hardware.h>
> +#include "hardware.h"
>  
>  #include "soc.h"
>  
> diff --git a/arch/arm/mach-ep93xx/edb93xx.c b/arch/arm/mach-ep93xx/edb93xx.c
> index 8e89ec8b6f0f..d96dd014dd23 100644
> --- a/arch/arm/mach-ep93xx/edb93xx.c
> +++ b/arch/arm/mach-ep93xx/edb93xx.c
> @@ -32,10 +32,10 @@
>  
>  #include <sound/cs4271.h>
>  
> -#include <mach/hardware.h>
> +#include "hardware.h"
>  #include <linux/platform_data/video-ep93xx.h>
>  #include <linux/platform_data/spi-ep93xx.h>
> -#include <mach/gpio-ep93xx.h>
> +#include "gpio-ep93xx.h"
>  
>  #include <asm/mach-types.h>
>  #include <asm/mach/arch.h>
> diff --git a/arch/arm/mach-ep93xx/gesbc9312.c b/arch/arm/mach-ep93xx/gesbc9312.c
> index 0cca5b183309..ac48e3476587 100644
> --- a/arch/arm/mach-ep93xx/gesbc9312.c
> +++ b/arch/arm/mach-ep93xx/gesbc9312.c
> @@ -15,7 +15,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/sizes.h>
>  
> -#include <mach/hardware.h>
> +#include "hardware.h"
>  
>  #include <asm/mach-types.h>
>  #include <asm/mach/arch.h>
> diff --git a/arch/arm/mach-ep93xx/include/mach/gpio-ep93xx.h b/arch/arm/mach-ep93xx/gpio-ep93xx.h
> similarity index 100%
> rename from arch/arm/mach-ep93xx/include/mach/gpio-ep93xx.h
> rename to arch/arm/mach-ep93xx/gpio-ep93xx.h
> diff --git a/arch/arm/mach-ep93xx/include/mach/hardware.h b/arch/arm/mach-ep93xx/hardware.h
> similarity index 96%
> rename from arch/arm/mach-ep93xx/include/mach/hardware.h
> rename to arch/arm/mach-ep93xx/hardware.h
> index 8938906e780a..e7d850e04782 100644
> --- a/arch/arm/mach-ep93xx/include/mach/hardware.h
> +++ b/arch/arm/mach-ep93xx/hardware.h
> @@ -6,7 +6,7 @@
>  #ifndef __ASM_ARCH_HARDWARE_H
>  #define __ASM_ARCH_HARDWARE_H
>  
> -#include <mach/platform.h>
> +#include "platform.h"
>  
>  /*
>   * The EP93xx has two external crystal oscillators.  To generate the
> diff --git a/arch/arm/mach-ep93xx/micro9.c b/arch/arm/mach-ep93xx/micro9.c
> index 373583c29825..c7f64e4ff6c7 100644
> --- a/arch/arm/mach-ep93xx/micro9.c
> +++ b/arch/arm/mach-ep93xx/micro9.c
> @@ -16,7 +16,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/io.h>
>  
> -#include <mach/hardware.h>
> +#include "hardware.h"
>  
>  #include <asm/mach-types.h>
>  #include <asm/mach/arch.h>
> diff --git a/arch/arm/mach-ep93xx/include/mach/platform.h b/arch/arm/mach-ep93xx/platform.h
> similarity index 100%
> rename from arch/arm/mach-ep93xx/include/mach/platform.h
> rename to arch/arm/mach-ep93xx/platform.h
> diff --git a/arch/arm/mach-ep93xx/simone.c b/arch/arm/mach-ep93xx/simone.c
> index 80ccb984d521..adc17289cc23 100644
> --- a/arch/arm/mach-ep93xx/simone.c
> +++ b/arch/arm/mach-ep93xx/simone.c
> @@ -27,8 +27,8 @@
>  #include <linux/gpio.h>
>  #include <linux/gpio/machine.h>
>  
> -#include <mach/hardware.h>
> -#include <mach/gpio-ep93xx.h>
> +#include "hardware.h"
> +#include "gpio-ep93xx.h"
>  
>  #include <asm/mach-types.h>
>  #include <asm/mach/arch.h>
> diff --git a/arch/arm/mach-ep93xx/snappercl15.c b/arch/arm/mach-ep93xx/snappercl15.c
> index cf0cb58b3454..f8f89551dbed 100644
> --- a/arch/arm/mach-ep93xx/snappercl15.c
> +++ b/arch/arm/mach-ep93xx/snappercl15.c
> @@ -25,9 +25,9 @@
>  
>  #include <linux/mtd/platnand.h>
>  
> -#include <mach/hardware.h>
> +#include "hardware.h"
>  #include <linux/platform_data/video-ep93xx.h>
> -#include <mach/gpio-ep93xx.h>
> +#include "gpio-ep93xx.h"
>  
>  #include <asm/mach-types.h>
>  #include <asm/mach/arch.h>
> diff --git a/arch/arm/mach-ep93xx/ts72xx.c b/arch/arm/mach-ep93xx/ts72xx.c
> index 85b74ac943f0..bba6aa5d7106 100644
> --- a/arch/arm/mach-ep93xx/ts72xx.c
> +++ b/arch/arm/mach-ep93xx/ts72xx.c
> @@ -23,8 +23,8 @@
>  #include <linux/mmc/host.h>
>  #include <linux/platform_data/spi-ep93xx.h>
>  
> -#include <mach/gpio-ep93xx.h>
> -#include <mach/hardware.h>
> +#include "gpio-ep93xx.h"
> +#include "hardware.h"
>  #include <mach/irqs.h>
>  
>  #include <asm/mach-types.h>
> diff --git a/arch/arm/mach-ep93xx/vision_ep9307.c b/arch/arm/mach-ep93xx/vision_ep9307.c
> index 767ee64628dc..66e2b34aa779 100644
> --- a/arch/arm/mach-ep93xx/vision_ep9307.c
> +++ b/arch/arm/mach-ep93xx/vision_ep9307.c
> @@ -31,10 +31,10 @@
>  
>  #include <sound/cs4271.h>
>  
> -#include <mach/hardware.h>
> +#include "hardware.h"
>  #include <linux/platform_data/video-ep93xx.h>
>  #include <linux/platform_data/spi-ep93xx.h>
> -#include <mach/gpio-ep93xx.h>
> +#include "gpio-ep93xx.h"
>  
>  #include <asm/mach-types.h>
>  #include <asm/mach/map.h>
> 
