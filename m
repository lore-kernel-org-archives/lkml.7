Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A575DC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 18:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77DCE206CD
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 18:20:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436541AbfIFSUZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 14:20:25 -0400
Received: from mga03.intel.com ([134.134.136.65]:19073 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392018AbfIFSUZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 14:20:25 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Sep 2019 11:20:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,473,1559545200"; 
   d="scan'208";a="183211024"
Received: from km-skylake-client-platform.sc.intel.com ([10.3.52.147])
  by fmsmga008.fm.intel.com with ESMTP; 06 Sep 2019 11:20:11 -0700
From:   Kyung Min Park <kyung.min.park@intel.com>
To:     joro@8bytes.org, dwmw2@infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc:     kyung.min.park@intel.com, sohil.mehta@intel.com,
        ashok.raj@intel.com, jacob.jun.pan@linux.intel.com,
        baolu.lu@intel.com, andriy.shevchenko@intel.com
Subject: [PATCH] iommu/vt-d: Add Scalable Mode fault information
Date:   Fri,  6 Sep 2019 11:14:02 -0700
Message-Id: <1567793642-17063-1-git-send-email-kyung.min.park@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Intel VT-d specification revision 3 added support for Scalable Mode
Translation for DMA remapping. Add the Scalable Mode fault reasons to
show detailed fault reasons when the translation fault happens.

Link: https://software.intel.com/sites/default/files/managed/c5/15/vt-directed-io-spec.pdf

Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
Signed-off-by: Kyung Min Park <kyung.min.park@intel.com>
---
 drivers/iommu/dmar.c        | 77 ++++++++++++++++++++++++++++++++++++++++++---
 include/linux/intel-iommu.h |  2 ++
 2 files changed, 75 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
index 1207e05..5cb63c5 100644
--- a/drivers/iommu/dmar.c
+++ b/drivers/iommu/dmar.c
@@ -1532,6 +1532,64 @@ static const char *dma_remap_fault_reasons[] =
 	"PCE for translation request specifies blocking",
 };
 
+static const char * const dma_remap_sm_fault_reasons[] = {
+	"SM: Invalid Root Table Address",
+	"SM: TTM 0 for request with PASID",
+	"SM: TTM 0 for page group request",
+	"Unknown", "Unknown", "Unknown", "Unknown", "Unknown", /* 0x33-0x37 */
+	"SM: Error attempting to access Root Entry",
+	"SM: Present bit in Root Entry is clear",
+	"SM: Non-zero reserved field set in Root Entry",
+	"Unknown", "Unknown", "Unknown", "Unknown", "Unknown", /* 0x3B-0x3F */
+	"SM: Error attempting to access Context Entry",
+	"SM: Present bit in Context Entry is clear",
+	"SM: Non-zero reserved field set in the Context Entry",
+	"SM: Invalid Context Entry",
+	"SM: DTE field in Context Entry is clear",
+	"SM: PASID Enable field in Context Entry is clear",
+	"SM: PASID is larger than the max in Context Entry",
+	"SM: PRE field in Context-Entry is clear",
+	"SM: RID_PASID field error in Context-Entry",
+	"Unknown", "Unknown", "Unknown", "Unknown", "Unknown", "Unknown", "Unknown", /* 0x49-0x4F */
+	"SM: Error attempting to access the PASID Directory Entry",
+	"SM: Present bit in Directory Entry is clear",
+	"SM: Non-zero reserved field set in PASID Directory Entry",
+	"Unknown", "Unknown", "Unknown", "Unknown", "Unknown", /* 0x53-0x57 */
+	"SM: Error attempting to access PASID Table Entry",
+	"SM: Present bit in PASID Table Entry is clear",
+	"SM: Non-zero reserved field set in PASID Table Entry",
+	"SM: Invalid Scalable-Mode PASID Table Entry",
+	"SM: ERE field is clear in PASID Table Entry",
+	"SM: SRE field is clear in PASID Table Entry",
+	"Unknown", "Unknown",/* 0x5E-0x5F */
+	"Unknown", "Unknown", "Unknown", "Unknown", "Unknown", "Unknown", "Unknown", "Unknown", /* 0x60-0x67 */
+	"Unknown", "Unknown", "Unknown", "Unknown", "Unknown", "Unknown", "Unknown", "Unknown", /* 0x68-0x6F */
+	"SM: Error attempting to access first-level paging entry",
+	"SM: Present bit in first-level paging entry is clear",
+	"SM: Non-zero reserved field set in first-level paging entry",
+	"SM: Error attempting to access FL-PML4 entry",
+	"SM: First-level entry address beyond MGAW in Nested translation",
+	"SM: Read permission error in FL-PML4 entry in Nested translation",
+	"SM: Read permission error in first-level paging entry in Nested translation",
+	"SM: Write permission error in first-level paging entry in Nested translation",
+	"SM: Error attempting to access second-level paging entry",
+	"SM: Read/Write permission error in second-level paging entry",
+	"SM: Non-zero reserved field set in second-level paging entry",
+	"SM: Invalid second-level page table pointer",
+	"SM: A/D bit update needed in second-level entry when set up in no snoop",
+	"Unknown", "Unknown", "Unknown", /* 0x7D-0x7F */
+	"SM: Address in first-level translation is not canonical",
+	"SM: U/S set 0 for first-level translation with user privilege",
+	"SM: No execute permission for request with PASID and ER=1",
+	"SM: Address beyond the DMA hardware max",
+	"SM: Second-level entry address beyond the max",
+	"SM: No write permission for Write/AtomicOp request",
+	"SM: No read permission for Read/AtomicOp request",
+	"SM: Invalid address-interrupt address",
+	"Unknown", "Unknown", "Unknown", "Unknown", "Unknown", "Unknown", "Unknown", "Unknown", /* 0x88-0x8F */
+	"SM: A/D bit update needed in first-level entry when set up in no snoop",
+};
+
 static const char *irq_remap_fault_reasons[] =
 {
 	"Detected reserved fields in the decoded interrupt-remapped request",
@@ -1549,6 +1607,10 @@ static const char *dmar_get_fault_reason(u8 fault_reason, int *fault_type)
 					ARRAY_SIZE(irq_remap_fault_reasons))) {
 		*fault_type = INTR_REMAP;
 		return irq_remap_fault_reasons[fault_reason - 0x20];
+	} else if (fault_reason >= 0x30 && (fault_reason - 0x30 <
+			ARRAY_SIZE(dma_remap_sm_fault_reasons))) {
+		*fault_type = DMA_REMAP;
+		return dma_remap_sm_fault_reasons[fault_reason - 0x30];
 	} else if (fault_reason < ARRAY_SIZE(dma_remap_fault_reasons)) {
 		*fault_type = DMA_REMAP;
 		return dma_remap_fault_reasons[fault_reason];
@@ -1624,7 +1686,8 @@ void dmar_msi_read(int irq, struct msi_msg *msg)
 }
 
 static int dmar_fault_do_one(struct intel_iommu *iommu, int type,
-		u8 fault_reason, u16 source_id, unsigned long long addr)
+		u8 fault_reason, int pasid, u16 source_id,
+		unsigned long long addr)
 {
 	const char *reason;
 	int fault_type;
@@ -1637,10 +1700,11 @@ static int dmar_fault_do_one(struct intel_iommu *iommu, int type,
 			PCI_FUNC(source_id & 0xFF), addr >> 48,
 			fault_reason, reason);
 	else
-		pr_err("[%s] Request device [%02x:%02x.%d] fault addr %llx [fault reason %02d] %s\n",
+		pr_err("[%s] Request device [%02x:%02x.%d] PASID %x fault addr %llx [fault reason %02d] %s\n",
 		       type ? "DMA Read" : "DMA Write",
 		       source_id >> 8, PCI_SLOT(source_id & 0xFF),
-		       PCI_FUNC(source_id & 0xFF), addr, fault_reason, reason);
+		       PCI_FUNC(source_id & 0xFF), pasid, addr,
+		       fault_reason, reason);
 	return 0;
 }
 
@@ -1672,8 +1736,9 @@ irqreturn_t dmar_fault(int irq, void *dev_id)
 		u8 fault_reason;
 		u16 source_id;
 		u64 guest_addr;
-		int type;
+		int type, pasid;
 		u32 data;
+		bool pasid_present;
 
 		/* highest 32 bits */
 		data = readl(iommu->reg + reg +
@@ -1685,10 +1750,12 @@ irqreturn_t dmar_fault(int irq, void *dev_id)
 			fault_reason = dma_frcd_fault_reason(data);
 			type = dma_frcd_type(data);
 
+			pasid = dma_frcd_pasid_value(data);
 			data = readl(iommu->reg + reg +
 				     fault_index * PRIMARY_FAULT_REG_LEN + 8);
 			source_id = dma_frcd_source_id(data);
 
+			pasid_present = dma_frcd_pasid_present(data);
 			guest_addr = dmar_readq(iommu->reg + reg +
 					fault_index * PRIMARY_FAULT_REG_LEN);
 			guest_addr = dma_frcd_page_addr(guest_addr);
@@ -1701,7 +1768,9 @@ irqreturn_t dmar_fault(int irq, void *dev_id)
 		raw_spin_unlock_irqrestore(&iommu->register_lock, flag);
 
 		if (!ratelimited)
+			/* Using pasid -1 if pasid is not present */
 			dmar_fault_do_one(iommu, type, fault_reason,
+					  pasid_present ? pasid : -1,
 					  source_id, guest_addr);
 
 		fault_index++;
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 3c6327b..617f68f 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -265,6 +265,8 @@
 #define dma_frcd_type(d) ((d >> 30) & 1)
 #define dma_frcd_fault_reason(c) (c & 0xff)
 #define dma_frcd_source_id(c) (c & 0xffff)
+#define dma_frcd_pasid_value(c) (((c) >> 8) & 0xfffff)
+#define dma_frcd_pasid_present(c) (((c) >> 31) & 1)
 /* low 64 bit */
 #define dma_frcd_page_addr(d) (d & (((u64)-1) << PAGE_SHIFT))
 
-- 
2.7.4

