Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC7ABC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 04:08:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 714762175B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 04:08:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q3gEWc9Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731819AbfEXEIG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 00:08:06 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41532 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbfEXEIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 00:08:05 -0400
Received: by mail-pf1-f196.google.com with SMTP id q17so4473666pfq.8
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 21:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dTxvT9mC2yTH7bA91mv9m7CkISDrjjXm+XA0cpum2uY=;
        b=q3gEWc9Yk89TvNqPulhJbgJnR9XjIbib6zN5vu6rt9OmbdYwblIxnrH8BOSiXOXKMh
         no0A6P3H8sQToDEDZiSOhSf63yZWHyOvo/zSUVk758PfIb13+PYZiXOIblYzRQEW6Bu4
         IDgMFMLl2MvpprV+li8xjmqiXDGLFlZhfIZRlDmGHdC4Wy8I4brg3QEr6BIdinuFFeJN
         /6AlLeG32l07sXTU+ncXCf756W2P3HZTowLV+FguNBHfE6i/TYpJkkLyT8aXadyNv0u8
         kIBxcuwGu6KNFrUOJreBc7Z+0o1tRuMOxF59N7F6yoY/UsHsPltbcyTJasXPsdgm3Ek+
         aWqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dTxvT9mC2yTH7bA91mv9m7CkISDrjjXm+XA0cpum2uY=;
        b=KCT0EJxeLlYCgNOsY82Cv509MFPXv8jHQ5O4GF2GPKF+IifwxowD82FQYyLU9pkJ94
         Wa9A/Ly/vr59pr7o664pd4mynMGBJNIn2SYcfbuCJhFesTIgaFAR1ZEcJQ52g0wgERSz
         kUDfTnC/Jzsa9Tui4F9R9VGKCgBXuZzGtCRrujxQiGgjzXBGDxx/6pLYovJCN3kLY2Fb
         ul/BHUCmyLRAN7b+4DwJztyTMrLbSNvUTdsSEyOTcJYCP4b7mBUeOE360aEWPJLAcSTR
         IweqSZaZstEeuSQar8jqAjE5WDZ9WwUQaASIh9PJSookJn+/9wrtvVyjCFlbXqzAFcBL
         jj9Q==
X-Gm-Message-State: APjAAAUx7RK4tWWAWhKixg7F6+cmQsH+ZMS3yioiox7QygRk3T4pXlVa
        3HekCPkIN4I5M6Sigu4ft4I=
X-Google-Smtp-Source: APXvYqwWGeEz8UB+yjAPWZ/fzf8KpSxJxakwAqDiMCEdYJOOa5hkqutsEhSaAMyi9ujtJEHiGf9BVA==
X-Received: by 2002:aa7:864e:: with SMTP id a14mr99209859pfo.132.1558670883726;
        Thu, 23 May 2019 21:08:03 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id e123sm786412pgc.29.2019.05.23.21.08.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 21:08:03 -0700 (PDT)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     hch@lst.de, robin.murphy@arm.com, m.szyprowski@samsung.com
Cc:     vdumpa@nvidia.com, linux@armlinux.org.uk, catalin.marinas@arm.com,
        will.deacon@arm.com, chris@zankel.net, jcmvbkbc@gmail.com,
        joro@8bytes.org, dwmw2@infradead.org, tony@atomide.com,
        akpm@linux-foundation.org, sfr@canb.auug.org.au,
        treding@nvidia.com, keescook@chromium.org, iamjoonsoo.kim@lge.com,
        wsa+renesas@sang-engineering.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, iommu@lists.linux-foundation.org,
        dann.frazier@canonical.com
Subject: [PATCH v3 1/2] dma-contiguous: Abstract dma_{alloc,free}_contiguous()
Date:   Thu, 23 May 2019 21:06:32 -0700
Message-Id: <20190524040633.16854-2-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190524040633.16854-1-nicoleotsuka@gmail.com>
References: <20190524040633.16854-1-nicoleotsuka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both dma_alloc_from_contiguous() and dma_release_from_contiguous()
are very simply implemented, but requiring callers to pass certain
parameters like count and align, and taking a boolean parameter to
check __GFP_NOWARN in the allocation flags. So every function call
duplicates similar work:
  /* A piece of example */
  unsigned long order = get_order(size);
  size_t count = size >> PAGE_SHIFT;
  page = dma_alloc_from_contiguous(dev, count, order, gfp & __GFP_NOWARN);
  [...]
  dma_release_from_contiguous(dev, page, size >> PAGE_SHIFT);

Additionally, as CMA can be used only in the context which permits
sleeping, most of callers do a gfpflags_allow_blocking() check and
a corresponding fallback allocation of normal pages upon any false
result:
  /* A piece of example */
  if (gfpflags_allow_blocking(flag))
      page = dma_alloc_from_contiguous();
  if (!page)
      page = alloc_pages();
  [...]
  if (!dma_release_from_contiguous(dev, page, count))
      __free_pages(page, get_order(size));

So this patch simplifies those function calls by abstracting these
operations into the two new functions: dma_{alloc,free}_contiguous.

As some callers of dma_{alloc,release}_from_contiguous() might be
complicated, this patch just implements these two new functions to
kernel/dma/direct.c only as an initial step.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
Changelog
v2->v3:
 * Added missing "static inline" in header file to fix build error.
v1->v2:
 * Added new functions beside the old ones so we can replace callers
   one by one later.
 * Applied new functions to dma/direct.c only, because it's the best
   example caller to apply and should be safe with the new functions.

 include/linux/dma-contiguous.h | 11 ++++++++
 kernel/dma/contiguous.c        | 48 ++++++++++++++++++++++++++++++++++
 kernel/dma/direct.c            | 24 +++--------------
 3 files changed, 63 insertions(+), 20 deletions(-)

diff --git a/include/linux/dma-contiguous.h b/include/linux/dma-contiguous.h
index f247e8aa5e3d..00a370c1c140 100644
--- a/include/linux/dma-contiguous.h
+++ b/include/linux/dma-contiguous.h
@@ -115,6 +115,8 @@ struct page *dma_alloc_from_contiguous(struct device *dev, size_t count,
 				       unsigned int order, bool no_warn);
 bool dma_release_from_contiguous(struct device *dev, struct page *pages,
 				 int count);
+struct page *dma_alloc_contiguous(struct device *dev, size_t size, gfp_t gfp);
+void dma_free_contiguous(struct device *dev, struct page *page, size_t size);
 
 #else
 
@@ -157,6 +159,15 @@ bool dma_release_from_contiguous(struct device *dev, struct page *pages,
 	return false;
 }
 
+static inline
+struct page *dma_alloc_contiguous(struct device *dev, size_t size, gfp_t gfp)
+{
+	return NULL;
+}
+
+static inline
+void dma_free_contiguous(struct device *dev, struct page *page, size_t size) { }
+
 #endif
 
 #endif
diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index b2a87905846d..21f39a6cb04f 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -214,6 +214,54 @@ bool dma_release_from_contiguous(struct device *dev, struct page *pages,
 	return cma_release(dev_get_cma_area(dev), pages, count);
 }
 
+/**
+ * dma_alloc_contiguous() - allocate contiguous pages
+ * @dev:   Pointer to device for which the allocation is performed.
+ * @size:  Requested allocation size.
+ * @gfp:   Allocation flags.
+ *
+ * This function allocates contiguous memory buffer for specified device. It
+ * first tries to use device specific contiguous memory area if available or
+ * the default global one, then tries a fallback allocation of normal pages.
+ */
+struct page *dma_alloc_contiguous(struct device *dev, size_t size, gfp_t gfp)
+{
+	int node = dev ? dev_to_node(dev) : NUMA_NO_NODE;
+	size_t count = PAGE_ALIGN(size) >> PAGE_SHIFT;
+	size_t align = get_order(PAGE_ALIGN(size));
+	struct cma *cma = dev_get_cma_area(dev);
+	struct page *page = NULL;
+
+	/* CMA can be used only in the context which permits sleeping */
+	if (cma && gfpflags_allow_blocking(gfp)) {
+		align = min_t(size_t, align, CONFIG_CMA_ALIGNMENT);
+		page = cma_alloc(cma, count, align, gfp & __GFP_NOWARN);
+	}
+
+	/* Fallback allocation of normal pages */
+	if (!page)
+		page = alloc_pages_node(node, gfp, align);
+
+	return page;
+}
+
+/**
+ * dma_free_contiguous() - release allocated pages
+ * @dev:   Pointer to device for which the pages were allocated.
+ * @page:  Pointer to the allocated pages.
+ * @size:  Size of allocated pages.
+ *
+ * This function releases memory allocated by dma_alloc_contiguous(). As the
+ * cma_release returns false when provided pages do not belong to contiguous
+ * area and true otherwise, this function then does a fallback __free_pages()
+ * upon a false-return.
+ */
+void dma_free_contiguous(struct device *dev, struct page *page, size_t size)
+{
+	if (!cma_release(dev_get_cma_area(dev), page, size >> PAGE_SHIFT))
+		__free_pages(page, get_order(size));
+}
+
 /*
  * Support for reserved memory regions defined in device tree
  */
diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 2c2772e9702a..0816c1e8b05a 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -96,8 +96,6 @@ static bool dma_coherent_ok(struct device *dev, phys_addr_t phys, size_t size)
 struct page *__dma_direct_alloc_pages(struct device *dev, size_t size,
 		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
 {
-	unsigned int count = PAGE_ALIGN(size) >> PAGE_SHIFT;
-	int page_order = get_order(size);
 	struct page *page = NULL;
 	u64 phys_mask;
 
@@ -109,20 +107,9 @@ struct page *__dma_direct_alloc_pages(struct device *dev, size_t size,
 	gfp |= __dma_direct_optimal_gfp_mask(dev, dev->coherent_dma_mask,
 			&phys_mask);
 again:
-	/* CMA can be used only in the context which permits sleeping */
-	if (gfpflags_allow_blocking(gfp)) {
-		page = dma_alloc_from_contiguous(dev, count, page_order,
-						 gfp & __GFP_NOWARN);
-		if (page && !dma_coherent_ok(dev, page_to_phys(page), size)) {
-			dma_release_from_contiguous(dev, page, count);
-			page = NULL;
-		}
-	}
-	if (!page)
-		page = alloc_pages_node(dev_to_node(dev), gfp, page_order);
-
+	page = dma_alloc_contiguous(dev, size, gfp);
 	if (page && !dma_coherent_ok(dev, page_to_phys(page), size)) {
-		__free_pages(page, page_order);
+		dma_free_contiguous(dev, page, size);
 		page = NULL;
 
 		if (IS_ENABLED(CONFIG_ZONE_DMA32) &&
@@ -154,7 +141,7 @@ void *dma_direct_alloc_pages(struct device *dev, size_t size,
 	if (PageHighMem(page)) {
 		/*
 		 * Depending on the cma= arguments and per-arch setup
-		 * dma_alloc_from_contiguous could return highmem pages.
+		 * dma_alloc_contiguous could return highmem pages.
 		 * Without remapping there is no way to return them here,
 		 * so log an error and fail.
 		 */
@@ -176,10 +163,7 @@ void *dma_direct_alloc_pages(struct device *dev, size_t size,
 
 void __dma_direct_free_pages(struct device *dev, size_t size, struct page *page)
 {
-	unsigned int count = PAGE_ALIGN(size) >> PAGE_SHIFT;
-
-	if (!dma_release_from_contiguous(dev, page, count))
-		__free_pages(page, get_order(size));
+	dma_free_contiguous(dev, page, size);
 }
 
 void dma_direct_free_pages(struct device *dev, size_t size, void *cpu_addr,
-- 
2.17.1

