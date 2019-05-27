Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8734C04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 10:06:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67F742146F
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 10:06:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="IQgEK7oQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbfE0KGE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 06:06:04 -0400
Received: from forwardcorp1o.mail.yandex.net ([95.108.205.193]:42576 "EHLO
        forwardcorp1o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725973AbfE0KGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 06:06:04 -0400
Received: from mxbackcorp1j.mail.yandex.net (mxbackcorp1j.mail.yandex.net [IPv6:2a02:6b8:0:1619::162])
        by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id 1F30B2E0954;
        Mon, 27 May 2019 13:06:00 +0300 (MSK)
Received: from smtpcorp1o.mail.yandex.net (smtpcorp1o.mail.yandex.net [2a02:6b8:0:1a2d::30])
        by mxbackcorp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id OwJn8zAnJQ-5wpmSr5g;
        Mon, 27 May 2019 13:06:00 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1558951560; bh=CQxEERr1BIi9CCcIXn6D3UIoYJZJlgFtBTDB1IkaSu8=;
        h=Message-ID:Date:To:From:Subject:Cc;
        b=IQgEK7oQm8wis5bpbA8YwPhFP2T7VClcMSokHBBCYQ4qCjG0zBDL6cO3BImi/e7oq
         G+ZRiGSYMArxMg2Fa78/w5wSBC2r2x/euqAecttbszz8EahWvJoUYxKpKLw5pUeXqS
         FIh/N5j0jpBBAuuUhvz0lF5a/I6FSqU5HgmaeOdM=
Authentication-Results: mxbackcorp1j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:d877:17c:81de:6e43])
        by smtpcorp1o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id L1algiQOax-5wluW1QG;
        Mon, 27 May 2019 13:05:58 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: [PATCH RFC] mm/madvise: implement MADV_STOCKPILE (kswapd from user
 space)
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Michal Hocko <mhocko@suse.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Roman Gushchin <guro@fb.com>
Date:   Mon, 27 May 2019 13:05:58 +0300
Message-ID: <155895155861.2824.318013775811596173.stgit@buzz>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Memory cgroup has no background memory reclaimer. Reclaiming after passing
high-limit blocks task because works synchronously in task-work.

This implements manual kswapd-style memory reclaim initiated by userspace.
It reclaims both physical memory and cgroup pages. It works in context of
task who calls syscall madvise thus cpu time is accounted correctly.

Interface:

ret = madvise(ptr, size, MADV_STOCKPILE)

Returns:
  0         - ok, free memory >= size
  -EINVAL   - not supported
  -ENOMEM   - not enough memory/cgroup limit
  -EINTR    - interrupted by pending signal
  -EAGAIN   - cannot reclaim enough memory

Argument 'size' is interpreted size of required free memory.
Implementation triggers direct reclaim until amount of free memory is
lower than that size. Argument 'ptr' could points to vma for specifying
numa allocation policy, right now should be NULL.

Usage scenario: independent thread or standalone daemon estimates rate of
allocations and calls MADV_STOCKPILE in loop to prepare free pages.
Thus fast path avoids allocation latency induced by direct reclaim.

We are using this embedded into memory allocator based on MADV_FREE.


Demonstration in memory cgroup with limit 1G:

touch zero
truncate -s 5G zero

Without stockpile:

perf stat -e vmscan:* md5sum zero

 Performance counter stats for 'md5sum zero':

                 0      vmscan:mm_vmscan_kswapd_sleep
                 0      vmscan:mm_vmscan_kswapd_wake
                 0      vmscan:mm_vmscan_wakeup_kswapd
                 0      vmscan:mm_vmscan_direct_reclaim_begin
             10147      vmscan:mm_vmscan_memcg_reclaim_begin
                 0      vmscan:mm_vmscan_memcg_softlimit_reclaim_begin
                 0      vmscan:mm_vmscan_direct_reclaim_end
             10147      vmscan:mm_vmscan_memcg_reclaim_end
                 0      vmscan:mm_vmscan_memcg_softlimit_reclaim_end
             99910      vmscan:mm_shrink_slab_start
             99910      vmscan:mm_shrink_slab_end
             39654      vmscan:mm_vmscan_lru_isolate
                 0      vmscan:mm_vmscan_writepage
             39652      vmscan:mm_vmscan_lru_shrink_inactive
                 2      vmscan:mm_vmscan_lru_shrink_active
             19982      vmscan:mm_vmscan_inactive_list_is_low

      10.886832585 seconds time elapsed

       8.928366000 seconds user
       1.935212000 seconds sys

With stockpile:

stockpile 100 10 &   # up to 100M every 10ms
perf stat -e vmscan:* md5sum zero

 Performance counter stats for 'md5sum zero':

                 0      vmscan:mm_vmscan_kswapd_sleep
                 0      vmscan:mm_vmscan_kswapd_wake
                 0      vmscan:mm_vmscan_wakeup_kswapd
                 0      vmscan:mm_vmscan_direct_reclaim_begin
                 0      vmscan:mm_vmscan_memcg_reclaim_begin
                 0      vmscan:mm_vmscan_memcg_softlimit_reclaim_begin
                 0      vmscan:mm_vmscan_direct_reclaim_end
                 0      vmscan:mm_vmscan_memcg_reclaim_end
                 0      vmscan:mm_vmscan_memcg_softlimit_reclaim_end
                 0      vmscan:mm_shrink_slab_start
                 0      vmscan:mm_shrink_slab_end
                 0      vmscan:mm_vmscan_lru_isolate
                 0      vmscan:mm_vmscan_writepage
                 0      vmscan:mm_vmscan_lru_shrink_inactive
                 0      vmscan:mm_vmscan_lru_shrink_active
                 0      vmscan:mm_vmscan_inactive_list_is_low

      10.469776675 seconds time elapsed

       8.976261000 seconds user
       1.491378000 seconds sys

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
---
 include/linux/memcontrol.h             |    6 +++++
 include/uapi/asm-generic/mman-common.h |    2 ++
 mm/madvise.c                           |   39 ++++++++++++++++++++++++++++++
 mm/memcontrol.c                        |   41 ++++++++++++++++++++++++++++++++
 tools/vm/Makefile                      |    2 +-
 tools/vm/stockpile.c                   |   30 +++++++++++++++++++++++
 6 files changed, 119 insertions(+), 1 deletion(-)
 create mode 100644 tools/vm/stockpile.c

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index bc74d6a4407c..25325f18ad55 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -517,6 +517,7 @@ unsigned long mem_cgroup_get_zone_lru_size(struct lruvec *lruvec,
 }
 
 void mem_cgroup_handle_over_high(void);
+int mem_cgroup_stockpile(unsigned long goal_pages);
 
 unsigned long mem_cgroup_get_max(struct mem_cgroup *memcg);
 
@@ -968,6 +969,11 @@ static inline void mem_cgroup_handle_over_high(void)
 {
 }
 
+static inline int mem_cgroup_stockpile(unsigned long goal_page)
+{
+	return 0;
+}
+
 static inline void mem_cgroup_enter_user_fault(void)
 {
 }
diff --git a/include/uapi/asm-generic/mman-common.h b/include/uapi/asm-generic/mman-common.h
index abd238d0f7a4..675145864fee 100644
--- a/include/uapi/asm-generic/mman-common.h
+++ b/include/uapi/asm-generic/mman-common.h
@@ -64,6 +64,8 @@
 #define MADV_WIPEONFORK 18		/* Zero memory on fork, child only */
 #define MADV_KEEPONFORK 19		/* Undo MADV_WIPEONFORK */
 
+#define MADV_STOCKPILE	20		/* stockpile free pages */
+
 /* compatibility flags */
 #define MAP_FILE	0
 
diff --git a/mm/madvise.c b/mm/madvise.c
index 628022e674a7..f908b08ecc9f 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -686,6 +686,41 @@ static int madvise_inject_error(int behavior,
 }
 #endif
 
+static long madvise_stockpile(unsigned long start, size_t len)
+{
+	unsigned long goal_pages, progress;
+	struct zonelist *zonelist;
+	int ret;
+
+	if (start)
+		return -EINVAL;
+
+	goal_pages = len >> PAGE_SHIFT;
+
+	if (goal_pages > totalram_pages() - totalreserve_pages)
+		return -ENOMEM;
+
+	ret = mem_cgroup_stockpile(goal_pages);
+	if (ret)
+		return ret;
+
+	/* TODO: use vma mempolicy */
+	zonelist = node_zonelist(numa_node_id(), GFP_HIGHUSER);
+
+	while (global_zone_page_state(NR_FREE_PAGES) <
+			goal_pages + totalreserve_pages) {
+
+		if (signal_pending(current))
+			return -EINTR;
+
+		progress = try_to_free_pages(zonelist, 0, GFP_HIGHUSER, NULL);
+		if (!progress)
+			return -EAGAIN;
+	}
+
+	return 0;
+}
+
 static long
 madvise_vma(struct vm_area_struct *vma, struct vm_area_struct **prev,
 		unsigned long start, unsigned long end, int behavior)
@@ -728,6 +763,7 @@ madvise_behavior_valid(int behavior)
 	case MADV_DODUMP:
 	case MADV_WIPEONFORK:
 	case MADV_KEEPONFORK:
+	case MADV_STOCKPILE:
 #ifdef CONFIG_MEMORY_FAILURE
 	case MADV_SOFT_OFFLINE:
 	case MADV_HWPOISON:
@@ -834,6 +870,9 @@ SYSCALL_DEFINE3(madvise, unsigned long, start, size_t, len_in, int, behavior)
 		return madvise_inject_error(behavior, start, start + len_in);
 #endif
 
+	if (behavior == MADV_STOCKPILE)
+		return madvise_stockpile(start, len);
+
 	write = madvise_need_mmap_write(behavior);
 	if (write) {
 		if (down_write_killable(&current->mm->mmap_sem))
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index e50a2db5b4ff..dc23dc6bbeb3 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2276,6 +2276,47 @@ void mem_cgroup_handle_over_high(void)
 	current->memcg_nr_pages_over_high = 0;
 }
 
+int mem_cgroup_stockpile(unsigned long goal_pages)
+{
+	int nr_retries = MEM_CGROUP_RECLAIM_RETRIES;
+	unsigned long limit, nr_free, progress;
+	struct mem_cgroup *memcg, *pos;
+	int ret = 0;
+
+	pos = memcg = get_mem_cgroup_from_mm(current->mm);
+
+retry:
+	if (signal_pending(current)) {
+		ret = -EINTR;
+		goto out;
+	}
+
+	limit = min(pos->memory.max, pos->high);
+	if (goal_pages > limit) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	nr_free = limit - page_counter_read(&pos->memory);
+	if ((long)nr_free < (long)goal_pages) {
+		progress = try_to_free_mem_cgroup_pages(pos,
+				goal_pages - nr_free, GFP_HIGHUSER, true);
+		if (progress || nr_retries--)
+			goto retry;
+		ret = -EAGAIN;
+		goto out;
+	}
+
+	nr_retries = MEM_CGROUP_RECLAIM_RETRIES;
+	pos = parent_mem_cgroup(pos);
+	if (pos)
+		goto retry;
+
+out:
+	css_put(&memcg->css);
+	return ret;
+}
+
 static int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
 		      unsigned int nr_pages)
 {
diff --git a/tools/vm/Makefile b/tools/vm/Makefile
index 20f6cf04377f..e5b5bc0d9421 100644
--- a/tools/vm/Makefile
+++ b/tools/vm/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 # Makefile for vm tools
 #
-TARGETS=page-types slabinfo page_owner_sort
+TARGETS=page-types slabinfo page_owner_sort stockpile
 
 LIB_DIR = ../lib/api
 LIBS = $(LIB_DIR)/libapi.a
diff --git a/tools/vm/stockpile.c b/tools/vm/stockpile.c
new file mode 100644
index 000000000000..245e24f293ec
--- /dev/null
+++ b/tools/vm/stockpile.c
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <sys/mman.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <err.h>
+#include <errno.h>
+
+#ifndef MADV_STOCKPILE
+# define MADV_STOCKPILE	20
+#endif
+
+int main(int argc, char **argv)
+{
+	int interval;
+	size_t size;
+	int ret;
+
+	if (argc != 3)
+		errx(1, "usage: %s <size_mb> <interval_ms>", argv[0]);
+
+	size = atol(argv[1]) << 20;
+	interval = atoi(argv[2]) * 1000;
+
+	while (1) {
+		ret = madvise(NULL, size, MADV_STOCKPILE);
+		if (ret && errno != EAGAIN)
+			err(2, "madvise(NULL, %zu, MADV_STOCKPILE)", size);
+		usleep(interval);
+	}
+}

