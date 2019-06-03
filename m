Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2E58C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 15:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAB8F27A92
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 15:55:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729532AbfFCPzH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 11:55:07 -0400
Received: from foss.arm.com ([217.140.101.70]:53542 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728296AbfFCPvE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 11:51:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4F58D169E;
        Mon,  3 Jun 2019 08:51:04 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1C7283F246;
        Mon,  3 Jun 2019 08:51:02 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        suzuki.poulose@arm.com, Ulf Hansson <ulf.hansson@linaro.org>,
        Joe Perches <joe@perches.com>
Subject: [RFC PATCH 04/57] drivers: Add generic match helper to match the device of_node
Date:   Mon,  3 Jun 2019 16:49:30 +0100
Message-Id: <1559577023-558-5-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1559577023-558-1-git-send-email-suzuki.poulose@arm.com>
References: <1559577023-558-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of spilling the match function to check the of_node for
a given value, lets add a common helper. Also add a wrapper to
find device by of_node pointer for bus.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Joe Perches <joe@perches.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/base/core.c    |  6 ++++++
 include/linux/device.h | 17 +++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index fd7511e..d20699c 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -3328,3 +3328,9 @@ void device_set_of_node_from_dev(struct device *dev, const struct device *dev2)
 	dev->of_node_reused = true;
 }
 EXPORT_SYMBOL_GPL(device_set_of_node_from_dev);
+
+int device_match_of_node(struct device *dev, void *np)
+{
+	return dev->of_node == np;
+}
+EXPORT_SYMBOL_GPL(device_match_of_node);
diff --git a/include/linux/device.h b/include/linux/device.h
index e85264f..fe16be4 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -163,6 +163,8 @@ void subsys_dev_iter_init(struct subsys_dev_iter *iter,
 struct device *subsys_dev_iter_next(struct subsys_dev_iter *iter);
 void subsys_dev_iter_exit(struct subsys_dev_iter *iter);
 
+int device_match_of_node(struct device *dev, void *np);
+
 int bus_for_each_dev(struct bus_type *bus, struct device *start, void *data,
 		     int (*fn)(struct device *dev, void *data));
 struct device *bus_find_device(struct bus_type *bus, struct device *start,
@@ -171,6 +173,21 @@ struct device *bus_find_device(struct bus_type *bus, struct device *start,
 struct device *bus_find_device_by_name(struct bus_type *bus,
 				       struct device *start,
 				       const char *name);
+
+/**
+ * bus_find_device_by_of_node : device iterator for locating a particular device
+ * matching the of_node.
+ * @bus: bus type
+ * @start: Device to begin with
+ * @np: of_node of the device to match.
+ */
+static inline struct device *bus_find_device_by_of_node(struct bus_type *bus,
+							struct device *start,
+							struct device_node *np)
+{
+	return bus_find_device(bus, start, np, device_match_of_node);
+}
+
 struct device *subsys_find_device_by_id(struct bus_type *bus, unsigned int id,
 					struct device *hint);
 int bus_for_each_drv(struct bus_type *bus, struct device_driver *start,
-- 
2.7.4

