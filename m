Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C69F7FA3735
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 14:22:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EAB1214E0
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 14:22:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440220AbfJQOWE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 10:22:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:40608 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2440094AbfJQOVi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 10:21:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DEC3FB447;
        Thu, 17 Oct 2019 14:21:36 +0000 (UTC)
From:   Oscar Salvador <osalvador@suse.de>
To:     n-horiguchi@ah.jp.nec.com
Cc:     mhocko@kernel.org, mike.kravetz@oracle.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: [RFC PATCH v2 12/16] mm,hwpoison: Refactor soft_offline_huge_page and __soft_offline_page
Date:   Thu, 17 Oct 2019 16:21:19 +0200
Message-Id: <20191017142123.24245-13-osalvador@suse.de>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20191017142123.24245-1-osalvador@suse.de>
References: <20191017142123.24245-1-osalvador@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Merging soft_offline_huge_page and __soft_offline_page let us get rid of
quite some duplicated code, and makes the code much easier to follow.

Now, __soft_offline_page will handle both normal and hugetlb pages.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 mm/memory-failure.c | 175 ++++++++++++++++++++++++----------------------------
 1 file changed, 79 insertions(+), 96 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 9b40cf1cb4fc..48eb314598e0 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -80,13 +80,33 @@ EXPORT_SYMBOL_GPL(hwpoison_filter_flags_value);
 
 extern bool take_page_off_buddy(struct page *page);
 
-static void page_handle_poison(struct page *page, bool release)
+static bool page_handle_poison(struct page *page, bool hugepage_or_freepage, bool release)
 {
+	if (hugepage_or_freepage) {
+		/*
+		 * Doing this check for free pages is also fine since dissolve_free_huge_page
+		 * returns 0 for non-hugetlb pages as well.
+		 */
+		if (dissolve_free_huge_page(page) || !take_page_off_buddy(page))
+			/*
+			 * The hugetlb page can end up being enqueued back into
+			 * the freelists by means of:
+			 * unmap_and_move_huge_page
+			 *  putback_active_hugepage
+			 *   put_page->free_huge_page
+			 *    enqueue_huge_page
+			 * If this happens, we might lose the race against an allocation.
+			 */
+			return false;
+	}
+
 	SetPageHWPoison(page);
 	if (release)
 		put_page(page);
 	page_ref_inc(page);
 	num_poisoned_pages_inc();
+
+	return true;
 }
 
 static int hwpoison_filter_dev(struct page *p)
@@ -1673,63 +1693,51 @@ static int get_any_page(struct page *page, unsigned long pfn)
 	return ret;
 }
 
-static int soft_offline_huge_page(struct page *page)
+static bool isolate_page(struct page *page, struct list_head *pagelist)
 {
-	int ret;
-	unsigned long pfn = page_to_pfn(page);
-	struct page *hpage = compound_head(page);
-	LIST_HEAD(pagelist);
+	bool isolated = false;
+	bool lru = PageLRU(page);
 
-	/*
-	 * This double-check of PageHWPoison is to avoid the race with
-	 * memory_failure(). See also comment in __soft_offline_page().
-	 */
-	lock_page(hpage);
-	if (PageHWPoison(hpage)) {
-		unlock_page(hpage);
-		put_page(hpage);
-		pr_info("soft offline: %#lx hugepage already poisoned\n", pfn);
-		return -EBUSY;
+	if (PageHuge(page)) {
+		isolated = isolate_huge_page(page, pagelist);
+	} else {
+		if (lru)
+			isolated = !isolate_lru_page(page);
+		else
+			isolated = !isolate_movable_page(page, ISOLATE_UNEVICTABLE);
+
+		if (isolated)
+			list_add(&page->lru, pagelist);
 	}
-	unlock_page(hpage);
 
-	ret = isolate_huge_page(hpage, &pagelist);
+	if (isolated && lru)
+		inc_node_page_state(page, NR_ISOLATED_ANON +
+				    page_is_file_cache(page));
+
 	/*
-	 * get_any_page() and isolate_huge_page() takes a refcount each,
-	 * so need to drop one here.
+	 * If we succeed to isolate the page, we grabbed another refcount on
+	 * the page, so we can safely drop the one we got from get_any_pages().
+	 * If we failed to isolate the page, it means that we cannot go further
+	 * and we will return an error, so drop the reference we got from
+	 * get_any_pages() as well.
 	 */
-	put_page(hpage);
-	if (!ret) {
-		pr_info("soft offline: %#lx hugepage failed to isolate\n", pfn);
-		return -EBUSY;
-	}
-
-	ret = migrate_pages(&pagelist, new_page, NULL, MPOL_MF_MOVE_ALL,
-				MIGRATE_SYNC, MR_MEMORY_FAILURE);
-	if (ret) {
-		pr_info("soft offline: %#lx: hugepage migration failed %d, type %lx (%pGp)\n",
-			pfn, ret, page->flags, &page->flags);
-		if (!list_empty(&pagelist))
-			putback_movable_pages(&pagelist);
-		if (ret > 0)
-			ret = -EIO;
-	} else {
-		/*
-		 * We set PG_hwpoison only when we were able to take the page
-		 * off the buddy.
-		 */
-		if (!dissolve_free_huge_page(page) && take_page_off_buddy(page))
-			page_handle_poison(page, false);
-		else
-			ret = -EBUSY;
-	}
-	return ret;
+	put_page(page);
+	return isolated;
 }
 
+/*
+ * __soft_offline_page handles hugetlb-pages and non-hugetlb pages.
+ * If the page is a non-dirty unmapped page-cache page, it simply invalidates.
+ * If the page is mapped, it migrates the contents over.
+ */
 static int __soft_offline_page(struct page *page)
 {
-	int ret;
+	int ret = 0;
 	unsigned long pfn = page_to_pfn(page);
+	struct page *hpage = compound_head(page);
+	const char *msg_page[] = { "page", "hugepage"};
+	bool huge = PageHuge(page);
+	LIST_HEAD(pagelist);
 
 	/*
 	 * Check PageHWPoison again inside page lock because PageHWPoison
@@ -1738,98 +1746,73 @@ static int __soft_offline_page(struct page *page)
 	 * so there's no race between soft_offline_page() and memory_failure().
 	 */
 	lock_page(page);
-	wait_on_page_writeback(page);
+	if (!PageHuge(page))
+		wait_on_page_writeback(page);
 	if (PageHWPoison(page)) {
 		unlock_page(page);
 		put_page(page);
 		pr_info("soft offline: %#lx page already poisoned\n", pfn);
 		return -EBUSY;
 	}
-	/*
-	 * Try to invalidate first. This should work for
-	 * non dirty unmapped page cache pages.
-	 */
-	ret = invalidate_inode_page(page);
+
+	if (!PageHuge(page))
+		/*
+		 * Try to invalidate first. This should work for
+		 * non dirty unmapped page cache pages.
+		 */
+		ret = invalidate_inode_page(page);
 	unlock_page(page);
+
 	/*
 	 * RED-PEN would be better to keep it isolated here, but we
 	 * would need to fix isolation locking first.
 	 */
-	if (ret == 1) {
+	if (ret) {
 		pr_info("soft_offline: %#lx: invalidated\n", pfn);
-		page_handle_poison(page, true);
+		page_handle_poison(page, false, true);
 		return 0;
 	}
 
-	/*
-	 * Simple invalidation didn't work.
-	 * Try to migrate to a new page instead. migrate.c
-	 * handles a large number of cases for us.
-	 */
-	if (PageLRU(page))
-		ret = isolate_lru_page(page);
-	else
-		ret = isolate_movable_page(page, ISOLATE_UNEVICTABLE);
-	/*
-	 * Drop page reference which is came from get_any_page()
-	 * successful isolate_lru_page() already took another one.
-	 */
-	put_page(page);
-	if (!ret) {
-		LIST_HEAD(pagelist);
-		/*
-		 * After isolated lru page, the PageLRU will be cleared,
-		 * so use !__PageMovable instead for LRU page's mapping
-		 * cannot have PAGE_MAPPING_MOVABLE.
-		 */
-		if (!__PageMovable(page))
-			inc_node_page_state(page, NR_ISOLATED_ANON +
-						page_is_file_cache(page));
-		list_add(&page->lru, &pagelist);
+	if (isolate_page(hpage, &pagelist)) {
 		ret = migrate_pages(&pagelist, new_page, NULL, MPOL_MF_MOVE_ALL,
 					MIGRATE_SYNC, MR_MEMORY_FAILURE);
 		if (!ret) {
-			page_handle_poison(page, true);
+			bool release = !huge;
+			if (!page_handle_poison(page, true, release))
+				ret = -EBUSY;
 		} else {
 			if (!list_empty(&pagelist))
 				putback_movable_pages(&pagelist);
 
-			pr_info("soft offline: %#lx: migration failed %d, type %lx (%pGp)\n",
-				pfn, ret, page->flags, &page->flags);
+			pr_info("soft offline: %#lx: %s migration failed %d, type %lx (%pGp)\n",
+				 pfn, msg_page[huge], ret, page->flags, &page->flags);
 			if (ret > 0)
 				ret = -EIO;
 		}
 	} else {
-		pr_info("soft offline: %#lx: isolation failed: %d, page count %d, type %lx (%pGp)\n",
-			pfn, ret, page_count(page), page->flags, &page->flags);
+		pr_info("soft offline: %#lx: %s isolation failed: %d, page count %d, type %lx (%pGp)\n",
+			 pfn, msg_page[huge], ret, page_count(page), page->flags, &page->flags);
 	}
 	return ret;
 }
 
 static int soft_offline_in_use_page(struct page *page)
 {
-	int ret;
 	struct page *hpage = compound_head(page);
 
 	if (!PageHuge(page) && PageTransHuge(hpage))
 		if (try_to_split_thp_page(page, "soft offline") < 0)
 			return -EBUSY;
 
-	if (PageHuge(page))
-		ret = soft_offline_huge_page(page);
-	else
-		ret = __soft_offline_page(page);
-	return ret;
+	return __soft_offline_page(page);
 }
 
 static int soft_offline_free_page(struct page *page)
 {
-	int rc = -EBUSY;
+	int rc = 0;
 
-	if (!dissolve_free_huge_page(page) && take_page_off_buddy(page)) {
-		page_handle_poison(page, false);
-		rc = 0;
-	}
+	if (!page_handle_poison(page, true, false))
+		rc = -EBUSY;
 
 	return rc;
 }
-- 
2.12.3

