Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60443C28CC0
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 05:49:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 416272186A
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 05:49:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbfEYFtG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 May 2019 01:49:06 -0400
Received: from mga05.intel.com ([192.55.52.43]:46780 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726851AbfEYFtF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 01:49:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 May 2019 22:49:05 -0700
X-ExtLoop1: 1
Received: from allen-box.sh.intel.com ([10.239.159.136])
  by fmsmga006.fm.intel.com with ESMTP; 24 May 2019 22:49:02 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>
Cc:     ashok.raj@intel.com, jacob.jun.pan@intel.com, kevin.tian@intel.com,
        jamessewart@arista.com, tmurphy@arista.com, dima@arista.com,
        sai.praneeth.prakhya@intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v4 09/15] iommu/vt-d: Handle 32bit device with identity default domain
Date:   Sat, 25 May 2019 13:41:30 +0800
Message-Id: <20190525054136.27810-10-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190525054136.27810-1-baolu.lu@linux.intel.com>
References: <20190525054136.27810-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The iommu driver doesn't know whether the bit width of a PCI
device is sufficient for access to the whole system memory.
Hence, the driver checks this when the driver calls into the
dma APIs. If a device is using an identity domain, but the
bit width is less than the system requirement, we need to use
a dma domain instead. This also applies after we delegated
the domain life cycle management to the upper layer.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel-iommu.c | 55 +++++++++++++++----------------------
 1 file changed, 22 insertions(+), 33 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 08da484e01d6..b7f5a6390be6 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -3012,25 +3012,6 @@ static int device_def_domain_type(struct device *dev, int startup)
 			return IOMMU_DOMAIN_DMA;
 	}
 
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
-	}
-
 	return (iommu_identity_mapping & IDENTMAP_ALL) ?
 			IOMMU_DOMAIN_IDENTITY : 0;
 }
@@ -3642,14 +3623,19 @@ struct dmar_domain *get_valid_domain_for_dev(struct device *dev)
 /* Check if the dev needs to go through non-identity map and unmap process.*/
 static bool iommu_need_mapping(struct device *dev)
 {
-	int found;
+	int ret;
 
 	if (iommu_dummy(dev))
 		return false;
 
-	found = identity_mapping(dev);
-	if (found) {
-		if (iommu_should_identity_map(dev, 0))
+	ret = identity_mapping(dev);
+	if (ret) {
+		u64 dma_mask = *dev->dma_mask;
+
+		if (dev->coherent_dma_mask && dev->coherent_dma_mask < dma_mask)
+			dma_mask = dev->coherent_dma_mask;
+
+		if (dma_mask >= dma_get_required_mask(dev))
 			return false;
 
 		/*
@@ -3657,17 +3643,20 @@ static bool iommu_need_mapping(struct device *dev)
 		 * non-identity mapping.
 		 */
 		dmar_remove_one_dev_info(dev);
-		dev_info(dev, "32bit DMA uses non-identity mapping\n");
-	} else {
-		/*
-		 * In case of a detached 64 bit DMA device from vm, the device
-		 * is put into si_domain for identity mapping.
-		 */
-		if (iommu_should_identity_map(dev, 0) &&
-		    !domain_add_dev_info(si_domain, dev)) {
-			dev_info(dev, "64bit DMA uses identity mapping\n");
-			return false;
+		ret = iommu_request_dma_domain_for_dev(dev);
+		if (ret) {
+			struct iommu_domain *domain;
+			struct dmar_domain *dmar_domain;
+
+			domain = iommu_get_domain_for_dev(dev);
+			if (domain) {
+				dmar_domain = to_dmar_domain(domain);
+				dmar_domain->flags |= DOMAIN_FLAG_LOSE_CHILDREN;
+			}
+			get_valid_domain_for_dev(dev);
 		}
+
+		dev_info(dev, "32bit DMA uses non-identity mapping\n");
 	}
 
 	return true;
-- 
2.17.1

