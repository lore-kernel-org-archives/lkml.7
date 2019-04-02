Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F970C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD5C3206BA
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:13:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FFy/4Wm+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729813AbfDBQN3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 12:13:29 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36721 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729086AbfDBQN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 12:13:29 -0400
Received: by mail-wm1-f66.google.com with SMTP id h18so4492766wml.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 09:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=xKY+ceGe4SnC6doIZkUhD6Dozc5uLu/ZgR2u3m//Do4=;
        b=FFy/4Wm+LurbVt0OXlOunKKi3T2Cm7VPBBPp4er2zxXCSFig3++1KgZ67Lc5P4SQZx
         PpQ+KNac1FSpIn9HYi0FW3hO6XWvHCMwyw03VFY4295APSPJGzFRIQltm2xvzp6jC6Q4
         V5pjK8XvvlJgadjNwoCFISAkobOv9L54qyBmJu5lopHqR0D067HpOjDGTgJj4HQTFtIJ
         UFu+wHh34k0Kimu1DvxXhD0PtA2QUbQJ7nrbmjgdk+NwFAkZAlPXBBnHPv/vAkiNyyit
         omL4C9rI/LByQtXK7NTPYCLs43V8XSm6V4yBxzCRcWf0oTAN8+hJnFxUjDtP8qUtTN4S
         9/lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xKY+ceGe4SnC6doIZkUhD6Dozc5uLu/ZgR2u3m//Do4=;
        b=qSFMBaIeYmqVHweVNg9laL3KXc0Gwj8DRrsxoSguQ8S8RS9qSZ4vKG7gWMvgur7W2g
         6CkWaPbOgz48OeZGRsqqyh2H0+zArLO8Yt402uI/MVz3WTa1dSkzFnpRECDdzeiMBwoB
         Th4Zr1H3e+kvLOSLdndXwQ+sppSJTeDZI0jw0rfM9QBcDiVYTbLhZO5aKf/b7QOV/7Rb
         BYPmrD6gNii89CZSaL4wbM+ZFi3Y1ywQzDq3R+sFxLU+GUUL8B9vKcr2TSZfTqzYEczh
         U1zV+B+F8jdVF7znn4g3HYZQdjsx3gSjQHi9qQpoyI5CEbM/biQ0wrctLu9Vzelpf1+i
         lOCQ==
X-Gm-Message-State: APjAAAV0zQ0Dy/TFxU5hdbOTyl4qYCofDXxo6P0QRVQZfQaISUFzRkBC
        f+KruxfW6EL5JCQow+uQvtu9vw==
X-Google-Smtp-Source: APXvYqzoObTo7zPJvBtCd59aQgny5Hx5j84Tue4t437siGlAblkQSZFM3HK85Cl0JhFmHM0F82HGMA==
X-Received: by 2002:a1c:c18d:: with SMTP id r135mr4126832wmf.112.1554221606503;
        Tue, 02 Apr 2019 09:13:26 -0700 (PDT)
Received: from mai.imgcgcw.net (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.gmail.com with ESMTPSA id a126sm17054999wmh.4.2019.04.02.09.13.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Apr 2019 09:13:25 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rui.zhang@intel.com, edubezval@gmail.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <groeck@chromium.org>,
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
        linux-arm-kernel@lists.infradead.org (moderated list:ARM PORT),
        linux-mips@vger.kernel.org (open list:MIPS)
Subject: [PATCH 1/7] thermal/drivers/core: Remove the module Kconfig's option
Date:   Tue,  2 Apr 2019 18:12:44 +0200
Message-Id: <20190402161256.11044-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The module support for the thermal subsystem makes little sense:
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
Acked-by: Guenter Roeck <groeck@chromium.org>
For mini2440:
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
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

