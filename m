Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86A2FC7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 16:02:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6631B22C7B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 16:02:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388567AbfGYQCV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 12:02:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:50080 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387809AbfGYQCR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 12:02:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B6699AF74;
        Thu, 25 Jul 2019 16:02:15 +0000 (UTC)
From:   Oscar Salvador <osalvador@suse.de>
To:     akpm@linux-foundation.org
Cc:     dan.j.williams@intel.com, david@redhat.com,
        pasha.tatashin@soleen.com, mhocko@suse.com,
        anshuman.khandual@arm.com, Jonathan.Cameron@huawei.com,
        vbabka@suse.cz, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v3 2/5] mm: Introduce a new Vmemmap page-type
Date:   Thu, 25 Jul 2019 18:02:04 +0200
Message-Id: <20190725160207.19579-3-osalvador@suse.de>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20190725160207.19579-1-osalvador@suse.de>
References: <20190725160207.19579-1-osalvador@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces a new Vmemmap page-type.

It also introduces some functions to ease the handling of vmemmap pages:

- vmemmap_nr_sections: Returns the number of sections that used vmemmap.

- vmemmap_nr_pages: Allows us to retrieve the amount of vmemmap pages
  derivated from any vmemmap-page in the section. Useful for accounting
  and to know how much to we have to skip in the case where vmemmap pages
  need to be ignored.

- vmemmap_head: Returns the vmemmap head page

- SetPageVmemmap: Sets Reserved flag bit, and sets page->type to Vmemmap.
  Setting the Reserved flag bit is just for extra protection, actually
  we do not expect anyone to use these pages for anything.

- ClearPageVmemmap: Clears Reserved flag bit and page->type.
  Only used when sections containing vmemmap pages are removed.

These functions will be used for the code handling Vmemmap pages.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 include/linux/mm.h         | 17 +++++++++++++++++
 include/linux/mm_types.h   |  5 +++++
 include/linux/page-flags.h | 19 +++++++++++++++++++
 3 files changed, 41 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 45f0ab0ed4f7..432175f8f8d2 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2904,6 +2904,23 @@ static inline bool debug_guardpage_enabled(void) { return false; }
 static inline bool page_is_guard(struct page *page) { return false; }
 #endif /* CONFIG_DEBUG_PAGEALLOC */
 
+static __always_inline struct page *vmemmap_head(struct page *page)
+{
+	return (struct page *)page->vmemmap_head;
+}
+
+static __always_inline unsigned long vmemmap_nr_sections(struct page *page)
+{
+	struct page *head = vmemmap_head(page);
+	return head->vmemmap_sections;
+}
+
+static __always_inline unsigned long vmemmap_nr_pages(struct page *page)
+{
+	struct page *head = vmemmap_head(page);
+	return head->vmemmap_pages - (page - head);
+}
+
 #if MAX_NUMNODES > 1
 void __init setup_nr_node_ids(void);
 #else
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 6a7a1083b6fb..51dd227f2a6b 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -170,6 +170,11 @@ struct page {
 			 * pmem backed DAX files are mapped.
 			 */
 		};
+		struct {        /* Vmemmap pages */
+			unsigned long vmemmap_head;
+			unsigned long vmemmap_sections; /* Number of sections */
+			unsigned long vmemmap_pages;    /* Number of pages */
+		};
 
 		/** @rcu_head: You can use this to free a page by RCU. */
 		struct rcu_head rcu_head;
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index f91cb8898ff0..75f302a532f9 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -708,6 +708,7 @@ PAGEFLAG_FALSE(DoubleMap)
 #define PG_kmemcg	0x00000200
 #define PG_table	0x00000400
 #define PG_guard	0x00000800
+#define PG_vmemmap     0x00001000
 
 #define PageType(page, flag)						\
 	((page->page_type & (PAGE_TYPE_BASE | flag)) == PAGE_TYPE_BASE)
@@ -764,6 +765,24 @@ PAGE_TYPE_OPS(Table, table)
  */
 PAGE_TYPE_OPS(Guard, guard)
 
+/*
+ * Vmemmap pages refers to those pages that are used to create the memmap
+ * array, and reside within the same memory range that was hotppluged, so
+ * they are self-hosted. (see include/linux/memory_hotplug.h)
+ */
+PAGE_TYPE_OPS(Vmemmap, vmemmap)
+static __always_inline void SetPageVmemmap(struct page *page)
+{
+	__SetPageVmemmap(page);
+	__SetPageReserved(page);
+}
+
+static __always_inline void ClearPageVmemmap(struct page *page)
+{
+	__ClearPageVmemmap(page);
+	__ClearPageReserved(page);
+}
+
 extern bool is_free_buddy_page(struct page *page);
 
 __PAGEFLAG(Isolated, isolated, PF_ANY);
-- 
2.12.3

