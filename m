Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54285C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:11:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C107206B8
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554138670;
	bh=fsg/7RqCgASI01202yrL2VV+4xPt6e8J4U605tcOrgM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oClgrd52hGKic9UiNT882SuquvY3Xs2P21rp55zZqhLXpXNvERQwirGvRrRJFWE98
	 b4cqP1gC+wTnmeTjVHm2+dg2A7o4nj2tFhH/coOJiyrts1Zd0uHVwGRP+KTo4IyulZ
	 VixHXszr6vUfSIGiTb4gAEwvbipMNAcaUzfnEU/Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730131AbfDARLJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:11:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:59320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730089AbfDARLF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:11:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C2B3206B8;
        Mon,  1 Apr 2019 17:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554138663;
        bh=fsg/7RqCgASI01202yrL2VV+4xPt6e8J4U605tcOrgM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DuT6DR9vvTLoKC/0g8W9fllGXCBZnx6uwpMm2BKz4qmRbwqHhdmvSRnje+yC0Vi+z
         iXF5UFzq5gYTXFni9J3DHS/gVbBCST6lc73sAftBmt5yU/cD3DlvgeHo7xwrcA9KQu
         pPqy2P+a7VQStsJ1GL7ERByJNJCO7CyumWUyGSas=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Qian Cai <cai@lca.pw>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 5.0 125/146] mm/hotplug: fix offline undo_isolate_page_range()
Date:   Mon,  1 Apr 2019 19:02:17 +0200
Message-Id: <20190401170058.866105463@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170048.449559024@linuxfoundation.org>
References: <20190401170048.449559024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Qian Cai <cai@lca.pw>

commit 9b7ea46a82b31c74a37e6ff1c2a1df7d53e392ab upstream.

Commit f1dd2cd13c4b ("mm, memory_hotplug: do not associate hotadded
memory to zones until online") introduced move_pfn_range_to_zone() which
calls memmap_init_zone() during onlining a memory block.
memmap_init_zone() will reset pagetype flags and makes migrate type to
be MOVABLE.

However, in __offline_pages(), it also call undo_isolate_page_range()
after offline_isolated_pages() to do the same thing.  Due to commit
2ce13640b3f4 ("mm: __first_valid_page skip over offline pages") changed
__first_valid_page() to skip offline pages, undo_isolate_page_range()
here just waste CPU cycles looping around the offlining PFN range while
doing nothing, because __first_valid_page() will return NULL as
offline_isolated_pages() has already marked all memory sections within
the pfn range as offline via offline_mem_sections().

Also, after calling the "useless" undo_isolate_page_range() here, it
reaches the point of no returning by notifying MEM_OFFLINE.  Those pages
will be marked as MIGRATE_MOVABLE again once onlining.  The only thing
left to do is to decrease the number of isolated pageblocks zone counter
which would make some paths of the page allocation slower that the above
commit introduced.

Even if alloc_contig_range() can be used to isolate 16GB-hugetlb pages
on ppc64, an "int" should still be enough to represent the number of
pageblocks there.  Fix an incorrect comment along the way.

[cai@lca.pw: v4]
  Link: http://lkml.kernel.org/r/20190314150641.59358-1-cai@lca.pw
Link: http://lkml.kernel.org/r/20190313143133.46200-1-cai@lca.pw
Fixes: 2ce13640b3f4 ("mm: __first_valid_page skip over offline pages")
Signed-off-by: Qian Cai <cai@lca.pw>
Acked-by: Michal Hocko <mhocko@suse.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: <stable@vger.kernel.org>	[4.13+]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/page-isolation.h |   10 --------
 mm/memory_hotplug.c            |   17 +++++++++++---
 mm/page_alloc.c                |    2 -
 mm/page_isolation.c            |   48 +++++++++++++++++++++++++----------------
 mm/sparse.c                    |    2 -
 5 files changed, 45 insertions(+), 34 deletions(-)

--- a/include/linux/page-isolation.h
+++ b/include/linux/page-isolation.h
@@ -41,16 +41,6 @@ int move_freepages_block(struct zone *zo
 
 /*
  * Changes migrate type in [start_pfn, end_pfn) to be MIGRATE_ISOLATE.
- * If specified range includes migrate types other than MOVABLE or CMA,
- * this will fail with -EBUSY.
- *
- * For isolating all pages in the range finally, the caller have to
- * free all pages in the range. test_page_isolated() can be used for
- * test it.
- *
- * The following flags are allowed (they can be combined in a bit mask)
- * SKIP_HWPOISON - ignore hwpoison pages
- * REPORT_FAILURE - report details about the failure to isolate the range
  */
 int
 start_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1560,7 +1560,7 @@ static int __ref __offline_pages(unsigne
 {
 	unsigned long pfn, nr_pages;
 	long offlined_pages;
-	int ret, node;
+	int ret, node, nr_isolate_pageblock;
 	unsigned long flags;
 	unsigned long valid_start, valid_end;
 	struct zone *zone;
@@ -1586,10 +1586,11 @@ static int __ref __offline_pages(unsigne
 	ret = start_isolate_page_range(start_pfn, end_pfn,
 				       MIGRATE_MOVABLE,
 				       SKIP_HWPOISON | REPORT_FAILURE);
-	if (ret) {
+	if (ret < 0) {
 		reason = "failure to isolate range";
 		goto failed_removal;
 	}
+	nr_isolate_pageblock = ret;
 
 	arg.start_pfn = start_pfn;
 	arg.nr_pages = nr_pages;
@@ -1642,8 +1643,16 @@ static int __ref __offline_pages(unsigne
 	/* Ok, all of our target is isolated.
 	   We cannot do rollback at this point. */
 	offline_isolated_pages(start_pfn, end_pfn);
-	/* reset pagetype flags and makes migrate type to be MOVABLE */
-	undo_isolate_page_range(start_pfn, end_pfn, MIGRATE_MOVABLE);
+
+	/*
+	 * Onlining will reset pagetype flags and makes migrate type
+	 * MOVABLE, so just need to decrease the number of isolated
+	 * pageblocks zone counter here.
+	 */
+	spin_lock_irqsave(&zone->lock, flags);
+	zone->nr_isolate_pageblock -= nr_isolate_pageblock;
+	spin_unlock_irqrestore(&zone->lock, flags);
+
 	/* removal success */
 	adjust_managed_page_count(pfn_to_page(start_pfn), -offlined_pages);
 	zone->present_pages -= offlined_pages;
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8160,7 +8160,7 @@ int alloc_contig_range(unsigned long sta
 
 	ret = start_isolate_page_range(pfn_max_align_down(start),
 				       pfn_max_align_up(end), migratetype, 0);
-	if (ret)
+	if (ret < 0)
 		return ret;
 
 	/*
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -160,27 +160,36 @@ __first_valid_page(unsigned long pfn, un
 	return NULL;
 }
 
-/*
- * start_isolate_page_range() -- make page-allocation-type of range of pages
- * to be MIGRATE_ISOLATE.
- * @start_pfn: The lower PFN of the range to be isolated.
- * @end_pfn: The upper PFN of the range to be isolated.
- * @migratetype: migrate type to set in error recovery.
+/**
+ * start_isolate_page_range() - make page-allocation-type of range of pages to
+ * be MIGRATE_ISOLATE.
+ * @start_pfn:		The lower PFN of the range to be isolated.
+ * @end_pfn:		The upper PFN of the range to be isolated.
+ *			start_pfn/end_pfn must be aligned to pageblock_order.
+ * @migratetype:	Migrate type to set in error recovery.
+ * @flags:		The following flags are allowed (they can be combined in
+ *			a bit mask)
+ *			SKIP_HWPOISON - ignore hwpoison pages
+ *			REPORT_FAILURE - report details about the failure to
+ *			isolate the range
  *
  * Making page-allocation-type to be MIGRATE_ISOLATE means free pages in
  * the range will never be allocated. Any free pages and pages freed in the
- * future will not be allocated again.
- *
- * start_pfn/end_pfn must be aligned to pageblock_order.
- * Return 0 on success and -EBUSY if any part of range cannot be isolated.
+ * future will not be allocated again. If specified range includes migrate types
+ * other than MOVABLE or CMA, this will fail with -EBUSY. For isolating all
+ * pages in the range finally, the caller have to free all pages in the range.
+ * test_page_isolated() can be used for test it.
  *
  * There is no high level synchronization mechanism that prevents two threads
- * from trying to isolate overlapping ranges.  If this happens, one thread
+ * from trying to isolate overlapping ranges. If this happens, one thread
  * will notice pageblocks in the overlapping range already set to isolate.
  * This happens in set_migratetype_isolate, and set_migratetype_isolate
- * returns an error.  We then clean up by restoring the migration type on
- * pageblocks we may have modified and return -EBUSY to caller.  This
+ * returns an error. We then clean up by restoring the migration type on
+ * pageblocks we may have modified and return -EBUSY to caller. This
  * prevents two threads from simultaneously working on overlapping ranges.
+ *
+ * Return: the number of isolated pageblocks on success and -EBUSY if any part
+ * of range cannot be isolated.
  */
 int start_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
 			     unsigned migratetype, int flags)
@@ -188,6 +197,7 @@ int start_isolate_page_range(unsigned lo
 	unsigned long pfn;
 	unsigned long undo_pfn;
 	struct page *page;
+	int nr_isolate_pageblock = 0;
 
 	BUG_ON(!IS_ALIGNED(start_pfn, pageblock_nr_pages));
 	BUG_ON(!IS_ALIGNED(end_pfn, pageblock_nr_pages));
@@ -196,13 +206,15 @@ int start_isolate_page_range(unsigned lo
 	     pfn < end_pfn;
 	     pfn += pageblock_nr_pages) {
 		page = __first_valid_page(pfn, pageblock_nr_pages);
-		if (page &&
-		    set_migratetype_isolate(page, migratetype, flags)) {
-			undo_pfn = pfn;
-			goto undo;
+		if (page) {
+			if (set_migratetype_isolate(page, migratetype, flags)) {
+				undo_pfn = pfn;
+				goto undo;
+			}
+			nr_isolate_pageblock++;
 		}
 	}
-	return 0;
+	return nr_isolate_pageblock;
 undo:
 	for (pfn = start_pfn;
 	     pfn < undo_pfn;
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -556,7 +556,7 @@ void online_mem_sections(unsigned long s
 }
 
 #ifdef CONFIG_MEMORY_HOTREMOVE
-/* Mark all memory sections within the pfn range as online */
+/* Mark all memory sections within the pfn range as offline */
 void offline_mem_sections(unsigned long start_pfn, unsigned long end_pfn)
 {
 	unsigned long pfn;


