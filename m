Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56169C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 18:49:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F95A20663
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 18:49:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="e1cnSn2P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbfDKSt1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 14:49:27 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35677 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726983AbfDKStY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 14:49:24 -0400
Received: by mail-ed1-f66.google.com with SMTP id s39so6161007edb.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 11:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+wIWsBlpHNvqt41NAQAGAJ7H8cITKPcnmYAF2btwAb0=;
        b=e1cnSn2PK0vQqM4MAMrrXLaTpi+hjQMUA4RONp5/QufCiGQabRY3c40vjmfM6/tVvu
         dHm2QgZxsJQxyaRWei+pLoeWXOIeJGMqxUsAwfq5xicNbDht5hsH9B9U3PksM/0Z1XVx
         7s29y5FnFW4RWp/4CUJywws1z5EA5sMdlVoxCo4ZXNuPJ+tPQk+TA/k5mdqED7+a6wOY
         ojT9K4KRqkO48HqTHgwak30pwg5Ii15hz3/L1EDeCE9YwFGUkkD/OfSFwHUQ6zuwiQy2
         4V/6bFAxvGfBhu6p6kUL2Oheb1GFC38Y0NuBIgjcvwkq28NKMZtTWCL3BpGsOTRkDHE0
         NSdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+wIWsBlpHNvqt41NAQAGAJ7H8cITKPcnmYAF2btwAb0=;
        b=IczlcT+iqJwlzx3VMPcIvp/isuF5SxK5JU76+1SwsF4GZV6gVodKWQAhKOZJrHZf5l
         m+IlhgVst/n8YSujgAUbm6zXI0hzKi2tMu36XZaPY9u9ku970wxvjjEXMo7khcPgjRHN
         DlARg9ec1B7eqxiRdazqWBLd/BRre69Rxar5PZwUC4WLtZNGBpRuyye6KMJ0Y1UO1j/Y
         4iXHQuhKVIpWv0WPzDj6FY1l9z0yrYHVZy6t6PYBjmHhdGN6Lg6Fi+//SnZE+UudIn+u
         M4kNnj6zLjFOJk73Tg8waUkSMGfo96jO3eTDOW9CBakCuFvOaUg9fuQPyL5BTd09jktY
         MPyw==
X-Gm-Message-State: APjAAAUeE7gnWK93juqhEA3863RQVb+FzQQU8QFOKAkWM2+PqlAXX95I
        aTQGVltpEUFgt1CujV17clJy4g==
X-Google-Smtp-Source: APXvYqzgvOx+i4FlVrymlvrfw2T19AcnP3BMR2H3Nrx4Vhr9zqZaB5+5yb9dg9dURDNKxHOHDD/v1A==
X-Received: by 2002:a17:906:4c92:: with SMTP id q18mr28345302eju.16.1555008562323;
        Thu, 11 Apr 2019 11:49:22 -0700 (PDT)
Received: from localhost.localdomain ([80.233.32.123])
        by smtp.gmail.com with ESMTPSA id b10sm1285130edi.28.2019.04.11.11.49.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 11:49:21 -0700 (PDT)
From:   Tom Murphy <tmurphy@arista.com>
To:     iommu@lists.linux-foundation.org
Cc:     dima@arista.com, jamessewart@arista.com, murphyt7@tcd.ie,
        Tom Murphy <tmurphy@arista.com>,
        Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will.deacon@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Clark <robdclark@gmail.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH 8/9] iommu/amd: Clean up unused functions
Date:   Thu, 11 Apr 2019 19:47:37 +0100
Message-Id: <20190411184741.27540-9-tmurphy@arista.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190411184741.27540-1-tmurphy@arista.com>
References: <20190411184741.27540-1-tmurphy@arista.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we are using the dma-iommu api we have a lot of unused code.
This patch removes all that unused code.

Signed-off-by: Tom Murphy <tmurphy@arista.com>
---
 drivers/iommu/amd_iommu.c | 209 --------------------------------------
 1 file changed, 209 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 218faf3a6d9c..02b351834a3b 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -116,18 +116,6 @@ struct kmem_cache *amd_iommu_irq_cache;
 static void update_domain(struct protection_domain *domain);
 static int protection_domain_init(struct protection_domain *domain);
 static void detach_device(struct device *dev);
-static void iova_domain_flush_tlb(struct iova_domain *iovad);
-
-/*
- * Data container for a dma_ops specific protection domain
- */
-struct dma_ops_domain {
-	/* generic protection domain information */
-	struct protection_domain domain;
-
-	/* IOVA RB-Tree */
-	struct iova_domain iovad;
-};
 
 static struct iova_domain reserved_iova_ranges;
 static struct lock_class_key reserved_rbtree_key;
@@ -201,12 +189,6 @@ static struct protection_domain *to_pdomain(struct iommu_domain *dom)
 	return container_of(dom, struct protection_domain, domain);
 }
 
-static struct dma_ops_domain* to_dma_ops_domain(struct protection_domain *domain)
-{
-	BUG_ON(domain->flags != PD_DMA_OPS_MASK);
-	return container_of(domain, struct dma_ops_domain, domain);
-}
-
 static struct iommu_dev_data *alloc_dev_data(u16 devid)
 {
 	struct iommu_dev_data *dev_data;
@@ -1280,12 +1262,6 @@ static void domain_flush_pages(struct protection_domain *domain,
 	__domain_flush_pages(domain, address, size, 0);
 }
 
-/* Flush the whole IO/TLB for a given protection domain */
-static void domain_flush_tlb(struct protection_domain *domain)
-{
-	__domain_flush_pages(domain, 0, CMD_INV_IOMMU_ALL_PAGES_ADDRESS, 0);
-}
-
 /* Flush the whole IO/TLB for a given protection domain - including PDE */
 static void domain_flush_tlb_pde(struct protection_domain *domain)
 {
@@ -1689,43 +1665,6 @@ static unsigned long iommu_unmap_page(struct protection_domain *dom,
 	return unmapped;
 }
 
-/****************************************************************************
- *
- * The next functions belong to the address allocator for the dma_ops
- * interface functions.
- *
- ****************************************************************************/
-
-
-static unsigned long dma_ops_alloc_iova(struct device *dev,
-					struct dma_ops_domain *dma_dom,
-					unsigned int pages, u64 dma_mask)
-{
-	unsigned long pfn = 0;
-
-	pages = __roundup_pow_of_two(pages);
-
-	if (dma_mask > DMA_BIT_MASK(32))
-		pfn = alloc_iova_fast(&dma_dom->iovad, pages,
-				      IOVA_PFN(DMA_BIT_MASK(32)), false);
-
-	if (!pfn)
-		pfn = alloc_iova_fast(&dma_dom->iovad, pages,
-				      IOVA_PFN(dma_mask), true);
-
-	return (pfn << PAGE_SHIFT);
-}
-
-static void dma_ops_free_iova(struct dma_ops_domain *dma_dom,
-			      unsigned long address,
-			      unsigned int pages)
-{
-	pages = __roundup_pow_of_two(pages);
-	address >>= PAGE_SHIFT;
-
-	free_iova_fast(&dma_dom->iovad, address, pages);
-}
-
 /****************************************************************************
  *
  * The next functions belong to the domain allocation. A domain is
@@ -1827,21 +1766,6 @@ static void free_gcr3_table(struct protection_domain *domain)
 	free_page((unsigned long)domain->gcr3_tbl);
 }
 
-static void dma_ops_domain_flush_tlb(struct dma_ops_domain *dom)
-{
-	domain_flush_tlb(&dom->domain);
-	domain_flush_complete(&dom->domain);
-}
-
-static void iova_domain_flush_tlb(struct iova_domain *iovad)
-{
-	struct dma_ops_domain *dom;
-
-	dom = container_of(iovad, struct dma_ops_domain, iovad);
-
-	dma_ops_domain_flush_tlb(dom);
-}
-
 /*
  * Free a domain, only used if something went wrong in the
  * allocation path and we need to free an already allocated page table
@@ -2437,100 +2361,6 @@ static int dir2prot(enum dma_data_direction direction)
 		return 0;
 }
 
-/*
- * This function contains common code for mapping of a physically
- * contiguous memory region into DMA address space. It is used by all
- * mapping functions provided with this IOMMU driver.
- * Must be called with the domain lock held.
- */
-static dma_addr_t __map_single(struct device *dev,
-			       struct dma_ops_domain *dma_dom,
-			       phys_addr_t paddr,
-			       size_t size,
-			       enum dma_data_direction direction,
-			       u64 dma_mask)
-{
-	dma_addr_t offset = paddr & ~PAGE_MASK;
-	dma_addr_t address, start, ret;
-	unsigned int pages;
-	int prot = 0;
-	int i;
-
-	pages = iommu_num_pages(paddr, size, PAGE_SIZE);
-	paddr &= PAGE_MASK;
-
-	address = dma_ops_alloc_iova(dev, dma_dom, pages, dma_mask);
-	if (!address)
-		goto out;
-
-	prot = dir2prot(direction);
-
-	start = address;
-	for (i = 0; i < pages; ++i) {
-		ret = iommu_map_page(&dma_dom->domain, start, paddr,
-				     PAGE_SIZE, prot, GFP_ATOMIC);
-		if (ret)
-			goto out_unmap;
-
-		paddr += PAGE_SIZE;
-		start += PAGE_SIZE;
-	}
-	address += offset;
-
-	if (unlikely(amd_iommu_np_cache)) {
-		domain_flush_pages(&dma_dom->domain, address, size);
-		domain_flush_complete(&dma_dom->domain);
-	}
-
-out:
-	return address;
-
-out_unmap:
-
-	for (--i; i >= 0; --i) {
-		start -= PAGE_SIZE;
-		iommu_unmap_page(&dma_dom->domain, start, PAGE_SIZE);
-	}
-
-	domain_flush_tlb(&dma_dom->domain);
-	domain_flush_complete(&dma_dom->domain);
-
-	dma_ops_free_iova(dma_dom, address, pages);
-
-	return DMA_MAPPING_ERROR;
-}
-
-/*
- * Does the reverse of the __map_single function. Must be called with
- * the domain lock held too
- */
-static void __unmap_single(struct dma_ops_domain *dma_dom,
-			   dma_addr_t dma_addr,
-			   size_t size,
-			   int dir)
-{
-	dma_addr_t i, start;
-	unsigned int pages;
-
-	pages = iommu_num_pages(dma_addr, size, PAGE_SIZE);
-	dma_addr &= PAGE_MASK;
-	start = dma_addr;
-
-	for (i = 0; i < pages; ++i) {
-		iommu_unmap_page(&dma_dom->domain, start, PAGE_SIZE);
-		start += PAGE_SIZE;
-	}
-
-	if (amd_iommu_unmap_flush) {
-		domain_flush_tlb(&dma_dom->domain);
-		domain_flush_complete(&dma_dom->domain);
-		dma_ops_free_iova(dma_dom, dma_addr, pages);
-	} else {
-		pages = __roundup_pow_of_two(pages);
-		queue_iova(&dma_dom->iovad, dma_addr >> PAGE_SHIFT, pages, 0);
-	}
-}
-
 /*
  * The exported map_single function for dma_ops.
  */
@@ -2563,32 +2393,6 @@ static void unmap_page(struct device *dev, dma_addr_t dma_addr, size_t size,
 	iommu_dma_unmap_page(dev, dma_addr, size, dir, attrs);
 }
 
-static int sg_num_pages(struct device *dev,
-			struct scatterlist *sglist,
-			int nelems)
-{
-	unsigned long mask, boundary_size;
-	struct scatterlist *s;
-	int i, npages = 0;
-
-	mask          = dma_get_seg_boundary(dev);
-	boundary_size = mask + 1 ? ALIGN(mask + 1, PAGE_SIZE) >> PAGE_SHIFT :
-				   1UL << (BITS_PER_LONG - PAGE_SHIFT);
-
-	for_each_sg(sglist, s, nelems, i) {
-		int p, n;
-
-		s->dma_address = npages << PAGE_SHIFT;
-		p = npages % boundary_size;
-		n = iommu_num_pages(sg_phys(s), s->length, PAGE_SIZE);
-		if (p + n > boundary_size)
-			npages += boundary_size - p;
-		npages += n;
-	}
-
-	return npages;
-}
-
 /*
  * The exported map_sg function for dma_ops (handles scatter-gather
  * lists).
@@ -3166,19 +2970,6 @@ static void amd_iommu_put_resv_regions(struct device *dev,
 		kfree(entry);
 }
 
-static void amd_iommu_apply_resv_region(struct device *dev,
-				      struct iommu_domain *domain,
-				      struct iommu_resv_region *region)
-{
-	struct dma_ops_domain *dma_dom = to_dma_ops_domain(to_pdomain(domain));
-	unsigned long start, end;
-
-	start = IOVA_PFN(region->start);
-	end   = IOVA_PFN(region->start + region->length - 1);
-
-	WARN_ON_ONCE(reserve_iova(&dma_dom->iovad, start, end) == NULL);
-}
-
 static bool amd_iommu_is_attach_deferred(struct iommu_domain *domain,
 					 struct device *dev)
 {
-- 
2.17.1

