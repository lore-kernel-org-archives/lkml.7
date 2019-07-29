Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 251C1C76193
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 14:29:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3CAF217D9
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 14:29:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZBx3zr3C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728494AbfG2O3U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 10:29:20 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46956 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbfG2O3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 10:29:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=LWms1tzdUBSIpVLSl2mZ1UudV6rJZIzfLpKlWyzdeIg=; b=ZBx3zr3C8ZbL0ZZco849pWWOjo
        eqE6HR29il18amM1+MRcsK7O9dUQzttNiJFk35Pwg4KplCTrezQhPnABVSHt8xpqUDsC3M+5D/mga
        BzUHIBTbT6aEbX2bMehCKE03hP2fHEtv5TdomEBY3QxGzafgXnYMSloGvZIv0CH/Qt5Om+QJbNTVg
        Tg176OEZHdJ6ZTJAEBcU8ZexiXQKJ8MdZb7Mpn8oi/T/KCh4Z53pxvBmkQE5PQyj/ChxZvF9ekXRf
        t324BKXjFOVA6A1HJYk/IkVmIkymfShrpglwVhxKATFEqvBYgFvGZ5aCxN/3okNLwH36wqChrVK13
        DxOvWc/w==;
Received: from [195.167.85.94] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hs6eF-0006MP-Nu; Mon, 29 Jul 2019 14:29:12 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>
Cc:     Ralph Campbell <rcampbell@nvidia.com>,
        Bharata B Rao <bharata@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/9] nouveau: simplify nouveau_dmem_migrate_vma
Date:   Mon, 29 Jul 2019 17:28:40 +0300
Message-Id: <20190729142843.22320-7-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190729142843.22320-1-hch@lst.de>
References: <20190729142843.22320-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Factor the main copy page to vram routine out into a helper that acts
on a single page and which doesn't require the nouveau_dmem_migrate
structure for argument passing.  As an added benefit the new version
only allocates the dma address array once and reuses it for each
subsequent chunk of work.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/gpu/drm/nouveau/nouveau_dmem.c | 185 ++++++++-----------------
 1 file changed, 56 insertions(+), 129 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_dmem.c b/drivers/gpu/drm/nouveau/nouveau_dmem.c
index 036e6c07d489..6cb930755970 100644
--- a/drivers/gpu/drm/nouveau/nouveau_dmem.c
+++ b/drivers/gpu/drm/nouveau/nouveau_dmem.c
@@ -44,8 +44,6 @@
 #define DMEM_CHUNK_SIZE (2UL << 20)
 #define DMEM_CHUNK_NPAGES (DMEM_CHUNK_SIZE >> PAGE_SHIFT)
 
-struct nouveau_migrate;
-
 enum nouveau_aper {
 	NOUVEAU_APER_VIRT,
 	NOUVEAU_APER_VRAM,
@@ -86,15 +84,6 @@ static inline struct nouveau_dmem *page_to_dmem(struct page *page)
 	return container_of(page->pgmap, struct nouveau_dmem, pagemap);
 }
 
-struct nouveau_migrate {
-	struct vm_area_struct *vma;
-	struct nouveau_drm *drm;
-	struct nouveau_fence *fence;
-	unsigned long npages;
-	dma_addr_t *dma;
-	unsigned long dma_nr;
-};
-
 static unsigned long nouveau_dmem_page_addr(struct page *page)
 {
 	struct nouveau_dmem_chunk *chunk = page->zone_device_data;
@@ -569,131 +558,67 @@ nouveau_dmem_init(struct nouveau_drm *drm)
 	drm->dmem = NULL;
 }
 
-static void
-nouveau_dmem_migrate_alloc_and_copy(struct vm_area_struct *vma,
-				    const unsigned long *src_pfns,
-				    unsigned long *dst_pfns,
-				    unsigned long start,
-				    unsigned long end,
-				    struct nouveau_migrate *migrate)
+static unsigned long nouveau_dmem_migrate_copy_one(struct nouveau_drm *drm,
+		struct vm_area_struct *vma, unsigned long addr,
+		unsigned long src, dma_addr_t *dma_addr)
 {
-	struct nouveau_drm *drm = migrate->drm;
 	struct device *dev = drm->dev->dev;
-	unsigned long addr, i, npages = 0;
-	nouveau_migrate_copy_t copy;
-	int ret;
-
-	/* First allocate new memory */
-	for (addr = start, i = 0; addr < end; addr += PAGE_SIZE, i++) {
-		struct page *dpage, *spage;
-
-		dst_pfns[i] = 0;
-		spage = migrate_pfn_to_page(src_pfns[i]);
-		if (!spage || !(src_pfns[i] & MIGRATE_PFN_MIGRATE))
-			continue;
-
-		dpage = nouveau_dmem_page_alloc_locked(drm);
-		if (!dpage)
-			continue;
-
-		dst_pfns[i] = migrate_pfn(page_to_pfn(dpage)) |
-			      MIGRATE_PFN_LOCKED |
-			      MIGRATE_PFN_DEVICE;
-		npages++;
-	}
-
-	if (!npages)
-		return;
-
-	/* Allocate storage for DMA addresses, so we can unmap later. */
-	migrate->dma = kmalloc(sizeof(*migrate->dma) * npages, GFP_KERNEL);
-	if (!migrate->dma)
-		goto error;
-	migrate->dma_nr = 0;
-
-	/* Copy things over */
-	copy = drm->dmem->migrate.copy_func;
-	for (addr = start, i = 0; addr < end; addr += PAGE_SIZE, i++) {
-		struct page *spage, *dpage;
-
-		dpage = migrate_pfn_to_page(dst_pfns[i]);
-		if (!dpage || dst_pfns[i] == MIGRATE_PFN_ERROR)
-			continue;
-
-		spage = migrate_pfn_to_page(src_pfns[i]);
-		if (!spage || !(src_pfns[i] & MIGRATE_PFN_MIGRATE)) {
-			nouveau_dmem_page_free_locked(drm, dpage);
-			dst_pfns[i] = 0;
-			continue;
-		}
-
-		migrate->dma[migrate->dma_nr] =
-			dma_map_page_attrs(dev, spage, 0, PAGE_SIZE,
-					   PCI_DMA_BIDIRECTIONAL,
-					   DMA_ATTR_SKIP_CPU_SYNC);
-		if (dma_mapping_error(dev, migrate->dma[migrate->dma_nr])) {
-			nouveau_dmem_page_free_locked(drm, dpage);
-			dst_pfns[i] = 0;
-			continue;
-		}
-
-		ret = copy(drm, 1, NOUVEAU_APER_VRAM,
-				nouveau_dmem_page_addr(dpage),
-				NOUVEAU_APER_HOST,
-				migrate->dma[migrate->dma_nr++]);
-		if (ret) {
-			nouveau_dmem_page_free_locked(drm, dpage);
-			dst_pfns[i] = 0;
-			continue;
-		}
-	}
+	struct page *dpage, *spage;
 
-	nouveau_fence_new(drm->dmem->migrate.chan, false, &migrate->fence);
+	spage = migrate_pfn_to_page(src);
+	if (!spage || !(src & MIGRATE_PFN_MIGRATE))
+		goto out;
 
-	return;
+	dpage = nouveau_dmem_page_alloc_locked(drm);
+	if (!dpage)
+		return 0;
 
-error:
-	for (addr = start, i = 0; addr < end; addr += PAGE_SIZE, ++i) {
-		struct page *page;
+	*dma_addr = dma_map_page(dev, spage, 0, PAGE_SIZE, DMA_BIDIRECTIONAL);
+	if (dma_mapping_error(dev, *dma_addr))
+		goto out_free_page;
 
-		if (!dst_pfns[i] || dst_pfns[i] == MIGRATE_PFN_ERROR)
-			continue;
+	if (drm->dmem->migrate.copy_func(drm, 1, NOUVEAU_APER_VRAM,
+			nouveau_dmem_page_addr(dpage), NOUVEAU_APER_HOST,
+			*dma_addr))
+		goto out_dma_unmap;
 
-		page = migrate_pfn_to_page(dst_pfns[i]);
-		dst_pfns[i] = MIGRATE_PFN_ERROR;
-		if (page == NULL)
-			continue;
+	return migrate_pfn(page_to_pfn(dpage)) |
+		MIGRATE_PFN_LOCKED | MIGRATE_PFN_DEVICE;
 
-		__free_page(page);
-	}
+out_dma_unmap:
+	dma_unmap_page(dev, *dma_addr, PAGE_SIZE, DMA_BIDIRECTIONAL);
+out_free_page:
+	nouveau_dmem_page_free_locked(drm, dpage);
+out:
+	return 0;
 }
 
-static void
-nouveau_dmem_migrate_finalize_and_map(struct nouveau_migrate *migrate)
+static void nouveau_dmem_migrate_chunk(struct migrate_vma *args,
+		struct nouveau_drm *drm, dma_addr_t *dma_addrs)
 {
-	struct nouveau_drm *drm = migrate->drm;
+	struct nouveau_fence *fence;
+	unsigned long addr = args->start, nr_dma = 0, i;
+
+	for (i = 0; addr < args->end; i++) {
+		args->dst[i] = nouveau_dmem_migrate_copy_one(drm, args->vma,
+				addr, args->src[i], &dma_addrs[nr_dma]);
+		if (args->dst[i])
+			nr_dma++;
+		addr += PAGE_SIZE;
+	}
 
-	nouveau_dmem_fence_done(&migrate->fence);
+	nouveau_fence_new(drm->dmem->migrate.chan, false, &fence);
+	migrate_vma_pages(args);
+	nouveau_dmem_fence_done(&fence);
 
-	while (migrate->dma_nr--) {
-		dma_unmap_page(drm->dev->dev, migrate->dma[migrate->dma_nr],
-			       PAGE_SIZE, PCI_DMA_BIDIRECTIONAL);
+	while (nr_dma--) {
+		dma_unmap_page(drm->dev->dev, dma_addrs[nr_dma], PAGE_SIZE,
+				DMA_BIDIRECTIONAL);
 	}
-	kfree(migrate->dma);
-
 	/*
-	 * FIXME optimization: update GPU page table to point to newly
-	 * migrated memory.
+	 * FIXME optimization: update GPU page table to point to newly migrated
+	 * memory.
 	 */
-}
-
-static void nouveau_dmem_migrate_chunk(struct migrate_vma *args,
-		struct nouveau_migrate *migrate)
-{
-	nouveau_dmem_migrate_alloc_and_copy(args->vma, args->src, args->dst,
-			args->start, args->end, migrate);
-	migrate_vma_pages(args);
-	nouveau_dmem_migrate_finalize_and_map(migrate);
 	migrate_vma_finalize(args);
 }
 
@@ -705,38 +630,40 @@ nouveau_dmem_migrate_vma(struct nouveau_drm *drm,
 {
 	unsigned long npages = (end - start) >> PAGE_SHIFT;
 	unsigned long max = min(SG_MAX_SINGLE_ALLOC, npages);
+	dma_addr_t *dma_addrs;
 	struct migrate_vma args = {
 		.vma		= vma,
 		.start		= start,
 	};
-	struct nouveau_migrate migrate = {
-		.drm		= drm,
-		.vma		= vma,
-		.npages		= npages,
-	};
 	unsigned long c, i;
 	int ret = -ENOMEM;
 
-	args.src = kzalloc(sizeof(long) * max, GFP_KERNEL);
+	args.src = kcalloc(max, sizeof(args.src), GFP_KERNEL);
 	if (!args.src)
 		goto out;
-	args.dst = kzalloc(sizeof(long) * max, GFP_KERNEL);
+	args.dst = kcalloc(max, sizeof(args.dst), GFP_KERNEL);
 	if (!args.dst)
 		goto out_free_src;
 
+	dma_addrs = kmalloc_array(max, sizeof(*dma_addrs), GFP_KERNEL);
+	if (!dma_addrs)
+		goto out_free_dst;
+
 	for (i = 0; i < npages; i += c) {
 		c = min(SG_MAX_SINGLE_ALLOC, npages);
 		args.end = start + (c << PAGE_SHIFT);
 		ret = migrate_vma_setup(&args);
 		if (ret)
-			goto out_free_dst;
+			goto out_free_dma;
 
 		if (args.cpages)
-			nouveau_dmem_migrate_chunk(&args, &migrate);
+			nouveau_dmem_migrate_chunk(&args, drm, dma_addrs);
 		args.start = args.end;
 	}
 
 	ret = 0;
+out_free_dma:
+	kfree(dma_addrs);
 out_free_dst:
 	kfree(args.dst);
 out_free_src:
-- 
2.20.1

