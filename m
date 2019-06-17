Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2ECAC31E59
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 14:22:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 827802084B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 14:22:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728176AbfFQOW1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 10:22:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51706 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726173AbfFQOW0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 10:22:26 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6FB8A30C31B7;
        Mon, 17 Jun 2019 14:22:15 +0000 (UTC)
Received: from llong.com (dhcp-17-85.bos.redhat.com [10.18.17.85])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DFB457E5CA;
        Mon, 17 Jun 2019 14:22:02 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH] mm, memcg: Report number of memcg caches in slabinfo
Date:   Mon, 17 Jun 2019 10:21:49 -0400
Message-Id: <20190617142149.5245-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Mon, 17 Jun 2019 14:22:25 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are concerns about memory leaks from extensive use of memory
cgroups as each memory cgroup creates its own set of kmem caches. There
is a possiblity that the memcg kmem caches may remain even after the
memory cgroup removal.

Therefore, it will be useful to show how many memcg caches are present
for each of the kmem caches. As slabinfo reporting code has to iterate
through all the memcg caches to get the final numbers anyway, there is
no additional cost in reporting the number of memcg caches available.

The slabinfo version is bumped up to 2.2 as a new "<num_caches>" column
is added at the end.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 mm/slab_common.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index 58251ba63e4a..c7aa47a99b2b 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -1308,13 +1308,13 @@ static void print_slabinfo_header(struct seq_file *m)
 	 * without _too_ many complaints.
 	 */
 #ifdef CONFIG_DEBUG_SLAB
-	seq_puts(m, "slabinfo - version: 2.1 (statistics)\n");
+	seq_puts(m, "slabinfo - version: 2.2 (statistics)\n");
 #else
-	seq_puts(m, "slabinfo - version: 2.1\n");
+	seq_puts(m, "slabinfo - version: 2.2\n");
 #endif
 	seq_puts(m, "# name            <active_objs> <num_objs> <objsize> <objperslab> <pagesperslab>");
 	seq_puts(m, " : tunables <limit> <batchcount> <sharedfactor>");
-	seq_puts(m, " : slabdata <active_slabs> <num_slabs> <sharedavail>");
+	seq_puts(m, " : slabdata <active_slabs> <num_slabs> <sharedavail> <num_caches>");
 #ifdef CONFIG_DEBUG_SLAB
 	seq_puts(m, " : globalstat <listallocs> <maxobjs> <grown> <reaped> <error> <maxfreeable> <nodeallocs> <remotefrees> <alienoverflow>");
 	seq_puts(m, " : cpustat <allochit> <allocmiss> <freehit> <freemiss>");
@@ -1338,14 +1338,18 @@ void slab_stop(struct seq_file *m, void *p)
 	mutex_unlock(&slab_mutex);
 }
 
-static void
+/*
+ * Return number of memcg caches.
+ */
+static unsigned int
 memcg_accumulate_slabinfo(struct kmem_cache *s, struct slabinfo *info)
 {
 	struct kmem_cache *c;
 	struct slabinfo sinfo;
+	unsigned int cnt = 0;
 
 	if (!is_root_cache(s))
-		return;
+		return 0;
 
 	for_each_memcg_cache(c, s) {
 		memset(&sinfo, 0, sizeof(sinfo));
@@ -1356,17 +1360,20 @@ memcg_accumulate_slabinfo(struct kmem_cache *s, struct slabinfo *info)
 		info->shared_avail += sinfo.shared_avail;
 		info->active_objs += sinfo.active_objs;
 		info->num_objs += sinfo.num_objs;
+		cnt++;
 	}
+	return cnt;
 }
 
 static void cache_show(struct kmem_cache *s, struct seq_file *m)
 {
 	struct slabinfo sinfo;
+	unsigned int nr_memcg_caches;
 
 	memset(&sinfo, 0, sizeof(sinfo));
 	get_slabinfo(s, &sinfo);
 
-	memcg_accumulate_slabinfo(s, &sinfo);
+	nr_memcg_caches = memcg_accumulate_slabinfo(s, &sinfo);
 
 	seq_printf(m, "%-17s %6lu %6lu %6u %4u %4d",
 		   cache_name(s), sinfo.active_objs, sinfo.num_objs, s->size,
@@ -1374,8 +1381,9 @@ static void cache_show(struct kmem_cache *s, struct seq_file *m)
 
 	seq_printf(m, " : tunables %4u %4u %4u",
 		   sinfo.limit, sinfo.batchcount, sinfo.shared);
-	seq_printf(m, " : slabdata %6lu %6lu %6lu",
-		   sinfo.active_slabs, sinfo.num_slabs, sinfo.shared_avail);
+	seq_printf(m, " : slabdata %6lu %6lu %6lu %3u",
+		   sinfo.active_slabs, sinfo.num_slabs, sinfo.shared_avail,
+		   nr_memcg_caches);
 	slabinfo_show_stats(m, s);
 	seq_putc(m, '\n');
 }
-- 
2.18.1

