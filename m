Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D709C2D0BF
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 02:13:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D49D206EC
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 02:13:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727659AbfLKCN1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 21:13:27 -0500
Received: from mga04.intel.com ([192.55.52.120]:52878 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727536AbfLKCNZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 21:13:25 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Dec 2019 18:13:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,301,1571727600"; 
   d="scan'208";a="225353013"
Received: from allen-box.sh.intel.com ([10.239.159.136])
  by orsmga002.jf.intel.com with ESMTP; 10 Dec 2019 18:13:22 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>
Cc:     ashok.raj@intel.com, sanjay.k.kumar@intel.com,
        jacob.jun.pan@linux.intel.com, kevin.tian@intel.com,
        yi.l.liu@intel.com, yi.y.sun@intel.com,
        Peter Xu <peterx@redhat.com>, iommu@lists.linux-foundation.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v3 3/6] iommu/vt-d: Add PASID_FLAG_FL5LP for first-level pasid setup
Date:   Wed, 11 Dec 2019 10:12:16 +0800
Message-Id: <20191211021219.8997-4-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191211021219.8997-1-baolu.lu@linux.intel.com>
References: <20191211021219.8997-1-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current intel_pasid_setup_first_level() use 5-level paging for
first level translation if CPUs use 5-level paging mode too.
This makes sense for SVA usages since the page table is shared
between CPUs and IOMMUs. But it makes no sense if we only want
to use first level for IOVA translation. Add PASID_FLAG_FL5LP
bit in the flags which indicates whether the 5-level paging
mode should be used.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel-pasid.c | 7 ++-----
 drivers/iommu/intel-pasid.h | 6 ++++++
 drivers/iommu/intel-svm.c   | 8 ++++++--
 3 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/intel-pasid.c b/drivers/iommu/intel-pasid.c
index 3cb569e76642..22b30f10b396 100644
--- a/drivers/iommu/intel-pasid.c
+++ b/drivers/iommu/intel-pasid.c
@@ -477,18 +477,15 @@ int intel_pasid_setup_first_level(struct intel_iommu *iommu,
 		pasid_set_sre(pte);
 	}
 
-#ifdef CONFIG_X86
-	/* Both CPU and IOMMU paging mode need to match */
-	if (cpu_feature_enabled(X86_FEATURE_LA57)) {
+	if (flags & PASID_FLAG_FL5LP) {
 		if (cap_5lp_support(iommu->cap)) {
 			pasid_set_flpm(pte, 1);
 		} else {
-			pr_err("VT-d has no 5-level paging support for CPU\n");
+			pr_err("No 5-level paging support for first-level\n");
 			pasid_clear_entry(pte);
 			return -EINVAL;
 		}
 	}
-#endif /* CONFIG_X86 */
 
 	pasid_set_domain_id(pte, did);
 	pasid_set_address_width(pte, iommu->agaw);
diff --git a/drivers/iommu/intel-pasid.h b/drivers/iommu/intel-pasid.h
index fc8cd8f17de1..92de6df24ccb 100644
--- a/drivers/iommu/intel-pasid.h
+++ b/drivers/iommu/intel-pasid.h
@@ -37,6 +37,12 @@
  */
 #define PASID_FLAG_SUPERVISOR_MODE	BIT(0)
 
+/*
+ * The PASID_FLAG_FL5LP flag Indicates using 5-level paging for first-
+ * level translation, otherwise, 4-level paging will be used.
+ */
+#define PASID_FLAG_FL5LP		BIT(1)
+
 struct pasid_dir_entry {
 	u64 val;
 };
diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
index 04023033b79f..d7f2a5358900 100644
--- a/drivers/iommu/intel-svm.c
+++ b/drivers/iommu/intel-svm.c
@@ -364,7 +364,9 @@ int intel_svm_bind_mm(struct device *dev, int *pasid, int flags, struct svm_dev_
 		ret = intel_pasid_setup_first_level(iommu, dev,
 				mm ? mm->pgd : init_mm.pgd,
 				svm->pasid, FLPT_DEFAULT_DID,
-				mm ? 0 : PASID_FLAG_SUPERVISOR_MODE);
+				(mm ? 0 : PASID_FLAG_SUPERVISOR_MODE) |
+				(cpu_feature_enabled(X86_FEATURE_LA57) ?
+				 PASID_FLAG_FL5LP : 0));
 		spin_unlock(&iommu->lock);
 		if (ret) {
 			if (mm)
@@ -385,7 +387,9 @@ int intel_svm_bind_mm(struct device *dev, int *pasid, int flags, struct svm_dev_
 		ret = intel_pasid_setup_first_level(iommu, dev,
 						mm ? mm->pgd : init_mm.pgd,
 						svm->pasid, FLPT_DEFAULT_DID,
-						mm ? 0 : PASID_FLAG_SUPERVISOR_MODE);
+						(mm ? 0 : PASID_FLAG_SUPERVISOR_MODE) |
+						(cpu_feature_enabled(X86_FEATURE_LA57) ?
+						PASID_FLAG_FL5LP : 0));
 		spin_unlock(&iommu->lock);
 		if (ret) {
 			kfree(sdev);
-- 
2.17.1

