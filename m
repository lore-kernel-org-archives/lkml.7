Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8042FCA9EC8
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 00:29:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BC5321852
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 00:29:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Iko7aXhj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408420AbfJRA3D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 20:29:03 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:43480 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2407161AbfJRA2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 20:28:48 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9I0NP8S030781
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 17:28:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=ryuCoRunr9dD/0DUyEYqCfwRBHwMfteNiovxH6SPta8=;
 b=Iko7aXhjB1Q7xMcVeaen+AKMA0UF/xpMaS4SycuB3QlGzO8dsxFmlki7iq4ic0HM8dF3
 2/hi1oLEnSS0zMOMdpB/0ZE5ee10bLeB1NRBwQsCxvmxi0Z9OMUxY5ZtdZfz5KzgOTzj
 mDWsyLCbtrOCpUDK/HzEQicg639wEtimMlA= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2vpj8rvkye-19
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 17:28:46 -0700
Received: from 2401:db00:30:600c:face:0:1f:0 (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 17 Oct 2019 17:28:35 -0700
Received: by devvm2643.prn2.facebook.com (Postfix, from userid 111017)
        id 1C45018CE848F; Thu, 17 Oct 2019 17:28:34 -0700 (PDT)
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
Subject: [PATCH 14/16] mm: memcg/slab: use one set of kmem_caches for all memory cgroups
Date:   Thu, 17 Oct 2019 17:28:18 -0700
Message-ID: <20191018002820.307763-15-guro@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191018002820.307763-1-guro@fb.com>
References: <20191018002820.307763-1-guro@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-17_07:2019-10-17,2019-10-17 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 clxscore=1015 spamscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=4 malwarescore=0 adultscore=0 bulkscore=0
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910180001
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is fairly big but mostly red patch, which makes all non-root
slab allocations using a single set of kmem_caches instead of
creating a separate set for each memory cgroup.

Because the number of non-root kmem_caches is now capped by the number
of root kmem_caches, there is no need to shrink or destroy them
prematurely. They can be perfectly destroyed together with their
root counterparts. This allows to dramatically simplify the
management of non-root kmem_caches and delete a ton of code.

This patch performs the following changes:
1) introduces memcg_params.memcg_cache pointer to represent the
   kmem_cache which will be used for all non-root allocations
2) reuses the existing memcg kmem_cache creation mechanism
   to create memcg kmem_cache on the first allocation attempt
3) memcg kmem_caches are named <kmemcache_name>-memcg,
   e.g. dentry-memcg
4) simplifies memcg_kmem_get_cache() to just return memcg kmem_cache
   or schedule it's creation and return the root cache
5) removes almost all non-root kmem_cache management code
   (separate refcounter, reparenting, shrinking, etc)
6) makes slab debugfs to display root_mem_cgroup css id and never
   show :dead and :deact flags in the memcg_slabinfo attribute.

Signed-off-by: Roman Gushchin <guro@fb.com>
---
 include/linux/memcontrol.h |   5 +-
 include/linux/slab.h       |   3 +-
 mm/memcontrol.c            | 123 ++---------
 mm/slab.c                  |  16 +-
 mm/slab.h                  | 121 ++++-------
 mm/slab_common.c           | 414 ++++---------------------------------
 mm/slub.c                  |  38 +---
 7 files changed, 106 insertions(+), 614 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index a75980559a47..f36203cf75f8 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -327,7 +327,6 @@ struct mem_cgroup {
         /* Index in the kmem_cache->memcg_params.memcg_caches array */
 	int kmemcg_id;
 	enum memcg_kmem_state kmem_state;
-	struct list_head kmem_caches;
 	struct mem_cgroup_ptr __rcu *kmem_memcg_ptr;
 	struct list_head kmem_memcg_ptr_list;
 #endif
@@ -1436,9 +1435,7 @@ static inline void memcg_set_shrinker_bit(struct mem_cgroup *memcg,
 }
 #endif
 
-struct kmem_cache *memcg_kmem_get_cache(struct kmem_cache *cachep,
-					struct mem_cgroup **memcgp);
-void memcg_kmem_put_cache(struct kmem_cache *cachep);
+struct kmem_cache *memcg_kmem_get_cache(struct kmem_cache *cachep);
 
 #ifdef CONFIG_MEMCG_KMEM
 int __memcg_kmem_charge(struct page *page, gfp_t gfp, int order);
diff --git a/include/linux/slab.h b/include/linux/slab.h
index 877a95c6a2d2..246474e9c706 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -155,8 +155,7 @@ struct kmem_cache *kmem_cache_create_usercopy(const char *name,
 void kmem_cache_destroy(struct kmem_cache *);
 int kmem_cache_shrink(struct kmem_cache *);
 
-void memcg_create_kmem_cache(struct mem_cgroup *, struct kmem_cache *);
-void memcg_deactivate_kmem_caches(struct mem_cgroup *, struct mem_cgroup *);
+void memcg_create_kmem_cache(struct kmem_cache *);
 
 /*
  * Please use this macro to create slab caches. Simply specify the
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 0c9698f03cfe..b0d0c833150c 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -330,7 +330,7 @@ static void memcg_reparent_kmem_memcg_ptr(struct mem_cgroup *memcg,
 }
 
 /*
- * This will be the memcg's index in each cache's ->memcg_params.memcg_caches.
+ * This will be used as a shrinker list's index.
  * The main reason for not using cgroup id for this:
  *  this works better in sparse environments, where we have a lot of memcgs,
  *  but only a few kmem-limited. Or also, if we have, for instance, 200
@@ -2938,9 +2938,7 @@ static int memcg_alloc_cache_id(void)
 	else if (size > MEMCG_CACHES_MAX_SIZE)
 		size = MEMCG_CACHES_MAX_SIZE;
 
-	err = memcg_update_all_caches(size);
-	if (!err)
-		err = memcg_update_all_list_lrus(size);
+	err = memcg_update_all_list_lrus(size);
 	if (!err)
 		memcg_nr_cache_ids = size;
 
@@ -2959,7 +2957,6 @@ static void memcg_free_cache_id(int id)
 }
 
 struct memcg_kmem_cache_create_work {
-	struct mem_cgroup *memcg;
 	struct kmem_cache *cachep;
 	struct work_struct work;
 };
@@ -2968,31 +2965,24 @@ static void memcg_kmem_cache_create_func(struct work_struct *w)
 {
 	struct memcg_kmem_cache_create_work *cw =
 		container_of(w, struct memcg_kmem_cache_create_work, work);
-	struct mem_cgroup *memcg = cw->memcg;
 	struct kmem_cache *cachep = cw->cachep;
 
-	memcg_create_kmem_cache(memcg, cachep);
+	memcg_create_kmem_cache(cachep);
 
-	css_put(&memcg->css);
 	kfree(cw);
 }
 
 /*
  * Enqueue the creation of a per-memcg kmem_cache.
  */
-static void memcg_schedule_kmem_cache_create(struct mem_cgroup *memcg,
-					       struct kmem_cache *cachep)
+static void memcg_schedule_kmem_cache_create(struct kmem_cache *cachep)
 {
 	struct memcg_kmem_cache_create_work *cw;
 
-	if (!css_tryget_online(&memcg->css))
-		return;
-
 	cw = kmalloc(sizeof(*cw), GFP_NOWAIT | __GFP_NOWARN);
 	if (!cw)
 		return;
 
-	cw->memcg = memcg;
 	cw->cachep = cachep;
 	INIT_WORK(&cw->work, memcg_kmem_cache_create_func);
 
@@ -3000,96 +2990,26 @@ static void memcg_schedule_kmem_cache_create(struct mem_cgroup *memcg,
 }
 
 /**
- * memcg_kmem_get_cache: select the correct per-memcg cache for allocation
+ * memcg_kmem_get_cache: select memcg or root cache for allocation
  * @cachep: the original global kmem cache
  *
  * Return the kmem_cache we're supposed to use for a slab allocation.
- * We try to use the current memcg's version of the cache.
  *
  * If the cache does not exist yet, if we are the first user of it, we
  * create it asynchronously in a workqueue and let the current allocation
  * go through with the original cache.
- *
- * This function takes a reference to the cache it returns to assure it
- * won't get destroyed while we are working with it. Once the caller is
- * done with it, memcg_kmem_put_cache() must be called to release the
- * reference.
  */
-struct kmem_cache *memcg_kmem_get_cache(struct kmem_cache *cachep,
-					struct mem_cgroup **memcgp)
+struct kmem_cache *memcg_kmem_get_cache(struct kmem_cache *cachep)
 {
-	struct mem_cgroup *memcg;
 	struct kmem_cache *memcg_cachep;
-	struct memcg_cache_array *arr;
-	int kmemcg_id;
 
-	VM_BUG_ON(!is_root_cache(cachep));
-
-	if (memcg_kmem_bypass())
+	memcg_cachep = READ_ONCE(cachep->memcg_params.memcg_cache);
+	if (unlikely(!memcg_cachep)) {
+		memcg_schedule_kmem_cache_create(cachep);
 		return cachep;
-
-	rcu_read_lock();
-
-	if (unlikely(current->active_memcg))
-		memcg = current->active_memcg;
-	else
-		memcg = mem_cgroup_from_task(current);
-
-	if (!memcg || memcg == root_mem_cgroup)
-		goto out_unlock;
-
-	kmemcg_id = READ_ONCE(memcg->kmemcg_id);
-	if (kmemcg_id < 0)
-		goto out_unlock;
-
-	arr = rcu_dereference(cachep->memcg_params.memcg_caches);
-
-	/*
-	 * Make sure we will access the up-to-date value. The code updating
-	 * memcg_caches issues a write barrier to match the data dependency
-	 * barrier inside READ_ONCE() (see memcg_create_kmem_cache()).
-	 */
-	memcg_cachep = READ_ONCE(arr->entries[kmemcg_id]);
-
-	/*
-	 * If we are in a safe context (can wait, and not in interrupt
-	 * context), we could be be predictable and return right away.
-	 * This would guarantee that the allocation being performed
-	 * already belongs in the new cache.
-	 *
-	 * However, there are some clashes that can arrive from locking.
-	 * For instance, because we acquire the slab_mutex while doing
-	 * memcg_create_kmem_cache, this means no further allocation
-	 * could happen with the slab_mutex held. So it's better to
-	 * defer everything.
-	 *
-	 * If the memcg is dying or memcg_cache is about to be released,
-	 * don't bother creating new kmem_caches. Because memcg_cachep
-	 * is ZEROed as the fist step of kmem offlining, we don't need
-	 * percpu_ref_tryget_live() here. css_tryget_online() check in
-	 * memcg_schedule_kmem_cache_create() will prevent us from
-	 * creation of a new kmem_cache.
-	 */
-	if (unlikely(!memcg_cachep))
-		memcg_schedule_kmem_cache_create(memcg, cachep);
-	else if (percpu_ref_tryget(&memcg_cachep->memcg_params.refcnt)) {
-		css_get(&memcg->css);
-		*memcgp = memcg;
-		cachep = memcg_cachep;
 	}
-out_unlock:
-	rcu_read_unlock();
-	return cachep;
-}
 
-/**
- * memcg_kmem_put_cache: drop reference taken by memcg_kmem_get_cache
- * @cachep: the cache returned by memcg_kmem_get_cache
- */
-void memcg_kmem_put_cache(struct kmem_cache *cachep)
-{
-	if (!is_root_cache(cachep))
-		percpu_ref_put(&cachep->memcg_params.refcnt);
+	return memcg_cachep;
 }
 
 /**
@@ -3669,7 +3589,6 @@ static int memcg_online_kmem(struct mem_cgroup *memcg)
 	 */
 	memcg->kmemcg_id = memcg_id;
 	memcg->kmem_state = KMEM_ONLINE;
-	INIT_LIST_HEAD(&memcg->kmem_caches);
 
 	return 0;
 }
@@ -3682,12 +3601,7 @@ static void memcg_offline_kmem(struct mem_cgroup *memcg)
 
 	if (memcg->kmem_state != KMEM_ONLINE)
 		return;
-	/*
-	 * Clear the online state before clearing memcg_caches array
-	 * entries. The slab_mutex in memcg_deactivate_kmem_caches()
-	 * guarantees that no cache will be created for this cgroup
-	 * after we are done (see memcg_create_kmem_cache()).
-	 */
+
 	memcg->kmem_state = KMEM_ALLOCATED;
 
 	parent = parent_mem_cgroup(memcg);
@@ -3695,12 +3609,10 @@ static void memcg_offline_kmem(struct mem_cgroup *memcg)
 		parent = root_mem_cgroup;
 
 	/*
-	 * Deactivate and reparent kmem_caches and reparent kmem_memcg_ptr.
-	 * Then flush percpu slab statistics to have precise values at the
-	 * parent and all ancestor levels. It's required to keep slab stats
-	 * accurate after the reparenting of kmem_caches.
+	 * Reparent kmem_memcg_ptr. Then flush percpu slab statistics to have
+	 * precise values at the parent and all ancestor levels. It's required
+	 * to keep slab stats accurate after the reparenting of kmem_caches.
 	 */
-	memcg_deactivate_kmem_caches(memcg, parent);
 	memcg_reparent_kmem_memcg_ptr(memcg, parent);
 	memcg_flush_percpu_vmstats(memcg, true);
 
@@ -3736,10 +3648,8 @@ static void memcg_free_kmem(struct mem_cgroup *memcg)
 	if (unlikely(memcg->kmem_state == KMEM_ONLINE))
 		memcg_offline_kmem(memcg);
 
-	if (memcg->kmem_state == KMEM_ALLOCATED) {
-		WARN_ON(!list_empty(&memcg->kmem_caches));
+	if (memcg->kmem_state == KMEM_ALLOCATED)
 		static_branch_dec(&memcg_kmem_enabled_key);
-	}
 }
 #else
 static int memcg_online_kmem(struct mem_cgroup *memcg)
@@ -5316,9 +5226,6 @@ mem_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
 
 	/* The following stuff does not apply to the root */
 	if (!parent) {
-#ifdef CONFIG_MEMCG_KMEM
-		INIT_LIST_HEAD(&memcg->kmem_caches);
-#endif
 		root_mem_cgroup = memcg;
 		return &memcg->css;
 	}
diff --git a/mm/slab.c b/mm/slab.c
index 91cd8bc4ee07..0914d7cd869f 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -1239,7 +1239,7 @@ void __init kmem_cache_init(void)
 				  nr_node_ids * sizeof(struct kmem_cache_node *),
 				  SLAB_HWCACHE_ALIGN, 0, 0);
 	list_add(&kmem_cache->list, &slab_caches);
-	memcg_link_cache(kmem_cache, NULL);
+	memcg_link_cache(kmem_cache);
 	slab_state = PARTIAL;
 
 	/*
@@ -2244,17 +2244,6 @@ int __kmem_cache_shrink(struct kmem_cache *cachep)
 	return (ret ? 1 : 0);
 }
 
-#ifdef CONFIG_MEMCG
-void __kmemcg_cache_deactivate(struct kmem_cache *cachep)
-{
-	__kmem_cache_shrink(cachep);
-}
-
-void __kmemcg_cache_deactivate_after_rcu(struct kmem_cache *s)
-{
-}
-#endif
-
 int __kmem_cache_shutdown(struct kmem_cache *cachep)
 {
 	return __kmem_cache_shrink(cachep);
@@ -3862,7 +3851,8 @@ static int do_tune_cpucache(struct kmem_cache *cachep, int limit,
 		return ret;
 
 	lockdep_assert_held(&slab_mutex);
-	for_each_memcg_cache(c, cachep) {
+	c = memcg_cache(cachep);
+	if (c) {
 		/* return value determined by the root cache only */
 		__do_tune_cpucache(c, limit, batchcount, shared, gfp);
 	}
diff --git a/mm/slab.h b/mm/slab.h
index a6330065d434..035c2969a2ca 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -32,66 +32,25 @@ struct kmem_cache {
 
 #else /* !CONFIG_SLOB */
 
-struct memcg_cache_array {
-	struct rcu_head rcu;
-	struct kmem_cache *entries[0];
-};
-
 /*
  * This is the main placeholder for memcg-related information in kmem caches.
- * Both the root cache and the child caches will have it. For the root cache,
- * this will hold a dynamically allocated array large enough to hold
- * information about the currently limited memcgs in the system. To allow the
- * array to be accessed without taking any locks, on relocation we free the old
- * version only after a grace period.
- *
- * Root and child caches hold different metadata.
+ * Both the root cache and the child cache will have it. Some fields are used
+ * in both cases, other are specific to root caches.
  *
  * @root_cache:	Common to root and child caches.  NULL for root, pointer to
  *		the root cache for children.
  *
  * The following fields are specific to root caches.
  *
- * @memcg_caches: kmemcg ID indexed table of child caches.  This table is
- *		used to index child cachces during allocation and cleared
- *		early during shutdown.
- *
- * @root_caches_node: List node for slab_root_caches list.
- *
- * @children:	List of all child caches.  While the child caches are also
- *		reachable through @memcg_caches, a child cache remains on
- *		this list until it is actually destroyed.
- *
- * The following fields are specific to child caches.
- *
- * @memcg:	Pointer to the memcg this cache belongs to.
- *
- * @children_node: List node for @root_cache->children list.
- *
- * @kmem_caches_node: List node for @memcg->kmem_caches list.
+ * @memcg_cache: pointer to memcg kmem cache, used by all non-root memory
+ *		cgroups.
+ * @root_caches_node: list node for slab_root_caches list.
  */
 struct memcg_cache_params {
 	struct kmem_cache *root_cache;
-	union {
-		struct {
-			struct memcg_cache_array __rcu *memcg_caches;
-			struct list_head __root_caches_node;
-			struct list_head children;
-			bool dying;
-		};
-		struct {
-			struct mem_cgroup *memcg;
-			struct list_head children_node;
-			struct list_head kmem_caches_node;
-			struct percpu_ref refcnt;
-
-			void (*work_fn)(struct kmem_cache *);
-			union {
-				struct rcu_head rcu_head;
-				struct work_struct work;
-			};
-		};
-	};
+
+	struct kmem_cache *memcg_cache;
+	struct list_head __root_caches_node;
 };
 #endif /* CONFIG_SLOB */
 
@@ -234,8 +193,6 @@ bool __kmem_cache_empty(struct kmem_cache *);
 int __kmem_cache_shutdown(struct kmem_cache *);
 void __kmem_cache_release(struct kmem_cache *);
 int __kmem_cache_shrink(struct kmem_cache *);
-void __kmemcg_cache_deactivate(struct kmem_cache *s);
-void __kmemcg_cache_deactivate_after_rcu(struct kmem_cache *s);
 void slab_kmem_cache_release(struct kmem_cache *);
 void kmem_cache_shrink_all(struct kmem_cache *s);
 
@@ -281,14 +238,6 @@ static inline int cache_vmstat_idx(struct kmem_cache *s)
 extern struct list_head		slab_root_caches;
 #define root_caches_node	memcg_params.__root_caches_node
 
-/*
- * Iterate over all memcg caches of the given root cache. The caller must hold
- * slab_mutex.
- */
-#define for_each_memcg_cache(iter, root) \
-	list_for_each_entry(iter, &(root)->memcg_params.children, \
-			    memcg_params.children_node)
-
 static inline bool is_root_cache(struct kmem_cache *s)
 {
 	return !s->memcg_params.root_cache;
@@ -319,6 +268,13 @@ static inline struct kmem_cache *memcg_root_cache(struct kmem_cache *s)
 	return s->memcg_params.root_cache;
 }
 
+static inline struct kmem_cache *memcg_cache(struct kmem_cache *s)
+{
+	if (is_root_cache(s))
+		return s->memcg_params.memcg_cache;
+	return NULL;
+}
+
 /*
  * Expects a pointer to a slab page. Please note, that PageSlab() check
  * isn't sufficient, as it returns true also for tail compound slab pages,
@@ -367,17 +323,27 @@ static inline struct kmem_cache *memcg_slab_pre_alloc_hook(struct kmem_cache *s,
 						size_t size, gfp_t flags)
 {
 	struct kmem_cache *cachep;
+	struct mem_cgroup *memcg;
+
+	if (memcg_kmem_bypass())
+		return s;
 
-	cachep = memcg_kmem_get_cache(s, memcgp);
-	if (is_root_cache(cachep))
+	memcg = get_mem_cgroup_from_current();
+	if (!memcg || mem_cgroup_is_root(memcg))
 		return s;
 
-	if (__memcg_kmem_charge_subpage(*memcgp, size * s->size, flags)) {
-		mem_cgroup_put(*memcgp);
-		memcg_kmem_put_cache(cachep);
-		cachep = NULL;
+	cachep = memcg_kmem_get_cache(s);
+	if (is_root_cache(cachep)) {
+		mem_cgroup_put(memcg);
+		return s;
 	}
 
+	if (__memcg_kmem_charge_subpage(memcg, size * s->size, flags)) {
+		mem_cgroup_put(memcg);
+		return NULL;
+	}
+
+	*memcgp = memcg;
 	return cachep;
 }
 
@@ -407,8 +373,6 @@ static inline void memcg_slab_post_alloc_hook(struct kmem_cache *s,
 	}
 	mem_cgroup_ptr_put(memcg_ptr);
 	mem_cgroup_put(memcg);
-
-	memcg_kmem_put_cache(s);
 }
 
 static inline void memcg_slab_free_hook(struct kmem_cache *s, struct page *page,
@@ -437,7 +401,7 @@ static inline void memcg_slab_free_hook(struct kmem_cache *s, struct page *page,
 }
 
 extern void slab_init_memcg_params(struct kmem_cache *);
-extern void memcg_link_cache(struct kmem_cache *s, struct mem_cgroup *memcg);
+extern void memcg_link_cache(struct kmem_cache *s);
 
 #else /* CONFIG_MEMCG_KMEM */
 
@@ -445,9 +409,6 @@ extern void memcg_link_cache(struct kmem_cache *s, struct mem_cgroup *memcg);
 #define slab_root_caches	slab_caches
 #define root_caches_node	list
 
-#define for_each_memcg_cache(iter, root) \
-	for ((void)(iter), (void)(root); 0; )
-
 static inline bool is_root_cache(struct kmem_cache *s)
 {
 	return true;
@@ -469,6 +430,11 @@ static inline struct kmem_cache *memcg_root_cache(struct kmem_cache *s)
 	return s;
 }
 
+static inline struct kmem_cache *memcg_cache(struct kmem_cache *s)
+{
+	return NULL;
+}
+
 static inline struct mem_cgroup *memcg_from_slab_obj(void *ptr)
 {
 	return NULL;
@@ -506,8 +472,7 @@ static inline void slab_init_memcg_params(struct kmem_cache *s)
 {
 }
 
-static inline void memcg_link_cache(struct kmem_cache *s,
-				    struct mem_cgroup *memcg)
+static inline void memcg_link_cache(struct kmem_cache *s)
 {
 }
 
@@ -535,8 +500,6 @@ static __always_inline int charge_slab_page(struct page *page,
 		ret = memcg_alloc_page_memcg_vec(page, gfp, objects);
 		if (ret)
 			return ret;
-
-		percpu_ref_get_many(&s->memcg_params.refcnt, 1 << order);
 	}
 	mod_node_page_state(page_pgdat(page), cache_vmstat_idx(s),
 			    PAGE_SIZE << order);
@@ -546,10 +509,9 @@ static __always_inline int charge_slab_page(struct page *page,
 static __always_inline void uncharge_slab_page(struct page *page, int order,
 					       struct kmem_cache *s)
 {
-	if (!is_root_cache(s)) {
+	if (!is_root_cache(s))
 		memcg_free_page_memcg_vec(page);
-		percpu_ref_put_many(&s->memcg_params.refcnt, 1 << order);
-	}
+
 	mod_node_page_state(page_pgdat(page), cache_vmstat_idx(s),
 			    -(PAGE_SIZE << order));
 }
@@ -698,9 +660,6 @@ static inline struct kmem_cache_node *get_node(struct kmem_cache *s, int node)
 void *slab_start(struct seq_file *m, loff_t *pos);
 void *slab_next(struct seq_file *m, void *p, loff_t *pos);
 void slab_stop(struct seq_file *m, void *p);
-void *memcg_slab_start(struct seq_file *m, loff_t *pos);
-void *memcg_slab_next(struct seq_file *m, void *p, loff_t *pos);
-void memcg_slab_stop(struct seq_file *m, void *p);
 int memcg_slab_show(struct seq_file *m, void *p);
 
 #if defined(CONFIG_SLAB) || defined(CONFIG_SLUB_DEBUG)
diff --git a/mm/slab_common.c b/mm/slab_common.c
index cc0c70b57c1c..3dcd90ba7525 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -131,141 +131,36 @@ int __kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t nr,
 #ifdef CONFIG_MEMCG_KMEM
 
 LIST_HEAD(slab_root_caches);
-static DEFINE_SPINLOCK(memcg_kmem_wq_lock);
-
-static void kmemcg_cache_shutdown(struct percpu_ref *percpu_ref);
 
 void slab_init_memcg_params(struct kmem_cache *s)
 {
 	s->memcg_params.root_cache = NULL;
-	RCU_INIT_POINTER(s->memcg_params.memcg_caches, NULL);
-	INIT_LIST_HEAD(&s->memcg_params.children);
-	s->memcg_params.dying = false;
+	s->memcg_params.memcg_cache = NULL;
 }
 
-static int init_memcg_params(struct kmem_cache *s,
-			     struct kmem_cache *root_cache)
+static void init_memcg_params(struct kmem_cache *s,
+			      struct kmem_cache *root_cache)
 {
-	struct memcg_cache_array *arr;
-
-	if (root_cache) {
-		int ret = percpu_ref_init(&s->memcg_params.refcnt,
-					  kmemcg_cache_shutdown,
-					  0, GFP_KERNEL);
-		if (ret)
-			return ret;
-
+	if (root_cache)
 		s->memcg_params.root_cache = root_cache;
-		INIT_LIST_HEAD(&s->memcg_params.children_node);
-		INIT_LIST_HEAD(&s->memcg_params.kmem_caches_node);
-		return 0;
-	}
-
-	slab_init_memcg_params(s);
-
-	if (!memcg_nr_cache_ids)
-		return 0;
-
-	arr = kvzalloc(sizeof(struct memcg_cache_array) +
-		       memcg_nr_cache_ids * sizeof(void *),
-		       GFP_KERNEL);
-	if (!arr)
-		return -ENOMEM;
-
-	RCU_INIT_POINTER(s->memcg_params.memcg_caches, arr);
-	return 0;
-}
-
-static void destroy_memcg_params(struct kmem_cache *s)
-{
-	if (is_root_cache(s)) {
-		kvfree(rcu_access_pointer(s->memcg_params.memcg_caches));
-	} else {
-		mem_cgroup_put(s->memcg_params.memcg);
-		WRITE_ONCE(s->memcg_params.memcg, NULL);
-		percpu_ref_exit(&s->memcg_params.refcnt);
-	}
+	else
+		slab_init_memcg_params(s);
 }
 
-static void free_memcg_params(struct rcu_head *rcu)
+void memcg_link_cache(struct kmem_cache *s)
 {
-	struct memcg_cache_array *old;
-
-	old = container_of(rcu, struct memcg_cache_array, rcu);
-	kvfree(old);
-}
-
-static int update_memcg_params(struct kmem_cache *s, int new_array_size)
-{
-	struct memcg_cache_array *old, *new;
-
-	new = kvzalloc(sizeof(struct memcg_cache_array) +
-		       new_array_size * sizeof(void *), GFP_KERNEL);
-	if (!new)
-		return -ENOMEM;
-
-	old = rcu_dereference_protected(s->memcg_params.memcg_caches,
-					lockdep_is_held(&slab_mutex));
-	if (old)
-		memcpy(new->entries, old->entries,
-		       memcg_nr_cache_ids * sizeof(void *));
-
-	rcu_assign_pointer(s->memcg_params.memcg_caches, new);
-	if (old)
-		call_rcu(&old->rcu, free_memcg_params);
-	return 0;
-}
-
-int memcg_update_all_caches(int num_memcgs)
-{
-	struct kmem_cache *s;
-	int ret = 0;
-
-	mutex_lock(&slab_mutex);
-	list_for_each_entry(s, &slab_root_caches, root_caches_node) {
-		ret = update_memcg_params(s, num_memcgs);
-		/*
-		 * Instead of freeing the memory, we'll just leave the caches
-		 * up to this point in an updated state.
-		 */
-		if (ret)
-			break;
-	}
-	mutex_unlock(&slab_mutex);
-	return ret;
-}
-
-void memcg_link_cache(struct kmem_cache *s, struct mem_cgroup *memcg)
-{
-	if (is_root_cache(s)) {
+	if (is_root_cache(s))
 		list_add(&s->root_caches_node, &slab_root_caches);
-	} else {
-		css_get(&memcg->css);
-		s->memcg_params.memcg = memcg;
-		list_add(&s->memcg_params.children_node,
-			 &s->memcg_params.root_cache->memcg_params.children);
-		list_add(&s->memcg_params.kmem_caches_node,
-			 &s->memcg_params.memcg->kmem_caches);
-	}
 }
 
 static void memcg_unlink_cache(struct kmem_cache *s)
 {
-	if (is_root_cache(s)) {
+	if (is_root_cache(s))
 		list_del(&s->root_caches_node);
-	} else {
-		list_del(&s->memcg_params.children_node);
-		list_del(&s->memcg_params.kmem_caches_node);
-	}
 }
 #else
-static inline int init_memcg_params(struct kmem_cache *s,
-				    struct kmem_cache *root_cache)
-{
-	return 0;
-}
-
-static inline void destroy_memcg_params(struct kmem_cache *s)
+static inline void init_memcg_params(struct kmem_cache *s,
+				     struct kmem_cache *root_cache)
 {
 }
 
@@ -380,7 +275,7 @@ static struct kmem_cache *create_cache(const char *name,
 		unsigned int object_size, unsigned int align,
 		slab_flags_t flags, unsigned int useroffset,
 		unsigned int usersize, void (*ctor)(void *),
-		struct mem_cgroup *memcg, struct kmem_cache *root_cache)
+		struct kmem_cache *root_cache)
 {
 	struct kmem_cache *s;
 	int err;
@@ -400,24 +295,20 @@ static struct kmem_cache *create_cache(const char *name,
 	s->useroffset = useroffset;
 	s->usersize = usersize;
 
-	err = init_memcg_params(s, root_cache);
-	if (err)
-		goto out_free_cache;
-
+	init_memcg_params(s, root_cache);
 	err = __kmem_cache_create(s, flags);
 	if (err)
 		goto out_free_cache;
 
 	s->refcount = 1;
 	list_add(&s->list, &slab_caches);
-	memcg_link_cache(s, memcg);
+	memcg_link_cache(s);
 out:
 	if (err)
 		return ERR_PTR(err);
 	return s;
 
 out_free_cache:
-	destroy_memcg_params(s);
 	kmem_cache_free(kmem_cache, s);
 	goto out;
 }
@@ -504,7 +395,7 @@ kmem_cache_create_usercopy(const char *name,
 
 	s = create_cache(cache_name, size,
 			 calculate_alignment(flags, align, size),
-			 flags, useroffset, usersize, ctor, NULL, NULL);
+			 flags, useroffset, usersize, ctor, NULL);
 	if (IS_ERR(s)) {
 		err = PTR_ERR(s);
 		kfree_const(cache_name);
@@ -629,51 +520,27 @@ static int shutdown_cache(struct kmem_cache *s)
 
 #ifdef CONFIG_MEMCG_KMEM
 /*
- * memcg_create_kmem_cache - Create a cache for a memory cgroup.
- * @memcg: The memory cgroup the new cache is for.
+ * memcg_create_kmem_cache - Create a cache for non-root memory cgroups.
  * @root_cache: The parent of the new cache.
  *
  * This function attempts to create a kmem cache that will serve allocation
- * requests going from @memcg to @root_cache. The new cache inherits properties
- * from its parent.
+ * requests going all non-root memory cgroups to @root_cache. The new cache
+ * inherits properties from its parent.
  */
-void memcg_create_kmem_cache(struct mem_cgroup *memcg,
-			     struct kmem_cache *root_cache)
+void memcg_create_kmem_cache(struct kmem_cache *root_cache)
 {
-	static char memcg_name_buf[NAME_MAX + 1]; /* protected by slab_mutex */
-	struct cgroup_subsys_state *css = &memcg->css;
-	struct memcg_cache_array *arr;
 	struct kmem_cache *s = NULL;
 	char *cache_name;
-	int idx;
 
 	get_online_cpus();
 	get_online_mems();
 
 	mutex_lock(&slab_mutex);
 
-	/*
-	 * The memory cgroup could have been offlined while the cache
-	 * creation work was pending.
-	 */
-	if (memcg->kmem_state != KMEM_ONLINE)
-		goto out_unlock;
-
-	idx = memcg_cache_id(memcg);
-	arr = rcu_dereference_protected(root_cache->memcg_params.memcg_caches,
-					lockdep_is_held(&slab_mutex));
-
-	/*
-	 * Since per-memcg caches are created asynchronously on first
-	 * allocation (see memcg_kmem_get_cache()), several threads can try to
-	 * create the same cache, but only one of them may succeed.
-	 */
-	if (arr->entries[idx])
+	if (root_cache->memcg_params.memcg_cache)
 		goto out_unlock;
 
-	cgroup_name(css->cgroup, memcg_name_buf, sizeof(memcg_name_buf));
-	cache_name = kasprintf(GFP_KERNEL, "%s(%llu:%s)", root_cache->name,
-			       css->serial_nr, memcg_name_buf);
+	cache_name = kasprintf(GFP_KERNEL, "%s-memcg", root_cache->name);
 	if (!cache_name)
 		goto out_unlock;
 
@@ -681,7 +548,7 @@ void memcg_create_kmem_cache(struct mem_cgroup *memcg,
 			 root_cache->align,
 			 root_cache->flags & CACHE_CREATE_MASK,
 			 root_cache->useroffset, root_cache->usersize,
-			 root_cache->ctor, memcg, root_cache);
+			 root_cache->ctor, root_cache);
 	/*
 	 * If we could not create a memcg cache, do not complain, because
 	 * that's not critical at all as we can always proceed with the root
@@ -698,7 +565,7 @@ void memcg_create_kmem_cache(struct mem_cgroup *memcg,
 	 * initialized.
 	 */
 	smp_wmb();
-	arr->entries[idx] = s;
+	root_cache->memcg_params.memcg_cache = s;
 
 out_unlock:
 	mutex_unlock(&slab_mutex);
@@ -707,197 +574,18 @@ void memcg_create_kmem_cache(struct mem_cgroup *memcg,
 	put_online_cpus();
 }
 
-static void kmemcg_workfn(struct work_struct *work)
-{
-	struct kmem_cache *s = container_of(work, struct kmem_cache,
-					    memcg_params.work);
-
-	get_online_cpus();
-	get_online_mems();
-
-	mutex_lock(&slab_mutex);
-	s->memcg_params.work_fn(s);
-	mutex_unlock(&slab_mutex);
-
-	put_online_mems();
-	put_online_cpus();
-}
-
-static void kmemcg_rcufn(struct rcu_head *head)
-{
-	struct kmem_cache *s = container_of(head, struct kmem_cache,
-					    memcg_params.rcu_head);
-
-	/*
-	 * We need to grab blocking locks.  Bounce to ->work.  The
-	 * work item shares the space with the RCU head and can't be
-	 * initialized eariler.
-	 */
-	INIT_WORK(&s->memcg_params.work, kmemcg_workfn);
-	queue_work(memcg_kmem_cache_wq, &s->memcg_params.work);
-}
-
-static void kmemcg_cache_shutdown_fn(struct kmem_cache *s)
-{
-	WARN_ON(shutdown_cache(s));
-}
-
-static void kmemcg_cache_shutdown(struct percpu_ref *percpu_ref)
-{
-	struct kmem_cache *s = container_of(percpu_ref, struct kmem_cache,
-					    memcg_params.refcnt);
-	unsigned long flags;
-
-	spin_lock_irqsave(&memcg_kmem_wq_lock, flags);
-	if (s->memcg_params.root_cache->memcg_params.dying)
-		goto unlock;
-
-	s->memcg_params.work_fn = kmemcg_cache_shutdown_fn;
-	INIT_WORK(&s->memcg_params.work, kmemcg_workfn);
-	queue_work(memcg_kmem_cache_wq, &s->memcg_params.work);
-
-unlock:
-	spin_unlock_irqrestore(&memcg_kmem_wq_lock, flags);
-}
-
-static void kmemcg_cache_deactivate_after_rcu(struct kmem_cache *s)
-{
-	__kmemcg_cache_deactivate_after_rcu(s);
-	percpu_ref_kill(&s->memcg_params.refcnt);
-}
-
-static void kmemcg_cache_deactivate(struct kmem_cache *s)
-{
-	if (WARN_ON_ONCE(is_root_cache(s)))
-		return;
-
-	__kmemcg_cache_deactivate(s);
-	s->flags |= SLAB_DEACTIVATED;
-
-	/*
-	 * memcg_kmem_wq_lock is used to synchronize memcg_params.dying
-	 * flag and make sure that no new kmem_cache deactivation tasks
-	 * are queued (see flush_memcg_workqueue() ).
-	 */
-	spin_lock_irq(&memcg_kmem_wq_lock);
-	if (s->memcg_params.root_cache->memcg_params.dying)
-		goto unlock;
-
-	s->memcg_params.work_fn = kmemcg_cache_deactivate_after_rcu;
-	call_rcu(&s->memcg_params.rcu_head, kmemcg_rcufn);
-unlock:
-	spin_unlock_irq(&memcg_kmem_wq_lock);
-}
-
-void memcg_deactivate_kmem_caches(struct mem_cgroup *memcg,
-				  struct mem_cgroup *parent)
-{
-	int idx;
-	struct memcg_cache_array *arr;
-	struct kmem_cache *s, *c;
-	unsigned int nr_reparented;
-
-	idx = memcg_cache_id(memcg);
-
-	get_online_cpus();
-	get_online_mems();
-
-	mutex_lock(&slab_mutex);
-	list_for_each_entry(s, &slab_root_caches, root_caches_node) {
-		arr = rcu_dereference_protected(s->memcg_params.memcg_caches,
-						lockdep_is_held(&slab_mutex));
-		c = arr->entries[idx];
-		if (!c)
-			continue;
-
-		kmemcg_cache_deactivate(c);
-		arr->entries[idx] = NULL;
-	}
-	nr_reparented = 0;
-	list_for_each_entry(s, &memcg->kmem_caches,
-			    memcg_params.kmem_caches_node) {
-		WRITE_ONCE(s->memcg_params.memcg, parent);
-		css_put(&memcg->css);
-		nr_reparented++;
-	}
-	if (nr_reparented) {
-		list_splice_init(&memcg->kmem_caches,
-				 &parent->kmem_caches);
-		css_get_many(&parent->css, nr_reparented);
-	}
-	mutex_unlock(&slab_mutex);
-
-	put_online_mems();
-	put_online_cpus();
-}
-
 static int shutdown_memcg_caches(struct kmem_cache *s)
 {
-	struct memcg_cache_array *arr;
-	struct kmem_cache *c, *c2;
-	LIST_HEAD(busy);
-	int i;
-
 	BUG_ON(!is_root_cache(s));
 
-	/*
-	 * First, shutdown active caches, i.e. caches that belong to online
-	 * memory cgroups.
-	 */
-	arr = rcu_dereference_protected(s->memcg_params.memcg_caches,
-					lockdep_is_held(&slab_mutex));
-	for_each_memcg_cache_index(i) {
-		c = arr->entries[i];
-		if (!c)
-			continue;
-		if (shutdown_cache(c))
-			/*
-			 * The cache still has objects. Move it to a temporary
-			 * list so as not to try to destroy it for a second
-			 * time while iterating over inactive caches below.
-			 */
-			list_move(&c->memcg_params.children_node, &busy);
-		else
-			/*
-			 * The cache is empty and will be destroyed soon. Clear
-			 * the pointer to it in the memcg_caches array so that
-			 * it will never be accessed even if the root cache
-			 * stays alive.
-			 */
-			arr->entries[i] = NULL;
-	}
-
-	/*
-	 * Second, shutdown all caches left from memory cgroups that are now
-	 * offline.
-	 */
-	list_for_each_entry_safe(c, c2, &s->memcg_params.children,
-				 memcg_params.children_node)
-		shutdown_cache(c);
-
-	list_splice(&busy, &s->memcg_params.children);
+	if (s->memcg_params.memcg_cache)
+		WARN_ON(shutdown_cache(s->memcg_params.memcg_cache));
 
-	/*
-	 * A cache being destroyed must be empty. In particular, this means
-	 * that all per memcg caches attached to it must be empty too.
-	 */
-	if (!list_empty(&s->memcg_params.children))
-		return -EBUSY;
 	return 0;
 }
 
 static void flush_memcg_workqueue(struct kmem_cache *s)
 {
-	spin_lock_irq(&memcg_kmem_wq_lock);
-	s->memcg_params.dying = true;
-	spin_unlock_irq(&memcg_kmem_wq_lock);
-
-	/*
-	 * SLAB and SLUB deactivate the kmem_caches through call_rcu. Make
-	 * sure all registered rcu callbacks have been invoked.
-	 */
-	rcu_barrier();
-
 	/*
 	 * SLAB and SLUB create memcg kmem_caches through workqueue and SLUB
 	 * deactivates the memcg kmem_caches through workqueue. Make sure all
@@ -919,7 +607,6 @@ static inline void flush_memcg_workqueue(struct kmem_cache *s)
 void slab_kmem_cache_release(struct kmem_cache *s)
 {
 	__kmem_cache_release(s);
-	destroy_memcg_params(s);
 	kfree_const(s->name);
 	kmem_cache_free(kmem_cache, s);
 }
@@ -983,7 +670,7 @@ int kmem_cache_shrink(struct kmem_cache *cachep)
 EXPORT_SYMBOL(kmem_cache_shrink);
 
 /**
- * kmem_cache_shrink_all - shrink a cache and all memcg caches for root cache
+ * kmem_cache_shrink_all - shrink root and memcg caches
  * @s: The cache pointer
  */
 void kmem_cache_shrink_all(struct kmem_cache *s)
@@ -1000,21 +687,11 @@ void kmem_cache_shrink_all(struct kmem_cache *s)
 	kasan_cache_shrink(s);
 	__kmem_cache_shrink(s);
 
-	/*
-	 * We have to take the slab_mutex to protect from the memcg list
-	 * modification.
-	 */
-	mutex_lock(&slab_mutex);
-	for_each_memcg_cache(c, s) {
-		/*
-		 * Don't need to shrink deactivated memcg caches.
-		 */
-		if (s->flags & SLAB_DEACTIVATED)
-			continue;
+	c = memcg_cache(s);
+	if (c) {
 		kasan_cache_shrink(c);
 		__kmem_cache_shrink(c);
 	}
-	mutex_unlock(&slab_mutex);
 	put_online_mems();
 	put_online_cpus();
 }
@@ -1069,7 +746,7 @@ struct kmem_cache *__init create_kmalloc_cache(const char *name,
 
 	create_boot_cache(s, name, size, flags, useroffset, usersize);
 	list_add(&s->list, &slab_caches);
-	memcg_link_cache(s, NULL);
+	memcg_link_cache(s);
 	s->refcount = 1;
 	return s;
 }
@@ -1431,7 +1108,8 @@ memcg_accumulate_slabinfo(struct kmem_cache *s, struct slabinfo *info)
 	if (!is_root_cache(s))
 		return;
 
-	for_each_memcg_cache(c, s) {
+	c = memcg_cache(s);
+	if (c) {
 		memset(&sinfo, 0, sizeof(sinfo));
 		get_slabinfo(c, &sinfo);
 
@@ -1562,7 +1240,7 @@ module_init(slab_proc_init);
 
 #if defined(CONFIG_DEBUG_FS) && defined(CONFIG_MEMCG_KMEM)
 /*
- * Display information about kmem caches that have child memcg caches.
+ * Display information about kmem caches that have memcg cache.
  */
 static int memcg_slabinfo_show(struct seq_file *m, void *unused)
 {
@@ -1574,9 +1252,9 @@ static int memcg_slabinfo_show(struct seq_file *m, void *unused)
 	seq_puts(m, " <active_slabs> <num_slabs>\n");
 	list_for_each_entry(s, &slab_root_caches, root_caches_node) {
 		/*
-		 * Skip kmem caches that don't have any memcg children.
+		 * Skip kmem caches that don't have the memcg cache.
 		 */
-		if (list_empty(&s->memcg_params.children))
+		if (!s->memcg_params.memcg_cache)
 			continue;
 
 		memset(&sinfo, 0, sizeof(sinfo));
@@ -1585,23 +1263,13 @@ static int memcg_slabinfo_show(struct seq_file *m, void *unused)
 			   cache_name(s), sinfo.active_objs, sinfo.num_objs,
 			   sinfo.active_slabs, sinfo.num_slabs);
 
-		for_each_memcg_cache(c, s) {
-			struct cgroup_subsys_state *css;
-			char *status = "";
-
-			css = &c->memcg_params.memcg->css;
-			if (!(css->flags & CSS_ONLINE))
-				status = ":dead";
-			else if (c->flags & SLAB_DEACTIVATED)
-				status = ":deact";
-
-			memset(&sinfo, 0, sizeof(sinfo));
-			get_slabinfo(c, &sinfo);
-			seq_printf(m, "%-17s %4d%-6s %6lu %6lu %6lu %6lu\n",
-				   cache_name(c), css->id, status,
-				   sinfo.active_objs, sinfo.num_objs,
-				   sinfo.active_slabs, sinfo.num_slabs);
-		}
+		c = s->memcg_params.memcg_cache;
+		memset(&sinfo, 0, sizeof(sinfo));
+		get_slabinfo(c, &sinfo);
+		seq_printf(m, "%-17s %4d %6lu %6lu %6lu %6lu\n",
+			   cache_name(c), root_mem_cgroup->css.id,
+			   sinfo.active_objs, sinfo.num_objs,
+			   sinfo.active_slabs, sinfo.num_slabs);
 	}
 	mutex_unlock(&slab_mutex);
 	return 0;
diff --git a/mm/slub.c b/mm/slub.c
index a62545c7acac..53abbf0831b6 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4057,36 +4057,6 @@ int __kmem_cache_shrink(struct kmem_cache *s)
 	return ret;
 }
 
-#ifdef CONFIG_MEMCG
-void __kmemcg_cache_deactivate_after_rcu(struct kmem_cache *s)
-{
-	/*
-	 * Called with all the locks held after a sched RCU grace period.
-	 * Even if @s becomes empty after shrinking, we can't know that @s
-	 * doesn't have allocations already in-flight and thus can't
-	 * destroy @s until the associated memcg is released.
-	 *
-	 * However, let's remove the sysfs files for empty caches here.
-	 * Each cache has a lot of interface files which aren't
-	 * particularly useful for empty draining caches; otherwise, we can
-	 * easily end up with millions of unnecessary sysfs files on
-	 * systems which have a lot of memory and transient cgroups.
-	 */
-	if (!__kmem_cache_shrink(s))
-		sysfs_slab_remove(s);
-}
-
-void __kmemcg_cache_deactivate(struct kmem_cache *s)
-{
-	/*
-	 * Disable empty slabs caching. Used to avoid pinning offline
-	 * memory cgroups by kmem pages that can be freed.
-	 */
-	slub_set_cpu_partial(s, 0);
-	s->min_partial = 0;
-}
-#endif	/* CONFIG_MEMCG */
-
 static int slab_mem_going_offline_callback(void *arg)
 {
 	struct kmem_cache *s;
@@ -4243,7 +4213,7 @@ static struct kmem_cache * __init bootstrap(struct kmem_cache *static_cache)
 	}
 	slab_init_memcg_params(s);
 	list_add(&s->list, &slab_caches);
-	memcg_link_cache(s, NULL);
+	memcg_link_cache(s);
 	return s;
 }
 
@@ -4311,7 +4281,8 @@ __kmem_cache_alias(const char *name, unsigned int size, unsigned int align,
 		s->object_size = max(s->object_size, size);
 		s->inuse = max(s->inuse, ALIGN(size, sizeof(void *)));
 
-		for_each_memcg_cache(c, s) {
+		c = memcg_cache(s);
+		if (c) {
 			c->object_size = s->object_size;
 			c->inuse = max(c->inuse, ALIGN(size, sizeof(void *)));
 		}
@@ -5582,7 +5553,8 @@ static ssize_t slab_attr_store(struct kobject *kobj,
 		 * directly either failed or succeeded, in which case we loop
 		 * through the descendants with best-effort propagation.
 		 */
-		for_each_memcg_cache(c, s)
+		c = memcg_cache(s);
+		if (c)
 			attribute->store(c, buf, len);
 		mutex_unlock(&slab_mutex);
 	}
-- 
2.21.0

