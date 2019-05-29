Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96886C04AB3
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 07:44:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78510208C3
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 07:44:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbfE2Hoy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 03:44:54 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:25457 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726976AbfE2Ho0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 03:44:26 -0400
X-UUID: ced8f32f83ee4e7592dd05e4f9172581-20190529
X-UUID: ced8f32f83ee4e7592dd05e4f9172581-20190529
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1939931420; Wed, 29 May 2019 15:44:21 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 29 May 2019 15:44:19 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 29 May 2019 15:44:18 +0800
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
        Min Guo <min.guo@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Biju Das <biju.das@bp.renesas.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Yu Chen <chenyu56@huawei.com>
Subject: [PATCH v6 08/10] usb: roles: get usb-role-switch from parent
Date:   Wed, 29 May 2019 15:43:46 +0800
Message-ID: <1559115828-19146-9-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1559115828-19146-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1559115828-19146-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

when the USB host controller is the parent of the connector,
usually type-B, sometimes don't need the graph, so we should
check whether it's parent registers usb-role-switch or not
firstly, and get it if exists.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
v6:
  new patch
---
 drivers/usb/roles/class.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/roles/class.c b/drivers/usb/roles/class.c
index aab795b54c7f..1f6af0ef3954 100644
--- a/drivers/usb/roles/class.c
+++ b/drivers/usb/roles/class.c
@@ -114,6 +114,19 @@ static void *usb_role_switch_match(struct device_connection *con, int ep,
 	return dev ? to_role_switch(dev) : ERR_PTR(-EPROBE_DEFER);
 }
 
+static struct usb_role_switch *
+usb_role_switch_is_parent(struct fwnode_handle *fwnode)
+{
+	struct fwnode_handle *parent = fwnode_get_parent(fwnode);
+	struct device *dev;
+
+	if (!parent || !fwnode_property_present(parent, "usb-role-switch"))
+		return NULL;
+
+	dev = class_find_device(role_class, NULL, parent, switch_fwnode_match);
+	return dev ? to_role_switch(dev) : ERR_PTR(-EPROBE_DEFER);
+}
+
 /**
  * usb_role_switch_get - Find USB role switch linked with the caller
  * @dev: The caller device
@@ -125,8 +138,10 @@ struct usb_role_switch *usb_role_switch_get(struct device *dev)
 {
 	struct usb_role_switch *sw;
 
-	sw = device_connection_find_match(dev, "usb-role-switch", NULL,
-					  usb_role_switch_match);
+	sw = usb_role_switch_is_parent(dev_fwnode(dev));
+	if (!sw)
+		sw = device_connection_find_match(dev, "usb-role-switch", NULL,
+						  usb_role_switch_match);
 
 	if (!IS_ERR_OR_NULL(sw))
 		WARN_ON(!try_module_get(sw->dev.parent->driver->owner));
@@ -146,8 +161,10 @@ struct usb_role_switch *fwnode_usb_role_switch_get(struct fwnode_handle *fwnode)
 {
 	struct usb_role_switch *sw;
 
-	sw = fwnode_connection_find_match(fwnode, "usb-role-switch", NULL,
-					  usb_role_switch_match);
+	sw = usb_role_switch_is_parent(fwnode);
+	if (!sw)
+		sw = fwnode_connection_find_match(fwnode, "usb-role-switch",
+						  NULL, usb_role_switch_match);
 	if (!IS_ERR_OR_NULL(sw))
 		WARN_ON(!try_module_get(sw->dev.parent->driver->owner));
 
-- 
2.21.0

