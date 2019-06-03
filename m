Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0FBDC282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 14:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A305C27B19
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 14:35:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729059AbfFCOfO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 10:35:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:54814 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728883AbfFCOfN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 10:35:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id ECABCAD43;
        Mon,  3 Jun 2019 14:35:11 +0000 (UTC)
From:   Vlastimil Babka <vbabka@suse.cz>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 2/3] mm, page_alloc: more extensive free page checking with debug_pagealloc
Date:   Mon,  3 Jun 2019 16:34:50 +0200
Message-Id: <20190603143451.27353-3-vbabka@suse.cz>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190603143451.27353-1-vbabka@suse.cz>
References: <20190603143451.27353-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The page allocator checks struct pages for expected state (mapcount, flags etc)
as pages are being allocated (check_new_page()) and freed (free_pages_check())
to provide some defense against errors in page allocator users. Prior commits
479f854a207c ("mm, page_alloc: defer debugging checks of pages allocated from
the PCP") and 4db7548ccbd9 ("mm, page_alloc: defer debugging checks of freed
pages until a PCP drain") this has happened for order-0 pages as they were
allocated from or freed to the per-cpu caches (pcplists). Since those are fast
paths, the checks are now performed only when pages are moved between pcplists
and global free lists. This however lowers the chances of catching errors soon
enough.

In order to increase the chances of the checks to catch errors, the kernel has
to be rebuilt with CONFIG_DEBUG_VM, which also enables multiple other internal
debug checks (VM_BUG_ON() etc), which is suboptimal when the goal is to catch
errors in mm users, not in mm code itself.

To catch some wrong users of page allocator, we have CONFIG_DEBUG_PAGEALLOC,
which is designed to have virtually no overhead unless enabled at boot time.
Memory corruptions when writing to freed pages have often the same underlying
errors (use-after-free, double free) as corrupting the corresponding struct
pages, so this existing debugging functionality is a good fit to extend by
also perform struct page checks at least as often as if CONFIG_DEBUG_VM was
enabled.

Specifically, after this patch, when debug_pagealloc is enabled on boot, and
CONFIG_DEBUG_VM disabled, pages are checked when allocated from or freed to the
pcplists *in addition* to being moved between pcplists and free lists. When
both debug_pagealloc and CONFIG_DEBUG_VM are enabled, pages are checked when
being moved between pcplists and free lists *in addition* to when allocated
from or freed to the pcplists.

When debug_pagealloc is not enabled on boot, the overhead in fast paths should
be virtually none thanks to the use of static key.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
Cc: Mel Gorman <mgorman@techsingularity.net>
---
 mm/Kconfig.debug | 13 ++++++++----
 mm/page_alloc.c  | 53 +++++++++++++++++++++++++++++++++++++++---------
 2 files changed, 52 insertions(+), 14 deletions(-)

diff --git a/mm/Kconfig.debug b/mm/Kconfig.debug
index fa6d79281368..a35ab6c55192 100644
--- a/mm/Kconfig.debug
+++ b/mm/Kconfig.debug
@@ -19,12 +19,17 @@ config DEBUG_PAGEALLOC
 	  Depending on runtime enablement, this results in a small or large
 	  slowdown, but helps to find certain types of memory corruption.
 
+	  Also, the state of page tracking structures is checked more often as
+	  pages are being allocated and freed, as unexpected state changes
+	  often happen for same reasons as memory corruption (e.g. double free,
+	  use-after-free).
+
 	  For architectures which don't enable ARCH_SUPPORTS_DEBUG_PAGEALLOC,
 	  fill the pages with poison patterns after free_pages() and verify
-	  the patterns before alloc_pages().  Additionally,
-	  this option cannot be enabled in combination with hibernation as
-	  that would result in incorrect warnings of memory corruption after
-	  a resume because free pages are not saved to the suspend image.
+	  the patterns before alloc_pages(). Additionally, this option cannot
+	  be enabled in combination with hibernation as that would result in
+	  incorrect warnings of memory corruption after a resume because free
+	  pages are not saved to the suspend image.
 
 	  By default this option will have a small overhead, e.g. by not
 	  allowing the kernel mapping to be backed by large pages on some
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 639f1f9e74c5..e6248e391358 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1162,19 +1162,36 @@ static __always_inline bool free_pages_prepare(struct page *page,
 }
 
 #ifdef CONFIG_DEBUG_VM
-static inline bool free_pcp_prepare(struct page *page)
+/*
+ * With DEBUG_VM enabled, order-0 pages are checked immediately when being freed
+ * to pcp lists. With debug_pagealloc also enabled, they are also rechecked when
+ * moved from pcp lists to free lists.
+ */
+static bool free_pcp_prepare(struct page *page)
 {
 	return free_pages_prepare(page, 0, true);
 }
 
-static inline bool bulkfree_pcp_prepare(struct page *page)
+static bool bulkfree_pcp_prepare(struct page *page)
 {
-	return false;
+	if (debug_pagealloc_enabled())
+		return free_pages_check(page);
+	else
+		return false;
 }
 #else
+/*
+ * With DEBUG_VM disabled, order-0 pages being freed are checked only when
+ * moving from pcp lists to free list in order to reduce overhead. With
+ * debug_pagealloc enabled, they are checked also immediately when being freed
+ * to the pcp lists.
+ */
 static bool free_pcp_prepare(struct page *page)
 {
-	return free_pages_prepare(page, 0, false);
+	if (debug_pagealloc_enabled())
+		return free_pages_prepare(page, 0, true);
+	else
+		return free_pages_prepare(page, 0, false);
 }
 
 static bool bulkfree_pcp_prepare(struct page *page)
@@ -2036,23 +2053,39 @@ static inline bool free_pages_prezeroed(void)
 }
 
 #ifdef CONFIG_DEBUG_VM
-static bool check_pcp_refill(struct page *page)
+/*
+ * With DEBUG_VM enabled, order-0 pages are checked for expected state when
+ * being allocated from pcp lists. With debug_pagealloc also enabled, they are
+ * also checked when pcp lists are refilled from the free lists.
+ */
+static inline bool check_pcp_refill(struct page *page)
 {
-	return false;
+	if (debug_pagealloc_enabled())
+		return check_new_page(page);
+	else
+		return false;
 }
 
-static bool check_new_pcp(struct page *page)
+static inline bool check_new_pcp(struct page *page)
 {
 	return check_new_page(page);
 }
 #else
-static bool check_pcp_refill(struct page *page)
+/*
+ * With DEBUG_VM disabled, free order-0 pages are checked for expected state
+ * when pcp lists are being refilled from the free lists. With debug_pagealloc
+ * enabled, they are also checked when being allocated from the pcp lists.
+ */
+static inline bool check_pcp_refill(struct page *page)
 {
 	return check_new_page(page);
 }
-static bool check_new_pcp(struct page *page)
+static inline bool check_new_pcp(struct page *page)
 {
-	return false;
+	if (debug_pagealloc_enabled())
+		return check_new_page(page);
+	else
+		return false;
 }
 #endif /* CONFIG_DEBUG_VM */
 
-- 
2.21.0

