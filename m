Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 815EFC28D18
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 02:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 518FF20851
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 02:45:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="V/rfOhOR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbfFECpF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 22:45:05 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:46408 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726637AbfFECpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 22:45:03 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x552hZuc009253
        for <linux-kernel@vger.kernel.org>; Tue, 4 Jun 2019 19:45:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=Wv6PULr08vn6aMDCf+MGkZnKQqchIV9NxQ/kg/T87Dk=;
 b=V/rfOhOR1cl30AcZIOb+eG4ipiYWLHfyERFMHlNPGsiZBivqkgrS4m8TeWLxuBcEBrhb
 bn0jJ8hPEKWkfBLiKHf+V2jlKxFpIYFrpbU4y2/Bv/+V/1ZOoQLbdiPZLFx0WnL4pKKA
 +zFdPCbi0Pbd17HY3nQV4JDVBeGyKiU2+n4= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2sx0j78sds-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 19:45:02 -0700
Received: from mx-out.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 4 Jun 2019 19:44:59 -0700
Received: by devvm2643.prn2.facebook.com (Postfix, from userid 111017)
        id 83CC012C7FDC8; Tue,  4 Jun 2019 19:44:58 -0700 (PDT)
Smtp-Origin-Hostprefix: devvm
From:   Roman Gushchin <guro@fb.com>
Smtp-Origin-Hostname: devvm2643.prn2.facebook.com
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Waiman Long <longman@redhat.com>, Roman Gushchin <guro@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH v6 04/10] mm: generalize postponed non-root kmem_cache deactivation
Date:   Tue, 4 Jun 2019 19:44:48 -0700
Message-ID: <20190605024454.1393507-5-guro@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190605024454.1393507-1-guro@fb.com>
References: <20190605024454.1393507-1-guro@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-05_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906050015
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently SLUB uses a work scheduled after an RCU grace period
to deactivate a non-root kmem_cache. This mechanism can be reused
for kmem_caches release, but requires generalization for SLAB
case.

Introduce kmemcg_cache_deactivate() function, which calls
allocator-specific __kmem_cache_deactivate() and schedules
execution of __kmem_cache_deactivate_after_rcu() with all
necessary locks in a worker context after an rcu grace period.

Here is the new calling scheme:
  kmemcg_cache_deactivate()
    __kmemcg_cache_deactivate()                  SLAB/SLUB-specific
    kmemcg_rcufn()                               rcu
      kmemcg_workfn()                            work
        __kmemcg_cache_deactivate_after_rcu()    SLAB/SLUB-specific

instead of:
  __kmemcg_cache_deactivate()                    SLAB/SLUB-specific
    slab_deactivate_memcg_cache_rcu_sched()      SLUB-only
      kmemcg_rcufn()                             rcu
        kmemcg_workfn()                          work
          kmemcg_cache_deact_after_rcu()         SLUB-only

For consistency, all allocator-specific functions start with "__".

Signed-off-by: Roman Gushchin <guro@fb.com>
---
 mm/slab.c        |  4 ++++
 mm/slab.h        |  3 +--
 mm/slab_common.c | 27 ++++++++-------------------
 mm/slub.c        |  8 +-------
 4 files changed, 14 insertions(+), 28 deletions(-)

diff --git a/mm/slab.c b/mm/slab.c
index a4091f8b3655..4b865393ebb4 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -2252,6 +2252,10 @@ void __kmemcg_cache_deactivate(struct kmem_cache *cachep)
 {
 	__kmem_cache_shrink(cachep);
 }
+
+void __kmemcg_cache_deactivate_after_rcu(struct kmem_cache *s)
+{
+}
 #endif
 
 int __kmem_cache_shutdown(struct kmem_cache *cachep)
diff --git a/mm/slab.h b/mm/slab.h
index 8ff90f42548a..d35d85794247 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -172,6 +172,7 @@ int __kmem_cache_shutdown(struct kmem_cache *);
 void __kmem_cache_release(struct kmem_cache *);
 int __kmem_cache_shrink(struct kmem_cache *);
 void __kmemcg_cache_deactivate(struct kmem_cache *s);
+void __kmemcg_cache_deactivate_after_rcu(struct kmem_cache *s);
 void slab_kmem_cache_release(struct kmem_cache *);
 
 struct seq_file;
@@ -291,8 +292,6 @@ static __always_inline void memcg_uncharge_slab(struct page *page, int order,
 
 extern void slab_init_memcg_params(struct kmem_cache *);
 extern void memcg_link_cache(struct kmem_cache *s, struct mem_cgroup *memcg);
-extern void slab_deactivate_memcg_cache_rcu_sched(struct kmem_cache *s,
-				void (*work_fn)(struct kmem_cache *));
 
 #else /* CONFIG_MEMCG_KMEM */
 
diff --git a/mm/slab_common.c b/mm/slab_common.c
index d019ee66bdc4..09b26673b63f 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -709,7 +709,7 @@ static void kmemcg_workfn(struct work_struct *work)
 	put_online_mems();
 	put_online_cpus();
 
-	/* done, put the ref from slab_deactivate_memcg_cache_rcu_sched() */
+	/* done, put the ref from kmemcg_cache_deactivate() */
 	css_put(&s->memcg_params.memcg->css);
 }
 
@@ -727,31 +727,21 @@ static void kmemcg_rcufn(struct rcu_head *head)
 	queue_work(memcg_kmem_cache_wq, &s->memcg_params.work);
 }
 
-/**
- * slab_deactivate_memcg_cache_rcu_sched - schedule deactivation after a
- *					   sched RCU grace period
- * @s: target kmem_cache
- * @work_fn: deactivation function to call
- *
- * Schedule @work_fn to be invoked with online cpus, mems and slab_mutex
- * held after a sched RCU grace period.  The slab is guaranteed to stay
- * alive until @work_fn is finished.  This is to be used from
- * __kmemcg_cache_deactivate().
- */
-void slab_deactivate_memcg_cache_rcu_sched(struct kmem_cache *s,
-					   void (*work_fn)(struct kmem_cache *))
+static void kmemcg_cache_deactivate(struct kmem_cache *s)
 {
 	if (WARN_ON_ONCE(is_root_cache(s)) ||
 	    WARN_ON_ONCE(s->memcg_params.work_fn))
 		return;
 
+	__kmemcg_cache_deactivate(s);
+
 	if (s->memcg_params.root_cache->memcg_params.dying)
 		return;
 
 	/* pin memcg so that @s doesn't get destroyed in the middle */
 	css_get(&s->memcg_params.memcg->css);
 
-	s->memcg_params.work_fn = work_fn;
+	s->memcg_params.work_fn = __kmemcg_cache_deactivate_after_rcu;
 	call_rcu(&s->memcg_params.rcu_head, kmemcg_rcufn);
 }
 
@@ -774,7 +764,7 @@ void memcg_deactivate_kmem_caches(struct mem_cgroup *memcg)
 		if (!c)
 			continue;
 
-		__kmemcg_cache_deactivate(c);
+		kmemcg_cache_deactivate(c);
 		arr->entries[idx] = NULL;
 	}
 	mutex_unlock(&slab_mutex);
@@ -867,11 +857,10 @@ static void flush_memcg_workqueue(struct kmem_cache *s)
 	mutex_unlock(&slab_mutex);
 
 	/*
-	 * SLUB deactivates the kmem_caches through call_rcu. Make
+	 * SLAB and SLUB deactivate the kmem_caches through call_rcu. Make
 	 * sure all registered rcu callbacks have been invoked.
 	 */
-	if (IS_ENABLED(CONFIG_SLUB))
-		rcu_barrier();
+	rcu_barrier();
 
 	/*
 	 * SLAB and SLUB create memcg kmem_caches through workqueue and SLUB
diff --git a/mm/slub.c b/mm/slub.c
index 9cb2eef62a37..ae3b1e49ecec 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4022,7 +4022,7 @@ int __kmem_cache_shrink(struct kmem_cache *s)
 }
 
 #ifdef CONFIG_MEMCG
-static void kmemcg_cache_deact_after_rcu(struct kmem_cache *s)
+void __kmemcg_cache_deactivate_after_rcu(struct kmem_cache *s)
 {
 	/*
 	 * Called with all the locks held after a sched RCU grace period.
@@ -4048,12 +4048,6 @@ void __kmemcg_cache_deactivate(struct kmem_cache *s)
 	 */
 	slub_set_cpu_partial(s, 0);
 	s->min_partial = 0;
-
-	/*
-	 * s->cpu_partial is checked locklessly (see put_cpu_partial), so
-	 * we have to make sure the change is visible before shrinking.
-	 */
-	slab_deactivate_memcg_cache_rcu_sched(s, kmemcg_cache_deact_after_rcu);
 }
 #endif	/* CONFIG_MEMCG */
 
-- 
2.20.1

