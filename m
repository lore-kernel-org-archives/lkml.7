Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDDEFC7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 15:15:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1A2022543
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 15:15:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390828AbfGWPPC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 11:15:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40811 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729358AbfGWPPB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 11:15:01 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9C94230C34D8;
        Tue, 23 Jul 2019 15:15:00 +0000 (UTC)
Received: from llong.com (dhcp-17-160.bos.redhat.com [10.18.17.160])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7EDF95D9C5;
        Tue, 23 Jul 2019 15:14:55 +0000 (UTC)
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
Subject: [PATCH v3] mm, slab: Extend slab/shrink to shrink all memcg caches
Date:   Tue, 23 Jul 2019 11:14:45 -0400
Message-Id: <20190723151445.7385-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Tue, 23 Jul 2019 15:15:01 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, a value of '1" is written to /sys/kernel/slab/<slab>/shrink
file to shrink the slab by flushing out all the per-cpu slabs and free
slabs in partial lists. This can be useful to squeeze out a bit more memory
under extreme condition as well as making the active object counts in
/proc/slabinfo more accurate.

This usually applies only to the root caches, as the SLUB_MEMCG_SYSFS_ON
option is usually not enabled and "slub_memcg_sysfs=1" not set. Even
if memcg sysfs is turned on, it is too cumbersome and impractical to
manage all those per-memcg sysfs files in a real production system.

So there is no practical way to shrink memcg caches.  Fix this by
enabling a proper write to the shrink sysfs file of the root cache
to scan all the available memcg caches and shrink them as well. For a
non-root memcg cache (when SLUB_MEMCG_SYSFS_ON or slub_memcg_sysfs is
on), only that cache will be shrunk when written.

On a 2-socket 64-core 256-thread arm64 system with 64k page after
a parallel kernel build, the the amount of memory occupied by slabs
before shrinking slabs were:

 # grep task_struct /proc/slabinfo
 task_struct        53137  53192   4288   61    4 : tunables    0    0
 0 : slabdata    872    872      0
 # grep "^S[lRU]" /proc/meminfo
 Slab:            3936832 kB
 SReclaimable:     399104 kB
 SUnreclaim:      3537728 kB

After shrinking slabs (by echoing "1" to all shrink files):

 # grep "^S[lRU]" /proc/meminfo
 Slab:            1356288 kB
 SReclaimable:     263296 kB
 SUnreclaim:      1092992 kB
 # grep task_struct /proc/slabinfo
 task_struct         2764   6832   4288   61    4 : tunables    0    0
 0 : slabdata    112    112      0

 [v3: Drop patch 2 & update doc]

Signed-off-by: Waiman Long <longman@redhat.com>
Acked-by: Roman Gushchin <guro@fb.com>
Acked-by: Christoph Lameter <cl@linux.com>
---
 Documentation/ABI/testing/sysfs-kernel-slab | 13 +++++---
 mm/slab.h                                   |  1 +
 mm/slab_common.c                            | 37 +++++++++++++++++++++
 mm/slub.c                                   |  2 +-
 4 files changed, 48 insertions(+), 5 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-kernel-slab b/Documentation/ABI/testing/sysfs-kernel-slab
index 29601d93a1c2..ed35833ad7f0 100644
--- a/Documentation/ABI/testing/sysfs-kernel-slab
+++ b/Documentation/ABI/testing/sysfs-kernel-slab
@@ -429,10 +429,15 @@ KernelVersion:	2.6.22
 Contact:	Pekka Enberg <penberg@cs.helsinki.fi>,
 		Christoph Lameter <cl@linux-foundation.org>
 Description:
-		The shrink file is written when memory should be reclaimed from
-		a cache.  Empty partial slabs are freed and the partial list is
-		sorted so the slabs with the fewest available objects are used
-		first.
+		The shrink file is used to reclaim unused slab cache
+		memory from a cache.  Empty per-cpu or partial slabs
+		are freed and the partial list is sorted so the slabs
+		with the fewest available objects are used first.
+		It only accepts a value of "1" on write for shrinking
+		the cache. Other input values are considered invalid.
+		Shrinking slab caches might be expensive and can
+		adversely impact other running applications.  So it
+		should be used with care.
 
 What:		/sys/kernel/slab/cache/slab_size
 Date:		May 2007
diff --git a/mm/slab.h b/mm/slab.h
index 9057b8056b07..5bf615cb3f99 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -174,6 +174,7 @@ int __kmem_cache_shrink(struct kmem_cache *);
 void __kmemcg_cache_deactivate(struct kmem_cache *s);
 void __kmemcg_cache_deactivate_after_rcu(struct kmem_cache *s);
 void slab_kmem_cache_release(struct kmem_cache *);
+void kmem_cache_shrink_all(struct kmem_cache *s);
 
 struct seq_file;
 struct file;
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 807490fe217a..6491c3a41805 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -981,6 +981,43 @@ int kmem_cache_shrink(struct kmem_cache *cachep)
 }
 EXPORT_SYMBOL(kmem_cache_shrink);
 
+/**
+ * kmem_cache_shrink_all - shrink a cache and all memcg caches for root cache
+ * @s: The cache pointer
+ */
+void kmem_cache_shrink_all(struct kmem_cache *s)
+{
+	struct kmem_cache *c;
+
+	if (!IS_ENABLED(CONFIG_MEMCG_KMEM) || !is_root_cache(s)) {
+		kmem_cache_shrink(s);
+		return;
+	}
+
+	get_online_cpus();
+	get_online_mems();
+	kasan_cache_shrink(s);
+	__kmem_cache_shrink(s);
+
+	/*
+	 * We have to take the slab_mutex to protect from the memcg list
+	 * modification.
+	 */
+	mutex_lock(&slab_mutex);
+	for_each_memcg_cache(c, s) {
+		/*
+		 * Don't need to shrink deactivated memcg caches.
+		 */
+		if (s->flags & SLAB_DEACTIVATED)
+			continue;
+		kasan_cache_shrink(c);
+		__kmem_cache_shrink(c);
+	}
+	mutex_unlock(&slab_mutex);
+	put_online_mems();
+	put_online_cpus();
+}
+
 bool slab_is_available(void)
 {
 	return slab_state >= UP;
diff --git a/mm/slub.c b/mm/slub.c
index e6c030e47364..9736eb10dcb8 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -5294,7 +5294,7 @@ static ssize_t shrink_store(struct kmem_cache *s,
 			const char *buf, size_t length)
 {
 	if (buf[0] == '1')
-		kmem_cache_shrink(s);
+		kmem_cache_shrink_all(s);
 	else
 		return -EINVAL;
 	return length;
-- 
2.18.1

