Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E77C5C28CC3
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 02:45:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD69B20851
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 02:45:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="N1ORyrtC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbfFECpC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 22:45:02 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:52266 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726293AbfFECpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 22:45:01 -0400
Received: from pps.filterd (m0044008.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x552iAeu001296
        for <linux-kernel@vger.kernel.org>; Tue, 4 Jun 2019 19:45:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=RAtQP8kdt+P/ff/UupI77hj0Bc++zM2YWzYBwAXPM6o=;
 b=N1ORyrtCMpqM8ArTqyLILrOwr/rNYmMHMW9zOhG/NRyrlupsDadIRbH+Gt2zpNdLeTHX
 6UchQ5coq6wyjYdFSjdBnNAWvDe9iDo/95rKavvBdoQXJ/GeLh+EHLugjQxPcLLLU5BB
 wHHKtT2bs17nxlMXfdM9vV2V0bZEmZnb0uA= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2swq1tjy3n-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 19:45:00 -0700
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Tue, 4 Jun 2019 19:44:59 -0700
Received: by devvm2643.prn2.facebook.com (Postfix, from userid 111017)
        id 8FE2012C7FDCE; Tue,  4 Jun 2019 19:44:58 -0700 (PDT)
Smtp-Origin-Hostprefix: devvm
From:   Roman Gushchin <guro@fb.com>
Smtp-Origin-Hostname: devvm2643.prn2.facebook.com
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Waiman Long <longman@redhat.com>, Roman Gushchin <guro@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH v6 07/10] mm: synchronize access to kmem_cache dying flag using a spinlock
Date:   Tue, 4 Jun 2019 19:44:51 -0700
Message-ID: <20190605024454.1393507-8-guro@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190605024454.1393507-1-guro@fb.com>
References: <20190605024454.1393507-1-guro@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-05_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=758 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906050015
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the memcg_params.dying flag and the corresponding
workqueue used for the asynchronous deactivation of kmem_caches
is synchronized using the slab_mutex.

It makes impossible to check this flag from the irq context,
which will be required in order to implement asynchronous release
of kmem_caches.

So let's switch over to the irq-save flavor of the spinlock-based
synchronization.

Signed-off-by: Roman Gushchin <guro@fb.com>
---
 mm/slab_common.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index 09b26673b63f..2914a8f0aa85 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -130,6 +130,7 @@ int __kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t nr,
 #ifdef CONFIG_MEMCG_KMEM
 
 LIST_HEAD(slab_root_caches);
+static DEFINE_SPINLOCK(memcg_kmem_wq_lock);
 
 void slab_init_memcg_params(struct kmem_cache *s)
 {
@@ -629,6 +630,7 @@ void memcg_create_kmem_cache(struct mem_cgroup *memcg,
 	struct memcg_cache_array *arr;
 	struct kmem_cache *s = NULL;
 	char *cache_name;
+	bool dying;
 	int idx;
 
 	get_online_cpus();
@@ -640,7 +642,13 @@ void memcg_create_kmem_cache(struct mem_cgroup *memcg,
 	 * The memory cgroup could have been offlined while the cache
 	 * creation work was pending.
 	 */
-	if (memcg->kmem_state != KMEM_ONLINE || root_cache->memcg_params.dying)
+	if (memcg->kmem_state != KMEM_ONLINE)
+		goto out_unlock;
+
+	spin_lock_irq(&memcg_kmem_wq_lock);
+	dying = root_cache->memcg_params.dying;
+	spin_unlock_irq(&memcg_kmem_wq_lock);
+	if (dying)
 		goto out_unlock;
 
 	idx = memcg_cache_id(memcg);
@@ -735,14 +743,17 @@ static void kmemcg_cache_deactivate(struct kmem_cache *s)
 
 	__kmemcg_cache_deactivate(s);
 
+	spin_lock_irq(&memcg_kmem_wq_lock);
 	if (s->memcg_params.root_cache->memcg_params.dying)
-		return;
+		goto unlock;
 
 	/* pin memcg so that @s doesn't get destroyed in the middle */
 	css_get(&s->memcg_params.memcg->css);
 
 	s->memcg_params.work_fn = __kmemcg_cache_deactivate_after_rcu;
 	call_rcu(&s->memcg_params.rcu_head, kmemcg_rcufn);
+unlock:
+	spin_unlock_irq(&memcg_kmem_wq_lock);
 }
 
 void memcg_deactivate_kmem_caches(struct mem_cgroup *memcg)
@@ -852,9 +863,9 @@ static int shutdown_memcg_caches(struct kmem_cache *s)
 
 static void flush_memcg_workqueue(struct kmem_cache *s)
 {
-	mutex_lock(&slab_mutex);
+	spin_lock_irq(&memcg_kmem_wq_lock);
 	s->memcg_params.dying = true;
-	mutex_unlock(&slab_mutex);
+	spin_unlock_irq(&memcg_kmem_wq_lock);
 
 	/*
 	 * SLAB and SLUB deactivate the kmem_caches through call_rcu. Make
-- 
2.20.1

