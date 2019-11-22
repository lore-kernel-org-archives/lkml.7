Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24875C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 03:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 000A320679
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 03:08:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbfKVDIk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 22:08:40 -0500
Received: from mga14.intel.com ([192.55.52.115]:53712 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726335AbfKVDI0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 22:08:26 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Nov 2019 19:08:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,228,1571727600"; 
   d="scan'208";a="232540449"
Received: from allen-box.sh.intel.com ([10.239.159.136])
  by fmsmga004.fm.intel.com with ESMTP; 21 Nov 2019 19:08:25 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     David Woodhouse <dwmw2@infradead.org>, ashok.raj@intel.com,
        jacob.jun.pan@linux.intel.com, kevin.tian@intel.com,
        Eric Auger <eric.auger@redhat.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 3/5] iommu/vt-d: Consolidate device tlb invalidation
Date:   Fri, 22 Nov 2019 11:04:47 +0800
Message-Id: <20191122030449.28892-4-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191122030449.28892-1-baolu.lu@linux.intel.com>
References: <20191122030449.28892-1-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Merge device tlb invalidation into iommu->flush.dev_tlb_inv.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/dmar.c        | 23 -----------------------
 drivers/iommu/intel-iommu.c | 31 +++++++++++++++++++++++++++++--
 drivers/iommu/intel-pasid.c |  3 ++-
 include/linux/intel-iommu.h |  2 --
 4 files changed, 31 insertions(+), 28 deletions(-)

diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
index 4b6090493f6d..8e26a36369ec 100644
--- a/drivers/iommu/dmar.c
+++ b/drivers/iommu/dmar.c
@@ -1307,29 +1307,6 @@ void qi_global_iec(struct intel_iommu *iommu)
 	qi_submit_sync(&desc, iommu);
 }
 
-void qi_flush_dev_iotlb(struct intel_iommu *iommu, u16 sid, u16 pfsid,
-			u16 qdep, u64 addr, unsigned mask)
-{
-	struct qi_desc desc;
-
-	if (mask) {
-		WARN_ON_ONCE(addr & ((1ULL << (VTD_PAGE_SHIFT + mask)) - 1));
-		addr |= (1ULL << (VTD_PAGE_SHIFT + mask - 1)) - 1;
-		desc.qw1 = QI_DEV_IOTLB_ADDR(addr) | QI_DEV_IOTLB_SIZE;
-	} else
-		desc.qw1 = QI_DEV_IOTLB_ADDR(addr);
-
-	if (qdep >= QI_DEV_IOTLB_MAX_INVS)
-		qdep = 0;
-
-	desc.qw0 = QI_DEV_IOTLB_SID(sid) | QI_DEV_IOTLB_QDEP(qdep) |
-		   QI_DIOTLB_TYPE | QI_DEV_IOTLB_PFSID(pfsid);
-	desc.qw2 = 0;
-	desc.qw3 = 0;
-
-	qi_submit_sync(&desc, iommu);
-}
-
 /*
  * Disable Queued Invalidation interface.
  */
diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 283382584453..4eeb18942d3c 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -1465,6 +1465,7 @@ static void iommu_flush_dev_iotlb(struct dmar_domain *domain,
 {
 	u16 sid, qdep;
 	unsigned long flags;
+	struct intel_iommu *iommu;
 	struct device_domain_info *info;
 
 	if (!domain->has_iotlb_device)
@@ -1477,8 +1478,9 @@ static void iommu_flush_dev_iotlb(struct dmar_domain *domain,
 
 		sid = info->bus << 8 | info->devfn;
 		qdep = info->ats_qdep;
-		qi_flush_dev_iotlb(info->iommu, sid, info->pfsid,
-				qdep, addr, mask);
+		iommu = info->iommu;
+		iommu->flush.dev_tlb_inv(iommu, sid, info->pfsid,
+					 qdep, addr, mask);
 	}
 	spin_unlock_irqrestore(&device_domain_lock, flags);
 }
@@ -3006,6 +3008,30 @@ qi_flush_pasid(struct intel_iommu *iommu, u16 did, u32 pasid, u64 granu)
 	qi_submit_sync(&desc, iommu);
 }
 
+/* Device TLB invalidation */
+static void
+qi_flush_dev_iotlb(struct intel_iommu *iommu, u16 sid, u16 pfsid,
+		   u16 qdep, u64 addr, unsigned int mask)
+{
+	struct qi_desc desc = {.qw2 = 0, .qw3 = 0};
+
+	if (mask) {
+		WARN_ON_ONCE(addr & ((1ULL << (VTD_PAGE_SHIFT + mask)) - 1));
+		addr |= (1ULL << (VTD_PAGE_SHIFT + mask - 1)) - 1;
+		desc.qw1 = QI_DEV_IOTLB_ADDR(addr) | QI_DEV_IOTLB_SIZE;
+	} else {
+		desc.qw1 = QI_DEV_IOTLB_ADDR(addr);
+	}
+
+	if (qdep >= QI_DEV_IOTLB_MAX_INVS)
+		qdep = 0;
+
+	desc.qw0 = QI_DEV_IOTLB_SID(sid) | QI_DEV_IOTLB_QDEP(qdep) |
+		   QI_DIOTLB_TYPE | QI_DEV_IOTLB_PFSID(pfsid);
+
+	qi_submit_sync(&desc, iommu);
+}
+
 static void intel_iommu_init_qi(struct intel_iommu *iommu)
 {
 	/*
@@ -3038,6 +3064,7 @@ static void intel_iommu_init_qi(struct intel_iommu *iommu)
 		iommu->flush.cc_inv = qi_flush_context;
 		iommu->flush.iotlb_inv = qi_flush_iotlb;
 		iommu->flush.pc_inv = qi_flush_pasid;
+		iommu->flush.dev_tlb_inv = qi_flush_dev_iotlb;
 		pr_info("%s: Using Queued invalidation\n", iommu->name);
 	}
 }
diff --git a/drivers/iommu/intel-pasid.c b/drivers/iommu/intel-pasid.c
index dd736f673603..01dd9c86178b 100644
--- a/drivers/iommu/intel-pasid.c
+++ b/drivers/iommu/intel-pasid.c
@@ -388,7 +388,8 @@ devtlb_invalidation_with_pasid(struct intel_iommu *iommu,
 	qdep = info->ats_qdep;
 	pfsid = info->pfsid;
 
-	qi_flush_dev_iotlb(iommu, sid, pfsid, qdep, 0, 64 - VTD_PAGE_SHIFT);
+	iommu->flush.dev_tlb_inv(iommu, sid, pfsid, qdep,
+				 0, 64 - VTD_PAGE_SHIFT);
 }
 
 void intel_pasid_tear_down_entry(struct intel_iommu *iommu,
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index c32ff2a7d958..326146a36dbf 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -665,8 +665,6 @@ extern void dmar_disable_qi(struct intel_iommu *iommu);
 extern int dmar_reenable_qi(struct intel_iommu *iommu);
 extern void qi_global_iec(struct intel_iommu *iommu);
 
-extern void qi_flush_dev_iotlb(struct intel_iommu *iommu, u16 sid, u16 pfsid,
-			u16 qdep, u64 addr, unsigned mask);
 extern int qi_submit_sync(struct qi_desc *desc, struct intel_iommu *iommu);
 
 extern int dmar_ir_support(void);
-- 
2.17.1

