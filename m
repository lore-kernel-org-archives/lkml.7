Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 339C2C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 18:09:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1FEB2063F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 18:09:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z4grn9oJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729468AbfDPSJl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 14:09:41 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43531 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbfDPSJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 14:09:41 -0400
Received: by mail-pg1-f196.google.com with SMTP id z9so10710839pgu.10;
        Tue, 16 Apr 2019 11:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=135ix82lxlDs2uPUYrS8Hp8Ls3cvHLI1ebW+9ZmfVfI=;
        b=Z4grn9oJx+JjBwzNOncIXkaPd/sEdmn3ySghPsdT+4QYWGWQA3UHPXrAsmDgfKhg/7
         EPYlLR8eMOLYrRgI8U+hIumlVVGDJrgkt9Q3YBVy2yti+WMD8AvLYMeHdGXlvD+il3t8
         Yx/j0vt9Gkg+gOHMzF0KQv4rXbrYdFYMcpnM33EkasMwpf9zx8UN6WuuhiJ9NlRX5iB5
         Ud6be2HxrnuR5nUSpZ2QxIs3qrgRi7vyy5vFGbB7Q5FiMEQv4wLb/bTHBjtDNDIIn9T0
         jY6dxfGtLwgwHofkc2+HmeTEQCCqwlNIll+bzcf99x3SnSC8ZKPjGgRATpzm+8Vg4zCl
         qI+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=135ix82lxlDs2uPUYrS8Hp8Ls3cvHLI1ebW+9ZmfVfI=;
        b=YbXwocsq3sCHEXHTQlvUSkdQQOGNMQqtvzkURKArBXhs+bH6l+CQF2aXlQmN0NoUz2
         n30DE5Z4Dzr+VotG5zADOvQibPRqXHFYOuNmnObIVgwtzGVMe2GhbBm2sDo1D7yxkN0E
         m5y0DH2vz0EvfNIVGYM298tnpKP7t1g1O5k5wTJxJgU8PPhAZZMHH74alhlXjXofagFC
         ownMVlh5ZQQ9Hg6Qd2M698NqfUHM6RD54sI1D9Q1vd/FGcKN+63civ9b8+XzicF43Hnk
         lhPmetmwMlzI5Gij5jqDpAwWCcAxRwpQ79M0/dVIV4xFsumSU4CBIzT1Qr9327UJYGXB
         ZC5g==
X-Gm-Message-State: APjAAAVDrIo/o3EsD0qLzWf+Pu7RkkeHKjhHwCVsbPRGXroEM2EKjCgG
        9oB52yAsyA3OHH8YJaSkzrmF7Ugz
X-Google-Smtp-Source: APXvYqwweC4iXkGZ2JpP5oDICz7glbYuIos9EwL94m6fWNluKhAtGiHBePbCx0UnDnWutdyl9GPFIw==
X-Received: by 2002:a63:6842:: with SMTP id d63mr75502772pgc.49.1555438180049;
        Tue, 16 Apr 2019 11:09:40 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e21sm71016292pfd.177.2019.04.16.11.09.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 11:09:39 -0700 (PDT)
Date:   Tue, 16 Apr 2019 11:09:38 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     arm@kernel.org, Greg Ungerer <gerg@uclinux.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 1/6 v2] ARM: ks8695: watchdog: stop using mach/*.h
Message-ID: <20190416180938.GA23210@roeck-us.net>
References: <20190415202501.941196-1-arnd@arndb.de>
 <20190416132207.1304277-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190416132207.1304277-1-arnd@arndb.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 03:21:41PM +0200, Arnd Bergmann wrote:
> drivers should not rely on machine specific headers but
> get their information from the platform device.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Guenter Roeck <linux@roeck-us.net>

I assume this will be applied through an arm tree since it touches arm code.

Thanks,
Guenter

> ---
>  arch/arm/mach-ks8695/devices.c | 13 ++++++++++++-
>  drivers/watchdog/Kconfig       |  2 +-
>  drivers/watchdog/ks8695_wdt.c  | 29 ++++++++++++++++-------------
>  3 files changed, 29 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/arm/mach-ks8695/devices.c b/arch/arm/mach-ks8695/devices.c
> index 15afeb964280..ba9d0f0f47ac 100644
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
>  	help
>  	  Watchdog timer embedded into KS8695 processor. This will reboot your
>  	  system when the timeout is reached.
> diff --git a/drivers/watchdog/ks8695_wdt.c b/drivers/watchdog/ks8695_wdt.c
> index 1e41818a44bc..2a11cdfe2ab1 100644
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
> @@ -239,6 +238,10 @@ static int ks8695wdt_probe(struct platform_device *pdev)
>  {
>  	int res;
>  
> +	tmr_reg = devm_platform_ioremap_resource(pdev, 0);
> +	if (!tmr_reg)
> +		return -ENXIO;
> +
>  	if (ks8695wdt_miscdev.parent)
>  		return -EBUSY;
>  	ks8695wdt_miscdev.parent = &pdev->dev;
