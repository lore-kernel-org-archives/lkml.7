Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 693E1C282CE
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 05:49:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 460AC2133D
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 05:49:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbfEYFtD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 May 2019 01:49:03 -0400
Received: from mga05.intel.com ([192.55.52.43]:46780 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726794AbfEYFs5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 01:48:57 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 May 2019 22:48:57 -0700
X-ExtLoop1: 1
Received: from allen-box.sh.intel.com ([10.239.159.136])
  by fmsmga006.fm.intel.com with ESMTP; 24 May 2019 22:48:54 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>
Cc:     ashok.raj@intel.com, jacob.jun.pan@intel.com, kevin.tian@intel.com,
        jamessewart@arista.com, tmurphy@arista.com, dima@arista.com,
        sai.praneeth.prakhya@intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v4 05/15] iommu/vt-d: Add device_def_domain_type() helper
Date:   Sat, 25 May 2019 13:41:26 +0800
Message-Id: <20190525054136.27810-6-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190525054136.27810-1-baolu.lu@linux.intel.com>
References: <20190525054136.27810-1-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This helper returns the default domain type that the device
requires.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel-iommu.c | 40 +++++++++++++++++++++++++------------
 1 file changed, 27 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index bac226dc8360..e1663af4e01b 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -2958,29 +2958,37 @@ static bool device_is_rmrr_locked(struct device *dev)
 	return true;
 }
 
-static int iommu_should_identity_map(struct device *dev, int startup)
+/*
+ * Return the required default domain type for a specific device.
+ *
+ * @dev: the device in query
+ * @startup: true if this is during early boot
+ *
+ * Returns:
+ *  - IOMMU_DOMAIN_DMA: device requires a dynamic mapping domain
+ *  - IOMMU_DOMAIN_IDENTITY: device requires an identical mapping domain
+ *  - 0: both identity and dynamic domains work for this device
+ */
+static int device_def_domain_type(struct device *dev, int startup)
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
@@ -3001,14 +3009,14 @@ static int iommu_should_identity_map(struct device *dev, int startup)
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
+			return IOMMU_DOMAIN_DMA;
 	}
 
 	/*
@@ -3030,7 +3038,13 @@ static int iommu_should_identity_map(struct device *dev, int startup)
 		return dma_mask >= dma_get_required_mask(dev);
 	}
 
-	return 1;
+	return (iommu_identity_mapping & IDENTMAP_ALL) ?
+			IOMMU_DOMAIN_IDENTITY : 0;
+}
+
+static inline int iommu_should_identity_map(struct device *dev, int startup)
+{
+	return device_def_domain_type(dev, startup) == IOMMU_DOMAIN_IDENTITY;
 }
 
 static int __init dev_prepare_static_identity_mapping(struct device *dev, int hw)
-- 
2.17.1

