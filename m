Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA1B8CA9EC8
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 00:29:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A199C21D7D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 00:29:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Vu2NAFxP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503997AbfJRA31 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 20:29:27 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:43058 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2406870AbfJRA2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 20:28:41 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9I0OMlU002611
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 17:28:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=6szowz6ychF/Fx/Qii6u2VKsIWGHdQvAp2da21KVkNA=;
 b=Vu2NAFxPIbj7oF0+HnIkt2a0j8unjSH3WnCIr36L7hflUhcuAHPKxk7YvaDNERFHvolM
 jJKP6zq9H0BP2tATGSvasiSeHh5bi2CQFXlOuqkyhZ1ovslCkexIWZJBLrBRSzw189X3
 V8nz4XWQbcx/ox0vNwKg4SutROxUuZpKvYk= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2vq2nkr1pg-15
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 17:28:39 -0700
Received: from 2401:db00:30:600c:face:0:39:0 (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 17 Oct 2019 17:28:35 -0700
Received: by devvm2643.prn2.facebook.com (Postfix, from userid 111017)
        id 109B318CE8489; Thu, 17 Oct 2019 17:28:34 -0700 (PDT)
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
Subject: [PATCH 11/16] mm: memcg/slab: replace memcg_from_slab_page() with memcg_from_slab_obj()
Date:   Thu, 17 Oct 2019 17:28:15 -0700
Message-ID: <20191018002820.307763-12-guro@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191018002820.307763-1-guro@fb.com>
References: <20191018002820.307763-1-guro@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-17_07:2019-10-17,2019-10-17 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=834
 spamscore=0 clxscore=1015 suspectscore=1 bulkscore=0 impostorscore=0
 mlxscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910180001
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On our way to share slab pages between multiple memory cgroups
let's make sure we don't use kmem_cache.memcg_params.memcg
pointer to determine memcg ownership of a slab object/page.

Let's transform memcg_from_slab_page() into memcg_from_slab_obj(),
which relies on memcg ownership data stored in page->mem_cgroup_vec.

Delete mem_cgroup_from_kmem() and use memcg_from_slab_obj()
instead.

Note: memcg_from_slab_obj() returns NULL if slab obj belongs
to the root cgroup, so remove the redundant check in
__mod_lruvec_slab_state().

Signed-off-by: Roman Gushchin <guro@fb.com>
---
 mm/list_lru.c   | 12 +-----------
 mm/memcontrol.c |  9 ++++-----
 mm/slab.h       | 21 +++++++++++++--------
 3 files changed, 18 insertions(+), 24 deletions(-)

diff --git a/mm/list_lru.c b/mm/list_lru.c
index 0f1f6b06b7f3..4f9d791b802c 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -57,16 +57,6 @@ list_lru_from_memcg_idx(struct list_lru_node *nlru, int idx)
 	return &nlru->lru;
 }
 
-static __always_inline struct mem_cgroup *mem_cgroup_from_kmem(void *ptr)
-{
-	struct page *page;
-
-	if (!memcg_kmem_enabled())
-		return NULL;
-	page = virt_to_head_page(ptr);
-	return memcg_from_slab_page(page);
-}
-
 static inline struct list_lru_one *
 list_lru_from_kmem(struct list_lru_node *nlru, void *ptr,
 		   struct mem_cgroup **memcg_ptr)
@@ -77,7 +67,7 @@ list_lru_from_kmem(struct list_lru_node *nlru, void *ptr,
 	if (!nlru->memcg_lrus)
 		goto out;
 
-	memcg = mem_cgroup_from_kmem(ptr);
+	memcg = memcg_from_slab_obj(ptr);
 	if (!memcg)
 		goto out;
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 8a753a336efd..1982b14d6e6f 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -548,7 +548,7 @@ ino_t page_cgroup_ino(struct page *page)
 
 	rcu_read_lock();
 	if (PageHead(page) && PageSlab(page))
-		memcg = memcg_from_slab_page(page);
+		memcg = root_mem_cgroup;
 	else
 		memcg = READ_ONCE(page->mem_cgroup);
 	while (memcg && !(memcg->css.flags & CSS_ONLINE))
@@ -852,16 +852,15 @@ void __mod_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
 
 void __mod_lruvec_slab_state(void *p, enum node_stat_item idx, int val)
 {
-	struct page *page = virt_to_head_page(p);
-	pg_data_t *pgdat = page_pgdat(page);
+	pg_data_t *pgdat = page_pgdat(virt_to_page(p));
 	struct mem_cgroup *memcg;
 	struct lruvec *lruvec;
 
 	rcu_read_lock();
-	memcg = memcg_from_slab_page(page);
+	memcg = memcg_from_slab_obj(p);
 
 	/* Untracked pages have no memcg, no lruvec. Update only the node */
-	if (!memcg || memcg == root_mem_cgroup) {
+	if (!memcg) {
 		__mod_node_page_state(pgdat, idx, val);
 	} else {
 		lruvec = mem_cgroup_lruvec(pgdat, memcg);
diff --git a/mm/slab.h b/mm/slab.h
index 0f2f712de77a..a6330065d434 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -329,15 +329,20 @@ static inline struct kmem_cache *memcg_root_cache(struct kmem_cache *s)
  * The kmem_cache can be reparented asynchronously. The caller must ensure
  * the memcg lifetime, e.g. by taking rcu_read_lock() or cgroup_mutex.
  */
-static inline struct mem_cgroup *memcg_from_slab_page(struct page *page)
+static inline struct mem_cgroup *memcg_from_slab_obj(void *ptr)
 {
-	struct kmem_cache *s;
-
-	s = READ_ONCE(page->slab_cache);
-	if (s && !is_root_cache(s))
-		return READ_ONCE(s->memcg_params.memcg);
+	struct mem_cgroup_ptr *memcg_ptr;
+	struct page *page;
+	unsigned int off;
 
-	return NULL;
+	if (!memcg_kmem_enabled())
+		return NULL;
+	page = virt_to_head_page(ptr);
+	if (is_root_cache(page->slab_cache))
+		return NULL;
+	off = obj_to_index(page->slab_cache, page, ptr);
+	memcg_ptr = page->mem_cgroup_vec[off];
+	return memcg_ptr->memcg;
 }
 
 static inline int memcg_alloc_page_memcg_vec(struct page *page, gfp_t gfp,
@@ -464,7 +469,7 @@ static inline struct kmem_cache *memcg_root_cache(struct kmem_cache *s)
 	return s;
 }
 
-static inline struct mem_cgroup *memcg_from_slab_page(struct page *page)
+static inline struct mem_cgroup *memcg_from_slab_obj(void *ptr)
 {
 	return NULL;
 }
-- 
2.21.0

