Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83BA1C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 22:34:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43CF72077B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 22:34:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lLhnV2bS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbfCLWeM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 18:34:12 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44499 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726280AbfCLWeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 18:34:10 -0400
Received: by mail-pg1-f194.google.com with SMTP id h34so2880001pgh.11
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 15:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CNCy2SGf01agfPIUoI0mNB3tC3JUsDAW7lCdNygAAfg=;
        b=lLhnV2bSVxytqXr7GTraMYKDSJWcLPf1AJ4jhxWyzW7riU8COKYEbht7n1aK3jzLua
         hZFskTIFmO4ddHn0VBmA7bYJ+lFl+SNXELhkeYW3fDi7ozLe48oYQd5x2azT3GpXXV73
         snsgq+EMuVdW43hSpU61qtsuGnlBNF5dIQo3wV/qA7depVjbEvySF6D3Y9URSlzsJRuS
         rgyqqo6yqBpRRcJIfcmjeY7+PbPOrCKCYDFZxdiMS7Vy6dY7/+R/r+L/x6Uc4M5/Ha8t
         72sE8kqCVR8ZTKGrKod1FJCx7fmZL0MPdyJ3c7ggY/ltDF658f3+SEPS+sbTl9bL6P84
         xIaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CNCy2SGf01agfPIUoI0mNB3tC3JUsDAW7lCdNygAAfg=;
        b=c5mWQ2JPhUzppPd/9KQbGT8qqKqeXuaODIXYSu94aGyM56NIY/5m3/IxHtc/e9khvv
         32Kqn3PY1vQGg4YPbqKgAHO9pxP4FOF30hlF1ijuonV2+X4Nb8uv9oZaIalvFDVmQQRB
         nXpnz9I1iIJn/8D6ZeUYEU422XNkCimrIAoJSc6Mc62fKNibscQ2SZVSP4CoTzLoQlnt
         BwtCNaPxNOB3jJwOmXPwLmaPGcBaF7r8Gi8NKwxPop07tdOQhJ5fPQ7/i2LxjQJU7KZY
         7DIgQDWud5qth30cCAN9Ijo8xj1RIOyir2mnHrcO3tAd1ND9YRW4BRT/j15faNQH5TNg
         7zFQ==
X-Gm-Message-State: APjAAAU/6O86WjXIuxk190Y+YMIp2jSHft0EGH4sjVIV7EaVhi6OzK7K
        TQcDA0z3aFcbq/vFkWtSawI=
X-Google-Smtp-Source: APXvYqyd55NWzBFVlPqDjX0SOkA4t3ShH69woO4U/IzykAEYfA+93dC952jtmZXrq8qIWhYCNo/o3w==
X-Received: by 2002:a63:dc4a:: with SMTP id f10mr6801954pgj.231.1552430049131;
        Tue, 12 Mar 2019 15:34:09 -0700 (PDT)
Received: from tower.thefacebook.com ([2620:10d:c090:200::1:3203])
        by smtp.gmail.com with ESMTPSA id i13sm14680592pfo.106.2019.03.12.15.34.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 15:34:08 -0700 (PDT)
From:   Roman Gushchin <guroan@gmail.com>
X-Google-Original-From: Roman Gushchin <guro@fb.com>
To:     linux-mm@kvack.org, kernel-team@fb.com
Cc:     linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, Roman Gushchin <guro@fb.com>
Subject: [PATCH v2 1/6] mm: prepare to premature release of memcg->vmstats_percpu
Date:   Tue, 12 Mar 2019 15:33:58 -0700
Message-Id: <20190312223404.28665-2-guro@fb.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190312223404.28665-1-guro@fb.com>
References: <20190312223404.28665-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare to handle premature release of memcg->vmstats_percpu data.
Currently it's a generic pointer which is expected to be non-NULL
during the whole life time of a memcg. Switch over to the
rcu-protected pointer, and carefully check it for being non-NULL.

This change is a required step towards dynamic premature release
of percpu memcg data.

Signed-off-by: Roman Gushchin <guro@fb.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
---
 include/linux/memcontrol.h | 40 +++++++++++++++++-------
 mm/memcontrol.c            | 62 +++++++++++++++++++++++++++++---------
 2 files changed, 77 insertions(+), 25 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 534267947664..05ca77767c6a 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -274,7 +274,7 @@ struct mem_cgroup {
 	struct task_struct	*move_lock_task;
 
 	/* memory.stat */
-	struct memcg_vmstats_percpu __percpu *vmstats_percpu;
+	struct memcg_vmstats_percpu __rcu /* __percpu */ *vmstats_percpu;
 
 	MEMCG_PADDING(_pad2_);
 
@@ -597,17 +597,26 @@ static inline unsigned long memcg_page_state(struct mem_cgroup *memcg,
 static inline void __mod_memcg_state(struct mem_cgroup *memcg,
 				     int idx, int val)
 {
+	struct memcg_vmstats_percpu __percpu *vmstats_percpu;
 	long x;
 
 	if (mem_cgroup_disabled())
 		return;
 
-	x = val + __this_cpu_read(memcg->vmstats_percpu->stat[idx]);
-	if (unlikely(abs(x) > MEMCG_CHARGE_BATCH)) {
-		atomic_long_add(x, &memcg->vmstats[idx]);
-		x = 0;
+	rcu_read_lock();
+	vmstats_percpu = (struct memcg_vmstats_percpu __percpu *)
+		rcu_dereference(memcg->vmstats_percpu);
+	if (likely(vmstats_percpu)) {
+		x = val + __this_cpu_read(vmstats_percpu->stat[idx]);
+		if (unlikely(abs(x) > MEMCG_CHARGE_BATCH)) {
+			atomic_long_add(x, &memcg->vmstats[idx]);
+			x = 0;
+		}
+		__this_cpu_write(vmstats_percpu->stat[idx], x);
+	} else {
+		atomic_long_add(val, &memcg->vmstats[idx]);
 	}
-	__this_cpu_write(memcg->vmstats_percpu->stat[idx], x);
+	rcu_read_unlock();
 }
 
 /* idx can be of type enum memcg_stat_item or node_stat_item */
@@ -740,17 +749,26 @@ static inline void __count_memcg_events(struct mem_cgroup *memcg,
 					enum vm_event_item idx,
 					unsigned long count)
 {
+	struct memcg_vmstats_percpu __percpu *vmstats_percpu;
 	unsigned long x;
 
 	if (mem_cgroup_disabled())
 		return;
 
-	x = count + __this_cpu_read(memcg->vmstats_percpu->events[idx]);
-	if (unlikely(x > MEMCG_CHARGE_BATCH)) {
-		atomic_long_add(x, &memcg->vmevents[idx]);
-		x = 0;
+	rcu_read_lock();
+	vmstats_percpu = (struct memcg_vmstats_percpu __percpu *)
+		rcu_dereference(memcg->vmstats_percpu);
+	if (likely(vmstats_percpu)) {
+		x = count + __this_cpu_read(vmstats_percpu->events[idx]);
+		if (unlikely(x > MEMCG_CHARGE_BATCH)) {
+			atomic_long_add(x, &memcg->vmevents[idx]);
+			x = 0;
+		}
+		__this_cpu_write(vmstats_percpu->events[idx], x);
+	} else {
+		atomic_long_add(count, &memcg->vmevents[idx]);
 	}
-	__this_cpu_write(memcg->vmstats_percpu->events[idx], x);
+	rcu_read_unlock();
 }
 
 static inline void count_memcg_events(struct mem_cgroup *memcg,
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index c532f8685aa3..803c772f354b 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -697,6 +697,8 @@ static void mem_cgroup_charge_statistics(struct mem_cgroup *memcg,
 					 struct page *page,
 					 bool compound, int nr_pages)
 {
+	struct memcg_vmstats_percpu __percpu *vmstats_percpu;
+
 	/*
 	 * Here, RSS means 'mapped anon' and anon's SwapCache. Shmem/tmpfs is
 	 * counted as CACHE even if it's on ANON LRU.
@@ -722,7 +724,12 @@ static void mem_cgroup_charge_statistics(struct mem_cgroup *memcg,
 		nr_pages = -nr_pages; /* for event */
 	}
 
-	__this_cpu_add(memcg->vmstats_percpu->nr_page_events, nr_pages);
+	rcu_read_lock();
+	vmstats_percpu = (struct memcg_vmstats_percpu __percpu *)
+		rcu_dereference(memcg->vmstats_percpu);
+	if (likely(vmstats_percpu))
+		__this_cpu_add(vmstats_percpu->nr_page_events, nr_pages);
+	rcu_read_unlock();
 }
 
 unsigned long mem_cgroup_node_nr_lru_pages(struct mem_cgroup *memcg,
@@ -756,10 +763,18 @@ static unsigned long mem_cgroup_nr_lru_pages(struct mem_cgroup *memcg,
 static bool mem_cgroup_event_ratelimit(struct mem_cgroup *memcg,
 				       enum mem_cgroup_events_target target)
 {
+	struct memcg_vmstats_percpu __percpu *vmstats_percpu;
 	unsigned long val, next;
+	bool ret = false;
 
-	val = __this_cpu_read(memcg->vmstats_percpu->nr_page_events);
-	next = __this_cpu_read(memcg->vmstats_percpu->targets[target]);
+	rcu_read_lock();
+	vmstats_percpu = (struct memcg_vmstats_percpu __percpu *)
+		rcu_dereference(memcg->vmstats_percpu);
+	if (!vmstats_percpu)
+		goto out;
+
+	val = __this_cpu_read(vmstats_percpu->nr_page_events);
+	next = __this_cpu_read(vmstats_percpu->targets[target]);
 	/* from time_after() in jiffies.h */
 	if ((long)(next - val) < 0) {
 		switch (target) {
@@ -775,10 +790,12 @@ static bool mem_cgroup_event_ratelimit(struct mem_cgroup *memcg,
 		default:
 			break;
 		}
-		__this_cpu_write(memcg->vmstats_percpu->targets[target], next);
-		return true;
+		__this_cpu_write(vmstats_percpu->targets[target], next);
+		ret = true;
 	}
-	return false;
+out:
+	rcu_read_unlock();
+	return ret;
 }
 
 /*
@@ -2104,22 +2121,29 @@ static void drain_all_stock(struct mem_cgroup *root_memcg)
 
 static int memcg_hotplug_cpu_dead(unsigned int cpu)
 {
+	struct memcg_vmstats_percpu __percpu *vmstats_percpu;
 	struct memcg_stock_pcp *stock;
 	struct mem_cgroup *memcg;
 
 	stock = &per_cpu(memcg_stock, cpu);
 	drain_stock(stock);
 
+	rcu_read_lock();
 	for_each_mem_cgroup(memcg) {
 		int i;
 
+		vmstats_percpu = (struct memcg_vmstats_percpu __percpu *)
+			rcu_dereference(memcg->vmstats_percpu);
+
 		for (i = 0; i < MEMCG_NR_STAT; i++) {
 			int nid;
 			long x;
 
-			x = this_cpu_xchg(memcg->vmstats_percpu->stat[i], 0);
-			if (x)
-				atomic_long_add(x, &memcg->vmstats[i]);
+			if (vmstats_percpu) {
+				x = this_cpu_xchg(vmstats_percpu->stat[i], 0);
+				if (x)
+					atomic_long_add(x, &memcg->vmstats[i]);
+			}
 
 			if (i >= NR_VM_NODE_STAT_ITEMS)
 				continue;
@@ -2137,11 +2161,14 @@ static int memcg_hotplug_cpu_dead(unsigned int cpu)
 		for (i = 0; i < NR_VM_EVENT_ITEMS; i++) {
 			long x;
 
-			x = this_cpu_xchg(memcg->vmstats_percpu->events[i], 0);
-			if (x)
-				atomic_long_add(x, &memcg->vmevents[i]);
+			if (vmstats_percpu) {
+				x = this_cpu_xchg(vmstats_percpu->events[i], 0);
+				if (x)
+					atomic_long_add(x, &memcg->vmevents[i]);
+			}
 		}
 	}
+	rcu_read_unlock();
 
 	return 0;
 }
@@ -4464,7 +4491,8 @@ static struct mem_cgroup *mem_cgroup_alloc(void)
 	if (memcg->id.id < 0)
 		goto fail;
 
-	memcg->vmstats_percpu = alloc_percpu(struct memcg_vmstats_percpu);
+	rcu_assign_pointer(memcg->vmstats_percpu,
+			   alloc_percpu(struct memcg_vmstats_percpu));
 	if (!memcg->vmstats_percpu)
 		goto fail;
 
@@ -6054,6 +6082,7 @@ static void uncharge_batch(const struct uncharge_gather *ug)
 {
 	unsigned long nr_pages = ug->nr_anon + ug->nr_file + ug->nr_kmem;
 	unsigned long flags;
+	struct memcg_vmstats_percpu __percpu *vmstats_percpu;
 
 	if (!mem_cgroup_is_root(ug->memcg)) {
 		page_counter_uncharge(&ug->memcg->memory, nr_pages);
@@ -6070,7 +6099,12 @@ static void uncharge_batch(const struct uncharge_gather *ug)
 	__mod_memcg_state(ug->memcg, MEMCG_RSS_HUGE, -ug->nr_huge);
 	__mod_memcg_state(ug->memcg, NR_SHMEM, -ug->nr_shmem);
 	__count_memcg_events(ug->memcg, PGPGOUT, ug->pgpgout);
-	__this_cpu_add(ug->memcg->vmstats_percpu->nr_page_events, nr_pages);
+	rcu_read_lock();
+	vmstats_percpu = (struct memcg_vmstats_percpu __percpu *)
+		rcu_dereference(ug->memcg->vmstats_percpu);
+	if (likely(vmstats_percpu))
+		__this_cpu_add(vmstats_percpu->nr_page_events, nr_pages);
+	rcu_read_unlock();
 	memcg_check_events(ug->memcg, ug->dummy_page);
 	local_irq_restore(flags);
 
-- 
2.20.1

