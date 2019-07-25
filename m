Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2254AC7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 16:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3F4E2238C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 16:02:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389885AbfGYQCd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 12:02:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:50114 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388481AbfGYQCS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 12:02:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 57D71AFE1;
        Thu, 25 Jul 2019 16:02:16 +0000 (UTC)
From:   Oscar Salvador <osalvador@suse.de>
To:     akpm@linux-foundation.org
Cc:     dan.j.williams@intel.com, david@redhat.com,
        pasha.tatashin@soleen.com, mhocko@suse.com,
        anshuman.khandual@arm.com, Jonathan.Cameron@huawei.com,
        vbabka@suse.cz, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v3 3/5] mm,sparse: Add SECTION_USE_VMEMMAP flag
Date:   Thu, 25 Jul 2019 18:02:05 +0200
Message-Id: <20190725160207.19579-4-osalvador@suse.de>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20190725160207.19579-1-osalvador@suse.de>
References: <20190725160207.19579-1-osalvador@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When hot-removing memory, we need to be careful about two things:

1) Memory range must be memory_block aligned. This is what
   check_hotplug_memory_range() checks for.

2) If a range was hot-added using MHP_MEMMAP_ON_MEMORY, we need to check
   whether the caller is removing memory with the same granularity that
   it was added.

So to check against case 2), we mark all sections used by vmemmap
(not only the ones containing vmemmap pages, but all sections spanning
the memory range) with SECTION_USE_VMEMMAP.

This will allow us to do some sanity checks when in hot-remove stage.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 include/linux/memory_hotplug.h | 3 ++-
 include/linux/mmzone.h         | 8 +++++++-
 mm/memory_hotplug.c            | 2 +-
 mm/sparse.c                    | 9 +++++++--
 4 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index 45dece922d7c..6b20008d9297 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -366,7 +366,8 @@ extern void move_pfn_range_to_zone(struct zone *zone, unsigned long start_pfn,
 		unsigned long nr_pages, struct vmem_altmap *altmap);
 extern bool is_memblock_offlined(struct memory_block *mem);
 extern int sparse_add_section(int nid, unsigned long pfn,
-		unsigned long nr_pages, struct vmem_altmap *altmap);
+		unsigned long nr_pages, struct vmem_altmap *altmap,
+		bool vmemmap_section);
 extern void sparse_remove_section(struct mem_section *ms,
 		unsigned long pfn, unsigned long nr_pages,
 		unsigned long map_offset, struct vmem_altmap *altmap);
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index d77d717c620c..259c326962f5 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1254,7 +1254,8 @@ extern size_t mem_section_usage_size(void);
 #define SECTION_HAS_MEM_MAP	(1UL<<1)
 #define SECTION_IS_ONLINE	(1UL<<2)
 #define SECTION_IS_EARLY	(1UL<<3)
-#define SECTION_MAP_LAST_BIT	(1UL<<4)
+#define SECTION_USE_VMEMMAP	(1UL<<4)
+#define SECTION_MAP_LAST_BIT	(1UL<<5)
 #define SECTION_MAP_MASK	(~(SECTION_MAP_LAST_BIT-1))
 #define SECTION_NID_SHIFT	3
 
@@ -1265,6 +1266,11 @@ static inline struct page *__section_mem_map_addr(struct mem_section *section)
 	return (struct page *)map;
 }
 
+static inline int vmemmap_section(struct mem_section *section)
+{
+	return (section && (section->section_mem_map & SECTION_USE_VMEMMAP));
+}
+
 static inline int present_section(struct mem_section *section)
 {
 	return (section && (section->section_mem_map & SECTION_MARKED_PRESENT));
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 3d97c3711333..c2338703ce80 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -314,7 +314,7 @@ int __ref __add_pages(int nid, unsigned long pfn, unsigned long nr_pages,
 
 		pfns = min(nr_pages, PAGES_PER_SECTION
 				- (pfn & ~PAGE_SECTION_MASK));
-		err = sparse_add_section(nid, pfn, pfns, altmap);
+		err = sparse_add_section(nid, pfn, pfns, altmap, 0);
 		if (err)
 			break;
 		pfn += pfns;
diff --git a/mm/sparse.c b/mm/sparse.c
index 79355a86064f..09cac39e39d9 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -856,13 +856,18 @@ static struct page * __meminit section_activate(int nid, unsigned long pfn,
  * * -ENOMEM	- Out of memory.
  */
 int __meminit sparse_add_section(int nid, unsigned long start_pfn,
-		unsigned long nr_pages, struct vmem_altmap *altmap)
+		unsigned long nr_pages, struct vmem_altmap *altmap,
+		bool vmemmap_section)
 {
 	unsigned long section_nr = pfn_to_section_nr(start_pfn);
+	unsigned long flags = 0;
 	struct mem_section *ms;
 	struct page *memmap;
 	int ret;
 
+	if (vmemmap_section)
+		flags = SECTION_USE_VMEMMAP;
+
 	ret = sparse_index_init(section_nr, nid);
 	if (ret < 0)
 		return ret;
@@ -884,7 +889,7 @@ int __meminit sparse_add_section(int nid, unsigned long start_pfn,
 	/* Align memmap to section boundary in the subsection case */
 	if (section_nr_to_pfn(section_nr) != start_pfn)
 		memmap = pfn_to_kaddr(section_nr_to_pfn(section_nr));
-	sparse_init_one_section(ms, section_nr, memmap, ms->usage, 0);
+	sparse_init_one_section(ms, section_nr, memmap, ms->usage, flags);
 
 	return 0;
 }
-- 
2.12.3

