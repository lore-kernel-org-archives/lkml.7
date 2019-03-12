Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 716F3C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 22:34:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 401B5217D8
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 22:34:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jrtS3ovn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbfCLWef (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 18:34:35 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38675 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726280AbfCLWeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 18:34:13 -0400
Received: by mail-pf1-f196.google.com with SMTP id n125so2862901pfn.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 15:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZKgL4zeK+z0St01hNMYKSt6dKMvw92MkjAHduvDs3M4=;
        b=jrtS3ovnWaLclOmLoRw34CUAd+9ENpw1XWtfnLUP1GL2O+JypA4+PCOxzdusoMOk42
         MwG2QHBlvBDAahr7Py5iS1cPYcTR4sq6AHI1i7JxSrfe4Z193iZBEtTWyzzO5M/qeVh8
         y/5CRZ5bEQz7MH/ith0ogencVWwi/1sVtcswJ1X1i7uv6w689GJCGWNslFK0fan/knST
         Evo9ANJxmGdHkfNod5kaooDNe8L3Wnrvb215MwDQyPp9a6tvADnANRyz4q1sEuM5r9Gt
         Xmd1TzZfc/2bDNGBzFEqgP3VGvUWq+PFL50UCQgdo9wcjoPw7/LplLb/nOt9Xy/gnxY3
         svCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZKgL4zeK+z0St01hNMYKSt6dKMvw92MkjAHduvDs3M4=;
        b=q6hrPhaz77vMzalmyAWiFDmlTnTyQLXBBerJv8w11X+6nW0/6nmxSgCwgRqB/nEfr2
         n9FoYPDO6HYda7hj6nwOvbjyEwnpgqcE4fJ/s4twBlY/OF/bFSpZTKw2XcpxkJvjZmqK
         PtQ2/dB77Xy/sZaew8CiH2q0nJ02PSOMyDpvj6uBSfC/QRbinBEKqoTNpMm5OVidM4IU
         YfPZtGczQ/spfdLf63V6eZTtjNz1C+Ey2qiaRyF3oFBqLEeLOrleLQJ9locPBnUsH/Gy
         jOLocra/wOMlvXKrChlY6eR2Ox+2UzdKIpTN25Tas4MJ3Z8QvPPDj2cF/87dCuho+WXC
         XZMw==
X-Gm-Message-State: APjAAAWOXmZIlrlVUd9Mij7THOHHUdtaiZBS4KBQf5kqksMpDRjd4jSP
        WwjVmzcBPd4IIj36vFAezmI=
X-Google-Smtp-Source: APXvYqyS8FSfyNNo22nCX4/AyHeBT/RRTO7S/phayDoBXXlEplUx4YCEb0YjtOc8QhTdvGHx5uHWwg==
X-Received: by 2002:a63:6193:: with SMTP id v141mr8446168pgb.392.1552430053392;
        Tue, 12 Mar 2019 15:34:13 -0700 (PDT)
Received: from tower.thefacebook.com ([2620:10d:c090:200::1:3203])
        by smtp.gmail.com with ESMTPSA id i13sm14680592pfo.106.2019.03.12.15.34.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 15:34:12 -0700 (PDT)
From:   Roman Gushchin <guroan@gmail.com>
X-Google-Original-From: Roman Gushchin <guro@fb.com>
To:     linux-mm@kvack.org, kernel-team@fb.com
Cc:     linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, Roman Gushchin <guro@fb.com>
Subject: [PATCH v2 4/6] mm: release per-node memcg percpu data prematurely
Date:   Tue, 12 Mar 2019 15:34:01 -0700
Message-Id: <20190312223404.28665-5-guro@fb.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190312223404.28665-1-guro@fb.com>
References: <20190312223404.28665-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to memcg-level statistics, per-node data isn't expected
to be hot after cgroup removal. Switching over to atomics and
prematurely releasing percpu data helps to reduce the memory
footprint of dying cgroups.

Signed-off-by: Roman Gushchin <guro@fb.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
---
 include/linux/memcontrol.h |  1 +
 mm/memcontrol.c            | 24 +++++++++++++++++++++++-
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 569337514230..f296693d102b 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -127,6 +127,7 @@ struct mem_cgroup_per_node {
 	struct lruvec		lruvec;
 
 	struct lruvec_stat __rcu /* __percpu */ *lruvec_stat_cpu;
+	struct lruvec_stat __percpu *lruvec_stat_cpu_offlined;
 	atomic_long_t		lruvec_stat[NR_VM_NODE_STAT_ITEMS];
 
 	unsigned long		lru_zone_size[MAX_NR_ZONES][NR_LRU_LISTS];
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index efd5bc131a38..1b5fe826d6d0 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4460,7 +4460,7 @@ static void free_mem_cgroup_per_node_info(struct mem_cgroup *memcg, int node)
 	if (!pn)
 		return;
 
-	free_percpu(pn->lruvec_stat_cpu);
+	WARN_ON_ONCE(pn->lruvec_stat_cpu != NULL);
 	kfree(pn);
 }
 
@@ -4616,7 +4616,17 @@ static int mem_cgroup_css_online(struct cgroup_subsys_state *css)
 static void percpu_rcu_free(struct rcu_head *rcu)
 {
 	struct mem_cgroup *memcg = container_of(rcu, struct mem_cgroup, rcu);
+	int node;
+
+	for_each_node(node) {
+		struct mem_cgroup_per_node *pn = memcg->nodeinfo[node];
 
+		if (!pn)
+			continue;
+
+		free_percpu(pn->lruvec_stat_cpu_offlined);
+		WARN_ON_ONCE(pn->lruvec_stat_cpu != NULL);
+	}
 	free_percpu(memcg->vmstats_percpu_offlined);
 	WARN_ON_ONCE(memcg->vmstats_percpu);
 
@@ -4625,6 +4635,18 @@ static void percpu_rcu_free(struct rcu_head *rcu)
 
 static void mem_cgroup_offline_percpu(struct mem_cgroup *memcg)
 {
+	int node;
+
+	for_each_node(node) {
+		struct mem_cgroup_per_node *pn = memcg->nodeinfo[node];
+
+		if (!pn)
+			continue;
+
+		pn->lruvec_stat_cpu_offlined = (struct lruvec_stat __percpu *)
+			rcu_dereference(pn->lruvec_stat_cpu);
+		rcu_assign_pointer(pn->lruvec_stat_cpu, NULL);
+	}
 	memcg->vmstats_percpu_offlined = (struct memcg_vmstats_percpu __percpu*)
 		rcu_dereference(memcg->vmstats_percpu);
 	rcu_assign_pointer(memcg->vmstats_percpu, NULL);
-- 
2.20.1

