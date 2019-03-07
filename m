Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B11BAC10F0D
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 23:00:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B61A2087C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 23:00:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xm1kKMC9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbfCGXAs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 18:00:48 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37168 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726243AbfCGXAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 18:00:43 -0500
Received: by mail-pg1-f195.google.com with SMTP id q206so12460645pgq.4
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 15:00:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JZX5VXWRV31e/dorMIyOAZjwZx1Lnus1V/4dOHz/P7o=;
        b=Xm1kKMC9B2w4t88wFEbcqoH6e3UjYFTd0TJSqsFikzco+7ogxo96EX0nP16sMJbA/D
         LLSVBZJBDEz2s/pXjjVn9UsVgWRbZVxLUbIf2ptRACQNUAGqUprEX6a1DRinHKw5cqeA
         saSPrh0ac7GIbDXM2tqBY5JabMVeKZK5pq2AM6gHHd2NgUEUM5jV35C6N+sm6BhlMSik
         OrbKHp1PzKc/8Lqk+TeUJEZBxlxgSWd6IjScBzR+zqvggjmPRH3lsIVbl0hk5XRSCeMU
         7HEsMpuv84maXQ4wCXQUhIkvGmgg1GgNgoeCuvcEah9F6lF2KaEUozcRhvJrkXRIRfs3
         bBLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JZX5VXWRV31e/dorMIyOAZjwZx1Lnus1V/4dOHz/P7o=;
        b=iW7hdtCuiYmlHJWLQ4v1rTP13R5F/MKmqD7h/MCL5WcvCl3t/aoQetwM0TAMHl9Ku7
         4w4Y+0cYC8/ZHyHJX5gU0rC8X0qG8GxncFKHq3aFFRNIzUwYdkC6OT38Zvz5gb/JcY6c
         XDnyW6Mj6dY+9akUNMN7JRWYnX/hYKcj3Xaf1zKkSMsgJGXH5R7h8IjVzKoTVZ4FNsRy
         2UhM45jHmDta9rC/G0TULqa8D0dasbAgdGQDbFRQGg1zR2aOXu3cq9tvOiZILogbHHN6
         bnahb84dcq3cFXA3ri7mzDuey8zEiuo/P8aPoOQPNLmc8vyx3xjBiaRmViabhp6WWbW/
         29kQ==
X-Gm-Message-State: APjAAAXWlTX4fR13isevRPSa/b9xPyjKykyPaikWvbeRlr5aiiY0tL73
        aGp9dEpyQ8nCpFx6nRyVkoE=
X-Google-Smtp-Source: APXvYqyQ0WlWO2ShjokCb1rn3KTI4g8tpX1+qir97KWkQkaWwmJJtvRCFS7kkyFXX+SvJ87Cs4JUAQ==
X-Received: by 2002:a63:8b42:: with SMTP id j63mr13351207pge.79.1551999642755;
        Thu, 07 Mar 2019 15:00:42 -0800 (PST)
Received: from tower.thefacebook.com ([2620:10d:c090:200::2:d18b])
        by smtp.gmail.com with ESMTPSA id i126sm11864806pfb.15.2019.03.07.15.00.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Mar 2019 15:00:42 -0800 (PST)
From:   Roman Gushchin <guroan@gmail.com>
X-Google-Original-From: Roman Gushchin <guro@fb.com>
To:     linux-mm@kvack.org, kernel-team@fb.com
Cc:     linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, Roman Gushchin <guro@fb.com>
Subject: [PATCH 5/5] mm: spill memcg percpu stats and events before releasing
Date:   Thu,  7 Mar 2019 15:00:33 -0800
Message-Id: <20190307230033.31975-6-guro@fb.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190307230033.31975-1-guro@fb.com>
References: <20190307230033.31975-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Spill percpu stats and events data to corresponding before releasing
percpu memory.

Although per-cpu stats are never exactly precise, dropping them on
floor regularly may lead to an accumulation of an error. So, it's
safer to sync them before releasing.

To minimize the number of atomic updates, let's sum all stats/events
on all cpus locally, and then make a single update per entry.

Signed-off-by: Roman Gushchin <guro@fb.com>
---
 mm/memcontrol.c | 52 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 18e863890392..b7eb6fac735e 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4612,11 +4612,63 @@ static int mem_cgroup_css_online(struct cgroup_subsys_state *css)
 	return 0;
 }
 
+/*
+ * Spill all per-cpu stats and events into atomics.
+ * Try to minimize the number of atomic writes by gathering data from
+ * all cpus locally, and then make one atomic update.
+ * No locking is required, because no one has an access to
+ * the offlined percpu data.
+ */
+static void mem_cgroup_spill_offlined_percpu(struct mem_cgroup *memcg)
+{
+	struct memcg_vmstats_percpu __percpu *vmstats_percpu;
+	struct lruvec_stat __percpu *lruvec_stat_cpu;
+	struct mem_cgroup_per_node *pn;
+	int cpu, i;
+	long x;
+
+	vmstats_percpu = memcg->vmstats_percpu_offlined;
+
+	for (i = 0; i < MEMCG_NR_STAT; i++) {
+		int nid;
+
+		x = 0;
+		for_each_possible_cpu(cpu)
+			x += per_cpu(vmstats_percpu->stat[i], cpu);
+		if (x)
+			atomic_long_add(x, &memcg->vmstats[i]);
+
+		if (i >= NR_VM_NODE_STAT_ITEMS)
+			continue;
+
+		for_each_node(nid) {
+			pn = mem_cgroup_nodeinfo(memcg, nid);
+			lruvec_stat_cpu = pn->lruvec_stat_cpu_offlined;
+
+			x = 0;
+			for_each_possible_cpu(cpu)
+				x += per_cpu(lruvec_stat_cpu->count[i], cpu);
+			if (x)
+				atomic_long_add(x, &pn->lruvec_stat[i]);
+		}
+	}
+
+	for (i = 0; i < NR_VM_EVENT_ITEMS; i++) {
+		x = 0;
+		for_each_possible_cpu(cpu)
+			x += per_cpu(vmstats_percpu->events[i], cpu);
+		if (x)
+			atomic_long_add(x, &memcg->vmevents[i]);
+	}
+}
+
 static void mem_cgroup_free_percpu(struct rcu_head *rcu)
 {
 	struct mem_cgroup *memcg = container_of(rcu, struct mem_cgroup, rcu);
 	int node;
 
+	mem_cgroup_spill_offlined_percpu(memcg);
+
 	for_each_node(node) {
 		struct mem_cgroup_per_node *pn = memcg->nodeinfo[node];
 
-- 
2.20.1

