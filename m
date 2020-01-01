Return-Path: <SRS0=1Df5=2W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20EF7C2D0CE
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jan 2020 01:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA993206E4
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jan 2020 01:55:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RlHrBnDX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727169AbgAABzA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Dec 2019 20:55:00 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:38735 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726806AbgAABzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Dec 2019 20:55:00 -0500
Received: by mail-pj1-f65.google.com with SMTP id l35so1767840pje.3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Dec 2019 17:54:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=fe0NgvD9BmtmfbiohPJASKeYNy6EnLhwU2wYALWek5M=;
        b=RlHrBnDXS/S7lhXTLtxGMZYxeabPT0OuRnyk9Ev+T/fgvJfj1U3DtobXZEHq9VMJ4B
         Wg53+U8V/sWFycnuzOCni0A+EZeqVchKs8jLNVZWwYFyd85Z6PSiyLdBp+hpoZ6HGrk9
         BVheZERXdfEV11g9VguFsiQPp74Ue8tjxGX4G/GxfXQgczqLVR/c1wr2MRQqndOsEMrn
         PTcDSuJ1TQEsvHw3Jhxpj0W58qhenrFa27sa82UnPOrxL7vRK+MzIhnBr8j5l5UtCy5C
         iIBiAT6KIM+L+TqA6tBNztz7mdzaYN5Ug5xwPZRZ010IWt2foK5bbnht3J4uKwyA11QF
         P69w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=fe0NgvD9BmtmfbiohPJASKeYNy6EnLhwU2wYALWek5M=;
        b=qKBKBgVcS7MwxQq+YWuryjqzhXG4ywhUhJwUb1iF0x83/RPZ/E7qaOrl+Q94rl2aD5
         UkjjuS67ZBLwzXiExaoT4DDcIPUyxSl5XAckivcKCYUeKqqGCvOgUNWwchbvIatUMzTd
         WbLp7cj8ebR244H3kQGNftJ4ZLZOke9rGOl9Xeiaxw8DG/ytmHmv6vjaLgHWT1Z9Tm8G
         OBw7rPONA3F0MoCIth3mjfZID/rV5sGpv1AgM/sOmBpVycmud34UkUjJ4DUwCURNXm1h
         PdXH2EDGH3qbrMaXXVJkheRodXPjLdY5+Cjt1fpnWBCF9z/NNE5Co2hRail1PV2eXOkI
         RJwA==
X-Gm-Message-State: APjAAAWKN3KH/u1J5FHRKC4DwlMkT05xdZ9xp+EHJqOLg4BtNYPZslKX
        8Tsopj98FPsSryAZ+VGn83hbEQ==
X-Google-Smtp-Source: APXvYqwuT1mCEM/nW8d/jc3dLeTlnii6a/PdHVjRO9JUrx+gN0rS5MqkYriFNwImSXm4TxW4z8XkJw==
X-Received: by 2002:a17:90a:d78f:: with SMTP id z15mr10287983pju.36.1577843699135;
        Tue, 31 Dec 2019 17:54:59 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id h3sm58385689pfr.15.2019.12.31.17.54.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Dec 2019 17:54:58 -0800 (PST)
Date:   Tue, 31 Dec 2019 17:54:57 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Christoph Hellwig <hch@lst.de>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
cc:     "Singh, Brijesh" <brijesh.singh@amd.com>,
        "Grimm, Jon" <jon.grimm@amd.com>, Joerg Roedel <joro@8bytes.org>,
        baekhw@google.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Subject: [rfc] dma-mapping: preallocate unencrypted DMA atomic pool
Message-ID: <alpine.DEB.2.21.1912311738130.68206@chino.kir.corp.google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph, Thomas, is something like this (without the diagnosic 
information included in this patch) acceptable for these allocations?  
Adding expansion support when the pool is half depleted wouldn't be *that* 
hard.

Or are there alternatives we should consider?  Thanks!




When AMD SEV is enabled in the guest, all allocations through 
dma_pool_alloc_page() must call set_memory_decrypted() for unencrypted 
DMA.  This includes dma_pool_alloc() and dma_direct_alloc_pages().  These 
calls may block which is not allowed in atomic allocation contexts such as 
from the NVMe driver.

Preallocate a complementary unecrypted DMA atomic pool that is initially 
4MB in size.  This patch does not contain dynamic expansion, but that 
could be added if necessary.

In our stress testing, our peak unecrypted DMA atomic allocation 
requirements is ~1.4MB, so 4MB is plenty.  This pool is similar to the 
existing DMA atomic pool but is unencrypted.

Signed-off-by: David Rientjes <rientjes@google.com>
---
 Based on v5.4 HEAD.

 This commit contains diagnostic information and is not intended for use 
 in a production environment.

 arch/x86/Kconfig            |   1 +
 drivers/iommu/dma-iommu.c   |   5 +-
 include/linux/dma-mapping.h |   7 ++-
 kernel/dma/direct.c         |  16 ++++-
 kernel/dma/remap.c          | 116 ++++++++++++++++++++++++++----------
 5 files changed, 108 insertions(+), 37 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1530,6 +1530,7 @@ config X86_CPA_STATISTICS
 config AMD_MEM_ENCRYPT
 	bool "AMD Secure Memory Encryption (SME) support"
 	depends on X86_64 && CPU_SUP_AMD
+	select DMA_DIRECT_REMAP
 	select DYNAMIC_PHYSICAL_MASK
 	select ARCH_USE_MEMREMAP_PROT
 	select ARCH_HAS_FORCE_DMA_UNENCRYPTED
diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -928,7 +928,7 @@ static void __iommu_dma_free(struct device *dev, size_t size, void *cpu_addr)
 
 	/* Non-coherent atomic allocation? Easy */
 	if (IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) &&
-	    dma_free_from_pool(cpu_addr, alloc_size))
+	    dma_free_from_pool(dev, cpu_addr, alloc_size))
 		return;
 
 	if (IS_ENABLED(CONFIG_DMA_REMAP) && is_vmalloc_addr(cpu_addr)) {
@@ -1011,7 +1011,8 @@ static void *iommu_dma_alloc(struct device *dev, size_t size,
 
 	if (IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) &&
 	    !gfpflags_allow_blocking(gfp) && !coherent)
-		cpu_addr = dma_alloc_from_pool(PAGE_ALIGN(size), &page, gfp);
+		cpu_addr = dma_alloc_from_pool(dev, PAGE_ALIGN(size), &page,
+					       gfp);
 	else
 		cpu_addr = iommu_dma_alloc_pages(dev, size, &page, gfp, attrs);
 	if (!cpu_addr)
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -629,9 +629,10 @@ void *dma_common_pages_remap(struct page **pages, size_t size,
 			pgprot_t prot, const void *caller);
 void dma_common_free_remap(void *cpu_addr, size_t size);
 
-bool dma_in_atomic_pool(void *start, size_t size);
-void *dma_alloc_from_pool(size_t size, struct page **ret_page, gfp_t flags);
-bool dma_free_from_pool(void *start, size_t size);
+bool dma_in_atomic_pool(struct device *dev, void *start, size_t size);
+void *dma_alloc_from_pool(struct device *dev, size_t size,
+			  struct page **ret_page, gfp_t flags);
+bool dma_free_from_pool(struct device *dev, void *start, size_t size);
 
 int
 dma_common_get_sgtable(struct device *dev, struct sg_table *sgt, void *cpu_addr,
diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -10,6 +10,7 @@
 #include <linux/dma-direct.h>
 #include <linux/scatterlist.h>
 #include <linux/dma-contiguous.h>
+#include <linux/dma-mapping.h>
 #include <linux/dma-noncoherent.h>
 #include <linux/pfn.h>
 #include <linux/set_memory.h>
@@ -131,6 +132,13 @@ void *dma_direct_alloc_pages(struct device *dev, size_t size,
 	struct page *page;
 	void *ret;
 
+	if (!gfpflags_allow_blocking(gfp) && force_dma_unencrypted(dev)) {
+		ret = dma_alloc_from_pool(dev, size, &page, gfp);
+		if (!ret)
+			return NULL;
+		goto done;
+	}
+
 	page = __dma_direct_alloc_pages(dev, size, dma_handle, gfp, attrs);
 	if (!page)
 		return NULL;
@@ -156,7 +164,7 @@ void *dma_direct_alloc_pages(struct device *dev, size_t size,
 		__dma_direct_free_pages(dev, size, page);
 		return NULL;
 	}
-
+done:
 	ret = page_address(page);
 	if (force_dma_unencrypted(dev)) {
 		set_memory_decrypted((unsigned long)ret, 1 << get_order(size));
@@ -185,6 +193,12 @@ void dma_direct_free_pages(struct device *dev, size_t size, void *cpu_addr,
 {
 	unsigned int page_order = get_order(size);
 
+	if (force_dma_unencrypted(dev) &&
+	    dma_in_atomic_pool(dev, cpu_addr, size)) {
+		dma_free_from_pool(dev, cpu_addr, size);
+		return;
+	}
+
 	if ((attrs & DMA_ATTR_NO_KERNEL_MAPPING) &&
 	    !force_dma_unencrypted(dev)) {
 		/* cpu_addr is a struct page cookie, not a kernel address */
diff --git a/kernel/dma/remap.c b/kernel/dma/remap.c
--- a/kernel/dma/remap.c
+++ b/kernel/dma/remap.c
@@ -8,6 +8,7 @@
 #include <linux/dma-contiguous.h>
 #include <linux/init.h>
 #include <linux/genalloc.h>
+#include <linux/set_memory.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 
@@ -100,9 +101,11 @@ void dma_common_free_remap(void *cpu_addr, size_t size)
 
 #ifdef CONFIG_DMA_DIRECT_REMAP
 static struct gen_pool *atomic_pool __ro_after_init;
+static struct gen_pool *atomic_pool_unencrypted __ro_after_init;
 
 #define DEFAULT_DMA_COHERENT_POOL_SIZE  SZ_256K
 static size_t atomic_pool_size __initdata = DEFAULT_DMA_COHERENT_POOL_SIZE;
+static size_t atomic_pool_unencrypted_size __initdata = SZ_4M;
 
 static int __init early_coherent_pool(char *p)
 {
@@ -120,10 +123,11 @@ static gfp_t dma_atomic_pool_gfp(void)
 	return GFP_KERNEL;
 }
 
-static int __init dma_atomic_pool_init(void)
+static int __init __dma_atomic_pool_init(struct gen_pool **pool,
+				size_t pool_size, bool unencrypt)
 {
-	unsigned int pool_size_order = get_order(atomic_pool_size);
-	unsigned long nr_pages = atomic_pool_size >> PAGE_SHIFT;
+	unsigned int pool_size_order = get_order(pool_size);
+	unsigned long nr_pages = pool_size >> PAGE_SHIFT;
 	struct page *page;
 	void *addr;
 	int ret;
@@ -136,78 +140,128 @@ static int __init dma_atomic_pool_init(void)
 	if (!page)
 		goto out;
 
-	arch_dma_prep_coherent(page, atomic_pool_size);
+	arch_dma_prep_coherent(page, pool_size);
 
-	atomic_pool = gen_pool_create(PAGE_SHIFT, -1);
-	if (!atomic_pool)
+	*pool = gen_pool_create(PAGE_SHIFT, -1);
+	if (!*pool)
 		goto free_page;
 
-	addr = dma_common_contiguous_remap(page, atomic_pool_size,
+	addr = dma_common_contiguous_remap(page, pool_size,
 					   pgprot_dmacoherent(PAGE_KERNEL),
 					   __builtin_return_address(0));
 	if (!addr)
 		goto destroy_genpool;
 
-	ret = gen_pool_add_virt(atomic_pool, (unsigned long)addr,
-				page_to_phys(page), atomic_pool_size, -1);
+	ret = gen_pool_add_virt(*pool, (unsigned long)addr, page_to_phys(page),
+				pool_size, -1);
 	if (ret)
 		goto remove_mapping;
-	gen_pool_set_algo(atomic_pool, gen_pool_first_fit_order_align, NULL);
+	gen_pool_set_algo(*pool, gen_pool_first_fit_order_align, NULL);
+	if (unencrypt)
+		set_memory_decrypted((unsigned long)page_to_virt(page), nr_pages);
 
-	pr_info("DMA: preallocated %zu KiB pool for atomic allocations\n",
-		atomic_pool_size / 1024);
+	pr_info("DMA: preallocated %zu KiB pool for atomic allocations%s\n",
+		pool_size >> 10, unencrypt ? " (unencrypted)" : "");
 	return 0;
 
 remove_mapping:
-	dma_common_free_remap(addr, atomic_pool_size);
+	dma_common_free_remap(addr, pool_size);
 destroy_genpool:
-	gen_pool_destroy(atomic_pool);
-	atomic_pool = NULL;
+	gen_pool_destroy(*pool);
+	*pool = NULL;
 free_page:
 	if (!dma_release_from_contiguous(NULL, page, nr_pages))
 		__free_pages(page, pool_size_order);
 out:
-	pr_err("DMA: failed to allocate %zu KiB pool for atomic coherent allocation\n",
-		atomic_pool_size / 1024);
+	pr_err("DMA: failed to allocate %zu KiB pool for atomic coherent allocation%s\n",
+		pool_size >> 10, unencrypt ? " (unencrypted)" : "");
 	return -ENOMEM;
 }
+
+static int __init dma_atomic_pool_init(void)
+{
+	int ret;
+
+	ret = __dma_atomic_pool_init(&atomic_pool, atomic_pool_size, false);
+	if (ret)
+		return ret;
+	return __dma_atomic_pool_init(&atomic_pool_unencrypted,
+				      atomic_pool_unencrypted_size, true);
+}
 postcore_initcall(dma_atomic_pool_init);
 
-bool dma_in_atomic_pool(void *start, size_t size)
+static inline struct gen_pool *dev_to_pool(struct device *dev)
 {
-	if (unlikely(!atomic_pool))
-		return false;
+	if (force_dma_unencrypted(dev))
+		return atomic_pool_unencrypted;
+	return atomic_pool;
+}
+
+bool dma_in_atomic_pool(struct device *dev, void *start, size_t size)
+{
+	struct gen_pool *pool = dev_to_pool(dev);
 
-	return addr_in_gen_pool(atomic_pool, (unsigned long)start, size);
+	if (unlikely(!pool))
+		return false;
+	return addr_in_gen_pool(pool, (unsigned long)start, size);
 }
 
-void *dma_alloc_from_pool(size_t size, struct page **ret_page, gfp_t flags)
+static struct gen_pool *atomic_pool __ro_after_init;
+static size_t encrypted_pool_size;
+static size_t encrypted_pool_size_max;
+static spinlock_t encrypted_pool_size_lock;
+
+void *dma_alloc_from_pool(struct device *dev, size_t size,
+			  struct page **ret_page, gfp_t flags)
 {
+	struct gen_pool *pool = dev_to_pool(dev);
 	unsigned long val;
 	void *ptr = NULL;
 
-	if (!atomic_pool) {
-		WARN(1, "coherent pool not initialised!\n");
+	if (!pool) {
+		WARN(1, "%scoherent pool not initialised!\n",
+			force_dma_unencrypted(dev) ? "encrypted " : "");
 		return NULL;
 	}
 
-	val = gen_pool_alloc(atomic_pool, size);
+	val = gen_pool_alloc(pool, size);
 	if (val) {
-		phys_addr_t phys = gen_pool_virt_to_phys(atomic_pool, val);
+		phys_addr_t phys = gen_pool_virt_to_phys(pool, val);
 
 		*ret_page = pfn_to_page(__phys_to_pfn(phys));
 		ptr = (void *)val;
 		memset(ptr, 0, size);
+		if (force_dma_unencrypted(dev)) {
+			unsigned long flags;
+
+			spin_lock_irqsave(&encrypted_pool_size_lock, flags);
+			encrypted_pool_size += size;
+			if (encrypted_pool_size > encrypted_pool_size_max) {
+				encrypted_pool_size_max = encrypted_pool_size;
+				pr_info("max encrypted pool size now %lu\n",
+					encrypted_pool_size_max);
+			}
+			spin_unlock_irqrestore(&encrypted_pool_size_lock, flags);
+		}
 	}
 
 	return ptr;
 }
 
-bool dma_free_from_pool(void *start, size_t size)
+bool dma_free_from_pool(struct device *dev, void *start, size_t size)
 {
-	if (!dma_in_atomic_pool(start, size))
+	struct gen_pool *pool = dev_to_pool(dev);
+
+	if (!dma_in_atomic_pool(dev, start, size))
 		return false;
-	gen_pool_free(atomic_pool, (unsigned long)start, size);
+	gen_pool_free(pool, (unsigned long)start, size);
+	if (force_dma_unencrypted(dev)) {
+		unsigned long flags;
+
+		spin_lock_irqsave(&encrypted_pool_size_lock, flags);
+		encrypted_pool_size -= size;
+		spin_unlock_irqrestore(&encrypted_pool_size_lock, flags);
+	}
 	return true;
 }
 
@@ -220,7 +274,7 @@ void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
 	size = PAGE_ALIGN(size);
 
 	if (!gfpflags_allow_blocking(flags)) {
-		ret = dma_alloc_from_pool(size, &page, flags);
+		ret = dma_alloc_from_pool(dev, size, &page, flags);
 		if (!ret)
 			return NULL;
 		goto done;
@@ -251,7 +305,7 @@ void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
 void arch_dma_free(struct device *dev, size_t size, void *vaddr,
 		dma_addr_t dma_handle, unsigned long attrs)
 {
-	if (!dma_free_from_pool(vaddr, PAGE_ALIGN(size))) {
+	if (!dma_free_from_pool(dev, vaddr, PAGE_ALIGN(size))) {
 		phys_addr_t phys = dma_to_phys(dev, dma_handle);
 		struct page *page = pfn_to_page(__phys_to_pfn(phys));
 
