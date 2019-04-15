Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1739C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:42:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 515EB20675
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:42:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hFENGm2W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728455AbfDOTmg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:42:36 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39343 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728251AbfDOTmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:42:35 -0400
Received: by mail-wm1-f65.google.com with SMTP id n25so21950161wmk.4;
        Mon, 15 Apr 2019 12:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VRxhfJBnMDDd1DJCvvW3loKAywUsqxyCFaAOHyOtjBc=;
        b=hFENGm2W4WFmK9c3AxDKZ+xJU+sQeCKq7i5kwynEFC+8DgNOW7YGbDOopbBPv3SzyV
         VF61MKmRu2anFmEew10kzaUOiH/3gVNGWFXT1/GJbOyiYTMN6lS0S/gcxxG3ZpXYo0WM
         bgi0/v5kTOkcT3aZQSUhc0uDKF2eDF3JGV0+k4huQ3KPOSCLp3faSrInVC1z9sjMmxb3
         YnusYzX3f4s3SBkjFnZJ9T85ztVrfYXzGUgdjR36LB4ZB+jJH/jvptJFtBwvA4Mfzqw6
         96LvY+hu9SxHNgFhlbN3/U/RMKphy4eItJAYPFUHC6wgHIvj9h61nbOaENE9dd0zfhHY
         Tddw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VRxhfJBnMDDd1DJCvvW3loKAywUsqxyCFaAOHyOtjBc=;
        b=abme8ZEcFOPcELjQWrzgXHuA/ctRe+lqrXb1W/NisiPQ1q16CfCxsJBQG//q3prYjg
         LjyoDXq39CdZ5nQPlHTy7i8DMDripPQYthngiLUVVAA/l0b1Ri2dhBC8nujbf4MPC6oA
         9pbeiuX6efub83GpQg7Yggko7DXzxMZ0CEAyX+jK9XOCb3ExNZXI37edg/wy8oPCXq3W
         NtGkZIivbx9uWqrRC2tKCy8jcJ0/woNo30Wp47sKQsj/LoVqSUM3k3ejrrVhSrcZApCG
         obtKnv3BWBOKoFnRzgkW0DGFIE5h3q6XqEwaVVq+vKz56xuXR9SD+rAVA3w1MYz6DfmC
         M2UA==
X-Gm-Message-State: APjAAAUUcVWLH84xUBU6HGQ5hUGZwJ2GtK6S8P8GINvVEA12ktuZg8OJ
        WyxwZkGuc6V3ZhEGp8jAQ7M=
X-Google-Smtp-Source: APXvYqyOQfUaKzftVc0KY4jFZyUXIF0o1bg1nyDdiBwyqtIiKd/aFHa8Qdx9agT5G6nzlPFg5b32Hg==
X-Received: by 2002:a7b:c4d5:: with SMTP id g21mr22753891wmk.133.1555357352176;
        Mon, 15 Apr 2019 12:42:32 -0700 (PDT)
Received: from [192.168.1.221] ([195.245.38.118])
        by smtp.gmail.com with ESMTPSA id z140sm45680232wmc.27.2019.04.15.12.42.30
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Apr 2019 12:42:31 -0700 (PDT)
Subject: Re: [PATCH 3/4] ARM: ep93xx: move pinctrl interfaces into
 include/linux/soc
To:     Arnd Bergmann <arnd@arndb.de>,
        Hartley Sweeten <hsweeten@visionengravers.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jens Axboe <axboe@kernel.dk>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-input@vger.kernel.org,
        linux-pwm@vger.kernel.org, alsa-devel@alsa-project.org
References: <20190415192734.935387-1-arnd@arndb.de>
 <20190415192734.935387-3-arnd@arndb.de>
From:   Alexander Sverdlin <alexander.sverdlin@gmail.com>
Message-ID: <1710526a-b988-24b3-307d-bd9d6e3f1769@gmail.com>
Date:   Mon, 15 Apr 2019 21:41:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190415192734.935387-3-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/04/2019 21:25, Arnd Bergmann wrote:
> ep93xx does not have a proper pinctrl driver, but does things
> ad-hoc through mach/platform.h, which is also used for setting
> up the boards.
> 
> To avoid using mach/*.h headers completely, let's move the interfaces
> into include/linux/soc/. This is far from great, but gets the job
> done here, without the need for a proper pinctrl driver.

Acked-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>

> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/mach-ep93xx/clock.c                 |  1 +
>  arch/arm/mach-ep93xx/core.c                  |  2 ++
>  arch/arm/mach-ep93xx/include/mach/platform.h | 16 ---------
>  drivers/ata/pata_ep93xx.c                    |  2 +-
>  drivers/input/keyboard/ep93xx_keypad.c       |  3 +-
>  drivers/pwm/pwm-ep93xx.c                     |  2 +-
>  include/linux/soc/cirrus/ep93xx.h            | 37 ++++++++++++++++++++
>  sound/soc/cirrus/edb93xx.c                   |  2 +-
>  sound/soc/cirrus/ep93xx-ac97.c               |  1 +
>  sound/soc/cirrus/ep93xx-i2s.c                |  3 +-
>  sound/soc/cirrus/simone.c                    |  2 +-
>  sound/soc/cirrus/snappercl15.c               |  2 +-
>  12 files changed, 48 insertions(+), 25 deletions(-)
>  create mode 100644 include/linux/soc/cirrus/ep93xx.h
> 
> diff --git a/arch/arm/mach-ep93xx/clock.c b/arch/arm/mach-ep93xx/clock.c
> index d2eee707d27f..9f43362eb62d 100644
> --- a/arch/arm/mach-ep93xx/clock.c
> +++ b/arch/arm/mach-ep93xx/clock.c
> @@ -20,6 +20,7 @@
>  #include <linux/io.h>
>  #include <linux/spinlock.h>
>  #include <linux/clkdev.h>
> +#include <linux/soc/cirrus/ep93xx.h>
>  
>  #include <mach/hardware.h>
>  
> diff --git a/arch/arm/mach-ep93xx/core.c b/arch/arm/mach-ep93xx/core.c
> index 706515faee06..3d245668846d 100644
> --- a/arch/arm/mach-ep93xx/core.c
> +++ b/arch/arm/mach-ep93xx/core.c
> @@ -43,6 +43,8 @@
>  #include <linux/platform_data/video-ep93xx.h>
>  #include <linux/platform_data/keypad-ep93xx.h>
>  #include <linux/platform_data/spi-ep93xx.h>
> +#include <linux/soc/cirrus/ep93xx.h>
> +
>  #include <mach/gpio-ep93xx.h>
>  
>  #include <asm/mach/arch.h>
> diff --git a/arch/arm/mach-ep93xx/include/mach/platform.h b/arch/arm/mach-ep93xx/include/mach/platform.h
> index 43446f33c2be..b4045a186239 100644
> --- a/arch/arm/mach-ep93xx/include/mach/platform.h
> +++ b/arch/arm/mach-ep93xx/include/mach/platform.h
> @@ -19,14 +19,6 @@ struct ep93xx_spi_info;
>  void ep93xx_map_io(void);
>  void ep93xx_init_irq(void);
>  
> -#define EP93XX_CHIP_REV_D0	3
> -#define EP93XX_CHIP_REV_D1	4
> -#define EP93XX_CHIP_REV_E0	5
> -#define EP93XX_CHIP_REV_E1	6
> -#define EP93XX_CHIP_REV_E2	7
> -
> -unsigned int ep93xx_chip_revision(void);
> -
>  void ep93xx_register_flash(unsigned int width,
>  			   resource_size_t start, resource_size_t size);
>  
> @@ -36,19 +28,11 @@ void ep93xx_register_spi(struct ep93xx_spi_info *info,
>  			 struct spi_board_info *devices, int num);
>  void ep93xx_register_fb(struct ep93xxfb_mach_info *data);
>  void ep93xx_register_pwm(int pwm0, int pwm1);
> -int ep93xx_pwm_acquire_gpio(struct platform_device *pdev);
> -void ep93xx_pwm_release_gpio(struct platform_device *pdev);
>  void ep93xx_register_keypad(struct ep93xx_keypad_platform_data *data);
> -int ep93xx_keypad_acquire_gpio(struct platform_device *pdev);
> -void ep93xx_keypad_release_gpio(struct platform_device *pdev);
>  void ep93xx_register_i2s(void);
> -int ep93xx_i2s_acquire(void);
> -void ep93xx_i2s_release(void);
>  void ep93xx_register_ac97(void);
>  void ep93xx_register_ide(void);
>  void ep93xx_register_adc(void);
> -int ep93xx_ide_acquire_gpio(struct platform_device *pdev);
> -void ep93xx_ide_release_gpio(struct platform_device *pdev);
>  
>  struct device *ep93xx_init_devices(void);
>  extern void ep93xx_timer_init(void);
> diff --git a/drivers/ata/pata_ep93xx.c b/drivers/ata/pata_ep93xx.c
> index cc6d06c1b2c7..db271b705529 100644
> --- a/drivers/ata/pata_ep93xx.c
> +++ b/drivers/ata/pata_ep93xx.c
> @@ -44,7 +44,7 @@
>  #include <linux/ktime.h>
>  
>  #include <linux/platform_data/dma-ep93xx.h>
> -#include <mach/platform.h>
> +#include <linux/soc/cirrus/ep93xx.h>
>  
>  #define DRV_NAME	"ep93xx-ide"
>  #define DRV_VERSION	"1.0"
> diff --git a/drivers/input/keyboard/ep93xx_keypad.c b/drivers/input/keyboard/ep93xx_keypad.c
> index 71472f6257c0..575dac52f7b4 100644
> --- a/drivers/input/keyboard/ep93xx_keypad.c
> +++ b/drivers/input/keyboard/ep93xx_keypad.c
> @@ -27,8 +27,7 @@
>  #include <linux/io.h>
>  #include <linux/input/matrix_keypad.h>
>  #include <linux/slab.h>
> -
> -#include <mach/hardware.h>
> +#include <linux/soc/cirrus/ep93xx.h>
>  #include <linux/platform_data/keypad-ep93xx.h>
>  
>  /*
> diff --git a/drivers/pwm/pwm-ep93xx.c b/drivers/pwm/pwm-ep93xx.c
> index bbf10ae02f0e..fa168581e6b8 100644
> --- a/drivers/pwm/pwm-ep93xx.c
> +++ b/drivers/pwm/pwm-ep93xx.c
> @@ -35,7 +35,7 @@
>  
>  #include <asm/div64.h>
>  
> -#include <mach/platform.h>	/* for ep93xx_pwm_{acquire,release}_gpio() */
> +#include <linux/soc/cirrus/ep93xx.h>	/* for ep93xx_pwm_{acquire,release}_gpio() */
>  
>  #define EP93XX_PWMx_TERM_COUNT	0x00
>  #define EP93XX_PWMx_DUTY_CYCLE	0x04
> diff --git a/include/linux/soc/cirrus/ep93xx.h b/include/linux/soc/cirrus/ep93xx.h
> new file mode 100644
> index 000000000000..56fbe2dc59b1
> --- /dev/null
> +++ b/include/linux/soc/cirrus/ep93xx.h
> @@ -0,0 +1,37 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _SOC_EP93XX_H
> +#define _SOC_EP93XX_H
> +
> +struct platform_device;
> +
> +#define EP93XX_CHIP_REV_D0	3
> +#define EP93XX_CHIP_REV_D1	4
> +#define EP93XX_CHIP_REV_E0	5
> +#define EP93XX_CHIP_REV_E1	6
> +#define EP93XX_CHIP_REV_E2	7
> +
> +#ifdef CONFIG_ARCH_EP93XX
> +int ep93xx_pwm_acquire_gpio(struct platform_device *pdev);
> +void ep93xx_pwm_release_gpio(struct platform_device *pdev);
> +int ep93xx_ide_acquire_gpio(struct platform_device *pdev);
> +void ep93xx_ide_release_gpio(struct platform_device *pdev);
> +int ep93xx_keypad_acquire_gpio(struct platform_device *pdev);
> +void ep93xx_keypad_release_gpio(struct platform_device *pdev);
> +int ep93xx_i2s_acquire(void);
> +void ep93xx_i2s_release(void);
> +unsigned int ep93xx_chip_revision(void);
> +
> +#else
> +static inline int ep93xx_pwm_acquire_gpio(struct platform_device *pdev) { return 0; }
> +static inline void ep93xx_pwm_release_gpio(struct platform_device *pdev) {}
> +static inline int ep93xx_ide_acquire_gpio(struct platform_device *pdev) { return 0; }
> +static inline void ep93xx_ide_release_gpio(struct platform_device *pdev) {}
> +static inline int ep93xx_keypad_acquire_gpio(struct platform_device *pdev) { return 0; }
> +static inline void ep93xx_keypad_release_gpio(struct platform_device *pdev) {}
> +static inline int ep93xx_i2s_acquire(void) { return 0; }
> +static inline void ep93xx_i2s_release(void) {}
> +static inline unsigned int ep93xx_chip_revision(void) { return 0; }
> +
> +#endif
> +
> +#endif
> diff --git a/sound/soc/cirrus/edb93xx.c b/sound/soc/cirrus/edb93xx.c
> index 3d011abaa266..f678b4c1514a 100644
> --- a/sound/soc/cirrus/edb93xx.c
> +++ b/sound/soc/cirrus/edb93xx.c
> @@ -22,11 +22,11 @@
>  #include <linux/platform_device.h>
>  #include <linux/gpio.h>
>  #include <linux/module.h>
> +#include <linux/soc/cirrus/ep93xx.h>
>  #include <sound/core.h>
>  #include <sound/pcm.h>
>  #include <sound/soc.h>
>  #include <asm/mach-types.h>
> -#include <mach/hardware.h>
>  
>  static int edb93xx_hw_params(struct snd_pcm_substream *substream,
>  			     struct snd_pcm_hw_params *params)
> diff --git a/sound/soc/cirrus/ep93xx-ac97.c b/sound/soc/cirrus/ep93xx-ac97.c
> index cd5a939ad608..c6bc447429af 100644
> --- a/sound/soc/cirrus/ep93xx-ac97.c
> +++ b/sound/soc/cirrus/ep93xx-ac97.c
> @@ -24,6 +24,7 @@
>  #include <sound/soc.h>
>  
>  #include <linux/platform_data/dma-ep93xx.h>
> +#include <linux/soc/cirrus/ep93xx.h>
>  
>  #include "ep93xx-pcm.h"
>  
> diff --git a/sound/soc/cirrus/ep93xx-i2s.c b/sound/soc/cirrus/ep93xx-i2s.c
> index 0918c5da575a..beab7c516855 100644
> --- a/sound/soc/cirrus/ep93xx-i2s.c
> +++ b/sound/soc/cirrus/ep93xx-i2s.c
> @@ -27,9 +27,8 @@
>  #include <sound/initval.h>
>  #include <sound/soc.h>
>  
> -#include <mach/hardware.h>
> -#include <mach/ep93xx-regs.h>
>  #include <linux/platform_data/dma-ep93xx.h>
> +#include <linux/soc/cirrus/ep93xx.h>
>  
>  #include "ep93xx-pcm.h"
>  
> diff --git a/sound/soc/cirrus/simone.c b/sound/soc/cirrus/simone.c
> index 1ec661834e5a..cb850530331b 100644
> --- a/sound/soc/cirrus/simone.c
> +++ b/sound/soc/cirrus/simone.c
> @@ -13,13 +13,13 @@
>  #include <linux/init.h>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
> +#include <linux/soc/cirrus/ep93xx.h>
>  
>  #include <sound/core.h>
>  #include <sound/pcm.h>
>  #include <sound/soc.h>
>  
>  #include <asm/mach-types.h>
> -#include <mach/hardware.h>
>  
>  static struct snd_soc_dai_link simone_dai = {
>  	.name		= "AC97",
> diff --git a/sound/soc/cirrus/snappercl15.c b/sound/soc/cirrus/snappercl15.c
> index 11ff7b2672b2..dea4909154c8 100644
> --- a/sound/soc/cirrus/snappercl15.c
> +++ b/sound/soc/cirrus/snappercl15.c
> @@ -13,12 +13,12 @@
>  
>  #include <linux/platform_device.h>
>  #include <linux/module.h>
> +#include <linux/soc/cirrus/ep93xx.h>
>  #include <sound/core.h>
>  #include <sound/pcm.h>
>  #include <sound/soc.h>
>  
>  #include <asm/mach-types.h>
> -#include <mach/hardware.h>
>  
>  #include "../codecs/tlv320aic23.h"
>  
> 
