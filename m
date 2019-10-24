Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A708CA9EBC
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 19:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 014562070B
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 19:51:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438539AbfJXTu7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 15:50:59 -0400
Received: from mga07.intel.com ([134.134.136.100]:62203 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438196AbfJXTut (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 15:50:49 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Oct 2019 12:50:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,225,1569308400"; 
   d="scan'208";a="282043158"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
  by orsmga001.jf.intel.com with ESMTP; 24 Oct 2019 12:50:43 -0700
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
Subject: [PATCH v7 08/11] iommu/vt-d: Misc macro clean up for SVM
Date:   Thu, 24 Oct 2019 12:55:01 -0700
Message-Id: <1571946904-86776-9-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1571946904-86776-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1571946904-86776-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use combined macros for_each_svm_dev() to simplify SVM device iteration
and error checking.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
---
 drivers/iommu/intel-svm.c | 89 ++++++++++++++++++++++-------------------------
 1 file changed, 42 insertions(+), 47 deletions(-)

diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
index a9a7f85a09bc..a18b02a9709d 100644
--- a/drivers/iommu/intel-svm.c
+++ b/drivers/iommu/intel-svm.c
@@ -212,6 +212,10 @@ static const struct mmu_notifier_ops intel_mmuops = {
 static DEFINE_MUTEX(pasid_mutex);
 static LIST_HEAD(global_svm_list);
 
+#define for_each_svm_dev(svm, dev)			\
+	list_for_each_entry(sdev, &svm->devs, list)	\
+	if (dev == sdev->dev)				\
+
 int intel_svm_bind_mm(struct device *dev, int *pasid, int flags, struct svm_dev_ops *ops)
 {
 	struct intel_iommu *iommu = intel_svm_device_to_iommu(dev);
@@ -257,15 +261,13 @@ int intel_svm_bind_mm(struct device *dev, int *pasid, int flags, struct svm_dev_
 				goto out;
 			}
 
-			list_for_each_entry(sdev, &svm->devs, list) {
-				if (dev == sdev->dev) {
-					if (sdev->ops != ops) {
-						ret = -EBUSY;
-						goto out;
-					}
-					sdev->users++;
-					goto success;
+			for_each_svm_dev(svm, dev) {
+				if (sdev->ops != ops) {
+					ret = -EBUSY;
+					goto out;
 				}
+				sdev->users++;
+				goto success;
 			}
 
 			break;
@@ -402,50 +404,43 @@ int intel_svm_unbind_mm(struct device *dev, int pasid)
 		goto out;
 
 	svm = ioasid_find(NULL, pasid, NULL);
-	if (IS_ERR(svm)) {
+	if (IS_ERR_OR_NULL(svm)) {
 		ret = PTR_ERR(svm);
 		goto out;
 	}
 
-	if (!svm)
-		goto out;
-
-	list_for_each_entry(sdev, &svm->devs, list) {
-		if (dev == sdev->dev) {
-			ret = 0;
-			sdev->users--;
-			if (!sdev->users) {
-				list_del_rcu(&sdev->list);
-				/* Flush the PASID cache and IOTLB for this device.
-				 * Note that we do depend on the hardware *not* using
-				 * the PASID any more. Just as we depend on other
-				 * devices never using PASIDs that they have no right
-				 * to use. We have a *shared* PASID table, because it's
-				 * large and has to be physically contiguous. So it's
-				 * hard to be as defensive as we might like. */
-				intel_pasid_tear_down_entry(iommu, dev, svm->pasid);
-				intel_flush_svm_range_dev(svm, sdev, 0, -1, 0);
-				kfree_rcu(sdev, rcu);
-
-				if (list_empty(&svm->devs)) {
-					/* Clear private data so that free pass check */
-					ioasid_set_data(svm->pasid, NULL);
-					ioasid_free(svm->pasid);
-					if (svm->mm)
-						mmu_notifier_unregister(&svm->notifier, svm->mm);
-
-					list_del(&svm->list);
-
-					/* We mandate that no page faults may be outstanding
-					 * for the PASID when intel_svm_unbind_mm() is called.
-					 * If that is not obeyed, subtle errors will happen.
-					 * Let's make them less subtle... */
-					memset(svm, 0x6b, sizeof(*svm));
-					kfree(svm);
-				}
+	for_each_svm_dev(svm, dev) {
+		ret = 0;
+		sdev->users--;
+		if (!sdev->users) {
+			list_del_rcu(&sdev->list);
+			/* Flush the PASID cache and IOTLB for this device.
+			 * Note that we do depend on the hardware *not* using
+			 * the PASID any more. Just as we depend on other
+			 * devices never using PASIDs that they have no right
+			 * to use. We have a *shared* PASID table, because it's
+			 * large and has to be physically contiguous. So it's
+			 * hard to be as defensive as we might like. */
+			intel_pasid_tear_down_entry(iommu, dev, svm->pasid);
+			intel_flush_svm_range_dev(svm, sdev, 0, -1, 0);
+			kfree_rcu(sdev, rcu);
+
+			if (list_empty(&svm->devs)) {
+				/* Clear private data so that free pass check */
+				ioasid_set_data(svm->pasid, NULL);
+				ioasid_free(svm->pasid);
+				if (svm->mm)
+					mmu_notifier_unregister(&svm->notifier, svm->mm);
+				list_del(&svm->list);
+				/* We mandate that no page faults may be outstanding
+				 * for the PASID when intel_svm_unbind_mm() is called.
+				 * If that is not obeyed, subtle errors will happen.
+				 * Let's make them less subtle... */
+				memset(svm, 0x6b, sizeof(*svm));
+				kfree(svm);
 			}
-			break;
 		}
+		break;
 	}
  out:
 	mutex_unlock(&pasid_mutex);
@@ -581,7 +576,7 @@ static irqreturn_t prq_event_thread(int irq, void *d)
 			 * to unbind the mm while any page faults are outstanding.
 			 * So we only need RCU to protect the internal idr code. */
 			rcu_read_unlock();
-			if (IS_ERR(svm) || !svm) {
+			if (IS_ERR_OR_NULL(svm)) {
 				pr_err("%s: Page request for invalid PASID %d: %08llx %08llx\n",
 				       iommu->name, req->pasid, ((unsigned long long *)req)[0],
 				       ((unsigned long long *)req)[1]);
-- 
2.7.4

