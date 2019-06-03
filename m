Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0DF0C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 15:52:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A490627930
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 15:52:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729550AbfFCPwN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 11:52:13 -0400
Received: from foss.arm.com ([217.140.101.70]:54030 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729531AbfFCPwK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 11:52:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E1BD515AB;
        Mon,  3 Jun 2019 08:52:09 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 01AF63F246;
        Mon,  3 Jun 2019 08:52:08 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        suzuki.poulose@arm.com
Subject: [RFC PATCH 46/57] driver: Add variants of driver_find_device()
Date:   Mon,  3 Jun 2019 16:50:12 +0100
Message-Id: <1559577023-558-47-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1559577023-558-1-git-send-email-suzuki.poulose@arm.com>
References: <1559577023-558-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a wrappers to lookup a device by name for a given driver, by various
generic properties of a device. This can avoid the proliferation of custom
match functions throughout the drivers.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 include/linux/device.h | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/include/linux/device.h b/include/linux/device.h
index 52d59d5..68d6e04 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -401,6 +401,50 @@ struct device *driver_find_device(struct device_driver *drv,
 				  struct device *start, void *data,
 				  int (*match)(struct device *dev, const void *data));
 
+/**
+ * driver_find_device_by_name - device iterator for locating a particular device
+ * of a specific name.
+ * @driver: the driver we're iterating
+ * @start: Device to begin with
+ * @name: name of the device to match
+ */
+static inline struct device *driver_find_device_by_name(struct device_driver *drv,
+							struct device *start,
+							const char *name)
+{
+	return driver_find_device(drv, start, (void *)name, device_match_name);
+}
+
+/**
+ * driver_find_device_by_of_node- device iterator for locating a particular device
+ * by of_node pointer.
+ * @driver: the driver we're iterating
+ * @start: Device to begin with
+ * @np: of_node pointer to match.
+ */
+static inline struct device *
+driver_find_device_by_of_node(struct device_driver *drv,
+			      struct device *start,
+			      const struct device_node *np)
+{
+	return driver_find_device(drv, start, (void *)np, device_match_of_node);
+}
+
+/**
+ * driver_find_device_by_fwnode- device iterator for locating a particular device
+ * by fwnode pointer.
+ * @driver: the driver we're iterating
+ * @start: Device to begin with
+ * @fwnode: fwnode pointer to match.
+ */
+static inline struct device *
+driver_find_device_by_fwnode(struct device_driver *drv,
+			     struct device *start,
+			     const struct fwnode_handle *fwnode)
+{
+	return driver_find_device(drv, start, (void *)fwnode, device_match_fwnode);
+}
+
 void driver_deferred_probe_add(struct device *dev);
 int driver_deferred_probe_check_state(struct device *dev);
 
-- 
2.7.4

