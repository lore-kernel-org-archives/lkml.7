Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F7F7C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 22:34:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 558132077B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 22:34:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k7QPsFLm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727216AbfCLWe1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 18:34:27 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35074 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726921AbfCLWeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 18:34:17 -0400
Received: by mail-pg1-f195.google.com with SMTP id e17so14592pgd.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 15:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PLL/4LfAnZv9OSID2l2Kyrqdn4GFKp657vXZGXPSxO0=;
        b=k7QPsFLmc+eBwxBeIp3C8Q/G3nJeZYxu7XnCay7LwQzvYDlcex8ZmzvLEALm8Ne5rw
         SLlbWdGCJNNNylqAovxOpBlwHo49mZQmWXeGGDXwyl+jLrKRlypwlZLICtOsya6U8/88
         ks2uXUfUmxVwbCUqjNelbhwLdaTnFwnlcnHLdIhCFHmh3+XU5EdrQpfzjqb28c/31aEh
         MWgHKZOniE/gg/g/aN3rT2rpFpy6or34LenQ6dTPqDklOxnQM6FsOdnsHRZ5GK6LSJxr
         VikGyXRKTXAJblZ/1TJmD13Dvb2uX0PrEt3TBBMrq/zR0FyJPp5nDwvQQHtrumlswmgj
         UotQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PLL/4LfAnZv9OSID2l2Kyrqdn4GFKp657vXZGXPSxO0=;
        b=ncUgHfjtaL2m5EDV2IIo3qXE2U4gwrD3DW8EtbyQZs/rrFLQygpu7vyg9CL0xIkle0
         6KlC5JnuHuM2aSe/d5X1mQd8FffhFW2LU0//FZk0MR7cIZ/ToC5RDjdmZrLgqnFAlFLk
         lvUevDPdfeUIuwC+wSNYR4WAkr7L2TJTzIr5cpgDswDLQ652juTwtz4qLcyRYaa9VMaf
         uM+Uyq8XVkw54c8+gZDvUIdmGkYwLc7i+djW9/rovl/JCimNsu15y59Bgp++dXswGeEh
         eYSb3Jri4z+zwP1AXwXT+IbBu+VsE+i6is0qVtQZYBADxb/OFaNlmbzqEK8Bd3eJmkz1
         jTGQ==
X-Gm-Message-State: APjAAAUTBPy7vejZlOL75IWdi25xWyWZ4+KU+W8tbMR+AVaf1kg58cH5
        3v4RRmRtYRYfCFkCyird/1U=
X-Google-Smtp-Source: APXvYqzMJr1pK4nMS01UgtE1/G7AaJ3jZ+2slx1gvSttry8dUdcDTbmwyNqFCWr4j4KvJIjGUZ1mbQ==
X-Received: by 2002:a17:902:2bc7:: with SMTP id l65mr42472606plb.79.1552430056682;
        Tue, 12 Mar 2019 15:34:16 -0700 (PDT)
Received: from tower.thefacebook.com ([2620:10d:c090:200::1:3203])
        by smtp.gmail.com with ESMTPSA id i13sm14680592pfo.106.2019.03.12.15.34.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 15:34:16 -0700 (PDT)
From:   Roman Gushchin <guroan@gmail.com>
X-Google-Original-From: Roman Gushchin <guro@fb.com>
To:     linux-mm@kvack.org, kernel-team@fb.com
Cc:     linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, Roman Gushchin <guro@fb.com>
Subject: [PATCH v2 6/6] mm: refactor memcg_hotplug_cpu_dead() to use memcg_flush_offline_percpu()
Date:   Tue, 12 Mar 2019 15:34:04 -0700
Message-Id: <20190312223404.28665-8-guro@fb.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190312223404.28665-1-guro@fb.com>
References: <20190312223404.28665-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's possible to remove a big chunk of the redundant code by making
memcg_flush_offline_percpu() to take cpumask as an argument and flush
percpu data on all cpus belonging to the mask instead of all possible cpus.

Then memcg_hotplug_cpu_dead() can call it with a single CPU bit set.

This approach allows to remove all duplicated code, but safe the
performance optimization made in memcg_flush_offline_percpu():
only one atomic operation per data entry.

for_each_data_entry()
	for_each_cpu(cpu. cpumask)
		sum_events()
	flush()

Otherwise it would be one atomic operation per data entry per cpu:
for_each_cpu(cpu)
	for_each_data_entry()
		flush()

Signed-off-by: Roman Gushchin <guro@fb.com>
---
 mm/memcontrol.c | 61 ++++++++-----------------------------------------
 1 file changed, 9 insertions(+), 52 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 0f18bf2afea8..92c80275d5eb 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2122,11 +2122,12 @@ static void drain_all_stock(struct mem_cgroup *root_memcg)
 /*
  * Flush all per-cpu stats and events into atomics.
  * Try to minimize the number of atomic writes by gathering data from
- * all cpus locally, and then make one atomic update.
+ * all cpus in cpumask locally, and then make one atomic update.
  * No locking is required, because no one has an access to
  * the offlined percpu data.
  */
-static void memcg_flush_offline_percpu(struct mem_cgroup *memcg)
+static void memcg_flush_offline_percpu(struct mem_cgroup *memcg,
+				       const struct cpumask *cpumask)
 {
 	struct memcg_vmstats_percpu __percpu *vmstats_percpu;
 	struct lruvec_stat __percpu *lruvec_stat_cpu;
@@ -2140,7 +2141,7 @@ static void memcg_flush_offline_percpu(struct mem_cgroup *memcg)
 		int nid;
 
 		x = 0;
-		for_each_possible_cpu(cpu)
+		for_each_cpu(cpu, cpumask)
 			x += per_cpu(vmstats_percpu->stat[i], cpu);
 		if (x)
 			atomic_long_add(x, &memcg->vmstats[i]);
@@ -2153,7 +2154,7 @@ static void memcg_flush_offline_percpu(struct mem_cgroup *memcg)
 			lruvec_stat_cpu = pn->lruvec_stat_cpu_offlined;
 
 			x = 0;
-			for_each_possible_cpu(cpu)
+			for_each_cpu(cpu, cpumask)
 				x += per_cpu(lruvec_stat_cpu->count[i], cpu);
 			if (x)
 				atomic_long_add(x, &pn->lruvec_stat[i]);
@@ -2162,7 +2163,7 @@ static void memcg_flush_offline_percpu(struct mem_cgroup *memcg)
 
 	for (i = 0; i < NR_VM_EVENT_ITEMS; i++) {
 		x = 0;
-		for_each_possible_cpu(cpu)
+		for_each_cpu(cpu, cpumask)
 			x += per_cpu(vmstats_percpu->events[i], cpu);
 		if (x)
 			atomic_long_add(x, &memcg->vmevents[i]);
@@ -2171,8 +2172,6 @@ static void memcg_flush_offline_percpu(struct mem_cgroup *memcg)
 
 static int memcg_hotplug_cpu_dead(unsigned int cpu)
 {
-	struct memcg_vmstats_percpu __percpu *vmstats_percpu;
-	struct lruvec_stat __percpu *lruvec_stat_cpu;
 	struct memcg_stock_pcp *stock;
 	struct mem_cgroup *memcg;
 
@@ -2180,50 +2179,8 @@ static int memcg_hotplug_cpu_dead(unsigned int cpu)
 	drain_stock(stock);
 
 	rcu_read_lock();
-	for_each_mem_cgroup(memcg) {
-		int i;
-
-		vmstats_percpu = (struct memcg_vmstats_percpu __percpu *)
-			rcu_dereference(memcg->vmstats_percpu);
-
-		for (i = 0; i < MEMCG_NR_STAT; i++) {
-			int nid;
-			long x;
-
-			if (vmstats_percpu) {
-				x = this_cpu_xchg(vmstats_percpu->stat[i], 0);
-				if (x)
-					atomic_long_add(x, &memcg->vmstats[i]);
-			}
-
-			if (i >= NR_VM_NODE_STAT_ITEMS)
-				continue;
-
-			for_each_node(nid) {
-				struct mem_cgroup_per_node *pn;
-
-				pn = mem_cgroup_nodeinfo(memcg, nid);
-
-				lruvec_stat_cpu = (struct lruvec_stat __percpu*)
-					rcu_dereference(pn->lruvec_stat_cpu);
-				if (!lruvec_stat_cpu)
-					continue;
-				x = this_cpu_xchg(lruvec_stat_cpu->count[i], 0);
-				if (x)
-					atomic_long_add(x, &pn->lruvec_stat[i]);
-			}
-		}
-
-		for (i = 0; i < NR_VM_EVENT_ITEMS; i++) {
-			long x;
-
-			if (vmstats_percpu) {
-				x = this_cpu_xchg(vmstats_percpu->events[i], 0);
-				if (x)
-					atomic_long_add(x, &memcg->vmevents[i]);
-			}
-		}
-	}
+	for_each_mem_cgroup(memcg)
+		memcg_flush_offline_percpu(memcg, get_cpu_mask(cpu));
 	rcu_read_unlock();
 
 	return 0;
@@ -4668,7 +4625,7 @@ static void percpu_rcu_free(struct rcu_head *rcu)
 	struct mem_cgroup *memcg = container_of(rcu, struct mem_cgroup, rcu);
 	int node;
 
-	memcg_flush_offline_percpu(memcg);
+	memcg_flush_offline_percpu(memcg, cpu_possible_mask);
 
 	for_each_node(node) {
 		struct mem_cgroup_per_node *pn = memcg->nodeinfo[node];
-- 
2.20.1

