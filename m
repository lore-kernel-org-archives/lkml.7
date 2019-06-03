Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 229B8C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 15:52:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F37A623957
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 15:52:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729588AbfFCPwU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 11:52:20 -0400
Received: from foss.arm.com ([217.140.101.70]:54068 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729553AbfFCPwQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 11:52:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 17DDD15AB;
        Mon,  3 Jun 2019 08:52:16 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B58773F246;
        Mon,  3 Jun 2019 08:52:14 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        suzuki.poulose@arm.com, Will Deacon <will.deacon@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>
Subject: [RFC PATCH 50/57] drivers: iommu: arm-smmu: Use driver_find_device_by_fwnode() helper
Date:   Mon,  3 Jun 2019 16:50:16 +0100
Message-Id: <1559577023-558-51-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1559577023-558-1-git-send-email-suzuki.poulose@arm.com>
References: <1559577023-558-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reuse the driver_find_device_by_fwnode() helper to lookup devices.

Cc: Will Deacon <will.deacon@arm.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/iommu/arm-smmu-v3.c | 9 ++-------
 drivers/iommu/arm-smmu.c    | 9 ++-------
 2 files changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index d787856..1f9851f 100644
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
+							  NULL, fwnode);
 	put_device(dev);
 	return dev ? dev_get_drvdata(dev) : NULL;
 }
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 4ce429b..c962e82 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1431,16 +1431,11 @@ static bool arm_smmu_capable(enum iommu_cap cap)
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
+							  NULL, fwnode);
 	put_device(dev);
 	return dev ? dev_get_drvdata(dev) : NULL;
 }
-- 
2.7.4

