Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3402C10F05
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 03:24:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B82422086C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 03:24:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dVR7Djlq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731747AbfDADYh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 23:24:37 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40728 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731593AbfDADYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 23:24:37 -0400
Received: by mail-pf1-f194.google.com with SMTP id c207so3812155pfc.7
        for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2019 20:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=hwwaEVKECJwjOTE1hnV29hek6M9PCrzEolVP/wwefUY=;
        b=dVR7Djlqzy5wKbwuoBbRQQAW7rhX4EadJRGwTYRVzHLON6Heet4U2vZz7YvCU8ITpU
         coVhxTNb4+83/ZqVJ8IPbtm41SZLIZssJ74CMRt9/d5zV/k016ZXMcp/AsooqDIMSUFl
         J4FSNCY+EcdbGsED13XkpH9oI7bD1BK+ru8XDED9CGd141gA+JhBSyYoHc17yKABKbs+
         ZqCLZpV+TuDvx+w0KgGa1U6m2QdjuaLFjQVcgjBlZE48rs9ShUHrKAgaxyKpi0acYz48
         UvgsXVBIIcYBBoF/iGvvPotGU+IOgrVXWH8dCFjLkApiv4i1EUZ1FrDhCSO1CM4YEPAK
         GgDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hwwaEVKECJwjOTE1hnV29hek6M9PCrzEolVP/wwefUY=;
        b=ZUd609PnddsmPRog3L6ombOwHr7oYF0gyMDPfJZsyFRUwLELFwQ7KhKc5TkwvZXkFY
         It1mtZ+7PNH7bmbAj3Rt1o+a9X4R/H3C92nrVszSLrxWhW31wE9zME8Gvg+1qTybACnI
         1xDtJ49LdnGs8wn7QUtmxX8/dsmX5AUDazB0K40VG5WMweXwRg0Wjl+DHyQUk8XnbCTa
         /8PUwf9RINu10eygu1lyMV4JcYc4+cQ2SDUzHY6vzIzZfoGzKWhHON9eztwSrineSnFL
         nSlZehwB4RhknwnY5y2zIEFoS9kWPF3rRAlahVbZWXlOLWwmzZXQZfM5eeyqgVJGzy1f
         qfdg==
X-Gm-Message-State: APjAAAUk9bIBbZvTNmeGWcSXOUqviLir5ueiA77vsoRkp4TdwppqOLnt
        rhZeAboHaFfcRGMsF3Hj2JbrVA==
X-Google-Smtp-Source: APXvYqyYlBUL5z+GLklnCgaBk3mP6hpdoYeVVhizXnZNfvVsFVEc5/KBbLoL7t1LP7g6PswO2gyqlg==
X-Received: by 2002:a65:6144:: with SMTP id o4mr21263129pgv.247.1554089075897;
        Sun, 31 Mar 2019 20:24:35 -0700 (PDT)
Received: from mai.imgcgcw.net ([147.50.13.10])
        by smtp.gmail.com with ESMTPSA id j14sm14124888pfe.12.2019.03.31.20.24.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 Mar 2019 20:24:34 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rui.zhang@intel.com, edubezval@gmail.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
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
        linux-arm-kernel@lists.infradead.org (moderated list:ARM PORT),
        linux-mips@vger.kernel.org (open list:MIPS)
Subject: [PATCH] thermal/drivers/core: Remove the module Kconfig's option
Date:   Mon,  1 Apr 2019 05:24:20 +0200
Message-Id: <20190401032425.18647-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The module support for the thermal subsystem does have a little sense:
 - some subsystems relying on it are not modules, thus forcing the
   framework to be compiled in
 - it is compiled in for almost every configs, the remaining ones
   are a few platforms where I don't see why we can not switch the thermal
   to 'y'. The drivers can stay in tristate.
 - platforms need the thermal to be ready as soon as possible at boot time
   in order to mitigate

Usually the subsystems framework are compiled-in and the plugs are as module.

Remove the module option. The removal of the module related dead code will
come after this patch gets in or is acked.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/configs/mini2440_defconfig        | 2 +-
 arch/arm/configs/pxa_defconfig             | 2 +-
 arch/mips/configs/ip22_defconfig           | 2 +-
 arch/mips/configs/ip27_defconfig           | 2 +-
 arch/unicore32/configs/unicore32_defconfig | 2 +-
 drivers/thermal/Kconfig                    | 4 ++--
 6 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/configs/mini2440_defconfig b/arch/arm/configs/mini2440_defconfig
index d95a8059d30b..0cf1c120c4bb 100644
--- a/arch/arm/configs/mini2440_defconfig
+++ b/arch/arm/configs/mini2440_defconfig
@@ -152,7 +152,7 @@ CONFIG_SPI_S3C24XX=y
 CONFIG_SPI_SPIDEV=y
 CONFIG_GPIO_SYSFS=y
 CONFIG_SENSORS_LM75=y
-CONFIG_THERMAL=m
+CONFIG_THERMAL=y
 CONFIG_WATCHDOG=y
 CONFIG_S3C2410_WATCHDOG=y
 CONFIG_FB=y
diff --git a/arch/arm/configs/pxa_defconfig b/arch/arm/configs/pxa_defconfig
index d4654755b09c..d4f9dda3a52f 100644
--- a/arch/arm/configs/pxa_defconfig
+++ b/arch/arm/configs/pxa_defconfig
@@ -387,7 +387,7 @@ CONFIG_SENSORS_LM75=m
 CONFIG_SENSORS_LM90=m
 CONFIG_SENSORS_LM95245=m
 CONFIG_SENSORS_NTC_THERMISTOR=m
-CONFIG_THERMAL=m
+CONFIG_THERMAL=y
 CONFIG_WATCHDOG=y
 CONFIG_XILINX_WATCHDOG=m
 CONFIG_SA1100_WATCHDOG=m
diff --git a/arch/mips/configs/ip22_defconfig b/arch/mips/configs/ip22_defconfig
index ff40fbc2f439..21a1168ae301 100644
--- a/arch/mips/configs/ip22_defconfig
+++ b/arch/mips/configs/ip22_defconfig
@@ -228,7 +228,7 @@ CONFIG_SERIAL_IP22_ZILOG=m
 # CONFIG_HW_RANDOM is not set
 CONFIG_RAW_DRIVER=m
 # CONFIG_HWMON is not set
-CONFIG_THERMAL=m
+CONFIG_THERMAL=y
 CONFIG_WATCHDOG=y
 CONFIG_INDYDOG=m
 # CONFIG_VGA_CONSOLE is not set
diff --git a/arch/mips/configs/ip27_defconfig b/arch/mips/configs/ip27_defconfig
index 81c47e18131b..54db5dedf776 100644
--- a/arch/mips/configs/ip27_defconfig
+++ b/arch/mips/configs/ip27_defconfig
@@ -271,7 +271,7 @@ CONFIG_I2C_PARPORT_LIGHT=m
 CONFIG_I2C_TAOS_EVM=m
 CONFIG_I2C_STUB=m
 # CONFIG_HWMON is not set
-CONFIG_THERMAL=m
+CONFIG_THERMAL=y
 CONFIG_MFD_PCF50633=m
 CONFIG_PCF50633_ADC=m
 CONFIG_PCF50633_GPIO=m
diff --git a/arch/unicore32/configs/unicore32_defconfig b/arch/unicore32/configs/unicore32_defconfig
index aebd01fc28e5..360cc9abcdb0 100644
--- a/arch/unicore32/configs/unicore32_defconfig
+++ b/arch/unicore32/configs/unicore32_defconfig
@@ -119,7 +119,7 @@ CONFIG_I2C_PUV3=y
 #	Hardware Monitoring support
 #CONFIG_SENSORS_LM75=m
 #	Generic Thermal sysfs driver
-#CONFIG_THERMAL=m
+#CONFIG_THERMAL=y
 #CONFIG_THERMAL_HWMON=y
 
 #	Multimedia support
diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 653aa27a25a4..ccf5b9408d7a 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -3,7 +3,7 @@
 #
 
 menuconfig THERMAL
-	tristate "Generic Thermal sysfs driver"
+	bool "Generic Thermal sysfs driver"
 	help
 	  Generic Thermal Sysfs driver offers a generic mechanism for
 	  thermal management. Usually it's made up of one or more thermal
@@ -11,7 +11,7 @@ menuconfig THERMAL
 	  Each thermal zone contains its own temperature, trip points,
 	  cooling devices.
 	  All platforms with ACPI thermal support can use this driver.
-	  If you want this support, you should say Y or M here.
+	  If you want this support, you should say Y here.
 
 if THERMAL
 
-- 
2.17.1

