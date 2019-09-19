Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AFD2C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 14:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66781218AF
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 14:24:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403808AbfISOXf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 10:23:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47510 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403764AbfISOX3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 10:23:29 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D309E31752BB;
        Thu, 19 Sep 2019 14:23:27 +0000 (UTC)
Received: from t460s.redhat.com (unknown [10.36.118.9])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 20B3060872;
        Thu, 19 Sep 2019 14:23:21 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, virtualization@lists.linux-foundation.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Juergen Gross <jgross@suse.com>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Anthony Yznaga <anthony.yznaga@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        Pingfan Liu <kernelfans@gmail.com>, Qian Cai <cai@lca.pw>,
        Dan Williams <dan.j.williams@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Wei Yang <richardw.yang@linux.intel.com>,
        Alexander Potapenko <glider@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Yu Zhao <yuzhao@google.com>, Minchan Kim <minchan@kernel.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>
Subject: [PATCH RFC v3 6/9] mm: Allow to offline PageOffline() pages with a reference count of 0
Date:   Thu, 19 Sep 2019 16:22:25 +0200
Message-Id: <20190919142228.5483-7-david@redhat.com>
In-Reply-To: <20190919142228.5483-1-david@redhat.com>
References: <20190919142228.5483-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Thu, 19 Sep 2019 14:23:28 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

virtio-mem wants to allow to offline memory blocks of which some parts
were unplugged, especially, to later offline and remove completely
unplugged memory blocks. The important part is that PageOffline() has
to remain set until the section is offline, so these pages will never
get accessed (e.g., when dumping). The pages should not be handed
back to the buddy (which would require clearing PageOffline() and
result in issues if offlining fails and the pages are suddenly in the
buddy).

Let's use "PageOffline() + reference count = 0" as a sign to
memory offlining code that these pages can simply be skipped when
offlining, similar to free or HWPoison pages.

Pass flags to test_pages_isolated(), similar as already done for
has_unmovable_pages(). Use a new flag to indicate the
requirement of memory offlining to skip over these special pages.

In has_unmovable_pages(), make sure the pages won't be detected as
movable. This is not strictly necessary, however makes e.g.,
alloc_contig_range() stop early, trying to isolate such page blocks -
compared to failing later when testing if all pages were isolated.

Also, make sure that when a reference to a PageOffline() page is
dropped, that the page will not be returned to the buddy.

memory devices (like virtio-mem) that want to make use of this
functionality have to make sure to synchronize against memory offlining,
using the memory hotplug notifier.

Alternative: Allow to offline with a reference count of 1
and use some other sign in the struct page that offlining is permitted.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Juergen Gross <jgross@suse.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Pavel Tatashin <pavel.tatashin@microsoft.com>
Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc: Anthony Yznaga <anthony.yznaga@oracle.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Pingfan Liu <kernelfans@gmail.com>
Cc: Qian Cai <cai@lca.pw>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc: Wei Yang <richardw.yang@linux.intel.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Yu Zhao <yuzhao@google.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Yang Shi <yang.shi@linux.alibaba.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/page-flags.h     |  4 ++++
 include/linux/page-isolation.h |  4 +++-
 mm/memory_hotplug.c            |  9 ++++++---
 mm/page_alloc.c                | 22 +++++++++++++++++++++-
 mm/page_isolation.c            | 18 +++++++++++++-----
 mm/swap.c                      |  9 +++++++++
 6 files changed, 56 insertions(+), 10 deletions(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index f91cb8898ff0..7e563eab6b4b 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -745,6 +745,10 @@ PAGE_TYPE_OPS(Buddy, buddy)
  * not onlined when onlining the section).
  * The content of these pages is effectively stale. Such pages should not
  * be touched (read/write/dump/save) except by their owner.
+ *
+ * PageOffline() pages that have a reference count of 0 will be treated
+ * like free pages when offlining pages, allowing the containing memory
+ * block to get offlined.
  */
 PAGE_TYPE_OPS(Offline, offline)
 
diff --git a/include/linux/page-isolation.h b/include/linux/page-isolation.h
index 1099c2fee20f..024e02b60346 100644
--- a/include/linux/page-isolation.h
+++ b/include/linux/page-isolation.h
@@ -32,6 +32,8 @@ static inline bool is_migrate_isolate(int migratetype)
 
 #define SKIP_HWPOISON	0x1
 #define REPORT_FAILURE	0x2
+/* Skip PageOffline() pages with a reference count of 0. */
+#define SKIP_OFFLINE	0x4
 
 bool has_unmovable_pages(struct zone *zone, struct page *page, int count,
 			 int migratetype, int flags);
@@ -58,7 +60,7 @@ undo_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
  * Test all pages in [start_pfn, end_pfn) are isolated or not.
  */
 int test_pages_isolated(unsigned long start_pfn, unsigned long end_pfn,
-			bool skip_hwpoisoned_pages);
+			int flags);
 
 struct page *alloc_migrate_target(struct page *page, unsigned long private);
 
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index f08eb429b8f3..d23ff7c5c96b 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1127,7 +1127,8 @@ static bool is_pageblock_removable_nolock(unsigned long pfn)
 	if (!zone_spans_pfn(zone, pfn))
 		return false;
 
-	return !has_unmovable_pages(zone, page, 0, MIGRATE_MOVABLE, SKIP_HWPOISON);
+	return !has_unmovable_pages(zone, page, 0, MIGRATE_MOVABLE,
+				    SKIP_HWPOISON | SKIP_OFFLINE);
 }
 
 /* Checks if this range of memory is likely to be hot-removable. */
@@ -1344,7 +1345,8 @@ static int
 check_pages_isolated_cb(unsigned long start_pfn, unsigned long nr_pages,
 			void *data)
 {
-	return test_pages_isolated(start_pfn, start_pfn + nr_pages, true);
+	return test_pages_isolated(start_pfn, start_pfn + nr_pages,
+				   SKIP_HWPOISON | SKIP_OFFLINE);
 }
 
 static int __init cmdline_parse_movable_node(char *p)
@@ -1455,7 +1457,8 @@ static int __ref __offline_pages(unsigned long start_pfn,
 	/* set above range as isolated */
 	ret = start_isolate_page_range(start_pfn, end_pfn,
 				       MIGRATE_MOVABLE,
-				       SKIP_HWPOISON | REPORT_FAILURE);
+				       SKIP_HWPOISON | REPORT_FAILURE |
+				       SKIP_OFFLINE);
 	if (ret < 0) {
 		reason = "failure to isolate range";
 		goto failed_removal;
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index d5d7944954b3..fef74720d8b4 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8221,6 +8221,15 @@ bool has_unmovable_pages(struct zone *zone, struct page *page, int count,
 		if (!page_ref_count(page)) {
 			if (PageBuddy(page))
 				iter += (1 << page_order(page)) - 1;
+			/*
+			* Memory devices allow to offline a page if it is
+			* marked PG_offline and has a reference count of 0.
+			* However, the pages are not movable as it would be
+			* required e.g., for alloc_contig_range().
+			*/
+			if (PageOffline(page) && !(flags & SKIP_OFFLINE))
+				if (++found > count)
+					goto unmovable;
 			continue;
 		}
 
@@ -8444,7 +8453,7 @@ int alloc_contig_range(unsigned long start, unsigned long end,
 	}
 
 	/* Make sure the range is really isolated. */
-	if (test_pages_isolated(outer_start, end, false)) {
+	if (test_pages_isolated(outer_start, end, 0)) {
 		pr_info_ratelimited("%s: [%lx, %lx) PFNs busy\n",
 			__func__, outer_start, end);
 		ret = -EBUSY;
@@ -8563,6 +8572,17 @@ __offline_isolated_pages(unsigned long start_pfn, unsigned long end_pfn)
 			offlined_pages++;
 			continue;
 		}
+		/*
+		 * Memory devices allow to offline a page if it is marked
+		 * PG_offline and has a reference count of 0.
+		 */
+		if (PageOffline(page) && !page_count(page)) {
+			BUG_ON(PageBuddy(page));
+			pfn++;
+			SetPageReserved(page);
+			offlined_pages++;
+			continue;
+		}
 
 		BUG_ON(page_count(page));
 		BUG_ON(!PageBuddy(page));
diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index 89c19c0feadb..0a75019d7e7c 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -171,6 +171,8 @@ __first_valid_page(unsigned long pfn, unsigned long nr_pages)
  *			SKIP_HWPOISON - ignore hwpoison pages
  *			REPORT_FAILURE - report details about the failure to
  *			isolate the range
+ *			SKIP_OFFLINE - ignore PageOffline() pages with a
+ *			reference count of 0
  *
  * Making page-allocation-type to be MIGRATE_ISOLATE means free pages in
  * the range will never be allocated. Any free pages and pages freed in the
@@ -257,7 +259,7 @@ void undo_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
  */
 static unsigned long
 __test_page_isolated_in_pageblock(unsigned long pfn, unsigned long end_pfn,
-				  bool skip_hwpoisoned_pages)
+				  int flags)
 {
 	struct page *page;
 
@@ -274,9 +276,16 @@ __test_page_isolated_in_pageblock(unsigned long pfn, unsigned long end_pfn,
 			 * simple way to verify that as VM_BUG_ON(), though.
 			 */
 			pfn += 1 << page_order(page);
-		else if (skip_hwpoisoned_pages && PageHWPoison(page))
+		else if ((flags & SKIP_HWPOISON) && PageHWPoison(page))
 			/* A HWPoisoned page cannot be also PageBuddy */
 			pfn++;
+		else if ((flags & SKIP_OFFLINE) && PageOffline(page) &&
+			 !page_count(page))
+			/*
+			 * Memory devices allow to offline a page if it is
+			 * marked PG_offline and has a reference count of 0.
+			 */
+			pfn++;
 		else
 			break;
 	}
@@ -286,7 +295,7 @@ __test_page_isolated_in_pageblock(unsigned long pfn, unsigned long end_pfn,
 
 /* Caller should ensure that requested range is in a single zone */
 int test_pages_isolated(unsigned long start_pfn, unsigned long end_pfn,
-			bool skip_hwpoisoned_pages)
+			int isol_flags)
 {
 	unsigned long pfn, flags;
 	struct page *page;
@@ -308,8 +317,7 @@ int test_pages_isolated(unsigned long start_pfn, unsigned long end_pfn,
 	/* Check all pages are free or marked as ISOLATED */
 	zone = page_zone(page);
 	spin_lock_irqsave(&zone->lock, flags);
-	pfn = __test_page_isolated_in_pageblock(start_pfn, end_pfn,
-						skip_hwpoisoned_pages);
+	pfn = __test_page_isolated_in_pageblock(start_pfn, end_pfn, isol_flags);
 	spin_unlock_irqrestore(&zone->lock, flags);
 
 	trace_test_pages_isolated(start_pfn, end_pfn, pfn);
diff --git a/mm/swap.c b/mm/swap.c
index 38c3fa4308e2..f98987656ecc 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -107,6 +107,15 @@ void __put_page(struct page *page)
 		 * not return it to page allocator.
 		 */
 		return;
+	} else if (PageOffline(page)) {
+		/*
+		 * Memory devices allow to offline a page if it is
+		 * marked PG_offline and has a reference count of 0. So if
+		 * somebody puts a reference of such a page and the
+		 * reference count drops to 0, don't return the page to the
+		 * buddy.
+		 */
+		return;
 	}
 
 	if (unlikely(PageCompound(page)))
-- 
2.21.0

