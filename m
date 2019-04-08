Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C675EC10F14
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 23:57:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0CDD2148E
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 23:57:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727228AbfDHX5P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 19:57:15 -0400
Received: from mga04.intel.com ([192.55.52.120]:9984 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726805AbfDHX5J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 19:57:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Apr 2019 16:57:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,327,1549958400"; 
   d="scan'208";a="149169971"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
  by orsmga002.jf.intel.com with ESMTP; 08 Apr 2019 16:57:07 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc:     "Yi Liu" <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        "Christoph Hellwig" <hch@infradead.org>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        Andriy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH 11/18] iommu/vt-d: Replace Intel specific PASID allocator with IOASID
Date:   Mon,  8 Apr 2019 16:59:26 -0700
Message-Id: <1554767973-30125-12-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554767973-30125-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1554767973-30125-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make use of generic IOASID code to manage PASID allocation,
free, and lookup.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/Kconfig       |  1 +
 drivers/iommu/intel-pasid.c | 36 ------------------------------------
 drivers/iommu/intel-svm.c   | 41 ++++++++++++++++++++++++-----------------
 3 files changed, 25 insertions(+), 53 deletions(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 6f07f3b..7f92009 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -204,6 +204,7 @@ config INTEL_IOMMU_SVM
 	bool "Support for Shared Virtual Memory with Intel IOMMU"
 	depends on INTEL_IOMMU && X86
 	select PCI_PASID
+	select IOASID
 	select MMU_NOTIFIER
 	help
 	  Shared Virtual Memory (SVM) provides a facility for devices
diff --git a/drivers/iommu/intel-pasid.c b/drivers/iommu/intel-pasid.c
index a17a522..0fda626 100644
--- a/drivers/iommu/intel-pasid.c
+++ b/drivers/iommu/intel-pasid.c
@@ -26,42 +26,6 @@
  */
 static DEFINE_SPINLOCK(pasid_lock);
 u32 intel_pasid_max_id = PASID_MAX;
-static DEFINE_IDR(pasid_idr);
-
-int intel_pasid_alloc_id(void *ptr, int start, int end, gfp_t gfp)
-{
-	int ret, min, max;
-
-	min = max_t(int, start, PASID_MIN);
-	max = min_t(int, end, intel_pasid_max_id);
-
-	WARN_ON(in_interrupt());
-	idr_preload(gfp);
-	spin_lock(&pasid_lock);
-	ret = idr_alloc(&pasid_idr, ptr, min, max, GFP_ATOMIC);
-	spin_unlock(&pasid_lock);
-	idr_preload_end();
-
-	return ret;
-}
-
-void intel_pasid_free_id(int pasid)
-{
-	spin_lock(&pasid_lock);
-	idr_remove(&pasid_idr, pasid);
-	spin_unlock(&pasid_lock);
-}
-
-void *intel_pasid_lookup_id(int pasid)
-{
-	void *p;
-
-	spin_lock(&pasid_lock);
-	p = idr_find(&pasid_idr, pasid);
-	spin_unlock(&pasid_lock);
-
-	return p;
-}
 
 int vcmd_alloc_pasid(struct intel_iommu *iommu, unsigned int *pasid)
 {
diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
index 3a4b09a..595ea0a 100644
--- a/drivers/iommu/intel-svm.c
+++ b/drivers/iommu/intel-svm.c
@@ -25,6 +25,7 @@
 #include <linux/dmar.h>
 #include <linux/interrupt.h>
 #include <linux/mm_types.h>
+#include <linux/ioasid.h>
 #include <asm/page.h>
 
 #include "intel-pasid.h"
@@ -211,7 +212,9 @@ static void intel_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
 	rcu_read_lock();
 	list_for_each_entry_rcu(sdev, &svm->devs, list) {
 		intel_pasid_tear_down_entry(svm->iommu, sdev->dev, svm->pasid);
-		intel_flush_svm_range_dev(svm, sdev, 0, -1, 0, !svm->mm);
+		/* for emulated iommu, PASID cache invalidation implies IOTLB/DTLB */
+		if (!cap_caching_mode(svm->iommu->cap))
+			intel_flush_svm_range_dev(svm, sdev, 0, -1, 0, !svm->mm);
 	}
 	rcu_read_unlock();
 
@@ -315,16 +318,15 @@ int intel_svm_bind_mm(struct device *dev, int *pasid, int flags, struct svm_dev_
 		if (pasid_max > intel_pasid_max_id)
 			pasid_max = intel_pasid_max_id;
 
-		/* Do not use PASID 0 in caching mode (virtualised IOMMU) */
-		ret = intel_pasid_alloc_id(svm,
-					   !!cap_caching_mode(iommu->cap),
-					   pasid_max - 1, GFP_KERNEL);
-		if (ret < 0) {
+		/* Do not use PASID 0, reserved for RID to PASID */
+		svm->pasid = ioasid_alloc(NULL, PASID_MIN,
+					pasid_max - 1, svm);
+		if (svm->pasid == INVALID_IOASID) {
 			kfree(svm);
 			kfree(sdev);
+			ret = ENOSPC;
 			goto out;
 		}
-		svm->pasid = ret;
 		svm->notifier.ops = &intel_mmuops;
 		svm->mm = mm;
 		svm->flags = flags;
@@ -334,7 +336,7 @@ int intel_svm_bind_mm(struct device *dev, int *pasid, int flags, struct svm_dev_
 		if (mm) {
 			ret = mmu_notifier_register(&svm->notifier, mm);
 			if (ret) {
-				intel_pasid_free_id(svm->pasid);
+				ioasid_free(svm->pasid);
 				kfree(svm);
 				kfree(sdev);
 				goto out;
@@ -350,7 +352,7 @@ int intel_svm_bind_mm(struct device *dev, int *pasid, int flags, struct svm_dev_
 		if (ret) {
 			if (mm)
 				mmu_notifier_unregister(&svm->notifier, mm);
-			intel_pasid_free_id(svm->pasid);
+			ioasid_free(svm->pasid);
 			kfree(svm);
 			kfree(sdev);
 			goto out;
@@ -383,7 +385,12 @@ int intel_svm_unbind_mm(struct device *dev, int pasid)
 	if (!iommu)
 		goto out;
 
-	svm = intel_pasid_lookup_id(pasid);
+	svm = ioasid_find(NULL, pasid, NULL);
+	if (IS_ERR(svm)) {
+		ret = PTR_ERR(svm);
+		goto out;
+	}
+
 	if (!svm)
 		goto out;
 
@@ -405,7 +412,7 @@ int intel_svm_unbind_mm(struct device *dev, int pasid)
 				kfree_rcu(sdev, rcu);
 
 				if (list_empty(&svm->devs)) {
-					intel_pasid_free_id(svm->pasid);
+					ioasid_free(svm->pasid);
 					if (svm->mm)
 						mmu_notifier_unregister(&svm->notifier, svm->mm);
 
@@ -440,10 +447,11 @@ int intel_svm_is_pasid_valid(struct device *dev, int pasid)
 	if (!iommu)
 		goto out;
 
-	svm = intel_pasid_lookup_id(pasid);
-	if (!svm)
+	svm = ioasid_find(NULL, pasid, NULL);
+	if (IS_ERR(svm)) {
+		ret = PTR_ERR(svm);
 		goto out;
-
+	}
 	/* init_mm is used in this case */
 	if (!svm->mm)
 		ret = 1;
@@ -550,13 +558,12 @@ static irqreturn_t prq_event_thread(int irq, void *d)
 
 		if (!svm || svm->pasid != req->pasid) {
 			rcu_read_lock();
-			svm = intel_pasid_lookup_id(req->pasid);
+			svm = ioasid_find(NULL, req->pasid, NULL);
 			/* It *can't* go away, because the driver is not permitted
 			 * to unbind the mm while any page faults are outstanding.
 			 * So we only need RCU to protect the internal idr code. */
 			rcu_read_unlock();
-
-			if (!svm) {
+			if (IS_ERR(svm) || !svm) {
 				pr_err("%s: Page request for invalid PASID %d: %08llx %08llx\n",
 				       iommu->name, req->pasid, ((unsigned long long *)req)[0],
 				       ((unsigned long long *)req)[1]);
-- 
2.7.4

