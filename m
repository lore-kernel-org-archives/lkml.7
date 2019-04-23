Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B03F6C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 04:43:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A0AA218D2
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 04:43:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="UmOzXPgo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728915AbfDXEnO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 00:43:14 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:59682 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725919AbfDXEnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 00:43:13 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x3O4fwWw022123
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 21:43:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=cRmr36eXTaKgScK2fa3yPK15EeGvQLf0Lc+faeDoG3Q=;
 b=UmOzXPgoQyMb6775Oz2yU4LqMZg7j6hKF1EyxksST2XqEVT04qJqd9NI/yWg3n/yIqH/
 a5TMQXYG/BcjWC4uW47FfZCqbTOyhI3fFCgDBKNwLiJZUmz//uzvCGM79Jb8FC1VCzJi
 0YoFkJ587li2/ZqhKmpKSmSY/V+8v9wZ7Fw= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by m0001303.ppops.net with ESMTP id 2s28ke1ukx-18
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 21:43:12 -0700
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Tue, 23 Apr 2019 21:43:08 -0700
Received: by devvm2643.prn2.facebook.com (Postfix, from userid 111017)
        id C6D241142D2E4; Tue, 23 Apr 2019 14:31:36 -0700 (PDT)
Smtp-Origin-Hostprefix: devvm
From:   Roman Gushchin <guro@fb.com>
Smtp-Origin-Hostname: devvm2643.prn2.facebook.com
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Shakeel Butt <shakeelb@google.com>,
        Christoph Lameter <cl@linux.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        <cgroups@vger.kernel.org>, Roman Gushchin <guro@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH v2 3/6] mm: introduce __memcg_kmem_uncharge_memcg()
Date:   Tue, 23 Apr 2019 14:31:30 -0700
Message-ID: <20190423213133.3551969-4-guro@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190423213133.3551969-1-guro@fb.com>
References: <20190423213133.3551969-1-guro@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-24_02:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's separate the page counter modification code out of
__memcg_kmem_uncharge() in a way similar to what
__memcg_kmem_charge() and __memcg_kmem_charge_memcg() work.

This will allow to reuse this code later using a new
memcg_kmem_uncharge_memcg() wrapper, which calls
__memcg_kmem_unchare_memcg() if memcg_kmem_enabled()
check is passed.

Signed-off-by: Roman Gushchin <guro@fb.com>
---
 include/linux/memcontrol.h | 10 ++++++++++
 mm/memcontrol.c            | 25 +++++++++++++++++--------
 2 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 36bdfe8e5965..deb209510902 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1298,6 +1298,8 @@ int __memcg_kmem_charge(struct page *page, gfp_t gfp, int order);
 void __memcg_kmem_uncharge(struct page *page, int order);
 int __memcg_kmem_charge_memcg(struct page *page, gfp_t gfp, int order,
 			      struct mem_cgroup *memcg);
+void __memcg_kmem_uncharge_memcg(struct mem_cgroup *memcg,
+				 unsigned int nr_pages);
 
 extern struct static_key_false memcg_kmem_enabled_key;
 extern struct workqueue_struct *memcg_kmem_cache_wq;
@@ -1339,6 +1341,14 @@ static inline int memcg_kmem_charge_memcg(struct page *page, gfp_t gfp,
 		return __memcg_kmem_charge_memcg(page, gfp, order, memcg);
 	return 0;
 }
+
+static inline void memcg_kmem_uncharge_memcg(struct page *page, int order,
+					     struct mem_cgroup *memcg)
+{
+	if (memcg_kmem_enabled())
+		__memcg_kmem_uncharge_memcg(memcg, 1 << order);
+}
+
 /*
  * helper for accessing a memcg's index. It will be used as an index in the
  * child cache array in kmem_cache, and also to derive its name. This function
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 48a8f1c35176..b2c39f187cbb 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2750,6 +2750,22 @@ int __memcg_kmem_charge(struct page *page, gfp_t gfp, int order)
 	css_put(&memcg->css);
 	return ret;
 }
+
+/**
+ * __memcg_kmem_uncharge_memcg: uncharge a kmem page
+ * @memcg: memcg to uncharge
+ * @nr_pages: number of pages to uncharge
+ */
+void __memcg_kmem_uncharge_memcg(struct mem_cgroup *memcg,
+				 unsigned int nr_pages)
+{
+	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
+		page_counter_uncharge(&memcg->kmem, nr_pages);
+
+	page_counter_uncharge(&memcg->memory, nr_pages);
+	if (do_memsw_account())
+		page_counter_uncharge(&memcg->memsw, nr_pages);
+}
 /**
  * __memcg_kmem_uncharge: uncharge a kmem page
  * @page: page to uncharge
@@ -2764,14 +2780,7 @@ void __memcg_kmem_uncharge(struct page *page, int order)
 		return;
 
 	VM_BUG_ON_PAGE(mem_cgroup_is_root(memcg), page);
-
-	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
-		page_counter_uncharge(&memcg->kmem, nr_pages);
-
-	page_counter_uncharge(&memcg->memory, nr_pages);
-	if (do_memsw_account())
-		page_counter_uncharge(&memcg->memsw, nr_pages);
-
+	__memcg_kmem_uncharge_memcg(memcg, nr_pages);
 	page->mem_cgroup = NULL;
 
 	/* slab pages do not have PageKmemcg flag set */
-- 
2.20.1

