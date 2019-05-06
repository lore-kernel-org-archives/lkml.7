Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7469C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 23:53:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0E9420C01
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 23:53:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbfEFXxa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 19:53:30 -0400
Received: from mga12.intel.com ([192.55.52.136]:21846 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726452AbfEFXx3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 19:53:29 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 May 2019 16:53:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,439,1549958400"; 
   d="scan'208";a="147053295"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga008.fm.intel.com with ESMTP; 06 May 2019 16:53:28 -0700
Subject: [PATCH v8 03/12] mm/sparsemem: Add helpers track active portions of
 a section at boot
From:   Dan Williams <dan.j.williams@intel.com>
To:     akpm@linux-foundation.org
Cc:     Michal Hocko <mhocko@suse.com>, Vlastimil Babka <vbabka@suse.cz>,
        Logan Gunthorpe <logang@deltatee.com>,
        Oscar Salvador <osalvador@suse.de>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Jane Chu <jane.chu@oracle.com>, linux-nvdimm@lists.01.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        osalvador@suse.de, mhocko@suse.com
Date:   Mon, 06 May 2019 16:39:42 -0700
Message-ID: <155718598213.130019.10989541248734713186.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <155718596657.130019.17139634728875079809.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <155718596657.130019.17139634728875079809.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare for hot{plug,remove} of sub-ranges of a section by tracking a
sub-section active bitmask, each bit representing a PMD_SIZE span of the
architecture's memory hotplug section size.

The implications of a partially populated section is that pfn_valid()
needs to go beyond a valid_section() check and read the sub-section
active ranges from the bitmask. The expectation is that the bitmask
(subsection_map) fits in the same cacheline as the valid_section() data,
so the incremental performance overhead to pfn_valid() should be
negligible.

Cc: Michal Hocko <mhocko@suse.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Logan Gunthorpe <logang@deltatee.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
Tested-by: Jane Chu <jane.chu@oracle.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 include/linux/mmzone.h |   29 ++++++++++++++++++++++++++++-
 mm/page_alloc.c        |    4 +++-
 mm/sparse.c            |   29 +++++++++++++++++++++++++++++
 3 files changed, 60 insertions(+), 2 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index ac163f2f274f..6dd52d544857 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1199,6 +1199,8 @@ struct mem_section_usage {
 	unsigned long pageblock_flags[0];
 };
 
+void subsection_map_init(unsigned long pfn, unsigned long nr_pages);
+
 struct page;
 struct page_ext;
 struct mem_section {
@@ -1336,12 +1338,36 @@ static inline struct mem_section *__pfn_to_section(unsigned long pfn)
 
 extern int __highest_present_section_nr;
 
+static inline int subsection_map_index(unsigned long pfn)
+{
+	return (pfn & ~(PAGE_SECTION_MASK)) / PAGES_PER_SUBSECTION;
+}
+
+#ifdef CONFIG_SPARSEMEM_VMEMMAP
+static inline int pfn_section_valid(struct mem_section *ms, unsigned long pfn)
+{
+	int idx = subsection_map_index(pfn);
+
+	return test_bit(idx, ms->usage->subsection_map);
+}
+#else
+static inline int pfn_section_valid(struct mem_section *ms, unsigned long pfn)
+{
+	return 1;
+}
+#endif
+
 #ifndef CONFIG_HAVE_ARCH_PFN_VALID
 static inline int pfn_valid(unsigned long pfn)
 {
+	struct mem_section *ms;
+
 	if (pfn_to_section_nr(pfn) >= NR_MEM_SECTIONS)
 		return 0;
-	return valid_section(__nr_to_section(pfn_to_section_nr(pfn)));
+	ms = __nr_to_section(pfn_to_section_nr(pfn));
+	if (!valid_section(ms))
+		return 0;
+	return pfn_section_valid(ms, pfn);
 }
 #endif
 
@@ -1373,6 +1399,7 @@ void sparse_init(void);
 #define sparse_init()	do {} while (0)
 #define sparse_index_init(_sec, _nid)  do {} while (0)
 #define pfn_present pfn_valid
+#define subsection_map_init(_pfn, _nr_pages) do {} while (0)
 #endif /* CONFIG_SPARSEMEM */
 
 /*
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 61c2b54a5b61..13816c5a51eb 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7291,10 +7291,12 @@ void __init free_area_init_nodes(unsigned long *max_zone_pfn)
 
 	/* Print out the early node map */
 	pr_info("Early memory node ranges\n");
-	for_each_mem_pfn_range(i, MAX_NUMNODES, &start_pfn, &end_pfn, &nid)
+	for_each_mem_pfn_range(i, MAX_NUMNODES, &start_pfn, &end_pfn, &nid) {
 		pr_info("  node %3d: [mem %#018Lx-%#018Lx]\n", nid,
 			(u64)start_pfn << PAGE_SHIFT,
 			((u64)end_pfn << PAGE_SHIFT) - 1);
+		subsection_map_init(start_pfn, end_pfn - start_pfn);
+	}
 
 	/* Initialise every node */
 	mminit_verify_pageflags_layout();
diff --git a/mm/sparse.c b/mm/sparse.c
index f87de7ad32c8..ac47a48050c7 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -210,6 +210,35 @@ static inline unsigned long first_present_section_nr(void)
 	return next_present_section_nr(-1);
 }
 
+void subsection_map_init(unsigned long pfn, unsigned long nr_pages)
+{
+	int end_sec = pfn_to_section_nr(pfn + nr_pages - 1);
+	int i, start_sec = pfn_to_section_nr(pfn);
+
+	if (!nr_pages)
+		return;
+
+	for (i = start_sec; i <= end_sec; i++) {
+		int idx, end;
+		unsigned long pfns;
+		struct mem_section *ms;
+
+		idx = subsection_map_index(pfn);
+		pfns = min(nr_pages, PAGES_PER_SECTION
+				- (pfn & ~PAGE_SECTION_MASK));
+		end = subsection_map_index(pfn + pfns - 1);
+
+		ms = __nr_to_section(i);
+		bitmap_set(ms->usage->subsection_map, idx, end - idx + 1);
+
+		pr_debug("%s: sec: %d pfns: %ld set(%d, %d)\n", __func__, i,
+				pfns, idx, end - idx + 1);
+
+		pfn += pfns;
+		nr_pages -= pfns;
+	}
+}
+
 /* Record a memory area against a node. */
 void __init memory_present(int nid, unsigned long start, unsigned long end)
 {

