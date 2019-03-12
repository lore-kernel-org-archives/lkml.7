Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 060C3C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 22:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C69C52077B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 22:34:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kPvcG3sz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbfCLWeU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 18:34:20 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45293 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727031AbfCLWeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 18:34:16 -0400
Received: by mail-pg1-f194.google.com with SMTP id 125so2878560pgc.12
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 15:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JZX5VXWRV31e/dorMIyOAZjwZx1Lnus1V/4dOHz/P7o=;
        b=kPvcG3sz1oIMN+A5deEm4FkV/2Og21S/ZdzmlBgWCta1VoPocpURg5BTxxL66IPeGW
         KebfneTeQknBMcv0RIODkHuIJ26KPqoOKTxWylOx80IgIWFxLgY+F7NNbYkjXL/u42EP
         48K9fomPliCJxLp2CCvydxaRJ+MEH6B9Txe++8T7+1tbAK/Nh+xfThDUNjxeYlOv+7O8
         e3jWD8BZTDObwiZvbqGhtTnRyjwIn+HA8OHG0nTDXsmHXpsbX1I/CDAJL9kE9Peb1PK4
         wA0iNVQ3Cai5d5t2+VGgnJgjCVY6fQkOLEOWIu/d6Uy/hAmr4kaNQrNCGCx9g9u9l2bI
         ZHqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JZX5VXWRV31e/dorMIyOAZjwZx1Lnus1V/4dOHz/P7o=;
        b=s7elVbFsfJeZoE0HjJLcmF5l8nfs3aCmwBxu42y/skzBcaC59Xhxd/TEs8WMIGiiku
         ICkMQH9MekzlcXa+KRMP0RShcT+kSo2o3DjPENM5gn5VETE/nh68c4lXU0vFQOXDe33o
         /fTGUIiwzMjKs4qJeb7eIFa80VswPXRM+jDxGn3902Dp24rFssLSeE3XIUv+3PAyMYj4
         qpEnPRrSbHwnygAmGPsFnXzWHjnBXkTB3hlx6RzOXYDs7yACbTTlt6i56r+hvahFYGIG
         4zMRp1yWyV9M+AzlDG2D2hucSaF22JC/Bv/Pkw0M8ZCWGT5htca4zWMTKkJpIRWQ8uyj
         B4Dw==
X-Gm-Message-State: APjAAAXH71YhZZRTJZEGlZulr8cQRFrXh0l9lBIxiqu90r+nT51B8zPy
        T8ouS3FtK0wKRXn4jDEaS+k=
X-Google-Smtp-Source: APXvYqzD1PVjUf4iM9o/YE+Z9nZ4TfeCb+Wf1JEL8VMwvOoex1fD36Y17trO1RbFs/TmANuws+r/Lg==
X-Received: by 2002:a17:902:8c8a:: with SMTP id t10mr5501547plo.160.1552430055663;
        Tue, 12 Mar 2019 15:34:15 -0700 (PDT)
Received: from tower.thefacebook.com ([2620:10d:c090:200::1:3203])
        by smtp.gmail.com with ESMTPSA id i13sm14680592pfo.106.2019.03.12.15.34.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 15:34:14 -0700 (PDT)
From:   Roman Gushchin <guroan@gmail.com>
X-Google-Original-From: Roman Gushchin <guro@fb.com>
To:     linux-mm@kvack.org, kernel-team@fb.com
Cc:     linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, Roman Gushchin <guro@fb.com>
Subject: [PATCH 5/5] mm: spill memcg percpu stats and events before releasing
Date:   Tue, 12 Mar 2019 15:34:03 -0700
Message-Id: <20190312223404.28665-7-guro@fb.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190312223404.28665-1-guro@fb.com>
References: <20190312223404.28665-1-guro@fb.com>
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

