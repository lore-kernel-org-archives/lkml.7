Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55D37CA9ECB
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 02:29:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B0AF2067D
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 02:29:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729290AbfKAC32 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 22:29:28 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:33165 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729203AbfKAC32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 22:29:28 -0400
X-UUID: e494aaf292df4777a5aac93b5ff36739-20191101
X-UUID: e494aaf292df4777a5aac93b5ff36739-20191101
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1397155461; Fri, 01 Nov 2019 10:29:15 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 1 Nov 2019 10:29:10 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 1 Nov 2019 10:29:10 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>
Subject: [RFC PATCH] usb: common: change usb_debug_root as static variable
Date:   Fri, 1 Nov 2019 10:29:09 +0800
Message-ID: <1572575349-5596-1-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 0BC6BF59A4B94D77E8F22C50E62B63F4624266A34528C7C889666C16795174A52000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Try to avoid using extern global variable, and provide two
functions for the usage cases

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
NOTE:
    Prepared but not send out patches for drivers using usb_debug_root,
because I'm not sure whether this patch is needed, and many drivers
will be modified.
---
 drivers/usb/common/common.c | 16 ++++++++++++++--
 include/linux/usb.h         |  5 ++++-
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/common/common.c b/drivers/usb/common/common.c
index 1433260d99b4..639ee6d243a2 100644
--- a/drivers/usb/common/common.c
+++ b/drivers/usb/common/common.c
@@ -293,8 +293,20 @@ struct device *usb_of_get_companion_dev(struct device *dev)
 EXPORT_SYMBOL_GPL(usb_of_get_companion_dev);
 #endif
 
-struct dentry *usb_debug_root;
-EXPORT_SYMBOL_GPL(usb_debug_root);
+static struct dentry *usb_debug_root;
+
+struct dentry *usb_debugfs_create_dir(const char *name)
+{
+	return debugfs_create_dir(name, usb_debug_root);
+}
+EXPORT_SYMBOL_GPL(usb_debugfs_create_dir);
+
+struct dentry *usb_debugfs_create_file(const char *name, umode_t mode,
+			void *data, const struct file_operations *fops)
+{
+	return debugfs_create_file(name, mode, usb_debug_root, data, fops);
+}
+EXPORT_SYMBOL_GPL(usb_debugfs_create_file);
 
 static int __init usb_common_init(void)
 {
diff --git a/include/linux/usb.h b/include/linux/usb.h
index e656e7b4b1e4..ad96e0aa0127 100644
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -2001,7 +2001,10 @@ extern void usb_register_notify(struct notifier_block *nb);
 extern void usb_unregister_notify(struct notifier_block *nb);
 
 /* debugfs stuff */
-extern struct dentry *usb_debug_root;
+extern struct dentry *usb_debugfs_create_dir(const char *name);
+extern struct dentry *
+usb_debugfs_create_file(const char *name, umode_t mode, void *data,
+			const struct file_operations *fops);
 
 /* LED triggers */
 enum usb_led_event {
-- 
2.23.0

