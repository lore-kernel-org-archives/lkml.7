Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79E69C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 04:19:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FD7B2073F
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 04:19:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbfDLETj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 00:19:39 -0400
Received: from mga04.intel.com ([192.55.52.120]:45315 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725788AbfDLETg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 00:19:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Apr 2019 21:19:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,340,1549958400"; 
   d="scan'208";a="142094939"
Received: from allen-box.sh.intel.com ([10.239.159.136])
  by fmsmga007.fm.intel.com with ESMTP; 11 Apr 2019 21:19:33 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>
Cc:     ashok.raj@intel.com, sanjay.k.kumar@intel.com,
        jacob.jun.pan@intel.com, kevin.tian@intel.com,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        yi.l.liu@intel.com, yi.y.sun@intel.com, peterx@redhat.com,
        tiwei.bie@intel.com, xin.zeng@intel.com,
        iommu@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v9 3/3] vfio/type1: Handle different mdev isolation type
Date:   Fri, 12 Apr 2019 12:13:26 +0800
Message-Id: <20190412041326.19914-4-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190412041326.19914-1-baolu.lu@linux.intel.com>
References: <20190412041326.19914-1-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the support to determine the isolation type
of a mediated device group by checking whether it has
an iommu device. If an iommu device exists, an iommu
domain will be allocated and then attached to the iommu
device. Otherwise, keep the same behavior as it is.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Sanjay Kumar <sanjay.k.kumar@intel.com>
Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Reviewed-by: Kirti Wankhede <kwankhede@nvidia.com>
Acked-by: Alex Williamson <alex.williamson@redhat.com>
---
 drivers/vfio/vfio_iommu_type1.c | 55 +++++++++++++++++++++++++--------
 1 file changed, 42 insertions(+), 13 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index c956b85264ae..3be1db3501cc 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -565,7 +565,7 @@ static int vfio_iommu_type1_pin_pages(void *iommu_data,
 	mutex_lock(&iommu->lock);
 
 	/* Fail if notifier list is empty */
-	if ((!iommu->external_domain) || (!iommu->notifier.head)) {
+	if (!iommu->notifier.head) {
 		ret = -EINVAL;
 		goto pin_done;
 	}
@@ -647,11 +647,6 @@ static int vfio_iommu_type1_unpin_pages(void *iommu_data,
 
 	mutex_lock(&iommu->lock);
 
-	if (!iommu->external_domain) {
-		mutex_unlock(&iommu->lock);
-		return -EINVAL;
-	}
-
 	do_accounting = !IS_IOMMU_CAP_DOMAIN_IN_CONTAINER(iommu);
 	for (i = 0; i < npage; i++) {
 		struct vfio_dma *dma;
@@ -1381,13 +1376,40 @@ static void vfio_iommu_detach_group(struct vfio_domain *domain,
 		iommu_detach_group(domain->domain, group->iommu_group);
 }
 
+static bool vfio_bus_is_mdev(struct bus_type *bus)
+{
+	struct bus_type *mdev_bus;
+	bool ret = false;
+
+	mdev_bus = symbol_get(mdev_bus_type);
+	if (mdev_bus) {
+		ret = (bus == mdev_bus);
+		symbol_put(mdev_bus_type);
+	}
+
+	return ret;
+}
+
+static int vfio_mdev_iommu_device(struct device *dev, void *data)
+{
+	struct device **old = data, *new;
+
+	new = vfio_mdev_get_iommu_device(dev);
+	if (!new || (*old && *old != new))
+		return -EINVAL;
+
+	*old = new;
+
+	return 0;
+}
+
 static int vfio_iommu_type1_attach_group(void *iommu_data,
 					 struct iommu_group *iommu_group)
 {
 	struct vfio_iommu *iommu = iommu_data;
 	struct vfio_group *group;
 	struct vfio_domain *domain, *d;
-	struct bus_type *bus = NULL, *mdev_bus;
+	struct bus_type *bus = NULL;
 	int ret;
 	bool resv_msi, msi_remap;
 	phys_addr_t resv_msi_base;
@@ -1422,23 +1444,30 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
 	if (ret)
 		goto out_free;
 
-	mdev_bus = symbol_get(mdev_bus_type);
+	if (vfio_bus_is_mdev(bus)) {
+		struct device *iommu_device = NULL;
 
-	if (mdev_bus) {
-		if ((bus == mdev_bus) && !iommu_present(bus)) {
-			symbol_put(mdev_bus_type);
+		group->mdev_group = true;
+
+		/* Determine the isolation type */
+		ret = iommu_group_for_each_dev(iommu_group, &iommu_device,
+					       vfio_mdev_iommu_device);
+		if (ret || !iommu_device) {
 			if (!iommu->external_domain) {
 				INIT_LIST_HEAD(&domain->group_list);
 				iommu->external_domain = domain;
-			} else
+			} else {
 				kfree(domain);
+			}
 
 			list_add(&group->next,
 				 &iommu->external_domain->group_list);
 			mutex_unlock(&iommu->lock);
+
 			return 0;
 		}
-		symbol_put(mdev_bus_type);
+
+		bus = iommu_device->bus;
 	}
 
 	domain->domain = iommu_domain_alloc(bus);
-- 
2.17.1

