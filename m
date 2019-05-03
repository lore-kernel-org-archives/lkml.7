Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAA12C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 22:30:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ECC8206C1
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 22:30:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbfECWaI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 18:30:08 -0400
Received: from mga02.intel.com ([134.134.136.20]:7006 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726831AbfECW3g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 18:29:36 -0400
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
Subject: [PATCH v3 13/16] iommu/vt-d: Clean up for SVM device list
Date:   Fri,  3 May 2019 15:32:14 -0700
Message-Id: <1556922737-76313-14-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556922737-76313-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1556922737-76313-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use combined macro for_each_svm_dev() to simplify SVM device iteration.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
---
 drivers/iommu/intel-svm.c | 79 +++++++++++++++++++++++------------------------
 1 file changed, 39 insertions(+), 40 deletions(-)

diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
index 8fff212..068dd9e 100644
--- a/drivers/iommu/intel-svm.c
+++ b/drivers/iommu/intel-svm.c
@@ -227,6 +227,9 @@ static const struct mmu_notifier_ops intel_mmuops = {
 
 static DEFINE_MUTEX(pasid_mutex);
 static LIST_HEAD(global_svm_list);
+#define for_each_svm_dev() \
+	list_for_each_entry(sdev, &svm->devs, list)	\
+	if (dev == sdev->dev)				\
 
 int intel_svm_bind_mm(struct device *dev, int *pasid, int flags, struct svm_dev_ops *ops)
 {
@@ -273,15 +276,13 @@ int intel_svm_bind_mm(struct device *dev, int *pasid, int flags, struct svm_dev_
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
+			for_each_svm_dev() {
+				if (sdev->ops != ops) {
+					ret = -EBUSY;
+					goto out;
 				}
+				sdev->users++;
+				goto success;
 			}
 
 			break;
@@ -411,40 +412,38 @@ int intel_svm_unbind_mm(struct device *dev, int pasid)
 	if (!svm)
 		goto out;
 
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
-				intel_flush_svm_range_dev(svm, sdev, 0, -1, 0, !svm->mm);
-				kfree_rcu(sdev, rcu);
-
-				if (list_empty(&svm->devs)) {
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
+	for_each_svm_dev() {
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
+			intel_flush_svm_range_dev(svm, sdev, 0, -1, 0, !svm->mm);
+			kfree_rcu(sdev, rcu);
+
+			if (list_empty(&svm->devs)) {
+				ioasid_free(svm->pasid);
+				if (svm->mm)
+					mmu_notifier_unregister(&svm->notifier, svm->mm);
+
+				list_del(&svm->list);
+
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
-- 
2.7.4

