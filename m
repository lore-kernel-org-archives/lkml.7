Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBA9FC31E5B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 17:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA1C220657
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 17:16:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730039AbfFSRQl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 13:16:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53976 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726251AbfFSRQl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 13:16:41 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 52BE4821C3;
        Wed, 19 Jun 2019 17:16:35 +0000 (UTC)
Received: from llong.com (dhcp-17-85.bos.redhat.com [10.18.17.85])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 15C105D71B;
        Wed, 19 Jun 2019 17:16:29 +0000 (UTC)
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
Subject: [PATCH v2] mm, memcg: Add a memcg_slabinfo debugfs file
Date:   Wed, 19 Jun 2019 13:16:21 -0400
Message-Id: <20190619171621.26209-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Wed, 19 Jun 2019 17:16:40 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are concerns about memory leaks from extensive use of memory
cgroups as each memory cgroup creates its own set of kmem caches. There
is a possiblity that the memcg kmem caches may remain even after the
memory cgroups have been offlined. Therefore, it will be useful to show
the status of each of memcg kmem caches.

This patch introduces a new <debugfs>/memcg_slabinfo file which is
somewhat similar to /proc/slabinfo in format, but lists only information
about kmem caches that have child memcg kmem caches. Information
available in /proc/slabinfo are not repeated in memcg_slabinfo.

A portion of a sample output of the file was:

  # <name> <css_id[:dead]> <active_objs> <num_objs> <active_slabs> <num_slabs>
  rpc_inode_cache   root          13     51      1      1
  rpc_inode_cache     48           0      0      0      0
  fat_inode_cache   root           1     45      1      1
  fat_inode_cache     41           2     45      1      1
  xfs_inode         root         770    816     24     24
  xfs_inode           92          22     34      1      1
  xfs_inode           88:dead      1     34      1      1
  xfs_inode           89:dead     23     34      1      1
  xfs_inode           85           4     34      1      1
  xfs_inode           84           9     34      1      1

The css id of the memcg is also listed. If a memcg is not online,
the tag ":dead" will be attached as shown above.

Suggested-by: Shakeel Butt <shakeelb@google.com>
Signed-off-by: Waiman Long <longman@redhat.com>
---
 mm/slab_common.c | 57 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index 58251ba63e4a..2bca1558a722 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -17,6 +17,7 @@
 #include <linux/uaccess.h>
 #include <linux/seq_file.h>
 #include <linux/proc_fs.h>
+#include <linux/debugfs.h>
 #include <asm/cacheflush.h>
 #include <asm/tlbflush.h>
 #include <asm/page.h>
@@ -1498,6 +1499,62 @@ static int __init slab_proc_init(void)
 	return 0;
 }
 module_init(slab_proc_init);
+
+#if defined(CONFIG_DEBUG_FS) && defined(CONFIG_MEMCG_KMEM)
+/*
+ * Display information about kmem caches that have child memcg caches.
+ */
+static int memcg_slabinfo_show(struct seq_file *m, void *unused)
+{
+	struct kmem_cache *s, *c;
+	struct slabinfo sinfo;
+
+	mutex_lock(&slab_mutex);
+	seq_puts(m, "# <name> <css_id[:dead]> <active_objs> <num_objs>");
+	seq_puts(m, " <active_slabs> <num_slabs>\n");
+	list_for_each_entry(s, &slab_root_caches, root_caches_node) {
+		/*
+		 * Skip kmem caches that don't have any memcg children.
+		 */
+		if (list_empty(&s->memcg_params.children))
+			continue;
+
+		memset(&sinfo, 0, sizeof(sinfo));
+		get_slabinfo(s, &sinfo);
+		seq_printf(m, "%-17s root      %6lu %6lu %6lu %6lu\n",
+			   cache_name(s), sinfo.active_objs, sinfo.num_objs,
+			   sinfo.active_slabs, sinfo.num_slabs);
+
+		for_each_memcg_cache(c, s) {
+			struct cgroup_subsys_state *css;
+			char *dead = "";
+
+			css = &c->memcg_params.memcg->css;
+			if (!(css->flags & CSS_ONLINE))
+				dead = ":dead";
+
+			memset(&sinfo, 0, sizeof(sinfo));
+			get_slabinfo(c, &sinfo);
+			seq_printf(m, "%-17s %4d%5s %6lu %6lu %6lu %6lu\n",
+				   cache_name(c), css->id, dead,
+				   sinfo.active_objs, sinfo.num_objs,
+				   sinfo.active_slabs, sinfo.num_slabs);
+		}
+	}
+	mutex_unlock(&slab_mutex);
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(memcg_slabinfo);
+
+static int __init memcg_slabinfo_init(void)
+{
+	debugfs_create_file("memcg_slabinfo", S_IFREG | S_IRUGO,
+			    NULL, NULL, &memcg_slabinfo_fops);
+	return 0;
+}
+
+late_initcall(memcg_slabinfo_init);
+#endif /* CONFIG_DEBUG_FS && CONFIG_MEMCG_KMEM */
 #endif /* CONFIG_SLAB || CONFIG_SLUB_DEBUG */
 
 static __always_inline void *__do_krealloc(const void *p, size_t new_size,
-- 
2.18.1

