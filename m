Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D70C48BE4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 18:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1E70208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 18:44:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbfF0SoE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 14:44:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50234 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726441AbfF0SoD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 14:44:03 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 64712C05B1CD;
        Thu, 27 Jun 2019 18:43:46 +0000 (UTC)
Received: from llong.com (dhcp-17-85.bos.redhat.com [10.18.17.85])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8CCD160126;
        Thu, 27 Jun 2019 18:43:37 +0000 (UTC)
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
Subject: [PATCH-next v2] mm, memcg: Add ":deact" tag for reparented kmem caches in memcg_slabinfo
Date:   Thu, 27 Jun 2019 14:43:24 -0400
Message-Id: <20190627184324.5875-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Thu, 27 Jun 2019 18:44:02 +0000 (UTC)
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

[v2: Set the flag in the common code as suggested by Roman.]

Signed-off-by: Waiman Long <longman@redhat.com>
Reviewed-by: Shakeel Butt <shakeelb@google.com>
Acked-by: Roman Gushchin <guro@fb.com>
---
 include/linux/slab.h |  4 ++++
 mm/slab_common.c     | 15 +++++++++------
 2 files changed, 13 insertions(+), 6 deletions(-)

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
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 146d8eaa639c..464faaa9fd81 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -771,6 +771,7 @@ static void kmemcg_cache_deactivate(struct kmem_cache *s)
 		return;
 
 	__kmemcg_cache_deactivate(s);
+	s->flags |= SLAB_DEACTIVATED;
 
 	/*
 	 * memcg_kmem_wq_lock is used to synchronize memcg_params.dying
@@ -1533,7 +1534,7 @@ static int memcg_slabinfo_show(struct seq_file *m, void *unused)
 	struct slabinfo sinfo;
 
 	mutex_lock(&slab_mutex);
-	seq_puts(m, "# <name> <css_id[:dead]> <active_objs> <num_objs>");
+	seq_puts(m, "# <name> <css_id[:dead|deact]> <active_objs> <num_objs>");
 	seq_puts(m, " <active_slabs> <num_slabs>\n");
 	list_for_each_entry(s, &slab_root_caches, root_caches_node) {
 		/*
@@ -1544,22 +1545,24 @@ static int memcg_slabinfo_show(struct seq_file *m, void *unused)
 
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
-- 
2.18.1

