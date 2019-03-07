Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1927DC10F03
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 23:00:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C228020851
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 23:00:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V2nhvsUU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbfCGXAk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 18:00:40 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39437 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726243AbfCGXAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 18:00:39 -0500
Received: by mail-pf1-f194.google.com with SMTP id i20so12601804pfo.6
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 15:00:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2zD5nbQljCuVZEpjxLRZoYsTQjqMS5l1KBU8Q+Sdfe8=;
        b=V2nhvsUUyX9TXoESjQOB5eMsm4xQAzZMmf0SgpDQU7WMnu5kBdLHv4JgEV90jf5GaP
         uLrVJnKQZ8gCQy3lXQGbFxG1kH6Z73WBa/x9i686DxKP3jrlEbvTTwherxEuLZByWTzX
         nadisGvGx7A5xom2xCSmhRoOfxmH8wlh5mbXW6Hg3mlOTrGa45fdNr1Ippn1B2ZD2QpU
         VC0ELQPKCVT6Wan0Qj5xK8EZevASG2q8+5N/HDZ8/O6H7arZTtoWzTyiGhyBwggpbdid
         /n/RTPzgam2gKExM2V7cwQSMLg41yt45EO4w/irg/VubtzXAhB5+O97LteDwWzCzNe9A
         WVTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2zD5nbQljCuVZEpjxLRZoYsTQjqMS5l1KBU8Q+Sdfe8=;
        b=c5qXnXYrMU3n2EqvXb60h2jNlhMWEtuNGMl0zxMUEAyE3gn3RBAynTLUOwWsmdzlN8
         rjwa+xD+TPw8zGlQEfMJlUaBTx90fkn0OMj6WxEATrF48FXuJHDYLKZZDCzHpEd4lXUd
         K2TvHoWlzXwhLmNKzBaPoAmpbFbszw/vkxJIAp+709naIVBpPgioANkyhoeTUqJT0d+d
         4ysTIw7BYbplhFFi8rarH6JiPBFkgOCDXA+A888p1hwuIZaZDKcpgxCw/zskeEMkowIo
         9qTblxA2KUcDonCJniaoJG3F9PXuo6v5qmCm6B3xm9a7onTMzCXHm3R9ChLC+MsqP3uq
         1vTQ==
X-Gm-Message-State: APjAAAUhcamiNjyRuG/IVoYhlIhXbV66+7m2KmyxM6HTwYsnKYLiVFoT
        Fr2S+HJRuNAdG1paQc06DSY=
X-Google-Smtp-Source: APXvYqx/NgILDTTJRVUsh55o+xNSO6KhGs1zskXimET2dZyUOOxDdBosr71+ch0fXmf8EM8Wuep8xA==
X-Received: by 2002:a65:4243:: with SMTP id d3mr13633502pgq.56.1551999638120;
        Thu, 07 Mar 2019 15:00:38 -0800 (PST)
Received: from tower.thefacebook.com ([2620:10d:c090:200::2:d18b])
        by smtp.gmail.com with ESMTPSA id i126sm11864806pfb.15.2019.03.07.15.00.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Mar 2019 15:00:37 -0800 (PST)
From:   Roman Gushchin <guroan@gmail.com>
X-Google-Original-From: Roman Gushchin <guro@fb.com>
To:     linux-mm@kvack.org, kernel-team@fb.com
Cc:     linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, Roman Gushchin <guro@fb.com>
Subject: [PATCH 1/5] mm: prepare to premature release of memcg->vmstats_percpu
Date:   Thu,  7 Mar 2019 15:00:29 -0800
Message-Id: <20190307230033.31975-2-guro@fb.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190307230033.31975-1-guro@fb.com>
References: <20190307230033.31975-1-guro@fb.com>
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

