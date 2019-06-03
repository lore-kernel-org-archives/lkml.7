Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49261C282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 15:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26D7A27A87
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 15:54:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729708AbfFCPyF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 11:54:05 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:53770 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729229AbfFCPvf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 11:51:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 80ADD1715;
        Mon,  3 Jun 2019 08:51:35 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 94DA63F246;
        Mon,  3 Jun 2019 08:51:34 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        suzuki.poulose@arm.com
Subject: [RFC PATCH 25/57] drivers: Add generic match by name helper
Date:   Mon,  3 Jun 2019 16:49:51 +0100
Message-Id: <1559577023-558-26-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1559577023-558-1-git-send-email-suzuki.poulose@arm.com>
References: <1559577023-558-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a generic helper to match a device by its name. Also use the generic
match by device name helper for bus_find_device_by_name. Since the new
match function is also exported, let us convert this to a static inline
function.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/base/bus.c     | 24 ------------------------
 drivers/base/core.c    |  6 ++++++
 include/linux/device.h | 21 ++++++++++++++++++---
 3 files changed, 24 insertions(+), 27 deletions(-)

diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index 0a58e96..229e83ee 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -342,30 +342,6 @@ struct device *bus_find_device(struct bus_type *bus,
 }
 EXPORT_SYMBOL_GPL(bus_find_device);
 
-static int match_name(struct device *dev, void *data)
-{
-	const char *name = data;
-
-	return sysfs_streq(name, dev_name(dev));
-}
-
-/**
- * bus_find_device_by_name - device iterator for locating a particular device of a specific name
- * @bus: bus type
- * @start: Device to begin with
- * @name: name of the device to match
- *
- * This is similar to the bus_find_device() function above, but it handles
- * searching by a name automatically, no need to write another strcmp matching
- * function.
- */
-struct device *bus_find_device_by_name(struct bus_type *bus,
-				       struct device *start, const char *name)
-{
-	return bus_find_device(bus, start, (void *)name, match_name);
-}
-EXPORT_SYMBOL_GPL(bus_find_device_by_name);
-
 /**
  * subsys_find_device_by_id - find a device with a specific enumeration number
  * @subsys: subsystem
diff --git a/drivers/base/core.c b/drivers/base/core.c
index db19185..88fa037 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -3352,3 +3352,9 @@ int device_match_devt(struct device *dev, void *pdevt)
 	return dev->devt == *(dev_t *)pdevt;
 }
 EXPORT_SYMBOL_GPL(device_match_devt);
+
+int device_match_name(struct device *dev, void *name)
+{
+	return sysfs_streq(dev_name(dev), name);
+}
+EXPORT_SYMBOL_GPL(device_match_name);
diff --git a/include/linux/device.h b/include/linux/device.h
index 6ad1a27..b4a9cd2 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -167,15 +167,30 @@ int device_match_of_node(struct device *dev, void *np);
 int device_match_acpi_dev(struct device *dev, void *adev);
 int device_match_fwnode(struct device *dev, void *fwnode);
 int device_match_devt(struct device *dev, void *pdevt);
+int device_match_name(struct device *dev, void *name);
 
 int bus_for_each_dev(struct bus_type *bus, struct device *start, void *data,
 		     int (*fn)(struct device *dev, void *data));
 struct device *bus_find_device(struct bus_type *bus, struct device *start,
 			       void *data,
 			       int (*match)(struct device *dev, void *data));
-struct device *bus_find_device_by_name(struct bus_type *bus,
-				       struct device *start,
-				       const char *name);
+
+/**
+ * bus_find_device_by_name - device iterator for locating a particular device
+ * of a specific name.
+ * @bus: bus type
+ * @start: Device to begin with
+ * @name: name of the device to match
+ *
+ * This is similar to the bus_find_device() function, but it handles
+ * searching by a name automatically.
+ */
+static inline struct device *bus_find_device_by_name(struct bus_type *bus,
+						     struct device *start,
+						     const char *name)
+{
+	return bus_find_device(bus, start, (void *)name, device_match_name);
+}
 
 /**
  * bus_find_device_by_of_node : device iterator for locating a particular device
-- 
2.7.4

