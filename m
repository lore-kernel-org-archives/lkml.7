Return-Path: <SRS0=HtuS=UO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAFEBC31E50
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 12:06:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DAE721841
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 12:06:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbfFOMGz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Jun 2019 08:06:55 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:34749 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725446AbfFOMGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jun 2019 08:06:54 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=xlpang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0TUEbRAF_1560600404;
Received: from localhost(mailfrom:xlpang@linux.alibaba.com fp:SMTPD_---0TUEbRAF_1560600404)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 15 Jun 2019 20:06:50 +0800
From:   Xunlei Pang <xlpang@linux.alibaba.com>
To:     Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH] psi: Don't account force reclaim as memory pressure
Date:   Sat, 15 Jun 2019 20:06:44 +0800
Message-Id: <20190615120644.26743-1-xlpang@linux.alibaba.com>
X-Mailer: git-send-email 2.14.4.44.g2045bb6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There're several cases like resize and force_empty that don't
need to account to psi, otherwise is misleading.

We also have a module reclaiming dying memcgs at background to
avoid too many dead memcgs which can cause lots of trouble, then
it makes the psi inaccuracy even worse without this patch.

Signed-off-by: Xunlei Pang <xlpang@linux.alibaba.com>
---
 include/linux/swap.h |  3 ++-
 mm/memcontrol.c      | 13 +++++++------
 mm/vmscan.c          |  9 ++++++---
 3 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 4bfb5c4ac108..74b5443877d4 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -354,7 +354,8 @@ extern int __isolate_lru_page(struct page *page, isolate_mode_t mode);
 extern unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
 						  unsigned long nr_pages,
 						  gfp_t gfp_mask,
-						  bool may_swap);
+						  bool may_swap,
+						  bool force_reclaim);
 extern unsigned long mem_cgroup_shrink_node(struct mem_cgroup *mem,
 						gfp_t gfp_mask, bool noswap,
 						pg_data_t *pgdat,
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index f1dfa651f55d..f4ec57876ada 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2237,7 +2237,8 @@ static void reclaim_high(struct mem_cgroup *memcg,
 		if (page_counter_read(&memcg->memory) <= memcg->high)
 			continue;
 		memcg_memory_event(memcg, MEMCG_HIGH);
-		try_to_free_mem_cgroup_pages(memcg, nr_pages, gfp_mask, true);
+		try_to_free_mem_cgroup_pages(memcg, nr_pages,
+				gfp_mask, true, false);
 	} while ((memcg = parent_mem_cgroup(memcg)));
 }
 
@@ -2330,7 +2331,7 @@ static int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	memcg_memory_event(mem_over_limit, MEMCG_MAX);
 
 	nr_reclaimed = try_to_free_mem_cgroup_pages(mem_over_limit, nr_pages,
-						    gfp_mask, may_swap);
+					 gfp_mask, may_swap, false);
 
 	if (mem_cgroup_margin(mem_over_limit) >= nr_pages)
 		goto retry;
@@ -2860,7 +2861,7 @@ static int mem_cgroup_resize_max(struct mem_cgroup *memcg,
 		}
 
 		if (!try_to_free_mem_cgroup_pages(memcg, 1,
-					GFP_KERNEL, !memsw)) {
+					GFP_KERNEL, !memsw, true)) {
 			ret = -EBUSY;
 			break;
 		}
@@ -2993,7 +2994,7 @@ static int mem_cgroup_force_empty(struct mem_cgroup *memcg)
 			return -EINTR;
 
 		progress = try_to_free_mem_cgroup_pages(memcg, 1,
-							GFP_KERNEL, true);
+							GFP_KERNEL, true, true);
 		if (!progress) {
 			nr_retries--;
 			/* maybe some writeback is necessary */
@@ -5549,7 +5550,7 @@ static ssize_t memory_high_write(struct kernfs_open_file *of,
 	nr_pages = page_counter_read(&memcg->memory);
 	if (nr_pages > high)
 		try_to_free_mem_cgroup_pages(memcg, nr_pages - high,
-					     GFP_KERNEL, true);
+					     GFP_KERNEL, true, true);
 
 	memcg_wb_domain_size_changed(memcg);
 	return nbytes;
@@ -5596,7 +5597,7 @@ static ssize_t memory_max_write(struct kernfs_open_file *of,
 
 		if (nr_reclaims) {
 			if (!try_to_free_mem_cgroup_pages(memcg, nr_pages - max,
-							  GFP_KERNEL, true))
+						GFP_KERNEL, true, true))
 				nr_reclaims--;
 			continue;
 		}
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 7acd0afdfc2a..3831848fca5a 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3212,7 +3212,8 @@ unsigned long mem_cgroup_shrink_node(struct mem_cgroup *memcg,
 unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
 					   unsigned long nr_pages,
 					   gfp_t gfp_mask,
-					   bool may_swap)
+					   bool may_swap,
+					   bool force_reclaim)
 {
 	struct zonelist *zonelist;
 	unsigned long nr_reclaimed;
@@ -3243,13 +3244,15 @@ unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
 
 	trace_mm_vmscan_memcg_reclaim_begin(0, sc.gfp_mask);
 
-	psi_memstall_enter(&pflags);
+	if (!force_reclaim)
+		psi_memstall_enter(&pflags);
 	noreclaim_flag = memalloc_noreclaim_save();
 
 	nr_reclaimed = do_try_to_free_pages(zonelist, &sc);
 
 	memalloc_noreclaim_restore(noreclaim_flag);
-	psi_memstall_leave(&pflags);
+	if (!force_reclaim)
+		psi_memstall_leave(&pflags);
 
 	trace_mm_vmscan_memcg_reclaim_end(nr_reclaimed);
 
-- 
2.14.4.44.g2045bb6

