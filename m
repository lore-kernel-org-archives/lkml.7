Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35FE9C76195
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 20:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18D0821880
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 20:25:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728580AbfGQUZg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 16:25:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38366 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727104AbfGQUZe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 16:25:34 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0C66030842A0;
        Wed, 17 Jul 2019 20:25:34 +0000 (UTC)
Received: from llong.com (dhcp-17-160.bos.redhat.com [10.18.17.160])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AB95B5C260;
        Wed, 17 Jul 2019 20:25:31 +0000 (UTC)
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
Subject: [PATCH v2 2/2] mm, slab: Show last shrink time in us when slab/shrink is read
Date:   Wed, 17 Jul 2019 16:24:13 -0400
Message-Id: <20190717202413.13237-3-longman@redhat.com>
In-Reply-To: <20190717202413.13237-1-longman@redhat.com>
References: <20190717202413.13237-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Wed, 17 Jul 2019 20:25:34 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The show method of /sys/kernel/slab/<slab>/shrink sysfs file currently
returns nothing. This is now modified to show the time of the last
cache shrink operation in us.

CONFIG_SLUB_DEBUG depends on CONFIG_SYSFS. So the new shrink_us field
is always available to the shrink methods.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 Documentation/ABI/testing/sysfs-kernel-slab |  2 ++
 include/linux/slub_def.h                    |  1 +
 mm/slub.c                                   | 12 +++++++++---
 3 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-kernel-slab b/Documentation/ABI/testing/sysfs-kernel-slab
index 94ffd47fc8d7..9869a3f57dc3 100644
--- a/Documentation/ABI/testing/sysfs-kernel-slab
+++ b/Documentation/ABI/testing/sysfs-kernel-slab
@@ -437,6 +437,8 @@ Description:
 		write for shrinking the cache. Other input values are
 		considered invalid.  If it is a root cache, all the
 		child memcg caches will also be shrunk, if available.
+		When read, the time in us of the last cache shrink
+		operation is shown.
 
 What:		/sys/kernel/slab/cache/slab_size
 Date:		May 2007
diff --git a/include/linux/slub_def.h b/include/linux/slub_def.h
index d2153789bd9f..055474197e83 100644
--- a/include/linux/slub_def.h
+++ b/include/linux/slub_def.h
@@ -113,6 +113,7 @@ struct kmem_cache {
 	/* For propagation, maximum size of a stored attr */
 	unsigned int max_attr_size;
 #ifdef CONFIG_SYSFS
+	unsigned int shrink_us;	/* Cache shrink time in us */
 	struct kset *memcg_kset;
 #endif
 #endif
diff --git a/mm/slub.c b/mm/slub.c
index 9736eb10dcb8..77d67a55ce43 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -34,6 +34,7 @@
 #include <linux/prefetch.h>
 #include <linux/memcontrol.h>
 #include <linux/random.h>
+#include <linux/sched/clock.h>
 
 #include <trace/events/kmem.h>
 
@@ -5287,16 +5288,21 @@ SLAB_ATTR(failslab);
 
 static ssize_t shrink_show(struct kmem_cache *s, char *buf)
 {
-	return 0;
+	return sprintf(buf, "%u\n", s->shrink_us);
 }
 
 static ssize_t shrink_store(struct kmem_cache *s,
 			const char *buf, size_t length)
 {
-	if (buf[0] == '1')
+	if (buf[0] == '1') {
+		u64 start = sched_clock();
+
 		kmem_cache_shrink_all(s);
-	else
+		s->shrink_us = (unsigned int)div_u64(sched_clock() - start,
+						     NSEC_PER_USEC);
+	} else {
 		return -EINVAL;
+	}
 	return length;
 }
 SLAB_ATTR(shrink);
-- 
2.18.1

