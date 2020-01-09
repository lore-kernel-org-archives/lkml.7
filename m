Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0CD8C33CA2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 17:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ED3420721
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 17:28:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Jv5qYgpt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388168AbgAIR2b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 12:28:31 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:65534 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388146AbgAIR23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 12:28:29 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 009HPcIo020266
        for <linux-kernel@vger.kernel.org>; Thu, 9 Jan 2020 09:28:28 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=/vqFynn09q0Y5/TYt7qVEQJtKWuVxHnwi9uYAry9J+E=;
 b=Jv5qYgptT2fqBQXikOS5nlHQeZB47/FwuJU2qjfs1k1eP8rz/X46nZ6b98qy9DjMiRtK
 5pvmZdVbrsnxSOhbXWRitlI5KEPKWaJLAnhbSaNPSzPMXc/nmKpqbAaviFjhOE7s1MPZ
 R6/8Ot/S2iNB4T4eXOxWBDlutiA0P5hYRCM= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2xd5av236b-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 09:28:28 -0800
Received: from intmgw001.06.prn3.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Thu, 9 Jan 2020 09:28:23 -0800
Received: by devvm2643.prn2.facebook.com (Postfix, from userid 111017)
        id 794E01D2DC5D8; Thu,  9 Jan 2020 09:28:18 -0800 (PST)
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
Subject: [PATCH 2/7] mm: kmem: cleanup (__)memcg_kmem_charge_memcg() arguments
Date:   Thu, 9 Jan 2020 09:27:40 -0800
Message-ID: <20200109172745.285585-3-guro@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200109172745.285585-1-guro@fb.com>
References: <20200109172745.285585-1-guro@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-09_03:2020-01-09,2020-01-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=983
 phishscore=0 spamscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 bulkscore=0 mlxscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001090143
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
index 9745d172ba18..f1eb8e72a612 100644
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

