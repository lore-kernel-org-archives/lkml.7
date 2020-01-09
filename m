Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FADFC33CA2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 20:27:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BB7F2077B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 20:27:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="IeZFx/du"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730198AbgAIU1P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 15:27:15 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:40304 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729843AbgAIU1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 15:27:15 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 009KPiWd008536
        for <linux-kernel@vger.kernel.org>; Thu, 9 Jan 2020 12:27:14 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=76aRhjElR+gZ+ApttC1k6ZUCNvpq/fbF3U0y6i6zjZ4=;
 b=IeZFx/duzytEjtLEIsdDimPg4vx679u6g8THe1l6uK4duo/x/aIC9adBcB36tRW8OaA/
 WR2u/voj0T3mmb4V7bBHZQ9pigvrUtN5k7Ei/l0S+w6Eu0SXgA+Z9VLeqIsF2HTVv6Xc
 qX+iG4UapvB4/RCfg5eQsMPb9iqYHADWLAo= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2xe2exu212-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 12:27:14 -0800
Received: from intmgw004.06.prn3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 9 Jan 2020 12:27:13 -0800
Received: by devvm2643.prn2.facebook.com (Postfix, from userid 111017)
        id 278901D2F0DC4; Thu,  9 Jan 2020 12:27:07 -0800 (PST)
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
Subject: [PATCH v2 1/6] mm: kmem: cleanup (__)memcg_kmem_charge_memcg() arguments
Date:   Thu, 9 Jan 2020 12:26:54 -0800
Message-ID: <20200109202659.752357-2-guro@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200109202659.752357-1-guro@fb.com>
References: <20200109202659.752357-1-guro@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-09_04:2020-01-09,2020-01-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 impostorscore=0 spamscore=0 suspectscore=0 malwarescore=0
 priorityscore=1501 mlxlogscore=999 mlxscore=0 clxscore=1015 adultscore=0
 bulkscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-2001090168
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first argument of memcg_kmem_charge_memcg() and
__memcg_kmem_charge_memcg() is the page pointer and it's not used.
Let's drop it.

Memcg pointer is passed as the last argument. Move it to
the first place for consistency with other memcg functions,
e.g. __memcg_kmem_uncharge_memcg() or try_charge().

Signed-off-by: Roman Gushchin <guro@fb.com>
---
 include/linux/memcontrol.h | 9 ++++-----
 mm/memcontrol.c            | 8 +++-----
 mm/slab.h                  | 2 +-
 3 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index a7a0a1a5c8d5..c954209fd685 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1364,8 +1364,7 @@ void memcg_kmem_put_cache(struct kmem_cache *cachep);
 #ifdef CONFIG_MEMCG_KMEM
 int __memcg_kmem_charge(struct page *page, gfp_t gfp, int order);
 void __memcg_kmem_uncharge(struct page *page, int order);
-int __memcg_kmem_charge_memcg(struct page *page, gfp_t gfp, int order,
-			      struct mem_cgroup *memcg);
+int __memcg_kmem_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp, int order);
 void __memcg_kmem_uncharge_memcg(struct mem_cgroup *memcg,
 				 unsigned int nr_pages);
 
@@ -1402,11 +1401,11 @@ static inline void memcg_kmem_uncharge(struct page *page, int order)
 		__memcg_kmem_uncharge(page, order);
 }
 
-static inline int memcg_kmem_charge_memcg(struct page *page, gfp_t gfp,
-					  int order, struct mem_cgroup *memcg)
+static inline int memcg_kmem_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp,
+					  int order)
 {
 	if (memcg_kmem_enabled())
-		return __memcg_kmem_charge_memcg(page, gfp, order, memcg);
+		return __memcg_kmem_charge_memcg(memcg, gfp, order);
 	return 0;
 }
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index c5b5f74cfd4d..6ef38f669923 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2820,15 +2820,13 @@ void memcg_kmem_put_cache(struct kmem_cache *cachep)
 
 /**
  * __memcg_kmem_charge_memcg: charge a kmem page
- * @page: page to charge
+ * @memcg: memory cgroup to charge
  * @gfp: reclaim mode
  * @order: allocation order
- * @memcg: memory cgroup to charge
  *
  * Returns 0 on success, an error code on failure.
  */
-int __memcg_kmem_charge_memcg(struct page *page, gfp_t gfp, int order,
-			    struct mem_cgroup *memcg)
+int __memcg_kmem_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp, int order)
 {
 	unsigned int nr_pages = 1 << order;
 	struct page_counter *counter;
@@ -2874,7 +2872,7 @@ int __memcg_kmem_charge(struct page *page, gfp_t gfp, int order)
 
 	memcg = get_mem_cgroup_from_current();
 	if (!mem_cgroup_is_root(memcg)) {
-		ret = __memcg_kmem_charge_memcg(page, gfp, order, memcg);
+		ret = __memcg_kmem_charge_memcg(memcg, gfp, order);
 		if (!ret) {
 			page->mem_cgroup = memcg;
 			__SetPageKmemcg(page);
diff --git a/mm/slab.h b/mm/slab.h
index 7e94700aa78c..c4c93e991250 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -365,7 +365,7 @@ static __always_inline int memcg_charge_slab(struct page *page,
 		return 0;
 	}
 
-	ret = memcg_kmem_charge_memcg(page, gfp, order, memcg);
+	ret = memcg_kmem_charge_memcg(memcg, gfp, order);
 	if (ret)
 		goto out;
 
-- 
2.21.1

