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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 132C1C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 18:40:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5963213A2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 18:40:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TrX0uTyr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbfCMSks (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 14:40:48 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41200 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727030AbfCMSkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 14:40:07 -0400
Received: by mail-pf1-f193.google.com with SMTP id d25so1981591pfn.8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 11:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZKgL4zeK+z0St01hNMYKSt6dKMvw92MkjAHduvDs3M4=;
        b=TrX0uTyrR8JGkApkgIGcwFbP61RnpY6vKQwkP3/WLW7+611dwmic3jm/UWC51wVBzv
         ZxmlfoRbLDOV/svdWScPzZ/35vHi6eAsW2cpY8KPHcmb/cksQIqgn3y0kW3HqrYsAViU
         PARJAv80Ak4rosKlqFWfUugSTU+uhn9jnGEMIaeC64cakf8i7ChAiCsDE+0A9ZwEGCge
         FYEJhOYXTTU3uD2MQVw2/thiMnBJdqoCRJOKTPFBfU/2O590YceAv1YBFw8evhN+Zv2A
         cTfzhAI9/zmULZ+hon4mYfTi8ukHQe/72jihu//A4YZaOWgfgWZWS/peYsKluEf3cG2l
         xV2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZKgL4zeK+z0St01hNMYKSt6dKMvw92MkjAHduvDs3M4=;
        b=oAsc1SEmBDmZniEEqmjZ+AdX/j5LWfik7XGbJAdTmCHp59EqDPI5F15/5oxe0ERXDR
         1J+80G3anNRlAd4wWruOAH599hrnzM+2GjAbS1UvwzwnAP//qpeID3syMXXCWTxMQyjp
         lZyGYiWQuTIiBo+UwcNBJLbZZWyrPq3A0OlDZ60cwWds+PxJ5cVY2XewWh+kyPcIBcKl
         r7dl2O1zJbtY5F36FrE5WRT4RPswRkLddvgsLwiyOjHit139D2Q1neinp5PCmaWwG9FC
         iVFIG2wm81mtZEFb6RM5xoV4wDLp/WlocdVFfyM6F0JN7KWPOlQKm8u3YK2BileMtZhX
         d3VA==
X-Gm-Message-State: APjAAAVfZCdcsgNjKETRJSyk5FmMaEOM6UJ9eXd+beiP0DbjefmvgMCA
        kWJ2nCmr+LpM0gQRirB/jZM=
X-Google-Smtp-Source: APXvYqxV2blt47QtOVx+WggwDQ01SnXjX2Y9PFVIr3pxDFvknWA+oQdov2HJkEBELj1nvrrU2TpWmg==
X-Received: by 2002:a17:902:3:: with SMTP id 3mr41784620pla.114.1552502406117;
        Wed, 13 Mar 2019 11:40:06 -0700 (PDT)
Received: from castle.hsd1.ca.comcast.net ([2603:3024:1704:3e00::d657])
        by smtp.gmail.com with ESMTPSA id i13sm15792562pgq.17.2019.03.13.11.40.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Mar 2019 11:40:05 -0700 (PDT)
From:   Roman Gushchin <guroan@gmail.com>
X-Google-Original-From: Roman Gushchin <guro@fb.com>
To:     linux-mm@kvack.org, kernel-team@fb.com
Cc:     linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, Roman Gushchin <guro@fb.com>
Subject: [PATCH v3 4/6] mm: release per-node memcg percpu data prematurely
Date:   Wed, 13 Mar 2019 11:39:51 -0700
Message-Id: <20190313183953.17854-5-guro@fb.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190313183953.17854-1-guro@fb.com>
References: <20190313183953.17854-1-guro@fb.com>
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

