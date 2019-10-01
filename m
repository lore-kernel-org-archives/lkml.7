Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB5FDECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 22:17:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D4012054F
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 22:17:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728750AbfJAWQ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 18:16:59 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:44843 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728254AbfJAWQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 18:16:59 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0TdwLulC_1569968204;
Received: from e19h19392.et15sqa.tbsite.net(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TdwLulC_1569968204)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 02 Oct 2019 06:16:54 +0800
From:   Yang Shi <yang.shi@linux.alibaba.com>
To:     kirill.shutemov@linux.intel.com, ktkhai@virtuozzo.com,
        hannes@cmpxchg.org, mhocko@suse.com, hughd@google.com,
        shakeelb@google.com, rientjes@google.com, akpm@linux-foundation.org
Cc:     yang.shi@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm: thp: move deferred split queue to memcg's nodeinfo
Date:   Wed,  2 Oct 2019 06:16:43 +0800
Message-Id: <1569968203-64647-1-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 87eaceb3faa59b9b4d940ec9554ce251325d83fe ("mm: thp: make
deferred split shrinker memcg aware") makes deferred split queue per
memcg to resolve memcg pre-mature OOM problem.  But, all nodes end up
sharing the same queue instead of one queue per-node before the commit.
It is not a big deal for memcg limit reclaim, but it may cause global
kswapd shrink THPs from a different node.

And, 0-day testing reported -19.6% regression of stress-ng's madvise
test [1].  I didn't see that much regression on my test box (24 threads,
48GB memory, 2 nodes), with the same test (stress-ng --timeout 1
--metrics-brief --sequential 72  --class vm --exclude spawn,exec), I saw
average -3% (run the same test 10 times then calculate the average since
the test itself may have most 15% variation according to my test)
regression sometimes (not every time, sometimes I didn't see regression
at all).

This might be caused by deferred split queue lock contention.  With some
configuration (i.e. just one root memcg) the lock contention my be worse
than before (given 2 nodes, two locks are reduced to one lock).

So, moving deferred split queue to memcg's nodeinfo to make it NUMA
aware again.

With this change stress-ng's madvise test shows average 4% improvement
sometimes and I didn't see degradation anymore.

[1]: https://lore.kernel.org/lkml/20190930084604.GC17687@shao2-debian/

Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Kirill Tkhai <ktkhai@virtuozzo.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Shakeel Butt <shakeelb@google.com>
Cc: David Rientjes <rientjes@google.com>
Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
---
 include/linux/memcontrol.h |  8 ++++----
 mm/huge_memory.c           | 15 +++++++++------
 mm/memcontrol.c            | 29 +++++++++++++++++------------
 3 files changed, 30 insertions(+), 22 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 9b60863..4b5c791 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -137,6 +137,10 @@ struct mem_cgroup_per_node {
 	bool			congested;	/* memcg has many dirty pages */
 						/* backed by a congested BDI */
 
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+	struct deferred_split deferred_split_queue;
+#endif
+
 	struct mem_cgroup	*memcg;		/* Back pointer, we cannot */
 						/* use container_of	   */
 };
@@ -330,10 +334,6 @@ struct mem_cgroup {
 	struct list_head event_list;
 	spinlock_t event_list_lock;
 
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
-	struct deferred_split deferred_split_queue;
-#endif
-
 	struct mem_cgroup_per_node *nodeinfo[0];
 	/* WARNING: nodeinfo must be the last member here */
 };
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index c5cb6dc..3b78910 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -500,10 +500,11 @@ pmd_t maybe_pmd_mkwrite(pmd_t pmd, struct vm_area_struct *vma)
 static inline struct deferred_split *get_deferred_split_queue(struct page *page)
 {
 	struct mem_cgroup *memcg = compound_head(page)->mem_cgroup;
-	struct pglist_data *pgdat = NODE_DATA(page_to_nid(page));
+	int nid = page_to_nid(page);
+	struct pglist_data *pgdat = NODE_DATA(nid);
 
 	if (memcg)
-		return &memcg->deferred_split_queue;
+		return &memcg->nodeinfo[nid]->deferred_split_queue;
 	else
 		return &pgdat->deferred_split_queue;
 }
@@ -2882,12 +2883,13 @@ void deferred_split_huge_page(struct page *page)
 static unsigned long deferred_split_count(struct shrinker *shrink,
 		struct shrink_control *sc)
 {
-	struct pglist_data *pgdata = NODE_DATA(sc->nid);
+	int nid = sc->nid;
+	struct pglist_data *pgdata = NODE_DATA(nid);
 	struct deferred_split *ds_queue = &pgdata->deferred_split_queue;
 
 #ifdef CONFIG_MEMCG
 	if (sc->memcg)
-		ds_queue = &sc->memcg->deferred_split_queue;
+		ds_queue = &sc->memcg->nodeinfo[nid]->deferred_split_queue;
 #endif
 	return READ_ONCE(ds_queue->split_queue_len);
 }
@@ -2895,7 +2897,8 @@ static unsigned long deferred_split_count(struct shrinker *shrink,
 static unsigned long deferred_split_scan(struct shrinker *shrink,
 		struct shrink_control *sc)
 {
-	struct pglist_data *pgdata = NODE_DATA(sc->nid);
+	int nid = sc->nid;
+	struct pglist_data *pgdata = NODE_DATA(nid);
 	struct deferred_split *ds_queue = &pgdata->deferred_split_queue;
 	unsigned long flags;
 	LIST_HEAD(list), *pos, *next;
@@ -2904,7 +2907,7 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
 
 #ifdef CONFIG_MEMCG
 	if (sc->memcg)
-		ds_queue = &sc->memcg->deferred_split_queue;
+		ds_queue = &sc->memcg->nodeinfo[nid]->deferred_split_queue;
 #endif
 
 	spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index c313c49..19d4295 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4989,6 +4989,12 @@ static int alloc_mem_cgroup_per_node_info(struct mem_cgroup *memcg, int node)
 	pn->on_tree = false;
 	pn->memcg = memcg;
 
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+	spin_lock_init(&pn->deferred_split_queue.split_queue_lock);
+	INIT_LIST_HEAD(&pn->deferred_split_queue.split_queue);
+	pn->deferred_split_queue.split_queue_len = 0;
+#endif
+
 	memcg->nodeinfo[node] = pn;
 	return 0;
 }
@@ -5081,11 +5087,6 @@ static struct mem_cgroup *mem_cgroup_alloc(void)
 		memcg->cgwb_frn[i].done =
 			__WB_COMPLETION_INIT(&memcg_cgwb_frn_waitq);
 #endif
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
-	spin_lock_init(&memcg->deferred_split_queue.split_queue_lock);
-	INIT_LIST_HEAD(&memcg->deferred_split_queue.split_queue);
-	memcg->deferred_split_queue.split_queue_len = 0;
-#endif
 	idr_replace(&mem_cgroup_idr, memcg, memcg->id.id);
 	return memcg;
 fail:
@@ -5419,6 +5420,8 @@ static int mem_cgroup_move_account(struct page *page,
 	unsigned int nr_pages = compound ? hpage_nr_pages(page) : 1;
 	int ret;
 	bool anon;
+	struct deferred_split *ds_queue;
+	int nid = page_to_nid(page);
 
 	VM_BUG_ON(from == to);
 	VM_BUG_ON_PAGE(PageLRU(page), page);
@@ -5466,10 +5469,11 @@ static int mem_cgroup_move_account(struct page *page,
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	if (compound && !list_empty(page_deferred_list(page))) {
-		spin_lock(&from->deferred_split_queue.split_queue_lock);
+		ds_queue = &from->nodeinfo[nid]->deferred_split_queue;
+		spin_lock(&ds_queue->split_queue_lock);
 		list_del_init(page_deferred_list(page));
-		from->deferred_split_queue.split_queue_len--;
-		spin_unlock(&from->deferred_split_queue.split_queue_lock);
+		ds_queue->split_queue_len--;
+		spin_unlock(&ds_queue->split_queue_lock);
 	}
 #endif
 	/*
@@ -5483,11 +5487,12 @@ static int mem_cgroup_move_account(struct page *page,
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	if (compound && list_empty(page_deferred_list(page))) {
-		spin_lock(&to->deferred_split_queue.split_queue_lock);
+		ds_queue = &to->nodeinfo[nid]->deferred_split_queue;
+		spin_lock(&ds_queue->split_queue_lock);
 		list_add_tail(page_deferred_list(page),
-			      &to->deferred_split_queue.split_queue);
-		to->deferred_split_queue.split_queue_len++;
-		spin_unlock(&to->deferred_split_queue.split_queue_lock);
+			      &ds_queue->split_queue);
+		ds_queue->split_queue_len++;
+		spin_unlock(&ds_queue->split_queue_lock);
 	}
 #endif
 
-- 
1.8.3.1

