Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10129C31E4C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 17:55:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAC522183E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 17:55:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbfFNRz3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 13:55:29 -0400
Received: from foss.arm.com ([217.140.110.172]:39694 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727700AbfFNRz1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 13:55:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 67A60D6E;
        Fri, 14 Jun 2019 10:55:27 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 64D113F718;
        Fri, 14 Jun 2019 10:55:26 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        suzuki.poulose@arm.com, Will Deacon <will.deacon@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v2 24/28] drivers: Introduce driver_find_device_by_fwnode() helper
Date:   Fri, 14 Jun 2019 18:54:19 +0100
Message-Id: <1560534863-15115-25-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1560534863-15115-1-git-send-email-suzuki.poulose@arm.com>
References: <1560534863-15115-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a wrapper to driver_find_device() to search for a device
by the fwnode pointer, reusing the generic match function.
Also convert the existing users to make use of the new helper.

Cc: Will Deacon <will.deacon@arm.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/iommu/arm-smmu-v3.c |  9 ++-------
 drivers/iommu/arm-smmu.c    |  9 ++-------
 include/linux/device.h      | 13 +++++++++++++
 3 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index d787856..6b956a03 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -2023,16 +2023,11 @@ arm_smmu_iova_to_phys(struct iommu_domain *domain, dma_addr_t iova)
 
 static struct platform_driver arm_smmu_driver;
 
-static int arm_smmu_match_node(struct device *dev, const void *data)
-{
-	return dev->fwnode == data;
-}
-
 static
 struct arm_smmu_device *arm_smmu_get_by_fwnode(struct fwnode_handle *fwnode)
 {
-	struct device *dev = driver_find_device(&arm_smmu_driver.driver, NULL,
-						fwnode, arm_smmu_match_node);
+	struct device *dev = driver_find_device_by_fwnode(&arm_smmu_driver.driver,
+							  fwnode);
 	put_device(dev);
 	return dev ? dev_get_drvdata(dev) : NULL;
 }
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 3af579a..0d63a9e 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1419,16 +1419,11 @@ static bool arm_smmu_capable(enum iommu_cap cap)
 	}
 }
 
-static int arm_smmu_match_node(struct device *dev, const void *data)
-{
-	return dev->fwnode == data;
-}
-
 static
 struct arm_smmu_device *arm_smmu_get_by_fwnode(struct fwnode_handle *fwnode)
 {
-	struct device *dev = driver_find_device(&arm_smmu_driver.driver, NULL,
-						fwnode, arm_smmu_match_node);
+	struct device *dev = driver_find_device_by_fwnode(&arm_smmu_driver.driver,
+							  fwnode);
 	put_device(dev);
 	return dev ? dev_get_drvdata(dev) : NULL;
 }
diff --git a/include/linux/device.h b/include/linux/device.h
index f929671..2cf49f7 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -450,6 +450,19 @@ driver_find_device_by_of_node(struct device_driver *drv,
 	return driver_find_device(drv, NULL, np, device_match_of_node);
 }
 
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
 void driver_deferred_probe_add(struct device *dev);
 int driver_deferred_probe_check_state(struct device *dev);
 
-- 
2.7.4

