Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 732CCC282DA
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 20:54:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CC7420825
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 20:54:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GgH3dPcp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbfDOUyN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 16:54:13 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:32823 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727052AbfDOUyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 16:54:13 -0400
Received: by mail-pg1-f193.google.com with SMTP id k19so9183918pgh.0;
        Mon, 15 Apr 2019 13:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=v/DK1xyuObQUpvpRdqdIUTRguBtee+RAYqcwAMAIjds=;
        b=GgH3dPcpozvXu/fZNtTu9/byU6890p4vPTEuXgrr0h2q9blxapNJb/ZPZnSCOoZ8Mh
         rUfo1kyHOSkTNBcMQz8sRTqLdZoun2oJSUxrcd4upE3Fde1tNm7UF+mBNTiCY9ZuSe1t
         Vf8JaE1zJueLBUA2sZa0UlyzXc+K25w+MLNR4C6yMhjpkSCaRdVqQoE+dGQsrmn95z5+
         zFsRWDCF9McTr6cHYq4Viby4GNreL4dGgh+pceJCGP42/P4RscqvlyocVMyJEyfwuk3b
         3UbFy/B3h7rAfX74lr5F6oXY5n+XZIQLAge9FsaRO6cnEab3Y1XkA6R61tvYx/rFrimH
         5J1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=v/DK1xyuObQUpvpRdqdIUTRguBtee+RAYqcwAMAIjds=;
        b=L5giHM0OpnikmPzKn7+bruPoM5tCXx13MCFgsbwenK3rjT3GrDFbw9Uj0ohMve3hQ+
         LIuZFL43hS3+lZd6ZlJpWvy30MIG/3g47QwYiAbsj+LVZ5LSUPwqnGrhJmJpHV0qZClI
         j3Ih3g8KCw0zCFQ2yuaToEZDEcXGBG8pIfZ8DFVKmqT4ZyeNaPtlZ6c+o/4C07DSHmMh
         BFzd5p7c62SbSBz/xtHU7UP83lJQ5NoOTcKvG43gtuj7nFcQl7Lb+Mp1cfmVskunzfFI
         NoUyZyFx+lTzWrfuBmsLpfPpAp9WNffuYIyKDphzKjOnK+fpK40scR2TxtSVHDVPvbR1
         eHIQ==
X-Gm-Message-State: APjAAAXZMUXf1xTg8+0SYQmohh2apno9ZIF+x3Bg2Sc3O3a3LE/loP2L
        SPMmG+xFJKDQx5CPtPFBwnVWGYhr
X-Google-Smtp-Source: APXvYqw1I/VFUuns/27KIE1T04Uhv8uRwbBBF47iSiE0C/bYaZeUjJV6+zuoZul44nw3b7rn8uhqhQ==
X-Received: by 2002:a63:3fc3:: with SMTP id m186mr74609379pga.151.1555361652449;
        Mon, 15 Apr 2019 13:54:12 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p7sm88044649pfp.70.2019.04.15.13.54.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Apr 2019 13:54:11 -0700 (PDT)
Date:   Mon, 15 Apr 2019 13:54:10 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Greg Ungerer <gerg@uclinux.org>,
        Linus Walleij <linus.walleij@linaro.org>, arm@kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 1/6] ARM: ks8695: watchdog: stop using mach/*.h
Message-ID: <20190415205410.GA31583@roeck-us.net>
References: <20190415202501.941196-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190415202501.941196-1-arnd@arndb.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2019 at 10:24:13PM +0200, Arnd Bergmann wrote:
> drivers should not rely on machine specific headers but
> get their information from the platform device.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/mach-ks8695/devices.c | 13 ++++++++++++-
>  drivers/watchdog/Kconfig       |  2 +-
>  drivers/watchdog/ks8695_wdt.c  | 30 +++++++++++++++++-------------
>  3 files changed, 30 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/arm/mach-ks8695/devices.c b/arch/arm/mach-ks8695/devices.c
> index 61cf20beb45f..57766817d86f 100644
> --- a/arch/arm/mach-ks8695/devices.c
> +++ b/arch/arm/mach-ks8695/devices.c
> @@ -169,11 +169,22 @@ void __init ks8696_add_device_hpna(void)
>  /* --------------------------------------------------------------------
>   *  Watchdog
>   * -------------------------------------------------------------------- */
> +#define KS8695_TMR_OFFSET      (0xF0000 + 0xE400)
> +#define KS8695_TMR_PA          (KS8695_IO_PA + KS8695_TMR_OFFSET)
> +static struct resource ks8695_wdt_resources[] = {
> +	[0] = {
> +		.name	= "tmr",
> +		.start	= KS8695_TMR_PA,
> +		.end	= KS8695_TMR_PA + 0xf,
> +		.flags	= IORESOURCE_MEM,
> +	},
> +};
>  
>  static struct platform_device ks8695_wdt_device = {
>  	.name		= "ks8695_wdt",
>  	.id		= -1,
> -	.num_resources	= 0,
> +	.resource	= ks8695_wdt_resources,
> +	.num_resources	= ARRAY_SIZE(ks8695_wdt_resources),
>  };
>  
>  static void __init ks8695_add_device_watchdog(void)
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 242eea859637..046e01daef57 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -397,7 +397,7 @@ config IXP4XX_WATCHDOG
>  
>  config KS8695_WATCHDOG
>  	tristate "KS8695 watchdog"
> -	depends on ARCH_KS8695
> +	depends on ARCH_KS8695 || COMPILE_TEST

Is __raw_readl / __raw_writel really available for all architectures / platforms ?

>  	help
>  	  Watchdog timer embedded into KS8695 processor. This will reboot your
>  	  system when the timeout is reached.
> diff --git a/drivers/watchdog/ks8695_wdt.c b/drivers/watchdog/ks8695_wdt.c
> index 1e41818a44bc..87c542c2f912 100644
> --- a/drivers/watchdog/ks8695_wdt.c
> +++ b/drivers/watchdog/ks8695_wdt.c
> @@ -23,10 +23,8 @@
>  #include <linux/watchdog.h>
>  #include <linux/io.h>
>  #include <linux/uaccess.h>
> -#include <mach/hardware.h>
>  
> -#define KS8695_TMR_OFFSET	(0xF0000 + 0xE400)
> -#define KS8695_TMR_VA		(KS8695_IO_VA + KS8695_TMR_OFFSET)
> +#define KS8695_CLOCK_RATE  25000000
>  
>  /*
>   * Timer registers
> @@ -57,6 +55,7 @@ MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
>  
>  static unsigned long ks8695wdt_busy;
>  static DEFINE_SPINLOCK(ks8695_lock);
> +static void __iomem *tmr_reg;
>  
>  /* ......................................................................... */
>  
> @@ -69,8 +68,8 @@ static inline void ks8695_wdt_stop(void)
>  
>  	spin_lock(&ks8695_lock);
>  	/* disable timer0 */
> -	tmcon = __raw_readl(KS8695_TMR_VA + KS8695_TMCON);
> -	__raw_writel(tmcon & ~TMCON_T0EN, KS8695_TMR_VA + KS8695_TMCON);
> +	tmcon = __raw_readl(tmr_reg + KS8695_TMCON);
> +	__raw_writel(tmcon & ~TMCON_T0EN, tmr_reg + KS8695_TMCON);
>  	spin_unlock(&ks8695_lock);
>  }
>  
> @@ -84,15 +83,15 @@ static inline void ks8695_wdt_start(void)
>  
>  	spin_lock(&ks8695_lock);
>  	/* disable timer0 */
> -	tmcon = __raw_readl(KS8695_TMR_VA + KS8695_TMCON);
> -	__raw_writel(tmcon & ~TMCON_T0EN, KS8695_TMR_VA + KS8695_TMCON);
> +	tmcon = __raw_readl(tmr_reg + KS8695_TMCON);
> +	__raw_writel(tmcon & ~TMCON_T0EN, tmr_reg + KS8695_TMCON);
>  
>  	/* program timer0 */
> -	__raw_writel(tval | T0TC_WATCHDOG, KS8695_TMR_VA + KS8695_T0TC);
> +	__raw_writel(tval | T0TC_WATCHDOG, tmr_reg + KS8695_T0TC);
>  
>  	/* re-enable timer0 */
> -	tmcon = __raw_readl(KS8695_TMR_VA + KS8695_TMCON);
> -	__raw_writel(tmcon | TMCON_T0EN, KS8695_TMR_VA + KS8695_TMCON);
> +	tmcon = __raw_readl(tmr_reg + KS8695_TMCON);
> +	__raw_writel(tmcon | TMCON_T0EN, tmr_reg + KS8695_TMCON);
>  	spin_unlock(&ks8695_lock);
>  }
>  
> @@ -105,9 +104,9 @@ static inline void ks8695_wdt_reload(void)
>  
>  	spin_lock(&ks8695_lock);
>  	/* disable, then re-enable timer0 */
> -	tmcon = __raw_readl(KS8695_TMR_VA + KS8695_TMCON);
> -	__raw_writel(tmcon & ~TMCON_T0EN, KS8695_TMR_VA + KS8695_TMCON);
> -	__raw_writel(tmcon | TMCON_T0EN, KS8695_TMR_VA + KS8695_TMCON);
> +	tmcon = __raw_readl(tmr_reg + KS8695_TMCON);
> +	__raw_writel(tmcon & ~TMCON_T0EN, tmr_reg + KS8695_TMCON);
> +	__raw_writel(tmcon | TMCON_T0EN, tmr_reg + KS8695_TMCON);
>  	spin_unlock(&ks8695_lock);
>  }
>  
> @@ -238,6 +237,11 @@ static struct miscdevice ks8695wdt_miscdev = {
>  static int ks8695wdt_probe(struct platform_device *pdev)
>  {
>  	int res;
> +	struct resource *resource = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +
> +	tmr_reg = devm_ioremap_resource(&pdev->dev, resource);

Please use devm_platform_ioremap_resource().

Thanks,
Guenter

> +	if (!tmr_reg)
> +		return -ENXIO;
>  
>  	if (ks8695wdt_miscdev.parent)
>  		return -EBUSY;
