Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9E95C43218
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 02:16:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BF4F20843
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 02:16:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbfD2CQS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 22:16:18 -0400
Received: from mga03.intel.com ([134.134.136.65]:46364 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727273AbfD2CQO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 22:16:14 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Apr 2019 19:16:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,408,1549958400"; 
   d="scan'208";a="146537874"
Received: from allen-box.sh.intel.com ([10.239.159.136])
  by orsmga003.jf.intel.com with ESMTP; 28 Apr 2019 19:16:11 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>
Cc:     ashok.raj@intel.com, jacob.jun.pan@intel.com, kevin.tian@intel.com,
        jamessewart@arista.com, tmurphy@arista.com, dima@arista.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 7/8] iommu/vt-d: Remove lazy allocation of domains
Date:   Mon, 29 Apr 2019 10:09:24 +0800
Message-Id: <20190429020925.18136-8-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190429020925.18136-1-baolu.lu@linux.intel.com>
References: <20190429020925.18136-1-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: James Sewart <jamessewart@arista.com>

The generic IOMMU code will manage the life cycle of a default
domain for each device that comes online. This patch removes the
lazy domain allocation and early reserved region mapping that is
now redundant.

Signed-off-by: James Sewart <jamessewart@arista.com>
---
 drivers/iommu/intel-iommu.c | 356 +-----------------------------------
 1 file changed, 5 insertions(+), 351 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index ec6ac39827ab..dd6abd554804 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -1862,63 +1862,6 @@ static inline int guestwidth_to_adjustwidth(int gaw)
 	return agaw;
 }
 
-static int domain_init(struct dmar_domain *domain, struct intel_iommu *iommu,
-		       int guest_width)
-{
-	int adjust_width, agaw;
-	unsigned long sagaw;
-	int err;
-
-	init_iova_domain(&domain->iovad, VTD_PAGE_SIZE, IOVA_START_PFN);
-
-	err = init_iova_flush_queue(&domain->iovad,
-				    iommu_flush_iova, iova_entry_free);
-	if (err)
-		return err;
-
-	domain_reserve_special_ranges(domain);
-
-	/* calculate AGAW */
-	if (guest_width > cap_mgaw(iommu->cap))
-		guest_width = cap_mgaw(iommu->cap);
-	domain->gaw = guest_width;
-	adjust_width = guestwidth_to_adjustwidth(guest_width);
-	agaw = width_to_agaw(adjust_width);
-	sagaw = cap_sagaw(iommu->cap);
-	if (!test_bit(agaw, &sagaw)) {
-		/* hardware doesn't support it, choose a bigger one */
-		pr_debug("Hardware doesn't support agaw %d\n", agaw);
-		agaw = find_next_bit(&sagaw, 5, agaw);
-		if (agaw >= 5)
-			return -ENODEV;
-	}
-	domain->agaw = agaw;
-
-	if (ecap_coherent(iommu->ecap))
-		domain->iommu_coherency = 1;
-	else
-		domain->iommu_coherency = 0;
-
-	if (ecap_sc_support(iommu->ecap))
-		domain->iommu_snooping = 1;
-	else
-		domain->iommu_snooping = 0;
-
-	if (intel_iommu_superpage)
-		domain->iommu_superpage = fls(cap_super_page_val(iommu->cap));
-	else
-		domain->iommu_superpage = 0;
-
-	domain->nid = iommu->node;
-
-	/* always allocate the top pgd */
-	domain->pgd = (struct dma_pte *)alloc_pgtable_page(domain->nid);
-	if (!domain->pgd)
-		return -ENOMEM;
-	__iommu_flush_cache(iommu, domain->pgd, PAGE_SIZE);
-	return 0;
-}
-
 static void domain_exit(struct dmar_domain *domain)
 {
 	struct page *freelist;
@@ -2600,118 +2543,6 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
 	return domain;
 }
 
-static int get_last_alias(struct pci_dev *pdev, u16 alias, void *opaque)
-{
-	*(u16 *)opaque = alias;
-	return 0;
-}
-
-static struct dmar_domain *find_or_alloc_domain(struct device *dev, int gaw)
-{
-	struct device_domain_info *info;
-	struct dmar_domain *domain = NULL;
-	struct intel_iommu *iommu;
-	u16 dma_alias;
-	unsigned long flags;
-	u8 bus, devfn;
-
-	iommu = device_to_iommu(dev, &bus, &devfn);
-	if (!iommu)
-		return NULL;
-
-	if (dev_is_pci(dev)) {
-		struct pci_dev *pdev = to_pci_dev(dev);
-
-		pci_for_each_dma_alias(pdev, get_last_alias, &dma_alias);
-
-		spin_lock_irqsave(&device_domain_lock, flags);
-		info = dmar_search_domain_by_dev_info(pci_domain_nr(pdev->bus),
-						      PCI_BUS_NUM(dma_alias),
-						      dma_alias & 0xff);
-		if (info) {
-			iommu = info->iommu;
-			domain = info->domain;
-		}
-		spin_unlock_irqrestore(&device_domain_lock, flags);
-
-		/* DMA alias already has a domain, use it */
-		if (info)
-			goto out;
-	}
-
-	/* Allocate and initialize new domain for the device */
-	domain = alloc_domain(0);
-	if (!domain)
-		return NULL;
-	if (domain_init(domain, iommu, gaw)) {
-		domain_exit(domain);
-		return NULL;
-	}
-
-out:
-
-	return domain;
-}
-
-static struct dmar_domain *set_domain_for_dev(struct device *dev,
-					      struct dmar_domain *domain)
-{
-	struct intel_iommu *iommu;
-	struct dmar_domain *tmp;
-	u16 req_id, dma_alias;
-	u8 bus, devfn;
-
-	iommu = device_to_iommu(dev, &bus, &devfn);
-	if (!iommu)
-		return NULL;
-
-	req_id = ((u16)bus << 8) | devfn;
-
-	if (dev_is_pci(dev)) {
-		struct pci_dev *pdev = to_pci_dev(dev);
-
-		pci_for_each_dma_alias(pdev, get_last_alias, &dma_alias);
-
-		/* register PCI DMA alias device */
-		if (req_id != dma_alias) {
-			tmp = dmar_insert_one_dev_info(iommu, PCI_BUS_NUM(dma_alias),
-					dma_alias & 0xff, NULL, domain);
-
-			if (!tmp || tmp != domain)
-				return tmp;
-		}
-	}
-
-	tmp = dmar_insert_one_dev_info(iommu, bus, devfn, dev, domain);
-	if (!tmp || tmp != domain)
-		return tmp;
-
-	return domain;
-}
-
-static struct dmar_domain *get_domain_for_dev(struct device *dev, int gaw)
-{
-	struct dmar_domain *domain, *tmp;
-
-	domain = find_domain(dev);
-	if (domain)
-		goto out;
-
-	domain = find_or_alloc_domain(dev, gaw);
-	if (!domain)
-		goto out;
-
-	tmp = set_domain_for_dev(dev, domain);
-	if (!tmp || domain != tmp) {
-		domain_exit(domain);
-		domain = tmp;
-	}
-
-out:
-
-	return domain;
-}
-
 static int iommu_domain_identity_map(struct dmar_domain *domain,
 				     unsigned long long start,
 				     unsigned long long end)
@@ -2737,72 +2568,6 @@ static int iommu_domain_identity_map(struct dmar_domain *domain,
 				DMA_PTE_READ|DMA_PTE_WRITE);
 }
 
-static int domain_prepare_identity_map(struct device *dev,
-				       struct dmar_domain *domain,
-				       unsigned long long start,
-				       unsigned long long end)
-{
-	/* For _hardware_ passthrough, don't bother. But for software
-	   passthrough, we do it anyway -- it may indicate a memory
-	   range which is reserved in E820, so which didn't get set
-	   up to start with in si_domain */
-	if (domain == si_domain && hw_pass_through) {
-		dev_warn(dev, "Ignoring identity map for HW passthrough [0x%Lx - 0x%Lx]\n",
-			 start, end);
-		return 0;
-	}
-
-	dev_info(dev, "Setting identity map [0x%Lx - 0x%Lx]\n", start, end);
-
-	if (end < start) {
-		WARN(1, "Your BIOS is broken; RMRR ends before it starts!\n"
-			"BIOS vendor: %s; Ver: %s; Product Version: %s\n",
-			dmi_get_system_info(DMI_BIOS_VENDOR),
-			dmi_get_system_info(DMI_BIOS_VERSION),
-		     dmi_get_system_info(DMI_PRODUCT_VERSION));
-		return -EIO;
-	}
-
-	if (end >> agaw_to_width(domain->agaw)) {
-		WARN(1, "Your BIOS is broken; RMRR exceeds permitted address width (%d bits)\n"
-		     "BIOS vendor: %s; Ver: %s; Product Version: %s\n",
-		     agaw_to_width(domain->agaw),
-		     dmi_get_system_info(DMI_BIOS_VENDOR),
-		     dmi_get_system_info(DMI_BIOS_VERSION),
-		     dmi_get_system_info(DMI_PRODUCT_VERSION));
-		return -EIO;
-	}
-
-	return iommu_domain_identity_map(domain, start, end);
-}
-
-static int iommu_prepare_identity_map(struct device *dev,
-				      unsigned long long start,
-				      unsigned long long end)
-{
-	struct dmar_domain *domain;
-	int ret;
-
-	domain = get_domain_for_dev(dev, DEFAULT_DOMAIN_ADDRESS_WIDTH);
-	if (!domain)
-		return -ENOMEM;
-
-	ret = domain_prepare_identity_map(dev, domain, start, end);
-	if (ret)
-		domain_exit(domain);
-
-	return ret;
-}
-
-static inline int iommu_prepare_rmrr_dev(struct dmar_rmrr_unit *rmrr,
-					 struct device *dev)
-{
-	if (dev->archdata.iommu == DUMMY_DEVICE_DOMAIN_INFO)
-		return 0;
-	return iommu_prepare_identity_map(dev, rmrr->base_address,
-					  rmrr->end_address);
-}
-
 static inline struct iommu_resv_region *iommu_get_isa_resv_region(void)
 {
 	if (!isa_resv_region)
@@ -2812,29 +2577,6 @@ static inline struct iommu_resv_region *iommu_get_isa_resv_region(void)
 	return isa_resv_region;
 }
 
-#ifdef CONFIG_INTEL_IOMMU_FLOPPY_WA
-static inline void iommu_prepare_isa(struct pci_dev *pdev)
-{
-	int ret;
-	struct iommu_resv_region *reg = iommu_get_isa_resv_region();
-
-	if (!reg)
-		return;
-
-	pr_info("Prepare 0-16MiB unity mapping for LPC\n");
-	ret = iommu_prepare_identity_map(&pdev->dev, reg->start,
-					 reg->start + reg->length - 1);
-
-	if (ret)
-		pr_err("Failed to create 0-16MiB identity map - floppy might not work\n");
-}
-#else
-static inline void iommu_prepare_isa(struct pci_dev *pdev)
-{
-	return;
-}
-#endif /* !CONFIG_INTEL_IOMMU_FLPY_WA */
-
 static int md_domain_init(struct dmar_domain *domain, int guest_width);
 
 static int __init si_domain_init(int hw)
@@ -3033,18 +2775,10 @@ static int __init dev_prepare_static_identity_mapping(struct device *dev, int hw
 
 static int __init iommu_prepare_static_identity_mapping(int hw)
 {
-	struct pci_dev *pdev = NULL;
 	struct dmar_drhd_unit *drhd;
 	struct intel_iommu *iommu;
 	struct device *dev;
-	int i;
-	int ret = 0;
-
-	for_each_pci_dev(pdev) {
-		ret = dev_prepare_static_identity_mapping(&pdev->dev, hw);
-		if (ret)
-			return ret;
-	}
+	int i, ret = 0;
 
 	for_each_active_iommu(iommu, drhd)
 		for_each_active_dev_scope(drhd->devices, drhd->devices_cnt, i, dev) {
@@ -3291,12 +3025,9 @@ static int copy_translation_tables(struct intel_iommu *iommu)
 static int __init init_dmars(void)
 {
 	struct dmar_drhd_unit *drhd;
-	struct dmar_rmrr_unit *rmrr;
 	bool copied_tables = false;
-	struct device *dev;
-	struct pci_dev *pdev;
 	struct intel_iommu *iommu;
-	int i, ret;
+	int ret;
 
 	/*
 	 * for each drhd
@@ -3447,36 +3178,6 @@ static int __init init_dmars(void)
 			goto free_iommu;
 		}
 	}
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
-	pdev = pci_get_class(PCI_CLASS_BRIDGE_ISA << 8, NULL);
-	if (pdev) {
-		iommu_prepare_isa(pdev);
-		pci_dev_put(pdev);
-	}
 
 domains_done:
 
@@ -3565,53 +3266,6 @@ static unsigned long intel_alloc_iova(struct device *dev,
 	return iova_pfn;
 }
 
-struct dmar_domain *get_valid_domain_for_dev(struct device *dev)
-{
-	struct dmar_domain *domain, *tmp;
-	struct dmar_rmrr_unit *rmrr;
-	struct device *i_dev;
-	int i, ret;
-
-	domain = find_domain(dev);
-	if (domain)
-		goto out;
-
-	domain = find_or_alloc_domain(dev, DEFAULT_DOMAIN_ADDRESS_WIDTH);
-	if (!domain)
-		goto out;
-
-	/* We have a new domain - setup possible RMRRs for the device */
-	rcu_read_lock();
-	for_each_rmrr_units(rmrr) {
-		for_each_active_dev_scope(rmrr->devices, rmrr->devices_cnt,
-					  i, i_dev) {
-			if (i_dev != dev)
-				continue;
-
-			ret = domain_prepare_identity_map(dev, domain,
-							  rmrr->base_address,
-							  rmrr->end_address);
-			if (ret)
-				dev_err(dev, "Mapping reserved region failed\n");
-		}
-	}
-	rcu_read_unlock();
-
-	tmp = set_domain_for_dev(dev, domain);
-	if (!tmp || domain != tmp) {
-		domain_exit(domain);
-		domain = tmp;
-	}
-
-out:
-
-	if (!domain)
-		dev_err(dev, "Allocating domain failed\n");
-
-
-	return domain;
-}
-
 /* Check if the dev needs to go through non-identity map and unmap process.*/
 static int iommu_no_mapping(struct device *dev)
 {
@@ -3665,7 +3319,7 @@ static dma_addr_t __intel_map_single(struct device *dev, phys_addr_t paddr,
 	if (iommu_no_mapping(dev))
 		return paddr;
 
-	domain = get_valid_domain_for_dev(dev);
+	domain = find_domain(dev);
 	if (!domain)
 		return DMA_MAPPING_ERROR;
 
@@ -3887,7 +3541,7 @@ static int intel_map_sg(struct device *dev, struct scatterlist *sglist, int nele
 	if (iommu_no_mapping(dev))
 		return intel_nontranslate_map_sg(dev, sglist, nelems, dir);
 
-	domain = get_valid_domain_for_dev(dev);
+	domain = find_domain(dev);
 	if (!domain)
 		return 0;
 
@@ -5582,7 +5236,7 @@ int intel_iommu_enable_pasid(struct intel_iommu *iommu, struct device *dev)
 	u64 ctx_lo;
 	int ret;
 
-	domain = get_valid_domain_for_dev(dev);
+	domain = find_domain(dev);
 	if (!domain)
 		return -EINVAL;
 
-- 
2.17.1

