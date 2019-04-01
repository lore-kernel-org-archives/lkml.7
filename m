Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4C8CC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 04:10:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0FB12086C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 04:10:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DDmXTurX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbfDAEKe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 00:10:34 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:33885 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbfDAEKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 00:10:34 -0400
Received: by mail-yb1-f194.google.com with SMTP id c2so3020138ybn.1
        for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2019 21:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QzSKihQZzQ7ROAl8Uqfco7n/5do+sI85xzCfbGp+Anc=;
        b=DDmXTurXDR4zN8vDoEMhC0LwvQzwy371OLRV3LRnboVerEylOKKFoqmOSubHTOpj3U
         G5tYzc+v2J5SwAaoXke4+Q8mihjpmzJm9d/jroAaewYs244lGZk4/2skNMQ9LPZ4rOpy
         4b3hqGRZnKhyBmTHgDATFAliNszvhtjcWoNZbdgSwkYTuRequa0/eF8CFzspwnLxzPAA
         NQzXrTxp5ekUisMRzCeYp41glMwdo3vjvXU5UyM8/7q0LwOHFPLsdZMXnrG1WZfqLa0e
         EJ6fO+5tMNlzIPWPW/PGYfrNiL/9N7xxUKysVXEfSliR7O0fTrPHdUF0JP7/NkAkJ/PM
         J66g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QzSKihQZzQ7ROAl8Uqfco7n/5do+sI85xzCfbGp+Anc=;
        b=iUiaQ83YOQOr+IG9ubyL4NNhbdkbU0hIGsi8SpvvFdcrnLaHN4cHimMylqM9lD1ihS
         o7GgDF0K9OakrAb4cKkXnwD1UJOgFUJFTevBpMOzWSOuzkU6jVwBjyPxb/ogNjDqEsm2
         pIgXd1Ah+jyoCt702+cDQ1NtxiriPn11O0PHjbBs6tITJez9t1gZqWBVlNa5qkNxZ+bp
         3IL/9lVvAfaMRf/ksBX+bheT8OsEpMb9buAxfp5Oaj3x9mZo8RUblCt/kmKUZsjMGq81
         Rw+PXS6uuqLugYZp0K8mVi8ZU4sRwIkLpxl0Lb+Rrz7JJX6w2MEFh8V0pM5GhkYwxwX0
         xLRQ==
X-Gm-Message-State: APjAAAVgrfMIHOxKXwO/qR7ga4TiOmh9cARV3bLQj/dePgpQsFxs9ZYR
        RB8yanISBnmf8u+LSNqzBGOAfQWYt9ipK7B7XuJO8Q==
X-Google-Smtp-Source: APXvYqxF8cbaWRb+umJHA+GOINmMlYk/DML6P7zb9KOJbXcw74psgC403ZhYYLOgaRobllmQO88evl7Pu9GEle2r9ko=
X-Received: by 2002:a25:c84:: with SMTP id 126mr22017341ybm.247.1554091832630;
 Sun, 31 Mar 2019 21:10:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190401032425.18647-1-daniel.lezcano@linaro.org>
In-Reply-To: <20190401032425.18647-1-daniel.lezcano@linaro.org>
From:   Guenter Roeck <groeck@google.com>
Date:   Sun, 31 Mar 2019 21:10:21 -0700
Message-ID: <CABXOdTeB+5vNi+mRBf2ff2YJG5WVRAGFjBz-ehjDTCyQdcpr7A@mail.gmail.com>
Subject: Re: [PATCH] thermal/drivers/core: Remove the module Kconfig's option
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rui.zhang@intel.com, edubezval@gmail.com,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
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

On Sun, Mar 31, 2019 at 8:24 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> The module support for the thermal subsystem does have a little sense:

Do you mean "makes little sense" ?

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

Sounds like a good idea.

Acked-by: Guenter Roeck <groeck@chromium.org>

Many dependencies such as the following can probably be simplified or
removed after this patch has been accepted.

depends on THERMAL=y
depends on THERMAL || THERMAL=n
depends on (HWMON && (THERMAL || !THERMAL_OF)) || !HWMON
depends on !(MLXSW_CORE=y && THERMAL=m)
depends on THERMAL || !THERMAL
depends on HWMON=y || HWMON=THERMAL
depends on THERMAL || !THERMAL_OF

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
