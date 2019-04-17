Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41545C282DD
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 18:53:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0572420663
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 18:53:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733146AbfDQSxP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 14:53:15 -0400
Received: from mga04.intel.com ([192.55.52.120]:21378 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731358AbfDQSxP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 14:53:15 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Apr 2019 11:53:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,362,1549958400"; 
   d="scan'208";a="316812583"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga005.jf.intel.com with ESMTP; 17 Apr 2019 11:53:12 -0700
Subject: [PATCH v6 06/12] mm/hotplug: Add mem-hotplug restrictions for
 remove_memory()
From:   Dan Williams <dan.j.williams@intel.com>
To:     akpm@linux-foundation.org
Cc:     Michal Hocko <mhocko@suse.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
        mhocko@suse.com, david@redhat.com
Date:   Wed, 17 Apr 2019 11:39:27 -0700
Message-ID: <155552636696.2015392.12612320706815016081.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <155552633539.2015392.2477781120122237934.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <155552633539.2015392.2477781120122237934.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Teach the arch_remove_memory() path to consult the same 'struct
mhp_restrictions' context as was specified at arch_add_memory() time.

No functional change, this is a preparation step for teaching
__remove_pages() about how and when to allow sub-section hot-remove, and
a cleanup for an unnecessary "is_dev_zone()" special case.

Cc: Michal Hocko <mhocko@suse.com>
Cc: Logan Gunthorpe <logang@deltatee.com>
Cc: David Hildenbrand <david@redhat.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 arch/ia64/mm/init.c            |    4 ++--
 arch/powerpc/mm/mem.c          |    5 +++--
 arch/s390/mm/init.c            |    2 +-
 arch/sh/mm/init.c              |    4 ++--
 arch/x86/mm/init_32.c          |    4 ++--
 arch/x86/mm/init_64.c          |    5 +++--
 include/linux/memory_hotplug.h |    5 +++--
 kernel/memremap.c              |   14 ++++++++------
 mm/memory_hotplug.c            |   17 ++++++++---------
 9 files changed, 32 insertions(+), 28 deletions(-)

diff --git a/arch/ia64/mm/init.c b/arch/ia64/mm/init.c
index d28e29103bdb..86c69c87e7e8 100644
--- a/arch/ia64/mm/init.c
+++ b/arch/ia64/mm/init.c
@@ -683,14 +683,14 @@ int arch_add_memory(int nid, u64 start, u64 size,
 
 #ifdef CONFIG_MEMORY_HOTREMOVE
 void arch_remove_memory(int nid, u64 start, u64 size,
-			struct vmem_altmap *altmap)
+		struct mhp_restrictions *restrictions)
 {
 	unsigned long start_pfn = start >> PAGE_SHIFT;
 	unsigned long nr_pages = size >> PAGE_SHIFT;
 	struct zone *zone;
 
 	zone = page_zone(pfn_to_page(start_pfn));
-	__remove_pages(zone, start_pfn, nr_pages, altmap);
+	__remove_pages(zone, start_pfn, nr_pages, restrictions);
 }
 #endif
 #endif
diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index cc9425fb9056..ccab989f397d 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -132,10 +132,11 @@ int __meminit arch_add_memory(int nid, u64 start, u64 size,
 
 #ifdef CONFIG_MEMORY_HOTREMOVE
 void __meminit arch_remove_memory(int nid, u64 start, u64 size,
-				  struct vmem_altmap *altmap)
+		struct mhp_restrictions *restrictions)
 {
 	unsigned long start_pfn = start >> PAGE_SHIFT;
 	unsigned long nr_pages = size >> PAGE_SHIFT;
+	struct vmem_altmap *altmap = restrictions->altmap;
 	struct page *page;
 	int ret;
 
@@ -147,7 +148,7 @@ void __meminit arch_remove_memory(int nid, u64 start, u64 size,
 	if (altmap)
 		page += vmem_altmap_offset(altmap);
 
-	__remove_pages(page_zone(page), start_pfn, nr_pages, altmap);
+	__remove_pages(page_zone(page), start_pfn, nr_pages, restrictions);
 
 	/* Remove htab bolted mappings for this section of memory */
 	start = (unsigned long)__va(start);
diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
index 31b1071315d7..3af7b99af1b1 100644
--- a/arch/s390/mm/init.c
+++ b/arch/s390/mm/init.c
@@ -235,7 +235,7 @@ int arch_add_memory(int nid, u64 start, u64 size,
 
 #ifdef CONFIG_MEMORY_HOTREMOVE
 void arch_remove_memory(int nid, u64 start, u64 size,
-			struct vmem_altmap *altmap)
+		struct mhp_restrictions *restrictions)
 {
 	/*
 	 * There is no hardware or firmware interface which could trigger a
diff --git a/arch/sh/mm/init.c b/arch/sh/mm/init.c
index 5aeb4d7099a1..3cff7e4723e6 100644
--- a/arch/sh/mm/init.c
+++ b/arch/sh/mm/init.c
@@ -430,14 +430,14 @@ EXPORT_SYMBOL_GPL(memory_add_physaddr_to_nid);
 
 #ifdef CONFIG_MEMORY_HOTREMOVE
 void arch_remove_memory(int nid, u64 start, u64 size,
-			struct vmem_altmap *altmap)
+		struct mhp_restrictions *restrictions)
 {
 	unsigned long start_pfn = PFN_DOWN(start);
 	unsigned long nr_pages = size >> PAGE_SHIFT;
 	struct zone *zone;
 
 	zone = page_zone(pfn_to_page(start_pfn));
-	__remove_pages(zone, start_pfn, nr_pages, altmap);
+	__remove_pages(zone, start_pfn, nr_pages, restrictions);
 }
 #endif
 #endif /* CONFIG_MEMORY_HOTPLUG */
diff --git a/arch/x86/mm/init_32.c b/arch/x86/mm/init_32.c
index 075e568098f2..ba888fd38f5d 100644
--- a/arch/x86/mm/init_32.c
+++ b/arch/x86/mm/init_32.c
@@ -861,14 +861,14 @@ int arch_add_memory(int nid, u64 start, u64 size,
 
 #ifdef CONFIG_MEMORY_HOTREMOVE
 void arch_remove_memory(int nid, u64 start, u64 size,
-			struct vmem_altmap *altmap)
+		struct mhp_restrictions *restrictions)
 {
 	unsigned long start_pfn = start >> PAGE_SHIFT;
 	unsigned long nr_pages = size >> PAGE_SHIFT;
 	struct zone *zone;
 
 	zone = page_zone(pfn_to_page(start_pfn));
-	__remove_pages(zone, start_pfn, nr_pages, altmap);
+	__remove_pages(zone, start_pfn, nr_pages, restrictions);
 }
 #endif
 #endif
diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index bb018d09d2dc..4071632be007 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1142,8 +1142,9 @@ kernel_physical_mapping_remove(unsigned long start, unsigned long end)
 }
 
 void __ref arch_remove_memory(int nid, u64 start, u64 size,
-			      struct vmem_altmap *altmap)
+		struct mhp_restrictions *restrictions)
 {
+	struct vmem_altmap *altmap = restrictions->altmap;
 	unsigned long start_pfn = start >> PAGE_SHIFT;
 	unsigned long nr_pages = size >> PAGE_SHIFT;
 	struct page *page = pfn_to_page(start_pfn);
@@ -1153,7 +1154,7 @@ void __ref arch_remove_memory(int nid, u64 start, u64 size,
 	if (altmap)
 		page += vmem_altmap_offset(altmap);
 	zone = page_zone(page);
-	__remove_pages(zone, start_pfn, nr_pages, altmap);
+	__remove_pages(zone, start_pfn, nr_pages, restrictions);
 	kernel_physical_mapping_remove(start, start + size);
 }
 #endif
diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index ae892eef8b82..31b768bd1268 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -125,9 +125,10 @@ static inline bool movable_node_is_enabled(void)
 
 #ifdef CONFIG_MEMORY_HOTREMOVE
 extern void arch_remove_memory(int nid, u64 start, u64 size,
-			       struct vmem_altmap *altmap);
+		struct mhp_restrictions *restrictions);
 extern void __remove_pages(struct zone *zone, unsigned long start_pfn,
-			   unsigned long nr_pages, struct vmem_altmap *altmap);
+		unsigned long nr_pages,
+		struct mhp_restrictions *restrictions);
 #endif /* CONFIG_MEMORY_HOTREMOVE */
 
 /*
diff --git a/kernel/memremap.c b/kernel/memremap.c
index f355586ea54a..33475e211568 100644
--- a/kernel/memremap.c
+++ b/kernel/memremap.c
@@ -108,8 +108,11 @@ static void devm_memremap_pages_release(void *data)
 		__remove_pages(page_zone(pfn_to_page(pfn)), pfn,
 				align_size >> PAGE_SHIFT, NULL);
 	} else {
-		arch_remove_memory(nid, align_start, align_size,
-				pgmap->altmap_valid ? &pgmap->altmap : NULL);
+		struct mhp_restrictions restrictions = {
+			.altmap = pgmap->altmap_valid ? &pgmap->altmap : NULL,
+		};
+
+		arch_remove_memory(nid, align_start, align_size, &restrictions);
 		kasan_remove_zero_shadow(__va(align_start), align_size);
 	}
 	mem_hotplug_done();
@@ -142,15 +145,14 @@ static void devm_memremap_pages_release(void *data)
 void *devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap)
 {
 	resource_size_t align_start, align_size, align_end;
-	struct vmem_altmap *altmap = pgmap->altmap_valid ?
-			&pgmap->altmap : NULL;
 	struct resource *res = &pgmap->res;
 	struct dev_pagemap *conflict_pgmap;
 	struct mhp_restrictions restrictions = {
 		/*
 		 * We do not want any optional features only our own memmap
 		*/
-		.altmap = altmap,
+
+		.altmap = pgmap->altmap_valid ? &pgmap->altmap : NULL,
 	};
 	pgprot_t pgprot = PAGE_KERNEL;
 	int error, nid, is_ram;
@@ -235,7 +237,7 @@ void *devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap)
 
 		zone = &NODE_DATA(nid)->node_zones[ZONE_DEVICE];
 		move_pfn_range_to_zone(zone, align_start >> PAGE_SHIFT,
-				align_size >> PAGE_SHIFT, altmap);
+				align_size >> PAGE_SHIFT, restrictions.altmap);
 	}
 
 	mem_hotplug_done();
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index d5874f9d4043..055cea62be6e 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -543,7 +543,7 @@ static void __remove_section(struct zone *zone, struct mem_section *ms,
  * @zone: zone from which pages need to be removed
  * @phys_start_pfn: starting pageframe (must be aligned to start of a section)
  * @nr_pages: number of pages to remove (must be multiple of section size)
- * @altmap: alternative device page map or %NULL if default memmap is used
+ * @restrictions: optional alternative device page map and other features
  *
  * Generic helper function to remove section mappings and sysfs entries
  * for the section of the memory we are removing. Caller needs to make
@@ -551,17 +551,15 @@ static void __remove_section(struct zone *zone, struct mem_section *ms,
  * calling offline_pages().
  */
 void __remove_pages(struct zone *zone, unsigned long phys_start_pfn,
-		    unsigned long nr_pages, struct vmem_altmap *altmap)
+		unsigned long nr_pages, struct mhp_restrictions *restrictions)
 {
 	unsigned long i;
-	unsigned long map_offset = 0;
 	int sections_to_remove;
+	unsigned long map_offset = 0;
+	struct vmem_altmap *altmap = restrictions->altmap;
 
-	/* In the ZONE_DEVICE case device driver owns the memory region */
-	if (is_dev_zone(zone)) {
-		if (altmap)
-			map_offset = vmem_altmap_offset(altmap);
-	}
+	if (altmap)
+		map_offset = vmem_altmap_offset(altmap);
 
 	clear_zone_contiguous(zone);
 
@@ -1832,6 +1830,7 @@ static void __release_memory_resource(u64 start, u64 size)
  */
 void __ref __remove_memory(int nid, u64 start, u64 size)
 {
+	struct mhp_restrictions restrictions = { 0 };
 	int ret;
 
 	BUG_ON(check_hotplug_memory_range(start, size));
@@ -1853,7 +1852,7 @@ void __ref __remove_memory(int nid, u64 start, u64 size)
 	memblock_free(start, size);
 	memblock_remove(start, size);
 
-	arch_remove_memory(nid, start, size, NULL);
+	arch_remove_memory(nid, start, size, &restrictions);
 	__release_memory_resource(start, size);
 
 	try_offline_node(nid);

