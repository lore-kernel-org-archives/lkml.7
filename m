Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E26C282CE
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 05:49:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AE012133D
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 05:49:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbfEYFtU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 May 2019 01:49:20 -0400
Received: from mga05.intel.com ([192.55.52.43]:46780 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726990AbfEYFtR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 01:49:17 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 May 2019 22:49:16 -0700
X-ExtLoop1: 1
Received: from allen-box.sh.intel.com ([10.239.159.136])
  by fmsmga006.fm.intel.com with ESMTP; 24 May 2019 22:49:14 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>
Cc:     ashok.raj@intel.com, jacob.jun.pan@intel.com, kevin.tian@intel.com,
        jamessewart@arista.com, tmurphy@arista.com, dima@arista.com,
        sai.praneeth.prakhya@intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v4 15/15] iommu/vt-d: Remove static identity map code
Date:   Sat, 25 May 2019 13:41:36 +0800
Message-Id: <20190525054136.27810-16-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190525054136.27810-1-baolu.lu@linux.intel.com>
References: <20190525054136.27810-1-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code to prepare the static identity map for various reserved
memory ranges in intel_iommu_init() is duplicated with the default
domain mechanism now. Remove it to avoid duplication.

Signed-off-by: James Sewart <jamessewart@arista.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel-iommu.c | 144 +-----------------------------------
 1 file changed, 1 insertion(+), 143 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 7c7230ae6967..ce38c6b3763a 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -2789,31 +2789,6 @@ static inline int iommu_prepare_rmrr_dev(struct dmar_rmrr_unit *rmrr,
 					  rmrr->end_address);
 }
 
-#ifdef CONFIG_INTEL_IOMMU_FLOPPY_WA
-static inline void iommu_prepare_isa(void)
-{
-	struct pci_dev *pdev;
-	int ret;
-
-	pdev = pci_get_class(PCI_CLASS_BRIDGE_ISA << 8, NULL);
-	if (!pdev)
-		return;
-
-	pr_info("Prepare 0-16MiB unity mapping for LPC\n");
-	ret = iommu_prepare_identity_map(&pdev->dev, 0, 16*1024*1024 - 1);
-
-	if (ret)
-		pr_err("Failed to create 0-16MiB identity map - floppy might not work\n");
-
-	pci_dev_put(pdev);
-}
-#else
-static inline void iommu_prepare_isa(void)
-{
-	return;
-}
-#endif /* !CONFIG_INTEL_IOMMU_FLPY_WA */
-
 static int md_domain_init(struct dmar_domain *domain, int guest_width);
 
 static int __init si_domain_init(int hw)
@@ -3028,68 +3003,6 @@ static int device_def_domain_type(struct device *dev)
 			IOMMU_DOMAIN_IDENTITY : 0;
 }
 
-static inline int iommu_should_identity_map(struct device *dev)
-{
-	return device_def_domain_type(dev) == IOMMU_DOMAIN_IDENTITY;
-}
-
-static int __init dev_prepare_static_identity_mapping(struct device *dev, int hw)
-{
-	int ret;
-
-	if (!iommu_should_identity_map(dev))
-		return 0;
-
-	ret = domain_add_dev_info(si_domain, dev);
-	if (!ret)
-		dev_info(dev, "%s identity mapping\n",
-			 hw ? "Hardware" : "Software");
-	else if (ret == -ENODEV)
-		/* device not associated with an iommu */
-		ret = 0;
-
-	return ret;
-}
-
-
-static int __init iommu_prepare_static_identity_mapping(int hw)
-{
-	struct pci_dev *pdev = NULL;
-	struct dmar_drhd_unit *drhd;
-	struct intel_iommu *iommu;
-	struct device *dev;
-	int i;
-	int ret = 0;
-
-	for_each_pci_dev(pdev) {
-		ret = dev_prepare_static_identity_mapping(&pdev->dev, hw);
-		if (ret)
-			return ret;
-	}
-
-	for_each_active_iommu(iommu, drhd)
-		for_each_active_dev_scope(drhd->devices, drhd->devices_cnt, i, dev) {
-			struct acpi_device_physical_node *pn;
-			struct acpi_device *adev;
-
-			if (dev->bus != &acpi_bus_type)
-				continue;
-
-			adev= to_acpi_device(dev);
-			mutex_lock(&adev->physical_node_lock);
-			list_for_each_entry(pn, &adev->physical_node_list, node) {
-				ret = dev_prepare_static_identity_mapping(pn->dev, hw);
-				if (ret)
-					break;
-			}
-			mutex_unlock(&adev->physical_node_lock);
-			if (ret)
-				return ret;
-		}
-
-	return 0;
-}
-
 static void intel_iommu_init_qi(struct intel_iommu *iommu)
 {
 	/*
@@ -3312,11 +3225,8 @@ static int copy_translation_tables(struct intel_iommu *iommu)
 static int __init init_dmars(void)
 {
 	struct dmar_drhd_unit *drhd;
-	struct dmar_rmrr_unit *rmrr;
-	bool copied_tables = false;
-	struct device *dev;
 	struct intel_iommu *iommu;
-	int i, ret;
+	int ret;
 
 	/*
 	 * for each drhd
@@ -3409,7 +3319,6 @@ static int __init init_dmars(void)
 			} else {
 				pr_info("Copied translation tables from previous kernel for %s\n",
 					iommu->name);
-				copied_tables = true;
 			}
 		}
 
@@ -3449,57 +3358,6 @@ static int __init init_dmars(void)
 	if (ret)
 		goto free_iommu;
 
-
-	/*
-	 * If we copied translations from a previous kernel in the kdump
-	 * case, we can not assign the devices to domains now, as that
-	 * would eliminate the old mappings. So skip this part and defer
-	 * the assignment to device driver initialization time.
-	 */
-	if (copied_tables)
-		goto domains_done;
-
-	/*
-	 * If pass through is not set or not enabled, setup context entries for
-	 * identity mappings for rmrr, gfx, and isa and may fall back to static
-	 * identity mapping if iommu_identity_mapping is set.
-	 */
-	if (iommu_identity_mapping) {
-		ret = iommu_prepare_static_identity_mapping(hw_pass_through);
-		if (ret) {
-			pr_crit("Failed to setup IOMMU pass-through\n");
-			goto free_iommu;
-		}
-	}
-	/*
-	 * For each rmrr
-	 *   for each dev attached to rmrr
-	 *   do
-	 *     locate drhd for dev, alloc domain for dev
-	 *     allocate free domain
-	 *     allocate page table entries for rmrr
-	 *     if context not allocated for bus
-	 *           allocate and init context
-	 *           set present in root table for this bus
-	 *     init context with domain, translation etc
-	 *    endfor
-	 * endfor
-	 */
-	pr_info("Setting RMRR:\n");
-	for_each_rmrr_units(rmrr) {
-		/* some BIOS lists non-exist devices in DMAR table. */
-		for_each_active_dev_scope(rmrr->devices, rmrr->devices_cnt,
-					  i, dev) {
-			ret = iommu_prepare_rmrr_dev(rmrr, dev);
-			if (ret)
-				pr_err("Mapping reserved region failed\n");
-		}
-	}
-
-	iommu_prepare_isa();
-
-domains_done:
-
 	/*
 	 * for each drhd
 	 *   enable fault log
-- 
2.17.1

