Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59BFFC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 07:34:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C2A5249F4
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 07:34:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbfFDHeb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 03:34:31 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:38643 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726589AbfFDHe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 03:34:29 -0400
X-UUID: 279c78d53c2e4bb39aa67cc19e446483-20190604
X-UUID: 279c78d53c2e4bb39aa67cc19e446483-20190604
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 555060999; Tue, 04 Jun 2019 15:34:16 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 4 Jun 2019 15:34:15 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 4 Jun 2019 15:34:13 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH v4] usb: create usb_debug_root for gadget only
Date:   Tue, 4 Jun 2019 15:34:07 +0800
Message-ID: <1559633647-29040-1-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_USB is not set, and CONFIG_USB_GADGET is set,
there is an issue, e.g.:

drivers/usb/mtu3/mtu3_debugfs.o: in function 'ssusb_debugfs_create_root':
mtu3_debugfs.c:(.text+0xba3): undefined reference to 'usb_debug_root'

usb_debug_root is currently only built when host is supported
(CONFIG_USB is set), for convenience, we also want it created when
gadget only is enabled, this patch try to support it.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
v4:
  move common API into common.c suggested by Felipe

v3:
  1. still create usb_debug_root for gadget only
  2. abandon mtu3's change
  3. drop acked-by Randy

v2(resend): add acked-by Randy

v1: fix mtu3's build error, replace usb_debug_root by NULL;
---
 drivers/usb/common/common.c   | 26 ++++++++++++++++++++++++++
 drivers/usb/core/usb.c        | 16 ++++------------
 drivers/usb/gadget/udc/core.c |  3 +++
 include/linux/usb.h           |  2 ++
 4 files changed, 35 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/common/common.c b/drivers/usb/common/common.c
index 18f5dcf58b0d..c52e9c9f58ec 100644
--- a/drivers/usb/common/common.c
+++ b/drivers/usb/common/common.c
@@ -15,6 +15,7 @@
 #include <linux/usb/of.h>
 #include <linux/usb/otg.h>
 #include <linux/of_platform.h>
+#include <linux/debugfs.h>
 
 static const char *const ep_type_names[] = {
 	[USB_ENDPOINT_XFER_CONTROL] = "ctrl",
@@ -139,6 +140,31 @@ enum usb_dr_mode usb_get_dr_mode(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(usb_get_dr_mode);
 
+struct dentry *usb_debug_root;
+EXPORT_SYMBOL_GPL(usb_debug_root);
+
+static atomic_t usb_debug_root_refcnt = ATOMIC_INIT(0);
+
+struct dentry *usb_debugfs_init(void)
+{
+	if (!usb_debug_root)
+		usb_debug_root = debugfs_create_dir("usb", NULL);
+
+	atomic_inc(&usb_debug_root_refcnt);
+
+	return usb_debug_root;
+}
+EXPORT_SYMBOL_GPL(usb_debugfs_init);
+
+void usb_debugfs_cleanup(void)
+{
+	if (atomic_dec_and_test(&usb_debug_root_refcnt)) {
+		debugfs_remove_recursive(usb_debug_root);
+		usb_debug_root = NULL;
+	}
+}
+EXPORT_SYMBOL_GPL(usb_debugfs_cleanup);
+
 #ifdef CONFIG_OF
 /**
  * of_usb_get_dr_mode_by_phy - Get dual role mode for the controller device
diff --git a/drivers/usb/core/usb.c b/drivers/usb/core/usb.c
index 7fcb9f782931..9d8db7faf75f 100644
--- a/drivers/usb/core/usb.c
+++ b/drivers/usb/core/usb.c
@@ -1185,19 +1185,11 @@ static struct notifier_block usb_bus_nb = {
 	.notifier_call = usb_bus_notify,
 };
 
-struct dentry *usb_debug_root;
-EXPORT_SYMBOL_GPL(usb_debug_root);
-
-static void usb_debugfs_init(void)
+static void usb_core_debugfs_init(void)
 {
-	usb_debug_root = debugfs_create_dir("usb", NULL);
-	debugfs_create_file("devices", 0444, usb_debug_root, NULL,
-			    &usbfs_devices_fops);
-}
+	struct dentry *root = usb_debugfs_init();
 
-static void usb_debugfs_cleanup(void)
-{
-	debugfs_remove_recursive(usb_debug_root);
+	debugfs_create_file("devices", 0444, root, NULL, &usbfs_devices_fops);
 }
 
 /*
@@ -1212,7 +1204,7 @@ static int __init usb_init(void)
 	}
 	usb_init_pool_max();
 
-	usb_debugfs_init();
+	usb_core_debugfs_init();
 
 	usb_acpi_register();
 	retval = bus_register(&usb_bus_type);
diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
index 7cf34beb50df..8ef000b9baa4 100644
--- a/drivers/usb/gadget/udc/core.c
+++ b/drivers/usb/gadget/udc/core.c
@@ -1597,12 +1597,15 @@ static int __init usb_udc_init(void)
 	}
 
 	udc_class->dev_uevent = usb_udc_uevent;
+	usb_debugfs_init();
+
 	return 0;
 }
 subsys_initcall(usb_udc_init);
 
 static void __exit usb_udc_exit(void)
 {
+	usb_debugfs_cleanup();
 	class_destroy(udc_class);
 }
 module_exit(usb_udc_exit);
diff --git a/include/linux/usb.h b/include/linux/usb.h
index ae82d9d1112b..175e4a0b1847 100644
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -1995,6 +1995,8 @@ extern void usb_unregister_notify(struct notifier_block *nb);
 
 /* debugfs stuff */
 extern struct dentry *usb_debug_root;
+extern struct dentry *usb_debugfs_init(void);
+extern void usb_debugfs_cleanup(void);
 
 /* LED triggers */
 enum usb_led_event {
-- 
2.21.0

