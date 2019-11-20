Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CE17C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 00:36:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33A2F20708
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 00:36:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="niYX+GMV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727538AbfKTAgW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 19:36:22 -0500
Received: from mail-pg1-f202.google.com ([209.85.215.202]:32905 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727222AbfKTAgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 19:36:21 -0500
Received: by mail-pg1-f202.google.com with SMTP id i13so16812299pgp.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2019 16:36:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=KUVkRfh7rPJOVSuTpFQKwHuzlyhYVvnRikPgm5pXhqw=;
        b=niYX+GMVyU/KtAmCBNxS1XoWzvoWiePhjPracV6ubT+6tbu6Rg7fWVq2eMfVC04auL
         /C/GVGH2v+vluVRtrvgW2UIF+e7+dtvzSQN6pSBEwch0MoHZOGXhARQNhIH2XA+EbJn6
         AHVNOU/BEoAtGsi37O4gN97SlWgLbMeM8hBgqaMXqM94iJnX9Eiuslnx3nqwHE2BYZTH
         rgBNIkiqeIH24j7O5YefOc4fVSCkdvReisfVorW2KrKFWlUeaMo+k4ARIWBrszsdUGuS
         bZDBu5D42+qJNBOso8usYkBa02WgLrTK8V66qmSHM2MUv+CHBbVxQhhiOg6pxNN75Hbx
         5+Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=KUVkRfh7rPJOVSuTpFQKwHuzlyhYVvnRikPgm5pXhqw=;
        b=IF4EDzkTIO0eBbmmOQueo0YVQePwSvNZ1SVslC82A15Jfz47XCRAIpnN1vYtoDADfW
         aGd2YDPA0vuiPc9wrbe1Szx3tM+2uCZmqlZO81TWS7c+nVKzlSL4xKK4cjqlDDpdLc6J
         1PlJjSMIEi/v9AsZkwefR4YwiiNl/IhNNrhyU2K6o7naOa7HkIPVGdr++U9Yo9So+7rI
         Qo0rp12H4QZ0RvBkQslPWSxzWVmss/K++MstSiM4j2XTP9oepd02fj98IwYHTGQSR4nH
         o5o/IRmAFYHHRzrrdZpmaZ8i5NcgtdqxwQ34LMZP5uDb+eDIFbzqpc824LtZjH6ErxWO
         ALjA==
X-Gm-Message-State: APjAAAXUrE2N7AAWZo22WgVQv379P4+hrGXX8whuKnloXkan6YJg2Cp6
        1eTRiyERF6gd0+8OCtC8gqpYQRuptm6faA==
X-Google-Smtp-Source: APXvYqxdOfU+JQYjpbW7imRlHKoChcKRzF6aAOCr1lU0V7mnv0yIRDfiHKJLuZ+EiA6nf+odVJJ8a+iER43+Mw==
X-Received: by 2002:a63:fe06:: with SMTP id p6mr3169030pgh.245.1574210180576;
 Tue, 19 Nov 2019 16:36:20 -0800 (PST)
Date:   Tue, 19 Nov 2019 16:36:16 -0800
Message-Id: <20191120003616.181350-1-yonghyun@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
Subject: [PATCH] iommu/vt-d: Add side channel for huge page support to Intel IOMMU.
From:   Yonghyun Hwang <yonghyun@google.com>
To:     David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Havard Skinnemoen <hskinnemoen@google.com>,
        Deepa Dinamani <deepadinamani@google.com>,
        Moritz Fischer <moritzf@google.com>,
        Yonghyun Hwang <yonghyun@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PCIe Address Translation Service (ATS) allows a PCIe device to look up
VA->PA translations maintained by the IOMMU and cache them. The IOMMU up
until at least Skylake fractures all ATS responses into 4 KiB pages, even
if the underlying page is 2 MiB. For added performance, a side channel is
defined, which lets the device know if the page is actually a 2 MiB page
and uses that information instead of the ATS Response size information to
determine the actual page size to use. The side channel is mapped to an
unused high-order PA bit, 45-bit, that is transferred intact from the IOMMU
PTE to the device.

Signed-off-by: Yonghyun Hwang <yonghyun@google.com>
---
 drivers/iommu/intel-iommu.c | 83 ++++++++++++++++++++++++++++++++-----
 drivers/iommu/intel-pasid.c |  2 +-
 include/linux/intel-iommu.h | 37 ++++++++++++-----
 include/linux/iommu.h       |  1 +
 4 files changed, 102 insertions(+), 21 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index fe8097078669..f748985b8081 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -307,6 +307,9 @@ static int hw_pass_through = 1;
  */
 #define DOMAIN_FLAG_LOSE_CHILDREN		BIT(1)
 
+/* Domain used for huge-page side channel. */
+#define DOMAIN_FLAG_A45_HUGE_PAGE		(1 << 2)
+
 #define for_each_domain_iommu(idx, domain)			\
 	for (idx = 0; idx < g_num_of_iommus; idx++)		\
 		if (domain->iommu_refcnt[idx])
@@ -552,6 +555,20 @@ static inline int domain_type_is_si(struct dmar_domain *domain)
 	return domain->flags & DOMAIN_FLAG_STATIC_IDENTITY;
 }
 
+static inline void domain_type_set_a45_huge_page(struct dmar_domain *domain,
+					     bool huge_page)
+{
+	if (huge_page)
+		domain->flags |= DOMAIN_FLAG_A45_HUGE_PAGE;
+	else
+		domain->flags &= ~DOMAIN_FLAG_A45_HUGE_PAGE;
+}
+
+inline bool domain_type_get_a45_huge_page(struct dmar_domain *domain)
+{
+	return (domain->flags & DOMAIN_FLAG_A45_HUGE_PAGE) != 0;
+}
+
 static inline int domain_pfn_supported(struct dmar_domain *domain,
 				       unsigned long pfn)
 {
@@ -922,7 +939,7 @@ static struct dma_pte *pfn_to_dma_pte(struct dmar_domain *domain,
 		if (level == 1)
 			break;
 
-		parent = phys_to_virt(dma_pte_addr(pte));
+		parent = phys_to_virt(dma_pte_addr(pte, domain));
 		level--;
 	}
 
@@ -958,7 +975,7 @@ static struct dma_pte *dma_pfn_level_pte(struct dmar_domain *domain,
 			return pte;
 		}
 
-		parent = phys_to_virt(dma_pte_addr(pte));
+		parent = phys_to_virt(dma_pte_addr(pte, domain));
 		total--;
 	}
 	return NULL;
@@ -1012,7 +1029,7 @@ static void dma_pte_free_level(struct dmar_domain *domain, int level,
 			goto next;
 
 		level_pfn = pfn & level_mask(level);
-		level_pte = phys_to_virt(dma_pte_addr(pte));
+		level_pte = phys_to_virt(dma_pte_addr(pte, domain));
 
 		if (level > 2) {
 			dma_pte_free_level(domain, level - 1, retain_level,
@@ -1073,7 +1090,7 @@ static struct page *dma_pte_list_pagetables(struct dmar_domain *domain,
 {
 	struct page *pg;
 
-	pg = pfn_to_page(dma_pte_addr(pte) >> PAGE_SHIFT);
+	pg = pfn_to_page(dma_pte_addr(pte, domain) >> PAGE_SHIFT);
 	pg->freelist = freelist;
 	freelist = pg;
 
@@ -1125,7 +1142,8 @@ static struct page *dma_pte_clear_level(struct dmar_domain *domain, int level,
 		} else if (level > 1) {
 			/* Recurse down into a level that isn't *entirely* obsolete */
 			freelist = dma_pte_clear_level(domain, level - 1,
-						       phys_to_virt(dma_pte_addr(pte)),
+						phys_to_virt(
+						       dma_pte_addr(pte, domain)),
 						       level_pfn, start_pfn, last_pfn,
 						       freelist);
 		}
@@ -2063,7 +2081,7 @@ static int domain_context_mapping_one(struct dmar_domain *domain,
 			 */
 			for (agaw = domain->agaw; agaw > iommu->agaw; agaw--) {
 				ret = -ENOMEM;
-				pgd = phys_to_virt(dma_pte_addr(pgd));
+				pgd = phys_to_virt(dma_pte_addr(pgd, domain));
 				if (!dma_pte_present(pgd))
 					goto out_unlock;
 			}
@@ -2229,6 +2247,9 @@ static int __domain_mapping(struct dmar_domain *domain, unsigned long iov_pfn,
 	unsigned long sg_res = 0;
 	unsigned int largepage_lvl = 0;
 	unsigned long lvl_pages = 0;
+	uint64_t large_page = DMA_PTE_LARGE_PAGE |
+	    (domain_type_get_a45_huge_page(domain) ?
+	    DMA_PTE_A45_HUGE_PAGE : 0);
 
 	BUG_ON(!domain_pfn_supported(domain, iov_pfn + nr_pages - 1));
 
@@ -2265,7 +2286,7 @@ static int __domain_mapping(struct dmar_domain *domain, unsigned long iov_pfn,
 			if (largepage_lvl > 1) {
 				unsigned long nr_superpages, end_pfn;
 
-				pteval |= DMA_PTE_LARGE_PAGE;
+				pteval |= large_page;
 				lvl_pages = lvl_to_nr_pages(largepage_lvl);
 
 				nr_superpages = sg_res / lvl_pages;
@@ -2280,7 +2301,7 @@ static int __domain_mapping(struct dmar_domain *domain, unsigned long iov_pfn,
 				dma_pte_free_pagetable(domain, iov_pfn, end_pfn,
 						       largepage_lvl + 1);
 			} else {
-				pteval &= ~(uint64_t)DMA_PTE_LARGE_PAGE;
+				pteval &= ~large_page;
 			}
 
 		}
@@ -5377,7 +5398,7 @@ static int prepare_domain_attach_device(struct iommu_domain *domain,
 		pte = dmar_domain->pgd;
 		if (dma_pte_present(pte)) {
 			dmar_domain->pgd = (struct dma_pte *)
-				phys_to_virt(dma_pte_addr(pte));
+				phys_to_virt(dma_pte_addr(pte, dmar_domain));
 			free_pgtable_page(pte);
 		}
 		dmar_domain->agaw--;
@@ -5386,6 +5407,46 @@ static int prepare_domain_attach_device(struct iommu_domain *domain,
 	return 0;
 }
 
+static int intel_iommu_domain_set_attr(struct iommu_domain *domain,
+				       enum iommu_attr attr, void *data)
+{
+	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
+	int ret = 0;
+
+	switch (attr) {
+	case DOMAIN_ATTR_A45_HUGE_PAGE: {
+		bool *huge_page = data;
+
+		domain_type_set_a45_huge_page(dmar_domain, *huge_page);
+		break;
+	}
+	default:
+		return -EINVAL;
+	}
+
+	return ret;
+}
+
+static int intel_iommu_domain_get_attr(struct iommu_domain *domain,
+				       enum iommu_attr attr, void *data)
+{
+	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
+	int ret = 0;
+
+	switch (attr) {
+	case DOMAIN_ATTR_A45_HUGE_PAGE: {
+		bool *huge_page  = data;
+
+		*huge_page = domain_type_get_a45_huge_page(dmar_domain);
+		break;
+	}
+	default:
+		return -EINVAL;
+	}
+
+	return ret;
+}
+
 static int intel_iommu_attach_device(struct iommu_domain *domain,
 				     struct device *dev)
 {
@@ -5535,7 +5596,7 @@ static phys_addr_t intel_iommu_iova_to_phys(struct iommu_domain *domain,
 
 	pte = pfn_to_dma_pte(dmar_domain, iova >> VTD_PAGE_SHIFT, &level);
 	if (pte)
-		phys = dma_pte_addr(pte);
+		phys = dma_pte_addr(pte, dmar_domain);
 
 	return phys;
 }
@@ -5958,6 +6019,8 @@ const struct iommu_ops intel_iommu_ops = {
 	.capable		= intel_iommu_capable,
 	.domain_alloc		= intel_iommu_domain_alloc,
 	.domain_free		= intel_iommu_domain_free,
+	.domain_set_attr	= intel_iommu_domain_set_attr,
+	.domain_get_attr	= intel_iommu_domain_get_attr,
 	.attach_dev		= intel_iommu_attach_device,
 	.detach_dev		= intel_iommu_detach_device,
 	.aux_attach_dev		= intel_iommu_aux_attach_device,
diff --git a/drivers/iommu/intel-pasid.c b/drivers/iommu/intel-pasid.c
index 040a445be300..ca7bf35cb4a0 100644
--- a/drivers/iommu/intel-pasid.c
+++ b/drivers/iommu/intel-pasid.c
@@ -553,7 +553,7 @@ int intel_pasid_setup_second_level(struct intel_iommu *iommu,
 	 */
 	pgd = domain->pgd;
 	for (agaw = domain->agaw; agaw > iommu->agaw; agaw--) {
-		pgd = phys_to_virt(dma_pte_addr(pgd));
+		pgd = phys_to_virt(dma_pte_addr(pgd, domain));
 		if (!dma_pte_present(pgd)) {
 			dev_err(dev, "Invalid domain page table\n");
 			return -EINVAL;
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index ed11ef594378..4c18fdf8bca3 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -37,6 +37,17 @@
 #define DMA_PTE_READ (1)
 #define DMA_PTE_WRITE (2)
 #define DMA_PTE_LARGE_PAGE (1 << 7)
+/*
+ * PCIe Address Translation Service (ATS) allows a PCIe device to look up VA->PA
+ * translations maintained by the IOMMU and cache them. Unfortunately, up to at
+ * least Intel Skylake, the IOMMU fragments all ATS Translation Responses to 4
+ * KiB, even if the underlying page size is 2 MiB. In order to know if a page is
+ * mapped as 2 MiB, a side-channel is defined here by setting the
+ * DMA_PTE_A45_HUGE_PAGE bit in all huge-page PTEs. This bit can be received as
+ * part of the ATS translation response and interpreted only as 2 MiB page size
+ * indicator, but ignored otherwise.
+ */
+#define DMA_PTE_A45_HUGE_PAGE (1UL << 45)
 #define DMA_PTE_SNP (1 << 11)
 
 #define CONTEXT_TT_MULTI_LEVEL	0
@@ -604,16 +615,6 @@ static inline void dma_clear_pte(struct dma_pte *pte)
 	pte->val = 0;
 }
 
-static inline u64 dma_pte_addr(struct dma_pte *pte)
-{
-#ifdef CONFIG_64BIT
-	return pte->val & VTD_PAGE_MASK;
-#else
-	/* Must have a full atomic 64-bit read */
-	return  __cmpxchg64(&pte->val, 0ULL, 0ULL) & VTD_PAGE_MASK;
-#endif
-}
-
 static inline bool dma_pte_present(struct dma_pte *pte)
 {
 	return (pte->val & 3) != 0;
@@ -624,6 +625,22 @@ static inline bool dma_pte_superpage(struct dma_pte *pte)
 	return (pte->val & DMA_PTE_LARGE_PAGE);
 }
 
+bool domain_type_get_a45_huge_page(struct dmar_domain *domain);
+static inline u64 dma_pte_addr(struct dma_pte *pte, struct dmar_domain *domain)
+{
+#ifdef CONFIG_64BIT
+	u64 mask = VTD_PAGE_MASK;
+
+	if (dma_pte_superpage(pte) && domain_type_get_a45_huge_page(domain))
+		mask &= ~DMA_PTE_A45_HUGE_PAGE;
+
+	return pte->val & mask;
+#else
+	/* Must have a full atomic 64-bit read */
+	return  __cmpxchg64(&pte->val, 0ULL, 0ULL) & VTD_PAGE_MASK;
+#endif
+}
+
 static inline int first_pte_in_page(struct dma_pte *pte)
 {
 	return !((unsigned long)pte & ~VTD_PAGE_MASK);
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index e28e80dea141..e4231f1759a0 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -126,6 +126,7 @@ enum iommu_attr {
 	DOMAIN_ATTR_FSL_PAMUV1,
 	DOMAIN_ATTR_NESTING,	/* two stages of translation */
 	DOMAIN_ATTR_DMA_USE_FLUSH_QUEUE,
+	DOMAIN_ATTR_A45_HUGE_PAGE,  /* huge-page side channel */
 	DOMAIN_ATTR_MAX,
 };
 
-- 
2.24.0.432.g9d3f5f5b63-goog

