Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC7B0C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 18:32:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8ABE2064A
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 18:32:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ul2BJMj1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726625AbfCEScJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 13:32:09 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45461 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726256AbfCEScI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 13:32:08 -0500
Received: by mail-pf1-f194.google.com with SMTP id v21so6332643pfm.12
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2019 10:32:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=mstBJc36EyPM6BDdCYkuofsUscezUjPdy0hb3O6DS+U=;
        b=Ul2BJMj1VuwKBGaw6Z7weeEh6qsKoIrPLZw5fwj9i1Mtex507rD9R1iOVSbT7ZEyrn
         4GOx6pmVIBXhlCCVK0UYQxfbSStXJ2SuC+YDGSdtS+WSM43/lodAZHfcdH8jcLTKHWDV
         Pu0UEC0x6ekJgh42A651pXpCRUpMKQtK6h7ySa/Hm4Qe1eZOhmJ4VJxPxBY0wej0GknR
         cDIh5oM62l8CRiiEPtQ3lBaK0IIGASmv4xYjSzQUvKnA2wR124IbJM3P+jMVpNQ46YFt
         y93IGYX2kVLM8AFS1XDnE+nmeOgrUlWVSpGp+QJU5Kl69CSdChrwccEbimzLSNJRmpq1
         i2Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=mstBJc36EyPM6BDdCYkuofsUscezUjPdy0hb3O6DS+U=;
        b=XPZC08Uo+nocFZbjeoAuCzLuIF7ENdV8+1VhAHLjyEka2QYQ5AshG9IoB5eCr98Z6q
         NkDRnnhnHm96l0kxKOL+EfvvN2PJch2+CHLAN0QcTicf5QAW/8lVp9y+BW7lsn6LFvYa
         M5kdpr2kXX7VfKVKVPdCaN+3tWOkSeYXPMGnxVe3btGw6rVk15yZ3CNc5gE5K5784/Bm
         bQY2FNOB46kJdxqoRrpV0VFbIfEvXB+PnGxDbf0qVSyr55oAROGzdt4vN2D0xKX4p/YY
         3VZNnuRbjNdOueN+bailh+3zHjc77bCY7da3JRJUnKJAmRTg2Yi3cpxLpHXS0RW6x8U0
         8TqQ==
X-Gm-Message-State: APjAAAVnhxkBdJlM/GalJ+BJqwZlB5CsO7b0WlJQqr6BzVdRj8tFZvCe
        iYVtHIYPk4pvqyzmdtQZHouIp+0d
X-Google-Smtp-Source: APXvYqzob4NVI5du36hJrh9KVKkm/zIXczwoue5r114tPSPgzGovdpkFRYAsvtx+12Gf8A6jl4H26g==
X-Received: by 2002:a62:484:: with SMTP id 126mr3172679pfe.91.1551810727403;
        Tue, 05 Mar 2019 10:32:07 -0800 (PST)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id h63sm24392987pfd.148.2019.03.05.10.32.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Mar 2019 10:32:06 -0800 (PST)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     hch@lst.de, robin.murphy@arm.com
Cc:     vdumpa@nvidia.com, catalin.marinas@arm.com, will.deacon@arm.com,
        chris@zankel.net, jcmvbkbc@gmail.com, joro@8bytes.org,
        dwmw2@infradead.org, m.szyprowski@samsung.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, iommu@lists.linux-foundation.org,
        jonathanh@nvidia.com
Subject: [PATCH v2 RFC/RFT] dma-contiguous: Get normal pages for single-page allocations
Date:   Tue,  5 Mar 2019 10:32:02 -0800
Message-Id: <20190305183202.16216-1-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The addresses within a single page are always contiguous, so it's
not so necessary to always allocate one single page from CMA area.
Since the CMA area has a limited predefined size of space, it may
run out of space in heavy use cases, where there might be quite a
lot CMA pages being allocated for single pages.

However, there is also a concern that a device might care where a
page comes from -- it might expect the page from CMA area and act
differently if the page doesn't.

This patch tries to get normal pages for single-page allocations
unless the device has its own CMA area. This would save resources
from the CMA area for more CMA allocations. And it'd also reduce
CMA fragmentations resulted from trivial allocations.

Also, it updates the API and its callers so as to pass gfp flags.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
Changelog
v1->v2:
 * Removed one ';' in header file that caused build errors when
   CONFIG_DMA_CMA=N.

 arch/arm/mm/dma-mapping.c      |  5 ++---
 arch/arm64/mm/dma-mapping.c    |  2 +-
 arch/xtensa/kernel/pci-dma.c   |  2 +-
 drivers/iommu/amd_iommu.c      |  2 +-
 drivers/iommu/intel-iommu.c    |  3 +--
 include/linux/dma-contiguous.h |  4 ++--
 kernel/dma/contiguous.c        | 23 +++++++++++++++++++----
 7 files changed, 27 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 8a90f298af96..c39fc2d97712 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -588,7 +588,7 @@ static void *__alloc_from_contiguous(struct device *dev, size_t size,
 	struct page *page;
 	void *ptr = NULL;
 
-	page = dma_alloc_from_contiguous(dev, count, order, gfp & __GFP_NOWARN);
+	page = dma_alloc_from_contiguous(dev, count, order, gfp);
 	if (!page)
 		return NULL;
 
@@ -1293,8 +1293,7 @@ static struct page **__iommu_alloc_buffer(struct device *dev, size_t size,
 		unsigned long order = get_order(size);
 		struct page *page;
 
-		page = dma_alloc_from_contiguous(dev, count, order,
-						 gfp & __GFP_NOWARN);
+		page = dma_alloc_from_contiguous(dev, count, order, gfp);
 		if (!page)
 			goto error;
 
diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index 78c0a72f822c..660adedaab5d 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -159,7 +159,7 @@ static void *__iommu_alloc_attrs(struct device *dev, size_t size,
 		struct page *page;
 
 		page = dma_alloc_from_contiguous(dev, size >> PAGE_SHIFT,
-					get_order(size), gfp & __GFP_NOWARN);
+						 get_order(size), gfp);
 		if (!page)
 			return NULL;
 
diff --git a/arch/xtensa/kernel/pci-dma.c b/arch/xtensa/kernel/pci-dma.c
index 9171bff76fc4..e15b893caadb 100644
--- a/arch/xtensa/kernel/pci-dma.c
+++ b/arch/xtensa/kernel/pci-dma.c
@@ -157,7 +157,7 @@ void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
 
 	if (gfpflags_allow_blocking(flag))
 		page = dma_alloc_from_contiguous(dev, count, get_order(size),
-						 flag & __GFP_NOWARN);
+						 flag);
 
 	if (!page)
 		page = alloc_pages(flag | __GFP_ZERO, get_order(size));
diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 6b0760dafb3e..c54923a9e31f 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -2691,7 +2691,7 @@ static void *alloc_coherent(struct device *dev, size_t size,
 			return NULL;
 
 		page = dma_alloc_from_contiguous(dev, size >> PAGE_SHIFT,
-					get_order(size), flag & __GFP_NOWARN);
+						 get_order(size), flag);
 		if (!page)
 			return NULL;
 	}
diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 87274b54febd..6b5cf7313db6 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -3791,8 +3791,7 @@ static void *intel_alloc_coherent(struct device *dev, size_t size,
 	if (gfpflags_allow_blocking(flags)) {
 		unsigned int count = size >> PAGE_SHIFT;
 
-		page = dma_alloc_from_contiguous(dev, count, order,
-						 flags & __GFP_NOWARN);
+		page = dma_alloc_from_contiguous(dev, count, order, flags);
 		if (page && iommu_no_mapping(dev) &&
 		    page_to_phys(page) + size > dev->coherent_dma_mask) {
 			dma_release_from_contiguous(dev, page, count);
diff --git a/include/linux/dma-contiguous.h b/include/linux/dma-contiguous.h
index f247e8aa5e3d..10ea106b720f 100644
--- a/include/linux/dma-contiguous.h
+++ b/include/linux/dma-contiguous.h
@@ -112,7 +112,7 @@ static inline int dma_declare_contiguous(struct device *dev, phys_addr_t size,
 }
 
 struct page *dma_alloc_from_contiguous(struct device *dev, size_t count,
-				       unsigned int order, bool no_warn);
+				       unsigned int order, gfp_t gfp);
 bool dma_release_from_contiguous(struct device *dev, struct page *pages,
 				 int count);
 
@@ -145,7 +145,7 @@ int dma_declare_contiguous(struct device *dev, phys_addr_t size,
 
 static inline
 struct page *dma_alloc_from_contiguous(struct device *dev, size_t count,
-				       unsigned int order, bool no_warn)
+				       unsigned int order, gfp_t gfp)
 {
 	return NULL;
 }
diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index b2a87905846d..11b6d6ef4fc9 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -186,16 +186,31 @@ int __init dma_contiguous_reserve_area(phys_addr_t size, phys_addr_t base,
  *
  * This function allocates memory buffer for specified device. It uses
  * device specific contiguous memory area if available or the default
- * global one. Requires architecture specific dev_get_cma_area() helper
- * function.
+ * global one.
+ *
+ * However, it allocates normal pages for one-page size of allocations
+ * instead of getting from CMA areas. As the addresses within a single
+ * page are always contiguous, so there is no need to waste CMA pages
+ * for that kind; it also helps reduce fragmentations in the CMA area.
+ *
+ * Requires architecture specific dev_get_cma_area() helper function.
  */
 struct page *dma_alloc_from_contiguous(struct device *dev, size_t count,
-				       unsigned int align, bool no_warn)
+				       unsigned int align, gfp_t gfp)
 {
+	struct cma *cma;
+
 	if (align > CONFIG_CMA_ALIGNMENT)
 		align = CONFIG_CMA_ALIGNMENT;
 
-	return cma_alloc(dev_get_cma_area(dev), count, align, no_warn);
+	if (dev && dev->cma_area)
+		cma = dev->cma_area;
+	else if (count > 1)
+		cma = dma_contiguous_default_area;
+	else
+		return alloc_pages(gfp, align);
+
+	return cma_alloc(cma, count, align, gfp & __GFP_NOWARN);
 }
 
 /**
-- 
2.17.1

