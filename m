Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E3D0C282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 17:28:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E39102072A
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 17:28:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="liS1tMvV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388137AbgAIR21 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 12:28:27 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:60204 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728444AbgAIR20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 12:28:26 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 009HPZbZ020211
        for <linux-kernel@vger.kernel.org>; Thu, 9 Jan 2020 09:28:25 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=Sky71T6ocPO8hx0rEsER0dZwwaqEusEZM0Nrks58OYc=;
 b=liS1tMvV2mnPMSRdyYmUp5WjKLlzl4FAdkX2TM5yfLnY1iR7LnMKmyWzjtFFNhD+iRIt
 GX4WExjUiVKgioI+r6CgnZByBCD8g5PnHrUhDX/zjnR6rGIirG3M5xhcy3QOTsDeabog
 SX/hUWl8tgaS0/fYYw7VVqYKGSzfjuBWHpw= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2xd5av2369-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 09:28:24 -0800
Received: from intmgw003.06.prn3.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::129) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Thu, 9 Jan 2020 09:28:23 -0800
Received: by devvm2643.prn2.facebook.com (Postfix, from userid 111017)
        id 89DA81D2DC5E0; Thu,  9 Jan 2020 09:28:18 -0800 (PST)
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
Subject: [PATCH 6/7] mm: memcg/slab: cache page number in memcg_(un)charge_slab()
Date:   Thu, 9 Jan 2020 09:27:44 -0800
Message-ID: <20200109172745.285585-7-guro@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200109172745.285585-1-guro@fb.com>
References: <20200109172745.285585-1-guro@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-09_03:2020-01-09,2020-01-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 phishscore=0 spamscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 bulkscore=0 mlxscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001090143
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are many places in memcg_charge_slab() and memcg_uncharge_slab()
which are calculating the number of pages to charge, css references to
grab etc depending on the order of the slab page.

Let's simplify the code by calculating it once and caching in the
local variable.

Signed-off-by: Roman Gushchin <guro@fb.com>
---
 mm/slab.h | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/mm/slab.h b/mm/slab.h
index d96c87a30a9b..43f8ce4aa325 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -348,6 +348,7 @@ static __always_inline int memcg_charge_slab(struct page *page,
 					     gfp_t gfp, int order,
 					     struct kmem_cache *s)
 {
+	unsigned int nr_pages = 1 << order;
 	struct mem_cgroup *memcg;
 	struct lruvec *lruvec;
 	int ret;
@@ -360,21 +361,21 @@ static __always_inline int memcg_charge_slab(struct page *page,
 
 	if (unlikely(!memcg || mem_cgroup_is_root(memcg))) {
 		mod_node_page_state(page_pgdat(page), cache_vmstat_idx(s),
-				    (1 << order));
-		percpu_ref_get_many(&s->memcg_params.refcnt, 1 << order);
+				    nr_pages);
+		percpu_ref_get_many(&s->memcg_params.refcnt, nr_pages);
 		return 0;
 	}
 
-	ret = memcg_kmem_charge_memcg(memcg, gfp, 1 << order);
+	ret = memcg_kmem_charge_memcg(memcg, gfp, nr_pages);
 	if (ret)
 		goto out;
 
 	lruvec = mem_cgroup_lruvec(memcg, page_pgdat(page));
-	mod_lruvec_state(lruvec, cache_vmstat_idx(s), 1 << order);
+	mod_lruvec_state(lruvec, cache_vmstat_idx(s), nr_pages);
 
 	/* transer try_charge() page references to kmem_cache */
-	percpu_ref_get_many(&s->memcg_params.refcnt, 1 << order);
-	css_put_many(&memcg->css, 1 << order);
+	percpu_ref_get_many(&s->memcg_params.refcnt, nr_pages);
+	css_put_many(&memcg->css, nr_pages);
 out:
 	css_put(&memcg->css);
 	return ret;
@@ -387,6 +388,7 @@ static __always_inline int memcg_charge_slab(struct page *page,
 static __always_inline void memcg_uncharge_slab(struct page *page, int order,
 						struct kmem_cache *s)
 {
+	unsigned int nr_pages = 1 << order;
 	struct mem_cgroup *memcg;
 	struct lruvec *lruvec;
 
@@ -394,15 +396,15 @@ static __always_inline void memcg_uncharge_slab(struct page *page, int order,
 	memcg = READ_ONCE(s->memcg_params.memcg);
 	if (likely(!mem_cgroup_is_root(memcg))) {
 		lruvec = mem_cgroup_lruvec(memcg, page_pgdat(page));
-		mod_lruvec_state(lruvec, cache_vmstat_idx(s), -(1 << order));
-		memcg_kmem_uncharge_memcg(memcg, order);
+		mod_lruvec_state(lruvec, cache_vmstat_idx(s), -nr_pages);
+		memcg_kmem_uncharge_memcg(memcg, nr_pages);
 	} else {
 		mod_node_page_state(page_pgdat(page), cache_vmstat_idx(s),
-				    -(1 << order));
+				    -nr_pages);
 	}
 	rcu_read_unlock();
 
-	percpu_ref_put_many(&s->memcg_params.refcnt, 1 << order);
+	percpu_ref_put_many(&s->memcg_params.refcnt, nr_pages);
 }
 
 extern void slab_init_memcg_params(struct kmem_cache *);
-- 
2.21.1

