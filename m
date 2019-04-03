Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5AD9C10F0B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 02:10:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FE0D2147C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 02:10:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727431AbfDCCKP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 22:10:15 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:16124 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726845AbfDCCJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 22:09:59 -0400
X-UUID: b78f3fae72fc42518ef56674a646ba25-20190403
X-UUID: b78f3fae72fc42518ef56674a646ba25-20190403
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1738006627; Wed, 03 Apr 2019 10:09:48 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 3 Apr 2019 10:09:45 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 3 Apr 2019 10:09:44 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Li Jun <jun.li@nxp.com>,
        Badhri Jagan Sridharan <badhri@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Min Guo <min.guo@mediatek.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [v3 PATCH 4/6] usb: roles: add API to get usb_role_switch by node
Date:   Wed, 3 Apr 2019 10:09:12 +0800
Message-ID: <1554257354-7440-5-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1554257354-7440-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1554257354-7440-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add fwnode_usb_role_switch_get() to make easier to get
usb_role_switch by fwnode which register it.
It's useful when there is not device_connection registered
between two drivers and only knows the fwnode which register
usb_role_switch.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
v3 changes:
  1. use fwnodes instead of node suggested by Andy
  2. rebuild the API suggested by Heikki

v2 no changes
---
 drivers/usb/roles/class.c | 31 +++++++++++++++++++++++++++++++
 include/linux/usb/role.h  |  2 ++
 2 files changed, 33 insertions(+)

diff --git a/drivers/usb/roles/class.c b/drivers/usb/roles/class.c
index f45d8df5cfb8..5ecb57f8960b 100644
--- a/drivers/usb/roles/class.c
+++ b/drivers/usb/roles/class.c
@@ -12,6 +12,7 @@
 #include <linux/device.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/of.h>
 #include <linux/slab.h>
 
 static struct class *role_class;
@@ -135,6 +136,36 @@ struct usb_role_switch *usb_role_switch_get(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(usb_role_switch_get);
 
+static int __switch_match_fwnode(struct device *dev, const void *fwnode)
+{
+	return dev_fwnode(dev->parent) == (const struct fwnode_handle *)fwnode;
+}
+
+/**
+ * fwnode_usb_role_switch_get - Find USB role switch by it's parent fwnode
+ * @fwnode: The fwnode that register USB role switch
+ *
+ * Finds and returns role switch registered by @fwnode. The reference count
+ * for the found switch is incremented.
+ */
+struct usb_role_switch *
+fwnode_usb_role_switch_get(struct fwnode_handle *fwnode)
+{
+	struct usb_role_switch *sw;
+	struct device *dev;
+
+	dev = class_find_device(role_class, NULL, fwnode,
+				__switch_match_fwnode);
+	if (!dev)
+		return ERR_PTR(-EPROBE_DEFER);
+
+	sw = to_role_switch(dev);
+	WARN_ON(!try_module_get(sw->dev.parent->driver->owner));
+
+	return sw;
+}
+EXPORT_SYMBOL_GPL(fwnode_usb_role_switch_get);
+
 /**
  * usb_role_switch_put - Release handle to a switch
  * @sw: USB Role Switch
diff --git a/include/linux/usb/role.h b/include/linux/usb/role.h
index c05ffa6abda9..d21cd55d9e45 100644
--- a/include/linux/usb/role.h
+++ b/include/linux/usb/role.h
@@ -46,6 +46,8 @@ int usb_role_switch_set_role(struct usb_role_switch *sw, enum usb_role role);
 enum usb_role usb_role_switch_get_role(struct usb_role_switch *sw);
 struct usb_role_switch *usb_role_switch_get(struct device *dev);
 void usb_role_switch_put(struct usb_role_switch *sw);
+struct usb_role_switch *
+fwnode_usb_role_switch_get(struct fwnode_handle *fwnode);
 
 struct usb_role_switch *
 usb_role_switch_register(struct device *parent,
-- 
2.20.1

