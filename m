Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6FC9C28CC6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 14:35:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B05D127A8E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 14:35:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729083AbfFCOfR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 10:35:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:54820 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728984AbfFCOfP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 10:35:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EDAEFAD8B;
        Mon,  3 Jun 2019 14:35:11 +0000 (UTC)
From:   Vlastimil Babka <vbabka@suse.cz>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 3/3] mm, debug_pagealloc: use a page type instead of page_ext flag
Date:   Mon,  3 Jun 2019 16:34:51 +0200
Message-Id: <20190603143451.27353-4-vbabka@suse.cz>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190603143451.27353-1-vbabka@suse.cz>
References: <20190603143451.27353-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When debug_pagealloc is enabled, we currently allocate the page_ext array to
mark guard pages with the PAGE_EXT_DEBUG_GUARD flag. Now that we have the
page_type field in struct page, we can use that instead, as guard pages are
neither PageSlab nor mapped to userspace. This reduces memory overhead when
debug_pagealloc is enabled and there are no other features requiring the
page_ext array.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: Matthew Wilcox <willy@infradead.org>
---
 .../admin-guide/kernel-parameters.txt         | 10 ++---
 include/linux/mm.h                            | 10 +----
 include/linux/page-flags.h                    |  6 +++
 include/linux/page_ext.h                      |  1 -
 mm/Kconfig.debug                              |  1 -
 mm/page_alloc.c                               | 40 +++----------------
 mm/page_ext.c                                 |  3 --
 7 files changed, 17 insertions(+), 54 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 138f6664b2e2..32003e76ba3b 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -805,12 +805,10 @@
 			tracking down these problems.
 
 	debug_pagealloc=
-			[KNL] When CONFIG_DEBUG_PAGEALLOC is set, this
-			parameter enables the feature at boot time. In
-			default, it is disabled. We can avoid allocating huge
-			chunk of memory for debug pagealloc if we don't enable
-			it at boot time and the system will work mostly same
-			with the kernel built without CONFIG_DEBUG_PAGEALLOC.
+			[KNL] When CONFIG_DEBUG_PAGEALLOC is set, this parameter
+			enables the feature at boot time. By default, it is
+			disabled and the system will work mostly the same as a
+			kernel built without CONFIG_DEBUG_PAGEALLOC.
 			on: enable the feature
 
 	debugpat	[X86] Enable PAT debugging
diff --git a/include/linux/mm.h b/include/linux/mm.h
index c71ed22769f3..2ba991e687db 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2846,8 +2846,6 @@ extern long copy_huge_page_from_user(struct page *dst_page,
 				bool allow_pagefault);
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE || CONFIG_HUGETLBFS */
 
-extern struct page_ext_operations debug_guardpage_ops;
-
 #ifdef CONFIG_DEBUG_PAGEALLOC
 extern unsigned int _debug_guardpage_minorder;
 DECLARE_STATIC_KEY_FALSE(_debug_guardpage_enabled);
@@ -2864,16 +2862,10 @@ static inline bool debug_guardpage_enabled(void)
 
 static inline bool page_is_guard(struct page *page)
 {
-	struct page_ext *page_ext;
-
 	if (!debug_guardpage_enabled())
 		return false;
 
-	page_ext = lookup_page_ext(page);
-	if (unlikely(!page_ext))
-		return false;
-
-	return test_bit(PAGE_EXT_DEBUG_GUARD, &page_ext->flags);
+	return PageGuard(page);
 }
 #else
 static inline unsigned int debug_guardpage_minorder(void) { return 0; }
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 9f8712a4b1a5..b848517da64c 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -703,6 +703,7 @@ PAGEFLAG_FALSE(DoubleMap)
 #define PG_offline	0x00000100
 #define PG_kmemcg	0x00000200
 #define PG_table	0x00000400
+#define PG_guard	0x00000800
 
 #define PageType(page, flag)						\
 	((page->page_type & (PAGE_TYPE_BASE | flag)) == PAGE_TYPE_BASE)
@@ -754,6 +755,11 @@ PAGE_TYPE_OPS(Kmemcg, kmemcg)
  */
 PAGE_TYPE_OPS(Table, table)
 
+/*
+ * Marks guardpages used with debug_pagealloc.
+ */
+PAGE_TYPE_OPS(Guard, guard)
+
 extern bool is_free_buddy_page(struct page *page);
 
 __PAGEFLAG(Isolated, isolated, PF_ANY);
diff --git a/include/linux/page_ext.h b/include/linux/page_ext.h
index f84f167ec04c..09592951725c 100644
--- a/include/linux/page_ext.h
+++ b/include/linux/page_ext.h
@@ -17,7 +17,6 @@ struct page_ext_operations {
 #ifdef CONFIG_PAGE_EXTENSION
 
 enum page_ext_flags {
-	PAGE_EXT_DEBUG_GUARD,
 	PAGE_EXT_OWNER,
 #if defined(CONFIG_IDLE_PAGE_TRACKING) && !defined(CONFIG_64BIT)
 	PAGE_EXT_YOUNG,
diff --git a/mm/Kconfig.debug b/mm/Kconfig.debug
index a35ab6c55192..82b6a20898bd 100644
--- a/mm/Kconfig.debug
+++ b/mm/Kconfig.debug
@@ -12,7 +12,6 @@ config DEBUG_PAGEALLOC
 	bool "Debug page memory allocations"
 	depends on DEBUG_KERNEL
 	depends on !HIBERNATION || ARCH_SUPPORTS_DEBUG_PAGEALLOC && !PPC && !SPARC
-	select PAGE_EXTENSION
 	select PAGE_POISONING if !ARCH_SUPPORTS_DEBUG_PAGEALLOC
 	---help---
 	  Unmap pages from the kernel linear mapping after free_pages().
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index e6248e391358..b178f297df68 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -50,7 +50,6 @@
 #include <linux/backing-dev.h>
 #include <linux/fault-inject.h>
 #include <linux/page-isolation.h>
-#include <linux/page_ext.h>
 #include <linux/debugobjects.h>
 #include <linux/kmemleak.h>
 #include <linux/compaction.h>
@@ -670,18 +669,6 @@ static int __init early_debug_pagealloc(char *buf)
 }
 early_param("debug_pagealloc", early_debug_pagealloc);
 
-static bool need_debug_guardpage(void)
-{
-	/* If we don't use debug_pagealloc, we don't need guard page */
-	if (!debug_pagealloc_enabled())
-		return false;
-
-	if (!debug_guardpage_minorder())
-		return false;
-
-	return true;
-}
-
 static void init_debug_guardpage(void)
 {
 	if (!debug_pagealloc_enabled())
@@ -693,11 +680,6 @@ static void init_debug_guardpage(void)
 	static_branch_enable(&_debug_guardpage_enabled);
 }
 
-struct page_ext_operations debug_guardpage_ops = {
-	.need = need_debug_guardpage,
-	.init = init_debug_guardpage,
-};
-
 static int __init debug_guardpage_minorder_setup(char *buf)
 {
 	unsigned long res;
@@ -715,20 +697,13 @@ early_param("debug_guardpage_minorder", debug_guardpage_minorder_setup);
 static inline bool set_page_guard(struct zone *zone, struct page *page,
 				unsigned int order, int migratetype)
 {
-	struct page_ext *page_ext;
-
 	if (!debug_guardpage_enabled())
 		return false;
 
 	if (order >= debug_guardpage_minorder())
 		return false;
 
-	page_ext = lookup_page_ext(page);
-	if (unlikely(!page_ext))
-		return false;
-
-	__set_bit(PAGE_EXT_DEBUG_GUARD, &page_ext->flags);
-
+	__SetPageGuard(page);
 	INIT_LIST_HEAD(&page->lru);
 	set_page_private(page, order);
 	/* Guard pages are not available for any usage */
@@ -740,23 +715,16 @@ static inline bool set_page_guard(struct zone *zone, struct page *page,
 static inline void clear_page_guard(struct zone *zone, struct page *page,
 				unsigned int order, int migratetype)
 {
-	struct page_ext *page_ext;
-
 	if (!debug_guardpage_enabled())
 		return;
 
-	page_ext = lookup_page_ext(page);
-	if (unlikely(!page_ext))
-		return;
-
-	__clear_bit(PAGE_EXT_DEBUG_GUARD, &page_ext->flags);
+	__ClearPageGuard(page);
 
 	set_page_private(page, 0);
 	if (!is_migrate_isolate(migratetype))
 		__mod_zone_freepage_state(zone, (1 << order), migratetype);
 }
 #else
-struct page_ext_operations debug_guardpage_ops;
 static inline bool set_page_guard(struct zone *zone, struct page *page,
 			unsigned int order, int migratetype) { return false; }
 static inline void clear_page_guard(struct zone *zone, struct page *page,
@@ -1931,6 +1899,10 @@ void __init page_alloc_init_late(void)
 
 	for_each_populated_zone(zone)
 		set_zone_contiguous(zone);
+
+#ifdef CONFIG_DEBUG_PAGEALLOC
+	init_debug_guardpage();
+#endif
 }
 
 #ifdef CONFIG_CMA
diff --git a/mm/page_ext.c b/mm/page_ext.c
index d8f1aca4ad43..5f5769c7db3b 100644
--- a/mm/page_ext.c
+++ b/mm/page_ext.c
@@ -59,9 +59,6 @@
  */
 
 static struct page_ext_operations *page_ext_ops[] = {
-#ifdef CONFIG_DEBUG_PAGEALLOC
-	&debug_guardpage_ops,
-#endif
 #ifdef CONFIG_PAGE_OWNER
 	&page_owner_ops,
 #endif
-- 
2.21.0

