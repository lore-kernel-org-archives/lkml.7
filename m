Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97FD9C31E44
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 00:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AEBF208C4
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 00:36:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408121AbfFLAgX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 20:36:23 -0400
Received: from mga09.intel.com ([134.134.136.24]:50299 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408026AbfFLAgV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 20:36:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jun 2019 17:36:21 -0700
X-ExtLoop1: 1
Received: from allen-box.sh.intel.com ([10.239.159.136])
  by orsmga001.jf.intel.com with ESMTP; 11 Jun 2019 17:36:19 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>
Cc:     ashok.raj@intel.com, jacob.jun.pan@intel.com, kevin.tian@intel.com,
        sai.praneeth.prakhya@intel.com, cai@lca.pw,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 7/7] iommu/vt-d: Consolidate domain_init() to avoid duplication
Date:   Wed, 12 Jun 2019 08:28:51 +0800
Message-Id: <20190612002851.17103-8-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190612002851.17103-1-baolu.lu@linux.intel.com>
References: <20190612002851.17103-1-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The domain_init() and md_domain_init() do almost the same job.
Consolidate them to avoid duplication.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel-iommu.c | 123 +++++++++++-------------------------
 1 file changed, 36 insertions(+), 87 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 5215dcd535a1..b8c6cf1d5f90 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -1825,63 +1825,6 @@ static inline int guestwidth_to_adjustwidth(int gaw)
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
@@ -2563,6 +2506,31 @@ static int get_last_alias(struct pci_dev *pdev, u16 alias, void *opaque)
 	return 0;
 }
 
+static int domain_init(struct dmar_domain *domain, int guest_width)
+{
+	int adjust_width;
+
+	init_iova_domain(&domain->iovad, VTD_PAGE_SIZE, IOVA_START_PFN);
+	domain_reserve_special_ranges(domain);
+
+	/* calculate AGAW */
+	domain->gaw = guest_width;
+	adjust_width = guestwidth_to_adjustwidth(guest_width);
+	domain->agaw = width_to_agaw(adjust_width);
+
+	domain->iommu_coherency = 0;
+	domain->iommu_snooping = 0;
+	domain->iommu_superpage = 0;
+	domain->max_addr = 0;
+
+	/* always allocate the top pgd */
+	domain->pgd = (struct dma_pte *)alloc_pgtable_page(domain->nid);
+	if (!domain->pgd)
+		return -ENOMEM;
+	domain_flush_cache(domain, domain->pgd, PAGE_SIZE);
+	return 0;
+}
+
 static struct dmar_domain *find_or_alloc_domain(struct device *dev, int gaw)
 {
 	struct device_domain_info *info;
@@ -2600,11 +2568,19 @@ static struct dmar_domain *find_or_alloc_domain(struct device *dev, int gaw)
 	domain = alloc_domain(0);
 	if (!domain)
 		return NULL;
-	if (domain_init(domain, iommu, gaw)) {
+
+	if (domain_init(domain, gaw)) {
 		domain_exit(domain);
 		return NULL;
 	}
 
+	if (init_iova_flush_queue(&domain->iovad,
+				  iommu_flush_iova,
+				  iova_entry_free)) {
+		pr_warn("iova flush queue initialization failed\n");
+		intel_iommu_strict = 1;
+	}
+
 out:
 	return domain;
 }
@@ -2709,8 +2685,6 @@ static int domain_prepare_identity_map(struct device *dev,
 	return iommu_domain_identity_map(domain, start, end);
 }
 
-static int md_domain_init(struct dmar_domain *domain, int guest_width);
-
 static int __init si_domain_init(int hw)
 {
 	struct dmar_rmrr_unit *rmrr;
@@ -2721,7 +2695,7 @@ static int __init si_domain_init(int hw)
 	if (!si_domain)
 		return -EFAULT;
 
-	if (md_domain_init(si_domain, DEFAULT_DOMAIN_ADDRESS_WIDTH)) {
+	if (domain_init(si_domain, DEFAULT_DOMAIN_ADDRESS_WIDTH)) {
 		domain_exit(si_domain);
 		return -EFAULT;
 	}
@@ -4837,31 +4811,6 @@ static void dmar_remove_one_dev_info(struct device *dev)
 	spin_unlock_irqrestore(&device_domain_lock, flags);
 }
 
-static int md_domain_init(struct dmar_domain *domain, int guest_width)
-{
-	int adjust_width;
-
-	init_iova_domain(&domain->iovad, VTD_PAGE_SIZE, IOVA_START_PFN);
-	domain_reserve_special_ranges(domain);
-
-	/* calculate AGAW */
-	domain->gaw = guest_width;
-	adjust_width = guestwidth_to_adjustwidth(guest_width);
-	domain->agaw = width_to_agaw(adjust_width);
-
-	domain->iommu_coherency = 0;
-	domain->iommu_snooping = 0;
-	domain->iommu_superpage = 0;
-	domain->max_addr = 0;
-
-	/* always allocate the top pgd */
-	domain->pgd = (struct dma_pte *)alloc_pgtable_page(domain->nid);
-	if (!domain->pgd)
-		return -ENOMEM;
-	domain_flush_cache(domain, domain->pgd, PAGE_SIZE);
-	return 0;
-}
-
 static struct iommu_domain *intel_iommu_domain_alloc(unsigned type)
 {
 	struct dmar_domain *dmar_domain;
@@ -4876,7 +4825,7 @@ static struct iommu_domain *intel_iommu_domain_alloc(unsigned type)
 			pr_err("Can't allocate dmar_domain\n");
 			return NULL;
 		}
-		if (md_domain_init(dmar_domain, DEFAULT_DOMAIN_ADDRESS_WIDTH)) {
+		if (domain_init(dmar_domain, DEFAULT_DOMAIN_ADDRESS_WIDTH)) {
 			pr_err("Domain initialization failed\n");
 			domain_exit(dmar_domain);
 			return NULL;
-- 
2.17.1

