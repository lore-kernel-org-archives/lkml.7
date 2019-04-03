Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E6B2C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 05:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6A85206DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 05:46:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=verdurent-com.20150623.gappssmtp.com header.i=@verdurent-com.20150623.gappssmtp.com header.b="TJfndTNu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728824AbfDCFqB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 01:46:01 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:35510 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728718AbfDCFqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 01:46:00 -0400
Received: by mail-ua1-f66.google.com with SMTP id a46so89254uae.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 22:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nFrxupJk5QN98j8QXG4Je1vJrfpdR68KS8rbFbTabe0=;
        b=TJfndTNugNUfYxz9RgcKXLIY6gzPVxi8mOKeOAQu5HqImmHnbdO1oNLNplklUp6NHW
         6T7caTphXrSVkr/w9jPejbX6XsZurgsA9HBonZT+g1sOX5zLRtAfgPsiCGnM2huH+KKA
         JbjIn42xJHZoIl+SKPx6QAjnowT+3hBznTlQz/sEgkgb5x8IdtIReGeVoe4pEMOI+V/2
         F8yJrvCTU9JPBRxGLUQDCouK7CBXLI/PoVA1fwM2DpMLT6ZJMZ6EEWFiJoXgnPn263to
         QVwHI7waIb7UhCHWZu4yxvNhFaaODNlN7TmTWEiZqKuhJdxUbuKDc8w3tg7pS8eDZ2p6
         SA0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nFrxupJk5QN98j8QXG4Je1vJrfpdR68KS8rbFbTabe0=;
        b=Yp30EQd9xkQpwJRGaUfk9sEGWhKcxx2WG79KdyWkISgDutMMDiP/MBUI3Hf2PrYpzh
         eXuEEQXRER83f9Afi1iFGhxWRaOUfwXH+HiPtF5Oj0ny+RnhoKx9UnHtHEAG5hRgbydP
         AzqnG4u61w+id5zaT2XsB5u28/QQQidYNybrU59JqZwrPXaBo9BJVe9gYwGZncTONmM4
         +N8ipnpFo1PnDHyNqEWdy8ThRn40URp+fsNizre7uZL2mbxCz/Av0+n3olYGzONj3BSd
         gnVHVrxco4YAXH3VgDe7EeR1O45A5E/AJG/b/n5kra1bK1ED+J8+EyGUa3WX8vP41jhv
         E86Q==
X-Gm-Message-State: APjAAAVvKJMLwC6bVd0myFcFNher1JKNjY4H9OW2Rjx0N0ioyHc46G/5
        RnfjpkZZo9xx40A7lkKmgD0xQO7NH19d3WMX/P+XyA==
X-Google-Smtp-Source: APXvYqzHGvJwiX/fdXxXEbQ9nw04ftftboAIcDEzw5XUfWYl5fSyrKNxgWlMIsv3+kkAGkJhPVHyho4X8bETTLnJ4Z0=
X-Received: by 2002:ab0:6947:: with SMTP id c7mr26293252uas.51.1554270358658;
 Tue, 02 Apr 2019 22:45:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190401032425.18647-1-daniel.lezcano@linaro.org>
In-Reply-To: <20190401032425.18647-1-daniel.lezcano@linaro.org>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Wed, 3 Apr 2019 12:45:47 +0700
Message-ID: <CAHLCerNx6vM_H72mWA14Avg9WcE6ugOcaxw1C1hQHeTaPsY21w@mail.gmail.com>
Subject: Re: [PATCH] thermal/drivers/core: Remove the module Kconfig's option
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, Guan Xuetao <gxt@pku.edu.cn>,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Guenter Roeck <groeck@chromium.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Daniel Mack <daniel@zonque.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>,
        "open list:MIPS" <linux-mips@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 1, 2019 at 10:24 AM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> The module support for the thermal subsystem does have a little sense:
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
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>

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
>  #      Hardware Monitoring support
>  #CONFIG_SENSORS_LM75=m
>  #      Generic Thermal sysfs driver
> -#CONFIG_THERMAL=m
> +#CONFIG_THERMAL=y
>  #CONFIG_THERMAL_HWMON=y
>
>  #      Multimedia support
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index 653aa27a25a4..ccf5b9408d7a 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -3,7 +3,7 @@
>  #
>
>  menuconfig THERMAL
> -       tristate "Generic Thermal sysfs driver"
> +       bool "Generic Thermal sysfs driver"
>         help
>           Generic Thermal Sysfs driver offers a generic mechanism for
>           thermal management. Usually it's made up of one or more thermal
> @@ -11,7 +11,7 @@ menuconfig THERMAL
>           Each thermal zone contains its own temperature, trip points,
>           cooling devices.
>           All platforms with ACPI thermal support can use this driver.
> -         If you want this support, you should say Y or M here.
> +         If you want this support, you should say Y here.
>
>  if THERMAL
>
> --
> 2.17.1
>
