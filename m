Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B512BC74A35
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 15:03:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A4FB2166E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 15:03:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728949AbfGKPDS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 11:03:18 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:58333 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728876AbfGKPDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 11:03:16 -0400
X-Originating-IP: 92.137.69.152
Received: from localhost (alyon-656-1-672-152.w92-137.abo.wanadoo.fr [92.137.69.152])
        (Authenticated sender: gregory.clement@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 516F740008;
        Thu, 11 Jul 2019 15:03:12 +0000 (UTC)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        =?UTF-8?q?Miqu=C3=A8l=20Raynal?= <miquel.raynal@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>,
        Hanna Hawa <hannah@marvell.com>
Subject: [PATCH v2 2/4] iommu/arm-smmu: Workaround for Marvell Armada-AP806 SoC erratum #582743
Date:   Thu, 11 Jul 2019 17:02:40 +0200
Message-Id: <20190711150242.25290-3-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190711150242.25290-1-gregory.clement@bootlin.com>
References: <20190711150242.25290-1-gregory.clement@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hanna Hawa <hannah@marvell.com>

Due to erratum #582743, the Marvell Armada-AP806 can't access 64bit to
ARM SMMUv2 registers.

This patch split the writeq/readq to two accesses of writel/readl.

We also mask the MMU_IDR2.PTFSv8 fields to not use AArch64 format but
only AARCH32_L. Indeed with AArch64 format 32 bits acces is not
supported.

Note that separate writes/reads to 2 is not problem regards to
atomicity, because the driver use the readq/writeq while initialize
the SMMU, report for SMMU fault, and use spinlock in one
case (iova_to_phys).

Signed-off-by: Hanna Hawa <hannah@marvell.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 Documentation/arm64/silicon-errata.txt |  2 ++
 drivers/iommu/arm-smmu.c               | 42 +++++++++++++++++++++++---
 2 files changed, 40 insertions(+), 4 deletions(-)

diff --git a/Documentation/arm64/silicon-errata.txt b/Documentation/arm64/silicon-errata.txt
index d1e2bb801e1b..3f78ae7a7690 100644
--- a/Documentation/arm64/silicon-errata.txt
+++ b/Documentation/arm64/silicon-errata.txt
@@ -72,6 +72,8 @@ stable kernels.
 | Cavium         | ThunderX2 SMMUv3| #74             | N/A                         |
 | Cavium         | ThunderX2 SMMUv3| #126            | N/A                         |
 |                |                 |                 |                             |
+| Marvell        | ARM-MMU-500     | #582743         | N/A                         |
+|                |                 |                 |                             |
 | Freescale/NXP  | LS2080A/LS1043A | A-008585        | FSL_ERRATUM_A008585         |
 |                |                 |                 |                             |
 | Hisilicon      | Hip0{5,6,7}     | #161010101      | HISILICON_ERRATUM_161010101 |
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index ac0784b5b675..32536ccae22d 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -126,6 +126,7 @@ enum arm_smmu_arch_version {
 enum arm_smmu_implementation {
 	GENERIC_SMMU,
 	ARM_MMU500,
+	MRVL_MMU500,
 	CAVIUM_SMMUV2,
 	QCOM_SMMUV2,
 };
@@ -301,13 +302,35 @@ static inline void smmu_writeq_relaxed(struct arm_smmu_device *smmu,
 				       u64 val,
 				       void __iomem *addr)
 {
-	writeq_relaxed(val, addr);
+	/*
+	 * Marvell Armada-AP806 erratum #582743.
+	 * Split all the writeq to double writel
+	 */
+	if (smmu->model != MRVL_MMU500) {
+		writeq_relaxed(val, addr);
+		return;
+	}
+
+	writel_relaxed(upper_32_bits(val), addr + 4);
+	writel_relaxed(lower_32_bits(val), addr);
 }
 
 static inline u64 smmu_readq_relaxed(struct arm_smmu_device *smmu,
 				     void __iomem *addr)
 {
-	return readq_relaxed(addr);
+	u64 val;
+
+	/*
+	 * Marvell Armada-AP806 erratum #582743.
+	 * Split all the readq to double readl
+	 */
+	if (smmu->model != MRVL_MMU500)
+		return readq_relaxed(addr);
+
+	val = (u64)readl_relaxed(addr + 4) << 32;
+	val |= readl_relaxed(addr);
+
+	return val;
 }
 
 static void parse_driver_options(struct arm_smmu_device *smmu)
@@ -1741,7 +1764,7 @@ static void arm_smmu_device_reset(struct arm_smmu_device *smmu)
 	for (i = 0; i < smmu->num_mapping_groups; ++i)
 		arm_smmu_write_sme(smmu, i);
 
-	if (smmu->model == ARM_MMU500) {
+	if (smmu->model == ARM_MMU500 || smmu->model == MRVL_MMU500) {
 		/*
 		 * Before clearing ARM_MMU500_ACTLR_CPRE, need to
 		 * clear CACHE_LOCK bit of ACR first. And, CACHE_LOCK
@@ -1770,7 +1793,7 @@ static void arm_smmu_device_reset(struct arm_smmu_device *smmu)
 		 * Disable MMU-500's not-particularly-beneficial next-page
 		 * prefetcher for the sake of errata #841119 and #826419.
 		 */
-		if (smmu->model == ARM_MMU500) {
+		if (smmu->model == ARM_MMU500 || smmu->model == MRVL_MMU500) {
 			reg = readl_relaxed(cb_base + ARM_SMMU_CB_ACTLR);
 			reg &= ~ARM_MMU500_ACTLR_CPRE;
 			writel_relaxed(reg, cb_base + ARM_SMMU_CB_ACTLR);
@@ -1987,6 +2010,15 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
 	if (id & ID2_VMID16)
 		smmu->features |= ARM_SMMU_FEAT_VMID16;
 
+	/*
+	 * Armada-AP806 erratum #582743.
+	 * Hide the SMMU_IDR2.PTFSv8 fields to sidestep the AArch64
+	 * formats altogether and allow using 32 bits access on the
+	 * interconnect.
+	 */
+	if (smmu->model == MRVL_MMU500)
+		id &= ~(ID2_PTFS_4K | ID2_PTFS_16K | ID2_PTFS_64K);
+
 	/*
 	 * What the page table walker can address actually depends on which
 	 * descriptor format is in use, but since a) we don't know that yet,
@@ -2053,6 +2085,7 @@ ARM_SMMU_MATCH_DATA(smmu_generic_v1, ARM_SMMU_V1, GENERIC_SMMU);
 ARM_SMMU_MATCH_DATA(smmu_generic_v2, ARM_SMMU_V2, GENERIC_SMMU);
 ARM_SMMU_MATCH_DATA(arm_mmu401, ARM_SMMU_V1_64K, GENERIC_SMMU);
 ARM_SMMU_MATCH_DATA(arm_mmu500, ARM_SMMU_V2, ARM_MMU500);
+ARM_SMMU_MATCH_DATA(mrvl_mmu500, ARM_SMMU_V2, MRVL_MMU500);
 ARM_SMMU_MATCH_DATA(cavium_smmuv2, ARM_SMMU_V2, CAVIUM_SMMUV2);
 ARM_SMMU_MATCH_DATA(qcom_smmuv2, ARM_SMMU_V2, QCOM_SMMUV2);
 
@@ -2062,6 +2095,7 @@ static const struct of_device_id arm_smmu_of_match[] = {
 	{ .compatible = "arm,mmu-400", .data = &smmu_generic_v1 },
 	{ .compatible = "arm,mmu-401", .data = &arm_mmu401 },
 	{ .compatible = "arm,mmu-500", .data = &arm_mmu500 },
+	{ .compatible = "marvell,mmu-500", .data = &mrvl_mmu500 },
 	{ .compatible = "cavium,smmu-v2", .data = &cavium_smmuv2 },
 	{ .compatible = "qcom,smmu-v2", .data = &qcom_smmuv2 },
 	{ },
-- 
2.20.1

