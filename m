Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB0ABC35280
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 14:37:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA85621906
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 14:37:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731752AbfI3OhB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 10:37:01 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:58450 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730780AbfI3OhA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 10:37:00 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 5BFA948E40CC6B5FE5AE;
        Mon, 30 Sep 2019 22:36:58 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.439.0; Mon, 30 Sep 2019 22:36:50 +0800
From:   John Garry <john.garry@huawei.com>
To:     <lorenzo.pieralisi@arm.com>, <guohanjun@huawei.com>,
        <sudeep.holla@arm.com>, <robin.murphy@arm.com>,
        <mark.rutland@arm.com>, <will@kernel.org>
CC:     <shameerali.kolothum.thodi@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
        <rjw@rjwysocki.net>, <lenb@kernel.org>, <nleeder@codeaurora.org>,
        <linuxarm@huawei.com>, John Garry <john.garry@huawei.com>
Subject: [RFC PATCH 6/6] ACPI/IORT: Drop code to set the PMCG software-defined model
Date:   Mon, 30 Sep 2019 22:33:51 +0800
Message-ID: <1569854031-237636-7-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1569854031-237636-1-git-send-email-john.garry@huawei.com>
References: <1569854031-237636-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we can identify a PMCG implementation from the parent SMMUv3
IIDR, drop all the code to match based on the ACPI OEM ID.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/acpi/arm64/iort.c | 35 +----------------------------------
 include/linux/acpi_iort.h |  8 --------
 2 files changed, 1 insertion(+), 42 deletions(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 0b687520c3e7..d04888cb8cff 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -1377,27 +1377,6 @@ static void __init arm_smmu_v3_pmcg_init_resources(struct resource *res,
 				       ACPI_EDGE_SENSITIVE, &res[2]);
 }
 
-static struct acpi_platform_list pmcg_plat_info[] __initdata = {
-	/* HiSilicon Hip08 Platform */
-	{"HISI  ", "HIP08   ", 0, ACPI_SIG_IORT, greater_than_or_equal,
-	 "Erratum #162001800", IORT_SMMU_V3_PMCG_HISI_HIP08},
-	{ }
-};
-
-static int __init arm_smmu_v3_pmcg_add_platdata(struct platform_device *pdev)
-{
-	u32 model;
-	int idx;
-
-	idx = acpi_match_platform_list(pmcg_plat_info);
-	if (idx >= 0)
-		model = pmcg_plat_info[idx].data;
-	else
-		model = IORT_SMMU_V3_PMCG_GENERIC;
-
-	return platform_device_add_data(pdev, &model, sizeof(model));
-}
-
 struct iort_dev_config {
 	const char *name;
 	int (*dev_init)(struct acpi_iort_node *node);
@@ -1408,7 +1387,6 @@ struct iort_dev_config {
 				     struct acpi_iort_node *node);
 	int (*dev_set_proximity)(struct device *dev,
 				    struct acpi_iort_node *node);
-	int (*dev_add_platdata)(struct platform_device *pdev);
 };
 
 static const struct iort_dev_config iort_arm_smmu_v3_cfg __initconst = {
@@ -1430,7 +1408,6 @@ static const struct iort_dev_config iort_arm_smmu_v3_pmcg_cfg __initconst = {
 	.name = "arm-smmu-v3-pmcg",
 	.dev_count_resources = arm_smmu_v3_pmcg_count_resources,
 	.dev_init_resources = arm_smmu_v3_pmcg_init_resources,
-	.dev_add_platdata = arm_smmu_v3_pmcg_add_platdata,
 };
 
 static __init const struct iort_dev_config *iort_get_dev_cfg(
@@ -1494,17 +1471,7 @@ static int __init iort_add_platform_device(struct acpi_iort_node *node,
 	if (ret)
 		goto dev_put;
 
-	/*
-	 * Platform devices based on PMCG nodes uses platform_data to
-	 * pass the hardware model info to the driver. For others, add
-	 * a copy of IORT node pointer to platform_data to be used to
-	 * retrieve IORT data information.
-	 */
-	if (ops->dev_add_platdata)
-		ret = ops->dev_add_platdata(pdev);
-	else
-		ret = platform_device_add_data(pdev, &node, sizeof(node));
-
+	ret = platform_device_add_data(pdev, &node, sizeof(node));
 	if (ret)
 		goto dev_put;
 
diff --git a/include/linux/acpi_iort.h b/include/linux/acpi_iort.h
index 8e7e2ec37f1b..7a8961e6a8bb 100644
--- a/include/linux/acpi_iort.h
+++ b/include/linux/acpi_iort.h
@@ -14,14 +14,6 @@
 #define IORT_IRQ_MASK(irq)		(irq & 0xffffffffULL)
 #define IORT_IRQ_TRIGGER_MASK(irq)	((irq >> 32) & 0xffffffffULL)
 
-/*
- * PMCG model identifiers for use in smmu pmu driver. Please note
- * that this is purely for the use of software and has nothing to
- * do with hardware or with IORT specification.
- */
-#define IORT_SMMU_V3_PMCG_GENERIC        0x00000000 /* Generic SMMUv3 PMCG */
-#define IORT_SMMU_V3_PMCG_HISI_HIP08     0x00000001 /* HiSilicon HIP08 PMCG */
-
 int iort_register_domain_token(int trans_id, phys_addr_t base,
 			       struct fwnode_handle *fw_node);
 void iort_deregister_domain_token(int trans_id);
-- 
2.17.1

