Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9D05C76192
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 12:29:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A90D520880
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 12:29:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="nq8XUGG5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731110AbfGQM3Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 08:29:25 -0400
Received: from forwardcorp1p.mail.yandex.net ([77.88.29.217]:50648 "EHLO
        forwardcorp1p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725873AbfGQM3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 08:29:24 -0400
Received: from mxbackcorp1g.mail.yandex.net (mxbackcorp1g.mail.yandex.net [IPv6:2a02:6b8:0:1402::301])
        by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id 6DEBB2E14BD;
        Wed, 17 Jul 2019 15:29:20 +0300 (MSK)
Received: from smtpcorp1o.mail.yandex.net (smtpcorp1o.mail.yandex.net [2a02:6b8:0:1a2d::30])
        by mxbackcorp1g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id zAEKNlfcnL-TKt4QiXA;
        Wed, 17 Jul 2019 15:29:20 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1563366560; bh=aMpv7Xct1a+OGXg8ADZUVXKf/2FGP5PbSlVY1U6Mlv0=;
        h=In-Reply-To:Message-ID:References:Date:To:From:Subject:Cc;
        b=nq8XUGG5Mgz9Txk1sHrC9JAhqHwzZBZiWqPSAVh4DZFsIM3GQogd0iO9GHwLL1QQi
         Q+o47kVvkdIbKdckX1i/F8IPbcT9SnAkEeVFD4Nil4hDg59DziL1LK/eTKk8BYp978
         zobtuPhWhYFl58Tbs0ccVmOopzum0l2zDBo44etE=
Authentication-Results: mxbackcorp1g.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:38d2:81d0:9f31:221f])
        by smtpcorp1o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id YSbPaaLWJy-TK9CVQFZ;
        Wed, 17 Jul 2019 15:29:20 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: [PATCH 2/2] mm/memcontrol: split local and nested atomic
 vmstats/vmevents counters
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     Michal Hocko <mhocko@kernel.org>
Date:   Wed, 17 Jul 2019 15:29:19 +0300
Message-ID: <156336655979.2828.15196553724473875230.stgit@buzz>
In-Reply-To: <156336655741.2828.4721531901883313745.stgit@buzz>
References: <156336655741.2828.4721531901883313745.stgit@buzz>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is alternative solution for problem addressed in commit 815744d75152
("mm: memcontrol: don't batch updates of local VM stats and events").

Instead of adding second set of percpu counters which wastes memory and
slows down showing statistics in cgroup-v1 this patch use two arrays of
atomic counters: local and nested statistics.

Then update has the same amount of atomic operations: local update and
one nested for each parent cgroup. Readers of hierarchical statistics
have to sum two atomics which isn't a big deal.

All updates are still batched using one set of percpu counters.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
---
 include/linux/memcontrol.h |   19 +++++++----------
 mm/memcontrol.c            |   48 +++++++++++++++++++-------------------------
 2 files changed, 29 insertions(+), 38 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 44c41462be33..4dd75d50c200 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -269,16 +269,16 @@ struct mem_cgroup {
 	atomic_t		moving_account;
 	struct task_struct	*move_lock_task;
 
-	/* Legacy local VM stats and events */
-	struct memcg_vmstats_percpu __percpu *vmstats_local;
-
 	/* Subtree VM stats and events (batched updates) */
 	struct memcg_vmstats_percpu __percpu *vmstats_percpu;
 
 	MEMCG_PADDING(_pad2_);
 
-	atomic_long_t		vmstats[MEMCG_NR_STAT];
-	atomic_long_t		vmevents[NR_VM_EVENT_ITEMS];
+	atomic_long_t		vmstats_local[MEMCG_NR_STAT];
+	atomic_long_t		vmstats_nested[MEMCG_NR_STAT];
+
+	atomic_long_t		vmevents_local[NR_VM_EVENT_ITEMS];
+	atomic_long_t		vmevents_nested[NR_VM_EVENT_ITEMS];
 
 	/* memory.events */
 	atomic_long_t		memory_events[MEMCG_NR_MEMORY_EVENTS];
@@ -557,7 +557,8 @@ void unlock_page_memcg(struct page *page);
  */
 static inline unsigned long memcg_page_state(struct mem_cgroup *memcg, int idx)
 {
-	long x = atomic_long_read(&memcg->vmstats[idx]);
+	long x = atomic_long_read(&memcg->vmstats_local[idx]) +
+		 atomic_long_read(&memcg->vmstats_nested[idx]);
 #ifdef CONFIG_SMP
 	if (x < 0)
 		x = 0;
@@ -572,11 +573,7 @@ static inline unsigned long memcg_page_state(struct mem_cgroup *memcg, int idx)
 static inline unsigned long memcg_page_state_local(struct mem_cgroup *memcg,
 						   int idx)
 {
-	long x = 0;
-	int cpu;
-
-	for_each_possible_cpu(cpu)
-		x += per_cpu(memcg->vmstats_local->stat[idx], cpu);
+	long x = atomic_long_read(&memcg->vmstats_local[idx]);
 #ifdef CONFIG_SMP
 	if (x < 0)
 		x = 0;
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 06d33dfc4ec4..97debc8e4120 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -695,14 +695,13 @@ void __mod_memcg_state(struct mem_cgroup *memcg, int idx, int val)
 	if (mem_cgroup_disabled())
 		return;
 
-	__this_cpu_add(memcg->vmstats_local->stat[idx], val);
-
 	x = val + __this_cpu_read(memcg->vmstats_percpu->stat[idx]);
 	if (unlikely(abs(x) > MEMCG_CHARGE_BATCH)) {
 		struct mem_cgroup *mi;
 
-		for (mi = memcg; mi; mi = parent_mem_cgroup(mi))
-			atomic_long_add(x, &mi->vmstats[idx]);
+		atomic_long_add(x, &memcg->vmstats_local[idx]);
+		for (mi = memcg; (mi = parent_mem_cgroup(mi)); )
+			atomic_long_add(x, &mi->vmstats_nested[idx]);
 		x = 0;
 	}
 	__this_cpu_write(memcg->vmstats_percpu->stat[idx], x);
@@ -777,14 +776,13 @@ void __count_memcg_events(struct mem_cgroup *memcg, enum vm_event_item idx,
 	if (mem_cgroup_disabled())
 		return;
 
-	__this_cpu_add(memcg->vmstats_local->events[idx], count);
-
 	x = count + __this_cpu_read(memcg->vmstats_percpu->events[idx]);
 	if (unlikely(x > MEMCG_CHARGE_BATCH)) {
 		struct mem_cgroup *mi;
 
-		for (mi = memcg; mi; mi = parent_mem_cgroup(mi))
-			atomic_long_add(x, &mi->vmevents[idx]);
+		atomic_long_add(x, &memcg->vmevents_local[idx]);
+		for (mi = memcg; (mi = parent_mem_cgroup(mi)); )
+			atomic_long_add(x, &mi->vmevents_nested[idx]);
 		x = 0;
 	}
 	__this_cpu_write(memcg->vmstats_percpu->events[idx], x);
@@ -792,17 +790,13 @@ void __count_memcg_events(struct mem_cgroup *memcg, enum vm_event_item idx,
 
 static unsigned long memcg_events(struct mem_cgroup *memcg, int event)
 {
-	return atomic_long_read(&memcg->vmevents[event]);
+	return atomic_long_read(&memcg->vmevents_local[event]) +
+	       atomic_long_read(&memcg->vmevents_nested[event]);
 }
 
 static unsigned long memcg_events_local(struct mem_cgroup *memcg, int event)
 {
-	long x = 0;
-	int cpu;
-
-	for_each_possible_cpu(cpu)
-		x += per_cpu(memcg->vmstats_local->events[event], cpu);
-	return x;
+	return atomic_long_read(&memcg->vmevents_local[event]);
 }
 
 static void mem_cgroup_charge_statistics(struct mem_cgroup *memcg,
@@ -2257,9 +2251,11 @@ static int memcg_hotplug_cpu_dead(unsigned int cpu)
 			long x;
 
 			x = this_cpu_xchg(memcg->vmstats_percpu->stat[i], 0);
-			if (x)
-				for (mi = memcg; mi; mi = parent_mem_cgroup(mi))
-					atomic_long_add(x, &mi->vmstats[i]);
+			if (x) {
+				atomic_long_add(x, &memcg->vmstats_local[i]);
+				for (mi = memcg; (mi = parent_mem_cgroup(mi)); )
+					atomic_long_add(x, &mi->vmstats_nested[i]);
+			}
 
 			if (i >= NR_VM_NODE_STAT_ITEMS)
 				continue;
@@ -2280,9 +2276,11 @@ static int memcg_hotplug_cpu_dead(unsigned int cpu)
 			long x;
 
 			x = this_cpu_xchg(memcg->vmstats_percpu->events[i], 0);
-			if (x)
-				for (mi = memcg; mi; mi = parent_mem_cgroup(mi))
-					atomic_long_add(x, &mi->vmevents[i]);
+			if (x) {
+				atomic_long_add(x, &memcg->vmevents_local[i]);
+				for (mi = memcg; (mi = parent_mem_cgroup(mi)); )
+					atomic_long_add(x, &mi->vmevents_nested[i]);
+			}
 		}
 	}
 
@@ -4085,7 +4083,8 @@ struct wb_domain *mem_cgroup_wb_domain(struct bdi_writeback *wb)
  */
 static unsigned long memcg_exact_page_state(struct mem_cgroup *memcg, int idx)
 {
-	long x = atomic_long_read(&memcg->vmstats[idx]);
+	long x = atomic_long_read(&memcg->vmstats_local[idx]) +
+		 atomic_long_read(&memcg->vmstats_nested[idx]);
 	int cpu;
 
 	for_each_online_cpu(cpu)
@@ -4638,7 +4637,6 @@ static void __mem_cgroup_free(struct mem_cgroup *memcg)
 	for_each_node(node)
 		free_mem_cgroup_per_node_info(memcg, node);
 	free_percpu(memcg->vmstats_percpu);
-	free_percpu(memcg->vmstats_local);
 	kfree(memcg);
 }
 
@@ -4667,10 +4665,6 @@ static struct mem_cgroup *mem_cgroup_alloc(void)
 	if (memcg->id.id < 0)
 		goto fail;
 
-	memcg->vmstats_local = alloc_percpu(struct memcg_vmstats_percpu);
-	if (!memcg->vmstats_local)
-		goto fail;
-
 	memcg->vmstats_percpu = alloc_percpu(struct memcg_vmstats_percpu);
 	if (!memcg->vmstats_percpu)
 		goto fail;

