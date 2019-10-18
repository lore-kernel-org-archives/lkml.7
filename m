Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DC76CA9EC8
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 00:29:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEC6321D7D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 00:29:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="MGrwpPYX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504008AbfJRA3b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 20:29:31 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:62102 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2406885AbfJRA2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 20:28:40 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9I0NtFn001496
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 17:28:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=pvgXXdTrCLKbYDxethJ96kH3nJKjLK66UDI+XKz1Op0=;
 b=MGrwpPYXjF9zWAfew+3Ui97Ef/fN4c2eCMaxmjTGTnJjlBSdiL1UPcF/haIaUGmjNfwV
 hTE7zbYQgDMxGW0l8B4i8vOwHl6xsQk7phVB9W1ONKMkdB8nBiZiK9fWbe8q1dgqv44h
 ivopRS8qIwx/YpVrylFgGBSegrA+v2sNOfM= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2vpj8rvkyf-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 17:28:40 -0700
Received: from 2401:db00:30:600c:face:0:1f:0 (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 17 Oct 2019 17:28:35 -0700
Received: by devvm2643.prn2.facebook.com (Postfix, from userid 111017)
        id EC87218CE847B; Thu, 17 Oct 2019 17:28:33 -0700 (PDT)
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
Subject: [PATCH 04/16] mm: memcg/slab: allocate space for memcg ownership data for non-root slabs
Date:   Thu, 17 Oct 2019 17:28:08 -0700
Message-ID: <20191018002820.307763-5-guro@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191018002820.307763-1-guro@fb.com>
References: <20191018002820.307763-1-guro@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-17_07:2019-10-17,2019-10-17 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=782
 clxscore=1015 spamscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=3 malwarescore=0 adultscore=0 bulkscore=0
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910180001
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allocate and release memory for storing the memcg ownership data.
For each slab page allocate space sufficient for number_of_objects
pointers to struct mem_cgroup_vec.

The mem_cgroup field of the struct page isn't used for slab pages,
so let's use the space for storing the pointer for the allocated
space.

This commit makes sure that the space is ready for use, but nobody
is actually using it yet. Following commits in the series will fix it.

Signed-off-by: Roman Gushchin <guro@fb.com>
---
 include/linux/mm_types.h |  5 ++++-
 mm/slab.c                |  3 ++-
 mm/slab.h                | 37 ++++++++++++++++++++++++++++++++++++-
 mm/slub.c                |  2 +-
 4 files changed, 43 insertions(+), 4 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 2222fa795284..4d99ee5a9c53 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -198,7 +198,10 @@ struct page {
 	atomic_t _refcount;
 
 #ifdef CONFIG_MEMCG
-	struct mem_cgroup *mem_cgroup;
+	union {
+		struct mem_cgroup *mem_cgroup;
+		struct mem_cgroup_ptr **mem_cgroup_vec;
+	};
 #endif
 
 	/*
diff --git a/mm/slab.c b/mm/slab.c
index f1e1840af533..ffa16dd966ef 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -1370,7 +1370,8 @@ static struct page *kmem_getpages(struct kmem_cache *cachep, gfp_t flags,
 		return NULL;
 	}
 
-	if (charge_slab_page(page, flags, cachep->gfporder, cachep)) {
+	if (charge_slab_page(page, flags, cachep->gfporder, cachep,
+			     cachep->num)) {
 		__free_pages(page, cachep->gfporder);
 		return NULL;
 	}
diff --git a/mm/slab.h b/mm/slab.h
index 03833b02b9ae..8620a0a1d5fa 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -406,6 +406,23 @@ static __always_inline void memcg_uncharge_slab(struct page *page, int order,
 	percpu_ref_put_many(&s->memcg_params.refcnt, 1 << order);
 }
 
+static inline int memcg_alloc_page_memcg_vec(struct page *page, gfp_t gfp,
+					     unsigned int objects)
+{
+	page->mem_cgroup_vec = kmalloc(sizeof(struct mem_cgroup_ptr *) *
+				       objects, gfp | __GFP_ZERO);
+	if (!page->mem_cgroup_vec)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static inline void memcg_free_page_memcg_vec(struct page *page)
+{
+	kfree(page->mem_cgroup_vec);
+	page->mem_cgroup_vec = NULL;
+}
+
 extern void slab_init_memcg_params(struct kmem_cache *);
 extern void memcg_link_cache(struct kmem_cache *s, struct mem_cgroup *memcg);
 
@@ -455,6 +472,16 @@ static inline void memcg_uncharge_slab(struct page *page, int order,
 {
 }
 
+static inline int memcg_alloc_page_memcg_vec(struct page *page, gfp_t gfp,
+					     unsigned int objects)
+{
+	return 0;
+}
+
+static inline void memcg_free_page_memcg_vec(struct page *page)
+{
+}
+
 static inline void slab_init_memcg_params(struct kmem_cache *s)
 {
 }
@@ -479,14 +506,21 @@ static inline struct kmem_cache *virt_to_cache(const void *obj)
 
 static __always_inline int charge_slab_page(struct page *page,
 					    gfp_t gfp, int order,
-					    struct kmem_cache *s)
+					    struct kmem_cache *s,
+					    unsigned int objects)
 {
+	int ret;
+
 	if (is_root_cache(s)) {
 		mod_node_page_state(page_pgdat(page), cache_vmstat_idx(s),
 				    PAGE_SIZE << order);
 		return 0;
 	}
 
+	ret = memcg_alloc_page_memcg_vec(page, gfp, objects);
+	if (ret)
+		return ret;
+
 	return memcg_charge_slab(page, gfp, order, s);
 }
 
@@ -499,6 +533,7 @@ static __always_inline void uncharge_slab_page(struct page *page, int order,
 		return;
 	}
 
+	memcg_free_page_memcg_vec(page);
 	memcg_uncharge_slab(page, order, s);
 }
 
diff --git a/mm/slub.c b/mm/slub.c
index bd902d65a71c..e810582f5b86 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1518,7 +1518,7 @@ static inline struct page *alloc_slab_page(struct kmem_cache *s,
 	else
 		page = __alloc_pages_node(node, flags, order);
 
-	if (page && charge_slab_page(page, flags, order, s)) {
+	if (page && charge_slab_page(page, flags, order, s, oo_objects(oo))) {
 		__free_pages(page, order);
 		page = NULL;
 	}
-- 
2.21.0

