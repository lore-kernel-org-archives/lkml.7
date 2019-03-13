Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77CE8C10F03
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 18:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 410D02147C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 18:40:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hjlmlrqo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbfCMSkP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 14:40:15 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45945 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727066AbfCMSkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 14:40:10 -0400
Received: by mail-pg1-f195.google.com with SMTP id 125so2112655pgc.12
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 11:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oYZ0d7IIZA63OVMPtucchTyEwGwVOr51nS/0GcejUsI=;
        b=hjlmlrqoyNqh8ZMDotoW00L/DiwAFvmdzuVBO5qEwnjoMnFwBtqz2v/L+DOuv1yKgE
         iFkL77zGQSG/AZc4wPNOQjIbqLrrRer/ITKaec1ZWBYULuL6i8fvKraEMqTdq1EMsv8o
         AgEdc2tWHxo31TIgegeSeM41gD89bZ7OO0hFTWtANImVHQnQsv00bzuBSO/ER/bycJeG
         ONJlxbJ8bQJwg2DEvUCj8jaI2x5boilM8pqZ2jIfebSy4iE4PwulXoZ7Hnt0r1zGorY4
         BXUk1VJpzHHRIOLVSc1IxnGoKFjConEDOx+EayzAIzbbZPedYCaEE3HhZNC/mu7TT5QH
         Yjpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oYZ0d7IIZA63OVMPtucchTyEwGwVOr51nS/0GcejUsI=;
        b=qqaqwD0s4FMHCdnuL9ge7oKBjMD4jIErVp5MuiXNl10/hE0XJ45sMsYGJK6Cxd6QQx
         gR+jnFtCNw4+uLYlGueCrBOpuTws6nyJVZf0xDzy2QYtw9/hlRfexACP9aSgRC9F0GtZ
         218c49i9oHpKU5qK4zpC+/HQ6R7Fwjfo5FmG9f1YfYdi1YaPwRaczvT2Fjv+hxo/Pvdx
         ORPyBh+QA6qP8fAPkrwrha2XjMWubm+Wma/F/OZYRbu4ijUqlHCPqj/KlJBruq0YPidf
         EB+ARuWQkL5CfxXYXldyVLL+xmbTeFh0L1St7wgZ8vKkzFUVf3KDU18Xn9mlqN8Je7+c
         aSDQ==
X-Gm-Message-State: APjAAAUqb6Q94CvgSCqvZr/2cDWZvlhFjMZL+gTJcsdC7fRxmgMFMCS+
        Dw3L0lkbi1/5mD11bCVa3A0=
X-Google-Smtp-Source: APXvYqwURWhkADd+qAQLVQN9HsSZU8WAqPGG3lUQMz73aqvzLNksvY2rMWiMAIlB7c+cWIpmfqzD0A==
X-Received: by 2002:a17:902:1621:: with SMTP id g30mr47029359plg.116.1552502408883;
        Wed, 13 Mar 2019 11:40:08 -0700 (PDT)
Received: from castle.hsd1.ca.comcast.net ([2603:3024:1704:3e00::d657])
        by smtp.gmail.com with ESMTPSA id i13sm15792562pgq.17.2019.03.13.11.40.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Mar 2019 11:40:07 -0700 (PDT)
From:   Roman Gushchin <guroan@gmail.com>
X-Google-Original-From: Roman Gushchin <guro@fb.com>
To:     linux-mm@kvack.org, kernel-team@fb.com
Cc:     linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, Roman Gushchin <guro@fb.com>
Subject: [PATCH v3 6/6] mm: refactor memcg_hotplug_cpu_dead() to use memcg_flush_offline_percpu()
Date:   Wed, 13 Mar 2019 11:39:53 -0700
Message-Id: <20190313183953.17854-7-guro@fb.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190313183953.17854-1-guro@fb.com>
References: <20190313183953.17854-1-guro@fb.com>
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
index 0f18bf2afea8..5b6a2ea66774 100644
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
+		memcg_flush_offline_percpu(memcg, cpumask_of(cpu));
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

