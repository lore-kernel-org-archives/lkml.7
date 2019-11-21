Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E46F6C43215
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 15:19:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D99B20674
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 15:19:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbfKUPTu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 10:19:50 -0500
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:35517 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbfKUPTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 10:19:49 -0500
X-Originating-IP: 153.3.140.100
Received: from localhost.localdomain.localdomain (unknown [153.3.140.100])
        (Authenticated sender: fly@kernel.page)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 965DE1C0017;
        Thu, 21 Nov 2019 15:19:37 +0000 (UTC)
From:   Pengfei Li <fly@kernel.page>
To:     akpm@linux-foundation.org
Cc:     mgorman@techsingularity.net, mhocko@kernel.org, vbabka@suse.cz,
        cl@linux.com, iamjoonsoo.kim@lge.com, guro@fb.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Pengfei Li <fly@kernel.page>
Subject: [RFC v1 01/19] mm, mmzone: modify zonelist to nodelist
Date:   Thu, 21 Nov 2019 23:17:53 +0800
Message-Id: <20191121151811.49742-2-fly@kernel.page>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191121151811.49742-1-fly@kernel.page>
References: <20191121151811.49742-1-fly@kernel.page>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Motivation
----------
Currently if we want to iterate through all the nodes we have to
traverse all the zones from the zonelist.

So in order to reduce the number of loops required to traverse node,
this series of patches modified the zonelist to nodelist.

Two new macros have been introduced:
1) for_each_node_nlist
2) for_each_node_nlist_nodemask

Benefit
-------
1. For a NUMA system with N nodes, each node has M zones, the number
   of loops is reduced from N*M times to N times when traversing node.

2. The size of pg_data_t is much reduced.

Signed-off-by: Pengfei Li <fly@kernel.page>
---
 drivers/tty/sysrq.c        |   2 +-
 include/linux/gfp.h        |  10 +-
 include/linux/mmzone.h     | 239 ++++++++++++++++++++-----------------
 include/linux/oom.h        |   4 +-
 include/linux/swap.h       |   2 +-
 include/trace/events/oom.h |   9 +-
 mm/compaction.c            |  18 +--
 mm/hugetlb.c               |   8 +-
 mm/internal.h              |   7 +-
 mm/memcontrol.c            |   2 +-
 mm/mempolicy.c             |  18 +--
 mm/mm_init.c               |  70 ++++++-----
 mm/mmzone.c                |  30 ++---
 mm/oom_kill.c              |  10 +-
 mm/page_alloc.c            | 207 +++++++++++++++++---------------
 mm/slab.c                  |   8 +-
 mm/slub.c                  |   8 +-
 mm/vmscan.c                |  34 +++---
 18 files changed, 367 insertions(+), 319 deletions(-)

diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index 573b2055173c..6c6fa8ba7397 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -362,7 +362,7 @@ static void moom_callback(struct work_struct *ignored)
 {
 	const gfp_t gfp_mask = GFP_KERNEL;
 	struct oom_control oc = {
-		.zonelist = node_zonelist(first_memory_node, gfp_mask),
+		.nodelist = node_nodelist(first_memory_node, gfp_mask),
 		.nodemask = NULL,
 		.memcg = NULL,
 		.gfp_mask = gfp_mask,
diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index e5b817cb86e7..6caab5a30f39 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -456,13 +456,13 @@ static inline enum zone_type gfp_zone(gfp_t flags)
  * virtual kernel addresses to the allocated page(s).
  */
 
-static inline int gfp_zonelist(gfp_t flags)
+static inline int gfp_nodelist(gfp_t flags)
 {
 #ifdef CONFIG_NUMA
 	if (unlikely(flags & __GFP_THISNODE))
-		return ZONELIST_NOFALLBACK;
+		return NODELIST_NOFALLBACK;
 #endif
-	return ZONELIST_FALLBACK;
+	return NODELIST_FALLBACK;
 }
 
 /*
@@ -474,9 +474,9 @@ static inline int gfp_zonelist(gfp_t flags)
  * For the normal case of non-DISCONTIGMEM systems the NODE_DATA() gets
  * optimized to &contig_page_data at compile-time.
  */
-static inline struct zonelist *node_zonelist(int nid, gfp_t flags)
+static inline struct nodelist *node_nodelist(int nid, gfp_t flags)
 {
-	return NODE_DATA(nid)->node_zonelists + gfp_zonelist(flags);
+	return NODE_DATA(nid)->node_nodelists + gfp_nodelist(flags);
 }
 
 #ifndef HAVE_ARCH_FREE_PAGE
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 89d8ff06c9ce..dd493239b8b2 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -644,46 +644,36 @@ static inline bool zone_intersects(struct zone *zone,
  */
 #define DEF_PRIORITY 12
 
-/* Maximum number of zones on a zonelist */
-#define MAX_ZONES_PER_ZONELIST (MAX_NUMNODES * MAX_NR_ZONES)
-
 enum {
-	ZONELIST_FALLBACK,	/* zonelist with fallback */
+	NODELIST_FALLBACK,	/* nodelist with fallback */
 #ifdef CONFIG_NUMA
 	/*
-	 * The NUMA zonelists are doubled because we need zonelists that
+	 * The NUMA zonelists are doubled because we need nodelists that
 	 * restrict the allocations to a single node for __GFP_THISNODE.
 	 */
-	ZONELIST_NOFALLBACK,	/* zonelist without fallback (__GFP_THISNODE) */
+	NODELIST_NOFALLBACK,	/* nodelist without fallback (__GFP_THISNODE) */
 #endif
-	MAX_ZONELISTS
+	MAX_NODELISTS
 };
 
 /*
- * This struct contains information about a zone in a zonelist. It is stored
+ * This struct contains information about a node in a zonelist. It is stored
  * here to avoid dereferences into large structures and lookups of tables
  */
-struct zoneref {
-	struct zone *zone;	/* Pointer to actual zone */
-	int zone_idx;		/* zone_idx(zoneref->zone) */
+struct nlist_entry {
+	unsigned int node_usable_zones;
+	int nid;
+	struct zone *zones;
 };
 
-/*
- * One allocation request operates on a zonelist. A zonelist
- * is a list of zones, the first one is the 'goal' of the
- * allocation, the other zones are fallback zones, in decreasing
- * priority.
- *
- * To speed the reading of the zonelist, the zonerefs contain the zone index
- * of the entry being read. Helper functions to access information given
- * a struct zoneref are
- *
- * zonelist_zone()	- Return the struct zone * for an entry in _zonerefs
- * zonelist_zone_idx()	- Return the index of the zone for an entry
- * zonelist_node_idx()	- Return the index of the node for an entry
- */
-struct zonelist {
-	struct zoneref _zonerefs[MAX_ZONES_PER_ZONELIST + 1];
+struct nodelist {
+	struct nlist_entry _nlist_entries[MAX_NUMNODES + 1];
+};
+
+struct nlist_traverser {
+	const struct nlist_entry *entry;
+	unsigned int highidx_mask;
+	unsigned int usable_zones;
 };
 
 #ifndef CONFIG_DISCONTIGMEM
@@ -710,7 +700,7 @@ struct deferred_split {
 struct bootmem_data;
 typedef struct pglist_data {
 	struct zone node_zones[MAX_NR_ZONES];
-	struct zonelist node_zonelists[MAX_ZONELISTS];
+	struct nodelist node_nodelists[MAX_NODELISTS];
 	int nr_zones;
 #ifdef CONFIG_FLAT_NODE_MEM_MAP	/* means !SPARSEMEM */
 	struct page *node_mem_map;
@@ -1018,105 +1008,138 @@ extern struct zone *next_zone(struct zone *zone);
 			; /* do nothing */		\
 		else
 
-static inline struct zone *zonelist_zone(struct zoneref *zoneref)
+#define usable_zones_add(ztype, usable_zones)			\
+	__set_bit(ztype, (unsigned long *)&usable_zones)
+
+#define usable_zones_remove(ztype, usable_zones)		\
+	__clear_bit(ztype, (unsigned long *)&usable_zones)
+
+#define usable_zones_highest(usable_zones)	\
+	__fls(usable_zones)
+
+void __next_nlist_entry_nodemask(struct nlist_traverser *t,
+					nodemask_t *nodemask);
+
+static inline int
+traverser_node(struct nlist_traverser *t)
 {
-	return zoneref->zone;
+	return t->entry->nid;
 }
 
-static inline int zonelist_zone_idx(struct zoneref *zoneref)
+static inline void
+init_nlist_traverser(struct nlist_traverser *t,
+			struct nodelist *nlist, enum zone_type highidx)
 {
-	return zoneref->zone_idx;
+	t->entry = nlist->_nlist_entries;
+	t->highidx_mask = (~(UINT_MAX << (highidx + 1)));
 }
 
-static inline int zonelist_node_idx(struct zoneref *zoneref)
+static inline unsigned int
+node_has_usable_zones(struct nlist_traverser *t)
 {
-	return zone_to_nid(zoneref->zone);
+	t->usable_zones = t->entry->node_usable_zones & t->highidx_mask;
+	return t->usable_zones;
 }
 
-struct zoneref *__next_zones_zonelist(struct zoneref *z,
-					enum zone_type highest_zoneidx,
-					nodemask_t *nodes);
+static __always_inline void
+next_nlist_entry(struct nlist_traverser *t)
+{
+	while (!node_has_usable_zones(t))
+		t->entry++;
+}
 
-/**
- * next_zones_zonelist - Returns the next zone at or below highest_zoneidx within the allowed nodemask using a cursor within a zonelist as a starting point
- * @z - The cursor used as a starting point for the search
- * @highest_zoneidx - The zone index of the highest zone to return
- * @nodes - An optional nodemask to filter the zonelist with
- *
- * This function returns the next zone at or below a given zone index that is
- * within the allowed nodemask using a cursor as the starting point for the
- * search. The zoneref returned is a cursor that represents the current zone
- * being examined. It should be advanced by one before calling
- * next_zones_zonelist again.
- */
-static __always_inline struct zoneref *next_zones_zonelist(struct zoneref *z,
-					enum zone_type highest_zoneidx,
-					nodemask_t *nodes)
+static __always_inline void
+next_nlist_entry_nodemask(struct nlist_traverser *t, nodemask_t *nodemask)
 {
-	if (likely(!nodes && zonelist_zone_idx(z) <= highest_zoneidx))
-		return z;
-	return __next_zones_zonelist(z, highest_zoneidx, nodes);
+	if (likely(!nodemask))
+		next_nlist_entry(t);
+	else
+		__next_nlist_entry_nodemask(t, nodemask);
 }
 
-/**
- * first_zones_zonelist - Returns the first zone at or below highest_zoneidx within the allowed nodemask in a zonelist
- * @zonelist - The zonelist to search for a suitable zone
- * @highest_zoneidx - The zone index of the highest zone to return
- * @nodes - An optional nodemask to filter the zonelist with
- * @return - Zoneref pointer for the first suitable zone found (see below)
- *
- * This function returns the first zone at or below a given zone index that is
- * within the allowed nodemask. The zoneref returned is a cursor that can be
- * used to iterate the zonelist with next_zones_zonelist by advancing it by
- * one before calling.
- *
- * When no eligible zone is found, zoneref->zone is NULL (zoneref itself is
- * never NULL). This may happen either genuinely, or due to concurrent nodemask
- * update due to cpuset modification.
- */
-static inline struct zoneref *first_zones_zonelist(struct zonelist *zonelist,
-					enum zone_type highest_zoneidx,
-					nodemask_t *nodes)
+#define for_each_node_nlist(node, t, nlist, highidx)		\
+	for (init_nlist_traverser(t, nlist, highidx),		\
+		next_nlist_entry(t), node = traverser_node(t);	\
+	     node != NUMA_NO_NODE;				\
+	     (t)->entry++,					\
+		next_nlist_entry(t), node = traverser_node(t))
+
+#define for_each_node_nlist_nodemask(node, t, nlist, highidx, nodemask) \
+	for (init_nlist_traverser(t, nlist, highidx),			\
+		next_nlist_entry_nodemask(t, nodemask),			\
+		node = traverser_node(t);				\
+	     node != NUMA_NO_NODE;					\
+	     (t)->entry++, next_nlist_entry_nodemask(t, nodemask),	\
+		node = traverser_node(t))
+
+static inline int
+first_node_nlist_nodemask(struct nodelist *nlist,
+				enum zone_type highidx, nodemask_t *nodemask)
 {
-	return next_zones_zonelist(zonelist->_zonerefs,
-							highest_zoneidx, nodes);
+	struct nlist_traverser t;
+
+	init_nlist_traverser(&t, nlist, highidx);
+	next_nlist_entry_nodemask(&t, nodemask);
+
+	return traverser_node(&t);
 }
 
-/**
- * for_each_zone_zonelist_nodemask - helper macro to iterate over valid zones in a zonelist at or below a given zone index and within a nodemask
- * @zone - The current zone in the iterator
- * @z - The current pointer within zonelist->_zonerefs being iterated
- * @zlist - The zonelist being iterated
- * @highidx - The zone index of the highest zone to return
- * @nodemask - Nodemask allowed by the allocator
- *
- * This iterator iterates though all zones at or below a given zone index and
- * within a given nodemask
- */
-#define for_each_zone_zonelist_nodemask(zone, z, zlist, highidx, nodemask) \
-	for (z = first_zones_zonelist(zlist, highidx, nodemask), zone = zonelist_zone(z);	\
-		zone;							\
-		z = next_zones_zonelist(++z, highidx, nodemask),	\
-			zone = zonelist_zone(z))
+static inline struct zone *
+traverser_zone(struct nlist_traverser *t)
+{
+	enum zone_type ztype = usable_zones_highest(t->usable_zones);
 
-#define for_next_zone_zonelist_nodemask(zone, z, zlist, highidx, nodemask) \
-	for (zone = z->zone;	\
-		zone;							\
-		z = next_zones_zonelist(++z, highidx, nodemask),	\
-			zone = zonelist_zone(z))
+	usable_zones_remove(ztype, t->usable_zones);
 
+	return (t->entry->zones + ztype);
+}
 
-/**
- * for_each_zone_zonelist - helper macro to iterate over valid zones in a zonelist at or below a given zone index
- * @zone - The current zone in the iterator
- * @z - The current pointer within zonelist->zones being iterated
- * @zlist - The zonelist being iterated
- * @highidx - The zone index of the highest zone to return
- *
- * This iterator iterates though all zones at or below a given zone index.
- */
-#define for_each_zone_zonelist(zone, z, zlist, highidx) \
-	for_each_zone_zonelist_nodemask(zone, z, zlist, highidx, NULL)
+static inline struct zone *
+get_zone_nlist(struct nlist_traverser *t)
+{
+	next_nlist_entry(t);
+
+	if (!t->entry->zones)
+		return NULL;
+
+	return traverser_zone(t);
+}
+
+static inline struct zone *
+get_zone_nlist_nodemask(struct nlist_traverser *t, nodemask_t *nodemask)
+{
+	next_nlist_entry_nodemask(t, nodemask);
+
+	if (!t->entry->zones)
+		return NULL;
+
+	return traverser_zone(t);
+}
+
+#define for_each_zone_nlist(zone, t, nlist, highidx)			\
+	for (init_nlist_traverser(t, nlist, highidx),			\
+		zone = get_zone_nlist(t);				\
+	     zone;							\
+	     zone = ((t)->usable_zones ? traverser_zone(t)		\
+				: ((t)->entry++, get_zone_nlist(t))))
+
+#define for_each_zone_nlist_nodemask(zone, t, nlist, highidx, nodemask)	\
+	for (init_nlist_traverser(t, nlist, highidx),				\
+		zone = get_zone_nlist_nodemask(t, nodemask);			\
+	     zone;								\
+	     zone = ((t)->usable_zones ? traverser_zone(t)			\
+			: ((t)->entry++, get_zone_nlist_nodemask(t, nodemask))))
+
+static inline struct zone *
+first_zone_nlist_nodemask(struct nodelist *nlist,
+				enum zone_type highidx, nodemask_t *nodemask)
+{
+	struct nlist_traverser t;
+
+	init_nlist_traverser(&t, nlist, highidx);
+
+	return get_zone_nlist_nodemask(&t, nodemask);
+}
 
 #ifdef CONFIG_SPARSEMEM
 #include <asm/sparsemem.h>
diff --git a/include/linux/oom.h b/include/linux/oom.h
index c696c265f019..634b1d2a81fa 100644
--- a/include/linux/oom.h
+++ b/include/linux/oom.h
@@ -10,7 +10,7 @@
 #include <linux/sched/coredump.h> /* MMF_* */
 #include <linux/mm.h> /* VM_FAULT* */
 
-struct zonelist;
+struct nodelist;
 struct notifier_block;
 struct mem_cgroup;
 struct task_struct;
@@ -28,7 +28,7 @@ enum oom_constraint {
  */
 struct oom_control {
 	/* Used to determine cpuset */
-	struct zonelist *zonelist;
+	struct nodelist *nodelist;
 
 	/* Used to determine mempolicy */
 	nodemask_t *nodemask;
diff --git a/include/linux/swap.h b/include/linux/swap.h
index 1e99f7ac1d7e..c041d7478ec8 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -349,7 +349,7 @@ extern void lru_cache_add_active_or_unevictable(struct page *page,
 
 /* linux/mm/vmscan.c */
 extern unsigned long zone_reclaimable_pages(struct zone *zone);
-extern unsigned long try_to_free_pages(struct zonelist *zonelist, int order,
+extern unsigned long try_to_free_pages(struct nodelist *nodelist, int order,
 					gfp_t gfp_mask, nodemask_t *mask);
 extern int __isolate_lru_page(struct page *page, isolate_mode_t mode);
 extern unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
diff --git a/include/trace/events/oom.h b/include/trace/events/oom.h
index 26a11e4a2c36..08007ea34243 100644
--- a/include/trace/events/oom.h
+++ b/include/trace/events/oom.h
@@ -31,7 +31,8 @@ TRACE_EVENT(oom_score_adj_update,
 
 TRACE_EVENT(reclaim_retry_zone,
 
-	TP_PROTO(struct zoneref *zoneref,
+	TP_PROTO(int node,
+		struct zone *zone,
 		int order,
 		unsigned long reclaimable,
 		unsigned long available,
@@ -39,7 +40,7 @@ TRACE_EVENT(reclaim_retry_zone,
 		int no_progress_loops,
 		bool wmark_check),
 
-	TP_ARGS(zoneref, order, reclaimable, available, min_wmark, no_progress_loops, wmark_check),
+	TP_ARGS(node, zone, order, reclaimable, available, min_wmark, no_progress_loops, wmark_check),
 
 	TP_STRUCT__entry(
 		__field(	int, node)
@@ -53,8 +54,8 @@ TRACE_EVENT(reclaim_retry_zone,
 	),
 
 	TP_fast_assign(
-		__entry->node = zone_to_nid(zoneref->zone);
-		__entry->zone_idx = zoneref->zone_idx;
+		__entry->node = node;
+		__entry->zone_idx = zone_idx(zone);
 		__entry->order = order;
 		__entry->reclaimable = reclaimable;
 		__entry->available = available;
diff --git a/mm/compaction.c b/mm/compaction.c
index 672d3c78c6ab..d9f42e18991c 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -2039,15 +2039,15 @@ enum compact_result compaction_suitable(struct zone *zone, int order,
 bool compaction_zonelist_suitable(struct alloc_context *ac, int order,
 		int alloc_flags)
 {
+	struct nlist_traverser t;
 	struct zone *zone;
-	struct zoneref *z;
 
 	/*
 	 * Make sure at least one zone would pass __compaction_suitable if we continue
 	 * retrying the reclaim.
 	 */
-	for_each_zone_zonelist_nodemask(zone, z, ac->zonelist, ac->high_zoneidx,
-					ac->nodemask) {
+	for_each_zone_nlist_nodemask(zone, &t, ac->nodelist,
+					ac->high_zoneidx, ac->nodemask) {
 		unsigned long available;
 		enum compact_result compact_result;
 
@@ -2060,7 +2060,7 @@ bool compaction_zonelist_suitable(struct alloc_context *ac, int order,
 		available = zone_reclaimable_pages(zone) / order;
 		available += zone_page_state_snapshot(zone, NR_FREE_PAGES);
 		compact_result = __compaction_suitable(zone, order, alloc_flags,
-				ac_classzone_idx(ac), available);
+				ac->classzone_idx, available);
 		if (compact_result != COMPACT_SKIPPED)
 			return true;
 	}
@@ -2341,9 +2341,9 @@ enum compact_result try_to_compact_pages(gfp_t gfp_mask, unsigned int order,
 		enum compact_priority prio, struct page **capture)
 {
 	int may_perform_io = gfp_mask & __GFP_IO;
-	struct zoneref *z;
-	struct zone *zone;
 	enum compact_result rc = COMPACT_SKIPPED;
+	struct nlist_traverser t;
+	struct zone *zone;
 
 	/*
 	 * Check if the GFP flags allow compaction - GFP_NOIO is really
@@ -2355,8 +2355,8 @@ enum compact_result try_to_compact_pages(gfp_t gfp_mask, unsigned int order,
 	trace_mm_compaction_try_to_compact_pages(order, gfp_mask, prio);
 
 	/* Compact each zone in the list */
-	for_each_zone_zonelist_nodemask(zone, z, ac->zonelist, ac->high_zoneidx,
-								ac->nodemask) {
+	for_each_zone_nlist_nodemask(zone, &t, ac->nodelist,
+					ac->high_zoneidx, ac->nodemask) {
 		enum compact_result status;
 
 		if (prio > MIN_COMPACT_PRIORITY
@@ -2366,7 +2366,7 @@ enum compact_result try_to_compact_pages(gfp_t gfp_mask, unsigned int order,
 		}
 
 		status = compact_zone_order(zone, order, gfp_mask, prio,
-				alloc_flags, ac_classzone_idx(ac), capture);
+				alloc_flags, ac->classzone_idx, capture);
 		rc = max(status, rc);
 
 		/* The allocation should succeed, stop compacting */
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index ac65bb5e38ac..2e55ec5dc84d 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -848,16 +848,16 @@ static struct page *dequeue_huge_page_nodemask(struct hstate *h, gfp_t gfp_mask,
 		nodemask_t *nmask)
 {
 	unsigned int cpuset_mems_cookie;
-	struct zonelist *zonelist;
+	struct nodelist *nodelist;
+	struct nlist_traverser t;
 	struct zone *zone;
-	struct zoneref *z;
 	int node = NUMA_NO_NODE;
 
-	zonelist = node_zonelist(nid, gfp_mask);
+	nodelist = node_nodelist(nid, gfp_mask);
 
 retry_cpuset:
 	cpuset_mems_cookie = read_mems_allowed_begin();
-	for_each_zone_zonelist_nodemask(zone, z, zonelist, gfp_zone(gfp_mask), nmask) {
+	for_each_zone_nlist_nodemask(zone, &t, nodelist, gfp_zone(gfp_mask), nmask) {
 		struct page *page;
 
 		if (!cpuset_zone_allowed(zone, gfp_mask))
diff --git a/mm/internal.h b/mm/internal.h
index 3cf20ab3ca01..90008f9fe7d9 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -111,16 +111,15 @@ extern pmd_t *mm_find_pmd(struct mm_struct *mm, unsigned long address);
  * by a const pointer.
  */
 struct alloc_context {
-	struct zonelist *zonelist;
+	struct nodelist *nodelist;
 	nodemask_t *nodemask;
-	struct zoneref *preferred_zoneref;
+	struct zone *preferred_zone;
+	enum zone_type classzone_idx;
 	int migratetype;
 	enum zone_type high_zoneidx;
 	bool spread_dirty_pages;
 };
 
-#define ac_classzone_idx(ac) zonelist_zone_idx(ac->preferred_zoneref)
-
 /*
  * Locate the struct page for both the matching buddy in our
  * pair (buddy1) and the combined O(n+1) page they form (page).
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index c5b5f74cfd4d..a9c3464c2bff 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1558,7 +1558,7 @@ static bool mem_cgroup_out_of_memory(struct mem_cgroup *memcg, gfp_t gfp_mask,
 				     int order)
 {
 	struct oom_control oc = {
-		.zonelist = NULL,
+		.nodelist = NULL,
 		.nodemask = NULL,
 		.memcg = memcg,
 		.gfp_mask = gfp_mask,
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index b2920ae87a61..b1df19d42047 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1876,18 +1876,18 @@ unsigned int mempolicy_slab_node(void)
 		return interleave_nodes(policy);
 
 	case MPOL_BIND: {
-		struct zoneref *z;
+		struct zone *zone;
 
 		/*
 		 * Follow bind policy behavior and start allocation at the
 		 * first node.
 		 */
-		struct zonelist *zonelist;
+		struct nodelist *nodelist;
 		enum zone_type highest_zoneidx = gfp_zone(GFP_KERNEL);
-		zonelist = &NODE_DATA(node)->node_zonelists[ZONELIST_FALLBACK];
-		z = first_zones_zonelist(zonelist, highest_zoneidx,
+		nodelist = &NODE_DATA(node)->node_nodelists[NODELIST_FALLBACK];
+		zone = first_zone_nlist_nodemask(nodelist, highest_zoneidx,
 							&policy->v.nodes);
-		return z->zone ? zone_to_nid(z->zone) : node;
+		return zone ? zone_to_nid(zone) : node;
 	}
 
 	default:
@@ -2404,7 +2404,7 @@ static void sp_free(struct sp_node *n)
 int mpol_misplaced(struct page *page, struct vm_area_struct *vma, unsigned long addr)
 {
 	struct mempolicy *pol;
-	struct zoneref *z;
+	struct zone *zone;
 	int curnid = page_to_nid(page);
 	unsigned long pgoff;
 	int thiscpu = raw_smp_processor_id();
@@ -2440,11 +2440,11 @@ int mpol_misplaced(struct page *page, struct vm_area_struct *vma, unsigned long
 		 */
 		if (node_isset(curnid, pol->v.nodes))
 			goto out;
-		z = first_zones_zonelist(
-				node_zonelist(numa_node_id(), GFP_HIGHUSER),
+		zone = first_zone_nlist_nodemask(
+				node_nodelist(numa_node_id(), GFP_HIGHUSER),
 				gfp_zone(GFP_HIGHUSER),
 				&pol->v.nodes);
-		polnid = zone_to_nid(z->zone);
+		polnid = zone_to_nid(zone);
 		break;
 
 	default:
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 5c918388de99..448e3228a911 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -18,10 +18,46 @@
 #ifdef CONFIG_DEBUG_MEMORY_INIT
 int __meminitdata mminit_loglevel;
 
+const char *nodelist_name[MAX_NODELISTS] __meminitconst = {
+	"general",
+#ifdef CONFIG_NUMA
+	"thisnode"
+#endif
+};
+
 #ifndef SECTIONS_SHIFT
 #define SECTIONS_SHIFT	0
 #endif
 
+void __init mminit_print_nodelist(int nid, int nl_type)
+{
+	pg_data_t *pgdat = NODE_DATA(nid);
+	struct nodelist *nodelist;
+	struct nlist_traverser t;
+	struct zone *node_zones, *zone;
+	enum zone_type ztype;
+
+	nodelist = &pgdat->node_nodelists[nl_type];
+	node_zones = pgdat->node_zones;
+
+	for (ztype = MAX_NR_ZONES - 1; ztype >= 0; ztype--) {
+		zone = node_zones + ztype;
+
+		if (!populated_zone(zone))
+			continue;
+
+		/* Print information about the nodelist */
+		printk(KERN_DEBUG "mminit::nodelist %s %d:%s = ",
+			nodelist_name[nl_type], nid, zone->name);
+
+		/* Iterate the nodelist */
+		for_each_zone_nlist(zone, &t, nodelist, ztype) {
+			pr_cont("%d:%s ", traverser_node(&t), zone->name);
+		}
+		pr_cont("\n");
+	}
+}
+
 /* The zonelists are simply reported, validation is manual. */
 void __init mminit_verify_zonelist(void)
 {
@@ -31,33 +67,13 @@ void __init mminit_verify_zonelist(void)
 		return;
 
 	for_each_online_node(nid) {
-		pg_data_t *pgdat = NODE_DATA(nid);
-		struct zone *zone;
-		struct zoneref *z;
-		struct zonelist *zonelist;
-		int i, listid, zoneid;
-
-		BUG_ON(MAX_ZONELISTS > 2);
-		for (i = 0; i < MAX_ZONELISTS * MAX_NR_ZONES; i++) {
-
-			/* Identify the zone and nodelist */
-			zoneid = i % MAX_NR_ZONES;
-			listid = i / MAX_NR_ZONES;
-			zonelist = &pgdat->node_zonelists[listid];
-			zone = &pgdat->node_zones[zoneid];
-			if (!populated_zone(zone))
-				continue;
-
-			/* Print information about the zonelist */
-			printk(KERN_DEBUG "mminit::zonelist %s %d:%s = ",
-				listid > 0 ? "thisnode" : "general", nid,
-				zone->name);
-
-			/* Iterate the zonelist */
-			for_each_zone_zonelist(zone, z, zonelist, zoneid)
-				pr_cont("%d:%s ", zone_to_nid(zone), zone->name);
-			pr_cont("\n");
-		}
+		/* print general nodelist */
+		mminit_print_nodelist(nid, NODELIST_FALLBACK);
+
+#ifdef CONFIG_NUMA
+		/* print thisnode nodelist */
+		mminit_print_nodelist(nid, NODELIST_NOFALLBACK);
+#endif
 	}
 }
 
diff --git a/mm/mmzone.c b/mm/mmzone.c
index 4686fdc23bb9..1f14e979108a 100644
--- a/mm/mmzone.c
+++ b/mm/mmzone.c
@@ -43,33 +43,27 @@ struct zone *next_zone(struct zone *zone)
 	return zone;
 }
 
-static inline int zref_in_nodemask(struct zoneref *zref, nodemask_t *nodes)
+static inline bool node_in_nodemask(int nid, nodemask_t *nodemask)
 {
 #ifdef CONFIG_NUMA
-	return node_isset(zonelist_node_idx(zref), *nodes);
+	return node_isset(nid, *nodemask);
 #else
-	return 1;
+	return true;
 #endif /* CONFIG_NUMA */
 }
 
-/* Returns the next zone at or below highest_zoneidx in a zonelist */
-struct zoneref *__next_zones_zonelist(struct zoneref *z,
-					enum zone_type highest_zoneidx,
-					nodemask_t *nodes)
+/* Returns the next nlist_entry at or below highest_zoneidx in a nodelist */
+void __next_nlist_entry_nodemask(struct nlist_traverser *t,
+					nodemask_t *nodemask)
 {
 	/*
-	 * Find the next suitable zone to use for the allocation.
-	 * Only filter based on nodemask if it's set
+	 * Find the next suitable nlist_entry to use for the allocation.
+	 * Only filter based on nodemask
 	 */
-	if (unlikely(nodes == NULL))
-		while (zonelist_zone_idx(z) > highest_zoneidx)
-			z++;
-	else
-		while (zonelist_zone_idx(z) > highest_zoneidx ||
-				(z->zone && !zref_in_nodemask(z, nodes)))
-			z++;
-
-	return z;
+	while (!node_has_usable_zones(t) ||
+		(traverser_node(t) != NUMA_NO_NODE &&
+			!node_in_nodemask(traverser_node(t), nodemask)))
+		t->entry++;
 }
 
 #ifdef CONFIG_ARCH_HAS_HOLES_MEMORYMODEL
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 314ce1a3cf25..f44c79db0cd6 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -251,10 +251,10 @@ static const char * const oom_constraint_text[] = {
  */
 static enum oom_constraint constrained_alloc(struct oom_control *oc)
 {
-	struct zone *zone;
-	struct zoneref *z;
 	enum zone_type high_zoneidx = gfp_zone(oc->gfp_mask);
 	bool cpuset_limited = false;
+	struct nlist_traverser t;
+	struct zone *zone;
 	int nid;
 
 	if (is_memcg_oom(oc)) {
@@ -268,7 +268,7 @@ static enum oom_constraint constrained_alloc(struct oom_control *oc)
 	if (!IS_ENABLED(CONFIG_NUMA))
 		return CONSTRAINT_NONE;
 
-	if (!oc->zonelist)
+	if (!oc->nodelist)
 		return CONSTRAINT_NONE;
 	/*
 	 * Reach here only when __GFP_NOFAIL is used. So, we should avoid
@@ -292,7 +292,7 @@ static enum oom_constraint constrained_alloc(struct oom_control *oc)
 	}
 
 	/* Check this allocation failure is caused by cpuset's wall function */
-	for_each_zone_zonelist_nodemask(zone, z, oc->zonelist,
+	for_each_zone_nlist_nodemask(zone, &t, oc->nodelist,
 			high_zoneidx, oc->nodemask)
 		if (!cpuset_zone_allowed(zone, oc->gfp_mask))
 			cpuset_limited = true;
@@ -1120,7 +1120,7 @@ bool out_of_memory(struct oom_control *oc)
 void pagefault_out_of_memory(void)
 {
 	struct oom_control oc = {
-		.zonelist = NULL,
+		.nodelist = NULL,
 		.nodemask = NULL,
 		.memcg = NULL,
 		.gfp_mask = 0,
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 62dcd6b76c80..ec5f48b755ff 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2555,16 +2555,15 @@ static void reserve_highatomic_pageblock(struct page *page, struct zone *zone,
 static bool unreserve_highatomic_pageblock(const struct alloc_context *ac,
 						bool force)
 {
-	struct zonelist *zonelist = ac->zonelist;
 	unsigned long flags;
-	struct zoneref *z;
+	struct nlist_traverser t;
 	struct zone *zone;
 	struct page *page;
 	int order;
 	bool ret;
 
-	for_each_zone_zonelist_nodemask(zone, z, zonelist, ac->high_zoneidx,
-								ac->nodemask) {
+	for_each_zone_nlist_nodemask(zone, &t, ac->nodelist,
+					ac->high_zoneidx, ac->nodemask) {
 		/*
 		 * Preserve at least one pageblock unless memory pressure
 		 * is really high.
@@ -3580,9 +3579,9 @@ static struct page *
 get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 						const struct alloc_context *ac)
 {
-	struct zoneref *z;
-	struct zone *zone;
 	struct pglist_data *last_pgdat_dirty_limit = NULL;
+	struct nlist_traverser t;
+	struct zone *zone;
 	bool no_fallback;
 
 retry:
@@ -3591,9 +3590,8 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 	 * See also __cpuset_node_allowed() comment in kernel/cpuset.c.
 	 */
 	no_fallback = alloc_flags & ALLOC_NOFRAGMENT;
-	z = ac->preferred_zoneref;
-	for_next_zone_zonelist_nodemask(zone, z, ac->zonelist, ac->high_zoneidx,
-								ac->nodemask) {
+	for_each_zone_nlist_nodemask(zone, &t, ac->nodelist,
+					ac->high_zoneidx, ac->nodemask) {
 		struct page *page;
 		unsigned long mark;
 
@@ -3631,7 +3629,7 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 		}
 
 		if (no_fallback && nr_online_nodes > 1 &&
-		    zone != ac->preferred_zoneref->zone) {
+		    zone != ac->preferred_zone) {
 			int local_nid;
 
 			/*
@@ -3639,7 +3637,7 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 			 * fragmenting fallbacks. Locality is more important
 			 * than fragmentation avoidance.
 			 */
-			local_nid = zone_to_nid(ac->preferred_zoneref->zone);
+			local_nid = zone_to_nid(ac->preferred_zone);
 			if (zone_to_nid(zone) != local_nid) {
 				alloc_flags &= ~ALLOC_NOFRAGMENT;
 				goto retry;
@@ -3648,7 +3646,7 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 
 		mark = wmark_pages(zone, alloc_flags & ALLOC_WMARK_MASK);
 		if (!zone_watermark_fast(zone, order, mark,
-				       ac_classzone_idx(ac), alloc_flags)) {
+					ac->classzone_idx, alloc_flags)) {
 			int ret;
 
 #ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
@@ -3667,7 +3665,7 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 				goto try_this_zone;
 
 			if (node_reclaim_mode == 0 ||
-			    !zone_allows_reclaim(ac->preferred_zoneref->zone, zone))
+			    !zone_allows_reclaim(ac->preferred_zone, zone))
 				continue;
 
 			ret = node_reclaim(zone->zone_pgdat, gfp_mask, order);
@@ -3681,7 +3679,7 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 			default:
 				/* did we reclaim enough */
 				if (zone_watermark_ok(zone, order, mark,
-						ac_classzone_idx(ac), alloc_flags))
+						ac->classzone_idx, alloc_flags))
 					goto try_this_zone;
 
 				continue;
@@ -3689,7 +3687,7 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 		}
 
 try_this_zone:
-		page = rmqueue(ac->preferred_zoneref->zone, zone, order,
+		page = rmqueue(ac->preferred_zone, zone, order,
 				gfp_mask, alloc_flags, ac->migratetype);
 		if (page) {
 			prep_new_page(page, order, gfp_mask, alloc_flags);
@@ -3792,7 +3790,7 @@ __alloc_pages_may_oom(gfp_t gfp_mask, unsigned int order,
 	const struct alloc_context *ac, unsigned long *did_some_progress)
 {
 	struct oom_control oc = {
-		.zonelist = ac->zonelist,
+		.nodelist = ac->nodelist,
 		.nodemask = ac->nodemask,
 		.memcg = NULL,
 		.gfp_mask = gfp_mask,
@@ -4031,8 +4029,8 @@ should_compact_retry(struct alloc_context *ac, unsigned int order, int alloc_fla
 		     enum compact_priority *compact_priority,
 		     int *compaction_retries)
 {
+	struct nlist_traverser t;
 	struct zone *zone;
-	struct zoneref *z;
 
 	if (!order || order > PAGE_ALLOC_COSTLY_ORDER)
 		return false;
@@ -4043,10 +4041,10 @@ should_compact_retry(struct alloc_context *ac, unsigned int order, int alloc_fla
 	 * Let's give them a good hope and keep retrying while the order-0
 	 * watermarks are OK.
 	 */
-	for_each_zone_zonelist_nodemask(zone, z, ac->zonelist, ac->high_zoneidx,
-					ac->nodemask) {
+	for_each_zone_nlist_nodemask(zone, &t, ac->nodelist,
+					ac->high_zoneidx, ac->nodemask) {
 		if (zone_watermark_ok(zone, 0, min_wmark_pages(zone),
-					ac_classzone_idx(ac), alloc_flags))
+					ac->classzone_idx, alloc_flags))
 			return true;
 	}
 	return false;
@@ -4121,7 +4119,7 @@ __perform_reclaim(gfp_t gfp_mask, unsigned int order,
 	fs_reclaim_acquire(gfp_mask);
 	noreclaim_flag = memalloc_noreclaim_save();
 
-	progress = try_to_free_pages(ac->zonelist, order, gfp_mask,
+	progress = try_to_free_pages(ac->nodelist, order, gfp_mask,
 								ac->nodemask);
 
 	memalloc_noreclaim_restore(noreclaim_flag);
@@ -4167,12 +4165,12 @@ __alloc_pages_direct_reclaim(gfp_t gfp_mask, unsigned int order,
 static void wake_all_kswapds(unsigned int order, gfp_t gfp_mask,
 			     const struct alloc_context *ac)
 {
-	struct zoneref *z;
-	struct zone *zone;
-	pg_data_t *last_pgdat = NULL;
 	enum zone_type high_zoneidx = ac->high_zoneidx;
+	pg_data_t *last_pgdat = NULL;
+	struct nlist_traverser t;
+	struct zone *zone;
 
-	for_each_zone_zonelist_nodemask(zone, z, ac->zonelist, high_zoneidx,
+	for_each_zone_nlist_nodemask(zone, &t, ac->nodelist, high_zoneidx,
 					ac->nodemask) {
 		if (last_pgdat != zone->zone_pgdat)
 			wakeup_kswapd(zone, gfp_mask, order, high_zoneidx);
@@ -4263,6 +4261,16 @@ bool gfp_pfmemalloc_allowed(gfp_t gfp_mask)
 	return !!__gfp_pfmemalloc_flags(gfp_mask);
 }
 
+static inline void
+reset_ac_preferred_zone(struct alloc_context *ac)
+{
+	ac->preferred_zone = first_zone_nlist_nodemask(ac->nodelist,
+					ac->high_zoneidx, ac->nodemask);
+
+	if (ac->preferred_zone)
+		ac->classzone_idx = zone_idx(ac->preferred_zone);
+}
+
 /*
  * Checks whether it makes sense to retry the reclaim to make a forward progress
  * for the given allocation request.
@@ -4278,8 +4286,8 @@ should_reclaim_retry(gfp_t gfp_mask, unsigned order,
 		     struct alloc_context *ac, int alloc_flags,
 		     bool did_some_progress, int *no_progress_loops)
 {
+	struct nlist_traverser t;
 	struct zone *zone;
-	struct zoneref *z;
 	bool ret = false;
 
 	/*
@@ -4307,8 +4315,8 @@ should_reclaim_retry(gfp_t gfp_mask, unsigned order,
 	 * request even if all reclaimable pages are considered then we are
 	 * screwed and have to go OOM.
 	 */
-	for_each_zone_zonelist_nodemask(zone, z, ac->zonelist, ac->high_zoneidx,
-					ac->nodemask) {
+	for_each_zone_nlist_nodemask(zone, &t, ac->nodelist,
+					ac->high_zoneidx, ac->nodemask) {
 		unsigned long available;
 		unsigned long reclaimable;
 		unsigned long min_wmark = min_wmark_pages(zone);
@@ -4322,9 +4330,10 @@ should_reclaim_retry(gfp_t gfp_mask, unsigned order,
 		 * reclaimable pages?
 		 */
 		wmark = __zone_watermark_ok(zone, order, min_wmark,
-				ac_classzone_idx(ac), alloc_flags, available);
-		trace_reclaim_retry_zone(z, order, reclaimable,
-				available, min_wmark, *no_progress_loops, wmark);
+				ac->classzone_idx, alloc_flags, available);
+		trace_reclaim_retry_zone(traverser_node(&t), zone, order,
+					reclaimable, available, min_wmark,
+					*no_progress_loops, wmark);
 		if (wmark) {
 			/*
 			 * If we didn't make any progress and have a lot of
@@ -4440,9 +4449,8 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 	 * there was a cpuset modification and we are retrying - otherwise we
 	 * could end up iterating over non-eligible zones endlessly.
 	 */
-	ac->preferred_zoneref = first_zones_zonelist(ac->zonelist,
-					ac->high_zoneidx, ac->nodemask);
-	if (!ac->preferred_zoneref->zone)
+	reset_ac_preferred_zone(ac);
+	if (!ac->preferred_zone)
 		goto nopage;
 
 	if (alloc_flags & ALLOC_KSWAPD)
@@ -4527,8 +4535,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 	 */
 	if (!(alloc_flags & ALLOC_CPUSET) || reserve_flags) {
 		ac->nodemask = NULL;
-		ac->preferred_zoneref = first_zones_zonelist(ac->zonelist,
-					ac->high_zoneidx, ac->nodemask);
+		reset_ac_preferred_zone(ac);
 	}
 
 	/* Attempt with potentially adjusted zonelist and alloc_flags */
@@ -4663,7 +4670,7 @@ static inline bool prepare_alloc_pages(gfp_t gfp_mask, unsigned int order,
 		unsigned int *alloc_flags)
 {
 	ac->high_zoneidx = gfp_zone(gfp_mask);
-	ac->zonelist = node_zonelist(preferred_nid, gfp_mask);
+	ac->nodelist = node_nodelist(preferred_nid, gfp_mask);
 	ac->nodemask = nodemask;
 	ac->migratetype = gfpflags_to_migratetype(gfp_mask);
 
@@ -4700,8 +4707,7 @@ static inline void finalise_ac(gfp_t gfp_mask, struct alloc_context *ac)
 	 * also used as the starting point for the zonelist iterator. It
 	 * may get reset for allocations that ignore memory policies.
 	 */
-	ac->preferred_zoneref = first_zones_zonelist(ac->zonelist,
-					ac->high_zoneidx, ac->nodemask);
+	reset_ac_preferred_zone(ac);
 }
 
 /*
@@ -4736,7 +4742,7 @@ __alloc_pages_nodemask(gfp_t gfp_mask, unsigned int order, int preferred_nid,
 	 * Forbid the first pass from falling back to types that fragment
 	 * memory until all local zones are considered.
 	 */
-	alloc_flags |= alloc_flags_nofragment(ac.preferred_zoneref->zone, gfp_mask);
+	alloc_flags |= alloc_flags_nofragment(ac.preferred_zone, gfp_mask);
 
 	/* First allocation attempt */
 	page = get_page_from_freelist(alloc_mask, order, alloc_flags, &ac);
@@ -5031,15 +5037,15 @@ EXPORT_SYMBOL(free_pages_exact);
  */
 static unsigned long nr_free_zone_pages(int offset)
 {
-	struct zoneref *z;
+	struct nlist_traverser t;
 	struct zone *zone;
 
 	/* Just pick one node, since fallback list is circular */
 	unsigned long sum = 0;
 
-	struct zonelist *zonelist = node_zonelist(numa_node_id(), GFP_KERNEL);
+	struct nodelist *nodelist = node_nodelist(numa_node_id(), GFP_KERNEL);
 
-	for_each_zone_zonelist(zone, z, zonelist, offset) {
+	for_each_zone_nlist(zone, &t, nodelist, offset) {
 		unsigned long size = zone_managed_pages(zone);
 		unsigned long high = high_wmark_pages(zone);
 		if (size > high)
@@ -5425,33 +5431,53 @@ void show_free_areas(unsigned int filter, nodemask_t *nodemask)
 	show_swap_cache_info();
 }
 
-static void zoneref_set_zone(struct zone *zone, struct zoneref *zoneref)
-{
-	zoneref->zone = zone;
-	zoneref->zone_idx = zone_idx(zone);
-}
-
 /*
  * Builds allocation fallback zone lists.
  *
  * Add all populated zones of a node to the zonelist.
  */
-static int build_zonerefs_node(pg_data_t *pgdat, struct zoneref *zonerefs)
+static struct nlist_entry *
+set_nlist_entry(struct nlist_entry *entry, int nid)
 {
-	struct zone *zone;
 	enum zone_type zone_type = MAX_NR_ZONES;
-	int nr_zones = 0;
+	struct zone *node_zones = NODE_DATA(nid)->node_zones;
+	struct zone *zone;
+
+	BUILD_BUG_ON(MAX_NR_ZONES >=
+			BITS_PER_BYTE * sizeof(entry->node_usable_zones));
+
+	entry->node_usable_zones = 0;
 
 	do {
 		zone_type--;
-		zone = pgdat->node_zones + zone_type;
+		zone = node_zones + zone_type;
 		if (managed_zone(zone)) {
-			zoneref_set_zone(zone, &zonerefs[nr_zones++]);
+			usable_zones_add(zone_type,
+					entry->node_usable_zones);
 			check_highest_zone(zone_type);
 		}
 	} while (zone_type);
 
-	return nr_zones;
+	if (entry->node_usable_zones) {
+		entry->nid = nid;
+		entry->zones = node_zones;
+		entry++;
+	}
+
+	return entry;
+}
+
+/*
+ * _nlist_entries[] end with
+ * (1) ->node_usable_zones = UINT_MAX,
+ * (2) ->nid = NUMA_NO_NODE,
+ * (3) ->zones = NULL
+ */
+static inline void set_last_nlist_entry(struct nlist_entry *entry)
+{
+	entry->node_usable_zones = UINT_MAX;
+	entry->nid = NUMA_NO_NODE;
+	entry->zones = NULL;
 }
 
 #ifdef CONFIG_NUMA
@@ -5568,45 +5594,37 @@ static int find_next_best_node(int node, nodemask_t *used_node_mask)
 	return best_node;
 }
 
-
 /*
  * Build zonelists ordered by node and zones within node.
  * This results in maximum locality--normal zone overflows into local
  * DMA zone, if any--but risks exhausting DMA zone.
  */
-static void build_zonelists_in_node_order(pg_data_t *pgdat, int *node_order,
+static void build_nodelists_in_node_order(pg_data_t *pgdat, int *node_order,
 		unsigned nr_nodes)
 {
-	struct zoneref *zonerefs;
+	struct nlist_entry *entry;
 	int i;
 
-	zonerefs = pgdat->node_zonelists[ZONELIST_FALLBACK]._zonerefs;
-
-	for (i = 0; i < nr_nodes; i++) {
-		int nr_zones;
+	entry = pgdat->node_nodelists[NODELIST_FALLBACK]._nlist_entries;
 
-		pg_data_t *node = NODE_DATA(node_order[i]);
+	for (i = 0; i < nr_nodes; i++)
+		entry = set_nlist_entry(entry, node_order[i]);
 
-		nr_zones = build_zonerefs_node(node, zonerefs);
-		zonerefs += nr_zones;
-	}
-	zonerefs->zone = NULL;
-	zonerefs->zone_idx = 0;
+	set_last_nlist_entry(entry);
 }
 
 /*
  * Build gfp_thisnode zonelists
  */
-static void build_thisnode_zonelists(pg_data_t *pgdat)
+static void build_thisnode_nodelists(pg_data_t *pgdat)
 {
-	struct zoneref *zonerefs;
-	int nr_zones;
+	struct nlist_entry *entry;
+
+	entry = pgdat->node_nodelists[NODELIST_NOFALLBACK]._nlist_entries;
 
-	zonerefs = pgdat->node_zonelists[ZONELIST_NOFALLBACK]._zonerefs;
-	nr_zones = build_zonerefs_node(pgdat, zonerefs);
-	zonerefs += nr_zones;
-	zonerefs->zone = NULL;
-	zonerefs->zone_idx = 0;
+	entry = set_nlist_entry(entry, pgdat->node_id);
+
+	set_last_nlist_entry(entry);
 }
 
 /*
@@ -5645,8 +5663,8 @@ static void build_zonelists(pg_data_t *pgdat)
 		load--;
 	}
 
-	build_zonelists_in_node_order(pgdat, node_order, nr_nodes);
-	build_thisnode_zonelists(pgdat);
+	build_nodelists_in_node_order(pgdat, node_order, nr_nodes);
+	build_thisnode_nodelists(pgdat);
 }
 
 #ifdef CONFIG_HAVE_MEMORYLESS_NODES
@@ -5658,12 +5676,12 @@ static void build_zonelists(pg_data_t *pgdat)
  */
 int local_memory_node(int node)
 {
-	struct zoneref *z;
+	struct zone *zone;
 
-	z = first_zones_zonelist(node_zonelist(node, GFP_KERNEL),
+	zone = first_zone_nlist_nodemask(node_nodelist(node, GFP_KERNEL),
 				   gfp_zone(GFP_KERNEL),
 				   NULL);
-	return zone_to_nid(z->zone);
+	return zone_to_nid(zone);
 }
 #endif
 
@@ -5674,14 +5692,12 @@ static void setup_min_slab_ratio(void);
 static void build_zonelists(pg_data_t *pgdat)
 {
 	int node, local_node;
-	struct zoneref *zonerefs;
-	int nr_zones;
+	struct nlist_entry *entry;
 
 	local_node = pgdat->node_id;
 
-	zonerefs = pgdat->node_zonelists[ZONELIST_FALLBACK]._zonerefs;
-	nr_zones = build_zonerefs_node(pgdat, zonerefs);
-	zonerefs += nr_zones;
+	entry = pgdat->node_nodelists[NODELIST_FALLBACK]._nlist_entries;
+	entry = set_nlist_entry(entry, local_node);
 
 	/*
 	 * Now we build the zonelist so that it contains the zones
@@ -5694,18 +5710,17 @@ static void build_zonelists(pg_data_t *pgdat)
 	for (node = local_node + 1; node < MAX_NUMNODES; node++) {
 		if (!node_online(node))
 			continue;
-		nr_zones = build_zonerefs_node(NODE_DATA(node), zonerefs);
-		zonerefs += nr_zones;
+
+		entry = set_nlist_entry(entry, node);
 	}
 	for (node = 0; node < local_node; node++) {
 		if (!node_online(node))
 			continue;
-		nr_zones = build_zonerefs_node(NODE_DATA(node), zonerefs);
-		zonerefs += nr_zones;
+
+		entry = set_nlist_entry(entry, node);
 	}
 
-	zonerefs->zone = NULL;
-	zonerefs->zone_idx = 0;
+	set_last_nlist_entry(entry);
 }
 
 #endif	/* CONFIG_NUMA */
@@ -8563,12 +8578,12 @@ struct page *alloc_contig_pages(unsigned long nr_pages, gfp_t gfp_mask,
 				int nid, nodemask_t *nodemask)
 {
 	unsigned long ret, pfn, flags;
-	struct zonelist *zonelist;
+	struct nodelist *nodelist;
+	struct nlist_traverser t;
 	struct zone *zone;
-	struct zoneref *z;
 
-	zonelist = node_zonelist(nid, gfp_mask);
-	for_each_zone_zonelist_nodemask(zone, z, zonelist,
+	nodelist = node_nodelist(nid, gfp_mask);
+	for_each_zone_nlist_nodemask(zone, &t, nodelist,
 					gfp_zone(gfp_mask), nodemask) {
 		spin_lock_irqsave(&zone->lock, flags);
 
diff --git a/mm/slab.c b/mm/slab.c
index f1e1840af533..b9a1353cf2ab 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -3103,8 +3103,8 @@ static void *alternate_node_alloc(struct kmem_cache *cachep, gfp_t flags)
  */
 static void *fallback_alloc(struct kmem_cache *cache, gfp_t flags)
 {
-	struct zonelist *zonelist;
-	struct zoneref *z;
+	struct nodelist *nodelist;
+	struct nlist_traverser t;
 	struct zone *zone;
 	enum zone_type high_zoneidx = gfp_zone(flags);
 	void *obj = NULL;
@@ -3117,14 +3117,14 @@ static void *fallback_alloc(struct kmem_cache *cache, gfp_t flags)
 
 retry_cpuset:
 	cpuset_mems_cookie = read_mems_allowed_begin();
-	zonelist = node_zonelist(mempolicy_slab_node(), flags);
+	nodelist = node_nodelist(mempolicy_slab_node(), flags);
 
 retry:
 	/*
 	 * Look through allowed nodes for objects available
 	 * from existing per node queues.
 	 */
-	for_each_zone_zonelist(zone, z, zonelist, high_zoneidx) {
+	for_each_zone_nlist(zone, &t, nodelist, high_zoneidx) {
 		nid = zone_to_nid(zone);
 
 		if (cpuset_zone_allowed(zone, flags) &&
diff --git a/mm/slub.c b/mm/slub.c
index b7c6b2e7f2db..ad1abfbc57b1 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1905,8 +1905,8 @@ static void *get_any_partial(struct kmem_cache *s, gfp_t flags,
 		struct kmem_cache_cpu *c)
 {
 #ifdef CONFIG_NUMA
-	struct zonelist *zonelist;
-	struct zoneref *z;
+	struct nodelist *nodelist;
+	struct nlist_traverser t;
 	struct zone *zone;
 	enum zone_type high_zoneidx = gfp_zone(flags);
 	void *object;
@@ -1936,8 +1936,8 @@ static void *get_any_partial(struct kmem_cache *s, gfp_t flags,
 
 	do {
 		cpuset_mems_cookie = read_mems_allowed_begin();
-		zonelist = node_zonelist(mempolicy_slab_node(), flags);
-		for_each_zone_zonelist(zone, z, zonelist, high_zoneidx) {
+		nodelist = node_nodelist(mempolicy_slab_node(), flags);
+		for_each_zone_nlist(zone, &t, nodelist, high_zoneidx) {
 			struct kmem_cache_node *n;
 
 			n = get_node(s, zone_to_nid(zone));
diff --git a/mm/vmscan.c b/mm/vmscan.c
index c8e88f4d9932..a3ad433c8ff4 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2918,9 +2918,9 @@ static inline bool compaction_ready(struct zone *zone, struct scan_control *sc)
  * If a zone is deemed to be full of pinned pages then just give it a light
  * scan then give up on it.
  */
-static void shrink_zones(struct zonelist *zonelist, struct scan_control *sc)
+static void shrink_zones(struct nodelist *nodelist, struct scan_control *sc)
 {
-	struct zoneref *z;
+	struct nlist_traverser t;
 	struct zone *zone;
 	unsigned long nr_soft_reclaimed;
 	unsigned long nr_soft_scanned;
@@ -2938,7 +2938,7 @@ static void shrink_zones(struct zonelist *zonelist, struct scan_control *sc)
 		sc->reclaim_idx = gfp_zone(sc->gfp_mask);
 	}
 
-	for_each_zone_zonelist_nodemask(zone, z, zonelist,
+	for_each_zone_nlist_nodemask(zone, &t, nodelist,
 					sc->reclaim_idx, sc->nodemask) {
 		/*
 		 * Take care memory controller reclaiming has small influence
@@ -3029,12 +3029,12 @@ static void snapshot_refaults(struct mem_cgroup *target_memcg, pg_data_t *pgdat)
  * returns:	0, if no pages reclaimed
  * 		else, the number of pages reclaimed
  */
-static unsigned long do_try_to_free_pages(struct zonelist *zonelist,
+static unsigned long do_try_to_free_pages(struct nodelist *nodelist,
 					  struct scan_control *sc)
 {
 	int initial_priority = sc->priority;
 	pg_data_t *last_pgdat;
-	struct zoneref *z;
+	struct nlist_traverser t;
 	struct zone *zone;
 retry:
 	delayacct_freepages_start();
@@ -3046,7 +3046,7 @@ static unsigned long do_try_to_free_pages(struct zonelist *zonelist,
 		vmpressure_prio(sc->gfp_mask, sc->target_mem_cgroup,
 				sc->priority);
 		sc->nr_scanned = 0;
-		shrink_zones(zonelist, sc);
+		shrink_zones(nodelist, sc);
 
 		if (sc->nr_reclaimed >= sc->nr_to_reclaim)
 			break;
@@ -3063,7 +3063,7 @@ static unsigned long do_try_to_free_pages(struct zonelist *zonelist,
 	} while (--sc->priority >= 0);
 
 	last_pgdat = NULL;
-	for_each_zone_zonelist_nodemask(zone, z, zonelist, sc->reclaim_idx,
+	for_each_zone_nlist_nodemask(zone, &t, nodelist, sc->reclaim_idx,
 					sc->nodemask) {
 		if (zone->zone_pgdat == last_pgdat)
 			continue;
@@ -3166,10 +3166,10 @@ static bool allow_direct_reclaim(pg_data_t *pgdat)
  * Returns true if a fatal signal was delivered during throttling. If this
  * happens, the page allocator should not consider triggering the OOM killer.
  */
-static bool throttle_direct_reclaim(gfp_t gfp_mask, struct zonelist *zonelist,
+static bool throttle_direct_reclaim(gfp_t gfp_mask, struct nodelist *nodelist,
 					nodemask_t *nodemask)
 {
-	struct zoneref *z;
+	struct nlist_traverser t;
 	struct zone *zone;
 	pg_data_t *pgdat = NULL;
 
@@ -3204,7 +3204,7 @@ static bool throttle_direct_reclaim(gfp_t gfp_mask, struct zonelist *zonelist,
 	 * for remote pfmemalloc reserves and processes on different nodes
 	 * should make reasonable progress.
 	 */
-	for_each_zone_zonelist_nodemask(zone, z, zonelist,
+	for_each_zone_nlist_nodemask(zone, &t, nodelist,
 					gfp_zone(gfp_mask), nodemask) {
 		if (zone_idx(zone) > ZONE_NORMAL)
 			continue;
@@ -3250,7 +3250,7 @@ static bool throttle_direct_reclaim(gfp_t gfp_mask, struct zonelist *zonelist,
 	return false;
 }
 
-unsigned long try_to_free_pages(struct zonelist *zonelist, int order,
+unsigned long try_to_free_pages(struct nodelist *nodelist, int order,
 				gfp_t gfp_mask, nodemask_t *nodemask)
 {
 	unsigned long nr_reclaimed;
@@ -3279,13 +3279,13 @@ unsigned long try_to_free_pages(struct zonelist *zonelist, int order,
 	 * 1 is returned so that the page allocator does not OOM kill at this
 	 * point.
 	 */
-	if (throttle_direct_reclaim(sc.gfp_mask, zonelist, nodemask))
+	if (throttle_direct_reclaim(sc.gfp_mask, nodelist, nodemask))
 		return 1;
 
 	set_task_reclaim_state(current, &sc.reclaim_state);
 	trace_mm_vmscan_direct_reclaim_begin(order, sc.gfp_mask);
 
-	nr_reclaimed = do_try_to_free_pages(zonelist, &sc);
+	nr_reclaimed = do_try_to_free_pages(nodelist, &sc);
 
 	trace_mm_vmscan_direct_reclaim_end(nr_reclaimed);
 	set_task_reclaim_state(current, NULL);
@@ -3363,7 +3363,7 @@ unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
 	 * equal pressure on all the nodes. This is based on the assumption that
 	 * the reclaim does not bail out early.
 	 */
-	struct zonelist *zonelist = node_zonelist(numa_node_id(), sc.gfp_mask);
+	struct nodelist *nodelist = node_nodelist(numa_node_id(), sc.gfp_mask);
 
 	set_task_reclaim_state(current, &sc.reclaim_state);
 
@@ -3374,7 +3374,7 @@ unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
 	psi_memstall_enter(&pflags);
 	noreclaim_flag = memalloc_noreclaim_save();
 
-	nr_reclaimed = do_try_to_free_pages(zonelist, &sc);
+	nr_reclaimed = do_try_to_free_pages(nodelist, &sc);
 
 	memalloc_noreclaim_restore(noreclaim_flag);
 	psi_memstall_leave(&pflags);
@@ -4033,7 +4033,7 @@ unsigned long shrink_all_memory(unsigned long nr_to_reclaim)
 		.may_swap = 1,
 		.hibernation_mode = 1,
 	};
-	struct zonelist *zonelist = node_zonelist(numa_node_id(), sc.gfp_mask);
+	struct nodelist *nodelist = node_nodelist(numa_node_id(), sc.gfp_mask);
 	unsigned long nr_reclaimed;
 	unsigned int noreclaim_flag;
 
@@ -4041,7 +4041,7 @@ unsigned long shrink_all_memory(unsigned long nr_to_reclaim)
 	noreclaim_flag = memalloc_noreclaim_save();
 	set_task_reclaim_state(current, &sc.reclaim_state);
 
-	nr_reclaimed = do_try_to_free_pages(zonelist, &sc);
+	nr_reclaimed = do_try_to_free_pages(nodelist, &sc);
 
 	set_task_reclaim_state(current, NULL);
 	memalloc_noreclaim_restore(noreclaim_flag);
-- 
2.23.0

