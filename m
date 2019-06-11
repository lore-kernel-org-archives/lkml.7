Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E239C31E46
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 23:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC47720872
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 23:18:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="A657KbJo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408015AbfFKXSa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 19:18:30 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:32840 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2407982AbfFKXSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 19:18:25 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5BN8de5015010
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 16:18:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=Xx5Luiw4ossPD+e7sUfpgznJxtqNhDquLK7q4vM5gv8=;
 b=A657KbJouvq/Ev7aTKFK7x7621+5wRCN625mZI/d0duLQMf3Y0bLvGhFDQTyvbDjFDij
 I0L3vq6qbr2k/DGA8SpeLWInH4njDu4xksjnSt/AlX68oOG+nGwkwtx9ZsNp/0jmB2YT
 ftJFna0Bi2j88VEk1lI8RiIdyVr5ebgANFU= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2t2keaggcx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 16:18:23 -0700
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::127) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Tue, 11 Jun 2019 16:18:21 -0700
Received: by devvm2643.prn2.facebook.com (Postfix, from userid 111017)
        id 42C22130CBF73; Tue, 11 Jun 2019 16:18:20 -0700 (PDT)
Smtp-Origin-Hostprefix: devvm
From:   Roman Gushchin <guro@fb.com>
Smtp-Origin-Hostname: devvm2643.prn2.facebook.com
To:     Andrew Morton <akpm@linux-foundation.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Waiman Long <longman@redhat.com>, Roman Gushchin <guro@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH v7 07/10] mm: synchronize access to kmem_cache dying flag using a spinlock
Date:   Tue, 11 Jun 2019 16:18:10 -0700
Message-ID: <20190611231813.3148843-8-guro@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190611231813.3148843-1-guro@fb.com>
References: <20190611231813.3148843-1-guro@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-11_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=737 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906110151
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
 mm/slab_common.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index 9383104651cd..1e5eaf84bf08 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -130,6 +130,7 @@ int __kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t nr,
 #ifdef CONFIG_MEMCG_KMEM
 
 LIST_HEAD(slab_root_caches);
+static DEFINE_SPINLOCK(memcg_kmem_wq_lock);
 
 void slab_init_memcg_params(struct kmem_cache *s)
 {
@@ -734,14 +735,22 @@ static void kmemcg_cache_deactivate(struct kmem_cache *s)
 
 	__kmemcg_cache_deactivate(s);
 
+	/*
+	 * memcg_kmem_wq_lock is used to synchronize memcg_params.dying
+	 * flag and make sure that no new kmem_cache deactivation tasks
+	 * are queued (see flush_memcg_workqueue() ).
+	 */
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
@@ -851,9 +860,9 @@ static int shutdown_memcg_caches(struct kmem_cache *s)
 
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
2.21.0

