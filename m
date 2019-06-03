Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36B17C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 15:52:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19E9D2786B
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 15:52:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729525AbfFCPwH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 11:52:07 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:53998 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729486AbfFCPwG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 11:52:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F030D15AB;
        Mon,  3 Jun 2019 08:52:05 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BD4693F246;
        Mon,  3 Jun 2019 08:52:04 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        suzuki.poulose@arm.com,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-usb@vger.kernel.org
Subject: [RFC PATCH 44/57] drivers: usb : Use class_find_device_by_fwnode() helper
Date:   Mon,  3 Jun 2019 16:50:10 +0100
Message-Id: <1559577023-558-45-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1559577023-558-1-git-send-email-suzuki.poulose@arm.com>
References: <1559577023-558-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reuse the generic helper to find a device by fwnode handle.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: linux-usb@vger.kernel.org
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/usb/roles/class.c | 8 +-------
 drivers/usb/typec/class.c | 8 +-------
 2 files changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/usb/roles/class.c b/drivers/usb/roles/class.c
index 3dc78cb..be9b70c 100644
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
+		dev = class_find_device_by_fwnode(role_class, NULL, con->fwnode);
 	} else {
 		dev = class_find_device_by_name(role_class, NULL, con->endpoint[ep]);
 	}
diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index c11cc5f..12f9759 100644
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
+		return class_find_device_by_fwnode(typec_class, NULL, con->fwnode);
 
 	dev = class_find_device_by_name(typec_class, NULL, con->endpoint[ep]);
 
-- 
2.7.4

