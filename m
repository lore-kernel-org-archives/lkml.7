Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0202CCA9EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 11:33:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C39A12084B
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 11:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571830379;
	bh=36mw5RBINCOuBE8TXREt+7OJI394uLXcJR1lXjARXvQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=eNIi/tTFS9GBbyRMqcbt3Hm4cjcAW/aghpkWm+D47cpT6Fj/8KmyElcjk5p/zb5y7
	 AzwetExdsap0+A3vhD0FynSOwEvNviY1U+HdZB0uEl+fr3axfaFSzadWtevcmyB1IM
	 dc+2y9/zHXmjI5Z9zGBDZ8Oc8L2pPpF0i0097pCo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404916AbfJWLc6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 07:32:58 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35781 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404612AbfJWLc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 07:32:58 -0400
Received: by mail-ed1-f67.google.com with SMTP id k2so4788601edx.2;
        Wed, 23 Oct 2019 04:32:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hdwleZl7aKYSnuF89b0pQj4m1XzFQrFelIN3+m5OFq4=;
        b=hLI/Qq8d44jZCnfrT6GvT4m7pSkrTeGLC+uQvnBMM9yHTtvzb9SSpT98LnHDGaYuWX
         9uosXKK4eoVvlPQuESn3dKSAYMSrQhhB1vQFkuiRuu7srNL2PwJ09GgoblJ0t2VxlGGh
         rCsMjIBLmKpJgHEX8UtqiGyvmB7+Lbqigsa6EypT9BjdyaP1Qcxjq20LiAKbOWiUxiQt
         vnxuyuKMLvwxGmxFeZ4PeCNqB2ZFPYEfX9q9zQqDiRLclUdbj7/Cn2EWl7QcmKysZMK5
         qfQqy8iZ+4kbTsEBE6wL5gEiaT2XEH76lXDkebg9Po1E5KVajoEak/n8QpVIeenhr0gX
         NaQg==
X-Gm-Message-State: APjAAAVdbhM33jXHACgk2Qzvl7AsutX7m83ELOC/BjjLwJPo7PpGsGnz
        BVCPWXpZKnDIa5SJ0+iMjHI=
X-Google-Smtp-Source: APXvYqwXMNsDkGP904tCfzaTaE0Lpi/HZOXZsU71cnQaD8EXOqDKzIJHoqvgOw1CI3PdQRGrXYQ73g==
X-Received: by 2002:a50:ed01:: with SMTP id j1mr37031597eds.111.1571830375804;
        Wed, 23 Oct 2019 04:32:55 -0700 (PDT)
Received: from pi3 ([194.230.155.217])
        by smtp.googlemail.com with ESMTPSA id a13sm279797eds.10.2019.10.23.04.32.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 04:32:55 -0700 (PDT)
Date:   Wed, 23 Oct 2019 13:32:52 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Kukjin Kim <kgene@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linus.walleij@linaro.org,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Pankaj Dubey <pankaj.dubey@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/36] ARM: samsung: move pm check code to drivers/soc
Message-ID: <20191023113252.GG10630@pi3>
References: <20191010202802.1132272-1-arnd@arndb.de>
 <20191010203043.1241612-1-arnd@arndb.de>
 <20191010203043.1241612-9-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191010203043.1241612-9-arnd@arndb.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 10, 2019 at 10:29:53PM +0200, Arnd Bergmann wrote:
> This is the only part of plat-samsung that is really
> shared between the s3c and s5p ports. Moving it to
> drivers/soc/ lets us make them completely independent.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/mach-s5pv210/Kconfig                 |  1 +
>  arch/arm/plat-samsung/Kconfig                 | 49 +----------
>  arch/arm/plat-samsung/Makefile                |  2 -
>  .../arm/plat-samsung/include/plat/pm-common.h | 70 +---------------
>  drivers/soc/samsung/Kconfig                   | 48 ++++++++++-
>  drivers/soc/samsung/Makefile                  |  3 +
>  .../soc/samsung/s3c-pm-check.c                |  2 +-
>  .../soc/samsung/s3c-pm-debug.c                |  3 +-
>  include/linux/soc/samsung/s3c-pm.h            | 84 +++++++++++++++++++
>  9 files changed, 139 insertions(+), 123 deletions(-)
>  rename arch/arm/plat-samsung/pm-check.c => drivers/soc/samsung/s3c-pm-check.c (99%)
>  rename arch/arm/plat-samsung/pm-debug.c => drivers/soc/samsung/s3c-pm-debug.c (97%)
>  create mode 100644 include/linux/soc/samsung/s3c-pm.h
> 
> diff --git a/arch/arm/mach-s5pv210/Kconfig b/arch/arm/mach-s5pv210/Kconfig
> index 03984a791879..d2b0e64bad7e 100644
> --- a/arch/arm/mach-s5pv210/Kconfig
> +++ b/arch/arm/mach-s5pv210/Kconfig
> @@ -18,6 +18,7 @@ config ARCH_S5PV210
>  	select HAVE_S3C_RTC if RTC_CLASS
>  	select PINCTRL
>  	select PINCTRL_EXYNOS
> +	select SOC_SAMSUNG
>  	help
>  	  Samsung S5PV210/S5PC110 series based systems
>  
> diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/plat-samsung/Kconfig
> index e31a156a27df..740bdb23f38a 100644
> --- a/arch/arm/plat-samsung/Kconfig
> +++ b/arch/arm/plat-samsung/Kconfig
> @@ -8,6 +8,7 @@ config PLAT_SAMSUNG
>  	default y
>  	select GENERIC_IRQ_CHIP
>  	select NO_IOPORT_MAP
> +	select SOC_SAMSUNG
>  	help
>  	  Base platform code for all Samsung SoC based systems
>  
> @@ -234,54 +235,6 @@ config SAMSUNG_PM_GPIO
>  	  pinctrl-samsung driver.
>  endif
>  
> -comment "Power management"
> -
> -config SAMSUNG_PM_DEBUG
> -	bool "Samsung PM Suspend debug"
> -	depends on PM && DEBUG_KERNEL
> -	depends on PLAT_S3C24XX || ARCH_S3C64XX || ARCH_S5PV210
> -	depends on DEBUG_S3C24XX_UART || DEBUG_S3C2410_UART
> -	help
> -	  Say Y here if you want verbose debugging from the PM Suspend and
> -	  Resume code. See <file:Documentation/arm/samsung-s3c24xx/suspend.rst>
> -	  for more information.
> -
> -config S3C_PM_DEBUG_LED_SMDK
> -       bool "SMDK LED suspend/resume debugging"
> -       depends on PM && (MACH_SMDK6410)
> -       help
> -         Say Y here to enable the use of the SMDK LEDs on the baseboard
> -	 for debugging of the state of the suspend and resume process.
> -
> -	 Note, this currently only works for S3C64XX based SMDK boards.
> -
> -config SAMSUNG_PM_CHECK
> -	bool "S3C2410 PM Suspend Memory CRC"
> -	depends on PM && (PLAT_S3C24XX || ARCH_S3C64XX || ARCH_S5PV210)
> -	select CRC32
> -	help
> -	  Enable the PM code's memory area checksum over sleep. This option
> -	  will generate CRCs of all blocks of memory, and store them before
> -	  going to sleep. The blocks are then checked on resume for any
> -	  errors.
> -
> -	  Note, this can take several seconds depending on memory size
> -	  and CPU speed.
> -
> -	  See <file:Documentation/arm/samsung-s3c24xx/suspend.rst>
> -
> -config SAMSUNG_PM_CHECK_CHUNKSIZE
> -	int "S3C2410 PM Suspend CRC Chunksize (KiB)"
> -	depends on PM && SAMSUNG_PM_CHECK
> -	default 64
> -	help
> -	  Set the chunksize in Kilobytes of the CRC for checking memory
> -	  corruption over suspend and resume. A smaller value will mean that
> -	  the CRC data block will take more memory, but will identify any
> -	  faults with better precision.
> -
> -	  See <file:Documentation/arm/samsung-s3c24xx/suspend.rst>
> -
>  config SAMSUNG_WAKEMASK
>  	bool
>  	depends on PM
> diff --git a/arch/arm/plat-samsung/Makefile b/arch/arm/plat-samsung/Makefile
> index 3db9d2c38258..d88b9b84f3a9 100644
> --- a/arch/arm/plat-samsung/Makefile
> +++ b/arch/arm/plat-samsung/Makefile
> @@ -28,8 +28,6 @@ obj-$(CONFIG_PM_SLEEP)		+= pm-common.o
>  obj-$(CONFIG_EXYNOS_CPU_SUSPEND) += pm-common.o
>  obj-$(CONFIG_SAMSUNG_PM)	+= pm.o
>  obj-$(CONFIG_SAMSUNG_PM_GPIO)	+= pm-gpio.o
> -obj-$(CONFIG_SAMSUNG_PM_CHECK)	+= pm-check.o
> -obj-$(CONFIG_SAMSUNG_PM_DEBUG)	+= pm-debug.o
>  
>  obj-$(CONFIG_SAMSUNG_WAKEMASK)	+= wakeup-mask.o
>  obj-$(CONFIG_SAMSUNG_WDT_RESET)	+= watchdog-reset.o
> diff --git a/arch/arm/plat-samsung/include/plat/pm-common.h b/arch/arm/plat-samsung/include/plat/pm-common.h
> index 87fa97fd6e8b..18b9607e1e39 100644
> --- a/arch/arm/plat-samsung/include/plat/pm-common.h
> +++ b/arch/arm/plat-samsung/include/plat/pm-common.h
> @@ -11,6 +11,7 @@
>  #define __PLAT_SAMSUNG_PM_COMMON_H __FILE__
>  
>  #include <linux/irq.h>
> +#include <linux/soc/samsung/s3c-pm.h>
>  
>  /* sleep save info */
>  
> @@ -36,73 +37,4 @@ extern void s3c_pm_do_save(struct sleep_save *ptr, int count);
>  extern void s3c_pm_do_restore(const struct sleep_save *ptr, int count);
>  extern void s3c_pm_do_restore_core(const struct sleep_save *ptr, int count);
>  
> -/* PM debug functions */
> -
> -/**
> - * struct pm_uart_save - save block for core UART
> - * @ulcon: Save value for S3C2410_ULCON
> - * @ucon: Save value for S3C2410_UCON
> - * @ufcon: Save value for S3C2410_UFCON
> - * @umcon: Save value for S3C2410_UMCON
> - * @ubrdiv: Save value for S3C2410_UBRDIV
> - *
> - * Save block for UART registers to be held over sleep and restored if they
> - * are needed (say by debug).
> -*/
> -struct pm_uart_save {
> -	u32	ulcon;
> -	u32	ucon;
> -	u32	ufcon;
> -	u32	umcon;
> -	u32	ubrdiv;
> -	u32	udivslot;
> -};
> -
> -#ifdef CONFIG_SAMSUNG_PM_DEBUG
> -/**
> - * s3c_pm_dbg() - low level debug function for use in suspend/resume.
> - * @msg: The message to print.
> - *
> - * This function is used mainly to debug the resume process before the system
> - * can rely on printk/console output. It uses the low-level debugging output
> - * routine printascii() to do its work.
> - */
> -extern void s3c_pm_dbg(const char *msg, ...);
> -
> -#define S3C_PMDBG(fmt...) s3c_pm_dbg(fmt)
> -
> -extern void s3c_pm_save_uarts(bool is_s3c24xx);
> -extern void s3c_pm_restore_uarts(bool is_s3c24xx);
> -
> -#ifdef CONFIG_ARCH_S3C64XX
> -extern void s3c_pm_arch_update_uart(void __iomem *regs,
> -				    struct pm_uart_save *save);
> -#else
> -static inline void
> -s3c_pm_arch_update_uart(void __iomem *regs, struct pm_uart_save *save)
> -{
> -}
> -#endif
> -
> -#else
> -#define S3C_PMDBG(fmt...) pr_debug(fmt)
> -
> -static inline void s3c_pm_save_uarts(bool is_s3c24xx) { }
> -static inline void s3c_pm_restore_uarts(bool is_s3c24xx) { }
> -#endif
> -
> -/* suspend memory checking */
> -
> -#ifdef CONFIG_SAMSUNG_PM_CHECK
> -extern void s3c_pm_check_prepare(void);
> -extern void s3c_pm_check_restore(void);
> -extern void s3c_pm_check_cleanup(void);
> -extern void s3c_pm_check_store(void);
> -#else
> -#define s3c_pm_check_prepare() do { } while (0)
> -#define s3c_pm_check_restore() do { } while (0)
> -#define s3c_pm_check_cleanup() do { } while (0)
> -#define s3c_pm_check_store()   do { } while (0)
> -#endif
> -
>  #endif
> diff --git a/drivers/soc/samsung/Kconfig b/drivers/soc/samsung/Kconfig
> index 33ad0de2de3c..0ea7402ffba3 100644
> --- a/drivers/soc/samsung/Kconfig
> +++ b/drivers/soc/samsung/Kconfig
> @@ -25,6 +25,52 @@ config EXYNOS_PMU_ARM_DRIVERS
>  
>  config EXYNOS_PM_DOMAINS
>  	bool "Exynos PM domains" if COMPILE_TEST
> -	depends on PM_GENERIC_DOMAINS || COMPILE_TEST
> +	depends on (ARCH_EXYNOS && PM_GENERIC_DOMAINS) || COMPILE_TEST
> +
> +config SAMSUNG_PM_DEBUG
> +	bool "Samsung PM Suspend debug"
> +	depends on PM && DEBUG_KERNEL
> +	depends on PLAT_S3C24XX || ARCH_S3C64XX || ARCH_S5PV210
> +	depends on DEBUG_S3C24XX_UART || DEBUG_S3C2410_UART
> +	help
> +	  Say Y here if you want verbose debugging from the PM Suspend and
> +	  Resume code. See <file:Documentation/arm/samsung-s3c24xx/suspend.rst>
> +	  for more information.
> +
> +config S3C_PM_DEBUG_LED_SMDK
> +       bool "SMDK LED suspend/resume debugging"
> +       depends on PM && (MACH_SMDK6410)
> +       help
> +         Say Y here to enable the use of the SMDK LEDs on the baseboard
> +	 for debugging of the state of the suspend and resume process.
> +
> +	 Note, this currently only works for S3C64XX based SMDK boards.
> +
> +config SAMSUNG_PM_CHECK
> +	bool "S3C2410 PM Suspend Memory CRC"
> +	depends on PM && (PLAT_S3C24XX || ARCH_S3C64XX || ARCH_S5PV210)
> +	select CRC32
> +	help
> +	  Enable the PM code's memory area checksum over sleep. This option
> +	  will generate CRCs of all blocks of memory, and store them before
> +	  going to sleep. The blocks are then checked on resume for any
> +	  errors.
> +
> +	  Note, this can take several seconds depending on memory size
> +	  and CPU speed.
> +
> +	  See <file:Documentation/arm/samsung-s3c24xx/suspend.rst>
> +
> +config SAMSUNG_PM_CHECK_CHUNKSIZE
> +	int "S3C2410 PM Suspend CRC Chunksize (KiB)"
> +	depends on PM && SAMSUNG_PM_CHECK
> +	default 64
> +	help
> +	  Set the chunksize in Kilobytes of the CRC for checking memory
> +	  corruption over suspend and resume. A smaller value will mean that
> +	  the CRC data block will take more memory, but will identify any
> +	  faults with better precision.
> +
> +	  See <file:Documentation/arm/samsung-s3c24xx/suspend.rst>
>  
>  endif
> diff --git a/drivers/soc/samsung/Makefile b/drivers/soc/samsung/Makefile
> index 3b6a8797416c..88ae7a522055 100644
> --- a/drivers/soc/samsung/Makefile
> +++ b/drivers/soc/samsung/Makefile
> @@ -6,3 +6,6 @@ obj-$(CONFIG_EXYNOS_PMU)	+= exynos-pmu.o
>  obj-$(CONFIG_EXYNOS_PMU_ARM_DRIVERS)	+= exynos3250-pmu.o exynos4-pmu.o \
>  					exynos5250-pmu.o exynos5420-pmu.o
>  obj-$(CONFIG_EXYNOS_PM_DOMAINS) += pm_domains.o
> +
> +obj-$(CONFIG_SAMSUNG_PM_CHECK)	+= s3c-pm-check.o
> +obj-$(CONFIG_SAMSUNG_PM_DEBUG)	+= s3c-pm-debug.o
> diff --git a/arch/arm/plat-samsung/pm-check.c b/drivers/soc/samsung/s3c-pm-check.c
> similarity index 99%
> rename from arch/arm/plat-samsung/pm-check.c
> rename to drivers/soc/samsung/s3c-pm-check.c
> index cd2c02c68bc3..ff3e099fc208 100644
> --- a/arch/arm/plat-samsung/pm-check.c
> +++ b/drivers/soc/samsung/s3c-pm-check.c
> @@ -15,7 +15,7 @@
>  #include <linux/ioport.h>
>  #include <linux/slab.h>
>  
> -#include <plat/pm-common.h>
> +#include <linux/soc/samsung/s3c-pm.h>
>  
>  #if CONFIG_SAMSUNG_PM_CHECK_CHUNKSIZE < 1
>  #error CONFIG_SAMSUNG_PM_CHECK_CHUNKSIZE must be a positive non-zero value
> diff --git a/arch/arm/plat-samsung/pm-debug.c b/drivers/soc/samsung/s3c-pm-debug.c
> similarity index 97%
> rename from arch/arm/plat-samsung/pm-debug.c
> rename to drivers/soc/samsung/s3c-pm-debug.c
> index 482d53753e93..b5ce0e9a41e5 100644
> --- a/arch/arm/plat-samsung/pm-debug.c
> +++ b/drivers/soc/samsung/s3c-pm-debug.c
> @@ -15,8 +15,7 @@
>  
>  #include <asm/mach/map.h>
>  
> -#include <plat/cpu.h>
> -#include <plat/pm-common.h>
> +#include <linux/soc/samsung/s3c-pm.h>
>  
>  static struct pm_uart_save uart_save;
>  
> diff --git a/include/linux/soc/samsung/s3c-pm.h b/include/linux/soc/samsung/s3c-pm.h
> new file mode 100644
> index 000000000000..d477b314d034
> --- /dev/null
> +++ b/include/linux/soc/samsung/s3c-pm.h
> @@ -0,0 +1,84 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2013 Samsung Electronics Co., Ltd.
> + *	Tomasz Figa <t.figa@samsung.com>
> + * Copyright (c) 2004 Simtec Electronics
> + *	http://armlinux.simtec.co.uk/
> + *	Written by Ben Dooks, <ben@simtec.co.uk>
> + */
> +
> +#ifndef __SAMSUNG_SOC_S3C_PM_H
> +#define __SAMSUNG_SOC_S3C_PM_H __FILE__

Use guard name prefix consistent with other files, so:
__LINUX_SOC_SAMSUNG_S3C_PM_H

Rest looks good.

Best regards,
Krzysztof
