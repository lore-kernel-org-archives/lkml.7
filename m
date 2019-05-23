Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1AEBC282CE
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 02:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B2CA2173C
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 02:27:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729838AbfEWC1v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 22:27:51 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:60260 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728022AbfEWC1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 22:27:50 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R721e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07417;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0TSQws5W_1558578458;
Received: from e19h19392.et15sqa.tbsite.net(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TSQws5W_1558578458)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 23 May 2019 10:27:45 +0800
From:   Yang Shi <yang.shi@linux.alibaba.com>
To:     ying.huang@intel.com, hannes@cmpxchg.org, mhocko@suse.com,
        mgorman@techsingularity.net, kirill.shutemov@linux.intel.com,
        josef@toxicpanda.com, hughd@google.com, shakeelb@google.com,
        akpm@linux-foundation.org
Cc:     yang.shi@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [v4 PATCH 2/2] mm: vmscan: correct some vmscan counters for THP swapout
Date:   Thu, 23 May 2019 10:27:38 +0800
Message-Id: <1558578458-83807-2-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1558578458-83807-1-git-send-email-yang.shi@linux.alibaba.com>
References: <1558578458-83807-1-git-send-email-yang.shi@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit bd4c82c22c36 ("mm, THP, swap: delay splitting THP after
swapped out"), THP can be swapped out in a whole.  But, nr_reclaimed
and some other vm counters still get inc'ed by one even though a whole
THP (512 pages) gets swapped out.

This doesn't make too much sense to memory reclaim.  For example, direct
reclaim may just need reclaim SWAP_CLUSTER_MAX pages, reclaiming one THP
could fulfill it.  But, if nr_reclaimed is not increased correctly,
direct reclaim may just waste time to reclaim more pages,
SWAP_CLUSTER_MAX * 512 pages in worst case.

And, it may cause pgsteal_{kswapd|direct} is greater than
pgscan_{kswapd|direct}, like the below:

pgsteal_kswapd 122933
pgsteal_direct 26600225
pgscan_kswapd 174153
pgscan_direct 14678312

nr_reclaimed and nr_scanned must be fixed in parallel otherwise it would
break some page reclaim logic, e.g.

vmpressure: this looks at the scanned/reclaimed ratio so it won't
change semantics as long as scanned & reclaimed are fixed in parallel.

compaction/reclaim: compaction wants a certain number of physical pages
freed up before going back to compacting.

kswapd priority raising: kswapd raises priority if we scan fewer pages
than the reclaim target (which itself is obviously expressed in order-0
pages). As a result, kswapd can falsely raise its aggressiveness even
when it's making great progress.

Other than nr_scanned and nr_reclaimed, some other counters, e.g.
pgactivate, nr_skipped, nr_ref_keep and nr_unmap_fail need to be fixed
too since they are user visible via cgroup, /proc/vmstat or trace
points, otherwise they would be underreported.

When isolating pages from LRUs, nr_taken has been accounted in base
page, but nr_scanned and nr_skipped are still accounted in THP.  It
doesn't make too much sense too since this may cause trace point
underreport the numbers as well.

So accounting those counters in base page instead of accounting THP as
one page.

nr_dirty, nr_unqueued_dirty, nr_congested and nr_writeback are used by
file cache, so they are not impacted by THP swap.

This change may result in lower steal/scan ratio in some cases since
THP may get split during page reclaim, then a part of tail pages get
reclaimed instead of the whole 512 pages, but nr_scanned is accounted
by 512, particularly for direct reclaim.  But, this should be not a
significant issue.

Cc: "Huang, Ying" <ying.huang@intel.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Shakeel Butt <shakeelb@google.com>
Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
---
v4: Fixed the comments from Johannes and Huang Ying
v3: Removed Shakeel's Reviewed-by since the patch has been changed significantly
    Switched back to use compound_order per Matthew
    Fixed more counters per Johannes
v2: Added Shakeel's Reviewed-by
    Use hpage_nr_pages instead of compound_order per Huang Ying and William Kucharski

 mm/vmscan.c | 34 ++++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index b65bc50..1b35a7a 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1118,6 +1118,7 @@ static unsigned long shrink_page_list(struct list_head *page_list,
 		int may_enter_fs;
 		enum page_references references = PAGEREF_RECLAIM_CLEAN;
 		bool dirty, writeback;
+		unsigned int nr_pages;
 
 		cond_resched();
 
@@ -1129,7 +1130,9 @@ static unsigned long shrink_page_list(struct list_head *page_list,
 
 		VM_BUG_ON_PAGE(PageActive(page), page);
 
-		sc->nr_scanned++;
+		/* Account the number of base pages evne though THP */
+		nr_pages = 1 << compound_order(page);
+		sc->nr_scanned += nr_pages;
 
 		if (unlikely(!page_evictable(page)))
 			goto activate_locked;
@@ -1250,7 +1253,7 @@ static unsigned long shrink_page_list(struct list_head *page_list,
 		case PAGEREF_ACTIVATE:
 			goto activate_locked;
 		case PAGEREF_KEEP:
-			stat->nr_ref_keep++;
+			stat->nr_ref_keep += nr_pages;
 			goto keep_locked;
 		case PAGEREF_RECLAIM:
 		case PAGEREF_RECLAIM_CLEAN:
@@ -1315,7 +1318,7 @@ static unsigned long shrink_page_list(struct list_head *page_list,
 			if (unlikely(PageTransHuge(page)))
 				flags |= TTU_SPLIT_HUGE_PMD;
 			if (!try_to_unmap(page, flags)) {
-				stat->nr_unmap_fail++;
+				stat->nr_unmap_fail += nr_pages;
 				goto activate_locked;
 			}
 		}
@@ -1442,7 +1445,11 @@ static unsigned long shrink_page_list(struct list_head *page_list,
 
 		unlock_page(page);
 free_it:
-		nr_reclaimed++;
+		/*
+		 * THP may get swapped out in a whole, need account
+		 * all base pages.
+		 */
+		nr_reclaimed += (1 << compound_order(page));
 
 		/*
 		 * Is there need to periodically free_page_list? It would
@@ -1464,7 +1471,6 @@ static unsigned long shrink_page_list(struct list_head *page_list,
 		if (!PageMlocked(page)) {
 			int type = page_is_file_cache(page);
 			SetPageActive(page);
-			pgactivate++;
 			stat->nr_activate[type] += hpage_nr_pages(page);
 			count_memcg_page_event(page, PGACTIVATE);
 		}
@@ -1475,6 +1481,8 @@ static unsigned long shrink_page_list(struct list_head *page_list,
 		VM_BUG_ON_PAGE(PageLRU(page) || PageUnevictable(page), page);
 	}
 
+	pgactivate = stat->nr_activate[0] + stat->nr_activate[1];
+
 	mem_cgroup_uncharge_list(&free_pages);
 	try_to_unmap_flush();
 	free_unref_page_list(&free_pages);
@@ -1642,14 +1650,14 @@ static unsigned long isolate_lru_pages(unsigned long nr_to_scan,
 	unsigned long nr_zone_taken[MAX_NR_ZONES] = { 0 };
 	unsigned long nr_skipped[MAX_NR_ZONES] = { 0, };
 	unsigned long skipped = 0;
-	unsigned long scan, total_scan, nr_pages;
+	unsigned long scan, total_scan;
+	unsigned long nr_pages;
 	LIST_HEAD(pages_skipped);
 	isolate_mode_t mode = (sc->may_unmap ? 0 : ISOLATE_UNMAPPED);
 
+	total_scan = 0;
 	scan = 0;
-	for (total_scan = 0;
-	     scan < nr_to_scan && nr_taken < nr_to_scan && !list_empty(src);
-	     total_scan++) {
+	while (scan < nr_to_scan && !list_empty(src)) {
 		struct page *page;
 
 		page = lru_to_page(src);
@@ -1657,9 +1665,12 @@ static unsigned long isolate_lru_pages(unsigned long nr_to_scan,
 
 		VM_BUG_ON_PAGE(!PageLRU(page), page);
 
+		nr_pages = 1 << compound_order(page);
+		total_scan += nr_pages;
+
 		if (page_zonenum(page) > sc->reclaim_idx) {
 			list_move(&page->lru, &pages_skipped);
-			nr_skipped[page_zonenum(page)]++;
+			nr_skipped[page_zonenum(page)] += nr_pages;
 			continue;
 		}
 
@@ -1669,10 +1680,9 @@ static unsigned long isolate_lru_pages(unsigned long nr_to_scan,
 		 * ineligible pages.  This causes the VM to not reclaim any
 		 * pages, triggering a premature OOM.
 		 */
-		scan++;
+		scan += nr_pages;
 		switch (__isolate_lru_page(page, mode)) {
 		case 0:
-			nr_pages = hpage_nr_pages(page);
 			nr_taken += nr_pages;
 			nr_zone_taken[page_zonenum(page)] += nr_pages;
 			list_move(&page->lru, dst);
-- 
1.8.3.1

