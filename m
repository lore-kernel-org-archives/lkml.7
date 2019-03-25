Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78AEEC4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 01:37:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52C3120863
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 01:37:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729400AbfCYBha (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 21:37:30 -0400
Received: from mga04.intel.com ([192.55.52.120]:35778 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729354AbfCYBh0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 21:37:26 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Mar 2019 18:37:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,256,1549958400"; 
   d="scan'208";a="128326937"
Received: from allen-box.sh.intel.com ([10.239.159.136])
  by orsmga008.jf.intel.com with ESMTP; 24 Mar 2019 18:37:23 -0700
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
Subject: [PATCH v8 9/9] vfio/type1: Handle different mdev isolation type
Date:   Mon, 25 Mar 2019 09:30:36 +0800
Message-Id: <20190325013036.18400-10-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190325013036.18400-1-baolu.lu@linux.intel.com>
References: <20190325013036.18400-1-baolu.lu@linux.intel.com>
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
---
 drivers/vfio/vfio_iommu_type1.c | 55 +++++++++++++++++++++++++--------
 1 file changed, 42 insertions(+), 13 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index ccc4165474aa..b91cafcd5181 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -559,7 +559,7 @@ static int vfio_iommu_type1_pin_pages(void *iommu_data,
 	mutex_lock(&iommu->lock);
 
 	/* Fail if notifier list is empty */
-	if ((!iommu->external_domain) || (!iommu->notifier.head)) {
+	if (!iommu->notifier.head) {
 		ret = -EINVAL;
 		goto pin_done;
 	}
@@ -641,11 +641,6 @@ static int vfio_iommu_type1_unpin_pages(void *iommu_data,
 
 	mutex_lock(&iommu->lock);
 
-	if (!iommu->external_domain) {
-		mutex_unlock(&iommu->lock);
-		return -EINVAL;
-	}
-
 	do_accounting = !IS_IOMMU_CAP_DOMAIN_IN_CONTAINER(iommu);
 	for (i = 0; i < npage; i++) {
 		struct vfio_dma *dma;
@@ -1368,13 +1363,40 @@ static void vfio_iommu_detach_group(struct vfio_domain *domain,
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
@@ -1409,23 +1431,30 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
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

