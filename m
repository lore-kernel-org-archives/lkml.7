Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E1FAC282E1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 15:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0421D2175B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 15:52:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QH4+OEEi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728503AbfDWPwP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 11:52:15 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34952 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728233AbfDWPwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 11:52:14 -0400
Received: by mail-pg1-f196.google.com with SMTP id g8so7830729pgf.2;
        Tue, 23 Apr 2019 08:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+nZBYYs3xJAIUHfD9A1Bv8gWHxW5vdV7lozuu5wy9Zo=;
        b=QH4+OEEiHYdEJkdSi5KfK01x3OxOiPVMekKtEd+meNY+51wbhH+YU5L827I3ulrkTx
         eJykqE20j1Ra7jt8zZKybVysdshUW8O3yf0OOhuIdn8ukZxOH1DdHuRczNeHMIn9bw07
         zm/1koXtMTBwU3bOph6tUGyUU3qdjwlW5iOUWADCpQwhigXKJJXgdlWxLkhPMaVh5xKg
         EPnaet5tsqFTCfpKMoRmMkEDkAUi4TfRUcKnhanTZJ8jQ5nQQm0dCX2mrSjB3dLwG00W
         QynoDeV1Q8WbvzWTFE5F4igkvVUiEcsqglwZuTSRY3k4qcWW0V/xubOmf4G1cIPanbOE
         FFzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+nZBYYs3xJAIUHfD9A1Bv8gWHxW5vdV7lozuu5wy9Zo=;
        b=i4/2NiLdel+m2znMeScb3Ag924IUWqF5mPPpq1C5+ENkeTEzsVn60LGlve3VzyETFo
         MhfIJ3uoibEMCQ7s8XsO9bT1xGsZBxee6zC88VrDjH4Q60UbfNuwi5feH77iuqdy/oER
         xzYrTn1lmoqgMYwDqWiJZkYxczV76mTTi2txhPx7+fJBlFPfM7hJ2MkU0eWtBh3V7pEJ
         yi7zsBo/vD2/6/4xNqA5Dh9Q2wY4MQuPlX39LM0taesSE6SrcbHC7Cami3jDV9zqjgcC
         i4ReDpAFawViczS6xmu80yZDoIS5U3BCYPgc6kzh9PsdaiJueibe4d7BKcCTH+Wb7a09
         IjwQ==
X-Gm-Message-State: APjAAAX5Ix98QKFQe+Jt7kQoRCoWGO8UbzYwukVRjvtCASNaj18brcfr
        864nQ3TxohM+8RllbN3agXY=
X-Google-Smtp-Source: APXvYqx+wRtFNIE4h+aAA7UaRfM+s4kJOyF5ri3PshN/WkpUk6KhMAu4rVhYoT43rDwS7XANDalLeg==
X-Received: by 2002:a63:7f0b:: with SMTP id a11mr23731274pgd.234.1556034733724;
        Tue, 23 Apr 2019 08:52:13 -0700 (PDT)
Received: from localhost.localdomain ([2601:644:8201:32e0:7256:81ff:febd:926d])
        by smtp.gmail.com with ESMTPSA id l74sm30098971pfi.174.2019.04.23.08.52.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 08:52:12 -0700 (PDT)
Date:   Tue, 23 Apr 2019 08:52:10 -0700
From:   Eduardo Valentin <edubezval@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Guenter Roeck <groeck@chromium.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, Guan Xuetao <gxt@pku.edu.cn>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Arnd Bergmann <arnd@arndb.de>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Daniel Mack <daniel@zonque.org>,
        "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>,
        "open list:MIPS" <linux-mips@vger.kernel.org>
Subject: Re: [PATCH 1/7] thermal/drivers/core: Remove the module Kconfig's
 option
Message-ID: <20190423155208.GC16014@localhost.localdomain>
References: <20190402161256.11044-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190402161256.11044-1-daniel.lezcano@linaro.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Apr 02, 2019 at 06:12:44PM +0200, Daniel Lezcano wrote:
> The module support for the thermal subsystem makes little sense:
>  - some subsystems relying on it are not modules, thus forcing the
>    framework to be compiled in
>  - it is compiled in for almost every configs, the remaining ones
>    are a few platforms where I don't see why we can not switch the thermal
>    to 'y'. The drivers can stay in tristate.
>  - platforms need the thermal to be ready as soon as possible at boot time
>    in order to mitigate
> 
> Usually the subsystems framework are compiled-in and the plugs are as module.
> 
> Remove the module option. The removal of the module related dead code will
> come after this patch gets in or is acked.


I remember some buzilla entry around this some time back.

Rui, do you remember why you made this to be module?

I dont have strong opinion here, but I would like to see
a better description why we are going this direction rather
than "most people dont use it as module". Was there any particular
specific technical motivation?


> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Acked-by: Guenter Roeck <groeck@chromium.org>
> For mini2440:
> Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  arch/arm/configs/mini2440_defconfig        | 2 +-
>  arch/arm/configs/pxa_defconfig             | 2 +-
>  arch/mips/configs/ip22_defconfig           | 2 +-
>  arch/mips/configs/ip27_defconfig           | 2 +-
>  arch/unicore32/configs/unicore32_defconfig | 2 +-
>  drivers/thermal/Kconfig                    | 4 ++--
>  6 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm/configs/mini2440_defconfig b/arch/arm/configs/mini2440_defconfig
> index d95a8059d30b..0cf1c120c4bb 100644
> --- a/arch/arm/configs/mini2440_defconfig
> +++ b/arch/arm/configs/mini2440_defconfig
> @@ -152,7 +152,7 @@ CONFIG_SPI_S3C24XX=y
>  CONFIG_SPI_SPIDEV=y
>  CONFIG_GPIO_SYSFS=y
>  CONFIG_SENSORS_LM75=y
> -CONFIG_THERMAL=m
> +CONFIG_THERMAL=y
>  CONFIG_WATCHDOG=y
>  CONFIG_S3C2410_WATCHDOG=y
>  CONFIG_FB=y
> diff --git a/arch/arm/configs/pxa_defconfig b/arch/arm/configs/pxa_defconfig
> index d4654755b09c..d4f9dda3a52f 100644
> --- a/arch/arm/configs/pxa_defconfig
> +++ b/arch/arm/configs/pxa_defconfig
> @@ -387,7 +387,7 @@ CONFIG_SENSORS_LM75=m
>  CONFIG_SENSORS_LM90=m
>  CONFIG_SENSORS_LM95245=m
>  CONFIG_SENSORS_NTC_THERMISTOR=m
> -CONFIG_THERMAL=m
> +CONFIG_THERMAL=y
>  CONFIG_WATCHDOG=y
>  CONFIG_XILINX_WATCHDOG=m
>  CONFIG_SA1100_WATCHDOG=m
> diff --git a/arch/mips/configs/ip22_defconfig b/arch/mips/configs/ip22_defconfig
> index ff40fbc2f439..21a1168ae301 100644
> --- a/arch/mips/configs/ip22_defconfig
> +++ b/arch/mips/configs/ip22_defconfig
> @@ -228,7 +228,7 @@ CONFIG_SERIAL_IP22_ZILOG=m
>  # CONFIG_HW_RANDOM is not set
>  CONFIG_RAW_DRIVER=m
>  # CONFIG_HWMON is not set
> -CONFIG_THERMAL=m
> +CONFIG_THERMAL=y
>  CONFIG_WATCHDOG=y
>  CONFIG_INDYDOG=m
>  # CONFIG_VGA_CONSOLE is not set
> diff --git a/arch/mips/configs/ip27_defconfig b/arch/mips/configs/ip27_defconfig
> index 81c47e18131b..54db5dedf776 100644
> --- a/arch/mips/configs/ip27_defconfig
> +++ b/arch/mips/configs/ip27_defconfig
> @@ -271,7 +271,7 @@ CONFIG_I2C_PARPORT_LIGHT=m
>  CONFIG_I2C_TAOS_EVM=m
>  CONFIG_I2C_STUB=m
>  # CONFIG_HWMON is not set
> -CONFIG_THERMAL=m
> +CONFIG_THERMAL=y
>  CONFIG_MFD_PCF50633=m
>  CONFIG_PCF50633_ADC=m
>  CONFIG_PCF50633_GPIO=m
> diff --git a/arch/unicore32/configs/unicore32_defconfig b/arch/unicore32/configs/unicore32_defconfig
> index aebd01fc28e5..360cc9abcdb0 100644
> --- a/arch/unicore32/configs/unicore32_defconfig
> +++ b/arch/unicore32/configs/unicore32_defconfig
> @@ -119,7 +119,7 @@ CONFIG_I2C_PUV3=y
>  #	Hardware Monitoring support
>  #CONFIG_SENSORS_LM75=m
>  #	Generic Thermal sysfs driver
> -#CONFIG_THERMAL=m
> +#CONFIG_THERMAL=y
>  #CONFIG_THERMAL_HWMON=y
>  
>  #	Multimedia support
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index 653aa27a25a4..ccf5b9408d7a 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -3,7 +3,7 @@
>  #
>  
>  menuconfig THERMAL
> -	tristate "Generic Thermal sysfs driver"
> +	bool "Generic Thermal sysfs driver"
>  	help
>  	  Generic Thermal Sysfs driver offers a generic mechanism for
>  	  thermal management. Usually it's made up of one or more thermal
> @@ -11,7 +11,7 @@ menuconfig THERMAL
>  	  Each thermal zone contains its own temperature, trip points,
>  	  cooling devices.
>  	  All platforms with ACPI thermal support can use this driver.
> -	  If you want this support, you should say Y or M here.
> +	  If you want this support, you should say Y here.
>  
>  if THERMAL
>  
> -- 
> 2.17.1
> 
