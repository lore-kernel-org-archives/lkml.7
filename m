Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1724C282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 17:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A00FB2072E
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 17:28:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="NjmPSEkf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388195AbgAIR2h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 12:28:37 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:56640 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388171AbgAIR2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 12:28:32 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 009HQZv9015920
        for <linux-kernel@vger.kernel.org>; Thu, 9 Jan 2020 09:28:31 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=u+bk8fjLooFbLHtHLfRzd36o43vhzmvIRuWvBet/Xsk=;
 b=NjmPSEkfiyUowdnK0Lp8hPNt8BmDkOh7i/Dgc0g4Tj6VyDjqf61V7D9bJ0zrcuOfxPsg
 raiNhsdPg75lEnZgUMkLHhH1C7PaLNLosj/rP5pvCa0+CRvYn+VHv/R3jv0dCARd0sQf
 bEKNy2B2XcZggfo57MaG2coIQ+Cc9XwshsY= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2xdtwdbwdb-15
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 09:28:31 -0800
Received: from intmgw002.06.prn3.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Thu, 9 Jan 2020 09:28:21 -0800
Received: by devvm2643.prn2.facebook.com (Postfix, from userid 111017)
        id 8E79C1D2DC5E2; Thu,  9 Jan 2020 09:28:18 -0800 (PST)
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
Subject: [PATCH 7/7] mm: kmem: rename (__)memcg_kmem_(un)charge_memcg() to __memcg_kmem_(un)charge()
Date:   Thu, 9 Jan 2020 09:27:45 -0800
Message-ID: <20200109172745.285585-8-guro@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200109172745.285585-1-guro@fb.com>
References: <20200109172745.285585-1-guro@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-09_03:2020-01-09,2020-01-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 bulkscore=0 adultscore=0
 impostorscore=0 clxscore=1015 malwarescore=0 priorityscore=1501
 mlxlogscore=982 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-2001090143
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the _memcg suffix from (__)memcg_kmem_(un)charge functions.
It's shorter and more obvious.

These are the most basic functions which are just (un)charging the
given cgroup with the given amount of pages.

Also fix up the corresponding comments.

Signed-off-by: Roman Gushchin <guro@fb.com>
---
 include/linux/memcontrol.h | 19 +++++++++---------
 mm/memcontrol.c            | 40 +++++++++++++++++++-------------------
 mm/slab.h                  |  4 ++--
 3 files changed, 31 insertions(+), 32 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index e4d0939213b8..5fbe3d91722f 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1362,12 +1362,11 @@ struct kmem_cache *memcg_kmem_get_cache(struct kmem_cache *cachep);
 void memcg_kmem_put_cache(struct kmem_cache *cachep);
 
 #ifdef CONFIG_MEMCG_KMEM
+int __memcg_kmem_charge(struct mem_cgroup *memcg, gfp_t gfp,
+			unsigned int nr_pages);
+void __memcg_kmem_uncharge(struct mem_cgroup *memcg, unsigned int nr_pages);
 int __memcg_kmem_charge_page(struct page *page, gfp_t gfp, int order);
 void __memcg_kmem_uncharge_page(struct page *page, int order);
-int __memcg_kmem_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp,
-			      unsigned int nr_pages);
-void __memcg_kmem_uncharge_memcg(struct mem_cgroup *memcg,
-				 unsigned int nr_pages);
 
 extern struct static_key_false memcg_kmem_enabled_key;
 extern struct workqueue_struct *memcg_kmem_cache_wq;
@@ -1403,19 +1402,19 @@ static inline void memcg_kmem_uncharge_page(struct page *page, int order)
 		__memcg_kmem_uncharge_page(page, order);
 }
 
-static inline int memcg_kmem_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp,
-					  unsigned int nr_pages)
+static inline int memcg_kmem_charge(struct mem_cgroup *memcg, gfp_t gfp,
+				    unsigned int nr_pages)
 {
 	if (memcg_kmem_enabled())
-		return __memcg_kmem_charge_memcg(memcg, gfp, nr_pages);
+		return __memcg_kmem_charge(memcg, gfp, nr_pages);
 	return 0;
 }
 
-static inline void memcg_kmem_uncharge_memcg(struct mem_cgroup *memcg,
-					     unsigned int nr_pages)
+static inline void memcg_kmem_uncharge(struct mem_cgroup *memcg,
+				       unsigned int nr_pages)
 {
 	if (memcg_kmem_enabled())
-		__memcg_kmem_uncharge_memcg(memcg, nr_pages);
+		__memcg_kmem_uncharge(memcg, nr_pages);
 }
 
 /*
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 8dbfb9fed9d8..8bcd231e6e7b 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2819,15 +2819,15 @@ void memcg_kmem_put_cache(struct kmem_cache *cachep)
 }
 
 /**
- * __memcg_kmem_charge_memcg: charge a kmem page
+ * __memcg_kmem_charge: charge a number of kernel pages to a memcg
  * @memcg: memory cgroup to charge
  * @gfp: reclaim mode
  * @nr_pages: number of pages to charge
  *
  * Returns 0 on success, an error code on failure.
  */
-int __memcg_kmem_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp,
-			      unsigned int nr_pages)
+int __memcg_kmem_charge(struct mem_cgroup *memcg, gfp_t gfp,
+			unsigned int nr_pages)
 {
 	struct page_counter *counter;
 	int ret;
@@ -2854,6 +2854,21 @@ int __memcg_kmem_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp,
 	return 0;
 }
 
+/**
+ * __memcg_kmem_uncharge: uncharge a number of kernel pages from a memcg
+ * @memcg: memcg to uncharge
+ * @nr_pages: number of pages to uncharge
+ */
+void __memcg_kmem_uncharge(struct mem_cgroup *memcg, unsigned int nr_pages)
+{
+	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
+		page_counter_uncharge(&memcg->kmem, nr_pages);
+
+	page_counter_uncharge(&memcg->memory, nr_pages);
+	if (do_memsw_account())
+		page_counter_uncharge(&memcg->memsw, nr_pages);
+}
+
 /**
  * __memcg_kmem_charge_page: charge a kmem page to the current memory cgroup
  * @page: page to charge
@@ -2872,7 +2887,7 @@ int __memcg_kmem_charge_page(struct page *page, gfp_t gfp, int order)
 
 	memcg = get_mem_cgroup_from_current();
 	if (!mem_cgroup_is_root(memcg)) {
-		ret = __memcg_kmem_charge_memcg(memcg, gfp, 1 << order);
+		ret = __memcg_kmem_charge(memcg, gfp, 1 << order);
 		if (!ret) {
 			page->mem_cgroup = memcg;
 			__SetPageKmemcg(page);
@@ -2882,21 +2897,6 @@ int __memcg_kmem_charge_page(struct page *page, gfp_t gfp, int order)
 	return ret;
 }
 
-/**
- * __memcg_kmem_uncharge_memcg: uncharge a kmem page
- * @memcg: memcg to uncharge
- * @nr_pages: number of pages to uncharge
- */
-void __memcg_kmem_uncharge_memcg(struct mem_cgroup *memcg,
-				 unsigned int nr_pages)
-{
-	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
-		page_counter_uncharge(&memcg->kmem, nr_pages);
-
-	page_counter_uncharge(&memcg->memory, nr_pages);
-	if (do_memsw_account())
-		page_counter_uncharge(&memcg->memsw, nr_pages);
-}
 /**
  * __memcg_kmem_uncharge_page: uncharge a kmem page
  * @page: page to uncharge
@@ -2911,7 +2911,7 @@ void __memcg_kmem_uncharge_page(struct page *page, int order)
 		return;
 
 	VM_BUG_ON_PAGE(mem_cgroup_is_root(memcg), page);
-	__memcg_kmem_uncharge_memcg(memcg, nr_pages);
+	__memcg_kmem_uncharge(memcg, nr_pages);
 	page->mem_cgroup = NULL;
 
 	/* slab pages do not have PageKmemcg flag set */
diff --git a/mm/slab.h b/mm/slab.h
index 43f8ce4aa325..207c83ef6e06 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -366,7 +366,7 @@ static __always_inline int memcg_charge_slab(struct page *page,
 		return 0;
 	}
 
-	ret = memcg_kmem_charge_memcg(memcg, gfp, nr_pages);
+	ret = memcg_kmem_charge(memcg, gfp, nr_pages);
 	if (ret)
 		goto out;
 
@@ -397,7 +397,7 @@ static __always_inline void memcg_uncharge_slab(struct page *page, int order,
 	if (likely(!mem_cgroup_is_root(memcg))) {
 		lruvec = mem_cgroup_lruvec(memcg, page_pgdat(page));
 		mod_lruvec_state(lruvec, cache_vmstat_idx(s), -nr_pages);
-		memcg_kmem_uncharge_memcg(memcg, nr_pages);
+		memcg_kmem_uncharge(memcg, nr_pages);
 	} else {
 		mod_node_page_state(page_pgdat(page), cache_vmstat_idx(s),
 				    -nr_pages);
-- 
2.21.1

