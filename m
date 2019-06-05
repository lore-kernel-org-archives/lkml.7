Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34879C282DE
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 09:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04A652075B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 09:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559726901;
	bh=O8jFUaIHNHhFCwSgoimMNeuJKeLFh5boOF6WLICbEpQ=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=K1Wy3UJpmM/cBzi0Vj+/HXHH+UJ05FeVKBFEbPo56DguywygDHgh5A+VwuR5lf/SG
	 NK58cj/nOnaOHNWkORlTyphLUTd9Qt+vjI7XV0lExWG5qiqSszesMvHRC9n2RY+joa
	 waCFWPPoTgQEP8DJLTNdDKz8gCExPXY93xQXqdRY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbfFEJ2U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 05:28:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:42446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726862AbfFEJ2U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 05:28:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1F8A20717;
        Wed,  5 Jun 2019 09:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559726899;
        bh=O8jFUaIHNHhFCwSgoimMNeuJKeLFh5boOF6WLICbEpQ=;
        h=Date:From:To:Cc:Subject:From;
        b=FiXrtfdl7Ez5iV/gHP9vjJGmvSqImAYHTPZMEwXuX9HgOC/7EXQ808E925fUEXosr
         iOb5iAspD+AXB3OFxxpTeLoITqiwdnamIjK7cQO3haA6ZcV5k4vUZpJ+fvUTFBm9k5
         FjZG1lzSn/o1kMfIytjRy87EU7xcqMFEKWY8rP2k=
Date:   Wed, 5 Jun 2019 11:28:16 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Felipe Balbi <felipe.balbi@linux.intel.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v2] USB: move usb debugfs directory creation to the usb
 common core
Message-ID: <20190605092816.GA23758@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The USB gadget subsystem wants to use the USB debugfs root directory, so
move it to the common "core" USB code so that it is properly initialized
and removed as needed.

In order to properly do this, we need to load the common code before the
usb core code, when everything is linked into the kernel, so reorder the
link order of the code.

Also as the usb common code has the possibility of the led trigger logic
to be merged into it, handle the build option properly by only having
one module init/exit function and have the common code initialize the
led trigger if needed.

Reported-by: From: Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---

Chunfeng, can you test this version to verify it works for you when
building the code into the kernel?

v2: handle led common code link error reported by kbuild
    handle subsys_initcall issue pointed out by Chunfeng

 drivers/usb/Makefile        |  3 +--
 drivers/usb/common/common.c | 21 +++++++++++++++++++++
 drivers/usb/common/common.h | 14 ++++++++++++++
 drivers/usb/common/led.c    |  9 +++------
 drivers/usb/core/usb.c      | 10 ++++------
 5 files changed, 43 insertions(+), 14 deletions(-)
 create mode 100644 drivers/usb/common/common.h

diff --git a/drivers/usb/Makefile b/drivers/usb/Makefile
index 7d1b8c82b208..ecc2de1ffaae 100644
--- a/drivers/usb/Makefile
+++ b/drivers/usb/Makefile
@@ -5,6 +5,7 @@
 
 # Object files in subdirectories
 
+obj-$(CONFIG_USB_COMMON)	+= common/
 obj-$(CONFIG_USB)		+= core/
 obj-$(CONFIG_USB_SUPPORT)	+= phy/
 
@@ -60,8 +61,6 @@ obj-$(CONFIG_USB_CHIPIDEA)	+= chipidea/
 obj-$(CONFIG_USB_RENESAS_USBHS)	+= renesas_usbhs/
 obj-$(CONFIG_USB_GADGET)	+= gadget/
 
-obj-$(CONFIG_USB_COMMON)	+= common/
-
 obj-$(CONFIG_USBIP_CORE)	+= usbip/
 
 obj-$(CONFIG_TYPEC)		+= typec/
diff --git a/drivers/usb/common/common.c b/drivers/usb/common/common.c
index 18f5dcf58b0d..84a4423aaddf 100644
--- a/drivers/usb/common/common.c
+++ b/drivers/usb/common/common.c
@@ -15,6 +15,8 @@
 #include <linux/usb/of.h>
 #include <linux/usb/otg.h>
 #include <linux/of_platform.h>
+#include <linux/debugfs.h>
+#include "common.h"
 
 static const char *const ep_type_names[] = {
 	[USB_ENDPOINT_XFER_CONTROL] = "ctrl",
@@ -291,4 +293,23 @@ struct device *usb_of_get_companion_dev(struct device *dev)
 EXPORT_SYMBOL_GPL(usb_of_get_companion_dev);
 #endif
 
+struct dentry *usb_debug_root;
+EXPORT_SYMBOL_GPL(usb_debug_root);
+
+static int usb_common_init(void)
+{
+	usb_debug_root = debugfs_create_dir("usb", NULL);
+	ledtrig_usb_init();
+	return 0;
+}
+
+static void usb_common_exit(void)
+{
+	ledtrig_usb_exit();
+	debugfs_remove_recursive(usb_debug_root);
+}
+
+subsys_initcall(usb_common_init);
+module_exit(usb_common_exit);
+
 MODULE_LICENSE("GPL");
diff --git a/drivers/usb/common/common.h b/drivers/usb/common/common.h
new file mode 100644
index 000000000000..424a91316a4b
--- /dev/null
+++ b/drivers/usb/common/common.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __LINUX_USB_COMMON_H
+#define __LINUX_USB_COMMON_H
+
+#if defined(CONFIG_USB_LED_TRIG)
+void ledtrig_usb_init(void);
+void ledtrig_usb_exit(void);
+#else
+static inline void ledtrig_usb_init(void) { }
+static inline void ledtrig_usb_exit(void) { }
+#endif
+
+#endif	/* __LINUX_USB_COMMON_H */
diff --git a/drivers/usb/common/led.c b/drivers/usb/common/led.c
index 7bd81166b77d..0865dd44a80a 100644
--- a/drivers/usb/common/led.c
+++ b/drivers/usb/common/led.c
@@ -10,6 +10,7 @@
 #include <linux/init.h>
 #include <linux/leds.h>
 #include <linux/usb.h>
+#include "common.h"
 
 #define BLINK_DELAY 30
 
@@ -36,18 +37,14 @@ void usb_led_activity(enum usb_led_event ev)
 EXPORT_SYMBOL_GPL(usb_led_activity);
 
 
-static int __init ledtrig_usb_init(void)
+void __init ledtrig_usb_init(void)
 {
 	led_trigger_register_simple("usb-gadget", &ledtrig_usb_gadget);
 	led_trigger_register_simple("usb-host", &ledtrig_usb_host);
-	return 0;
 }
 
-static void __exit ledtrig_usb_exit(void)
+void __exit ledtrig_usb_exit(void)
 {
 	led_trigger_unregister_simple(ledtrig_usb_gadget);
 	led_trigger_unregister_simple(ledtrig_usb_host);
 }
-
-module_init(ledtrig_usb_init);
-module_exit(ledtrig_usb_exit);
diff --git a/drivers/usb/core/usb.c b/drivers/usb/core/usb.c
index 7fcb9f782931..5a0df527a8ca 100644
--- a/drivers/usb/core/usb.c
+++ b/drivers/usb/core/usb.c
@@ -1185,19 +1185,17 @@ static struct notifier_block usb_bus_nb = {
 	.notifier_call = usb_bus_notify,
 };
 
-struct dentry *usb_debug_root;
-EXPORT_SYMBOL_GPL(usb_debug_root);
+static struct dentry *usb_devices_root;
 
 static void usb_debugfs_init(void)
 {
-	usb_debug_root = debugfs_create_dir("usb", NULL);
-	debugfs_create_file("devices", 0444, usb_debug_root, NULL,
-			    &usbfs_devices_fops);
+	usb_devices_root = debugfs_create_file("devices", 0444, usb_debug_root,
+					       NULL, &usbfs_devices_fops);
 }
 
 static void usb_debugfs_cleanup(void)
 {
-	debugfs_remove_recursive(usb_debug_root);
+	debugfs_remove(usb_devices_root);
 }
 
 /*
-- 
2.21.0

