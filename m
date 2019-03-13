Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0CF8C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 18:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C394720693
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 18:40:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sj7e7KrT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbfCMSkM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 14:40:12 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39223 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727050AbfCMSkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 14:40:08 -0400
Received: by mail-pf1-f195.google.com with SMTP id i20so1992327pfo.6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 11:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2cvW24YvYXEUFU3KxBgLfjLN1zP9HeM/T5I/fane4LI=;
        b=Sj7e7KrTxGgjBtBVwW3+pppFo1OluqFpgx9p+e0I2eslI0IX76GxI56FyMr0Ujn61G
         n1uwAi30e7xrRWMomWR9vdILS1jqnjUhGAy5SN5E3wk3gci8ouk2KGOxzM091kLH4psW
         caD1lAzHKoQUdqLU0neRW1iZ+UbJuolybIwG/RnT0S4Bf6qnocRv8R4aDfhhWpIcz/N2
         VHXy5jPc34xUBgtkCA5Unh9g/nR69Htojaxs8hmdEN6sLd9DHj0vmv0f4bCjQYcTmKc1
         pht4bgTrWHV8QEdJqc3QEU56m6n+9htJvRLPcJWs6IpSra+W7soIv9swTAFQo2B7cjbw
         gkpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2cvW24YvYXEUFU3KxBgLfjLN1zP9HeM/T5I/fane4LI=;
        b=ldPwCwSgNEipqZAwSBj4Is+uPHsoqLUM+KDpQBzxh6Yk64cpq/rLqL2+0pA2Jgs5CZ
         ax/5XHxSpITyhe/8jNPUkoear8DcPEa4k3CNXOIkCYwem1ZGKcdpFrT+CQS3pa5IqMbX
         h+HO5Of7X+L5hpa3L+YD4DgUtBFUWOJ5rYbIfylWbaPSl1dX9mWHkmJX8mMQw68jPOyo
         VI9+N8IVNvAMCAUoBYMBzAKB9PTPoFfzsLJS0qSweeu5lhXI3rxRZf8hJqlXW+CBHT+W
         179KdhU3qbfnbZlAcciNESj3dRNW7/yDf1oNQvwf8z+XTU4rCywJpvh0W+UHsBHOLLYL
         ZisQ==
X-Gm-Message-State: APjAAAUAewTcwImIaVVZPd6nYHoIj7pc7wpg09cSdnEIs5wxpNTW5WPU
        /2QTautu0/CUoLqaj4e9fKI=
X-Google-Smtp-Source: APXvYqxN6T26cpU/i7gJrXRMqYa2D+TtQXlmh9inTy8ofpUF4HZSJ/PCcVKIq40FliL0BRe0lBbtlw==
X-Received: by 2002:a17:902:bd97:: with SMTP id q23mr45933336pls.94.1552502407449;
        Wed, 13 Mar 2019 11:40:07 -0700 (PDT)
Received: from castle.hsd1.ca.comcast.net ([2603:3024:1704:3e00::d657])
        by smtp.gmail.com with ESMTPSA id i13sm15792562pgq.17.2019.03.13.11.40.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Mar 2019 11:40:06 -0700 (PDT)
From:   Roman Gushchin <guroan@gmail.com>
X-Google-Original-From: Roman Gushchin <guro@fb.com>
To:     linux-mm@kvack.org, kernel-team@fb.com
Cc:     linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, Roman Gushchin <guro@fb.com>
Subject: [PATCH v3 5/6] mm: flush memcg percpu stats and events before releasing
Date:   Wed, 13 Mar 2019 11:39:52 -0700
Message-Id: <20190313183953.17854-6-guro@fb.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190313183953.17854-1-guro@fb.com>
References: <20190313183953.17854-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Flush percpu stats and events data to corresponding before releasing
percpu memory.

Although per-cpu stats are never exactly precise, dropping them on
floor regularly may lead to an accumulation of an error. So, it's
safer to flush them before releasing.

To minimize the number of atomic updates, let's sum all stats/events
on all cpus locally, and then make a single update per entry.

Signed-off-by: Roman Gushchin <guro@fb.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/memcontrol.c | 52 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 1b5fe826d6d0..0f18bf2afea8 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2119,6 +2119,56 @@ static void drain_all_stock(struct mem_cgroup *root_memcg)
 	mutex_unlock(&percpu_charge_mutex);
 }
 
+/*
+ * Flush all per-cpu stats and events into atomics.
+ * Try to minimize the number of atomic writes by gathering data from
+ * all cpus locally, and then make one atomic update.
+ * No locking is required, because no one has an access to
+ * the offlined percpu data.
+ */
+static void memcg_flush_offline_percpu(struct mem_cgroup *memcg)
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
 static int memcg_hotplug_cpu_dead(unsigned int cpu)
 {
 	struct memcg_vmstats_percpu __percpu *vmstats_percpu;
@@ -4618,6 +4668,8 @@ static void percpu_rcu_free(struct rcu_head *rcu)
 	struct mem_cgroup *memcg = container_of(rcu, struct mem_cgroup, rcu);
 	int node;
 
+	memcg_flush_offline_percpu(memcg);
+
 	for_each_node(node) {
 		struct mem_cgroup_per_node *pn = memcg->nodeinfo[node];
 
-- 
2.20.1

