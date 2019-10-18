Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB9BECA9ECA
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 00:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C1D721852
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 00:28:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="orC2ytYI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406849AbfJRA2i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 20:28:38 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:8332 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728495AbfJRA2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 20:28:37 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9I0P68d002605
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 17:28:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=+4EuFXoz6PBFGXJnX24Fea7l6snTrRg2U/5Bduqey+g=;
 b=orC2ytYIwK9sorMKj9DfyA0mx4RPENst/KCn3UKBhtYec03epuAO51qtzejQq1SDEm2g
 CVjRP9Wzwt+OZBawy8+PhCEAYy9Fgg4uLm9S5S6zZsCa4XxX9W7QwWUTqoYr25YmRMom
 X8bhFfqVmjZQ+U2Zfip6HDEQjay0zn7KWVs= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2vp5k0g0d6-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 17:28:36 -0700
Received: from 2401:db00:30:6012:face:0:17:0 (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Thu, 17 Oct 2019 17:28:35 -0700
Received: by devvm2643.prn2.facebook.com (Postfix, from userid 111017)
        id 099DE18CE8485; Thu, 17 Oct 2019 17:28:34 -0700 (PDT)
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
Subject: [PATCH 09/16] mm: memcg/slab: charge individual slab objects instead of pages
Date:   Thu, 17 Oct 2019 17:28:13 -0700
Message-ID: <20191018002820.307763-10-guro@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191018002820.307763-1-guro@fb.com>
References: <20191018002820.307763-1-guro@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-17_07:2019-10-17,2019-10-17 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0
 suspectscore=3 bulkscore=0 clxscore=1015 mlxscore=0 mlxlogscore=999
 impostorscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1908290000 definitions=main-1910180001
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch to per-object accounting of non-root slab objects.

Charging is performed using subpage charging API in pre_alloc hook.
If the amount of memory has been charged successfully, we proceed
with the actual allocation. Otherwise, -ENOMEM is returned.

In post_alloc hook we do check if the actual allocation succeeded.
If so, corresponding vmstats are bumped and memcg membership
information is recorded. Otherwise, the charge is canceled.

On free path we do look for memcg membership information,
decrement stats and do uncharge. No operations are performed
with root kmem_caches.

Global per-node slab-related vmstats NR_SLAB_(UN)RECLAIMABLE_B
are still modified from (un)charge_slab_page() functions. The idea
is to keep all slab pages accounted as slab pages on system level.
Memcg and lruvec counters are now representing only memory used
by actual slab objects and do not include free space. Free space
is shared and doesn't belong to any specific cgroup.

Signed-off-by: Roman Gushchin <guro@fb.com>
---
 mm/slab.h | 152 ++++++++++++++++++++----------------------------------
 1 file changed, 57 insertions(+), 95 deletions(-)

diff --git a/mm/slab.h b/mm/slab.h
index 28feabed1e9a..0f2f712de77a 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -340,72 +340,6 @@ static inline struct mem_cgroup *memcg_from_slab_page(struct page *page)
 	return NULL;
 }
 
-/*
- * Charge the slab page belonging to the non-root kmem_cache.
- * Can be called for non-root kmem_caches only.
- */
-static __always_inline int memcg_charge_slab(struct page *page,
-					     gfp_t gfp, int order,
-					     struct kmem_cache *s)
-{
-	struct mem_cgroup *memcg;
-	struct lruvec *lruvec;
-	int ret;
-
-	rcu_read_lock();
-	memcg = READ_ONCE(s->memcg_params.memcg);
-	while (memcg && !css_tryget_online(&memcg->css))
-		memcg = parent_mem_cgroup(memcg);
-	rcu_read_unlock();
-
-	if (unlikely(!memcg || mem_cgroup_is_root(memcg))) {
-		mod_node_page_state(page_pgdat(page), cache_vmstat_idx(s),
-				    (PAGE_SIZE << order));
-		percpu_ref_get_many(&s->memcg_params.refcnt, 1 << order);
-		return 0;
-	}
-
-	ret = memcg_kmem_charge_memcg(page, gfp, order, memcg);
-	if (ret)
-		goto out;
-
-	lruvec = mem_cgroup_lruvec(page_pgdat(page), memcg);
-	mod_lruvec_state(lruvec, cache_vmstat_idx(s), PAGE_SIZE << order);
-
-	/* transer try_charge() page references to kmem_cache */
-	percpu_ref_get_many(&s->memcg_params.refcnt, 1 << order);
-	css_put_many(&memcg->css, 1 << order);
-out:
-	css_put(&memcg->css);
-	return ret;
-}
-
-/*
- * Uncharge a slab page belonging to a non-root kmem_cache.
- * Can be called for non-root kmem_caches only.
- */
-static __always_inline void memcg_uncharge_slab(struct page *page, int order,
-						struct kmem_cache *s)
-{
-	struct mem_cgroup *memcg;
-	struct lruvec *lruvec;
-
-	rcu_read_lock();
-	memcg = READ_ONCE(s->memcg_params.memcg);
-	if (likely(!mem_cgroup_is_root(memcg))) {
-		lruvec = mem_cgroup_lruvec(page_pgdat(page), memcg);
-		mod_lruvec_state(lruvec, cache_vmstat_idx(s),
-				 -(PAGE_SIZE << order));
-		memcg_kmem_uncharge_memcg(page, order, memcg);
-	} else {
-		mod_node_page_state(page_pgdat(page), cache_vmstat_idx(s),
-				    -(PAGE_SIZE << order));
-	}
-	rcu_read_unlock();
-
-	percpu_ref_put_many(&s->memcg_params.refcnt, 1 << order);
-}
-
 static inline int memcg_alloc_page_memcg_vec(struct page *page, gfp_t gfp,
 					     unsigned int objects)
 {
@@ -423,11 +357,31 @@ static inline void memcg_free_page_memcg_vec(struct page *page)
 	page->mem_cgroup_vec = NULL;
 }
 
+static inline struct kmem_cache *memcg_slab_pre_alloc_hook(struct kmem_cache *s,
+						struct mem_cgroup **memcgp,
+						size_t size, gfp_t flags)
+{
+	struct kmem_cache *cachep;
+
+	cachep = memcg_kmem_get_cache(s, memcgp);
+	if (is_root_cache(cachep))
+		return s;
+
+	if (__memcg_kmem_charge_subpage(*memcgp, size * s->size, flags)) {
+		mem_cgroup_put(*memcgp);
+		memcg_kmem_put_cache(cachep);
+		cachep = NULL;
+	}
+
+	return cachep;
+}
+
 static inline void memcg_slab_post_alloc_hook(struct kmem_cache *s,
 					      struct mem_cgroup *memcg,
 					      size_t size, void **p)
 {
 	struct mem_cgroup_ptr *memcg_ptr;
+	struct lruvec *lruvec;
 	struct page *page;
 	unsigned long off;
 	size_t i;
@@ -439,6 +393,11 @@ static inline void memcg_slab_post_alloc_hook(struct kmem_cache *s,
 			off = obj_to_index(s, page, p[i]);
 			mem_cgroup_ptr_get(memcg_ptr);
 			page->mem_cgroup_vec[off] = memcg_ptr;
+			lruvec = mem_cgroup_lruvec(page_pgdat(page), memcg);
+			mod_lruvec_memcg_state(lruvec, cache_vmstat_idx(s),
+					       s->size);
+		} else {
+			__memcg_kmem_uncharge_subpage(memcg, s->size);
 		}
 	}
 	mem_cgroup_ptr_put(memcg_ptr);
@@ -451,6 +410,8 @@ static inline void memcg_slab_free_hook(struct kmem_cache *s, struct page *page,
 					void *p)
 {
 	struct mem_cgroup_ptr *memcg_ptr;
+	struct mem_cgroup *memcg;
+	struct lruvec *lruvec;
 	unsigned int off;
 
 	if (!memcg_kmem_enabled() || is_root_cache(s))
@@ -459,6 +420,14 @@ static inline void memcg_slab_free_hook(struct kmem_cache *s, struct page *page,
 	off = obj_to_index(s, page, p);
 	memcg_ptr = page->mem_cgroup_vec[off];
 	page->mem_cgroup_vec[off] = NULL;
+	rcu_read_lock();
+	memcg = memcg_ptr->memcg;
+	if (likely(!mem_cgroup_is_root(memcg))) {
+		__memcg_kmem_uncharge_subpage(memcg, s->size);
+		lruvec = mem_cgroup_lruvec(page_pgdat(page), memcg);
+		mod_lruvec_memcg_state(lruvec, cache_vmstat_idx(s), -s->size);
+	}
+	rcu_read_unlock();
 	mem_cgroup_ptr_put(memcg_ptr);
 }
 
@@ -500,17 +469,6 @@ static inline struct mem_cgroup *memcg_from_slab_page(struct page *page)
 	return NULL;
 }
 
-static inline int memcg_charge_slab(struct page *page, gfp_t gfp, int order,
-				    struct kmem_cache *s)
-{
-	return 0;
-}
-
-static inline void memcg_uncharge_slab(struct page *page, int order,
-				       struct kmem_cache *s)
-{
-}
-
 static inline int memcg_alloc_page_memcg_vec(struct page *page, gfp_t gfp,
 					     unsigned int objects)
 {
@@ -521,6 +479,13 @@ static inline void memcg_free_page_memcg_vec(struct page *page)
 {
 }
 
+static inline struct kmem_cache *memcg_slab_pre_alloc_hook(struct kmem_cache *s,
+						struct mem_cgroup **memcgp,
+						size_t size, gfp_t flags)
+{
+	return NULL;
+}
+
 static inline void memcg_slab_post_alloc_hook(struct kmem_cache *s,
 					      struct mem_cgroup *memcg,
 					      size_t size, void **p)
@@ -561,30 +526,27 @@ static __always_inline int charge_slab_page(struct page *page,
 {
 	int ret;
 
-	if (is_root_cache(s)) {
-		mod_node_page_state(page_pgdat(page), cache_vmstat_idx(s),
-				    PAGE_SIZE << order);
-		return 0;
-	}
-
-	ret = memcg_alloc_page_memcg_vec(page, gfp, objects);
-	if (ret)
-		return ret;
+	if (!is_root_cache(s)) {
+		ret = memcg_alloc_page_memcg_vec(page, gfp, objects);
+		if (ret)
+			return ret;
 
-	return memcg_charge_slab(page, gfp, order, s);
+		percpu_ref_get_many(&s->memcg_params.refcnt, 1 << order);
+	}
+	mod_node_page_state(page_pgdat(page), cache_vmstat_idx(s),
+			    PAGE_SIZE << order);
+	return 0;
 }
 
 static __always_inline void uncharge_slab_page(struct page *page, int order,
 					       struct kmem_cache *s)
 {
-	if (is_root_cache(s)) {
-		mod_node_page_state(page_pgdat(page), cache_vmstat_idx(s),
-				    -(PAGE_SIZE << order));
-		return;
+	if (!is_root_cache(s)) {
+		memcg_free_page_memcg_vec(page);
+		percpu_ref_put_many(&s->memcg_params.refcnt, 1 << order);
 	}
-
-	memcg_free_page_memcg_vec(page);
-	memcg_uncharge_slab(page, order, s);
+	mod_node_page_state(page_pgdat(page), cache_vmstat_idx(s),
+			    -(PAGE_SIZE << order));
 }
 
 static inline struct kmem_cache *cache_from_obj(struct kmem_cache *s, void *x)
@@ -656,7 +618,7 @@ static inline struct kmem_cache *slab_pre_alloc_hook(struct kmem_cache *s,
 
 	if (memcg_kmem_enabled() &&
 	    ((flags & __GFP_ACCOUNT) || (s->flags & SLAB_ACCOUNT)))
-		return memcg_kmem_get_cache(s, memcgp);
+		return memcg_slab_pre_alloc_hook(s, memcgp, size, flags);
 
 	return s;
 }
-- 
2.21.0

