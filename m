Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D53EC28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 15:15:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0096F206C3
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 15:15:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728664AbfFEPPD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 11:15:03 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:33624 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728650AbfFEPPA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 11:15:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E2DBC15BF;
        Wed,  5 Jun 2019 08:14:59 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CA9913F246;
        Wed,  5 Jun 2019 08:14:57 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        suzuki.poulose@arm.com, Arnd Bergmann <arnd@arndb.de>,
        Joerg Roedel <joro@8bytes.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Lee Jones <lee.jones@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thor Thayer <thor.thayer@linux.intel.com>,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCH 12/13] drivers: Introduce variants of driver_find_device()
Date:   Wed,  5 Jun 2019 16:13:49 +0100
Message-Id: <1559747630-28065-13-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1559747630-28065-1-git-send-email-suzuki.poulose@arm.com>
References: <1559747630-28065-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to the other device lookup helpers, introduce
variants of driver_find_device() to automatically lookup
devices by their generic properties to avoid proliferation
of custom match functions. We add :

	driver_find_device_by_name
	driver_find_device_by_of_node
	driver_find_device_by_fwnode
	driver_find_device_by_devt
	driver_find_next_device

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Jonathan Hunter <jonathanh@nvidia.com>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Thor Thayer <thor.thayer@linux.intel.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 include/linux/device.h | 58 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/include/linux/device.h b/include/linux/device.h
index 10de79d..2c05e60 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -404,6 +404,64 @@ struct device *driver_find_device(struct device_driver *drv,
 				  struct device *start, const void *data,
 				  int (*match)(struct device *dev, const void *data));
 
+/**
+ * driver_find_device_by_name - device iterator for locating a particular device
+ * of a specific name.
+ * @driver: the driver we're iterating
+ * @name: name of the device to match
+ */
+static inline struct device *driver_find_device_by_name(struct device_driver *drv,
+							const char *name)
+{
+	return driver_find_device(drv, NULL, name, device_match_name);
+}
+
+/**
+ * driver_find_device_by_of_node- device iterator for locating a particular device
+ * by of_node pointer.
+ * @driver: the driver we're iterating
+ * @np: of_node pointer to match.
+ */
+static inline struct device *
+driver_find_device_by_of_node(struct device_driver *drv,
+			      const struct device_node *np)
+{
+	return driver_find_device(drv, NULL, np, device_match_of_node);
+}
+
+/**
+ * driver_find_device_by_fwnode- device iterator for locating a particular device
+ * by fwnode pointer.
+ * @driver: the driver we're iterating
+ * @fwnode: fwnode pointer to match.
+ */
+static inline struct device *
+driver_find_device_by_fwnode(struct device_driver *drv,
+			     const struct fwnode_handle *fwnode)
+{
+	return driver_find_device(drv, NULL, fwnode, device_match_fwnode);
+}
+
+/**
+ * driver_find_device_by_devt- device iterator for locating a particular device
+ * by devt.
+ * @driver: the driver we're iterating
+ * @start: device to start search from
+ * @devt: devt pointer to match.
+ */
+static inline struct device *driver_find_device_by_devt(struct device_driver *drv,
+							struct device *start,
+							dev_t devt)
+{
+	return driver_find_device(drv, start, &devt, device_match_devt);
+}
+
+static inline struct device *driver_find_next_device(struct device_driver *drv,
+						     struct device *start)
+{
+	return driver_find_device(drv, start, NULL, device_match_any);
+}
+
 void driver_deferred_probe_add(struct device *dev);
 int driver_deferred_probe_check_state(struct device *dev);
 
-- 
2.7.4

