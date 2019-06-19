Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5776C31E5F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 06:06:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9280A20B1F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 06:06:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731020AbfFSGGD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 02:06:03 -0400
Received: from mga17.intel.com ([192.55.52.151]:36241 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730882AbfFSGGB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 02:06:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jun 2019 23:06:00 -0700
X-IronPort-AV: E=Sophos;i="5.63,392,1557212400"; 
   d="scan'208";a="243216408"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jun 2019 23:06:00 -0700
Subject: [PATCH v10 02/13] mm/sparsemem: Introduce a SECTION_IS_EARLY flag
From:   Dan Williams <dan.j.williams@intel.com>
To:     akpm@linux-foundation.org
Cc:     Qian Cai <cai@lca.pw>, Michal Hocko <mhocko@suse.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Pavel Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
Date:   Tue, 18 Jun 2019 22:51:43 -0700
Message-ID: <156092350358.979959.5817209875548072819.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <156092349300.979959.17603710711957735135.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <156092349300.979959.17603710711957735135.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for sub-section hotplug, track whether a given section
was created during early memory initialization, or later via memory
hotplug.  This distinction is needed to maintain the coarse expectation
that pfn_valid() returns true for any pfn within a given section even if
that section has pages that are reserved from the page allocator.

For example one of the of goals of subsection hotplug is to support
cases where the system physical memory layout collides System RAM and
PMEM within a section. Several pfn_valid() users expect to just check if
a section is valid, but they are not careful to check if the given pfn
is within a "System RAM" boundary and instead expect pgdat information
to further validate the pfn.

Rather than unwind those paths to make their pfn_valid() queries more
precise a follow on patch uses the SECTION_IS_EARLY flag to maintain the
traditional expectation that pfn_valid() returns true for all early
sections.

Link: https://lore.kernel.org/lkml/1560366952-10660-1-git-send-email-cai@lca.pw/
Reported-by: Qian Cai <cai@lca.pw>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Logan Gunthorpe <logang@deltatee.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 include/linux/mmzone.h |    8 +++++++-
 mm/sparse.c            |   20 +++++++++-----------
 2 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 179680c94262..d081c9a1d25d 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1261,7 +1261,8 @@ extern size_t mem_section_usage_size(void);
 #define	SECTION_MARKED_PRESENT	(1UL<<0)
 #define SECTION_HAS_MEM_MAP	(1UL<<1)
 #define SECTION_IS_ONLINE	(1UL<<2)
-#define SECTION_MAP_LAST_BIT	(1UL<<3)
+#define SECTION_IS_EARLY	(1UL<<3)
+#define SECTION_MAP_LAST_BIT	(1UL<<4)
 #define SECTION_MAP_MASK	(~(SECTION_MAP_LAST_BIT-1))
 #define SECTION_NID_SHIFT	3
 
@@ -1287,6 +1288,11 @@ static inline int valid_section(struct mem_section *section)
 	return (section && (section->section_mem_map & SECTION_HAS_MEM_MAP));
 }
 
+static inline int early_section(struct mem_section *section)
+{
+	return (section && (section->section_mem_map & SECTION_IS_EARLY));
+}
+
 static inline int valid_section_nr(unsigned long nr)
 {
 	return valid_section(__nr_to_section(nr));
diff --git a/mm/sparse.c b/mm/sparse.c
index 71da15cc7432..2031a0694f35 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -288,11 +288,11 @@ struct page *sparse_decode_mem_map(unsigned long coded_mem_map, unsigned long pn
 
 static void __meminit sparse_init_one_section(struct mem_section *ms,
 		unsigned long pnum, struct page *mem_map,
-		struct mem_section_usage *usage)
+		struct mem_section_usage *usage, unsigned long flags)
 {
 	ms->section_mem_map &= ~SECTION_MAP_MASK;
-	ms->section_mem_map |= sparse_encode_mem_map(mem_map, pnum) |
-							SECTION_HAS_MEM_MAP;
+	ms->section_mem_map |= sparse_encode_mem_map(mem_map, pnum)
+		| SECTION_HAS_MEM_MAP | flags;
 	ms->usage = usage;
 }
 
@@ -497,7 +497,8 @@ static void __init sparse_init_nid(int nid, unsigned long pnum_begin,
 			goto failed;
 		}
 		check_usemap_section_nr(nid, usage);
-		sparse_init_one_section(__nr_to_section(pnum), pnum, map, usage);
+		sparse_init_one_section(__nr_to_section(pnum), pnum, map, usage,
+				SECTION_IS_EARLY);
 		usage = (void *) usage + mem_section_usage_size();
 	}
 	sparse_buffer_fini();
@@ -731,7 +732,7 @@ int __meminit sparse_add_one_section(int nid, unsigned long start_pfn,
 	page_init_poison(memmap, sizeof(struct page) * PAGES_PER_SECTION);
 
 	section_mark_present(ms);
-	sparse_init_one_section(ms, section_nr, memmap, usage);
+	sparse_init_one_section(ms, section_nr, memmap, usage, 0);
 
 out:
 	if (ret < 0) {
@@ -771,19 +772,16 @@ static inline void clear_hwpoisoned_pages(struct page *memmap, int nr_pages)
 }
 #endif
 
-static void free_section_usage(struct page *memmap,
+static void free_section_usage(struct mem_section *ms, struct page *memmap,
 		struct mem_section_usage *usage, struct vmem_altmap *altmap)
 {
-	struct page *usage_page;
-
 	if (!usage)
 		return;
 
-	usage_page = virt_to_page(usage);
 	/*
 	 * Check to see if allocation came from hot-plug-add
 	 */
-	if (PageSlab(usage_page) || PageCompound(usage_page)) {
+	if (!early_section(ms)) {
 		kfree(usage);
 		if (memmap)
 			__kfree_section_memmap(memmap, altmap);
@@ -815,6 +813,6 @@ void sparse_remove_one_section(struct mem_section *ms, unsigned long map_offset,
 
 	clear_hwpoisoned_pages(memmap + map_offset,
 			PAGES_PER_SECTION - map_offset);
-	free_section_usage(memmap, usage, altmap);
+	free_section_usage(ms, memmap, usage, altmap);
 }
 #endif /* CONFIG_MEMORY_HOTPLUG */

