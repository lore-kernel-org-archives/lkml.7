Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA26AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 13:14:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A79020857
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 13:14:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727640AbfCRNOb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 09:14:31 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:52246 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727257AbfCRNO3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 09:14:29 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id CDF98E8185D9CA8E2875;
        Mon, 18 Mar 2019 21:14:27 +0800 (CST)
Received: from HGHY1l002753561.china.huawei.com (10.177.23.164) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.408.0; Mon, 18 Mar 2019 21:14:17 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v2 2/2] iommu/arm-smmu-v3: to make smmu can be enabled in the kdump kernel
Date:   Mon, 18 Mar 2019 21:12:43 +0800
Message-ID: <20190318131243.20716-3-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.19.2.windows.1
In-Reply-To: <20190318131243.20716-1-thunder.leizhen@huawei.com>
References: <20190318131243.20716-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.177.23.164]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I don't known why device_shutdown() is not called in the first kernel
before the execution switch to the secondary kernel. People may afraid
that the function may lead the kernel to be crashed again, because it
contains too many operations, lead the secondary kernel can not be
entered finally.
  
Maybe the configuration of a device driver is set in the first kernel,
but it's not set in the secondary kernel, because of the limited memory
resources. (In order to facilitate the description, mark this kind of
devices as "unexpected devices".) Because the device was not shutdown in
the first kernel, so it may still access memory in the secondary kernel.
For example, a netcard may still using its ring buffer to auto receive
the external network packets in the secondary kernel.

commit b63b3439b856 ("iommu/arm-smmu-v3: Abort all transactions if SMMU
is enabled in kdump kernel") set SMMU_GBPA.ABORT to abort the unexpected
devices access, but it also abort the memory access of the devices which
we needed, like netcard. For example, a system may have no harddisk, and
the vmcore should be dumped through network. 

In fact, we can use STE.config=0b000 to abort the memory access of the
unexpected devices only. Show as below:
1. In the first kernel, all buffers used by the "unexpected" devices are
   correctly mapped, and it will not be corrupted by the secondary kernel
   because the latter has its dedicated reserved memory.
2. Enter the secondary kernel, set SMMU_GBPA.ABORT=1 then disable smmu.
3. Preset all STE entries: STE.config=0b000. For 2-level Stream Table,
   pre-allocated a dummy L2ST(Level 2 Stream Table) and make all
   L1STD.l2ptr pointer to the dummy L2ST. The dummy L2ST is shared by all
   L1STDs(Level 1 Stream Table Descriptor).
4. Enable smmu. After now, a new attached device if needed, will allocate
   a new L2ST accordingly, and change the related L1STD.l2ptr pointer to
   it. 
   Please note that, we still base desc->l2ptr to judge whether the L2ST
   have been allocated or not, and don't care the value of L1STD.l2ptr.

Fixes: commit b63b3439b856 ("iommu/arm-smmu-v3: Abort all transactions ...")
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/iommu/arm-smmu-v3.c | 72 ++++++++++++++++++++++++++++++++-------------
 1 file changed, 51 insertions(+), 21 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 9b6afa8e69f70f6..28b04d4aef62a9f 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -1218,35 +1218,57 @@ static void arm_smmu_init_bypass_stes(u64 *strtab, unsigned int nent)
 	}
 }
 
-static int arm_smmu_init_l2_strtab(struct arm_smmu_device *smmu, u32 sid)
+static int __arm_smmu_init_l2_strtab(struct arm_smmu_device *smmu, u32 sid,
+				     struct arm_smmu_strtab_l1_desc *desc)
 {
-	size_t size;
 	void *strtab;
 	struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;
-	struct arm_smmu_strtab_l1_desc *desc = &cfg->l1_desc[sid >> STRTAB_SPLIT];
 
-	if (desc->l2ptr)
-		return 0;
-
-	size = 1 << (STRTAB_SPLIT + ilog2(STRTAB_STE_DWORDS) + 3);
 	strtab = &cfg->strtab[(sid >> STRTAB_SPLIT) * STRTAB_L1_DESC_DWORDS];
 
-	desc->span = STRTAB_SPLIT + 1;
-	desc->l2ptr = dmam_alloc_coherent(smmu->dev, size, &desc->l2ptr_dma,
-					  GFP_KERNEL | __GFP_ZERO);
 	if (!desc->l2ptr) {
-		dev_err(smmu->dev,
-			"failed to allocate l2 stream table for SID %u\n",
-			sid);
-		return -ENOMEM;
+		size_t size;
+
+		size = 1 << (STRTAB_SPLIT + ilog2(STRTAB_STE_DWORDS) + 3);
+		desc->l2ptr = dmam_alloc_coherent(smmu->dev, size,
+						  &desc->l2ptr_dma,
+						  GFP_KERNEL | __GFP_ZERO);
+		if (!desc->l2ptr) {
+			dev_err(smmu->dev,
+				"failed to allocate l2 stream table for SID %u\n",
+				sid);
+			return -ENOMEM;
+		}
+
+		desc->span = STRTAB_SPLIT + 1;
+		arm_smmu_init_bypass_stes(desc->l2ptr, 1 << STRTAB_SPLIT);
 	}
 
-	arm_smmu_init_bypass_stes(desc->l2ptr, 1 << STRTAB_SPLIT);
 	arm_smmu_write_strtab_l1_desc(strtab, desc);
+	return 0;
+}
+
+static int arm_smmu_init_l2_strtab(struct arm_smmu_device *smmu, u32 sid)
+{
+	int ret;
+	struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;
+	struct arm_smmu_strtab_l1_desc *desc = &cfg->l1_desc[sid >> STRTAB_SPLIT];
+
+	ret = __arm_smmu_init_l2_strtab(smmu, sid, desc);
+	if (ret)
+		return ret;
+
 	arm_smmu_sync_std_for_sid(smmu, sid);
 	return 0;
 }
 
+static int arm_smmu_init_dummy_l2_strtab(struct arm_smmu_device *smmu, u32 sid)
+{
+	static struct arm_smmu_strtab_l1_desc dummy_desc;
+
+	return __arm_smmu_init_l2_strtab(smmu, sid, &dummy_desc);
+}
+
 /* IRQ and event handlers */
 static irqreturn_t arm_smmu_evtq_thread(int irq, void *dev)
 {
@@ -2149,8 +2171,12 @@ static int arm_smmu_init_l1_strtab(struct arm_smmu_device *smmu)
 	}
 
 	for (i = 0; i < cfg->num_l1_ents; ++i) {
-		arm_smmu_write_strtab_l1_desc(strtab, &cfg->l1_desc[i]);
-		strtab += STRTAB_L1_DESC_DWORDS << 3;
+		if (is_kdump_kernel()) {
+			arm_smmu_init_dummy_l2_strtab(smmu, i << STRTAB_SPLIT);
+		} else {
+			arm_smmu_write_strtab_l1_desc(strtab, &cfg->l1_desc[i]);
+			strtab += STRTAB_L1_DESC_DWORDS << 3;
+		}
 	}
 
 	return 0;
@@ -2466,11 +2492,8 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu, bool bypass)
 	/* Clear CR0 and sync (disables SMMU and queue processing) */
 	reg = readl_relaxed(smmu->base + ARM_SMMU_CR0);
 	if (reg & CR0_SMMUEN) {
-		if (is_kdump_kernel()) {
+		if (is_kdump_kernel())
 			arm_smmu_update_gbpa(smmu, GBPA_ABORT, 0);
-			arm_smmu_device_disable(smmu);
-			return -EBUSY;
-		}
 
 		dev_warn(smmu->dev, "SMMU currently enabled! Resetting...\n");
 	}
@@ -2858,6 +2881,13 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	bool bypass;
 
+	/*
+	 * Force to disable bypass in the kdump kernel, abort all incoming
+	 * transactions from the unknown devices.
+	 */
+	if (is_kdump_kernel())
+		disable_bypass = 1;
+
 	smmu = devm_kzalloc(dev, sizeof(*smmu), GFP_KERNEL);
 	if (!smmu) {
 		dev_err(dev, "failed to allocate arm_smmu_device\n");
-- 
1.8.3


