Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87926C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 15:20:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 647372084B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 15:20:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728144AbfFDPUr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 11:20:47 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:43012 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727800AbfFDPUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 11:20:42 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id EA732285368
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     gwendal@chromium.org, Guenter Roeck <groeck@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Lee Jones <lee.jones@linaro.org>, kernel@collabora.com,
        dtor@chromium.org
Subject: [PATCH 05/10] mfd / platform: cros_ec: Rename config to a better name
Date:   Tue,  4 Jun 2019 17:20:14 +0200
Message-Id: <20190604152019.16100-6-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190604152019.16100-1-enric.balletbo@collabora.com>
References: <20190604152019.16100-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cros-ec-dev is a multifunction device that now doesn't implement any
chardev communication interface. MFD_CROS_EC_CHARDEV doesn't look
a good name to describe that device and can cause confusion. Hence
rename it to CROS_EC_DEV.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 drivers/mfd/Kconfig             | 16 ++++++++++------
 drivers/mfd/Makefile            |  2 +-
 drivers/platform/chrome/Kconfig | 20 ++++++++++----------
 3 files changed, 21 insertions(+), 17 deletions(-)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index ad0a5de74ef2..5137253533da 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -211,14 +211,18 @@ config MFD_AXP20X_RSB
 	  components like regulators or the PEK (Power Enable Key) under the
 	  corresponding menus.
 
-config MFD_CROS_EC_CHARDEV
-	tristate "Chrome OS Embedded Controller userspace device interface"
+config MFD_CROS_EC_DEV
+	tristate "ChromeOS Embedded Controller multifunction device"
+	select MFD_CORE
 	depends on CROS_EC
-	---help---
-	  This driver adds support to talk with the ChromeOS EC from userspace.
+	default CROS_EC
+	help
+	  Select this to get support for ChromeOS Embedded Controller
+	  sub-devices. This driver will instantiate additional drivers such
+	  as RTC, USBPD, etc. but you have to select the individual drivers.
 
-	  If you have a supported Chromebook, choose Y or M here.
-	  The module will be called cros_ec_dev.
+	  To compile this driver as a module, choose M here: the module will be
+	  called cros-ec-dev.
 
 config MFD_MADERA
 	tristate "Cirrus Logic Madera codecs"
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 32327dc6bb45..7d2bb3f98894 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -13,7 +13,7 @@ obj-$(CONFIG_MFD_ASIC3)		+= asic3.o tmio_core.o
 obj-$(CONFIG_ARCH_BCM2835)	+= bcm2835-pm.o
 obj-$(CONFIG_MFD_BCM590XX)	+= bcm590xx.o
 obj-$(CONFIG_MFD_BD9571MWV)	+= bd9571mwv.o
-obj-$(CONFIG_MFD_CROS_EC_CHARDEV) += cros_ec_dev.o
+obj-$(CONFIG_MFD_CROS_EC_DEV)	+= cros_ec_dev.o
 obj-$(CONFIG_MFD_EXYNOS_LPASS)	+= exynos-lpass.o
 
 obj-$(CONFIG_HTC_PASIC3)	+= htc-pasic3.o
diff --git a/drivers/platform/chrome/Kconfig b/drivers/platform/chrome/Kconfig
index 3a9ad001838a..23f09ff0f72e 100644
--- a/drivers/platform/chrome/Kconfig
+++ b/drivers/platform/chrome/Kconfig
@@ -149,8 +149,8 @@ config CROS_KBD_LED_BACKLIGHT
 
 config CROS_EC_CHARDEV
 	tristate "ChromeOS EC miscdevice"
-	depends on MFD_CROS_EC_CHARDEV
-	default MFD_CROS_EC_CHARDEV
+	depends on MFD_CROS_EC_DEV
+	default MFD_CROS_EC_DEV
 	help
 	  This driver adds file operations support to talk with the
 	  ChromeOS EC from userspace via a character device.
@@ -160,8 +160,8 @@ config CROS_EC_CHARDEV
 
 config CROS_EC_LIGHTBAR
 	tristate "Chromebook Pixel's lightbar support"
-	depends on MFD_CROS_EC_CHARDEV
-	default MFD_CROS_EC_CHARDEV
+	depends on MFD_CROS_EC_DEV
+	default MFD_CROS_EC_DEV
 	help
 	  This option exposes the Chromebook Pixel's lightbar to
 	  userspace.
@@ -171,8 +171,8 @@ config CROS_EC_LIGHTBAR
 
 config CROS_EC_VBC
 	tristate "ChromeOS EC vboot context support"
-	depends on MFD_CROS_EC_CHARDEV && OF
-	default MFD_CROS_EC_CHARDEV
+	depends on MFD_CROS_EC_DEV && OF
+	default MFD_CROS_EC_DEV
 	help
 	  This option exposes the ChromeOS EC vboot context nvram to
 	  userspace.
@@ -182,8 +182,8 @@ config CROS_EC_VBC
 
 config CROS_EC_DEBUGFS
 	tristate "Export ChromeOS EC internals in DebugFS"
-	depends on MFD_CROS_EC_CHARDEV && DEBUG_FS
-	default MFD_CROS_EC_CHARDEV
+	depends on MFD_CROS_EC_DEV && DEBUG_FS
+	default MFD_CROS_EC_DEV
 	help
 	  This option exposes the ChromeOS EC device internals to
 	  userspace.
@@ -193,8 +193,8 @@ config CROS_EC_DEBUGFS
 
 config CROS_EC_SYSFS
 	tristate "ChromeOS EC control and information through sysfs"
-	depends on MFD_CROS_EC_CHARDEV && SYSFS
-	default MFD_CROS_EC_CHARDEV
+	depends on MFD_CROS_EC_DEV && SYSFS
+	default MFD_CROS_EC_DEV
 	help
 	  This option exposes some sysfs attributes to control and get
 	  information from ChromeOS EC.
-- 
2.20.1

