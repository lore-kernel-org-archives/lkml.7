Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71CE6C43215
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 15:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AE7420674
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 15:22:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727428AbfKUPW5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 10:22:57 -0500
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:46415 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726967AbfKUPW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 10:22:56 -0500
X-Originating-IP: 153.3.140.100
Received: from localhost.localdomain.localdomain (unknown [153.3.140.100])
        (Authenticated sender: fly@kernel.page)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 766831C0019;
        Thu, 21 Nov 2019 15:22:42 +0000 (UTC)
From:   Pengfei Li <fly@kernel.page>
To:     akpm@linux-foundation.org
Cc:     mgorman@techsingularity.net, mhocko@kernel.org, vbabka@suse.cz,
        cl@linux.com, iamjoonsoo.kim@lge.com, guro@fb.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Pengfei Li <fly@kernel.page>
Subject: [RFC v1 19/19] mm, mmzone: cleanup zonelist in comments
Date:   Thu, 21 Nov 2019 23:18:11 +0800
Message-Id: <20191121151811.49742-20-fly@kernel.page>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191121151811.49742-1-fly@kernel.page>
References: <20191121151811.49742-1-fly@kernel.page>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a cleanup patch.

Clean up all comments that contain the zonelist.

Signed-off-by: Pengfei Li <fly@kernel.page>
---
 arch/hexagon/mm/init.c           |  2 +-
 arch/ia64/include/asm/topology.h |  2 +-
 arch/x86/mm/numa.c               |  2 +-
 include/linux/gfp.h              |  8 +++---
 include/linux/mmzone.h           |  4 +--
 kernel/cgroup/cpuset.c           |  4 +--
 mm/internal.h                    |  2 +-
 mm/memory_hotplug.c              |  8 +++---
 mm/mempolicy.c                   |  2 +-
 mm/mm_init.c                     |  2 +-
 mm/page_alloc.c                  | 45 ++++++++++++++++----------------
 mm/vmscan.c                      |  2 +-
 12 files changed, 41 insertions(+), 42 deletions(-)

diff --git a/arch/hexagon/mm/init.c b/arch/hexagon/mm/init.c
index c961773a6fff..65eccf11cf55 100644
--- a/arch/hexagon/mm/init.c
+++ b/arch/hexagon/mm/init.c
@@ -103,7 +103,7 @@ void __init paging_init(void)
 
 	zones_sizes[ZONE_NORMAL] = max_low_pfn;
 
-	free_area_init(zones_sizes);  /*  sets up the zonelists and mem_map  */
+	free_area_init(zones_sizes);  /*  sets up the nodelists and mem_map  */
 
 	/*
 	 * Start of high memory area.  Will probably need something more
diff --git a/arch/ia64/include/asm/topology.h b/arch/ia64/include/asm/topology.h
index 43567240b0d6..cd3f4b121c89 100644
--- a/arch/ia64/include/asm/topology.h
+++ b/arch/ia64/include/asm/topology.h
@@ -13,7 +13,7 @@
 
 #ifdef CONFIG_NUMA
 
-/* Nodes w/o CPUs are preferred for memory allocations, see build_zonelists */
+/* Nodes w/o CPUs are preferred for memory allocations, see build_nodelists */
 #define PENALTY_FOR_NODE_WITH_CPUS 255
 
 /*
diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
index 4123100e0eaf..4ada68abdcc9 100644
--- a/arch/x86/mm/numa.c
+++ b/arch/x86/mm/numa.c
@@ -728,7 +728,7 @@ static void __init init_memory_less_node(int nid)
 	free_area_init_node(nid, zones_size, 0, zholes_size);
 
 	/*
-	 * All zonelists will be built later in start_kernel() after per cpu
+	 * All nodelists will be built later in start_kernel() after per cpu
 	 * areas are initialized.
 	 */
 }
diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index 6caab5a30f39..882c3d844ea1 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -466,10 +466,10 @@ static inline int gfp_nodelist(gfp_t flags)
 }
 
 /*
- * We get the zone list from the current node and the gfp_mask.
- * This zone list contains a maximum of MAXNODES*MAX_NR_ZONES zones.
- * There are two zonelists per node, one for all zones with memory and
- * one containing just zones from the node the zonelist belongs to.
+ * We get the node list from the current node and the gfp_mask.
+ * This node list contains a maximum of MAXNODES nodes.
+ * There are two nodelists per node, one for all zones with memory and
+ * one containing just zones from the node the nodelist belongs to.
  *
  * For the normal case of non-DISCONTIGMEM systems the NODE_DATA() gets
  * optimized to &contig_page_data at compile-time.
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 0423a84dfd7d..4b21e884b357 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -648,7 +648,7 @@ enum {
 	NODELIST_FALLBACK,	/* nodelist with fallback */
 #ifdef CONFIG_NUMA
 	/*
-	 * The NUMA zonelists are doubled because we need nodelists that
+	 * The NUMA nodelists are doubled because we need nodelists that
 	 * restrict the allocations to a single node for __GFP_THISNODE.
 	 */
 	NODELIST_NOFALLBACK,	/* nodelist without fallback (__GFP_THISNODE) */
@@ -657,7 +657,7 @@ enum {
 };
 
 /*
- * This struct contains information about a node in a zonelist. It is stored
+ * This struct contains information about a node in a nodelist. It is stored
  * here to avoid dereferences into large structures and lookups of tables
  */
 struct nlist_entry {
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 58f5073acff7..759d122b17e1 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -3393,7 +3393,7 @@ static struct cpuset *nearest_hardwall_ancestor(struct cpuset *cs)
  * __alloc_pages() routine only calls here with __GFP_HARDWALL bit
  * _not_ set if it's a GFP_KERNEL allocation, and all nodes in the
  * current tasks mems_allowed came up empty on the first pass over
- * the zonelist.  So only GFP_KERNEL allocations, if all nodes in the
+ * the nodelist.  So only GFP_KERNEL allocations, if all nodes in the
  * cpuset are short of memory, might require taking the callback_lock.
  *
  * The first call here from mm/page_alloc:get_page_from_freelist()
@@ -3467,7 +3467,7 @@ bool __cpuset_node_allowed(int node, gfp_t gfp_mask)
  * should not be possible for the following code to return an
  * offline node.  But if it did, that would be ok, as this routine
  * is not returning the node where the allocation must be, only
- * the node where the search should start.  The zonelist passed to
+ * the node where the search should start.  The nodelist passed to
  * __alloc_pages() will include all nodes.  If the slab allocator
  * is passed an offline node, it will fall back to the local node.
  * See kmem_cache_alloc_node().
diff --git a/mm/internal.h b/mm/internal.h
index 73ba9b6376cd..68954eac0bd9 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -105,7 +105,7 @@ extern pmd_t *mm_find_pmd(struct mm_struct *mm, unsigned long address);
  * nodemask, migratetype and high_zoneidx are initialized only once in
  * __alloc_pages_nodemask() and then never change.
  *
- * zonelist, preferred_zone and classzone_idx are set first in
+ * nodelist, preferred_zone and classzone_idx are set first in
  * __alloc_pages_nodemask() for the fast path, and might be later changed
  * in __alloc_pages_slowpath(). All other functions pass the whole strucure
  * by a const pointer.
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 3ff55da7b225..9dbd3377932f 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -793,9 +793,9 @@ int __ref online_pages(unsigned long pfn, unsigned long nr_pages, int online_typ
 		goto failed_addition;
 
 	/*
-	 * If this zone is not populated, then it is not in zonelist.
+	 * If this zone is not populated, then it is not in nodelist.
 	 * This means the page allocator ignores this zone.
-	 * So, zonelist must be updated after online.
+	 * So, nodelist must be updated after online.
 	 */
 	if (!populated_zone(zone)) {
 		need_nodelists_rebuild = true;
@@ -901,8 +901,8 @@ static pg_data_t __ref *hotadd_new_pgdat(int nid, u64 start)
 	free_area_init_core_hotplug(nid);
 
 	/*
-	 * The node we allocated has no zone fallback lists. For avoiding
-	 * to access not-initialized zonelist, build here.
+	 * The node we allocated has no node fallback lists. For avoiding
+	 * to access not-initialized nodelist, build here.
 	 */
 	build_all_nodelists(pgdat);
 
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 8fd962762e46..fc90cea07cfb 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1950,7 +1950,7 @@ static inline unsigned interleave_nid(struct mempolicy *pol,
  * Returns a nid suitable for a huge page allocation and a pointer
  * to the struct mempolicy for conditional unref after allocation.
  * If the effective policy is 'BIND, returns a pointer to the mempolicy's
- * @nodemask for filtering the zonelist.
+ * @nodemask for filtering the nodelist.
  *
  * Must be protected by read_mems_allowed_begin()
  */
diff --git a/mm/mm_init.c b/mm/mm_init.c
index ac91374b0e95..fff486f9a330 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -58,7 +58,7 @@ void __init mminit_print_nodelist(int nid, int nl_type)
 	}
 }
 
-/* The zonelists are simply reported, validation is manual. */
+/* The nodelists are simply reported, validation is manual. */
 void __init mminit_verify_nodelist(void)
 {
 	int nid;
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index bc24e614c296..6998e051a94b 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2647,7 +2647,7 @@ __rmqueue_fallback(struct zone *zone, int order, int start_migratetype,
 	/*
 	 * Do not steal pages from freelists belonging to other pageblocks
 	 * i.e. orders < pageblock_order. If there are no local zones free,
-	 * the zonelists will be reiterated without ALLOC_NOFRAGMENT.
+	 * the nodelists will be reiterated without ALLOC_NOFRAGMENT.
 	 */
 	if (alloc_flags & ALLOC_NOFRAGMENT)
 		min_order = pageblock_order;
@@ -3572,7 +3572,7 @@ alloc_flags_nofragment(struct zone *zone, gfp_t gfp_mask)
 }
 
 /*
- * get_page_from_freelist goes through the zonelist trying to allocate
+ * get_page_from_freelist goes through the nodelist trying to allocate
  * a page.
  */
 static struct page *
@@ -3586,7 +3586,7 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 
 retry:
 	/*
-	 * Scan zonelist, looking for a zone with enough free.
+	 * Scan nodelist, looking for a zone with enough free.
 	 * See also __cpuset_node_allowed() comment in kernel/cpuset.c.
 	 */
 	no_fallback = alloc_flags & ALLOC_NOFRAGMENT;
@@ -3811,7 +3811,7 @@ __alloc_pages_may_oom(gfp_t gfp_mask, unsigned int order,
 	}
 
 	/*
-	 * Go through the zonelist yet one more time, keep very high watermark
+	 * Go through the nodelist yet one more time, keep very high watermark
 	 * here, this is only to catch a parallel oom killing, we must fail if
 	 * we're still under heavy pressure. But make sure that this reclaim
 	 * attempt shall not depend on __GFP_DIRECT_RECLAIM && !__GFP_NORETRY
@@ -4441,7 +4441,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 	alloc_flags = gfp_to_alloc_flags(gfp_mask);
 
 	/*
-	 * We need to recalculate the starting point for the zonelist iterator
+	 * We need to recalculate the starting point for the nodelist iterator
 	 * because we might have used different nodemask in the fast path, or
 	 * there was a cpuset modification and we are retrying - otherwise we
 	 * could end up iterating over non-eligible zones endlessly.
@@ -4526,7 +4526,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 		alloc_flags = reserve_flags;
 
 	/*
-	 * Reset the nodemask and zonelist iterators if memory policies can be
+	 * Reset the nodemask and nodelist iterators if memory policies can be
 	 * ignored. These allocations are high priority and system rather than
 	 * user oriented.
 	 */
@@ -4535,7 +4535,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 		reset_ac_preferred_zone(ac);
 	}
 
-	/* Attempt with potentially adjusted zonelist and alloc_flags */
+	/* Attempt with potentially adjusted nodelist and alloc_flags */
 	page = get_page_from_freelist(gfp_mask, order, alloc_flags, ac);
 	if (page)
 		goto got_pg;
@@ -4701,7 +4701,7 @@ static inline void finalise_ac(gfp_t gfp_mask, struct alloc_context *ac)
 
 	/*
 	 * The preferred zone is used for statistics but crucially it is
-	 * also used as the starting point for the zonelist iterator. It
+	 * also used as the starting point for the nodelist iterator. It
 	 * may get reset for allocations that ignore memory policies.
 	 */
 	reset_ac_preferred_zone(ac);
@@ -5429,9 +5429,8 @@ void show_free_areas(unsigned int filter, nodemask_t *nodemask)
 }
 
 /*
- * Builds allocation fallback zone lists.
- *
- * Add all populated zones of a node to the zonelist.
+ * Builds allocation fallback node lists.
+ * Add all populated zones of a node to the nodelist.
  */
 static struct nlist_entry *
 set_nlist_entry(struct nlist_entry *entry, int nid)
@@ -5506,7 +5505,7 @@ early_param("numa_nodelist_order", setup_numa_nodelist_order);
 char numa_nodelist_order[] = "Node";
 
 /*
- * sysctl handler for numa_zonelist_order
+ * sysctl handler for numa_nodelist_order
  */
 int numa_nodelist_order_handler(struct ctl_table *table, int write,
 		void __user *buffer, size_t *length,
@@ -5592,7 +5591,7 @@ static int find_next_best_node(int node, nodemask_t *used_node_mask)
 }
 
 /*
- * Build zonelists ordered by node and zones within node.
+ * Build nodelists ordered by node and zones within node.
  * This results in maximum locality--normal zone overflows into local
  * DMA zone, if any--but risks exhausting DMA zone.
  */
@@ -5611,7 +5610,7 @@ static void build_nodelists_in_node_order(pg_data_t *pgdat, int *node_order,
 }
 
 /*
- * Build gfp_thisnode zonelists
+ * Build gfp_thisnode nodelists
  */
 static void build_thisnode_nodelists(pg_data_t *pgdat)
 {
@@ -5625,7 +5624,7 @@ static void build_thisnode_nodelists(pg_data_t *pgdat)
 }
 
 /*
- * Build zonelists ordered by zone and nodes within zones.
+ * Build nodelists ordered by zone and nodes within zones.
  * This results in conserving DMA zone[s] until all Normal memory is
  * exhausted, but results in overflowing to remote node while memory
  * may still exist in local DMA zone.
@@ -5667,9 +5666,9 @@ static void build_nodelists(pg_data_t *pgdat)
 #ifdef CONFIG_HAVE_MEMORYLESS_NODES
 /*
  * Return node id of node used for "local" allocations.
- * I.e., first node id of first zone in arg node's generic zonelist.
+ * I.e., first node id of first zone in arg node's generic nodelist.
  * Used for initializing percpu 'numa_mem', which is used primarily
- * for kernel allocations, so use GFP_KERNEL flags to locate zonelist.
+ * for kernel allocations, so use GFP_KERNEL flags to locate nodelist.
  */
 int local_memory_node(int node)
 {
@@ -5693,7 +5692,7 @@ static void build_nodelists(pg_data_t *pgdat)
 	entry = set_nlist_entry(entry, local_node);
 
 	/*
-	 * Now we build the zonelist so that it contains the zones
+	 * Now we build the nodelist so that it contains the zones
 	 * of all the other nodes.
 	 * We don't want to pressure a particular node, so when
 	 * building the zones for node N, we make sure that the
@@ -5752,7 +5751,7 @@ static void __build_all_nodelists(void *data)
 
 	/*
 	 * This node is hotadded and no memory is yet present.   So just
-	 * building zonelists is fine - no need to touch other nodes.
+	 * building nodelists is fine - no need to touch other nodes.
 	 */
 	if (self && !node_online(self->node_id)) {
 		build_nodelists(self);
@@ -5766,7 +5765,7 @@ static void __build_all_nodelists(void *data)
 #ifdef CONFIG_HAVE_MEMORYLESS_NODES
 		/*
 		 * We now know the "local memory node" for each node--
-		 * i.e., the node of the first zone in the generic zonelist.
+		 * i.e., the node of the first zone in the generic nodelist.
 		 * Set up numa_mem percpu variable for on-line cpus.  During
 		 * boot, only the boot cpu should be on-line;  we'll init the
 		 * secondary cpus' numa_mem as they come on-line.  During
@@ -5810,7 +5809,7 @@ build_all_nodelists_init(void)
 /*
  * unless system_state == SYSTEM_BOOTING.
  *
- * __ref due to call of __init annotated helper build_all_zonelists_init
+ * __ref due to call of __init annotated helper build_all_nodelists_init
  * [protected by SYSTEM_BOOTING].
  */
 void __ref build_all_nodelists(pg_data_t *pgdat)
@@ -5834,7 +5833,7 @@ void __ref build_all_nodelists(pg_data_t *pgdat)
 	else
 		page_group_by_mobility_disabled = 0;
 
-	pr_info("Built %u zonelists, mobility grouping %s.  Total pages: %ld\n",
+	pr_info("Built %u nodelists, mobility grouping %s.  Total pages: %ld\n",
 		nr_online_nodes,
 		page_group_by_mobility_disabled ? "off" : "on",
 		vm_total_pages);
@@ -8554,7 +8553,7 @@ static bool zone_spans_last_pfn(const struct zone *zone,
  * @nodemask:	Mask for other possible nodes
  *
  * This routine is a wrapper around alloc_contig_range(). It scans over zones
- * on an applicable zonelist to find a contiguous pfn range which can then be
+ * on an applicable nodelist to find a contiguous pfn range which can then be
  * tried for allocation with alloc_contig_range(). This routine is intended
  * for allocation requests which can not be fulfilled with the buddy allocator.
  *
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 2b0e51525c3a..8a0c786f7c25 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3360,7 +3360,7 @@ unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
 		.may_swap = may_swap,
 	};
 	/*
-	 * Traverse the ZONELIST_FALLBACK zonelist of the current node to put
+	 * Traverse the NODELIST_FALLBACK nodelist of the current node to put
 	 * equal pressure on all the nodes. This is based on the assumption that
 	 * the reclaim does not bail out early.
 	 */
-- 
2.23.0

