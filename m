Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F4AC282DD
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 09:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AAE8205C9
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 09:24:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MlgI9WL5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727400AbfDTJW7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 05:22:59 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:43007 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbfDTJW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 05:22:58 -0400
Received: by mail-yb1-f193.google.com with SMTP id l124so2773370ybf.9
        for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2019 02:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=BYjcsNJcuw4q/Jhj44nu6gzyDj3UcYUDVGhp84fiC3A=;
        b=MlgI9WL5ivL9GxAbM+LqJD9slg+s/RyPYP+cj9fHD1ClfMJ2n2eWLTlI1CjDsznkuw
         rRNAyrr6Cr7dP8OP1G5XVamL2IlzYY5JJAJHsLP/EoqBFhJHn/quz/l84heJwBNTXQNy
         lXe+KDwLJ8pcxzfrFWSTgb3dSr2/n5o8bj2JsyoXn8XnsSEkIz/3gE4A5+ac8jO/Wo1c
         k30skJ4Yteam7OAAyUtGvrd5x5jM3V0z1uS48PaGM5rs3f4XEgJpW8i793jc1oNR5pps
         a7cpe22xozGWDwuzCUdHlA2YCu00aIQVSPkF7+IaeZK6veinyNHQvKNOxQm8sx4m31m6
         X6FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BYjcsNJcuw4q/Jhj44nu6gzyDj3UcYUDVGhp84fiC3A=;
        b=YKICd9Pid9GuOFDwaQnmTkaXQJFjGRfuCEU5RoguyAioEV5Xker0pKONzaBi2bRINP
         OouU5TtGDvkw/cC8KHobQ08lq/v4AnrzSDldRaetXNtmrb64DeI6+e2nfvTUbQehUumP
         zz2w0y/nTiJStqX6EZSVxGdvBgye14kllkdBBz0GVYVKc3y2WQENDUArlNxTp3zFnPBa
         sv+n7JDTfzXM+pGMeivoI69mtacNVBq2+Y0oyKMt4OP72drZhXN/6Xte0gvirU2AMs3x
         dvsIHByCX2waQr81VipuY/oaqCi9JWh92tANERrSVmS0pYoQSL/O1KWqPKKq6/zJDm3h
         TvMw==
X-Gm-Message-State: APjAAAVYtL+mCf49uVBuzbZD0+gYlbWWcNoLH9luLOoFG75MbHdwEc4J
        c+TG/yRuV/0t9pYFSkxid2k=
X-Google-Smtp-Source: APXvYqxH/+d/NnxApgjR2+28orgcDtWHB+F71EH3/nmG+/TxKt0RNoh270ErLKXNzyTupXL6prDQig==
X-Received: by 2002:a5b:9d0:: with SMTP id y16mr7093310ybq.323.1555752177124;
        Sat, 20 Apr 2019 02:22:57 -0700 (PDT)
Received: from localhost.localdomain ([117.204.45.231])
        by smtp.gmail.com with ESMTPSA id s127sm3484380yws.66.2019.04.20.02.22.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Apr 2019 02:22:56 -0700 (PDT)
From:   MosesChristopher <moseschristopherb@gmail.com>
To:     johan@kernel.org, elder@kernel.org, gregkh@linuxfoundation.org
Cc:     greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Moses Christopher <moseschristopherb@gmail.com>
Subject: [PATCH] staging: greybus: use help instead of ---help--- in Kconfig
Date:   Sat, 20 Apr 2019 09:21:49 +0000
Message-Id: <20190420092149.14763-1-moseschristopherb@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Moses Christopher <moseschristopherb@gmail.com>

      - Resolve the following warning from the Kconfig,
        "WARNING: prefer 'help' over '---help---' for new help texts"

Signed-off-by: Moses Christopher <moseschristopherb@gmail.com>
---
 drivers/staging/greybus/Kconfig | 44 ++++++++++++++++++++---------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/staging/greybus/Kconfig b/drivers/staging/greybus/Kconfig
index b571e4e8060b..2f5061b565a6 100644
--- a/drivers/staging/greybus/Kconfig
+++ b/drivers/staging/greybus/Kconfig
@@ -1,7 +1,7 @@
 menuconfig GREYBUS
 	tristate "Greybus support"
 	depends on SYSFS
-	---help---
+	help
 	  This option enables the Greybus driver core.  Greybus is an
 	  hardware protocol that was designed to provide Unipro with a
 	  sane application layer.  It was originally designed for the
@@ -19,7 +19,7 @@ if GREYBUS
 config GREYBUS_ES2
 	tristate "Greybus ES3 USB host controller"
 	depends on USB
-	---help---
+	help
 	  Select this option if you have a Toshiba ES3 USB device that
 	  acts as a Greybus "host controller".  This device is a bridge
 	  from a USB device to a Unipro network.
@@ -30,7 +30,7 @@ config GREYBUS_ES2
 config GREYBUS_AUDIO
 	tristate "Greybus Audio Class driver"
 	depends on SOUND
-	---help---
+	help
 	  Select this option if you have a device that follows the
 	  Greybus Audio Class specification.
 
@@ -39,7 +39,7 @@ config GREYBUS_AUDIO
 
 config GREYBUS_BOOTROM
 	tristate "Greybus Bootrom Class driver"
-	---help---
+	help
 	  Select this option if you have a device that follows the
 	  Greybus Bootrom Class specification.
 
@@ -49,7 +49,7 @@ config GREYBUS_BOOTROM
 config GREYBUS_CAMERA
 	tristate "Greybus Camera Class driver"
 	depends on MEDIA_SUPPORT && LEDS_CLASS_FLASH && BROKEN
-	---help---
+	help
 	  Select this option if you have a device that follows the
 	  Greybus Camera Class specification.
 
@@ -59,7 +59,7 @@ config GREYBUS_CAMERA
 config GREYBUS_FIRMWARE
 	tristate "Greybus Firmware Download Class driver"
 	depends on SPI
-	---help---
+	help
 	  Select this option if you have a device that follows the
 	  Greybus Firmware Download Class specification.
 
@@ -69,7 +69,7 @@ config GREYBUS_FIRMWARE
 config GREYBUS_HID
 	tristate "Greybus HID Class driver"
 	depends on HID && INPUT
-	---help---
+	help
 	  Select this option if you have a device that follows the
 	  Greybus HID Class specification.
 
@@ -79,7 +79,7 @@ config GREYBUS_HID
 config GREYBUS_LIGHT
 	tristate "Greybus LED Class driver"
 	depends on LEDS_CLASS
-	---help---
+	help
 	  Select this option if you have a device that follows the
 	  Greybus LED Class specification.
 
@@ -88,7 +88,7 @@ config GREYBUS_LIGHT
 
 config GREYBUS_LOG
 	tristate "Greybus Debug Log Class driver"
-	---help---
+	help
 	  Select this option if you have a device that follows the
 	  Greybus Debug Log Class specification.
 
@@ -97,7 +97,7 @@ config GREYBUS_LOG
 
 config GREYBUS_LOOPBACK
 	tristate "Greybus Loopback Class driver"
-	---help---
+	help
 	  Select this option if you have a device that follows the
 	  Greybus Debug Log Class specification.
 
@@ -107,7 +107,7 @@ config GREYBUS_LOOPBACK
 config GREYBUS_POWER
 	tristate "Greybus Powersupply Class driver"
 	depends on POWER_SUPPLY
-	---help---
+	help
 	  Select this option if you have a device that follows the
 	  Greybus Powersupply Class specification.
 
@@ -116,7 +116,7 @@ config GREYBUS_POWER
 
 config GREYBUS_RAW
 	tristate "Greybus Raw Class driver"
-	---help---
+	help
 	  Select this option if you have a device that follows the
 	  Greybus Raw Class specification.
 
@@ -125,7 +125,7 @@ config GREYBUS_RAW
 
 config GREYBUS_VIBRATOR
 	tristate "Greybus Vibrator Motor Class driver"
-	---help---
+	help
 	  Select this option if you have a device that follows the
 	  Greybus Vibrator Motor Class specification.
 
@@ -134,7 +134,7 @@ config GREYBUS_VIBRATOR
 
 menuconfig GREYBUS_BRIDGED_PHY
 	tristate "Greybus Bridged PHY Class drivers"
-	---help---
+	help
 	  Select this option to pick from a variety of Greybus Bridged
 	  PHY class drivers.  These drivers emulate a number of
 	  different "traditional" busses by tunneling them over Greybus.
@@ -149,7 +149,7 @@ config GREYBUS_GPIO
 	tristate "Greybus GPIO Bridged PHY driver"
 	depends on GPIOLIB
 	select GPIOLIB_IRQCHIP
-	---help---
+	help
 	  Select this option if you have a device that follows the
 	  Greybus GPIO Bridged PHY Class specification.
 
@@ -159,7 +159,7 @@ config GREYBUS_GPIO
 config GREYBUS_I2C
 	tristate "Greybus I2C Bridged PHY driver"
 	depends on I2C
-	---help---
+	help
 	  Select this option if you have a device that follows the
 	  Greybus I2C Bridged PHY Class specification.
 
@@ -169,7 +169,7 @@ config GREYBUS_I2C
 config GREYBUS_PWM
 	tristate "Greybus PWM Bridged PHY driver"
 	depends on PWM
-	---help---
+	help
 	  Select this option if you have a device that follows the
 	  Greybus PWM Bridged PHY Class specification.
 
@@ -179,7 +179,7 @@ config GREYBUS_PWM
 config GREYBUS_SDIO
 	tristate "Greybus SDIO Bridged PHY driver"
 	depends on MMC
-	---help---
+	help
 	  Select this option if you have a device that follows the
 	  Greybus SDIO Bridged PHY Class specification.
 
@@ -189,7 +189,7 @@ config GREYBUS_SDIO
 config GREYBUS_SPI
 	tristate "Greybus SPI Bridged PHY driver"
 	depends on SPI
-	---help---
+	help
 	  Select this option if you have a device that follows the
 	  Greybus SPI Bridged PHY Class specification.
 
@@ -199,7 +199,7 @@ config GREYBUS_SPI
 config GREYBUS_UART
 	tristate "Greybus UART Bridged PHY driver"
 	depends on TTY
-	---help---
+	help
 	  Select this option if you have a device that follows the
 	  Greybus UART Bridged PHY Class specification.
 
@@ -209,7 +209,7 @@ config GREYBUS_UART
 config GREYBUS_USB
 	tristate "Greybus USB Host Bridged PHY driver"
 	depends on USB
-	---help---
+	help
 	  Select this option if you have a device that follows the
 	  Greybus USB Host Bridged PHY Class specification.
 
@@ -221,7 +221,7 @@ endif	# GREYBUS_BRIDGED_PHY
 config GREYBUS_ARCHE
 	tristate "Greybus Arche Platform driver"
 	depends on USB_HSIC_USB3613 || COMPILE_TEST
-	---help---
+	help
 	  Select this option if you have an Arche device.
 
 	  To compile this code as a module, chose M here: the module
-- 
2.11.0

