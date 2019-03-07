Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E665C10F0C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 23:00:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 454B420854
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 23:00:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DckgoRO/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbfCGXAo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 18:00:44 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40863 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726348AbfCGXAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 18:00:42 -0500
Received: by mail-pg1-f193.google.com with SMTP id u9so12453685pgo.7
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 15:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MfCrTGNmSaFUElZVoR94lwj3NK36d5qLYupM1vXTErA=;
        b=DckgoRO/Og9fpzx5eO2KFbjkYdOnR1jrMLl012hR598K9U/OkK69u0GSHHoaGMPmDl
         S4buq5J+Tv3pZTi+Kdt+wCGz5NPe489QYj47U0E4z9qym9QV5kbKgACI6w2MBFcasnf5
         lMenGSfadqVa9AEOW7wF8RYYuYhXOa54agdS1Q9xnVWSyU6ZnMBkcjFsl0w8dd4/CvO6
         M2oo5gELJ2m+CL8xrrMFgdlvIqSY61S4ubbL10igebd/2s+pIC98lfsUCu0j5VO46PqJ
         k5YZmwMTIKRp3gKUaluH6M0WPUd96ydqN/tarPBdgXh/bLAmAUX9oimU/ZJTP4Kd0kPP
         Ikpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MfCrTGNmSaFUElZVoR94lwj3NK36d5qLYupM1vXTErA=;
        b=EI/hnn4MLQu81WQnfFgIgjiTaGYTXv9W4cH0ZRJdSJfNQ+yZGaV1hrBm4GwdH7eF7J
         NNeUKvxCQP7vJ0y9IFfUBiNlBMluxdL0EEUETgjaGTanFC4DNSxi8SfS4bb90iwlSmfc
         UAVvSM2u+enlG0DdGrGQ7uWTfLdAlLzXIkmx4xkqe7mrVbgJW3DH4ZMjmlLCThyUxnV8
         ATgGTYarXHNiRIPEs/g5FcE3ANDLoS/Xw1SLduVXHfYGkJertUI1dfsVskcZtbpUJxSa
         Oq0q5aNuvRrk0CDnN887MO0qi/ghPnYrf23ZILcVLM9wWT5NKSRvsA+/DA72JqEtcIhO
         kY9A==
X-Gm-Message-State: APjAAAU56Jdes6cfbk6tYfvmiH0uLoOmRtGHA6JM4mjib+o9g2pG2aj2
        yxD3Kqb1DAXMlqHhAO42+g8=
X-Google-Smtp-Source: APXvYqyNrdFaTzkRpNlZuAWstlgn+HzqsgGmG/ZykiNpz92+GrArj5J170eRpoAbjVwIyx5oQFwreQ==
X-Received: by 2002:a63:8542:: with SMTP id u63mr13751923pgd.323.1551999641771;
        Thu, 07 Mar 2019 15:00:41 -0800 (PST)
Received: from tower.thefacebook.com ([2620:10d:c090:200::2:d18b])
        by smtp.gmail.com with ESMTPSA id i126sm11864806pfb.15.2019.03.07.15.00.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Mar 2019 15:00:41 -0800 (PST)
From:   Roman Gushchin <guroan@gmail.com>
X-Google-Original-From: Roman Gushchin <guro@fb.com>
To:     linux-mm@kvack.org, kernel-team@fb.com
Cc:     linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, Roman Gushchin <guro@fb.com>
Subject: [PATCH 4/5] mm: release per-node memcg percpu data prematurely
Date:   Thu,  7 Mar 2019 15:00:32 -0800
Message-Id: <20190307230033.31975-5-guro@fb.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190307230033.31975-1-guro@fb.com>
References: <20190307230033.31975-1-guro@fb.com>
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
index 8c55954e6f23..18e863890392 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4459,7 +4459,7 @@ static void free_mem_cgroup_per_node_info(struct mem_cgroup *memcg, int node)
 	if (!pn)
 		return;
 
-	free_percpu(pn->lruvec_stat_cpu);
+	WARN_ON_ONCE(pn->lruvec_stat_cpu != NULL);
 	kfree(pn);
 }
 
@@ -4615,7 +4615,17 @@ static int mem_cgroup_css_online(struct cgroup_subsys_state *css)
 static void mem_cgroup_free_percpu(struct rcu_head *rcu)
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
 
@@ -4624,6 +4634,18 @@ static void mem_cgroup_free_percpu(struct rcu_head *rcu)
 
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

