Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10FB0C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 15:51:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E93022781E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 15:51:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729370AbfFCPvp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 11:51:45 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:53816 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729282AbfFCPvm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 11:51:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E50551A25;
        Mon,  3 Jun 2019 08:51:41 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 04E1A3F246;
        Mon,  3 Jun 2019 08:51:40 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        suzuki.poulose@arm.com
Subject: [RFC PATCH 28/57] drivers: class: Add variants of class_find_device()
Date:   Mon,  3 Jun 2019 16:49:54 +0100
Message-Id: <1559577023-558-29-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1559577023-558-1-git-send-email-suzuki.poulose@arm.com>
References: <1559577023-558-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to the bus_find_device_by_*() helpers add wrappers
for class_find_device() to find devices by generic attributes.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 include/linux/device.h | 58 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/include/linux/device.h b/include/linux/device.h
index e8d1267..1945c3d 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -528,6 +528,64 @@ extern int class_for_each_device(struct class *class, struct device *start,
 extern struct device *class_find_device(struct class *class,
 					struct device *start, const void *data,
 					int (*match)(struct device *, const void *));
+/**
+ * class_find_device_by_name - device iterator for locating a particular device
+ * of a specific name.
+ * @class: the class we're iterating
+ * @start: Device to begin with
+ * @name: name of the device to match
+ *
+ * This is similar to the class_find_device() above, but it handles searching
+ * by a name automatically.
+ */
+static inline struct device *class_find_device_by_name(struct class *class,
+						       struct device *start,
+						       const void *name)
+{
+	return class_find_device(class, start, name, device_match_name);
+}
+
+/**
+ * class_find_device_by_devt - device iterator for locating a particular device
+ * by devt.
+ * @class: the class we're iterating
+ * @start: Device to begin with
+ * @devt: devt of the device to match
+ */
+static inline struct device *class_find_device_by_devt(struct class *class,
+						       struct device *start,
+						       dev_t devt)
+{
+	return class_find_device(class, start, &devt, device_match_devt);
+}
+
+/**
+ * class_find_device_by_of_node - device iterator for locating a particular device
+ * by of_node.
+ * @class: the class we're iterating
+ * @start: Device to begin with
+ * @np: of_node of the device to match
+ */
+static inline struct device *class_find_device_by_of_node(struct class *class,
+							  struct device *start,
+							  struct device_node *np)
+{
+	return class_find_device(class, start, np, device_match_of_node);
+}
+
+/**
+ * class_find_device_by_fwnode - device iterator for locating a particular device
+ * by fwnode.
+ * @class: the class we're iterating
+ * @start: Device to begin with
+ * @fwnode: fwnode of the device to match
+ */
+static inline struct device *class_find_device_by_fwnode(struct class *class,
+							  struct device *start,
+							  struct fwnode_handle *fwnode)
+{
+	return class_find_device(class, start, fwnode, device_match_fwnode);
+}
 
 struct class_attribute {
 	struct attribute attr;
-- 
2.7.4

