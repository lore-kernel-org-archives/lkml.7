Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EECABC76191
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 08:51:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD498227BF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 08:51:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbfGXIvh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 04:51:37 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:61680 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726713AbfGXIve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 04:51:34 -0400
X-UUID: 06329a48bcea4aa18cd20906aa237e11-20190724
X-UUID: 06329a48bcea4aa18cd20906aa237e11-20190724
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1610829251; Wed, 24 Jul 2019 16:51:28 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 MTKMBS31DR.mediatek.inc (172.27.6.102) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 24 Jul 2019 16:51:22 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 24 Jul 2019 16:51:22 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Biju Das <biju.das@bp.renesas.com>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Li Jun <jun.li@nxp.com>,
        Badhri Jagan Sridharan <badhri@google.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Min Guo <min.guo@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v8 07/11] usb: roles: Add fwnode_usb_role_switch_get() function
Date:   Wed, 24 Jul 2019 16:50:41 +0800
Message-ID: <1563958245-6321-8-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1563958245-6321-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1563958245-6321-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: EEC99CC9CADEE3CB7C259B701737F573F31D6B5C909FBC392820A1ADB63BBF6C2000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heikki Krogerus <heikki.krogerus@linux.intel.com>

The fwnode_usb_role_switch_get() function is exactly the
same as usb_role_switch_get(), except that it takes struct
fwnode_handle as parameter instead of struct device.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
Tested-by: Biju Das <biju.das@bp.renesas.com>
---
v8: no changes

v7: 
 add signed-off-by Chunfeng and tested-by Biju

v6:
  new patch
---
 drivers/usb/roles/class.c | 20 ++++++++++++++++++++
 include/linux/usb/role.h  |  7 +++++++
 2 files changed, 27 insertions(+)

diff --git a/drivers/usb/roles/class.c b/drivers/usb/roles/class.c
index 86defca6623e..5b637aaf311f 100644
--- a/drivers/usb/roles/class.c
+++ b/drivers/usb/roles/class.c
@@ -135,6 +135,26 @@ struct usb_role_switch *usb_role_switch_get(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(usb_role_switch_get);
 
+/**
+ * fwnode_usb_role_switch_get - Find USB role switch linked with the caller
+ * @fwnode: The caller device node
+ *
+ * This is similar to the usb_role_switch_get() function above, but it searches
+ * the switch using fwnode instead of device entry.
+ */
+struct usb_role_switch *fwnode_usb_role_switch_get(struct fwnode_handle *fwnode)
+{
+	struct usb_role_switch *sw;
+
+	sw = fwnode_connection_find_match(fwnode, "usb-role-switch", NULL,
+					  usb_role_switch_match);
+	if (!IS_ERR_OR_NULL(sw))
+		WARN_ON(!try_module_get(sw->dev.parent->driver->owner));
+
+	return sw;
+}
+EXPORT_SYMBOL_GPL(fwnode_usb_role_switch_get);
+
 /**
  * usb_role_switch_put - Release handle to a switch
  * @sw: USB Role Switch
diff --git a/include/linux/usb/role.h b/include/linux/usb/role.h
index da2b9641b877..2d77f97df72d 100644
--- a/include/linux/usb/role.h
+++ b/include/linux/usb/role.h
@@ -47,6 +47,7 @@ struct usb_role_switch_desc {
 int usb_role_switch_set_role(struct usb_role_switch *sw, enum usb_role role);
 enum usb_role usb_role_switch_get_role(struct usb_role_switch *sw);
 struct usb_role_switch *usb_role_switch_get(struct device *dev);
+struct usb_role_switch *fwnode_usb_role_switch_get(struct fwnode_handle *node);
 void usb_role_switch_put(struct usb_role_switch *sw);
 
 struct usb_role_switch *
@@ -70,6 +71,12 @@ static inline struct usb_role_switch *usb_role_switch_get(struct device *dev)
 	return ERR_PTR(-ENODEV);
 }
 
+static inline struct usb_role_switch *
+fwnode_usb_role_switch_get(struct fwnode_handle *node)
+{
+	return ERR_PTR(-ENODEV);
+}
+
 static inline void usb_role_switch_put(struct usb_role_switch *sw) { }
 
 static inline struct usb_role_switch *
-- 
2.21.0

