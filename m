Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53E45C31E44
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 23:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C41320872
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 23:18:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="G2316pcB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407990AbfFKXSY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 19:18:24 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:50578 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2407975AbfFKXSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 19:18:24 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5BN8FOp026250
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 16:18:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=y8x91J89Hsw0QdQlhcd3vnyvb98p4X6XpzkxVy4k5LU=;
 b=G2316pcBitLm0xhNSOGwtMs4VFS7W8LMn6B4d6jVQ00LyWUySjzJ/QnPAXtvLvPWzx14
 r1yxBZ7D8Ze0i4UT5VisczIizNG7xGiA54lkOCttqKQKUx7/R54ChtKV46AkQi4tj8NM
 /99uNAn0BTGWMUQUcWidfjy1DYIrMekUlxQ= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2t2jma8q5t-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 16:18:23 -0700
Received: from mx-out.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 11 Jun 2019 16:18:21 -0700
Received: by devvm2643.prn2.facebook.com (Postfix, from userid 111017)
        id 2CD40130CBF69; Tue, 11 Jun 2019 16:18:20 -0700 (PDT)
Smtp-Origin-Hostprefix: devvm
From:   Roman Gushchin <guro@fb.com>
Smtp-Origin-Hostname: devvm2643.prn2.facebook.com
To:     Andrew Morton <akpm@linux-foundation.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Waiman Long <longman@redhat.com>, Roman Gushchin <guro@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH v7 02/10] mm: rename slab delayed deactivation functions and fields
Date:   Tue, 11 Jun 2019 16:18:05 -0700
Message-ID: <20190611231813.3148843-3-guro@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190611231813.3148843-1-guro@fb.com>
References: <20190611231813.3148843-1-guro@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-11_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906110151
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The delayed work/rcu deactivation infrastructure of non-root
kmem_caches can be also used for asynchronous release of these
objects. Let's get rid of the word "deactivation" in corresponding
names to make the code look better after generalization.

It's easier to make the renaming first, so that the generalized
code will look consistent from scratch.

Let's rename struct memcg_cache_params fields:
  deact_fn -> work_fn
  deact_rcu_head -> rcu_head
  deact_work -> work

And RCU/delayed work callbacks in slab common code:
  kmemcg_deactivate_rcufn -> kmemcg_rcufn
  kmemcg_deactivate_workfn -> kmemcg_workfn

This patch contains no functional changes, only renamings.

Signed-off-by: Roman Gushchin <guro@fb.com>
Acked-by: Vladimir Davydov <vdavydov.dev@gmail.com>
---
 include/linux/slab.h |  6 +++---
 mm/slab.h            |  2 +-
 mm/slab_common.c     | 30 +++++++++++++++---------------
 3 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 9449b19c5f10..47923c173f30 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -642,10 +642,10 @@ struct memcg_cache_params {
 			struct list_head children_node;
 			struct list_head kmem_caches_node;
 
-			void (*deact_fn)(struct kmem_cache *);
+			void (*work_fn)(struct kmem_cache *);
 			union {
-				struct rcu_head deact_rcu_head;
-				struct work_struct deact_work;
+				struct rcu_head rcu_head;
+				struct work_struct work;
 			};
 		};
 	};
diff --git a/mm/slab.h b/mm/slab.h
index 86f7ede21203..7ef695b91919 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -291,7 +291,7 @@ static __always_inline void memcg_uncharge_slab(struct page *page, int order,
 extern void slab_init_memcg_params(struct kmem_cache *);
 extern void memcg_link_cache(struct kmem_cache *s, struct mem_cgroup *memcg);
 extern void slab_deactivate_memcg_cache_rcu_sched(struct kmem_cache *s,
-				void (*deact_fn)(struct kmem_cache *));
+				void (*work_fn)(struct kmem_cache *));
 
 #else /* CONFIG_MEMCG_KMEM */
 
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 6e00bdf8618d..99489d82ba78 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -691,17 +691,17 @@ void memcg_create_kmem_cache(struct mem_cgroup *memcg,
 	put_online_cpus();
 }
 
-static void kmemcg_deactivate_workfn(struct work_struct *work)
+static void kmemcg_workfn(struct work_struct *work)
 {
 	struct kmem_cache *s = container_of(work, struct kmem_cache,
-					    memcg_params.deact_work);
+					    memcg_params.work);
 
 	get_online_cpus();
 	get_online_mems();
 
 	mutex_lock(&slab_mutex);
 
-	s->memcg_params.deact_fn(s);
+	s->memcg_params.work_fn(s);
 
 	mutex_unlock(&slab_mutex);
 
@@ -712,36 +712,36 @@ static void kmemcg_deactivate_workfn(struct work_struct *work)
 	css_put(&s->memcg_params.memcg->css);
 }
 
-static void kmemcg_deactivate_rcufn(struct rcu_head *head)
+static void kmemcg_rcufn(struct rcu_head *head)
 {
 	struct kmem_cache *s = container_of(head, struct kmem_cache,
-					    memcg_params.deact_rcu_head);
+					    memcg_params.rcu_head);
 
 	/*
-	 * We need to grab blocking locks.  Bounce to ->deact_work.  The
+	 * We need to grab blocking locks.  Bounce to ->work.  The
 	 * work item shares the space with the RCU head and can't be
 	 * initialized eariler.
 	 */
-	INIT_WORK(&s->memcg_params.deact_work, kmemcg_deactivate_workfn);
-	queue_work(memcg_kmem_cache_wq, &s->memcg_params.deact_work);
+	INIT_WORK(&s->memcg_params.work, kmemcg_workfn);
+	queue_work(memcg_kmem_cache_wq, &s->memcg_params.work);
 }
 
 /**
  * slab_deactivate_memcg_cache_rcu_sched - schedule deactivation after a
  *					   sched RCU grace period
  * @s: target kmem_cache
- * @deact_fn: deactivation function to call
+ * @work_fn: deactivation function to call
  *
- * Schedule @deact_fn to be invoked with online cpus, mems and slab_mutex
+ * Schedule @work_fn to be invoked with online cpus, mems and slab_mutex
  * held after a sched RCU grace period.  The slab is guaranteed to stay
- * alive until @deact_fn is finished.  This is to be used from
+ * alive until @work_fn is finished.  This is to be used from
  * __kmemcg_cache_deactivate().
  */
 void slab_deactivate_memcg_cache_rcu_sched(struct kmem_cache *s,
-					   void (*deact_fn)(struct kmem_cache *))
+					   void (*work_fn)(struct kmem_cache *))
 {
 	if (WARN_ON_ONCE(is_root_cache(s)) ||
-	    WARN_ON_ONCE(s->memcg_params.deact_fn))
+	    WARN_ON_ONCE(s->memcg_params.work_fn))
 		return;
 
 	if (s->memcg_params.root_cache->memcg_params.dying)
@@ -750,8 +750,8 @@ void slab_deactivate_memcg_cache_rcu_sched(struct kmem_cache *s,
 	/* pin memcg so that @s doesn't get destroyed in the middle */
 	css_get(&s->memcg_params.memcg->css);
 
-	s->memcg_params.deact_fn = deact_fn;
-	call_rcu(&s->memcg_params.deact_rcu_head, kmemcg_deactivate_rcufn);
+	s->memcg_params.work_fn = work_fn;
+	call_rcu(&s->memcg_params.rcu_head, kmemcg_rcufn);
 }
 
 void memcg_deactivate_kmem_caches(struct mem_cgroup *memcg)
-- 
2.21.0

