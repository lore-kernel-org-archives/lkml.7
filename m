Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC8FC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 11:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCCFA2064A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 11:47:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729993AbfCFLrL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 06:47:11 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:58443 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729824AbfCFLrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 06:47:08 -0500
X-UUID: f8d9c932612a4100b20bb92f2c1faac2-20190306
X-UUID: f8d9c932612a4100b20bb92f2c1faac2-20190306
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 831724507; Wed, 06 Mar 2019 19:46:57 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 6 Mar 2019 19:46:55 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 6 Mar 2019 19:46:54 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH 09/11] usb: mtu3: move vbus and mode debugfs interfaces into mtu3_debugfs.c
Date:   Wed, 6 Mar 2019 19:46:21 +0800
Message-ID: <1551872783-13707-10-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1551872783-13707-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1551872783-13707-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to the separated debugfs files are added, move vbus and mode
debugfs interfaces related with dual-role switch from mtu3_dr.c
into mtu3_debugfs.c

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/mtu3/mtu3_debug.h   |   2 +
 drivers/usb/mtu3/mtu3_debugfs.c | 101 ++++++++++++++++++++++++++++
 drivers/usb/mtu3/mtu3_dr.c      | 113 +-------------------------------
 drivers/usb/mtu3/mtu3_dr.h      |   4 ++
 4 files changed, 110 insertions(+), 110 deletions(-)

diff --git a/drivers/usb/mtu3/mtu3_debug.h b/drivers/usb/mtu3/mtu3_debug.h
index 94d39b00403e..d97a48c73469 100644
--- a/drivers/usb/mtu3/mtu3_debug.h
+++ b/drivers/usb/mtu3/mtu3_debug.h
@@ -27,11 +27,13 @@ struct mtu3_file_map {
 
 #if IS_ENABLED(CONFIG_DEBUG_FS)
 void ssusb_dev_debugfs_init(struct ssusb_mtk *ssusb);
+void ssusb_dr_debugfs_init(struct ssusb_mtk *ssusb);
 void ssusb_debugfs_create_root(struct ssusb_mtk *ssusb);
 void ssusb_debugfs_remove_root(struct ssusb_mtk *ssusb);
 
 #else
 static inline void ssusb_dev_debugfs_init(struct ssusb_mtk *ssusb) {}
+static inline void ssusb_dr_debugfs_init(struct ssusb_mtk *ssusb) {}
 static inline void ssusb_debugfs_create_root(struct ssusb_mtk *ssusb) {}
 static inline void ssusb_debugfs_remove_root(struct ssusb_mtk *ssusb) {}
 
diff --git a/drivers/usb/mtu3/mtu3_debugfs.c b/drivers/usb/mtu3/mtu3_debugfs.c
index 7cb1cad5a4b3..62c57ddc554e 100644
--- a/drivers/usb/mtu3/mtu3_debugfs.c
+++ b/drivers/usb/mtu3/mtu3_debugfs.c
@@ -10,6 +10,7 @@
 #include <linux/uaccess.h>
 
 #include "mtu3.h"
+#include "mtu3_dr.h"
 #include "mtu3_debug.h"
 
 #define dump_register(nm)		\
@@ -425,6 +426,106 @@ void ssusb_dev_debugfs_init(struct ssusb_mtk *ssusb)
 			    mtu, &mtu3_ep_used_fops);
 }
 
+static int ssusb_mode_show(struct seq_file *sf, void *unused)
+{
+	struct ssusb_mtk *ssusb = sf->private;
+
+	seq_printf(sf, "current mode: %s(%s drd)\n(echo device/host)\n",
+		   ssusb->is_host ? "host" : "device",
+		   ssusb->otg_switch.manual_drd_enabled ? "manual" : "auto");
+
+	return 0;
+}
+
+static int ssusb_mode_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, ssusb_mode_show, inode->i_private);
+}
+
+static ssize_t ssusb_mode_write(struct file *file, const char __user *ubuf,
+				size_t count, loff_t *ppos)
+{
+	struct seq_file *sf = file->private_data;
+	struct ssusb_mtk *ssusb = sf->private;
+	char buf[16];
+
+	if (copy_from_user(&buf, ubuf, min_t(size_t, sizeof(buf) - 1, count)))
+		return -EFAULT;
+
+	if (!strncmp(buf, "host", 4) && !ssusb->is_host) {
+		ssusb_mode_manual_switch(ssusb, 1);
+	} else if (!strncmp(buf, "device", 6) && ssusb->is_host) {
+		ssusb_mode_manual_switch(ssusb, 0);
+	} else {
+		dev_err(ssusb->dev, "wrong or duplicated setting\n");
+		return -EINVAL;
+	}
+
+	return count;
+}
+
+static const struct file_operations ssusb_mode_fops = {
+	.open = ssusb_mode_open,
+	.write = ssusb_mode_write,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = single_release,
+};
+
+static int ssusb_vbus_show(struct seq_file *sf, void *unused)
+{
+	struct ssusb_mtk *ssusb = sf->private;
+	struct otg_switch_mtk *otg_sx = &ssusb->otg_switch;
+
+	seq_printf(sf, "vbus state: %s\n(echo on/off)\n",
+		   regulator_is_enabled(otg_sx->vbus) ? "on" : "off");
+
+	return 0;
+}
+
+static int ssusb_vbus_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, ssusb_vbus_show, inode->i_private);
+}
+
+static ssize_t ssusb_vbus_write(struct file *file, const char __user *ubuf,
+				size_t count, loff_t *ppos)
+{
+	struct seq_file *sf = file->private_data;
+	struct ssusb_mtk *ssusb = sf->private;
+	struct otg_switch_mtk *otg_sx = &ssusb->otg_switch;
+	char buf[16];
+	bool enable;
+
+	if (copy_from_user(&buf, ubuf, min_t(size_t, sizeof(buf) - 1, count)))
+		return -EFAULT;
+
+	if (kstrtobool(buf, &enable)) {
+		dev_err(ssusb->dev, "wrong setting\n");
+		return -EINVAL;
+	}
+
+	ssusb_set_vbus(otg_sx, enable);
+
+	return count;
+}
+
+static const struct file_operations ssusb_vbus_fops = {
+	.open = ssusb_vbus_open,
+	.write = ssusb_vbus_write,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = single_release,
+};
+
+void ssusb_dr_debugfs_init(struct ssusb_mtk *ssusb)
+{
+	struct dentry *root = ssusb->dbgfs_root;
+
+	debugfs_create_file("mode", 0644, root, ssusb, &ssusb_mode_fops);
+	debugfs_create_file("vbus", 0644, root, ssusb, &ssusb_vbus_fops);
+}
+
 void ssusb_debugfs_create_root(struct ssusb_mtk *ssusb)
 {
 	ssusb->dbgfs_root =
diff --git a/drivers/usb/mtu3/mtu3_dr.c b/drivers/usb/mtu3/mtu3_dr.c
index 3f86ae1e73e8..ff2956272e15 100644
--- a/drivers/usb/mtu3/mtu3_dr.c
+++ b/drivers/usb/mtu3/mtu3_dr.c
@@ -7,16 +7,9 @@
  * Author: Chunfeng Yun <chunfeng.yun@mediatek.com>
  */
 
-#include <linux/debugfs.h>
-#include <linux/irq.h>
-#include <linux/kernel.h>
-#include <linux/of_device.h>
-#include <linux/pinctrl/consumer.h>
-#include <linux/seq_file.h>
-#include <linux/uaccess.h>
-
 #include "mtu3.h"
 #include "mtu3_dr.h"
+#include "mtu3_debug.h"
 
 #define USB2_PORT 2
 #define USB3_PORT 3
@@ -270,7 +263,7 @@ static int ssusb_extcon_register(struct otg_switch_mtk *otg_sx)
  * This is useful in special cases, such as uses TYPE-A receptacle but also
  * wants to support dual-role mode.
  */
-static void ssusb_mode_manual_switch(struct ssusb_mtk *ssusb, int to_host)
+void ssusb_mode_manual_switch(struct ssusb_mtk *ssusb, int to_host)
 {
 	struct otg_switch_mtk *otg_sx = &ssusb->otg_switch;
 
@@ -285,106 +278,6 @@ static void ssusb_mode_manual_switch(struct ssusb_mtk *ssusb, int to_host)
 	}
 }
 
-static int ssusb_mode_show(struct seq_file *sf, void *unused)
-{
-	struct ssusb_mtk *ssusb = sf->private;
-
-	seq_printf(sf, "current mode: %s(%s drd)\n(echo device/host)\n",
-		ssusb->is_host ? "host" : "device",
-		ssusb->otg_switch.manual_drd_enabled ? "manual" : "auto");
-
-	return 0;
-}
-
-static int ssusb_mode_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, ssusb_mode_show, inode->i_private);
-}
-
-static ssize_t ssusb_mode_write(struct file *file,
-	const char __user *ubuf, size_t count, loff_t *ppos)
-{
-	struct seq_file *sf = file->private_data;
-	struct ssusb_mtk *ssusb = sf->private;
-	char buf[16];
-
-	if (copy_from_user(&buf, ubuf, min_t(size_t, sizeof(buf) - 1, count)))
-		return -EFAULT;
-
-	if (!strncmp(buf, "host", 4) && !ssusb->is_host) {
-		ssusb_mode_manual_switch(ssusb, 1);
-	} else if (!strncmp(buf, "device", 6) && ssusb->is_host) {
-		ssusb_mode_manual_switch(ssusb, 0);
-	} else {
-		dev_err(ssusb->dev, "wrong or duplicated setting\n");
-		return -EINVAL;
-	}
-
-	return count;
-}
-
-static const struct file_operations ssusb_mode_fops = {
-	.open = ssusb_mode_open,
-	.write = ssusb_mode_write,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-};
-
-static int ssusb_vbus_show(struct seq_file *sf, void *unused)
-{
-	struct ssusb_mtk *ssusb = sf->private;
-	struct otg_switch_mtk *otg_sx = &ssusb->otg_switch;
-
-	seq_printf(sf, "vbus state: %s\n(echo on/off)\n",
-		regulator_is_enabled(otg_sx->vbus) ? "on" : "off");
-
-	return 0;
-}
-
-static int ssusb_vbus_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, ssusb_vbus_show, inode->i_private);
-}
-
-static ssize_t ssusb_vbus_write(struct file *file,
-	const char __user *ubuf, size_t count, loff_t *ppos)
-{
-	struct seq_file *sf = file->private_data;
-	struct ssusb_mtk *ssusb = sf->private;
-	struct otg_switch_mtk *otg_sx = &ssusb->otg_switch;
-	char buf[16];
-	bool enable;
-
-	if (copy_from_user(&buf, ubuf, min_t(size_t, sizeof(buf) - 1, count)))
-		return -EFAULT;
-
-	if (kstrtobool(buf, &enable)) {
-		dev_err(ssusb->dev, "wrong setting\n");
-		return -EINVAL;
-	}
-
-	ssusb_set_vbus(otg_sx, enable);
-
-	return count;
-}
-
-static const struct file_operations ssusb_vbus_fops = {
-	.open = ssusb_vbus_open,
-	.write = ssusb_vbus_write,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-};
-
-static void ssusb_debugfs_init(struct ssusb_mtk *ssusb)
-{
-	struct dentry *root = ssusb->dbgfs_root;
-
-	debugfs_create_file("mode", 0644, root, ssusb, &ssusb_mode_fops);
-	debugfs_create_file("vbus", 0644, root, ssusb, &ssusb_vbus_fops);
-}
-
 void ssusb_set_force_mode(struct ssusb_mtk *ssusb,
 			  enum mtu3_dr_force_mode mode)
 {
@@ -417,7 +310,7 @@ int ssusb_otg_switch_init(struct ssusb_mtk *ssusb)
 	INIT_WORK(&otg_sx->vbus_work, ssusb_vbus_work);
 
 	if (otg_sx->manual_drd_enabled)
-		ssusb_debugfs_init(ssusb);
+		ssusb_dr_debugfs_init(ssusb);
 	else
 		ret = ssusb_extcon_register(otg_sx);
 
diff --git a/drivers/usb/mtu3/mtu3_dr.h b/drivers/usb/mtu3/mtu3_dr.h
index 50702fdcde28..ba6fe357ce29 100644
--- a/drivers/usb/mtu3/mtu3_dr.h
+++ b/drivers/usb/mtu3/mtu3_dr.h
@@ -71,6 +71,7 @@ static inline void ssusb_gadget_exit(struct ssusb_mtk *ssusb)
 #if IS_ENABLED(CONFIG_USB_MTU3_DUAL_ROLE)
 int ssusb_otg_switch_init(struct ssusb_mtk *ssusb);
 void ssusb_otg_switch_exit(struct ssusb_mtk *ssusb);
+void ssusb_mode_manual_switch(struct ssusb_mtk *ssusb, int to_host);
 int ssusb_set_vbus(struct otg_switch_mtk *otg_sx, int is_on);
 void ssusb_set_force_mode(struct ssusb_mtk *ssusb,
 			  enum mtu3_dr_force_mode mode);
@@ -85,6 +86,9 @@ static inline int ssusb_otg_switch_init(struct ssusb_mtk *ssusb)
 static inline void ssusb_otg_switch_exit(struct ssusb_mtk *ssusb)
 {}
 
+static inline void
+ssusb_mode_manual_switch(struct ssusb_mtk *ssusb, int to_host) {}
+
 static inline int ssusb_set_vbus(struct otg_switch_mtk *otg_sx, int is_on)
 {
 	return 0;
-- 
2.20.1

