Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA00C282CE
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 03:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60F242183E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 03:57:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbfDKD5a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 23:57:30 -0400
Received: from out4437.biz.mail.alibaba.com ([47.88.44.37]:1440 "EHLO
        out4437.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726588AbfDKD50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 23:57:26 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R231e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0TP0I5rB_1554955031;
Received: from e19h19392.et15sqa.tbsite.net(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TP0I5rB_1554955031)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 11 Apr 2019 11:57:22 +0800
From:   Yang Shi <yang.shi@linux.alibaba.com>
To:     mhocko@suse.com, mgorman@techsingularity.net, riel@surriel.com,
        hannes@cmpxchg.org, akpm@linux-foundation.org,
        dave.hansen@intel.com, keith.busch@intel.com,
        dan.j.williams@intel.com, fengguang.wu@intel.com, fan.du@intel.com,
        ying.huang@intel.com, ziy@nvidia.com
Cc:     yang.shi@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [v2 PATCH 4/9] mm: migrate: make migrate_pages() return nr_succeeded
Date:   Thu, 11 Apr 2019 11:56:54 +0800
Message-Id: <1554955019-29472-5-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1554955019-29472-1-git-send-email-yang.shi@linux.alibaba.com>
References: <1554955019-29472-1-git-send-email-yang.shi@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The migrate_pages() returns the number of pages that were not migrated,
or an error code.  When returning an error code, there is no way to know
how many pages were migrated or not migrated.

In the following patch, migrate_pages() is used to demote pages to PMEM
node, we need account how many pages are reclaimed (demoted) since page
reclaim behavior depends on this.  Add *nr_succeeded parameter to make
migrate_pages() return how many pages are demoted successfully for all
cases.

Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
---
 include/linux/migrate.h |  5 +++--
 mm/compaction.c         |  3 ++-
 mm/gup.c                |  4 +++-
 mm/memory-failure.c     |  7 +++++--
 mm/memory_hotplug.c     |  4 +++-
 mm/mempolicy.c          |  7 +++++--
 mm/migrate.c            | 18 ++++++++++--------
 mm/page_alloc.c         |  4 +++-
 8 files changed, 34 insertions(+), 18 deletions(-)

diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index e13d9bf..837fdd1 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -66,7 +66,8 @@ extern int migrate_page(struct address_space *mapping,
 			struct page *newpage, struct page *page,
 			enum migrate_mode mode);
 extern int migrate_pages(struct list_head *l, new_page_t new, free_page_t free,
-		unsigned long private, enum migrate_mode mode, int reason);
+		unsigned long private, enum migrate_mode mode, int reason,
+		unsigned int *nr_succeeded);
 extern int isolate_movable_page(struct page *page, isolate_mode_t mode);
 extern void putback_movable_page(struct page *page);
 
@@ -84,7 +85,7 @@ extern int migrate_page_move_mapping(struct address_space *mapping,
 static inline void putback_movable_pages(struct list_head *l) {}
 static inline int migrate_pages(struct list_head *l, new_page_t new,
 		free_page_t free, unsigned long private, enum migrate_mode mode,
-		int reason)
+		int reason, unsigned int *nr_succeeded)
 	{ return -ENOSYS; }
 static inline int isolate_movable_page(struct page *page, isolate_mode_t mode)
 	{ return -EBUSY; }
diff --git a/mm/compaction.c b/mm/compaction.c
index f171a83..c6a0ec4 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -2065,6 +2065,7 @@ bool compaction_zonelist_suitable(struct alloc_context *ac, int order,
 	unsigned long last_migrated_pfn;
 	const bool sync = cc->mode != MIGRATE_ASYNC;
 	bool update_cached;
+	unsigned int nr_succeeded = 0;
 
 	cc->migratetype = gfpflags_to_migratetype(cc->gfp_mask);
 	ret = compaction_suitable(cc->zone, cc->order, cc->alloc_flags,
@@ -2173,7 +2174,7 @@ bool compaction_zonelist_suitable(struct alloc_context *ac, int order,
 
 		err = migrate_pages(&cc->migratepages, compaction_alloc,
 				compaction_free, (unsigned long)cc, cc->mode,
-				MR_COMPACTION);
+				MR_COMPACTION, &nr_succeeded);
 
 		trace_mm_compaction_migratepages(cc->nr_migratepages, err,
 							&cc->migratepages);
diff --git a/mm/gup.c b/mm/gup.c
index f84e226..b482b8c 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1217,6 +1217,7 @@ static long check_and_migrate_cma_pages(unsigned long start, long nr_pages,
 	long i;
 	bool drain_allow = true;
 	bool migrate_allow = true;
+	unsigned int nr_succeeded = 0;
 	LIST_HEAD(cma_page_list);
 
 check_again:
@@ -1257,7 +1258,8 @@ static long check_and_migrate_cma_pages(unsigned long start, long nr_pages,
 			put_page(pages[i]);
 
 		if (migrate_pages(&cma_page_list, new_non_cma_page,
-				  NULL, 0, MIGRATE_SYNC, MR_CONTIG_RANGE)) {
+				  NULL, 0, MIGRATE_SYNC, MR_CONTIG_RANGE,
+				  &nr_succeeded)) {
 			/*
 			 * some of the pages failed migration. Do get_user_pages
 			 * without migration.
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index fc8b517..b5d8a8f 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1686,6 +1686,7 @@ static int soft_offline_huge_page(struct page *page, int flags)
 	int ret;
 	unsigned long pfn = page_to_pfn(page);
 	struct page *hpage = compound_head(page);
+	unsigned int nr_succeeded = 0;
 	LIST_HEAD(pagelist);
 
 	/*
@@ -1713,7 +1714,7 @@ static int soft_offline_huge_page(struct page *page, int flags)
 	}
 
 	ret = migrate_pages(&pagelist, new_page, NULL, MPOL_MF_MOVE_ALL,
-				MIGRATE_SYNC, MR_MEMORY_FAILURE);
+				MIGRATE_SYNC, MR_MEMORY_FAILURE, &nr_succeeded);
 	if (ret) {
 		pr_info("soft offline: %#lx: hugepage migration failed %d, type %lx (%pGp)\n",
 			pfn, ret, page->flags, &page->flags);
@@ -1742,6 +1743,7 @@ static int __soft_offline_page(struct page *page, int flags)
 {
 	int ret;
 	unsigned long pfn = page_to_pfn(page);
+	unsigned int nr_succeeded = 0;
 
 	/*
 	 * Check PageHWPoison again inside page lock because PageHWPoison
@@ -1801,7 +1803,8 @@ static int __soft_offline_page(struct page *page, int flags)
 						page_is_file_cache(page));
 		list_add(&page->lru, &pagelist);
 		ret = migrate_pages(&pagelist, new_page, NULL, MPOL_MF_MOVE_ALL,
-					MIGRATE_SYNC, MR_MEMORY_FAILURE);
+					MIGRATE_SYNC, MR_MEMORY_FAILURE,
+					&nr_succeeded);
 		if (ret) {
 			if (!list_empty(&pagelist))
 				putback_movable_pages(&pagelist);
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 1140f3b..29414a4 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1375,6 +1375,7 @@ static struct page *new_node_page(struct page *page, unsigned long private)
 	unsigned long pfn;
 	struct page *page;
 	int ret = 0;
+	unsigned int nr_succeeded = 0;
 	LIST_HEAD(source);
 
 	for (pfn = start_pfn; pfn < end_pfn; pfn++) {
@@ -1435,7 +1436,8 @@ static struct page *new_node_page(struct page *page, unsigned long private)
 	if (!list_empty(&source)) {
 		/* Allocate a new page from the nearest neighbor node */
 		ret = migrate_pages(&source, new_node_page, NULL, 0,
-					MIGRATE_SYNC, MR_MEMORY_HOTPLUG);
+					MIGRATE_SYNC, MR_MEMORY_HOTPLUG,
+					&nr_succeeded);
 		if (ret) {
 			list_for_each_entry(page, &source, lru) {
 				pr_warn("migrating pfn %lx failed ret:%d ",
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index af171cc..96d6e2e 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -962,6 +962,7 @@ static int migrate_to_node(struct mm_struct *mm, int source, int dest,
 	nodemask_t nmask;
 	LIST_HEAD(pagelist);
 	int err = 0;
+	unsigned int nr_succeeded = 0;
 
 	nodes_clear(nmask);
 	node_set(source, nmask);
@@ -977,7 +978,7 @@ static int migrate_to_node(struct mm_struct *mm, int source, int dest,
 
 	if (!list_empty(&pagelist)) {
 		err = migrate_pages(&pagelist, alloc_new_node_page, NULL, dest,
-					MIGRATE_SYNC, MR_SYSCALL);
+					MIGRATE_SYNC, MR_SYSCALL, &nr_succeeded);
 		if (err)
 			putback_movable_pages(&pagelist);
 	}
@@ -1156,6 +1157,7 @@ static long do_mbind(unsigned long start, unsigned long len,
 	struct mempolicy *new;
 	unsigned long end;
 	int err;
+	unsigned int nr_succeeded = 0;
 	LIST_HEAD(pagelist);
 
 	if (flags & ~(unsigned long)MPOL_MF_VALID)
@@ -1228,7 +1230,8 @@ static long do_mbind(unsigned long start, unsigned long len,
 		if (!list_empty(&pagelist)) {
 			WARN_ON_ONCE(flags & MPOL_MF_LAZY);
 			nr_failed = migrate_pages(&pagelist, new_page, NULL,
-				start, MIGRATE_SYNC, MR_MEMPOLICY_MBIND);
+				start, MIGRATE_SYNC, MR_MEMPOLICY_MBIND,
+				&nr_succeeded);
 			if (nr_failed)
 				putback_movable_pages(&pagelist);
 		}
diff --git a/mm/migrate.c b/mm/migrate.c
index ac6f493..84bba47 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1387,6 +1387,7 @@ static int unmap_and_move_huge_page(new_page_t get_new_page,
  * @mode:		The migration mode that specifies the constraints for
  *			page migration, if any.
  * @reason:		The reason for page migration.
+ * @nr_succeeded:	The number of pages migrated successfully.
  *
  * The function returns after 10 attempts or if no pages are movable any more
  * because the list has become empty or no retryable pages exist any more.
@@ -1397,11 +1398,10 @@ static int unmap_and_move_huge_page(new_page_t get_new_page,
  */
 int migrate_pages(struct list_head *from, new_page_t get_new_page,
 		free_page_t put_new_page, unsigned long private,
-		enum migrate_mode mode, int reason)
+		enum migrate_mode mode, int reason, unsigned int *nr_succeeded)
 {
 	int retry = 1;
 	int nr_failed = 0;
-	int nr_succeeded = 0;
 	int pass = 0;
 	struct page *page;
 	struct page *page2;
@@ -1455,7 +1455,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 				retry++;
 				break;
 			case MIGRATEPAGE_SUCCESS:
-				nr_succeeded++;
+				(*nr_succeeded)++;
 				break;
 			default:
 				/*
@@ -1472,11 +1472,11 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 	nr_failed += retry;
 	rc = nr_failed;
 out:
-	if (nr_succeeded)
-		count_vm_events(PGMIGRATE_SUCCESS, nr_succeeded);
+	if (*nr_succeeded)
+		count_vm_events(PGMIGRATE_SUCCESS, *nr_succeeded);
 	if (nr_failed)
 		count_vm_events(PGMIGRATE_FAIL, nr_failed);
-	trace_mm_migrate_pages(nr_succeeded, nr_failed, mode, reason);
+	trace_mm_migrate_pages(*nr_succeeded, nr_failed, mode, reason);
 
 	if (!swapwrite)
 		current->flags &= ~PF_SWAPWRITE;
@@ -1501,12 +1501,13 @@ static int do_move_pages_to_node(struct mm_struct *mm,
 		struct list_head *pagelist, int node)
 {
 	int err;
+	unsigned int nr_succeeded = 0;
 
 	if (list_empty(pagelist))
 		return 0;
 
 	err = migrate_pages(pagelist, alloc_new_node_page, NULL, node,
-			MIGRATE_SYNC, MR_SYSCALL);
+			MIGRATE_SYNC, MR_SYSCALL, &nr_succeeded);
 	if (err)
 		putback_movable_pages(pagelist);
 	return err;
@@ -1939,6 +1940,7 @@ int migrate_misplaced_page(struct page *page, struct vm_area_struct *vma,
 	pg_data_t *pgdat = NODE_DATA(node);
 	int isolated;
 	int nr_remaining;
+	unsigned int nr_succeeded = 0;
 	LIST_HEAD(migratepages);
 
 	/*
@@ -1963,7 +1965,7 @@ int migrate_misplaced_page(struct page *page, struct vm_area_struct *vma,
 	list_add(&page->lru, &migratepages);
 	nr_remaining = migrate_pages(&migratepages, alloc_misplaced_dst_page,
 				     NULL, node, MIGRATE_ASYNC,
-				     MR_NUMA_MISPLACED);
+				     MR_NUMA_MISPLACED, &nr_succeeded);
 	if (nr_remaining) {
 		if (!list_empty(&migratepages)) {
 			list_del(&page->lru);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index bda17c2..e53cc96 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8139,6 +8139,7 @@ static int __alloc_contig_migrate_range(struct compact_control *cc,
 	unsigned long pfn = start;
 	unsigned int tries = 0;
 	int ret = 0;
+	unsigned int nr_succeeded = 0;
 
 	migrate_prep();
 
@@ -8166,7 +8167,8 @@ static int __alloc_contig_migrate_range(struct compact_control *cc,
 		cc->nr_migratepages -= nr_reclaimed;
 
 		ret = migrate_pages(&cc->migratepages, alloc_migrate_target,
-				    NULL, 0, cc->mode, MR_CONTIG_RANGE);
+				    NULL, 0, cc->mode, MR_CONTIG_RANGE,
+				    &nr_succeeded);
 	}
 	if (ret < 0) {
 		putback_movable_pages(&cc->migratepages);
-- 
1.8.3.1

