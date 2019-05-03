Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DF38C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 22:29:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32C09206C1
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 22:29:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726999AbfECW3m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 18:29:42 -0400
Received: from mga02.intel.com ([134.134.136.20]:7007 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726776AbfECW3f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 18:29:35 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 May 2019 15:29:33 -0700
X-ExtLoop1: 1
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
  by orsmga002.jf.intel.com with ESMTP; 03 May 2019 15:29:33 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Eric Auger <eric.auger@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc:     "Yi Liu" <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        "Christoph Hellwig" <hch@infradead.org>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        Andriy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v3 08/16] iommu/vt-d: Replace Intel specific PASID allocator with IOASID
Date:   Fri,  3 May 2019 15:32:09 -0700
Message-Id: <1556922737-76313-9-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556922737-76313-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1556922737-76313-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make use of generic IOASID code to manage PASID allocation,
free, and lookup. Replace Intel specific code.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/intel-iommu.c | 11 +++++------
 drivers/iommu/intel-pasid.c | 36 ------------------------------------
 drivers/iommu/intel-svm.c   | 37 +++++++++++++++++++++----------------
 3 files changed, 26 insertions(+), 58 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index fcc694a..64af526 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -5155,7 +5155,7 @@ static void auxiliary_unlink_device(struct dmar_domain *domain,
 	domain->auxd_refcnt--;
 
 	if (!domain->auxd_refcnt && domain->default_pasid > 0)
-		intel_pasid_free_id(domain->default_pasid);
+		ioasid_free(domain->default_pasid);
 }
 
 static int aux_domain_add_dev(struct dmar_domain *domain,
@@ -5173,10 +5173,9 @@ static int aux_domain_add_dev(struct dmar_domain *domain,
 	if (domain->default_pasid <= 0) {
 		int pasid;
 
-		pasid = intel_pasid_alloc_id(domain, PASID_MIN,
-					     pci_max_pasids(to_pci_dev(dev)),
-					     GFP_KERNEL);
-		if (pasid <= 0) {
+		pasid = ioasid_alloc(NULL, PASID_MIN, pci_max_pasids(to_pci_dev(dev)) - 1,
+				domain);
+		if (pasid == INVALID_IOASID) {
 			pr_err("Can't allocate default pasid\n");
 			return -ENODEV;
 		}
@@ -5212,7 +5211,7 @@ static int aux_domain_add_dev(struct dmar_domain *domain,
 	spin_unlock(&iommu->lock);
 	spin_unlock_irqrestore(&device_domain_lock, flags);
 	if (!domain->auxd_refcnt && domain->default_pasid > 0)
-		intel_pasid_free_id(domain->default_pasid);
+		ioasid_free(domain->default_pasid);
 
 	return ret;
 }
diff --git a/drivers/iommu/intel-pasid.c b/drivers/iommu/intel-pasid.c
index 95f8f0c..2ce6ac2 100644
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
index f5d1e1e..8fff212 100644
--- a/drivers/iommu/intel-svm.c
+++ b/drivers/iommu/intel-svm.c
@@ -25,6 +25,7 @@
 #include <linux/dmar.h>
 #include <linux/interrupt.h>
 #include <linux/mm_types.h>
+#include <linux/ioasid.h>
 #include <asm/page.h>
 
 #include "intel-pasid.h"
@@ -334,16 +335,15 @@ int intel_svm_bind_mm(struct device *dev, int *pasid, int flags, struct svm_dev_
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
@@ -353,7 +353,7 @@ int intel_svm_bind_mm(struct device *dev, int *pasid, int flags, struct svm_dev_
 		if (mm) {
 			ret = mmu_notifier_register(&svm->notifier, mm);
 			if (ret) {
-				intel_pasid_free_id(svm->pasid);
+				ioasid_free(svm->pasid);
 				kfree(svm);
 				kfree(sdev);
 				goto out;
@@ -369,7 +369,7 @@ int intel_svm_bind_mm(struct device *dev, int *pasid, int flags, struct svm_dev_
 		if (ret) {
 			if (mm)
 				mmu_notifier_unregister(&svm->notifier, mm);
-			intel_pasid_free_id(svm->pasid);
+			ioasid_free(svm->pasid);
 			kfree(svm);
 			kfree(sdev);
 			goto out;
@@ -402,7 +402,12 @@ int intel_svm_unbind_mm(struct device *dev, int pasid)
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
 
@@ -424,7 +429,7 @@ int intel_svm_unbind_mm(struct device *dev, int pasid)
 				kfree_rcu(sdev, rcu);
 
 				if (list_empty(&svm->devs)) {
-					intel_pasid_free_id(svm->pasid);
+					ioasid_free(svm->pasid);
 					if (svm->mm)
 						mmu_notifier_unregister(&svm->notifier, svm->mm);
 
@@ -459,10 +464,11 @@ int intel_svm_is_pasid_valid(struct device *dev, int pasid)
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
@@ -569,13 +575,12 @@ static irqreturn_t prq_event_thread(int irq, void *d)
 
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

