Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16800C28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 22:12:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE40A2070B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 22:12:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbfFEWMk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 18:12:40 -0400
Received: from mga04.intel.com ([192.55.52.120]:28909 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726502AbfFEWMj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 18:12:39 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Jun 2019 15:12:38 -0700
X-ExtLoop1: 1
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga007.fm.intel.com with ESMTP; 05 Jun 2019 15:12:38 -0700
Subject: [PATCH v9 04/12] mm/sparsemem: Convert kmalloc_section_memmap() to
 populate_section_memmap()
From:   Dan Williams <dan.j.williams@intel.com>
To:     akpm@linux-foundation.org
Cc:     Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Oscar Salvador <osalvador@suse.de>,
        Pavel Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
        osalvador@suse.de, mhocko@suse.com
Date:   Wed, 05 Jun 2019 14:58:21 -0700
Message-ID: <155977189139.2443951.460884430946346998.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <155977186863.2443951.9036044808311959913.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <155977186863.2443951.9036044808311959913.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow sub-section sized ranges to be added to the memmap.
populate_section_memmap() takes an explict pfn range rather than
assuming a full section, and those parameters are plumbed all the way
through to vmmemap_populate(). There should be no sub-section usage in
current deployments. New warnings are added to clarify which memmap
allocation paths are sub-section capable.

Cc: Michal Hocko <mhocko@suse.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Logan Gunthorpe <logang@deltatee.com>
Cc: Oscar Salvador <osalvador@suse.de>
Reviewed-by: Pavel Tatashin <pasha.tatashin@soleen.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 arch/x86/mm/init_64.c |    4 ++-
 include/linux/mm.h    |    4 ++-
 mm/sparse-vmemmap.c   |   21 +++++++++++------
 mm/sparse.c           |   61 +++++++++++++++++++++++++++++++------------------
 4 files changed, 57 insertions(+), 33 deletions(-)

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 8335ac6e1112..688fb0687e55 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1520,7 +1520,9 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
 {
 	int err;
 
-	if (boot_cpu_has(X86_FEATURE_PSE))
+	if (end - start < PAGES_PER_SECTION * sizeof(struct page))
+		err = vmemmap_populate_basepages(start, end, node);
+	else if (boot_cpu_has(X86_FEATURE_PSE))
 		err = vmemmap_populate_hugepages(start, end, node, altmap);
 	else if (altmap) {
 		pr_err_once("%s: no cpu support for altmap allocations\n",
diff --git a/include/linux/mm.h b/include/linux/mm.h
index acc578407e9e..c502f3ce8661 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2734,8 +2734,8 @@ const char * arch_vma_name(struct vm_area_struct *vma);
 void print_vma_addr(char *prefix, unsigned long rip);
 
 void *sparse_buffer_alloc(unsigned long size);
-struct page *sparse_mem_map_populate(unsigned long pnum, int nid,
-		struct vmem_altmap *altmap);
+struct page * __populate_section_memmap(unsigned long pfn,
+		unsigned long nr_pages, int nid, struct vmem_altmap *altmap);
 pgd_t *vmemmap_pgd_populate(unsigned long addr, int node);
 p4d_t *vmemmap_p4d_populate(pgd_t *pgd, unsigned long addr, int node);
 pud_t *vmemmap_pud_populate(p4d_t *p4d, unsigned long addr, int node);
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index 7fec05796796..200aef686722 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -245,19 +245,26 @@ int __meminit vmemmap_populate_basepages(unsigned long start,
 	return 0;
 }
 
-struct page * __meminit sparse_mem_map_populate(unsigned long pnum, int nid,
-		struct vmem_altmap *altmap)
+struct page * __meminit __populate_section_memmap(unsigned long pfn,
+		unsigned long nr_pages, int nid, struct vmem_altmap *altmap)
 {
 	unsigned long start;
 	unsigned long end;
-	struct page *map;
 
-	map = pfn_to_page(pnum * PAGES_PER_SECTION);
-	start = (unsigned long)map;
-	end = (unsigned long)(map + PAGES_PER_SECTION);
+	/*
+	 * The minimum granularity of memmap extensions is
+	 * PAGES_PER_SUBSECTION as allocations are tracked in the
+	 * 'subsection_map' bitmap of the section.
+	 */
+	end = ALIGN(pfn + nr_pages, PAGES_PER_SUBSECTION);
+	pfn &= PAGE_SUBSECTION_MASK;
+	nr_pages = end - pfn;
+
+	start = (unsigned long) pfn_to_page(pfn);
+	end = start + nr_pages * sizeof(struct page);
 
 	if (vmemmap_populate(start, end, nid, altmap))
 		return NULL;
 
-	return map;
+	return pfn_to_page(pfn);
 }
diff --git a/mm/sparse.c b/mm/sparse.c
index 0baa2e55cfdd..2093c662a5f7 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -439,8 +439,8 @@ static unsigned long __init section_map_size(void)
 	return PAGE_ALIGN(sizeof(struct page) * PAGES_PER_SECTION);
 }
 
-struct page __init *sparse_mem_map_populate(unsigned long pnum, int nid,
-		struct vmem_altmap *altmap)
+struct page __init *__populate_section_memmap(unsigned long pfn,
+		unsigned long nr_pages, int nid, struct vmem_altmap *altmap)
 {
 	unsigned long size = section_map_size();
 	struct page *map = sparse_buffer_alloc(size);
@@ -521,10 +521,13 @@ static void __init sparse_init_nid(int nid, unsigned long pnum_begin,
 	}
 	sparse_buffer_init(map_count * section_map_size(), nid);
 	for_each_present_section_nr(pnum_begin, pnum) {
+		unsigned long pfn = section_nr_to_pfn(pnum);
+
 		if (pnum >= pnum_end)
 			break;
 
-		map = sparse_mem_map_populate(pnum, nid, NULL);
+		map = __populate_section_memmap(pfn, PAGES_PER_SECTION,
+				nid, NULL);
 		if (!map) {
 			pr_err("%s: node[%d] memory map backing failed. Some memory will not be available.",
 			       __func__, nid);
@@ -624,17 +627,17 @@ void offline_mem_sections(unsigned long start_pfn, unsigned long end_pfn)
 #endif
 
 #ifdef CONFIG_SPARSEMEM_VMEMMAP
-static inline struct page *kmalloc_section_memmap(unsigned long pnum, int nid,
-		struct vmem_altmap *altmap)
+static struct page *populate_section_memmap(unsigned long pfn,
+		unsigned long nr_pages, int nid, struct vmem_altmap *altmap)
 {
-	/* This will make the necessary allocations eventually. */
-	return sparse_mem_map_populate(pnum, nid, altmap);
+	return __populate_section_memmap(pfn, nr_pages, nid, altmap);
 }
-static void __kfree_section_memmap(struct page *memmap,
+
+static void depopulate_section_memmap(unsigned long pfn, unsigned long nr_pages,
 		struct vmem_altmap *altmap)
 {
-	unsigned long start = (unsigned long)memmap;
-	unsigned long end = (unsigned long)(memmap + PAGES_PER_SECTION);
+	unsigned long start = (unsigned long) pfn_to_page(pfn);
+	unsigned long end = start + nr_pages * sizeof(struct page);
 
 	vmemmap_free(start, end, altmap);
 }
@@ -646,11 +649,18 @@ static void free_map_bootmem(struct page *memmap)
 	vmemmap_free(start, end, NULL);
 }
 #else
-static struct page *__kmalloc_section_memmap(void)
+struct page *populate_section_memmap(unsigned long pfn,
+		unsigned long nr_pages, int nid, struct vmem_altmap *altmap)
 {
 	struct page *page, *ret;
 	unsigned long memmap_size = sizeof(struct page) * PAGES_PER_SECTION;
 
+	if ((pfn & ~PAGE_SECTION_MASK) || nr_pages != PAGES_PER_SECTION) {
+		WARN(1, "%s: called with section unaligned parameters\n",
+				__func__);
+		return NULL;
+	}
+
 	page = alloc_pages(GFP_KERNEL|__GFP_NOWARN, get_order(memmap_size));
 	if (page)
 		goto got_map_page;
@@ -667,15 +677,17 @@ static struct page *__kmalloc_section_memmap(void)
 	return ret;
 }
 
-static inline struct page *kmalloc_section_memmap(unsigned long pnum, int nid,
+static void depopulate_section_memmap(unsigned long pfn, unsigned long nr_pages,
 		struct vmem_altmap *altmap)
 {
-	return __kmalloc_section_memmap();
-}
+	struct page *memmap = pfn_to_page(pfn);
+
+	if ((pfn & ~PAGE_SECTION_MASK) || nr_pages != PAGES_PER_SECTION) {
+		WARN(1, "%s: called with section unaligned parameters\n",
+				__func__);
+		return;
+	}
 
-static void __kfree_section_memmap(struct page *memmap,
-		struct vmem_altmap *altmap)
-{
 	if (is_vmalloc_addr(memmap))
 		vfree(memmap);
 	else
@@ -744,12 +756,13 @@ int __meminit sparse_add_one_section(int nid, unsigned long start_pfn,
 	if (ret < 0 && ret != -EEXIST)
 		return ret;
 	ret = 0;
-	memmap = kmalloc_section_memmap(section_nr, nid, altmap);
+	memmap = populate_section_memmap(start_pfn, PAGES_PER_SECTION, nid,
+			altmap);
 	if (!memmap)
 		return -ENOMEM;
 	usage = kzalloc(mem_section_usage_size(), GFP_KERNEL);
 	if (!usage) {
-		__kfree_section_memmap(memmap, altmap);
+		depopulate_section_memmap(start_pfn, PAGES_PER_SECTION, altmap);
 		return -ENOMEM;
 	}
 
@@ -771,7 +784,7 @@ int __meminit sparse_add_one_section(int nid, unsigned long start_pfn,
 out:
 	if (ret < 0) {
 		kfree(usage);
-		__kfree_section_memmap(memmap, altmap);
+		depopulate_section_memmap(start_pfn, PAGES_PER_SECTION, altmap);
 	}
 	return ret;
 }
@@ -807,7 +820,8 @@ static inline void clear_hwpoisoned_pages(struct page *memmap, int nr_pages)
 #endif
 
 static void free_section_usage(struct page *memmap,
-		struct mem_section_usage *usage, struct vmem_altmap *altmap)
+		struct mem_section_usage *usage, unsigned long pfn,
+		unsigned long nr_pages, struct vmem_altmap *altmap)
 {
 	struct page *usage_page;
 
@@ -821,7 +835,7 @@ static void free_section_usage(struct page *memmap,
 	if (PageSlab(usage_page) || PageCompound(usage_page)) {
 		kfree(usage);
 		if (memmap)
-			__kfree_section_memmap(memmap, altmap);
+			depopulate_section_memmap(pfn, nr_pages, altmap);
 		return;
 	}
 
@@ -850,6 +864,7 @@ void sparse_remove_one_section(struct mem_section *ms, unsigned long map_offset,
 
 	clear_hwpoisoned_pages(memmap + map_offset,
 			PAGES_PER_SECTION - map_offset);
-	free_section_usage(memmap, usage, altmap);
+	free_section_usage(memmap, usage, section_nr_to_pfn(__section_nr(ms)),
+			PAGES_PER_SECTION, altmap);
 }
 #endif /* CONFIG_MEMORY_HOTPLUG */

