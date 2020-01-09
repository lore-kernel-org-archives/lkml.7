Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B415DC282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 20:27:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D1B320848
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 20:27:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="oQcoUK4L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730302AbgAIU1T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 15:27:19 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:10230 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728661AbgAIU1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 15:27:18 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 009KPGwB015318
        for <linux-kernel@vger.kernel.org>; Thu, 9 Jan 2020 12:27:17 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=E3d8gHLBDOSZn6famP4DibpAMVOOAGc7zyC42ywswbo=;
 b=oQcoUK4Ly7LT5TLEgQfJAjZDRAaTvEK03YUoM01i0yYD7J2sY46luo8bcx4D5MU9Ese5
 piuvNNSqtLuwcxcH2l1Z5SU9ZFesaiF+m/dg97surcZtVVwIDMAe6SgVwNYINVQvuZn4
 AZwZGfNDYRnl+yxIJZ0WgRXvj11zmXr/VLw= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2xdrj8nhkm-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 12:27:17 -0800
Received: from intmgw002.06.prn3.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Thu, 9 Jan 2020 12:27:16 -0800
Received: by devvm2643.prn2.facebook.com (Postfix, from userid 111017)
        id 2DD091D2F0DC8; Thu,  9 Jan 2020 12:27:07 -0800 (PST)
Smtp-Origin-Hostprefix: devvm
From:   Roman Gushchin <guro@fb.com>
Smtp-Origin-Hostname: devvm2643.prn2.facebook.com
To:     <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>
CC:     Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Roman Gushchin <guro@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH v2 3/6] mm: kmem: rename memcg_kmem_(un)charge() into memcg_kmem_(un)charge_page()
Date:   Thu, 9 Jan 2020 12:26:56 -0800
Message-ID: <20200109202659.752357-4-guro@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200109202659.752357-1-guro@fb.com>
References: <20200109202659.752357-1-guro@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-09_04:2020-01-09,2020-01-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=2
 adultscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0
 clxscore=1015 mlxscore=0 mlxlogscore=999 priorityscore=1501 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001090168
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename (__)memcg_kmem_(un)charge() into (__)memcg_kmem_(un)charge_page()
to better reflect what they are actually doing:
1) call __memcg_kmem_(un)charge_memcg() to actually charge or
uncharge the current memcg
2) set or clear the PageKmemcg flag

Signed-off-by: Roman Gushchin <guro@fb.com>
---
 fs/pipe.c                  |  2 +-
 include/linux/memcontrol.h | 23 +++++++++++++----------
 kernel/fork.c              |  9 +++++----
 mm/memcontrol.c            |  8 ++++----
 mm/page_alloc.c            |  4 ++--
 5 files changed, 25 insertions(+), 21 deletions(-)

diff --git a/fs/pipe.c b/fs/pipe.c
index 57502c3c0fba..f1851f7ecbd6 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -143,7 +143,7 @@ static int anon_pipe_buf_steal(struct pipe_inode_info *pipe,
 	struct page *page = buf->page;
 
 	if (page_count(page) == 1) {
-		memcg_kmem_uncharge(page, 0);
+		memcg_kmem_uncharge_page(page, 0);
 		__SetPageLocked(page);
 		return 0;
 	}
diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 900a9f884260..4ee0c345e905 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1362,8 +1362,8 @@ struct kmem_cache *memcg_kmem_get_cache(struct kmem_cache *cachep);
 void memcg_kmem_put_cache(struct kmem_cache *cachep);
 
 #ifdef CONFIG_MEMCG_KMEM
-int __memcg_kmem_charge(struct page *page, gfp_t gfp, int order);
-void __memcg_kmem_uncharge(struct page *page, int order);
+int __memcg_kmem_charge_page(struct page *page, gfp_t gfp, int order);
+void __memcg_kmem_uncharge_page(struct page *page, int order);
 int __memcg_kmem_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp, int order);
 void __memcg_kmem_uncharge_memcg(struct mem_cgroup *memcg,
 				 unsigned int nr_pages);
@@ -1388,17 +1388,18 @@ static inline bool memcg_kmem_enabled(void)
 	return static_branch_unlikely(&memcg_kmem_enabled_key);
 }
 
-static inline int memcg_kmem_charge(struct page *page, gfp_t gfp, int order)
+static inline int memcg_kmem_charge_page(struct page *page, gfp_t gfp,
+					 int order)
 {
 	if (memcg_kmem_enabled())
-		return __memcg_kmem_charge(page, gfp, order);
+		return __memcg_kmem_charge_page(page, gfp, order);
 	return 0;
 }
 
-static inline void memcg_kmem_uncharge(struct page *page, int order)
+static inline void memcg_kmem_uncharge_page(struct page *page, int order)
 {
 	if (memcg_kmem_enabled())
-		__memcg_kmem_uncharge(page, order);
+		__memcg_kmem_uncharge_page(page, order);
 }
 
 static inline int memcg_kmem_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp,
@@ -1428,21 +1429,23 @@ static inline int memcg_cache_id(struct mem_cgroup *memcg)
 
 #else
 
-static inline int memcg_kmem_charge(struct page *page, gfp_t gfp, int order)
+static inline int memcg_kmem_charge_page(struct page *page, gfp_t gfp,
+					 int order)
 {
 	return 0;
 }
 
-static inline void memcg_kmem_uncharge(struct page *page, int order)
+static inline void memcg_kmem_uncharge_page(struct page *page, int order)
 {
 }
 
-static inline int __memcg_kmem_charge(struct page *page, gfp_t gfp, int order)
+static inline int __memcg_kmem_charge_page(struct page *page, gfp_t gfp,
+					   int order)
 {
 	return 0;
 }
 
-static inline void __memcg_kmem_uncharge(struct page *page, int order)
+static inline void __memcg_kmem_uncharge_page(struct page *page, int order)
 {
 }
 
diff --git a/kernel/fork.c b/kernel/fork.c
index 2508a4f238a3..6e410a189683 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -281,7 +281,7 @@ static inline void free_thread_stack(struct task_struct *tsk)
 					     MEMCG_KERNEL_STACK_KB,
 					     -(int)(PAGE_SIZE / 1024));
 
-			memcg_kmem_uncharge(vm->pages[i], 0);
+			memcg_kmem_uncharge_page(vm->pages[i], 0);
 		}
 
 		for (i = 0; i < NR_CACHED_STACKS; i++) {
@@ -413,12 +413,13 @@ static int memcg_charge_kernel_stack(struct task_struct *tsk)
 
 		for (i = 0; i < THREAD_SIZE / PAGE_SIZE; i++) {
 			/*
-			 * If memcg_kmem_charge() fails, page->mem_cgroup
-			 * pointer is NULL, and both memcg_kmem_uncharge()
+			 * If memcg_kmem_charge_page() fails, page->mem_cgroup
+			 * pointer is NULL, and both memcg_kmem_uncharge_page()
 			 * and mod_memcg_page_state() in free_thread_stack()
 			 * will ignore this page. So it's safe.
 			 */
-			ret = memcg_kmem_charge(vm->pages[i], GFP_KERNEL, 0);
+			ret = memcg_kmem_charge_page(vm->pages[i], GFP_KERNEL,
+						     0);
 			if (ret)
 				return ret;
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 6ef38f669923..6bdf040e4615 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2855,14 +2855,14 @@ int __memcg_kmem_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp, int order)
 }
 
 /**
- * __memcg_kmem_charge: charge a kmem page to the current memory cgroup
+ * __memcg_kmem_charge_page: charge a kmem page to the current memory cgroup
  * @page: page to charge
  * @gfp: reclaim mode
  * @order: allocation order
  *
  * Returns 0 on success, an error code on failure.
  */
-int __memcg_kmem_charge(struct page *page, gfp_t gfp, int order)
+int __memcg_kmem_charge_page(struct page *page, gfp_t gfp, int order)
 {
 	struct mem_cgroup *memcg;
 	int ret = 0;
@@ -2898,11 +2898,11 @@ void __memcg_kmem_uncharge_memcg(struct mem_cgroup *memcg,
 		page_counter_uncharge(&memcg->memsw, nr_pages);
 }
 /**
- * __memcg_kmem_uncharge: uncharge a kmem page
+ * __memcg_kmem_uncharge_page: uncharge a kmem page
  * @page: page to uncharge
  * @order: allocation order
  */
-void __memcg_kmem_uncharge(struct page *page, int order)
+void __memcg_kmem_uncharge_page(struct page *page, int order)
 {
 	struct mem_cgroup *memcg = page->mem_cgroup;
 	unsigned int nr_pages = 1 << order;
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 4785a8a2040e..8fca5b806139 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1159,7 +1159,7 @@ static __always_inline bool free_pages_prepare(struct page *page,
 	if (PageMappingFlags(page))
 		page->mapping = NULL;
 	if (memcg_kmem_enabled() && PageKmemcg(page))
-		__memcg_kmem_uncharge(page, order);
+		__memcg_kmem_uncharge_page(page, order);
 	if (check_free)
 		bad += free_pages_check(page);
 	if (bad)
@@ -4777,7 +4777,7 @@ __alloc_pages_nodemask(gfp_t gfp_mask, unsigned int order, int preferred_nid,
 
 out:
 	if (memcg_kmem_enabled() && (gfp_mask & __GFP_ACCOUNT) && page &&
-	    unlikely(__memcg_kmem_charge(page, gfp_mask, order) != 0)) {
+	    unlikely(__memcg_kmem_charge_page(page, gfp_mask, order) != 0)) {
 		__free_pages(page, order);
 		page = NULL;
 	}
-- 
2.21.1

