Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF90CC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 12:29:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 762712085A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 12:29:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="cJ31JBsU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727203AbfCRM3K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 08:29:10 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34504 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbfCRM3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 08:29:08 -0400
Received: by mail-wr1-f66.google.com with SMTP id k1so16351763wre.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 05:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DO1z0u/OGAKzBJvOGOCFOqGEzFjL4ovxKinkepShL1c=;
        b=cJ31JBsUt3zlxsh7mDLZPov/0YbuWV71MZXbptWlCzYiOhURS+tWKLLnKe3p2Uj0o0
         sOyJ8323MLdPyKPR72r4bYtwxr+w4u/TbmJZr2mRvowkAibwRQ6ail5iHUFmCCrTjLXd
         R7HwEhlKftOcIYIbL+0AwRC7O1nxFEP2zGVl13L1AU31w1EOeI/rwU/ZeptxMZvIa0i7
         8PpI6Dbp++MsbzOvGWqNGIIq7/UDZLUnt9oE4NSgy3DnRh+tWeyduT5332L9CaW3HM9G
         JND7JMJ1VDzRReJhBdoBdJef0yWax7DKjJtFarfCVIxZaeoh8hFVK5oJwsrJN4eizWaw
         59NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DO1z0u/OGAKzBJvOGOCFOqGEzFjL4ovxKinkepShL1c=;
        b=h58XqSbQXjVdcVw6snp6Cs7EdfDRjqocrrmTAScXaBrTvR5S1i5In+vNnlQMR0CYZP
         OnglUqL85O5TW0enZ0c6aggSVNT1+2P9bYHYTeziuCz5uDqdUfj6m2cGyfw8OFd889g5
         5bfebmoQGZTqjtC4ZC1ddJadNqcuk2mARLMDLHenb/tNnfauHBQUl7qC+Mw5BiS9sFKY
         lxMdMuJDXyLzczgqlBlvy0Af1W6vyynpirq46tvL4D/3nJAmbg8xYjn4JG9qVZYcqblL
         x8vt+F1cu+JLTCL9EcZdze7yPnRmNYN8dAY9YXv3uykbqB3xBMiGpifnmov83i3ILstQ
         JMIA==
X-Gm-Message-State: APjAAAX+YEb+of9St6U/XZrx9nwSNFoYLWE0wfvCm35Hbv2NllyKw4X8
        EdkAtDeHSao6shVj67CSRu2LBQ==
X-Google-Smtp-Source: APXvYqzvQWOc4EjgmodXU2RBYM4zE/Uhz6gwTPNWKxheb3WySunZN6g2wGjbfG6Gtyo+MZWROQG1+A==
X-Received: by 2002:adf:f487:: with SMTP id l7mr11353454wro.86.1552912146149;
        Mon, 18 Mar 2019 05:29:06 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id v13sm2368112wmj.43.2019.03.18.05.29.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 05:29:05 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Lechner <david@lechnology.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [RESEND PATCH 1/2] ARM: davinci: support multiplatform build for ARM v5
Date:   Mon, 18 Mar 2019 13:29:00 +0100
Message-Id: <20190318122901.7231-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190318122901.7231-1-brgl@bgdev.pl>
References: <20190318122901.7231-1-brgl@bgdev.pl>
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
 arch/arm/mach-davinci/Kconfig          | 16 ++++++++++++----
 arch/arm/mach-davinci/Makefile         |  2 ++
 4 files changed, 19 insertions(+), 25 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index f893798e13d3..01be980ee5d0 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -583,27 +583,6 @@ config ARCH_S3C24XX
 	  (<http://www.simtec.co.uk/products/EB110ITX/>), the IPAQ 1940 or the
 	  Samsung SMDK2410 development board (and derivatives).
 
-config ARCH_DAVINCI
-	bool "TI DaVinci"
-	select ARCH_HAS_HOLES_MEMORYMODEL
-	select COMMON_CLK
-	select CPU_ARM926T
-	select DAVINCI_TIMER
-	select GENERIC_ALLOCATOR
-	select GENERIC_CLOCKEVENTS
-	select GENERIC_IRQ_CHIP
-	select GENERIC_IRQ_MULTI_HANDLER
-	select GPIOLIB
-	select HAVE_IDE
-	select PM_GENERIC_DOMAINS if PM
-	select PM_GENERIC_DOMAINS_OF if PM && OF
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
index 207962a656a2..bbf285dd63e4 100644
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
@@ -128,9 +131,11 @@ CONFIG_SPI=y
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
index 5a59cebc7d0a..ba6d55590b9d 100644
--- a/arch/arm/mach-davinci/Kconfig
+++ b/arch/arm/mach-davinci/Kconfig
@@ -1,11 +1,21 @@
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
@@ -225,6 +235,4 @@ config DAVINCI_MUX_WARNINGS
 	  to change the pin multiplexing setup. When there are no warnings
 	  printed, it's safe to deselect DAVINCI_MUX for your product.
 
-endmenu
-
 endif
diff --git a/arch/arm/mach-davinci/Makefile b/arch/arm/mach-davinci/Makefile
index d9af8c0c0b87..58838a9de651 100644
--- a/arch/arm/mach-davinci/Makefile
+++ b/arch/arm/mach-davinci/Makefile
@@ -4,6 +4,8 @@
 #
 #
 
+ccflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/$(src)/include
+
 # Common objects
 obj-y 					:= serial.o usb.o common.o sram.o
 
-- 
2.20.1

