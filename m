Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F88C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 18:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA65F204FD
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 18:49:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387555AbfCASsv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 13:48:51 -0500
Received: from unicorn.mansr.com ([81.2.72.234]:56170 "EHLO unicorn.mansr.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726195AbfCASsv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 13:48:51 -0500
Received: by unicorn.mansr.com (Postfix, from userid 51770)
        id 5FC1515632; Fri,  1 Mar 2019 18:48:40 +0000 (GMT)
From:   Mans Rullgard <mans@mansr.com>
To:     Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] auxdisplay: deconfuse configuration
Date:   Fri,  1 Mar 2019 18:48:14 +0000
Message-Id: <20190301184816.784-1-mans@mansr.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The auxdisplay Kconfig is confusing.  It creates two separate menus
even though the settings are closely related.  Moreover, the options
for setting the boot message depend on CONFIG_PARPORT even though they
are used by drivers that do not.

Clear up the confustion by moving the "Parallel port LCD/Keypad" menu
under auxdisplay where it logically belongs.  Change the boot message
options to depend only on CONFIG_CHARLCD, making them accessible also
when only the HD44780 is selected.

Since the "Parallel port LCD/Keypad" driver now has a new dependency
on CONFIG_AUXDISPLAY, rename its Kconfig symbol and keep the old one
such that make oldconfig will not disable the driver.

Signed-off-by: Mans Rullgard <mans@mansr.com>
---
 drivers/auxdisplay/Kconfig  | 17 ++++++++++++-----
 drivers/auxdisplay/Makefile |  2 +-
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/auxdisplay/Kconfig b/drivers/auxdisplay/Kconfig
index 57410f9c5d44..7d3fe27d6868 100644
--- a/drivers/auxdisplay/Kconfig
+++ b/drivers/auxdisplay/Kconfig
@@ -164,9 +164,7 @@ config ARM_CHARLCD
 	  line and the Linux version on the second line, but that's
 	  still useful.
 
-endif # AUXDISPLAY
-
-menuconfig PANEL
+menuconfig PARPORT_PANEL
 	tristate "Parallel port LCD/Keypad Panel support"
 	depends on PARPORT
 	select CHARLCD
@@ -178,7 +176,7 @@ menuconfig PANEL
 	  compiled as a module, or linked into the kernel and started at boot.
 	  If you don't understand what all this is about, say N.
 
-if PANEL
+if PARPORT_PANEL
 
 config PANEL_PARPORT
 	int "Default parallel port number (0=LPT1)"
@@ -419,8 +417,11 @@ config PANEL_LCD_PIN_BL
 
 	  Default for the 'BL' pin in custom profile is '0' (uncontrolled).
 
+endif # PARPORT_PANEL
+
 config PANEL_CHANGE_MESSAGE
 	bool "Change LCD initialization message ?"
+	depends on CHARLCD
 	default "n"
 	---help---
 	  This allows you to replace the boot message indicating the kernel version
@@ -444,7 +445,13 @@ config PANEL_BOOT_MESSAGE
 	  An empty message will only clear the display at driver init time. Any other
 	  printf()-formatted message is valid with newline and escape codes.
 
-endif # PANEL
+endif # AUXDISPLAY
+
+config PANEL
+	tristate "Parallel port LCD/Keypad Panel support (OLD OPTION)"
+	depends on PARPORT
+	select AUXDISPLAY
+	select PARPORT_PANEL
 
 config CHARLCD
 	tristate "Character LCD core support" if COMPILE_TEST
diff --git a/drivers/auxdisplay/Makefile b/drivers/auxdisplay/Makefile
index 7ac6776ca3f6..cf54b5efb07e 100644
--- a/drivers/auxdisplay/Makefile
+++ b/drivers/auxdisplay/Makefile
@@ -10,4 +10,4 @@ obj-$(CONFIG_CFAG12864B)	+= cfag12864b.o cfag12864bfb.o
 obj-$(CONFIG_IMG_ASCII_LCD)	+= img-ascii-lcd.o
 obj-$(CONFIG_HD44780)		+= hd44780.o
 obj-$(CONFIG_HT16K33)		+= ht16k33.o
-obj-$(CONFIG_PANEL)             += panel.o
+obj-$(CONFIG_PARPORT_PANEL)	+= panel.o
-- 
2.20.1

