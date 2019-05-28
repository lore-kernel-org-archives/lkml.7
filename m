Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DADDC04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 12:44:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39D6B208CB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 12:44:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727553AbfE1Mop (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 08:44:45 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:46928 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727360AbfE1Mop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 08:44:45 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0TStMl0v_1559047475;
Received: from e19h19392.et15sqa.tbsite.net(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TStMl0v_1559047475)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 28 May 2019 20:44:42 +0800
From:   Yang Shi <yang.shi@linux.alibaba.com>
To:     ktkhai@virtuozzo.com, hannes@cmpxchg.org, mhocko@suse.com,
        kirill.shutemov@linux.intel.com, hughd@google.com,
        shakeelb@google.com, akpm@linux-foundation.org
Cc:     yang.shi@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] mm: thp: make deferred split shrinker memcg aware
Date:   Tue, 28 May 2019 20:44:22 +0800
Message-Id: <1559047464-59838-2-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1559047464-59838-1-git-send-email-yang.shi@linux.alibaba.com>
References: <1559047464-59838-1-git-send-email-yang.shi@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently THP deferred split shrinker is not memcg aware, this may cause
premature OOM with some configuration. For example the below test would
run into premature OOM easily:

$ cgcreate -g memory:thp
$ echo 4G > /sys/fs/cgroup/memory/thp/memory/limit_in_bytes
$ cgexec -g memory:thp transhuge-stress 4000

transhuge-stress comes from kernel selftest.

It is easy to hit OOM, but there are still a lot THP on the deferred
split queue, memcg direct reclaim can't touch them since the deferred
split shrinker is not memcg aware.

Convert deferred split shrinker memcg aware by introducing per memcg
deferred split queue.  The THP should be on either per node or per memcg
deferred split queue if it belongs to a memcg.  When the page is
immigrated to the other memcg, it will be immigrated to the target
memcg's deferred split queue too.

And, move deleting THP from deferred split queue in page free before
memcg uncharge so that the page's memcg information is available.

Reuse the second tail page's deferred_list for per memcg list since the
same THP can't be on multiple deferred split queues.

Cc: Kirill Tkhai <ktkhai@virtuozzo.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Shakeel Butt <shakeelb@google.com>
Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
---
 include/linux/huge_mm.h    |  24 ++++++
 include/linux/memcontrol.h |   6 ++
 include/linux/mm_types.h   |   7 +-
 mm/huge_memory.c           | 182 +++++++++++++++++++++++++++++++++------------
 mm/memcontrol.c            |  20 +++++
 mm/swap.c                  |   4 +
 6 files changed, 194 insertions(+), 49 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 7cd5c15..f6d1cde 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -250,6 +250,26 @@ static inline bool thp_migration_supported(void)
 	return IS_ENABLED(CONFIG_ARCH_ENABLE_THP_MIGRATION);
 }
 
+static inline struct list_head *page_deferred_list(struct page *page)
+{
+	/*
+	 * Global deferred list in the second tail pages is occupied by
+	 * compound_head.
+	 */
+	return &page[2].deferred_list;
+}
+
+static inline struct list_head *page_memcg_deferred_list(struct page *page)
+{
+	/*
+	 * Memcg deferred list in the second tail pages is occupied by
+	 * compound_head.
+	 */
+	return &page[2].memcg_deferred_list;
+}
+
+extern void del_thp_from_deferred_split_queue(struct page *);
+
 #else /* CONFIG_TRANSPARENT_HUGEPAGE */
 #define HPAGE_PMD_SHIFT ({ BUILD_BUG(); 0; })
 #define HPAGE_PMD_MASK ({ BUILD_BUG(); 0; })
@@ -368,6 +388,10 @@ static inline bool thp_migration_supported(void)
 {
 	return false;
 }
+
+static inline void del_thp_from_deferred_split_queue(struct page *page)
+{
+}
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
 #endif /* _LINUX_HUGE_MM_H */
diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index bc74d6a..9ff5fab 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -316,6 +316,12 @@ struct mem_cgroup {
 	struct list_head event_list;
 	spinlock_t event_list_lock;
 
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+	struct list_head split_queue;
+	unsigned long split_queue_len;
+	spinlock_t split_queue_lock;
+#endif
+
 	struct mem_cgroup_per_node *nodeinfo[0];
 	/* WARNING: nodeinfo must be the last member here */
 };
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 8ec38b1..405f5e6 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -139,7 +139,12 @@ struct page {
 		struct {	/* Second tail page of compound page */
 			unsigned long _compound_pad_1;	/* compound_head */
 			unsigned long _compound_pad_2;
-			struct list_head deferred_list;
+			union {
+				/* Global THP deferred split list */
+				struct list_head deferred_list;
+				/* Memcg THP deferred split list */
+				struct list_head memcg_deferred_list;
+			};
 		};
 		struct {	/* Page table pages */
 			unsigned long _pt_pad_1;	/* compound_head */
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 9f8bce9..0b9cfe1 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -492,12 +492,6 @@ pmd_t maybe_pmd_mkwrite(pmd_t pmd, struct vm_area_struct *vma)
 	return pmd;
 }
 
-static inline struct list_head *page_deferred_list(struct page *page)
-{
-	/* ->lru in the tail pages is occupied by compound_head. */
-	return &page[2].deferred_list;
-}
-
 void prep_transhuge_page(struct page *page)
 {
 	/*
@@ -505,7 +499,10 @@ void prep_transhuge_page(struct page *page)
 	 * as list_head: assuming THP order >= 2
 	 */
 
-	INIT_LIST_HEAD(page_deferred_list(page));
+	if (mem_cgroup_disabled())
+		INIT_LIST_HEAD(page_deferred_list(page));
+	else
+		INIT_LIST_HEAD(page_memcg_deferred_list(page));
 	set_compound_page_dtor(page, TRANSHUGE_PAGE_DTOR);
 }
 
@@ -2664,6 +2661,7 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 	bool mlocked;
 	unsigned long flags;
 	pgoff_t end;
+	struct mem_cgroup *memcg = head->mem_cgroup;
 
 	VM_BUG_ON_PAGE(is_huge_zero_page(page), page);
 	VM_BUG_ON_PAGE(!PageLocked(page), page);
@@ -2744,17 +2742,30 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 	}
 
 	/* Prevent deferred_split_scan() touching ->_refcount */
-	spin_lock(&pgdata->split_queue_lock);
+	if (!memcg)
+		spin_lock(&pgdata->split_queue_lock);
+	else
+		spin_lock(&memcg->split_queue_lock);
 	count = page_count(head);
 	mapcount = total_mapcount(head);
 	if (!mapcount && page_ref_freeze(head, 1 + extra_pins)) {
-		if (!list_empty(page_deferred_list(head))) {
-			pgdata->split_queue_len--;
-			list_del(page_deferred_list(head));
+		if (!memcg) {
+			if (!list_empty(page_deferred_list(head))) {
+				pgdata->split_queue_len--;
+				list_del(page_deferred_list(head));
+			}
+		} else {
+			if (!list_empty(page_memcg_deferred_list(head))) {
+				memcg->split_queue_len--;
+				list_del(page_memcg_deferred_list(head));
+			}
 		}
 		if (mapping)
 			__dec_node_page_state(page, NR_SHMEM_THPS);
-		spin_unlock(&pgdata->split_queue_lock);
+		if (!memcg)
+			spin_unlock(&pgdata->split_queue_lock);
+		else
+			spin_unlock(&memcg->split_queue_lock);
 		__split_huge_page(page, list, end, flags);
 		if (PageSwapCache(head)) {
 			swp_entry_t entry = { .val = page_private(head) };
@@ -2771,7 +2782,10 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 			dump_page(page, "total_mapcount(head) > 0");
 			BUG();
 		}
-		spin_unlock(&pgdata->split_queue_lock);
+		if (!memcg)
+			spin_unlock(&pgdata->split_queue_lock);
+		else
+			spin_unlock(&memcg->split_queue_lock);
 fail:		if (mapping)
 			xa_unlock(&mapping->i_pages);
 		spin_unlock_irqrestore(&pgdata->lru_lock, flags);
@@ -2791,17 +2805,40 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 	return ret;
 }
 
-void free_transhuge_page(struct page *page)
+void del_thp_from_deferred_split_queue(struct page *page)
 {
 	struct pglist_data *pgdata = NODE_DATA(page_to_nid(page));
 	unsigned long flags;
+	struct mem_cgroup *memcg = compound_head(page)->mem_cgroup;
 
-	spin_lock_irqsave(&pgdata->split_queue_lock, flags);
-	if (!list_empty(page_deferred_list(page))) {
-		pgdata->split_queue_len--;
-		list_del(page_deferred_list(page));
+	/*
+	 * The THP may be not on LRU at this point, e.g. the old page of
+	 * NUMA migration.  And PageTransHuge is not enough to distinguish
+	 * with other compound page, e.g. skb, THP destructor is not used
+	 * anymore and will be removed, so the compound order sounds like
+	 * the only choice here.
+	 */
+	if (PageTransHuge(page) && compound_order(page) == HPAGE_PMD_ORDER) {
+		if (!memcg) {
+			spin_lock_irqsave(&pgdata->split_queue_lock, flags);
+			if (!list_empty(page_deferred_list(page))) {
+				pgdata->split_queue_len--;
+				list_del(page_deferred_list(page));
+			}
+			spin_unlock_irqrestore(&pgdata->split_queue_lock, flags);
+		} else {
+			spin_lock_irqsave(&memcg->split_queue_lock, flags);
+			if (!list_empty(page_memcg_deferred_list(page))) {
+				memcg->split_queue_len--;
+				list_del(page_memcg_deferred_list(page));
+			}
+			spin_unlock_irqrestore(&memcg->split_queue_lock, flags);
+		}
 	}
-	spin_unlock_irqrestore(&pgdata->split_queue_lock, flags);
+}
+
+void free_transhuge_page(struct page *page)
+{
 	free_compound_page(page);
 }
 
@@ -2809,23 +2846,41 @@ void deferred_split_huge_page(struct page *page)
 {
 	struct pglist_data *pgdata = NODE_DATA(page_to_nid(page));
 	unsigned long flags;
+	struct mem_cgroup *memcg;
 
 	VM_BUG_ON_PAGE(!PageTransHuge(page), page);
 
-	spin_lock_irqsave(&pgdata->split_queue_lock, flags);
-	if (list_empty(page_deferred_list(page))) {
-		count_vm_event(THP_DEFERRED_SPLIT_PAGE);
-		list_add_tail(page_deferred_list(page), &pgdata->split_queue);
-		pgdata->split_queue_len++;
+	memcg = compound_head(page)->mem_cgroup;
+	if (!memcg) {
+		spin_lock_irqsave(&pgdata->split_queue_lock, flags);
+		if (list_empty(page_deferred_list(page))) {
+			count_vm_event(THP_DEFERRED_SPLIT_PAGE);
+			list_add_tail(page_deferred_list(page), &pgdata->split_queue);
+			pgdata->split_queue_len++;
+		}
+		spin_unlock_irqrestore(&pgdata->split_queue_lock, flags);
+	} else {
+		spin_lock_irqsave(&memcg->split_queue_lock, flags);
+		if (list_empty(page_memcg_deferred_list(page))) {
+			count_vm_event(THP_DEFERRED_SPLIT_PAGE);
+			list_add_tail(page_memcg_deferred_list(page),
+				      &memcg->split_queue);
+			memcg->split_queue_len++;
+			memcg_set_shrinker_bit(memcg, page_to_nid(page),
+					       deferred_split_shrinker.id);
+		}
+		spin_unlock_irqrestore(&memcg->split_queue_lock, flags);
 	}
-	spin_unlock_irqrestore(&pgdata->split_queue_lock, flags);
 }
 
 static unsigned long deferred_split_count(struct shrinker *shrink,
 		struct shrink_control *sc)
 {
-	struct pglist_data *pgdata = NODE_DATA(sc->nid);
-	return READ_ONCE(pgdata->split_queue_len);
+	if (!sc->memcg) {
+		struct pglist_data *pgdata = NODE_DATA(sc->nid);
+		return READ_ONCE(pgdata->split_queue_len);
+	} else
+		return READ_ONCE(sc->memcg->split_queue_len);
 }
 
 static unsigned long deferred_split_scan(struct shrinker *shrink,
@@ -2837,22 +2892,40 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
 	struct page *page;
 	int split = 0;
 
-	spin_lock_irqsave(&pgdata->split_queue_lock, flags);
-	/* Take pin on all head pages to avoid freeing them under us */
-	list_for_each_safe(pos, next, &pgdata->split_queue) {
-		page = list_entry((void *)pos, struct page, mapping);
-		page = compound_head(page);
-		if (get_page_unless_zero(page)) {
-			list_move(page_deferred_list(page), &list);
-		} else {
-			/* We lost race with put_compound_page() */
-			list_del_init(page_deferred_list(page));
-			pgdata->split_queue_len--;
+	if (!sc->memcg) {
+		spin_lock_irqsave(&pgdata->split_queue_lock, flags);
+		/* Take pin on all head pages to avoid freeing them under us */
+		list_for_each_safe(pos, next, &pgdata->split_queue) {
+			page = list_entry((void *)pos, struct page, mapping);
+			page = compound_head(page);
+			if (get_page_unless_zero(page)) {
+				list_move(page_deferred_list(page), &list);
+			} else {
+				/* We lost race with put_compound_page() */
+				list_del_init(page_deferred_list(page));
+				pgdata->split_queue_len--;
+			}
+			if (!--sc->nr_to_scan)
+				break;
 		}
-		if (!--sc->nr_to_scan)
-			break;
+		spin_unlock_irqrestore(&pgdata->split_queue_lock, flags);
+	} else {
+		spin_lock_irqsave(&sc->memcg->split_queue_lock, flags);
+		list_for_each_safe(pos, next, &sc->memcg->split_queue) {
+			page = list_entry((void *)pos, struct page, mapping);
+			page = compound_head(page);
+			if (get_page_unless_zero(page)) {
+				list_move(page_memcg_deferred_list(page), &list);
+			} else {
+				/* We lost race with put_compound_page() */
+				list_del_init(page_memcg_deferred_list(page));
+				sc->memcg->split_queue_len--;
+			}
+			if (!--sc->nr_to_scan)
+				break;
+		}
+		spin_unlock_irqrestore(&sc->memcg->split_queue_lock, flags);
 	}
-	spin_unlock_irqrestore(&pgdata->split_queue_lock, flags);
 
 	list_for_each_safe(pos, next, &list) {
 		page = list_entry((void *)pos, struct page, mapping);
@@ -2866,16 +2939,29 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
 		put_page(page);
 	}
 
-	spin_lock_irqsave(&pgdata->split_queue_lock, flags);
-	list_splice_tail(&list, &pgdata->split_queue);
-	spin_unlock_irqrestore(&pgdata->split_queue_lock, flags);
-
+	if (!sc->memcg) {
+		spin_lock_irqsave(&pgdata->split_queue_lock, flags);
+		list_splice_tail(&list, &pgdata->split_queue);
+		spin_unlock_irqrestore(&pgdata->split_queue_lock, flags);
+	} else {
+		spin_lock_irqsave(&sc->memcg->split_queue_lock, flags);
+		list_splice_tail(&list, &sc->memcg->split_queue);
+		spin_unlock_irqrestore(&sc->memcg->split_queue_lock, flags);
+	}
 	/*
 	 * Stop shrinker if we didn't split any page, but the queue is empty.
 	 * This can happen if pages were freed under us.
 	 */
-	if (!split && list_empty(&pgdata->split_queue))
-		return SHRINK_STOP;
+	if (!split) {
+		if (!sc->memcg) {
+			if (list_empty(&pgdata->split_queue))
+				return SHRINK_STOP;
+		} else {
+			if (list_empty(&sc->memcg->split_queue))
+				return SHRINK_STOP;
+		}
+	}
+
 	return split;
 }
 
@@ -2883,7 +2969,7 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
 	.count_objects = deferred_split_count,
 	.scan_objects = deferred_split_scan,
 	.seeks = DEFAULT_SEEKS,
-	.flags = SHRINKER_NUMA_AWARE,
+	.flags = SHRINKER_NUMA_AWARE | SHRINKER_MEMCG_AWARE,
 };
 
 #ifdef CONFIG_DEBUG_FS
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index e50a2db..6418fa0 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4579,6 +4579,11 @@ static struct mem_cgroup *mem_cgroup_alloc(void)
 #ifdef CONFIG_CGROUP_WRITEBACK
 	INIT_LIST_HEAD(&memcg->cgwb_list);
 #endif
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+	spin_lock_init(&memcg->split_queue_lock);
+	INIT_LIST_HEAD(&memcg->split_queue);
+	memcg->split_queue_len = 0;
+#endif
 	idr_replace(&mem_cgroup_idr, memcg, memcg->id.id);
 	return memcg;
 fail:
@@ -4949,6 +4954,21 @@ static int mem_cgroup_move_account(struct page *page,
 		__mod_memcg_state(to, NR_WRITEBACK, nr_pages);
 	}
 
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+	if (compound && !list_empty(page_memcg_deferred_list(page))) {
+		spin_lock(&from->split_queue_lock);
+		list_del(page_memcg_deferred_list(page));
+		from->split_queue_len--;
+		spin_unlock(&from->split_queue_lock);
+
+		spin_lock(&to->split_queue_lock);
+		list_add_tail(page_memcg_deferred_list(page),
+			      &to->split_queue);
+		to->split_queue_len++;
+		spin_unlock(&to->split_queue_lock);
+	}
+#endif
+
 	/*
 	 * It is safe to change page->mem_cgroup here because the page
 	 * is referenced, charged, and isolated - we can't race with
diff --git a/mm/swap.c b/mm/swap.c
index 3a75722..3348295 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -69,6 +69,10 @@ static void __page_cache_release(struct page *page)
 		del_page_from_lru_list(page, lruvec, page_off_lru(page));
 		spin_unlock_irqrestore(&pgdat->lru_lock, flags);
 	}
+
+	/* Delete THP from deferred split queue before memcg uncharge */
+	del_thp_from_deferred_split_queue(page);
+
 	__ClearPageWaiters(page);
 	mem_cgroup_uncharge(page);
 }
-- 
1.8.3.1

