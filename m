Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7281C31E4E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 17:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D2EF2184E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 17:55:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727569AbfFNRzP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 13:55:15 -0400
Received: from foss.arm.com ([217.140.110.172]:39548 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727483AbfFNRzO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 13:55:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9CCD8ED1;
        Fri, 14 Jun 2019 10:55:13 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B50993F718;
        Fri, 14 Jun 2019 10:55:12 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        suzuki.poulose@arm.com,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-usb@vger.kernel.org
Subject: [PATCH v2 14/28] drivers: Introduce class_find_device_by_fwnode() helper
Date:   Fri, 14 Jun 2019 18:54:09 +0100
Message-Id: <1560534863-15115-15-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1560534863-15115-1-git-send-email-suzuki.poulose@arm.com>
References: <1560534863-15115-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a wrapper to class_find_device() to search for a device
by the fwnode pointer, reusing the generic match function.
Also convert the existing users to make use of the new helper.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: linux-usb@vger.kernel.org
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/usb/roles/class.c |  8 +-------
 drivers/usb/typec/class.c |  8 +-------
 include/linux/device.h    | 13 +++++++++++++
 3 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/usb/roles/class.c b/drivers/usb/roles/class.c
index 07aaa96..5cd87d8 100644
--- a/drivers/usb/roles/class.c
+++ b/drivers/usb/roles/class.c
@@ -85,11 +85,6 @@ enum usb_role usb_role_switch_get_role(struct usb_role_switch *sw)
 }
 EXPORT_SYMBOL_GPL(usb_role_switch_get_role);
 
-static int switch_fwnode_match(struct device *dev, const void *fwnode)
-{
-	return dev_fwnode(dev) == fwnode;
-}
-
 static void *usb_role_switch_match(struct device_connection *con, int ep,
 				   void *data)
 {
@@ -99,8 +94,7 @@ static void *usb_role_switch_match(struct device_connection *con, int ep,
 		if (!fwnode_property_present(con->fwnode, con->id))
 			return NULL;
 
-		dev = class_find_device(role_class, NULL, con->fwnode,
-					switch_fwnode_match);
+		dev = class_find_device_by_fwnode(role_class, con->fwnode);
 	} else {
 		dev = class_find_device_by_name(role_class, con->endpoint[ep]);
 	}
diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index 18a0687..af4fb73 100644
--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -205,11 +205,6 @@ static void typec_altmode_put_partner(struct altmode *altmode)
 	put_device(&adev->dev);
 }
 
-static int typec_port_fwnode_match(struct device *dev, const void *fwnode)
-{
-	return dev_fwnode(dev) == fwnode;
-}
-
 static void *typec_port_match(struct device_connection *con, int ep, void *data)
 {
 	struct device *dev;
@@ -219,8 +214,7 @@ static void *typec_port_match(struct device_connection *con, int ep, void *data)
 	 * we need to return ERR_PTR(-PROBE_DEFER) when there is no device.
 	 */
 	if (con->fwnode)
-		return class_find_device(typec_class, NULL, con->fwnode,
-					 typec_port_fwnode_match);
+		return class_find_device_by_fwnode(typec_class, con->fwnode);
 
 	dev = class_find_device_by_name(typec_class, con->endpoint[ep]);
 
diff --git a/include/linux/device.h b/include/linux/device.h
index 9228502..52ac911 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -509,6 +509,19 @@ class_find_device_by_of_node(struct class *class, const struct device_node *np)
 	return class_find_device(class, NULL, np, device_match_of_node);
 }
 
+/**
+ * class_find_device_by_fwnode : device iterator for locating a particular device
+ * matching the fwnode.
+ * @class: class type
+ * @fwnode: fwnode of the device to match.
+ */
+static inline struct device *
+class_find_device_by_fwnode(struct class *class,
+			    const struct fwnode_handle *fwnode)
+{
+	return class_find_device(class, NULL, fwnode, device_match_fwnode);
+}
+
 struct class_attribute {
 	struct attribute attr;
 	ssize_t (*show)(struct class *class, struct class_attribute *attr,
-- 
2.7.4

