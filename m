Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EF52C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 03:08:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D39F820679
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 03:08:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbfKVDIZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 22:08:25 -0500
Received: from mga14.intel.com ([192.55.52.115]:53712 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726335AbfKVDIX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 22:08:23 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Nov 2019 19:08:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,228,1571727600"; 
   d="scan'208";a="232540437"
Received: from allen-box.sh.intel.com ([10.239.159.136])
  by fmsmga004.fm.intel.com with ESMTP; 21 Nov 2019 19:08:21 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     David Woodhouse <dwmw2@infradead.org>, ashok.raj@intel.com,
        jacob.jun.pan@linux.intel.com, kevin.tian@intel.com,
        Eric Auger <eric.auger@redhat.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 1/5] iommu/vt-d: Extend iommu_flush for scalable mode
Date:   Fri, 22 Nov 2019 11:04:45 +0800
Message-Id: <20191122030449.28892-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191122030449.28892-1-baolu.lu@linux.intel.com>
References: <20191122030449.28892-1-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Intel VT-d 3.0 introduces more cache flush interfaces when it
runs in the scalable mode. Currently various cache flush helpers
are scattered around. This consolidates them by putting them in
the existing iommu_flush structure. The name of each cache flush
operation is defined according to the spec (section 6.5) so that
people are easy to look up them in the spec.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/dmar.c        |  38 ------------
 drivers/iommu/intel-iommu.c | 118 ++++++++++++++++++++++--------------
 include/linux/intel-iommu.h |  34 ++++++++---
 3 files changed, 98 insertions(+), 92 deletions(-)

diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
index eecd6a421667..4b6090493f6d 100644
--- a/drivers/iommu/dmar.c
+++ b/drivers/iommu/dmar.c
@@ -1307,44 +1307,6 @@ void qi_global_iec(struct intel_iommu *iommu)
 	qi_submit_sync(&desc, iommu);
 }
 
-void qi_flush_context(struct intel_iommu *iommu, u16 did, u16 sid, u8 fm,
-		      u64 type)
-{
-	struct qi_desc desc;
-
-	desc.qw0 = QI_CC_FM(fm) | QI_CC_SID(sid) | QI_CC_DID(did)
-			| QI_CC_GRAN(type) | QI_CC_TYPE;
-	desc.qw1 = 0;
-	desc.qw2 = 0;
-	desc.qw3 = 0;
-
-	qi_submit_sync(&desc, iommu);
-}
-
-void qi_flush_iotlb(struct intel_iommu *iommu, u16 did, u64 addr,
-		    unsigned int size_order, u64 type)
-{
-	u8 dw = 0, dr = 0;
-
-	struct qi_desc desc;
-	int ih = 0;
-
-	if (cap_write_drain(iommu->cap))
-		dw = 1;
-
-	if (cap_read_drain(iommu->cap))
-		dr = 1;
-
-	desc.qw0 = QI_IOTLB_DID(did) | QI_IOTLB_DR(dr) | QI_IOTLB_DW(dw)
-		| QI_IOTLB_GRAN(type) | QI_IOTLB_TYPE;
-	desc.qw1 = QI_IOTLB_ADDR(addr) | QI_IOTLB_IH(ih)
-		| QI_IOTLB_AM(size_order);
-	desc.qw2 = 0;
-	desc.qw3 = 0;
-
-	qi_submit_sync(&desc, iommu);
-}
-
 void qi_flush_dev_iotlb(struct intel_iommu *iommu, u16 sid, u16 pfsid,
 			u16 qdep, u64 addr, unsigned mask)
 {
diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index b9d11f2e3194..59e4130161eb 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -1503,11 +1503,10 @@ static void iommu_flush_iotlb_psi(struct intel_iommu *iommu,
 	 * aligned to the size
 	 */
 	if (!cap_pgsel_inv(iommu->cap) || mask > cap_max_amask_val(iommu->cap))
-		iommu->flush.flush_iotlb(iommu, did, 0, 0,
-						DMA_TLB_DSI_FLUSH);
+		iommu->flush.iotlb_inv(iommu, did, 0, 0, DMA_TLB_DSI_FLUSH);
 	else
-		iommu->flush.flush_iotlb(iommu, did, addr | ih, mask,
-						DMA_TLB_PSI_FLUSH);
+		iommu->flush.iotlb_inv(iommu, did, addr | ih,
+				       mask, DMA_TLB_PSI_FLUSH);
 
 	/*
 	 * In caching mode, changes of pages from non-present to present require
@@ -1540,7 +1539,7 @@ static void iommu_flush_iova(struct iova_domain *iovad)
 		struct intel_iommu *iommu = g_iommus[idx];
 		u16 did = domain->iommu_did[iommu->seq_id];
 
-		iommu->flush.flush_iotlb(iommu, did, 0, 0, DMA_TLB_DSI_FLUSH);
+		iommu->flush.iotlb_inv(iommu, did, 0, 0, DMA_TLB_DSI_FLUSH);
 
 		if (!cap_caching_mode(iommu->cap))
 			iommu_flush_dev_iotlb(get_iommu_domain(iommu, did),
@@ -2017,12 +2016,12 @@ static int domain_context_mapping_one(struct dmar_domain *domain,
 		u16 did_old = context_domain_id(context);
 
 		if (did_old < cap_ndoms(iommu->cap)) {
-			iommu->flush.flush_context(iommu, did_old,
-						   (((u16)bus) << 8) | devfn,
-						   DMA_CCMD_MASK_NOBIT,
-						   DMA_CCMD_DEVICE_INVL);
-			iommu->flush.flush_iotlb(iommu, did_old, 0, 0,
-						 DMA_TLB_DSI_FLUSH);
+			iommu->flush.cc_inv(iommu, did_old,
+					    (((u16)bus) << 8) | devfn,
+					    DMA_CCMD_MASK_NOBIT,
+					    DMA_CCMD_DEVICE_INVL);
+			iommu->flush.iotlb_inv(iommu, did_old, 0, 0,
+					       DMA_TLB_DSI_FLUSH);
 		}
 	}
 
@@ -2099,11 +2098,11 @@ static int domain_context_mapping_one(struct dmar_domain *domain,
 	 * domain #0, which we have to flush:
 	 */
 	if (cap_caching_mode(iommu->cap)) {
-		iommu->flush.flush_context(iommu, 0,
-					   (((u16)bus) << 8) | devfn,
-					   DMA_CCMD_MASK_NOBIT,
-					   DMA_CCMD_DEVICE_INVL);
-		iommu->flush.flush_iotlb(iommu, did, 0, 0, DMA_TLB_DSI_FLUSH);
+		iommu->flush.cc_inv(iommu, 0,
+				    (((u16)bus) << 8) | devfn,
+				    DMA_CCMD_MASK_NOBIT,
+				    DMA_CCMD_DEVICE_INVL);
+		iommu->flush.iotlb_inv(iommu, did, 0, 0, DMA_TLB_DSI_FLUSH);
 	} else {
 		iommu_flush_write_buffer(iommu);
 	}
@@ -2388,16 +2387,9 @@ static void domain_context_clear_one(struct intel_iommu *iommu, u8 bus, u8 devfn
 	context_clear_entry(context);
 	__iommu_flush_cache(iommu, context, sizeof(*context));
 	spin_unlock_irqrestore(&iommu->lock, flags);
-	iommu->flush.flush_context(iommu,
-				   did_old,
-				   (((u16)bus) << 8) | devfn,
-				   DMA_CCMD_MASK_NOBIT,
-				   DMA_CCMD_DEVICE_INVL);
-	iommu->flush.flush_iotlb(iommu,
-				 did_old,
-				 0,
-				 0,
-				 DMA_TLB_DSI_FLUSH);
+	iommu->flush.cc_inv(iommu, did_old, (((u16)bus) << 8) | devfn,
+			    DMA_CCMD_MASK_NOBIT, DMA_CCMD_DEVICE_INVL);
+	iommu->flush.iotlb_inv(iommu, did_old, 0, 0, DMA_TLB_DSI_FLUSH);
 }
 
 static inline void unlink_domain_info(struct device_domain_info *info)
@@ -2963,6 +2955,45 @@ static int device_def_domain_type(struct device *dev)
 			IOMMU_DOMAIN_IDENTITY : 0;
 }
 
+static void
+qi_flush_context(struct intel_iommu *iommu, u16 did, u16 sid, u8 fm, u64 type)
+{
+	struct qi_desc desc;
+
+	desc.qw0 = QI_CC_FM(fm) | QI_CC_SID(sid) | QI_CC_DID(did)
+			| QI_CC_GRAN(type) | QI_CC_TYPE;
+	desc.qw1 = 0;
+	desc.qw2 = 0;
+	desc.qw3 = 0;
+
+	qi_submit_sync(&desc, iommu);
+}
+
+static void
+qi_flush_iotlb(struct intel_iommu *iommu, u16 did, u64 addr,
+	       unsigned int size_order, u64 type)
+{
+	u8 dw = 0, dr = 0;
+
+	struct qi_desc desc;
+	int ih = 0;
+
+	if (cap_write_drain(iommu->cap))
+		dw = 1;
+
+	if (cap_read_drain(iommu->cap))
+		dr = 1;
+
+	desc.qw0 = QI_IOTLB_DID(did) | QI_IOTLB_DR(dr) | QI_IOTLB_DW(dw)
+		| QI_IOTLB_GRAN(type) | QI_IOTLB_TYPE;
+	desc.qw1 = QI_IOTLB_ADDR(addr) | QI_IOTLB_IH(ih)
+		| QI_IOTLB_AM(size_order);
+	desc.qw2 = 0;
+	desc.qw3 = 0;
+
+	qi_submit_sync(&desc, iommu);
+}
+
 static void intel_iommu_init_qi(struct intel_iommu *iommu)
 {
 	/*
@@ -2987,13 +3018,13 @@ static void intel_iommu_init_qi(struct intel_iommu *iommu)
 		/*
 		 * Queued Invalidate not enabled, use Register Based Invalidate
 		 */
-		iommu->flush.flush_context = __iommu_flush_context;
-		iommu->flush.flush_iotlb = __iommu_flush_iotlb;
+		iommu->flush.cc_inv = __iommu_flush_context;
+		iommu->flush.iotlb_inv = __iommu_flush_iotlb;
 		pr_info("%s: Using Register based invalidation\n",
 			iommu->name);
 	} else {
-		iommu->flush.flush_context = qi_flush_context;
-		iommu->flush.flush_iotlb = qi_flush_iotlb;
+		iommu->flush.cc_inv = qi_flush_context;
+		iommu->flush.iotlb_inv = qi_flush_iotlb;
 		pr_info("%s: Using Queued invalidation\n", iommu->name);
 	}
 }
@@ -3300,8 +3331,8 @@ static int __init init_dmars(void)
 	for_each_active_iommu(iommu, drhd) {
 		iommu_flush_write_buffer(iommu);
 		iommu_set_root_entry(iommu);
-		iommu->flush.flush_context(iommu, 0, 0, 0, DMA_CCMD_GLOBAL_INVL);
-		iommu->flush.flush_iotlb(iommu, 0, 0, 0, DMA_TLB_GLOBAL_FLUSH);
+		iommu->flush.cc_inv(iommu, 0, 0, 0, DMA_CCMD_GLOBAL_INVL);
+		iommu->flush.iotlb_inv(iommu, 0, 0, 0, DMA_TLB_GLOBAL_FLUSH);
 	}
 
 	if (iommu_default_passthrough())
@@ -4196,9 +4227,8 @@ static int init_iommu_hw(void)
 
 		iommu_set_root_entry(iommu);
 
-		iommu->flush.flush_context(iommu, 0, 0, 0,
-					   DMA_CCMD_GLOBAL_INVL);
-		iommu->flush.flush_iotlb(iommu, 0, 0, 0, DMA_TLB_GLOBAL_FLUSH);
+		iommu->flush.cc_inv(iommu, 0, 0, 0, DMA_CCMD_GLOBAL_INVL);
+		iommu->flush.iotlb_inv(iommu, 0, 0, 0, DMA_TLB_GLOBAL_FLUSH);
 		iommu_enable_translation(iommu);
 		iommu_disable_protect_mem_regions(iommu);
 	}
@@ -4212,10 +4242,8 @@ static void iommu_flush_all(void)
 	struct intel_iommu *iommu;
 
 	for_each_active_iommu(iommu, drhd) {
-		iommu->flush.flush_context(iommu, 0, 0, 0,
-					   DMA_CCMD_GLOBAL_INVL);
-		iommu->flush.flush_iotlb(iommu, 0, 0, 0,
-					 DMA_TLB_GLOBAL_FLUSH);
+		iommu->flush.cc_inv(iommu, 0, 0, 0, DMA_CCMD_GLOBAL_INVL);
+		iommu->flush.iotlb_inv(iommu, 0, 0, 0, DMA_TLB_GLOBAL_FLUSH);
 	}
 }
 
@@ -4502,8 +4530,8 @@ static int intel_iommu_add(struct dmar_drhd_unit *dmaru)
 		goto disable_iommu;
 
 	iommu_set_root_entry(iommu);
-	iommu->flush.flush_context(iommu, 0, 0, 0, DMA_CCMD_GLOBAL_INVL);
-	iommu->flush.flush_iotlb(iommu, 0, 0, 0, DMA_TLB_GLOBAL_FLUSH);
+	iommu->flush.cc_inv(iommu, 0, 0, 0, DMA_CCMD_GLOBAL_INVL);
+	iommu->flush.iotlb_inv(iommu, 0, 0, 0, DMA_TLB_GLOBAL_FLUSH);
 	iommu_enable_translation(iommu);
 
 	iommu_disable_protect_mem_regions(iommu);
@@ -5756,11 +5784,9 @@ int intel_iommu_enable_pasid(struct intel_iommu *iommu, struct device *dev)
 		ctx_lo |= CONTEXT_PASIDE;
 		context[0].lo = ctx_lo;
 		wmb();
-		iommu->flush.flush_context(iommu,
-					   domain->iommu_did[iommu->seq_id],
-					   PCI_DEVID(info->bus, info->devfn),
-					   DMA_CCMD_MASK_NOBIT,
-					   DMA_CCMD_DEVICE_INVL);
+		iommu->flush.cc_inv(iommu, domain->iommu_did[iommu->seq_id],
+				    PCI_DEVID(info->bus, info->devfn),
+				    DMA_CCMD_MASK_NOBIT, DMA_CCMD_DEVICE_INVL);
 	}
 
 	/* Enable PASID support in the device, if it wasn't already */
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index aaece25c055f..ac725a4ce1c1 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -418,11 +418,33 @@ struct ir_table {
 };
 #endif
 
+/* struct iommu_flush - Intel IOMMU cache invalidation ops
+ *
+ * @cc_inv: invalidate context cache
+ * @iotlb_inv: Invalidate IOTLB and paging structure caches when software
+ *             has changed second-level tables.
+ * @p_iotlb_inv: Invalidate IOTLB and paging structure caches when software
+ *               has changed first-level tables.
+ * @pc_inv: invalidate pasid cache
+ * @dev_tlb_inv: invalidate cached mappings used by requests-without-PASID
+ *               from the Device-TLB on a endpoint device.
+ * @p_dev_tlb_inv: invalidate cached mappings used by requests-with-PASID
+ *                 from the Device-TLB on an endpoint device
+ */
 struct iommu_flush {
-	void (*flush_context)(struct intel_iommu *iommu, u16 did, u16 sid,
-			      u8 fm, u64 type);
-	void (*flush_iotlb)(struct intel_iommu *iommu, u16 did, u64 addr,
-			    unsigned int size_order, u64 type);
+	void (*cc_inv)(struct intel_iommu *iommu, u16 did,
+		       u16 sid, u8 fm, u64 type);
+	void (*iotlb_inv)(struct intel_iommu *iommu, u16 did, u64 addr,
+			  unsigned int size_order, u64 type);
+	void (*p_iotlb_inv)(struct intel_iommu *iommu, u16 did, u32 pasid,
+			    u64 addr, unsigned long npages, bool ih);
+	void (*pc_inv)(struct intel_iommu *iommu, u16 did, u32 pasid,
+		       u64 granu);
+	void (*dev_tlb_inv)(struct intel_iommu *iommu, u16 sid, u16 pfsid,
+			    u16 qdep, u64 addr, unsigned int mask);
+	void (*p_dev_tlb_inv)(struct intel_iommu *iommu, u16 sid, u16 pfsid,
+			      u32 pasid, u16 qdep, u64 addr,
+			      unsigned long npages);
 };
 
 enum {
@@ -640,10 +662,6 @@ extern void dmar_disable_qi(struct intel_iommu *iommu);
 extern int dmar_reenable_qi(struct intel_iommu *iommu);
 extern void qi_global_iec(struct intel_iommu *iommu);
 
-extern void qi_flush_context(struct intel_iommu *iommu, u16 did, u16 sid,
-			     u8 fm, u64 type);
-extern void qi_flush_iotlb(struct intel_iommu *iommu, u16 did, u64 addr,
-			  unsigned int size_order, u64 type);
 extern void qi_flush_dev_iotlb(struct intel_iommu *iommu, u16 sid, u16 pfsid,
 			u16 qdep, u64 addr, unsigned mask);
 extern int qi_submit_sync(struct qi_desc *desc, struct intel_iommu *iommu);
-- 
2.17.1

