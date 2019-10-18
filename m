Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5651BCA9ECC
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 00:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08996222C6
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 00:28:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="rj4LgSTF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406924AbfJRA2l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 20:28:41 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:41272 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2406858AbfJRA2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 20:28:38 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9I0OM30013489
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 17:28:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=lDMfG9E4iIMfu/wUSmuJUiD5Jhprmh1yfQmARapRliw=;
 b=rj4LgSTFiHzGi8ve2tng28zEC+7b+UIB1XM6BmeACe1Zhgu6QV5YE/EK48GNdVFSG4qh
 p0IA/HX4jqNo+pkxMM4VWSdAo8keK5Vg6baonCEjKB85YWoO2CReDA06qjPJseIuXlbC
 uBDdFig0yHbK/trrCi82r7sPlqwQsvdwGB4= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2vpufxt2ku-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 17:28:37 -0700
Received: from 2401:db00:30:6007:face:0:1:0 (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 17 Oct 2019 17:28:35 -0700
Received: by devvm2643.prn2.facebook.com (Postfix, from userid 111017)
        id E883118CE8479; Thu, 17 Oct 2019 17:28:33 -0700 (PDT)
Smtp-Origin-Hostprefix: devvm
From:   Roman Gushchin <guro@fb.com>
Smtp-Origin-Hostname: devvm2643.prn2.facebook.com
To:     <linux-mm@kvack.org>
CC:     Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Waiman Long <longman@redhat.com>,
        Christoph Lameter <cl@linux.com>, Roman Gushchin <guro@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH 03/16] mm: vmstat: convert slab vmstat counter to bytes
Date:   Thu, 17 Oct 2019 17:28:07 -0700
Message-ID: <20191018002820.307763-4-guro@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191018002820.307763-1-guro@fb.com>
References: <20191018002820.307763-1-guro@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-17_07:2019-10-17,2019-10-17 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 phishscore=0
 lowpriorityscore=0 suspectscore=3 clxscore=1015 bulkscore=0 spamscore=0
 adultscore=0 mlxlogscore=999 impostorscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910180001
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to prepare for per-object slab memory accounting,
convert NR_SLAB_RECLAIMABLE and NR_SLAB_UNRECLAIMABLE vmstat
items to bytes.

To make sure that these vmstats are in bytes, rename them
to NR_SLAB_RECLAIMABLE_B and NR_SLAB_UNRECLAIMABLE_B (similar to
NR_KERNEL_STACK_KB).

The size of slab memory shouldn't exceed 4Gb on 32-bit machines,
so it will fit into atomic_long_t we use for vmstats.

Signed-off-by: Roman Gushchin <guro@fb.com>
---
 drivers/base/node.c     | 14 +++++++++-----
 fs/proc/meminfo.c       |  4 ++--
 include/linux/mmzone.h  | 10 ++++++++--
 include/linux/vmstat.h  |  8 ++++++++
 kernel/power/snapshot.c |  2 +-
 mm/memcontrol.c         | 29 ++++++++++++++++-------------
 mm/oom_kill.c           |  2 +-
 mm/page_alloc.c         |  8 ++++----
 mm/slab.h               | 15 ++++++++-------
 mm/slab_common.c        |  4 ++--
 mm/slob.c               | 12 ++++++------
 mm/slub.c               |  8 ++++----
 mm/vmscan.c             |  3 ++-
 mm/vmstat.c             | 21 +++++++++++++++++++--
 mm/workingset.c         |  6 ++++--
 15 files changed, 94 insertions(+), 52 deletions(-)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index 98a31bafc8a2..fa07c5806dcd 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -368,8 +368,8 @@ static ssize_t node_read_meminfo(struct device *dev,
 	unsigned long sreclaimable, sunreclaimable;
 
 	si_meminfo_node(&i, nid);
-	sreclaimable = node_page_state(pgdat, NR_SLAB_RECLAIMABLE);
-	sunreclaimable = node_page_state(pgdat, NR_SLAB_UNRECLAIMABLE);
+	sreclaimable = node_page_state_pages(pgdat, NR_SLAB_RECLAIMABLE_B);
+	sunreclaimable = node_page_state_pages(pgdat, NR_SLAB_UNRECLAIMABLE_B);
 	n = sprintf(buf,
 		       "Node %d MemTotal:       %8lu kB\n"
 		       "Node %d MemFree:        %8lu kB\n"
@@ -505,9 +505,13 @@ static ssize_t node_read_vmstat(struct device *dev,
 			     sum_zone_numa_state(nid, i));
 #endif
 
-	for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++)
-		n += sprintf(buf+n, "%s %lu\n", node_stat_name(i),
-			     node_page_state(pgdat, i));
+	for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++) {
+		unsigned long x = node_page_state(pgdat, i);
+
+		if (vmstat_item_in_bytes(i))
+			x >>= PAGE_SHIFT;
+		n += sprintf(buf+n, "%s %lu\n", node_stat_name(i), x);
+	}
 
 	return n;
 }
diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
index ac9247371871..87afa8683c1b 100644
--- a/fs/proc/meminfo.c
+++ b/fs/proc/meminfo.c
@@ -53,8 +53,8 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
 		pages[lru] = global_node_page_state(NR_LRU_BASE + lru);
 
 	available = si_mem_available();
-	sreclaimable = global_node_page_state(NR_SLAB_RECLAIMABLE);
-	sunreclaim = global_node_page_state(NR_SLAB_UNRECLAIMABLE);
+	sreclaimable = global_node_page_state_pages(NR_SLAB_RECLAIMABLE_B);
+	sunreclaim = global_node_page_state_pages(NR_SLAB_UNRECLAIMABLE_B);
 
 	show_val_kb(m, "MemTotal:       ", i.totalram);
 	show_val_kb(m, "MemFree:        ", i.freeram);
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 4d8adaa5d59c..e20c200bff95 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -215,8 +215,8 @@ enum node_stat_item {
 	NR_INACTIVE_FILE,	/*  "     "     "   "       "         */
 	NR_ACTIVE_FILE,		/*  "     "     "   "       "         */
 	NR_UNEVICTABLE,		/*  "     "     "   "       "         */
-	NR_SLAB_RECLAIMABLE,	/* Please do not reorder this item */
-	NR_SLAB_UNRECLAIMABLE,	/* and this one without looking at
+	NR_SLAB_RECLAIMABLE_B,	/* Please do not reorder this item */
+	NR_SLAB_UNRECLAIMABLE_B,/* and this one without looking at
 				 * memcg_flush_percpu_vmstats() first. */
 	NR_ISOLATED_ANON,	/* Temporary isolated pages from anon lru */
 	NR_ISOLATED_FILE,	/* Temporary isolated pages from file lru */
@@ -247,6 +247,12 @@ enum node_stat_item {
 	NR_VM_NODE_STAT_ITEMS
 };
 
+static __always_inline bool vmstat_item_in_bytes(enum node_stat_item item)
+{
+	return (item == NR_SLAB_RECLAIMABLE_B ||
+		item == NR_SLAB_UNRECLAIMABLE_B);
+}
+
 /*
  * We do arithmetic on the LRU lists in various places in the code,
  * so it is important to keep the active lists LRU_ACTIVE higher in
diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
index 292485f3d24d..5b0f61b3ca75 100644
--- a/include/linux/vmstat.h
+++ b/include/linux/vmstat.h
@@ -200,6 +200,12 @@ static inline unsigned long global_node_page_state(enum node_stat_item item)
 	return x;
 }
 
+static inline
+unsigned long global_node_page_state_pages(enum node_stat_item item)
+{
+	return global_node_page_state(item) >> PAGE_SHIFT;
+}
+
 static inline unsigned long zone_page_state(struct zone *zone,
 					enum zone_stat_item item)
 {
@@ -240,6 +246,8 @@ extern unsigned long sum_zone_node_page_state(int node,
 extern unsigned long sum_zone_numa_state(int node, enum numa_stat_item item);
 extern unsigned long node_page_state(struct pglist_data *pgdat,
 						enum node_stat_item item);
+extern unsigned long node_page_state_pages(struct pglist_data *pgdat,
+					   enum node_stat_item item);
 #else
 #define sum_zone_node_page_state(node, item) global_zone_page_state(item)
 #define node_page_state(node, item) global_node_page_state(item)
diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index 26b9168321e7..d3911f75c39b 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -1666,7 +1666,7 @@ static unsigned long minimum_image_size(unsigned long saveable)
 {
 	unsigned long size;
 
-	size = global_node_page_state(NR_SLAB_RECLAIMABLE)
+	size = global_node_page_state_pages(NR_SLAB_RECLAIMABLE_B)
 		+ global_node_page_state(NR_ACTIVE_ANON)
 		+ global_node_page_state(NR_INACTIVE_ANON)
 		+ global_node_page_state(NR_ACTIVE_FILE)
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index cd8ac747827e..9303e98b0718 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -751,13 +751,16 @@ mem_cgroup_largest_soft_limit_node(struct mem_cgroup_tree_per_node *mctz)
  */
 void __mod_memcg_state(struct mem_cgroup *memcg, int idx, int val)
 {
-	long x;
+	long x, threshold = MEMCG_CHARGE_BATCH;
 
 	if (mem_cgroup_disabled())
 		return;
 
+	if (vmstat_item_in_bytes(idx))
+		threshold <<= PAGE_SHIFT;
+
 	x = val + __this_cpu_read(memcg->vmstats_percpu->stat[idx]);
-	if (unlikely(abs(x) > MEMCG_CHARGE_BATCH)) {
+	if (unlikely(abs(x) > threshold)) {
 		struct mem_cgroup *mi;
 
 		/*
@@ -799,7 +802,7 @@ void __mod_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
 	pg_data_t *pgdat = lruvec_pgdat(lruvec);
 	struct mem_cgroup_per_node *pn;
 	struct mem_cgroup *memcg;
-	long x;
+	long x, threshold = MEMCG_CHARGE_BATCH;
 
 	/* Update node */
 	__mod_node_page_state(pgdat, idx, val);
@@ -816,8 +819,11 @@ void __mod_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
 	/* Update lruvec */
 	__this_cpu_add(pn->lruvec_stat_local->count[idx], val);
 
+	if (vmstat_item_in_bytes(idx))
+		threshold <<= PAGE_SHIFT;
+
 	x = val + __this_cpu_read(pn->lruvec_stat_cpu->count[idx]);
-	if (unlikely(abs(x) > MEMCG_CHARGE_BATCH)) {
+	if (unlikely(abs(x) > threshold)) {
 		struct mem_cgroup_per_node *pi;
 
 		for (pi = pn; pi; pi = parent_nodeinfo(pi, pgdat->node_id))
@@ -1466,9 +1472,8 @@ static char *memory_stat_format(struct mem_cgroup *memcg)
 		       (u64)memcg_page_state(memcg, MEMCG_KERNEL_STACK_KB) *
 		       1024);
 	seq_buf_printf(&s, "slab %llu\n",
-		       (u64)(memcg_page_state(memcg, NR_SLAB_RECLAIMABLE) +
-			     memcg_page_state(memcg, NR_SLAB_UNRECLAIMABLE)) *
-		       PAGE_SIZE);
+		       (u64)(memcg_page_state(memcg, NR_SLAB_RECLAIMABLE_B) +
+			     memcg_page_state(memcg, NR_SLAB_UNRECLAIMABLE_B)));
 	seq_buf_printf(&s, "sock %llu\n",
 		       (u64)memcg_page_state(memcg, MEMCG_SOCK) *
 		       PAGE_SIZE);
@@ -1502,11 +1507,9 @@ static char *memory_stat_format(struct mem_cgroup *memcg)
 			       PAGE_SIZE);
 
 	seq_buf_printf(&s, "slab_reclaimable %llu\n",
-		       (u64)memcg_page_state(memcg, NR_SLAB_RECLAIMABLE) *
-		       PAGE_SIZE);
+		       (u64)memcg_page_state(memcg, NR_SLAB_RECLAIMABLE_B));
 	seq_buf_printf(&s, "slab_unreclaimable %llu\n",
-		       (u64)memcg_page_state(memcg, NR_SLAB_UNRECLAIMABLE) *
-		       PAGE_SIZE);
+		       (u64)memcg_page_state(memcg, NR_SLAB_UNRECLAIMABLE_B));
 
 	/* Accumulated memory events */
 
@@ -3582,8 +3585,8 @@ static void memcg_flush_percpu_vmstats(struct mem_cgroup *memcg, bool slab_only)
 	int min_idx, max_idx;
 
 	if (slab_only) {
-		min_idx = NR_SLAB_RECLAIMABLE;
-		max_idx = NR_SLAB_UNRECLAIMABLE;
+		min_idx = NR_SLAB_RECLAIMABLE_B;
+		max_idx = NR_SLAB_UNRECLAIMABLE_B;
 	} else {
 		min_idx = 0;
 		max_idx = MEMCG_NR_STAT;
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 314ce1a3cf25..61476bf0f147 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -183,7 +183,7 @@ static bool is_dump_unreclaim_slabs(void)
 		 global_node_page_state(NR_ISOLATED_FILE) +
 		 global_node_page_state(NR_UNEVICTABLE);
 
-	return (global_node_page_state(NR_SLAB_UNRECLAIMABLE) > nr_lru);
+	return (global_node_page_state_pages(NR_SLAB_UNRECLAIMABLE_B) > nr_lru);
 }
 
 /**
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index cd1dd0712624..c037bdaa73a1 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5130,8 +5130,8 @@ long si_mem_available(void)
 	 * items that are in use, and cannot be freed. Cap this estimate at the
 	 * low watermark.
 	 */
-	reclaimable = global_node_page_state(NR_SLAB_RECLAIMABLE) +
-			global_node_page_state(NR_KERNEL_MISC_RECLAIMABLE);
+	reclaimable = global_node_page_state_pages(NR_SLAB_RECLAIMABLE_B) +
+		global_node_page_state(NR_KERNEL_MISC_RECLAIMABLE);
 	available += reclaimable - min(reclaimable / 2, wmark_low);
 
 	if (available < 0)
@@ -5275,8 +5275,8 @@ void show_free_areas(unsigned int filter, nodemask_t *nodemask)
 		global_node_page_state(NR_FILE_DIRTY),
 		global_node_page_state(NR_WRITEBACK),
 		global_node_page_state(NR_UNSTABLE_NFS),
-		global_node_page_state(NR_SLAB_RECLAIMABLE),
-		global_node_page_state(NR_SLAB_UNRECLAIMABLE),
+		global_node_page_state_pages(NR_SLAB_RECLAIMABLE_B),
+		global_node_page_state_pages(NR_SLAB_UNRECLAIMABLE_B),
 		global_node_page_state(NR_FILE_MAPPED),
 		global_node_page_state(NR_SHMEM),
 		global_zone_page_state(NR_PAGETABLE),
diff --git a/mm/slab.h b/mm/slab.h
index 3eb29ae75743..03833b02b9ae 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -272,7 +272,7 @@ int __kmem_cache_alloc_bulk(struct kmem_cache *, gfp_t, size_t, void **);
 static inline int cache_vmstat_idx(struct kmem_cache *s)
 {
 	return (s->flags & SLAB_RECLAIM_ACCOUNT) ?
-		NR_SLAB_RECLAIMABLE : NR_SLAB_UNRECLAIMABLE;
+		NR_SLAB_RECLAIMABLE_B : NR_SLAB_UNRECLAIMABLE_B;
 }
 
 #ifdef CONFIG_MEMCG_KMEM
@@ -360,7 +360,7 @@ static __always_inline int memcg_charge_slab(struct page *page,
 
 	if (unlikely(!memcg || mem_cgroup_is_root(memcg))) {
 		mod_node_page_state(page_pgdat(page), cache_vmstat_idx(s),
-				    (1 << order));
+				    (PAGE_SIZE << order));
 		percpu_ref_get_many(&s->memcg_params.refcnt, 1 << order);
 		return 0;
 	}
@@ -370,7 +370,7 @@ static __always_inline int memcg_charge_slab(struct page *page,
 		goto out;
 
 	lruvec = mem_cgroup_lruvec(page_pgdat(page), memcg);
-	mod_lruvec_state(lruvec, cache_vmstat_idx(s), 1 << order);
+	mod_lruvec_state(lruvec, cache_vmstat_idx(s), PAGE_SIZE << order);
 
 	/* transer try_charge() page references to kmem_cache */
 	percpu_ref_get_many(&s->memcg_params.refcnt, 1 << order);
@@ -394,11 +394,12 @@ static __always_inline void memcg_uncharge_slab(struct page *page, int order,
 	memcg = READ_ONCE(s->memcg_params.memcg);
 	if (likely(!mem_cgroup_is_root(memcg))) {
 		lruvec = mem_cgroup_lruvec(page_pgdat(page), memcg);
-		mod_lruvec_state(lruvec, cache_vmstat_idx(s), -(1 << order));
+		mod_lruvec_state(lruvec, cache_vmstat_idx(s),
+				 -(PAGE_SIZE << order));
 		memcg_kmem_uncharge_memcg(page, order, memcg);
 	} else {
 		mod_node_page_state(page_pgdat(page), cache_vmstat_idx(s),
-				    -(1 << order));
+				    -(PAGE_SIZE << order));
 	}
 	rcu_read_unlock();
 
@@ -482,7 +483,7 @@ static __always_inline int charge_slab_page(struct page *page,
 {
 	if (is_root_cache(s)) {
 		mod_node_page_state(page_pgdat(page), cache_vmstat_idx(s),
-				    1 << order);
+				    PAGE_SIZE << order);
 		return 0;
 	}
 
@@ -494,7 +495,7 @@ static __always_inline void uncharge_slab_page(struct page *page, int order,
 {
 	if (is_root_cache(s)) {
 		mod_node_page_state(page_pgdat(page), cache_vmstat_idx(s),
-				    -(1 << order));
+				    -(PAGE_SIZE << order));
 		return;
 	}
 
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 8afa188f6e20..f0f7f955c5fa 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -1311,8 +1311,8 @@ void *kmalloc_order(size_t size, gfp_t flags, unsigned int order)
 	page = alloc_pages(flags, order);
 	if (likely(page)) {
 		ret = page_address(page);
-		mod_node_page_state(page_pgdat(page), NR_SLAB_UNRECLAIMABLE,
-				    1 << order);
+		mod_node_page_state(page_pgdat(page), NR_SLAB_UNRECLAIMABLE_B,
+				    PAGE_SIZE << order);
 	}
 	ret = kasan_kmalloc_large(ret, size, flags);
 	/* As ret might get tagged, call kmemleak hook after KASAN. */
diff --git a/mm/slob.c b/mm/slob.c
index fa53e9f73893..8b7b56235438 100644
--- a/mm/slob.c
+++ b/mm/slob.c
@@ -202,8 +202,8 @@ static void *slob_new_pages(gfp_t gfp, int order, int node)
 	if (!page)
 		return NULL;
 
-	mod_node_page_state(page_pgdat(page), NR_SLAB_UNRECLAIMABLE,
-			    1 << order);
+	mod_node_page_state(page_pgdat(page), NR_SLAB_UNRECLAIMABLE_B,
+			    PAGE_SIZE << order);
 	return page_address(page);
 }
 
@@ -214,8 +214,8 @@ static void slob_free_pages(void *b, int order)
 	if (current->reclaim_state)
 		current->reclaim_state->reclaimed_slab += 1 << order;
 
-	mod_node_page_state(page_pgdat(sp), NR_SLAB_UNRECLAIMABLE,
-			    -(1 << order));
+	mod_node_page_state(page_pgdat(sp), NR_SLAB_UNRECLAIMABLE_B,
+			    -(PAGE_SIZE << order));
 	__free_pages(sp, order);
 }
 
@@ -550,8 +550,8 @@ void kfree(const void *block)
 		slob_free(m, *m + align);
 	} else {
 		unsigned int order = compound_order(sp);
-		mod_node_page_state(page_pgdat(sp), NR_SLAB_UNRECLAIMABLE,
-				    -(1 << order));
+		mod_node_page_state(page_pgdat(sp), NR_SLAB_UNRECLAIMABLE_B,
+				    -(PAGE_SIZE << order));
 		__free_pages(sp, order);
 
 	}
diff --git a/mm/slub.c b/mm/slub.c
index 249e4c8be66a..bd902d65a71c 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3838,8 +3838,8 @@ static void *kmalloc_large_node(size_t size, gfp_t flags, int node)
 	page = alloc_pages_node(node, flags, order);
 	if (page) {
 		ptr = page_address(page);
-		mod_node_page_state(page_pgdat(page), NR_SLAB_UNRECLAIMABLE,
-				    1 << order);
+		mod_node_page_state(page_pgdat(page), NR_SLAB_UNRECLAIMABLE_B,
+				    PAGE_SIZE << order);
 	}
 
 	return kmalloc_large_node_hook(ptr, size, flags);
@@ -3970,8 +3970,8 @@ void kfree(const void *x)
 
 		BUG_ON(!PageCompound(page));
 		kfree_hook(object);
-		mod_node_page_state(page_pgdat(page), NR_SLAB_UNRECLAIMABLE,
-				    -(1 << order));
+		mod_node_page_state(page_pgdat(page), NR_SLAB_UNRECLAIMABLE_B,
+				    -(PAGE_SIZE << order));
 		__free_pages(page, order);
 		return;
 	}
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 50c81463797b..990e4b455b7d 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4272,7 +4272,8 @@ int node_reclaim(struct pglist_data *pgdat, gfp_t gfp_mask, unsigned int order)
 	 * unmapped file backed pages.
 	 */
 	if (node_pagecache_reclaimable(pgdat) <= pgdat->min_unmapped_pages &&
-	    node_page_state(pgdat, NR_SLAB_RECLAIMABLE) <= pgdat->min_slab_pages)
+	    node_page_state_pages(pgdat, NR_SLAB_RECLAIMABLE_B) <=
+	    pgdat->min_slab_pages)
 		return NODE_RECLAIM_FULL;
 
 	/*
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 3375e7f45891..1d10ffcecb9f 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -344,6 +344,8 @@ void __mod_node_page_state(struct pglist_data *pgdat, enum node_stat_item item,
 	x = delta + __this_cpu_read(*p);
 
 	t = __this_cpu_read(pcp->stat_threshold);
+	if (vmstat_item_in_bytes(item))
+		t <<= PAGE_SHIFT;
 
 	if (unlikely(x > t || x < -t)) {
 		node_page_state_add(x, pgdat, item);
@@ -555,6 +557,8 @@ static inline void mod_node_state(struct pglist_data *pgdat,
 		 * for all cpus in a node.
 		 */
 		t = this_cpu_read(pcp->stat_threshold);
+		if (vmstat_item_in_bytes(item))
+			t <<= PAGE_SHIFT;
 
 		o = this_cpu_read(*p);
 		n = delta + o;
@@ -999,6 +1003,12 @@ unsigned long node_page_state(struct pglist_data *pgdat,
 #endif
 	return x;
 }
+
+unsigned long node_page_state_pages(struct pglist_data *pgdat,
+				    enum node_stat_item item)
+{
+	return node_page_state(pgdat, item) >> PAGE_SHIFT;
+}
 #endif
 
 #ifdef CONFIG_COMPACTION
@@ -1548,8 +1558,12 @@ static void zoneinfo_show_print(struct seq_file *m, pg_data_t *pgdat,
 	if (is_zone_first_populated(pgdat, zone)) {
 		seq_printf(m, "\n  per-node stats");
 		for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++) {
+			unsigned long x = node_page_state(pgdat, i);
+
+			if (vmstat_item_in_bytes(i))
+				x >>= PAGE_SHIFT;
 			seq_printf(m, "\n      %-12s %lu", node_stat_name(i),
-				   node_page_state(pgdat, i));
+				   x);
 		}
 	}
 	seq_printf(m,
@@ -1671,8 +1685,11 @@ static void *vmstat_start(struct seq_file *m, loff_t *pos)
 	v += NR_VM_NUMA_STAT_ITEMS;
 #endif
 
-	for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++)
+	for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++) {
 		v[i] = global_node_page_state(i);
+		if (vmstat_item_in_bytes(i))
+			v[i] >>= PAGE_SHIFT;
+	}
 	v += NR_VM_NODE_STAT_ITEMS;
 
 	global_dirty_limits(v + NR_DIRTY_BG_THRESHOLD,
diff --git a/mm/workingset.c b/mm/workingset.c
index c963831d354f..675792387e58 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -430,8 +430,10 @@ static unsigned long count_shadow_nodes(struct shrinker *shrinker,
 		for (pages = 0, i = 0; i < NR_LRU_LISTS; i++)
 			pages += lruvec_page_state_local(lruvec,
 							 NR_LRU_BASE + i);
-		pages += lruvec_page_state_local(lruvec, NR_SLAB_RECLAIMABLE);
-		pages += lruvec_page_state_local(lruvec, NR_SLAB_UNRECLAIMABLE);
+		pages += lruvec_page_state_local(
+			lruvec, NR_SLAB_RECLAIMABLE_B) >> PAGE_SHIFT;
+		pages += lruvec_page_state_local(
+			lruvec, NR_SLAB_UNRECLAIMABLE_B) >> PAGE_SHIFT;
 	} else
 #endif
 		pages = node_present_pages(sc->nid);
-- 
2.21.0

