Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51259C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 15:54:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30DF327A6D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 15:54:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729734AbfFCPys (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 11:54:48 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:53654 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728731AbfFCPvT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 11:51:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 90E4B15AB;
        Mon,  3 Jun 2019 08:51:18 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 817F83F246;
        Mon,  3 Jun 2019 08:51:17 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        suzuki.poulose@arm.com, Ulf Hansson <ulf.hansson@linaro.org>
Subject: [RFC PATCH 13/57] drivers: Add generic helper for matching device by fwnode
Date:   Mon,  3 Jun 2019 16:49:39 +0100
Message-Id: <1559577023-558-14-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1559577023-558-1-git-send-email-suzuki.poulose@arm.com>
References: <1559577023-558-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of spilling the match function to check the device fwnode
everywhere, let us add a generic helper which can be reused by all.
Also adds a wrapper for bus_find_device to find a device by fwnode.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/base/core.c    |  6 ++++++
 include/linux/device.h | 15 +++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index d20699c..141c4f8 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -3334,3 +3334,9 @@ int device_match_of_node(struct device *dev, void *np)
 	return dev->of_node == np;
 }
 EXPORT_SYMBOL_GPL(device_match_of_node);
+
+int device_match_fwnode(struct device *dev, void *fwnode)
+{
+	return dev_fwnode(dev) == fwnode;
+}
+EXPORT_SYMBOL_GPL(device_match_fwnode);
diff --git a/include/linux/device.h b/include/linux/device.h
index fe16be4..54be931 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -164,6 +164,7 @@ struct device *subsys_dev_iter_next(struct subsys_dev_iter *iter);
 void subsys_dev_iter_exit(struct subsys_dev_iter *iter);
 
 int device_match_of_node(struct device *dev, void *np);
+int device_match_fwnode(struct device *dev, void *fwnode);
 
 int bus_for_each_dev(struct bus_type *bus, struct device *start, void *data,
 		     int (*fn)(struct device *dev, void *data));
@@ -188,6 +189,20 @@ static inline struct device *bus_find_device_by_of_node(struct bus_type *bus,
 	return bus_find_device(bus, start, np, device_match_of_node);
 }
 
+/**
+ * bus_find_device_by_fwnode : device iterator for locating a particular device
+ * matching the fwnode.
+ * @bus: bus type
+ * @start: Device to begin with
+ * @fwnode: fwnode of the device to match.
+ */
+static inline struct device *bus_find_device_by_fwnode(struct bus_type *bus,
+						       struct device *start,
+						       struct fwnode_handle *fwnode)
+{
+	return bus_find_device(bus, start, fwnode, device_match_fwnode);
+}
+
 struct device *subsys_find_device_by_id(struct bus_type *bus, unsigned int id,
 					struct device *hint);
 int bus_for_each_drv(struct bus_type *bus, struct device_driver *start,
-- 
2.7.4

