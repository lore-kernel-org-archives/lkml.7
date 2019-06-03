Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94388C28CC6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 15:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63E7427987
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 15:51:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729202AbfFCPvd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 11:51:33 -0400
Received: from foss.arm.com ([217.140.101.70]:53698 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728994AbfFCPvY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 11:51:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EAB8E1715;
        Mon,  3 Jun 2019 08:51:23 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DB6D83F246;
        Mon,  3 Jun 2019 08:51:22 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        suzuki.poulose@arm.com, Ulf Hansson <ulf.hansson@linaro.org>
Subject: [RFC PATCH 17/57] drivers: Add generic match by device type helper
Date:   Mon,  3 Jun 2019 16:49:43 +0100
Message-Id: <1559577023-558-18-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1559577023-558-1-git-send-email-suzuki.poulose@arm.com>
References: <1559577023-558-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a generic helper routine to match the device type of
a given device.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/base/core.c    |  6 ++++++
 include/linux/device.h | 15 +++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 141c4f8..9df812f 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -3340,3 +3340,9 @@ int device_match_fwnode(struct device *dev, void *fwnode)
 	return dev_fwnode(dev) == fwnode;
 }
 EXPORT_SYMBOL_GPL(device_match_fwnode);
+
+int device_match_devt(struct device *dev, void *pdevt)
+{
+	return dev->devt == *(dev_t *)pdevt;
+}
+EXPORT_SYMBOL_GPL(device_match_devt);
diff --git a/include/linux/device.h b/include/linux/device.h
index 54be931..83c0745 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -165,6 +165,7 @@ void subsys_dev_iter_exit(struct subsys_dev_iter *iter);
 
 int device_match_of_node(struct device *dev, void *np);
 int device_match_fwnode(struct device *dev, void *fwnode);
+int device_match_devt(struct device *dev, void *pdevt);
 
 int bus_for_each_dev(struct bus_type *bus, struct device *start, void *data,
 		     int (*fn)(struct device *dev, void *data));
@@ -203,6 +204,20 @@ static inline struct device *bus_find_device_by_fwnode(struct bus_type *bus,
 	return bus_find_device(bus, start, fwnode, device_match_fwnode);
 }
 
+/**
+ * bus_find_device_by_devt : device iterator for locating a particular device
+ * matching the device type.
+ * @bus: bus type
+ * @start: Device to begin with
+ * @devt: device type of the device to match.
+ */
+static inline struct device *bus_find_device_by_devt(struct bus_type *bus,
+						     struct device *start,
+						     dev_t devt)
+{
+	return bus_find_device(bus, start, &devt, device_match_devt);
+}
+
 struct device *subsys_find_device_by_id(struct bus_type *bus, unsigned int id,
 					struct device *hint);
 int bus_for_each_drv(struct bus_type *bus, struct device_driver *start,
-- 
2.7.4

