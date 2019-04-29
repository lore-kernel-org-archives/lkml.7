Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7195C43218
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 02:16:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A13B820843
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 02:16:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727279AbfD2CQO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 22:16:14 -0400
Received: from mga03.intel.com ([134.134.136.65]:46364 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727227AbfD2CQK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 22:16:10 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Apr 2019 19:16:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,408,1549958400"; 
   d="scan'208";a="146537863"
Received: from allen-box.sh.intel.com ([10.239.159.136])
  by orsmga003.jf.intel.com with ESMTP; 28 Apr 2019 19:16:07 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>
Cc:     ashok.raj@intel.com, jacob.jun.pan@intel.com, kevin.tian@intel.com,
        jamessewart@arista.com, tmurphy@arista.com, dima@arista.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v3 5/8] iommu/vt-d: Implement def_domain_type iommu ops entry
Date:   Mon, 29 Apr 2019 10:09:22 +0800
Message-Id: <20190429020925.18136-6-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190429020925.18136-1-baolu.lu@linux.intel.com>
References: <20190429020925.18136-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It will be used by the iommu generic framework to check the
default domain types that Intel IOMMU driver supports for a
specific device. Return IOMMU_DOMAIN_DMA if device requires
a non-identity domain;  Return IOMMU_DOMAIN_IDENTITY if the
device requires to use an identity domain. Otherwise return
IOMMU_DOMAIN_ANY which indicates that both domain types are
supported, hence the static default domain type defined in
iommu generic layer will be used.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel-iommu.c | 86 +++++++++++++------------------------
 1 file changed, 29 insertions(+), 57 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 847e4a326d29..d2b51e045603 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -2858,9 +2858,6 @@ static int identity_mapping(struct device *dev)
 {
 	struct device_domain_info *info;
 
-	if (likely(!iommu_identity_mapping))
-		return 0;
-
 	info = dev->archdata.iommu;
 	if (info && info != DUMMY_DEVICE_DOMAIN_INFO)
 		return (info->domain == si_domain);
@@ -2945,29 +2942,26 @@ static bool device_is_rmrr_locked(struct device *dev)
 	return true;
 }
 
-static int iommu_should_identity_map(struct device *dev, int startup)
+static int intel_iommu_def_domain_type(struct device *dev)
 {
 	if (dev_is_pci(dev)) {
 		struct pci_dev *pdev = to_pci_dev(dev);
 
 		if (device_is_rmrr_locked(dev))
-			return 0;
+			return IOMMU_DOMAIN_DMA;
 
 		/*
 		 * Prevent any device marked as untrusted from getting
 		 * placed into the statically identity mapping domain.
 		 */
 		if (pdev->untrusted)
-			return 0;
+			return IOMMU_DOMAIN_DMA;
 
 		if ((iommu_identity_mapping & IDENTMAP_AZALIA) && IS_AZALIA(pdev))
-			return 1;
+			return IOMMU_DOMAIN_IDENTITY;
 
 		if ((iommu_identity_mapping & IDENTMAP_GFX) && IS_GFX_DEVICE(pdev))
-			return 1;
-
-		if (!(iommu_identity_mapping & IDENTMAP_ALL))
-			return 0;
+			return IOMMU_DOMAIN_IDENTITY;
 
 		/*
 		 * We want to start off with all devices in the 1:1 domain, and
@@ -2988,43 +2982,25 @@ static int iommu_should_identity_map(struct device *dev, int startup)
 		 */
 		if (!pci_is_pcie(pdev)) {
 			if (!pci_is_root_bus(pdev->bus))
-				return 0;
+				return IOMMU_DOMAIN_DMA;
 			if (pdev->class >> 8 == PCI_CLASS_BRIDGE_PCI)
-				return 0;
+				return IOMMU_DOMAIN_DMA;
 		} else if (pci_pcie_type(pdev) == PCI_EXP_TYPE_PCI_BRIDGE)
-			return 0;
+			return IOMMU_DOMAIN_DMA;
 	} else {
 		if (device_has_rmrr(dev))
-			return 0;
-	}
-
-	/*
-	 * At boot time, we don't yet know if devices will be 64-bit capable.
-	 * Assume that they will — if they turn out not to be, then we can
-	 * take them out of the 1:1 domain later.
-	 */
-	if (!startup) {
-		/*
-		 * If the device's dma_mask is less than the system's memory
-		 * size then this is not a candidate for identity mapping.
-		 */
-		u64 dma_mask = *dev->dma_mask;
-
-		if (dev->coherent_dma_mask &&
-		    dev->coherent_dma_mask < dma_mask)
-			dma_mask = dev->coherent_dma_mask;
-
-		return dma_mask >= dma_get_required_mask(dev);
+			return IOMMU_DOMAIN_DMA;
 	}
 
-	return 1;
+	return (iommu_identity_mapping & IDENTMAP_ALL) ?
+			IOMMU_DOMAIN_IDENTITY : IOMMU_DOMAIN_ANY;
 }
 
 static int __init dev_prepare_static_identity_mapping(struct device *dev, int hw)
 {
 	int ret;
 
-	if (!iommu_should_identity_map(dev, 1))
+	if (intel_iommu_def_domain_type(dev) != IOMMU_DOMAIN_IDENTITY)
 		return 0;
 
 	ret = domain_add_dev_info(si_domain, dev);
@@ -3631,35 +3607,30 @@ static int iommu_no_mapping(struct device *dev)
 	if (iommu_dummy(dev))
 		return 1;
 
-	if (!iommu_identity_mapping)
-		return 0;
-
 	found = identity_mapping(dev);
 	if (found) {
-		if (iommu_should_identity_map(dev, 0))
-			return 1;
-		else {
+		/*
+		 * If the device's dma_mask is less than the system's memory
+		 * size then this is not a candidate for identity mapping.
+		 */
+		u64 dma_mask = *dev->dma_mask;
+
+		if (dev->coherent_dma_mask &&
+		    dev->coherent_dma_mask < dma_mask)
+			dma_mask = dev->coherent_dma_mask;
+
+		if (dma_mask < dma_get_required_mask(dev)) {
 			/*
 			 * 32 bit DMA is removed from si_domain and fall back
 			 * to non-identity mapping.
 			 */
 			dmar_remove_one_dev_info(dev);
-			dev_info(dev, "32bit DMA uses non-identity mapping\n");
+			dev_warn(dev, "32bit DMA uses non-identity mapping\n");
+
 			return 0;
 		}
-	} else {
-		/*
-		 * In case of a detached 64 bit DMA device from vm, the device
-		 * is put into si_domain for identity mapping.
-		 */
-		if (iommu_should_identity_map(dev, 0)) {
-			int ret;
-			ret = domain_add_dev_info(si_domain, dev);
-			if (!ret) {
-				dev_info(dev, "64bit DMA uses identity mapping\n");
-				return 1;
-			}
-		}
+
+		return 1;
 	}
 
 	return 0;
@@ -4605,7 +4576,7 @@ static int device_notifier(struct notifier_block *nb,
 		    list_empty(&domain->devices))
 			domain_exit(domain);
 	} else if (action == BUS_NOTIFY_ADD_DEVICE) {
-		if (iommu_should_identity_map(dev, 1))
+		if (intel_iommu_def_domain_type(dev) == IOMMU_DOMAIN_IDENTITY)
 			domain_add_dev_info(si_domain, dev);
 	}
 
@@ -5781,6 +5752,7 @@ const struct iommu_ops intel_iommu_ops = {
 	.dev_feat_enabled	= intel_iommu_dev_feat_enabled,
 	.dev_enable_feat	= intel_iommu_dev_enable_feat,
 	.dev_disable_feat	= intel_iommu_dev_disable_feat,
+	.def_domain_type	= intel_iommu_def_domain_type,
 	.pgsize_bitmap		= INTEL_IOMMU_PGSIZES,
 };
 
-- 
2.17.1

