Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68E32C4360D
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 14:31:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C5F32146E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 14:31:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437308AbfIYObY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 10:31:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:39388 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2437216AbfIYObX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 10:31:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5FAF5B60C;
        Wed, 25 Sep 2019 14:31:19 +0000 (UTC)
From:   Vlastimil Babka <vbabka@suse.cz>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, Qian Cai <cai@lca.pw>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Subject: [PATCH 1/3] mm, page_owner: fix off-by-one error in __set_page_owner_handle()
Date:   Wed, 25 Sep 2019 16:30:54 +0200
Message-Id: <20190925143056.25853-6-vbabka@suse.cz>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190925143056.25853-1-vbabka@suse.cz>
References: <20190925143056.25853-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As noted by Kirill, commit 7e2f2a0cd17c ("mm, page_owner: record page owner for
each subpage") has introduced an off-by-one error in __set_page_owner_handle()
when looking up page_ext for subpages. As a result, the head page page_owner
info is set twice, while for the last tail page, it's not set at all.

Fix this and also make the code more efficient by advancing the page_ext
pointer we already have, instead of calling lookup_page_ext() for each subpage.
Since the full size of struct page_ext is not known at compile time, we can't
use a simple page_ext++ statement, so introduce a page_ext_next() inline
function for that.

Reported-by: Kirill A. Shutemov <kirill@shutemov.name>
Fixes: 7e2f2a0cd17c ("mm, page_owner: record page owner for each subpage")
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/page_ext.h |  8 ++++++++
 mm/page_ext.c            | 23 +++++++++--------------
 mm/page_owner.c          | 15 +++++++--------
 3 files changed, 24 insertions(+), 22 deletions(-)

diff --git a/include/linux/page_ext.h b/include/linux/page_ext.h
index 682fd465df06..5e856512bafb 100644
--- a/include/linux/page_ext.h
+++ b/include/linux/page_ext.h
@@ -36,6 +36,7 @@ struct page_ext {
 	unsigned long flags;
 };
 
+extern unsigned long page_ext_size;
 extern void pgdat_page_ext_init(struct pglist_data *pgdat);
 
 #ifdef CONFIG_SPARSEMEM
@@ -52,6 +53,13 @@ static inline void page_ext_init(void)
 
 struct page_ext *lookup_page_ext(const struct page *page);
 
+static inline struct page_ext *page_ext_next(struct page_ext *curr)
+{
+	void *next = curr;
+	next += page_ext_size;
+	return next;
+}
+
 #else /* !CONFIG_PAGE_EXTENSION */
 struct page_ext;
 
diff --git a/mm/page_ext.c b/mm/page_ext.c
index 5f5769c7db3b..4ade843ff588 100644
--- a/mm/page_ext.c
+++ b/mm/page_ext.c
@@ -67,8 +67,9 @@ static struct page_ext_operations *page_ext_ops[] = {
 #endif
 };
 
+unsigned long page_ext_size = sizeof(struct page_ext);
+
 static unsigned long total_usage;
-static unsigned long extra_mem;
 
 static bool __init invoke_need_callbacks(void)
 {
@@ -78,9 +79,8 @@ static bool __init invoke_need_callbacks(void)
 
 	for (i = 0; i < entries; i++) {
 		if (page_ext_ops[i]->need && page_ext_ops[i]->need()) {
-			page_ext_ops[i]->offset = sizeof(struct page_ext) +
-						extra_mem;
-			extra_mem += page_ext_ops[i]->size;
+			page_ext_ops[i]->offset = page_ext_size;
+			page_ext_size += page_ext_ops[i]->size;
 			need = true;
 		}
 	}
@@ -99,14 +99,9 @@ static void __init invoke_init_callbacks(void)
 	}
 }
 
-static unsigned long get_entry_size(void)
-{
-	return sizeof(struct page_ext) + extra_mem;
-}
-
 static inline struct page_ext *get_entry(void *base, unsigned long index)
 {
-	return base + get_entry_size() * index;
+	return base + page_ext_size * index;
 }
 
 #if !defined(CONFIG_SPARSEMEM)
@@ -156,7 +151,7 @@ static int __init alloc_node_page_ext(int nid)
 		!IS_ALIGNED(node_end_pfn(nid), MAX_ORDER_NR_PAGES))
 		nr_pages += MAX_ORDER_NR_PAGES;
 
-	table_size = get_entry_size() * nr_pages;
+	table_size = page_ext_size * nr_pages;
 
 	base = memblock_alloc_try_nid(
 			table_size, PAGE_SIZE, __pa(MAX_DMA_ADDRESS),
@@ -234,7 +229,7 @@ static int __meminit init_section_page_ext(unsigned long pfn, int nid)
 	if (section->page_ext)
 		return 0;
 
-	table_size = get_entry_size() * PAGES_PER_SECTION;
+	table_size = page_ext_size * PAGES_PER_SECTION;
 	base = alloc_page_ext(table_size, nid);
 
 	/*
@@ -254,7 +249,7 @@ static int __meminit init_section_page_ext(unsigned long pfn, int nid)
 	 * we need to apply a mask.
 	 */
 	pfn &= PAGE_SECTION_MASK;
-	section->page_ext = (void *)base - get_entry_size() * pfn;
+	section->page_ext = (void *)base - page_ext_size * pfn;
 	total_usage += table_size;
 	return 0;
 }
@@ -267,7 +262,7 @@ static void free_page_ext(void *addr)
 		struct page *page = virt_to_page(addr);
 		size_t table_size;
 
-		table_size = get_entry_size() * PAGES_PER_SECTION;
+		table_size = page_ext_size * PAGES_PER_SECTION;
 
 		BUG_ON(PageReserved(page));
 		kmemleak_free(addr);
diff --git a/mm/page_owner.c b/mm/page_owner.c
index dee931184788..d3cf5d336ccf 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -156,10 +156,10 @@ void __reset_page_owner(struct page *page, unsigned int order)
 		handle = save_stack(GFP_NOWAIT | __GFP_NOWARN);
 #endif
 
+	page_ext = lookup_page_ext(page);
+	if (unlikely(!page_ext))
+		return;
 	for (i = 0; i < (1 << order); i++) {
-		page_ext = lookup_page_ext(page + i);
-		if (unlikely(!page_ext))
-			continue;
 		__clear_bit(PAGE_EXT_OWNER_ACTIVE, &page_ext->flags);
 #ifdef CONFIG_DEBUG_PAGEALLOC
 		if (debug_pagealloc_enabled()) {
@@ -167,6 +167,7 @@ void __reset_page_owner(struct page *page, unsigned int order)
 			page_owner->free_handle = handle;
 		}
 #endif
+		page_ext = page_ext_next(page_ext);
 	}
 }
 
@@ -186,7 +187,7 @@ static inline void __set_page_owner_handle(struct page *page,
 		__set_bit(PAGE_EXT_OWNER, &page_ext->flags);
 		__set_bit(PAGE_EXT_OWNER_ACTIVE, &page_ext->flags);
 
-		page_ext = lookup_page_ext(page + i);
+		page_ext = page_ext_next(page_ext);
 	}
 }
 
@@ -224,12 +225,10 @@ void __split_page_owner(struct page *page, unsigned int order)
 	if (unlikely(!page_ext))
 		return;
 
-	page_owner = get_page_owner(page_ext);
-	page_owner->order = 0;
-	for (i = 1; i < (1 << order); i++) {
-		page_ext = lookup_page_ext(page + i);
+	for (i = 0; i < (1 << order); i++) {
 		page_owner = get_page_owner(page_ext);
 		page_owner->order = 0;
+		page_ext = page_ext_next(page_ext);
 	}
 }
 
-- 
2.23.0

