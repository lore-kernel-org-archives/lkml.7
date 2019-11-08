Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C828FC6196
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 15:16:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1599222CD
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 15:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573226199;
	bh=dH6xqBtVWWX4lmKBiNgrWT5il7BHO6Ej/hBNTMvHOC8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=azImGhlfDNCxv0lJh6LRcmIqvYnMwNR3ZrnXSMxbbLA1A0PxwTfQm6rktnaZN9I7C
	 IFKifyeO1K7oIgdvEwAiXGngiV3ULwW6eW7AEbme2Ax4U35WdOs2bH2CeXKoZ6KHOG
	 iFAMfMpVvbFEFUqF3Hcdit4t0dmaE91ZEsudLO5M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727653AbfKHPQh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 10:16:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:36374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727419AbfKHPQg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 10:16:36 -0500
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BDD3621882;
        Fri,  8 Nov 2019 15:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573226195;
        bh=dH6xqBtVWWX4lmKBiNgrWT5il7BHO6Ej/hBNTMvHOC8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lf+hWfCf227SsrZODLeStQ/SHJHLn78jIQDx3SGZmQl8JpVgy3PPwWj5PHCAQW2tV
         4q+WuBEynWLORzj7b2KIdXit9Dk+fdb2ToCqZcnxyK4DNxHWKfgg9gYuaezdghmxCL
         vOl3yPpME50prNvlTJogeYUyVRUOGws4JKgVyQRE=
From:   Will Deacon <will@kernel.org>
To:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc:     Will Deacon <will@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        John Garry <john.garry@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Saravana Kannan <saravanak@google.com>,
        "Isaac J. Manjarres" <isaacm@codeaurora.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v2 8/9] Revert "iommu/arm-smmu: Make arm-smmu explicitly non-modular"
Date:   Fri,  8 Nov 2019 15:16:07 +0000
Message-Id: <20191108151608.20932-9-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191108151608.20932-1-will@kernel.org>
References: <20191108151608.20932-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit addb672f200f4e99368270da205320b83efe01a0.

Let's get the SMMU driver building as a module, which means putting
back some dead code that we used to carry.

Signed-off-by: Will Deacon <will@kernel.org>
---
 drivers/iommu/arm-smmu.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 7c503a6bc585..53bbe0663b9e 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -27,8 +27,7 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
-#include <linux/init.h>
-#include <linux/moduleparam.h>
+#include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_device.h>
@@ -59,10 +58,6 @@
 #define MSI_IOVA_LENGTH			0x100000
 
 static int force_stage;
-/*
- * not really modular, but the easiest way to keep compat with existing
- * bootargs behaviour is to continue using module_param() here.
- */
 module_param(force_stage, int, S_IRUGO);
 MODULE_PARM_DESC(force_stage,
 	"Force SMMU mappings to be installed at a particular stage of translation. A value of '1' or '2' forces the corresponding stage. All other values are ignored (i.e. no stage is forced). Note that selecting a specific stage will disable support for nested translation.");
@@ -1878,6 +1873,7 @@ static const struct of_device_id arm_smmu_of_match[] = {
 	{ .compatible = "qcom,smmu-v2", .data = &qcom_smmuv2 },
 	{ },
 };
+MODULE_DEVICE_TABLE(of, arm_smmu_of_match);
 
 #ifdef CONFIG_ACPI
 static int acpi_smmu_get_data(u32 model, struct arm_smmu_device *smmu)
@@ -2165,12 +2161,12 @@ static int arm_smmu_legacy_bus_init(void)
 }
 device_initcall_sync(arm_smmu_legacy_bus_init);
 
-static void arm_smmu_device_shutdown(struct platform_device *pdev)
+static int arm_smmu_device_remove(struct platform_device *pdev)
 {
 	struct arm_smmu_device *smmu = platform_get_drvdata(pdev);
 
 	if (!smmu)
-		return;
+		return -ENODEV;
 
 	if (!bitmap_empty(smmu->context_map, ARM_SMMU_MAX_CBS))
 		dev_err(&pdev->dev, "removing device with active domains!\n");
@@ -2186,6 +2182,12 @@ static void arm_smmu_device_shutdown(struct platform_device *pdev)
 		clk_bulk_disable(smmu->num_clks, smmu->clks);
 
 	clk_bulk_unprepare(smmu->num_clks, smmu->clks);
+	return 0;
+}
+
+static void arm_smmu_device_shutdown(struct platform_device *pdev)
+{
+	arm_smmu_device_remove(pdev);
 }
 
 static int __maybe_unused arm_smmu_runtime_resume(struct device *dev)
@@ -2235,12 +2237,16 @@ static const struct dev_pm_ops arm_smmu_pm_ops = {
 
 static struct platform_driver arm_smmu_driver = {
 	.driver	= {
-		.name			= "arm-smmu",
-		.of_match_table		= of_match_ptr(arm_smmu_of_match),
-		.pm			= &arm_smmu_pm_ops,
-		.suppress_bind_attrs	= true,
+		.name		= "arm-smmu",
+		.of_match_table	= of_match_ptr(arm_smmu_of_match),
+		.pm		= &arm_smmu_pm_ops,
 	},
 	.probe	= arm_smmu_device_probe,
+	.remove	= arm_smmu_device_remove,
 	.shutdown = arm_smmu_device_shutdown,
 };
-builtin_platform_driver(arm_smmu_driver);
+module_platform_driver(arm_smmu_driver);
+
+MODULE_DESCRIPTION("IOMMU API for ARM architected SMMU implementations");
+MODULE_AUTHOR("Will Deacon <will.deacon@arm.com>");
+MODULE_LICENSE("GPL v2");
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

