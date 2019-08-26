Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D23FC3A59E
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 08:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69F9620874
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 08:52:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729758AbfHZIwO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 04:52:14 -0400
Received: from mga05.intel.com ([192.55.52.43]:4367 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726401AbfHZIwN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 04:52:13 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Aug 2019 01:52:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,431,1559545200"; 
   d="scan'208";a="379578251"
Received: from allen-box.sh.intel.com ([10.239.159.136])
  by fmsmga005.fm.intel.com with ESMTP; 26 Aug 2019 01:52:11 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Stijn Tintel <stijn@linux-ipv6.be>,
        Petr Vandrovec <petr@vandrovec.name>
Subject: [PATCH 1/1] Revert "iommu/vt-d: Avoid duplicated pci dma alias consideration"
Date:   Mon, 26 Aug 2019 16:50:56 +0800
Message-Id: <20190826085056.32484-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 557529494d79f3f1fadd486dd18d2de0b19be4da.

Commit 557529494d79f ("iommu/vt-d: Avoid duplicated pci dma alias
consideration") aimed to address a NULL pointer deference issue
happened when a thunderbolt device driver returned unexpectedly.

Unfortunately, this change breaks a previous pci quirk added by
commit cc346a4714a59 ("PCI: Add function 1 DMA alias quirk for
Marvell devices"), as the result, devices like Marvell 88SE9128
SATA controller doesn't work anymore.

We will continue to try to find the real culprit mentioned in
557529494d79f, but for now we should revert it to fix current
breakage.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=204627
Cc: Stijn Tintel <stijn@linux-ipv6.be>
Cc: Petr Vandrovec <petr@vandrovec.name>
Reported-by: Stijn Tintel <stijn@linux-ipv6.be>
Reported-by: Petr Vandrovec <petr@vandrovec.name>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel-iommu.c | 55 +++++++++++++++++++++++++++++++++++--
 1 file changed, 53 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 12d094d08c0a..c4e0e4a9ee9e 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -339,6 +339,8 @@ static void domain_exit(struct dmar_domain *domain);
 static void domain_remove_dev_info(struct dmar_domain *domain);
 static void dmar_remove_one_dev_info(struct device *dev);
 static void __dmar_remove_one_dev_info(struct device_domain_info *info);
+static void domain_context_clear(struct intel_iommu *iommu,
+				 struct device *dev);
 static int domain_detach_iommu(struct dmar_domain *domain,
 			       struct intel_iommu *iommu);
 static bool device_is_rmrr_locked(struct device *dev);
@@ -2105,9 +2107,26 @@ static int domain_context_mapping_one(struct dmar_domain *domain,
 	return ret;
 }
 
+struct domain_context_mapping_data {
+	struct dmar_domain *domain;
+	struct intel_iommu *iommu;
+	struct pasid_table *table;
+};
+
+static int domain_context_mapping_cb(struct pci_dev *pdev,
+				     u16 alias, void *opaque)
+{
+	struct domain_context_mapping_data *data = opaque;
+
+	return domain_context_mapping_one(data->domain, data->iommu,
+					  data->table, PCI_BUS_NUM(alias),
+					  alias & 0xff);
+}
+
 static int
 domain_context_mapping(struct dmar_domain *domain, struct device *dev)
 {
+	struct domain_context_mapping_data data;
 	struct pasid_table *table;
 	struct intel_iommu *iommu;
 	u8 bus, devfn;
@@ -2117,7 +2136,17 @@ domain_context_mapping(struct dmar_domain *domain, struct device *dev)
 		return -ENODEV;
 
 	table = intel_pasid_get_table(dev);
-	return domain_context_mapping_one(domain, iommu, table, bus, devfn);
+
+	if (!dev_is_pci(dev))
+		return domain_context_mapping_one(domain, iommu, table,
+						  bus, devfn);
+
+	data.domain = domain;
+	data.iommu = iommu;
+	data.table = table;
+
+	return pci_for_each_dma_alias(to_pci_dev(dev),
+				      &domain_context_mapping_cb, &data);
 }
 
 static int domain_context_mapped_cb(struct pci_dev *pdev,
@@ -4759,6 +4788,28 @@ int __init intel_iommu_init(void)
 	return ret;
 }
 
+static int domain_context_clear_one_cb(struct pci_dev *pdev, u16 alias, void *opaque)
+{
+	struct intel_iommu *iommu = opaque;
+
+	domain_context_clear_one(iommu, PCI_BUS_NUM(alias), alias & 0xff);
+	return 0;
+}
+
+/*
+ * NB - intel-iommu lacks any sort of reference counting for the users of
+ * dependent devices.  If multiple endpoints have intersecting dependent
+ * devices, unbinding the driver from any one of them will possibly leave
+ * the others unable to operate.
+ */
+static void domain_context_clear(struct intel_iommu *iommu, struct device *dev)
+{
+	if (!iommu || !dev || !dev_is_pci(dev))
+		return;
+
+	pci_for_each_dma_alias(to_pci_dev(dev), &domain_context_clear_one_cb, iommu);
+}
+
 static void __dmar_remove_one_dev_info(struct device_domain_info *info)
 {
 	struct dmar_domain *domain;
@@ -4779,7 +4830,7 @@ static void __dmar_remove_one_dev_info(struct device_domain_info *info)
 					PASID_RID2PASID);
 
 		iommu_disable_dev_iotlb(info);
-		domain_context_clear_one(iommu, info->bus, info->devfn);
+		domain_context_clear(iommu, info->dev);
 		intel_pasid_free_table(info->dev);
 	}
 
-- 
2.17.1

