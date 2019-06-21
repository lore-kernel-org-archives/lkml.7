Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20428C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 17:30:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3A962075E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 17:30:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbfFURaf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 13:30:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42858 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725992AbfFURaf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 13:30:35 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2D41D308FC5F;
        Fri, 21 Jun 2019 17:30:29 +0000 (UTC)
Received: from llong.com (dhcp-17-85.bos.redhat.com [10.18.17.85])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DDD0519C68;
        Fri, 21 Jun 2019 17:30:22 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Michal Hocko <mhocko@kernel.org>, Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH-next] mm, memcg: Add ":deact" tag for reparented kmem caches in memcg_slabinfo
Date:   Fri, 21 Jun 2019 13:30:05 -0400
Message-Id: <20190621173005.31514-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Fri, 21 Jun 2019 17:30:34 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With Roman's kmem cache reparent patch, multiple kmem caches of the same
type can be seen attached to the same memcg id. All of them, except
maybe one, are reparent'ed kmem caches. It can be useful to tag those
reparented caches by adding a new slab flag "SLAB_DEACTIVATED" to those
kmem caches that will be reparent'ed if it cannot be destroyed completely.

For the reparent'ed memcg kmem caches, the tag ":deact" will now be
shown in <debugfs>/memcg_slabinfo.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 include/linux/slab.h |  4 ++++
 mm/slab.c            |  1 +
 mm/slab_common.c     | 14 ++++++++------
 mm/slub.c            |  1 +
 4 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index fecf40b7be69..19ab1380f875 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -116,6 +116,10 @@
 /* Objects are reclaimable */
 #define SLAB_RECLAIM_ACCOUNT	((slab_flags_t __force)0x00020000U)
 #define SLAB_TEMPORARY		SLAB_RECLAIM_ACCOUNT	/* Objects are short-lived */
+
+/* Slab deactivation flag */
+#define SLAB_DEACTIVATED	((slab_flags_t __force)0x10000000U)
+
 /*
  * ZERO_SIZE_PTR will be returned for zero sized kmalloc requests.
  *
diff --git a/mm/slab.c b/mm/slab.c
index a2e93adf1df0..e8c7743fc283 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -2245,6 +2245,7 @@ int __kmem_cache_shrink(struct kmem_cache *cachep)
 #ifdef CONFIG_MEMCG
 void __kmemcg_cache_deactivate(struct kmem_cache *cachep)
 {
+	cachep->flags |= SLAB_DEACTIVATED;
 	__kmem_cache_shrink(cachep);
 }
 
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 146d8eaa639c..85cf0c374303 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -1533,7 +1533,7 @@ static int memcg_slabinfo_show(struct seq_file *m, void *unused)
 	struct slabinfo sinfo;
 
 	mutex_lock(&slab_mutex);
-	seq_puts(m, "# <name> <css_id[:dead]> <active_objs> <num_objs>");
+	seq_puts(m, "# <name> <css_id[:dead|deact]> <active_objs> <num_objs>");
 	seq_puts(m, " <active_slabs> <num_slabs>\n");
 	list_for_each_entry(s, &slab_root_caches, root_caches_node) {
 		/*
@@ -1544,22 +1544,24 @@ static int memcg_slabinfo_show(struct seq_file *m, void *unused)
 
 		memset(&sinfo, 0, sizeof(sinfo));
 		get_slabinfo(s, &sinfo);
-		seq_printf(m, "%-17s root      %6lu %6lu %6lu %6lu\n",
+		seq_printf(m, "%-17s root       %6lu %6lu %6lu %6lu\n",
 			   cache_name(s), sinfo.active_objs, sinfo.num_objs,
 			   sinfo.active_slabs, sinfo.num_slabs);
 
 		for_each_memcg_cache(c, s) {
 			struct cgroup_subsys_state *css;
-			char *dead = "";
+			char *status = "";
 
 			css = &c->memcg_params.memcg->css;
 			if (!(css->flags & CSS_ONLINE))
-				dead = ":dead";
+				status = ":dead";
+			else if (c->flags & SLAB_DEACTIVATED)
+				status = ":deact";
 
 			memset(&sinfo, 0, sizeof(sinfo));
 			get_slabinfo(c, &sinfo);
-			seq_printf(m, "%-17s %4d%5s %6lu %6lu %6lu %6lu\n",
-				   cache_name(c), css->id, dead,
+			seq_printf(m, "%-17s %4d%-6s %6lu %6lu %6lu %6lu\n",
+				   cache_name(c), css->id, status,
 				   sinfo.active_objs, sinfo.num_objs,
 				   sinfo.active_slabs, sinfo.num_slabs);
 		}
diff --git a/mm/slub.c b/mm/slub.c
index a384228ff6d3..c965b4413658 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4057,6 +4057,7 @@ void __kmemcg_cache_deactivate(struct kmem_cache *s)
 	 */
 	slub_set_cpu_partial(s, 0);
 	s->min_partial = 0;
+	s->flags |= SLAB_DEACTIVATED;
 }
 #endif	/* CONFIG_MEMCG */
 
-- 
2.18.1

