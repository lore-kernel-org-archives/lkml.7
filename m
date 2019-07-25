Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90D7EC7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 13:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6088F2238C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 13:20:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="vWHBawv3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389858AbfGYNUM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 09:20:12 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51610 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389776AbfGYNUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 09:20:12 -0400
Received: by mail-wm1-f68.google.com with SMTP id 207so44992377wma.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 06:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o4s5mYhFtZl29VTDqSwCHcLENJRWZGEcESnpKK9TpyE=;
        b=vWHBawv33ZZ6U2Kf/1WV8az60+8PapAIgbjF4cRKP1SqiON9Sc9cUXurj2fsDId5eO
         +LBQZfXQcEmtfEeC1R5pEISJ4vJ4+PfM0J13CxHOuUjvfvV3uMDIJeMLQ+fR7x2z2TEd
         sGl/CfMK2zfHVvRcmyhNAYeumt99lUvwQ6J0bi8iJtBTYXgFUzgiZNsDq74HeUPC8uIe
         hDHd+6H9+6gnZhpu5Ha8Ysr09ciwPcFf6EJjrYEEQoS11HpZ2kqEPYsMCpHTiXItjqCa
         2B0weoEZ5Utu/OPtO280+QxfpG1Q3QK/dutrzbUNE35n+P5bK4xTZ2KtqpzI0oZUuThW
         2BgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o4s5mYhFtZl29VTDqSwCHcLENJRWZGEcESnpKK9TpyE=;
        b=TsbOR5OIGS+vMJTVW5YwYdAhMHt2cUawzeMUz2wuAqBcsb//OslQthiwXsg5LYYPEi
         TMQuDECX+/4Mv5vhE8K73t1WiLKZJckLZ+CYB91mEo+cJ4Nqd7aKNnQaJ2xplNz2IaWt
         vJ9lOUZMJ3mosH62dNGnTGJARGUW5W0JUaNGFVpWp2vHvXXdnqNSRVt3B4wI/5bMS/yi
         f4G8Fqrr9VwfugS3ZN77vgT0R6FEJyUfeXAnC4EvbHKzCDwRztUYfX5Umg12JmjuySCP
         lI8PFc9zJ56W7TTusJpwvERDM0JSjq9SNJNYW8bcWR/GdiyAyhQv62Yi1ldvvqgIzVfY
         Vj7Q==
X-Gm-Message-State: APjAAAWifEAEoi00YiIhfUeN0ptAcRvgBXOOuOLWmbdhNl0nHAoDFz9n
        TIpTrUt/2026Sk85BdxXQyg=
X-Google-Smtp-Source: APXvYqzAlpy7gYe9nIkhMAWD7UaqXx5H1UnY+8UcvvqFWqvBgfMOU5mP1w9Z79vNCNMuGs37+drGXg==
X-Received: by 2002:a1c:411:: with SMTP id 17mr74091953wme.74.1564060387102;
        Thu, 25 Jul 2019 06:13:07 -0700 (PDT)
Received: from localhost.localdomain ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id z7sm47119735wrh.67.2019.07.25.06.13.05
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Jul 2019 06:13:06 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Lechner <david@lechnology.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 4/5] ARM: davinci: support multiplatform build for ARM v5
Date:   Thu, 25 Jul 2019 15:12:56 +0200
Message-Id: <20190725131257.6142-5-brgl@bgdev.pl>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190725131257.6142-1-brgl@bgdev.pl>
References: <20190725131257.6142-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Add modifications necessary to make davinci part of the ARM v5
multiplatform build.

Move the arch-specific configuration out of arch/arm/Kconfig and
into mach-davinci/Kconfig. Remove the sub-menu for DaVinci
implementations (they'll be visible directly under the system type.
Select all necessary options not already selected by ARCH_MULTI_V5.
Update davinci_all_defconfig. Explicitly include the mach-specific
headers in mach-davinci/Makefile.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/Kconfig                       | 21 ---------------------
 arch/arm/configs/davinci_all_defconfig |  5 +++++
 arch/arm/mach-davinci/Kconfig          | 17 +++++++++++++----
 arch/arm/mach-davinci/Makefile         |  2 ++
 4 files changed, 20 insertions(+), 25 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 33b00579beff..013d4eefdf32 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -578,27 +578,6 @@ config ARCH_S3C24XX
 	  (<http://www.simtec.co.uk/products/EB110ITX/>), the IPAQ 1940 or the
 	  Samsung SMDK2410 development board (and derivatives).
 
-config ARCH_DAVINCI
-	bool "TI DaVinci"
-	select ARCH_HAS_HOLES_MEMORYMODEL
-	select COMMON_CLK
-	select CPU_ARM926T
-	select GENERIC_ALLOCATOR
-	select GENERIC_CLOCKEVENTS
-	select GENERIC_IRQ_CHIP
-	select GENERIC_IRQ_MULTI_HANDLER
-	select GPIOLIB
-	select HAVE_IDE
-	select PM_GENERIC_DOMAINS if PM
-	select PM_GENERIC_DOMAINS_OF if PM && OF
-	select REGMAP_MMIO
-	select RESET_CONTROLLER
-	select SPARSE_IRQ
-	select USE_OF
-	select ZONE_DMA
-	help
-	  Support for TI's DaVinci platform.
-
 config ARCH_OMAP1
 	bool "TI OMAP1"
 	depends on MMU
diff --git a/arch/arm/configs/davinci_all_defconfig b/arch/arm/configs/davinci_all_defconfig
index 9a32a8c0f873..b34970ce6b31 100644
--- a/arch/arm/configs/davinci_all_defconfig
+++ b/arch/arm/configs/davinci_all_defconfig
@@ -17,6 +17,9 @@ CONFIG_MODVERSIONS=y
 CONFIG_PARTITION_ADVANCED=y
 # CONFIG_IOSCHED_DEADLINE is not set
 # CONFIG_IOSCHED_CFQ is not set
+CONFIG_ARCH_MULTIPLATFORM=y
+CONFIG_ARCH_MULTI_V7=n
+CONFIG_ARCH_MULTI_V5=y
 CONFIG_ARCH_DAVINCI=y
 CONFIG_ARCH_DAVINCI_DM644x=y
 CONFIG_ARCH_DAVINCI_DM355=y
@@ -129,9 +132,11 @@ CONFIG_SPI=y
 CONFIG_SPI_DAVINCI=m
 CONFIG_PINCTRL_DA850_PUPD=m
 CONFIG_PINCTRL_SINGLE=y
+CONFIG_GPIOLIB=y
 CONFIG_GPIO_SYSFS=y
 CONFIG_GPIO_PCA953X=y
 CONFIG_GPIO_PCA953X_IRQ=y
+CONFIG_RESET_CONTROLLER=y
 CONFIG_POWER_RESET=y
 CONFIG_POWER_RESET_GPIO=y
 CONFIG_SYSCON_REBOOT_MODE=m
diff --git a/arch/arm/mach-davinci/Kconfig b/arch/arm/mach-davinci/Kconfig
index 5a59cebc7d0a..dd427bd2768c 100644
--- a/arch/arm/mach-davinci/Kconfig
+++ b/arch/arm/mach-davinci/Kconfig
@@ -1,11 +1,22 @@
 # SPDX-License-Identifier: GPL-2.0
+
+menuconfig ARCH_DAVINCI
+	bool "TI DaVinci"
+	depends on ARCH_MULTI_V5
+	select DAVINCI_TIMER
+	select ZONE_DMA
+	select ARCH_HAS_HOLES_MEMORYMODEL
+	select PM_GENERIC_DOMAINS if PM
+	select PM_GENERIC_DOMAINS_OF if PM && OF
+	select REGMAP_MMIO
+	select HAVE_IDE
+	select PINCTRL_SINGLE
+
 if ARCH_DAVINCI
 
 config ARCH_DAVINCI_DMx
 	bool
 
-menu "TI DaVinci Implementations"
-
 comment "DaVinci Core Type"
 
 config ARCH_DAVINCI_DM644x
@@ -225,6 +236,4 @@ config DAVINCI_MUX_WARNINGS
 	  to change the pin multiplexing setup. When there are no warnings
 	  printed, it's safe to deselect DAVINCI_MUX for your product.
 
-endmenu
-
 endif
diff --git a/arch/arm/mach-davinci/Makefile b/arch/arm/mach-davinci/Makefile
index f76a8482784f..a03d8443ef08 100644
--- a/arch/arm/mach-davinci/Makefile
+++ b/arch/arm/mach-davinci/Makefile
@@ -4,6 +4,8 @@
 #
 #
 
+ccflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/$(src)/include
+
 # Common objects
 obj-y 					:= time.o serial.o usb.o \
 					   common.o sram.o
-- 
2.21.0

