Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C527C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 07:58:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7730623401
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 07:58:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392900AbfHWH6T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 03:58:19 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:10978 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2392061AbfHWH5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 03:57:49 -0400
X-UUID: cbd8f6cc14af49b6b4be9276cdad155f-20190823
X-UUID: cbd8f6cc14af49b6b4be9276cdad155f-20190823
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1406150217; Fri, 23 Aug 2019 15:57:33 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 23 Aug 2019 15:57:31 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 23 Aug 2019 15:57:30 +0800
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
        Linus Walleij <linus.walleij@linaro.org>,
        Nagarjuna Kristam <nkristam@nvidia.com>
Subject: [PATCH next v10 07/11] usb: roles: Add fwnode_usb_role_switch_get() function
Date:   Fri, 23 Aug 2019 15:57:17 +0800
Message-ID: <1566547041-20804-8-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1566547041-20804-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1566547041-20804-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: FFDB3100BE96F835206B5ED36C104E555BB0BC15C54D47328B38EB93D80304E72000:8
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
v10:
  revert changes of v9

v9:
 replace signed-off-by by suggested-by Heikki

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
index 0526efbc4922..2abb6fe384ca 100644
--- a/drivers/usb/roles/class.c
+++ b/drivers/usb/roles/class.c
@@ -123,6 +123,26 @@ struct usb_role_switch *usb_role_switch_get(struct device *dev)
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
2.23.0

