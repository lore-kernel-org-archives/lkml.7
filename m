Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B59DC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 15:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 072D720851
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 15:31:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="O6LcbKV+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbfCGPbA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 10:31:00 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:38294 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbfCGPa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 10:30:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Message-Id:Date:Subject:Cc:To:From:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=pU459oZFuuJF3UD9IffoGHv4Mev788hiistaz2HEtG4=; b=O6LcbKV+K19yUefMx/PIhdiQz
        68wp8GkHFfdMM43kUcc3WFA0gDn65ptuKUW7UDhFTnCbzqndR6KzKx5Qzjgac7NMjTExyT4l6jLNR
        u8MQJMegZ2mpZTSwWBhU7WAHkpMDD9KowxU6yUcoVMYZkjrSZUkItugp8SFge8Js+qdVDmtj2D7+/
        3LZolgvmOFhti9CYv+7PIfO0NNhPPiX3qtfgH2egHqFLbEHG9vBN1Ac5P79kdHZ1A87GJjv9nrnMg
        mEwyhAOfq7mxvyWWORQsTQq6ATV0HFLblIoTMAFkzfO1DkQtr5oTcVPOE5Iih32AGMpCRHSc5JQFd
        u/wyQKbTA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h1uz4-0004zL-DQ; Thu, 07 Mar 2019 15:30:58 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
        Song Liu <liu.song.a23@gmail.com>
Subject: [PATCH v4] page cache: Store only head pages in i_pages
Date:   Thu,  7 Mar 2019 07:30:51 -0800
Message-Id: <20190307153051.18815-1-willy@infradead.org>
X-Mailer: git-send-email 2.14.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Transparent Huge Pages are currently stored in i_pages as pointers to
consecutive subpages.  This patch changes that to storing consecutive
pointers to the head page in preparation for storing huge pages more
efficiently in i_pages.

Large parts of this are "inspired" by Kirill's patch
https://lore.kernel.org/lkml/20170126115819.58875-2-kirill.shutemov@linux.intel.com/

Signed-off-by: Matthew Wilcox <willy@infradead.org>
Acked-by: Jan Kara <jack@suse.cz>
Reviewed-by: Kirill Shutemov <kirill@shutemov.name>
Reviewed-and-tested-by: Song Liu <songliubraving@fb.com>
Tested-by: William Kucharski <william.kucharski@oracle.com>
Reviewed-by: William Kucharski <william.kucharski@oracle.com>
---

v4: Extra tested-by and Reviewed-by tags
    Fixed a couple of comments
    Fixed a typo reported by Song
v3: Fix reporting of 'start' in find_get_pages_range() and
      find_get_pages_range_tag() (noticed by Jan)
    Fix page_cache_delete_batch() (Kirill)
    Convert migrate_page_move_mapping() (Kirill)
    Convert memfd_wait_for_pins() and memfd_tag_pins() (Kirill)
    Fix __delete_from_swap_cache() (Kirill)
v2: Rebase on top of linux-next 20190212
    Fixed a missing s/head/page/ in filemap_map_pages
    Include missing calls to xas_store() in __split_huge_page

 include/linux/pagemap.h |   9 +++
 mm/filemap.c            | 159 ++++++++++++++++------------------------
 mm/huge_memory.c        |   3 +
 mm/khugepaged.c         |   4 +-
 mm/memfd.c              |   2 +
 mm/migrate.c            |   2 +-
 mm/shmem.c              |   2 +-
 mm/swap_state.c         |   4 +-
 8 files changed, 82 insertions(+), 103 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index b477a70cc2e4..f5d0b9e69175 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -332,6 +332,15 @@ static inline struct page *grab_cache_page_nowait(struct address_space *mapping,
 			mapping_gfp_mask(mapping));
 }
 
+static inline struct page *find_subpage(struct page *page, pgoff_t offset)
+{
+	VM_BUG_ON_PAGE(PageTail(page), page);
+	VM_BUG_ON_PAGE(page->index > offset, page);
+	VM_BUG_ON_PAGE(page->index + (1 << compound_order(page)) <= offset,
+			page);
+	return page - page->index + offset;
+}
+
 struct page *find_get_entry(struct address_space *mapping, pgoff_t offset);
 struct page *find_lock_entry(struct address_space *mapping, pgoff_t offset);
 unsigned find_get_entries(struct address_space *mapping, pgoff_t start,
diff --git a/mm/filemap.c b/mm/filemap.c
index a3b4021c448f..d85bb9d7de74 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -279,11 +279,11 @@ EXPORT_SYMBOL(delete_from_page_cache);
  * @pvec: pagevec with pages to delete
  *
  * The function walks over mapping->i_pages and removes pages passed in @pvec
- * from the mapping. The function expects @pvec to be sorted by page index.
+ * from the mapping. The function expects @pvec to be sorted by page index
+ * and is optimised for it to be dense.
  * It tolerates holes in @pvec (mapping entries at those indices are not
  * modified). The function expects only THP head pages to be present in the
- * @pvec and takes care to delete all corresponding tail pages from the
- * mapping as well.
+ * @pvec.
  *
  * The function expects the i_pages lock to be held.
  */
@@ -292,40 +292,44 @@ static void page_cache_delete_batch(struct address_space *mapping,
 {
 	XA_STATE(xas, &mapping->i_pages, pvec->pages[0]->index);
 	int total_pages = 0;
-	int i = 0, tail_pages = 0;
+	int i = 0;
 	struct page *page;
 
 	mapping_set_update(&xas, mapping);
 	xas_for_each(&xas, page, ULONG_MAX) {
-		if (i >= pagevec_count(pvec) && !tail_pages)
+		if (i >= pagevec_count(pvec))
 			break;
+
+		/* A swap/dax/shadow entry got inserted? Skip it. */
 		if (xa_is_value(page))
 			continue;
-		if (!tail_pages) {
-			/*
-			 * Some page got inserted in our range? Skip it. We
-			 * have our pages locked so they are protected from
-			 * being removed.
-			 */
-			if (page != pvec->pages[i]) {
-				VM_BUG_ON_PAGE(page->index >
-						pvec->pages[i]->index, page);
-				continue;
-			}
-			WARN_ON_ONCE(!PageLocked(page));
-			if (PageTransHuge(page) && !PageHuge(page))
-				tail_pages = HPAGE_PMD_NR - 1;
+		/*
+		 * A page got inserted in our range? Skip it. We have our
+		 * pages locked so they are protected from being removed.
+		 * If we see a page whose index is higher than ours, it
+		 * means our page has been removed, which shouldn't be
+		 * possible because we're holding the PageLock.
+		 */
+		if (page != pvec->pages[i]) {
+			VM_BUG_ON_PAGE(page->index > pvec->pages[i]->index,
+					page);
+			continue;
+		}
+
+		WARN_ON_ONCE(!PageLocked(page));
+
+		if (page->index == xas.xa_index)
 			page->mapping = NULL;
-			/*
-			 * Leave page->index set: truncation lookup relies
-			 * upon it
-			 */
+		/* Leave page->index set: truncation lookup relies on it */
+
+		/*
+		 * Move to the next page in the vector if this is a regular
+		 * page or the index is of the last sub-page of this compound
+		 * page.
+		 */
+		if (page->index + (1UL << compound_order(page)) - 1 ==
+				xas.xa_index)
 			i++;
-		} else {
-			VM_BUG_ON_PAGE(page->index + HPAGE_PMD_NR - tail_pages
-					!= pvec->pages[i]->index, page);
-			tail_pages--;
-		}
 		xas_store(&xas, NULL);
 		total_pages++;
 	}
@@ -1491,7 +1495,7 @@ EXPORT_SYMBOL(page_cache_prev_miss);
 struct page *find_get_entry(struct address_space *mapping, pgoff_t offset)
 {
 	XA_STATE(xas, &mapping->i_pages, offset);
-	struct page *head, *page;
+	struct page *page;
 
 	rcu_read_lock();
 repeat:
@@ -1506,25 +1510,19 @@ struct page *find_get_entry(struct address_space *mapping, pgoff_t offset)
 	if (!page || xa_is_value(page))
 		goto out;
 
-	head = compound_head(page);
-	if (!page_cache_get_speculative(head))
+	if (!page_cache_get_speculative(page))
 		goto repeat;
 
-	/* The page was split under us? */
-	if (compound_head(page) != head) {
-		put_page(head);
-		goto repeat;
-	}
-
 	/*
-	 * Has the page moved?
+	 * Has the page moved or been split?
 	 * This is part of the lockless pagecache protocol. See
 	 * include/linux/pagemap.h for details.
 	 */
 	if (unlikely(page != xas_reload(&xas))) {
-		put_page(head);
+		put_page(page);
 		goto repeat;
 	}
+	page = find_subpage(page, offset);
 out:
 	rcu_read_unlock();
 
@@ -1696,7 +1694,6 @@ unsigned find_get_entries(struct address_space *mapping,
 
 	rcu_read_lock();
 	xas_for_each(&xas, page, ULONG_MAX) {
-		struct page *head;
 		if (xas_retry(&xas, page))
 			continue;
 		/*
@@ -1707,17 +1704,13 @@ unsigned find_get_entries(struct address_space *mapping,
 		if (xa_is_value(page))
 			goto export;
 
-		head = compound_head(page);
-		if (!page_cache_get_speculative(head))
+		if (!page_cache_get_speculative(page))
 			goto retry;
 
-		/* The page was split under us? */
-		if (compound_head(page) != head)
-			goto put_page;
-
-		/* Has the page moved? */
+		/* Has the page moved or been split? */
 		if (unlikely(page != xas_reload(&xas)))
 			goto put_page;
+		page = find_subpage(page, xas.xa_index);
 
 export:
 		indices[ret] = xas.xa_index;
@@ -1726,7 +1719,7 @@ unsigned find_get_entries(struct address_space *mapping,
 			break;
 		continue;
 put_page:
-		put_page(head);
+		put_page(page);
 retry:
 		xas_reset(&xas);
 	}
@@ -1768,33 +1761,27 @@ unsigned find_get_pages_range(struct address_space *mapping, pgoff_t *start,
 
 	rcu_read_lock();
 	xas_for_each(&xas, page, end) {
-		struct page *head;
 		if (xas_retry(&xas, page))
 			continue;
 		/* Skip over shadow, swap and DAX entries */
 		if (xa_is_value(page))
 			continue;
 
-		head = compound_head(page);
-		if (!page_cache_get_speculative(head))
+		if (!page_cache_get_speculative(page))
 			goto retry;
 
-		/* The page was split under us? */
-		if (compound_head(page) != head)
-			goto put_page;
-
-		/* Has the page moved? */
+		/* Has the page moved or been split? */
 		if (unlikely(page != xas_reload(&xas)))
 			goto put_page;
 
-		pages[ret] = page;
+		pages[ret] = find_subpage(page, xas.xa_index);
 		if (++ret == nr_pages) {
 			*start = xas.xa_index + 1;
 			goto out;
 		}
 		continue;
 put_page:
-		put_page(head);
+		put_page(page);
 retry:
 		xas_reset(&xas);
 	}
@@ -1839,7 +1826,6 @@ unsigned find_get_pages_contig(struct address_space *mapping, pgoff_t index,
 
 	rcu_read_lock();
 	for (page = xas_load(&xas); page; page = xas_next(&xas)) {
-		struct page *head;
 		if (xas_retry(&xas, page))
 			continue;
 		/*
@@ -1849,24 +1835,19 @@ unsigned find_get_pages_contig(struct address_space *mapping, pgoff_t index,
 		if (xa_is_value(page))
 			break;
 
-		head = compound_head(page);
-		if (!page_cache_get_speculative(head))
+		if (!page_cache_get_speculative(page))
 			goto retry;
 
-		/* The page was split under us? */
-		if (compound_head(page) != head)
-			goto put_page;
-
-		/* Has the page moved? */
+		/* Has the page moved or been split? */
 		if (unlikely(page != xas_reload(&xas)))
 			goto put_page;
 
-		pages[ret] = page;
+		pages[ret] = find_subpage(page, xas.xa_index);
 		if (++ret == nr_pages)
 			break;
 		continue;
 put_page:
-		put_page(head);
+		put_page(page);
 retry:
 		xas_reset(&xas);
 	}
@@ -1902,7 +1883,6 @@ unsigned find_get_pages_range_tag(struct address_space *mapping, pgoff_t *index,
 
 	rcu_read_lock();
 	xas_for_each_marked(&xas, page, end, tag) {
-		struct page *head;
 		if (xas_retry(&xas, page))
 			continue;
 		/*
@@ -1913,26 +1893,21 @@ unsigned find_get_pages_range_tag(struct address_space *mapping, pgoff_t *index,
 		if (xa_is_value(page))
 			continue;
 
-		head = compound_head(page);
-		if (!page_cache_get_speculative(head))
+		if (!page_cache_get_speculative(page))
 			goto retry;
 
-		/* The page was split under us? */
-		if (compound_head(page) != head)
-			goto put_page;
-
-		/* Has the page moved? */
+		/* Has the page moved or been split? */
 		if (unlikely(page != xas_reload(&xas)))
 			goto put_page;
 
-		pages[ret] = page;
+		pages[ret] = find_subpage(page, xas.xa_index);
 		if (++ret == nr_pages) {
 			*index = xas.xa_index + 1;
 			goto out;
 		}
 		continue;
 put_page:
-		put_page(head);
+		put_page(page);
 retry:
 		xas_reset(&xas);
 	}
@@ -1981,7 +1956,6 @@ unsigned find_get_entries_tag(struct address_space *mapping, pgoff_t start,
 
 	rcu_read_lock();
 	xas_for_each_marked(&xas, page, ULONG_MAX, tag) {
-		struct page *head;
 		if (xas_retry(&xas, page))
 			continue;
 		/*
@@ -1992,17 +1966,13 @@ unsigned find_get_entries_tag(struct address_space *mapping, pgoff_t start,
 		if (xa_is_value(page))
 			goto export;
 
-		head = compound_head(page);
-		if (!page_cache_get_speculative(head))
+		if (!page_cache_get_speculative(page))
 			goto retry;
 
-		/* The page was split under us? */
-		if (compound_head(page) != head)
-			goto put_page;
-
-		/* Has the page moved? */
+		/* Has the page moved or been split? */
 		if (unlikely(page != xas_reload(&xas)))
 			goto put_page;
+		page = find_subpage(page, xas.xa_index);
 
 export:
 		indices[ret] = xas.xa_index;
@@ -2011,7 +1981,7 @@ unsigned find_get_entries_tag(struct address_space *mapping, pgoff_t start,
 			break;
 		continue;
 put_page:
-		put_page(head);
+		put_page(page);
 retry:
 		xas_reset(&xas);
 	}
@@ -2633,7 +2603,7 @@ void filemap_map_pages(struct vm_fault *vmf,
 	pgoff_t last_pgoff = start_pgoff;
 	unsigned long max_idx;
 	XA_STATE(xas, &mapping->i_pages, start_pgoff);
-	struct page *head, *page;
+	struct page *page;
 
 	rcu_read_lock();
 	xas_for_each(&xas, page, end_pgoff) {
@@ -2642,24 +2612,19 @@ void filemap_map_pages(struct vm_fault *vmf,
 		if (xa_is_value(page))
 			goto next;
 
-		head = compound_head(page);
-
 		/*
 		 * Check for a locked page first, as a speculative
 		 * reference may adversely influence page migration.
 		 */
-		if (PageLocked(head))
+		if (PageLocked(page))
 			goto next;
-		if (!page_cache_get_speculative(head))
+		if (!page_cache_get_speculative(page))
 			goto next;
 
-		/* The page was split under us? */
-		if (compound_head(page) != head)
-			goto skip;
-
-		/* Has the page moved? */
+		/* Has the page moved or been split? */
 		if (unlikely(page != xas_reload(&xas)))
 			goto skip;
+		page = find_subpage(page, xas.xa_index);
 
 		if (!PageUptodate(page) ||
 				PageReadahead(page) ||
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 404acdcd0455..aaf88f85d492 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2456,6 +2456,9 @@ static void __split_huge_page(struct page *page, struct list_head *list,
 			if (IS_ENABLED(CONFIG_SHMEM) && PageSwapBacked(head))
 				shmem_uncharge(head->mapping->host, 1);
 			put_page(head + i);
+		} else if (!PageAnon(page)) {
+			__xa_store(&head->mapping->i_pages, head[i].index,
+					head + i, 0);
 		}
 	}
 
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 449044378782..7ba7a1e4fa79 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1374,7 +1374,7 @@ static void collapse_shmem(struct mm_struct *mm,
 				result = SCAN_FAIL;
 				goto xa_locked;
 			}
-			xas_store(&xas, new_page + (index % HPAGE_PMD_NR));
+			xas_store(&xas, new_page);
 			nr_none++;
 			continue;
 		}
@@ -1450,7 +1450,7 @@ static void collapse_shmem(struct mm_struct *mm,
 		list_add_tail(&page->lru, &pagelist);
 
 		/* Finally, replace with the new page. */
-		xas_store(&xas, new_page + (index % HPAGE_PMD_NR));
+		xas_store(&xas, new_page);
 		continue;
 out_unlock:
 		unlock_page(page);
diff --git a/mm/memfd.c b/mm/memfd.c
index 650e65a46b9c..2647c898990c 100644
--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -39,6 +39,7 @@ static void memfd_tag_pins(struct xa_state *xas)
 	xas_for_each(xas, page, ULONG_MAX) {
 		if (xa_is_value(page))
 			continue;
+		page = find_subpage(page, xas->xa_index);
 		if (page_count(page) - page_mapcount(page) > 1)
 			xas_set_mark(xas, MEMFD_TAG_PINNED);
 
@@ -88,6 +89,7 @@ static int memfd_wait_for_pins(struct address_space *mapping)
 			bool clear = true;
 			if (xa_is_value(page))
 				continue;
+			page = find_subpage(page, xas.xa_index);
 			if (page_count(page) - page_mapcount(page) != 1) {
 				/*
 				 * On the last scan, we clean up all those tags
diff --git a/mm/migrate.c b/mm/migrate.c
index ac6f4939bb59..1ce24fc3af27 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -465,7 +465,7 @@ int migrate_page_move_mapping(struct address_space *mapping,
 
 		for (i = 1; i < HPAGE_PMD_NR; i++) {
 			xas_next(&xas);
-			xas_store(&xas, newpage + i);
+			xas_store(&xas, newpage);
 		}
 	}
 
diff --git a/mm/shmem.c b/mm/shmem.c
index b3db3779a30a..3a4b74cb4f14 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -614,7 +614,7 @@ static int shmem_add_to_page_cache(struct page *page,
 		if (xas_error(&xas))
 			goto unlock;
 next:
-		xas_store(&xas, page + i);
+		xas_store(&xas, page);
 		if (++i < nr) {
 			xas_next(&xas);
 			goto next;
diff --git a/mm/swap_state.c b/mm/swap_state.c
index 85245fdec8d9..eb714165afd2 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -132,7 +132,7 @@ int add_to_swap_cache(struct page *page, swp_entry_t entry, gfp_t gfp)
 		for (i = 0; i < nr; i++) {
 			VM_BUG_ON_PAGE(xas.xa_index != idx + i, page);
 			set_page_private(page + i, entry.val + i);
-			xas_store(&xas, page + i);
+			xas_store(&xas, page);
 			xas_next(&xas);
 		}
 		address_space->nrpages += nr;
@@ -167,7 +167,7 @@ void __delete_from_swap_cache(struct page *page, swp_entry_t entry)
 
 	for (i = 0; i < nr; i++) {
 		void *entry = xas_store(&xas, NULL);
-		VM_BUG_ON_PAGE(entry != page + i, entry);
+		VM_BUG_ON_PAGE(entry != page, entry);
 		set_page_private(page + i, 0);
 		xas_next(&xas);
 	}
-- 
2.20.1

