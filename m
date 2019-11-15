Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40EF6C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 23:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D99520733
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 23:05:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbfKOXFH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 18:05:07 -0500
Received: from mga03.intel.com ([134.134.136.65]:52452 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727168AbfKOXFG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 18:05:06 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Nov 2019 15:05:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,309,1569308400"; 
   d="scan'208";a="217240207"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
  by orsmga002.jf.intel.com with ESMTP; 15 Nov 2019 15:05:05 -0800
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>, "Yi Liu" <yi.l.liu@intel.com>,
        Eric Auger <eric.auger@redhat.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH 02/10] iommu/vt-d: Fix CPU and IOMMU SVM feature matching checks
Date:   Fri, 15 Nov 2019 15:09:29 -0800
Message-Id: <1573859377-75924-3-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1573859377-75924-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1573859377-75924-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current code checks CPU and IOMMU feature set for SVM support but
the result is never stored nor used. Therefore, SVM can still be used
even when these checks failed.

This patch consolidates code for checking PASID, CPU vs. IOMMU paging
mode compatibility, as well as provides specific error messages for
each failed checks.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/intel-iommu.c | 10 ++--------
 drivers/iommu/intel-svm.c   | 40 +++++++++++++++++++++++++++-------------
 include/linux/intel-iommu.h |  4 +++-
 3 files changed, 32 insertions(+), 22 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 3f974919d3bd..d598168e410d 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -3289,10 +3289,7 @@ static int __init init_dmars(void)
 
 		if (!ecap_pass_through(iommu->ecap))
 			hw_pass_through = 0;
-#ifdef CONFIG_INTEL_IOMMU_SVM
-		if (pasid_supported(iommu))
-			intel_svm_init(iommu);
-#endif
+		intel_svm_check(iommu);
 	}
 
 	/*
@@ -4471,10 +4468,7 @@ static int intel_iommu_add(struct dmar_drhd_unit *dmaru)
 	if (ret)
 		goto out;
 
-#ifdef CONFIG_INTEL_IOMMU_SVM
-	if (pasid_supported(iommu))
-		intel_svm_init(iommu);
-#endif
+	intel_svm_check(iommu);
 
 	if (dmaru->ignored) {
 		/*
diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
index 9b159132405d..e9773d714862 100644
--- a/drivers/iommu/intel-svm.c
+++ b/drivers/iommu/intel-svm.c
@@ -23,19 +23,6 @@
 
 static irqreturn_t prq_event_thread(int irq, void *d);
 
-int intel_svm_init(struct intel_iommu *iommu)
-{
-	if (cpu_feature_enabled(X86_FEATURE_GBPAGES) &&
-			!cap_fl1gp_support(iommu->cap))
-		return -EINVAL;
-
-	if (cpu_feature_enabled(X86_FEATURE_LA57) &&
-			!cap_5lp_support(iommu->cap))
-		return -EINVAL;
-
-	return 0;
-}
-
 #define PRQ_ORDER 0
 
 int intel_svm_enable_prq(struct intel_iommu *iommu)
@@ -99,6 +86,33 @@ int intel_svm_finish_prq(struct intel_iommu *iommu)
 	return 0;
 }
 
+static inline bool intel_svm_capable(struct intel_iommu *iommu)
+{
+	return iommu->flags & VTD_FLAG_SVM_CAPABLE;
+}
+
+void intel_svm_check(struct intel_iommu *iommu)
+{
+	if (!pasid_supported(iommu))
+		return;
+
+	if (cpu_feature_enabled(X86_FEATURE_GBPAGES) &&
+	    !cap_fl1gp_support(iommu->cap)) {
+		pr_err("%s SVM disabled, incompatible 1GB page capability\n",
+			iommu->name);
+		return;
+	}
+
+	if (cpu_feature_enabled(X86_FEATURE_LA57) &&
+	    !cap_5lp_support(iommu->cap)) {
+		pr_err("%s SVM disabled, incompatible paging mode\n",
+			iommu->name);
+		return;
+	}
+
+	iommu->flags |= VTD_FLAG_SVM_CAPABLE;
+}
+
 static void intel_flush_svm_range_dev (struct intel_svm *svm, struct intel_svm_dev *sdev,
 				unsigned long address, unsigned long pages, int ih)
 {
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 63118991824c..7dcfa1c4a844 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -657,7 +657,7 @@ void iommu_flush_write_buffer(struct intel_iommu *iommu);
 int intel_iommu_enable_pasid(struct intel_iommu *iommu, struct device *dev);
 
 #ifdef CONFIG_INTEL_IOMMU_SVM
-int intel_svm_init(struct intel_iommu *iommu);
+extern void intel_svm_check(struct intel_iommu *iommu);
 extern int intel_svm_enable_prq(struct intel_iommu *iommu);
 extern int intel_svm_finish_prq(struct intel_iommu *iommu);
 
@@ -685,6 +685,8 @@ struct intel_svm {
 };
 
 extern struct intel_iommu *intel_svm_device_to_iommu(struct device *dev);
+#else
+static inline void intel_svm_check(struct intel_iommu *iommu) {}
 #endif
 
 #ifdef CONFIG_INTEL_IOMMU_DEBUGFS
-- 
2.7.4

