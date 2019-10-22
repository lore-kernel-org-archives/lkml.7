Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71AB6CA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 23:49:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 499752075A
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 23:49:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389885AbfJVXtJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 19:49:09 -0400
Received: from mga06.intel.com ([134.134.136.31]:28707 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389865AbfJVXtH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 19:49:07 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Oct 2019 16:49:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,218,1569308400"; 
   d="scan'208";a="191652644"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
  by orsmga008.jf.intel.com with ESMTP; 22 Oct 2019 16:49:03 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>
Cc:     "Yi Liu" <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        "Christoph Hellwig" <hch@infradead.org>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Eric Auger <eric.auger@redhat.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v6 06/10] iommu/vt-d: Add nested translation helper function
Date:   Tue, 22 Oct 2019 16:53:19 -0700
Message-Id: <1571788403-42095-7-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1571788403-42095-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1571788403-42095-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nested translation mode is supported in VT-d 3.0 Spec.CH 3.8.
With PASID granular translation type set to 0x11b, translation
result from the first level(FL) also subject to a second level(SL)
page table translation. This mode is used for SVA virtualization,
where FL performs guest virtual to guest physical translation and
SL performs guest physical to host physical translation.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
---
 drivers/iommu/intel-pasid.c | 207 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/iommu/intel-pasid.h |  12 +++
 2 files changed, 219 insertions(+)

diff --git a/drivers/iommu/intel-pasid.c b/drivers/iommu/intel-pasid.c
index 9c5affcd28e4..fd2c82fd90c1 100644
--- a/drivers/iommu/intel-pasid.c
+++ b/drivers/iommu/intel-pasid.c
@@ -442,6 +442,76 @@ pasid_set_flpm(struct pasid_entry *pe, u64 value)
 	pasid_set_bits(&pe->val[2], GENMASK_ULL(3, 2), value << 2);
 }
 
+/*
+ * Setup the Extended Memory Type(EMT) field (Bits 91-93)
+ * of a scalable mode PASID entry.
+ */
+static inline void
+pasid_set_emt(struct pasid_entry *pe, u64 value)
+{
+	pasid_set_bits(&pe->val[1], GENMASK_ULL(29, 27), value << 27);
+}
+
+/*
+ * Setup the Page Attribute Table (PAT) field (Bits 96-127)
+ * of a scalable mode PASID entry.
+ */
+static inline void
+pasid_set_pat(struct pasid_entry *pe, u64 value)
+{
+	pasid_set_bits(&pe->val[1], GENMASK_ULL(63, 32), value << 27);
+}
+
+/*
+ * Setup the Cache Disable (CD) field (Bit 89)
+ * of a scalable mode PASID entry.
+ */
+static inline void
+pasid_set_cd(struct pasid_entry *pe)
+{
+	pasid_set_bits(&pe->val[1], 1 << 25, 1);
+}
+
+/*
+ * Setup the Extended Memory Type Enable (EMTE) field (Bit 90)
+ * of a scalable mode PASID entry.
+ */
+static inline void
+pasid_set_emte(struct pasid_entry *pe)
+{
+	pasid_set_bits(&pe->val[1], 1 << 26, 1);
+}
+
+/*
+ * Setup the Extended Access Flag Enable (EAFE) field (Bit 135)
+ * of a scalable mode PASID entry.
+ */
+static inline void
+pasid_set_eafe(struct pasid_entry *pe)
+{
+	pasid_set_bits(&pe->val[2], 1 << 7, 1);
+}
+
+/*
+ * Setup the Page-level Cache Disable (PCD) field (Bit 95)
+ * of a scalable mode PASID entry.
+ */
+static inline void
+pasid_set_pcd(struct pasid_entry *pe)
+{
+	pasid_set_bits(&pe->val[1], 1 << 31, 1);
+}
+
+/*
+ * Setup the Page-level Write-Through (PWT)) field (Bit 94)
+ * of a scalable mode PASID entry.
+ */
+static inline void
+pasid_set_pwt(struct pasid_entry *pe)
+{
+	pasid_set_bits(&pe->val[1], 1 << 30, 1);
+}
+
 static void
 pasid_cache_invalidation_with_pasid(struct intel_iommu *iommu,
 				    u16 did, int pasid)
@@ -674,3 +744,140 @@ int intel_pasid_setup_pass_through(struct intel_iommu *iommu,
 
 	return 0;
 }
+
+static int intel_pasid_setup_bind_data(struct intel_iommu *iommu,
+				struct pasid_entry *pte,
+				struct iommu_gpasid_bind_data_vtd *pasid_data)
+{
+	/*
+	 * Not all guest PASID table entry fields are passed down during bind,
+	 * here we only set up the ones that are dependent on guest settings.
+	 * Execution related bits such as NXE, SMEP are not meaningful to IOMMU,
+	 * therefore not set. Other fields, such as snoop related, are set based
+	 * on host needs regardless of  guest settings.
+	 */
+	if (pasid_data->flags & IOMMU_SVA_VTD_GPASID_SRE) {
+		if (!ecap_srs(iommu->ecap)) {
+			pr_err("No supervisor request support on %s\n",
+			       iommu->name);
+			return -EINVAL;
+		}
+		pasid_set_sre(pte);
+	}
+
+	if ((pasid_data->flags & IOMMU_SVA_VTD_GPASID_EAFE) && ecap_eafs(iommu->ecap))
+		pasid_set_eafe(pte);
+
+	if (pasid_data->flags & IOMMU_SVA_VTD_GPASID_EMTE) {
+		pasid_set_emte(pte);
+		pasid_set_emt(pte, pasid_data->emt);
+	}
+
+	/*
+	 * Memory type is only applicable to devices inside processor coherent
+	 * domain. PCIe devices are not included. We can skip the rest of the
+	 * flags if IOMMU does not support MTS.
+	 */
+	if (!ecap_mts(iommu->ecap)) {
+		pr_info("%s does not support memory type bind guest PASID\n",
+			iommu->name);
+		return 0;
+	}
+
+	if (pasid_data->flags & IOMMU_SVA_VTD_GPASID_PCD)
+		pasid_set_pcd(pte);
+	if (pasid_data->flags & IOMMU_SVA_VTD_GPASID_PWT)
+		pasid_set_pwt(pte);
+	if (pasid_data->flags & IOMMU_SVA_VTD_GPASID_CD)
+		pasid_set_cd(pte);
+	pasid_set_pat(pte, pasid_data->pat);
+
+	return 0;
+
+}
+
+/**
+ * intel_pasid_setup_nested() - Set up PASID entry for nested translation
+ * which is used for vSVA. The first level page tables are used for
+ * GVA-GPA translation in the guest, second level page tables are used
+ * for GPA to HPA translation.
+ *
+ * @iommu:      Iommu which the device belong to
+ * @dev:        Device to be set up for translation
+ * @gpgd:       FLPTPTR: First Level Page translation pointer in GPA
+ * @pasid:      PASID to be programmed in the device PASID table
+ * @pasid_data: Additional PASID info from the guest bind request
+ * @domain:     Domain info for setting up second level page tables
+ * @addr_width: Address width of the first level (guest)
+ */
+int intel_pasid_setup_nested(struct intel_iommu *iommu,
+			struct device *dev, pgd_t *gpgd,
+			int pasid, struct iommu_gpasid_bind_data_vtd *pasid_data,
+			struct dmar_domain *domain,
+			int addr_width)
+{
+	struct pasid_entry *pte;
+	struct dma_pte *pgd;
+	u64 pgd_val;
+	int agaw;
+	u16 did;
+
+	if (!ecap_nest(iommu->ecap)) {
+		pr_err("IOMMU: %s: No nested translation support\n",
+		       iommu->name);
+		return -EINVAL;
+	}
+
+	pte = intel_pasid_get_entry(dev, pasid);
+	if (WARN_ON(!pte))
+		return -EINVAL;
+
+	pasid_clear_entry(pte);
+
+	/* Sanity checking performed by caller to make sure address
+	 * width matching in two dimensions:
+	 * 1. CPU vs. IOMMU
+	 * 2. Guest vs. Host.
+	 */
+	switch (addr_width) {
+	case 57:
+		pasid_set_flpm(pte, 1);
+		break;
+	case 48:
+		pasid_set_flpm(pte, 0);
+		break;
+	default:
+		dev_err(dev, "Invalid paging mode %d\n", addr_width);
+		return -EINVAL;
+	}
+
+	pasid_set_flptr(pte, (u64)gpgd);
+
+	intel_pasid_setup_bind_data(iommu, pte, pasid_data);
+
+	/* Setup the second level based on the given domain */
+	pgd = domain->pgd;
+
+	for (agaw = domain->agaw; agaw != iommu->agaw; agaw--) {
+		pgd = phys_to_virt(dma_pte_addr(pgd));
+		if (!dma_pte_present(pgd)) {
+			dev_err(dev, "Invalid domain page table\n");
+			return -EINVAL;
+		}
+	}
+	pgd_val = virt_to_phys(pgd);
+	pasid_set_slptr(pte, pgd_val);
+	pasid_set_fault_enable(pte);
+
+	did = domain->iommu_did[iommu->seq_id];
+	pasid_set_domain_id(pte, did);
+
+	pasid_set_address_width(pte, agaw);
+	pasid_set_page_snoop(pte, !!ecap_smpwc(iommu->ecap));
+
+	pasid_set_translation_type(pte, PASID_ENTRY_PGTT_NESTED);
+	pasid_set_present(pte);
+	pasid_flush_caches(iommu, pte, pasid, did);
+
+	return 0;
+}
diff --git a/drivers/iommu/intel-pasid.h b/drivers/iommu/intel-pasid.h
index e413e884e685..09c85db73b77 100644
--- a/drivers/iommu/intel-pasid.h
+++ b/drivers/iommu/intel-pasid.h
@@ -46,6 +46,7 @@
  * to vmalloc or even module mappings.
  */
 #define PASID_FLAG_SUPERVISOR_MODE	BIT(0)
+#define PASID_FLAG_NESTED		BIT(1)
 
 struct pasid_dir_entry {
 	u64 val;
@@ -55,6 +56,11 @@ struct pasid_entry {
 	u64 val[8];
 };
 
+#define PASID_ENTRY_PGTT_FL_ONLY	(1)
+#define PASID_ENTRY_PGTT_SL_ONLY	(2)
+#define PASID_ENTRY_PGTT_NESTED		(3)
+#define PASID_ENTRY_PGTT_PT		(4)
+
 /* The representative of a PASID table */
 struct pasid_table {
 	void			*table;		/* pasid table pointer */
@@ -103,6 +109,12 @@ int intel_pasid_setup_second_level(struct intel_iommu *iommu,
 int intel_pasid_setup_pass_through(struct intel_iommu *iommu,
 				   struct dmar_domain *domain,
 				   struct device *dev, int pasid);
+int intel_pasid_setup_nested(struct intel_iommu *iommu,
+			struct device *dev, pgd_t *pgd,
+			int pasid,
+			struct iommu_gpasid_bind_data_vtd *pasid_data,
+			struct dmar_domain *domain,
+			int addr_width);
 void intel_pasid_tear_down_entry(struct intel_iommu *iommu,
 				 struct device *dev, int pasid);
 int vcmd_alloc_pasid(struct intel_iommu *iommu, unsigned int *pasid);
-- 
2.7.4

