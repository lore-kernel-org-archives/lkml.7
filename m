Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FA9CC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 23:01:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 151C320840
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 23:01:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cOsHXC8q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbfCGXA7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 18:00:59 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46897 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbfCGXAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 18:00:40 -0500
Received: by mail-pg1-f193.google.com with SMTP id 196so12458149pgf.13
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 15:00:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XVAzLd6hdIPZj35NxoEZAwxg04Tr002qNrQDR1YF6Fc=;
        b=cOsHXC8q1NlpYG2/9ohgQ48P9MJVgooAsBgk28QQbidN3suqAiF/mMOKqLcnQisWny
         D5RakrhfayswSpAIWwziHUMt52tfLfZKPBc/1xsRfVDrRIrqSdV++twQXPUiCwW8KvDa
         FfffGsXE2gkHQZPwi+1Kh3E4yORU25DiUZHtZhxNTkIiBGwmPNH38R/SFQP7Uv+ZDNiI
         45Ptn3Amz54/mVGvbfQduB5lcVD8Qx9kFvrx+5XPyFShwlyP/VnzRKGtbQyUG9wbXLUs
         MPg4Z5uW7sOdJbJRFNjVgdZM99iSdhB3P6zXS1sDD9weT3lXJBR5Q956ZiY+/TEWY2nQ
         YCAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XVAzLd6hdIPZj35NxoEZAwxg04Tr002qNrQDR1YF6Fc=;
        b=pAyW/oPqdRFWnqpB9Kn7kNNLctRP7A5JbqBF3AsgT6tO+xtctXYO+omULs/j2WchjA
         nUdWdfNOD5qb92hCBIrmj+cYtHA2KHVBAZKrf80cQEScDV/7LwKp7H/vHwxobpwnhXUZ
         7E7hs7NiH2yubjkg+3X/X2CkflVtOaMRx6zvmk15hCkEHzraObaydFPxJ6zvyHS+zNOj
         yo4uaLB9R5n1i5IwMS0B01VWCejLzFHtqtY2GNxrMtu+xXAIhVHvaJcTrwB3lnWiC4mw
         wWfg3BUjOmdvfFxliBK1kpR7t9KPXgOWDK4Yzto0+YIqRqyF9nn+HE73K/gjmDDCytAf
         oZ5g==
X-Gm-Message-State: APjAAAWY/vI4PDtjybzqW461gCV5wt3stT8WvQyasMBAvM8pGdSd4lSl
        rEoxBRTDf7nt+mfq0NaJP4k=
X-Google-Smtp-Source: APXvYqzIHdXQsfrnBx1c44K71SD+IKizHnfv93In7LvP+Dos1vMHhkeSszM33wViMkWYf7DfSWojFQ==
X-Received: by 2002:a63:6ecb:: with SMTP id j194mr14086143pgc.250.1551999639357;
        Thu, 07 Mar 2019 15:00:39 -0800 (PST)
Received: from tower.thefacebook.com ([2620:10d:c090:200::2:d18b])
        by smtp.gmail.com with ESMTPSA id i126sm11864806pfb.15.2019.03.07.15.00.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Mar 2019 15:00:38 -0800 (PST)
From:   Roman Gushchin <guroan@gmail.com>
X-Google-Original-From: Roman Gushchin <guro@fb.com>
To:     linux-mm@kvack.org, kernel-team@fb.com
Cc:     linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, Roman Gushchin <guro@fb.com>
Subject: [PATCH 2/5] mm: prepare to premature release of per-node lruvec_stat_cpu
Date:   Thu,  7 Mar 2019 15:00:30 -0800
Message-Id: <20190307230033.31975-3-guro@fb.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190307230033.31975-1-guro@fb.com>
References: <20190307230033.31975-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to the memcg's vmstats_percpu, per-memcg per-node stats
consists of percpu- and atomic counterparts, and we do expect
that both coexist during the whole life-cycle of the memcg.

To prepare for a premature release of percpu per-node data,
let's pretend that lruvec_stat_cpu is a rcu-protected pointer,
which can be NULL. This patch adds corresponding checks whenever
required.

Signed-off-by: Roman Gushchin <guro@fb.com>
---
 include/linux/memcontrol.h | 21 +++++++++++++++------
 mm/memcontrol.c            | 11 +++++++++--
 2 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 05ca77767c6a..8ac04632002a 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -126,7 +126,7 @@ struct memcg_shrinker_map {
 struct mem_cgroup_per_node {
 	struct lruvec		lruvec;
 
-	struct lruvec_stat __percpu *lruvec_stat_cpu;
+	struct lruvec_stat __rcu /* __percpu */ *lruvec_stat_cpu;
 	atomic_long_t		lruvec_stat[NR_VM_NODE_STAT_ITEMS];
 
 	unsigned long		lru_zone_size[MAX_NR_ZONES][NR_LRU_LISTS];
@@ -682,6 +682,7 @@ static inline unsigned long lruvec_page_state(struct lruvec *lruvec,
 static inline void __mod_lruvec_state(struct lruvec *lruvec,
 				      enum node_stat_item idx, int val)
 {
+	struct lruvec_stat __percpu *lruvec_stat_cpu;
 	struct mem_cgroup_per_node *pn;
 	long x;
 
@@ -697,12 +698,20 @@ static inline void __mod_lruvec_state(struct lruvec *lruvec,
 	__mod_memcg_state(pn->memcg, idx, val);
 
 	/* Update lruvec */
-	x = val + __this_cpu_read(pn->lruvec_stat_cpu->count[idx]);
-	if (unlikely(abs(x) > MEMCG_CHARGE_BATCH)) {
-		atomic_long_add(x, &pn->lruvec_stat[idx]);
-		x = 0;
+	rcu_read_lock();
+	lruvec_stat_cpu = (struct lruvec_stat __percpu *)
+		rcu_dereference(pn->lruvec_stat_cpu);
+	if (likely(lruvec_stat_cpu)) {
+		x = val + __this_cpu_read(lruvec_stat_cpu->count[idx]);
+		if (unlikely(abs(x) > MEMCG_CHARGE_BATCH)) {
+			atomic_long_add(x, &pn->lruvec_stat[idx]);
+			x = 0;
+		}
+		__this_cpu_write(lruvec_stat_cpu->count[idx], x);
+	} else {
+		atomic_long_add(val, &pn->lruvec_stat[idx]);
 	}
-	__this_cpu_write(pn->lruvec_stat_cpu->count[idx], x);
+	rcu_read_unlock();
 }
 
 static inline void mod_lruvec_state(struct lruvec *lruvec,
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 803c772f354b..8f3cac02221a 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2122,6 +2122,7 @@ static void drain_all_stock(struct mem_cgroup *root_memcg)
 static int memcg_hotplug_cpu_dead(unsigned int cpu)
 {
 	struct memcg_vmstats_percpu __percpu *vmstats_percpu;
+	struct lruvec_stat __percpu *lruvec_stat_cpu;
 	struct memcg_stock_pcp *stock;
 	struct mem_cgroup *memcg;
 
@@ -2152,7 +2153,12 @@ static int memcg_hotplug_cpu_dead(unsigned int cpu)
 				struct mem_cgroup_per_node *pn;
 
 				pn = mem_cgroup_nodeinfo(memcg, nid);
-				x = this_cpu_xchg(pn->lruvec_stat_cpu->count[i], 0);
+
+				lruvec_stat_cpu = (struct lruvec_stat __percpu*)
+					rcu_dereference(pn->lruvec_stat_cpu);
+				if (!lruvec_stat_cpu)
+					continue;
+				x = this_cpu_xchg(lruvec_stat_cpu->count[i], 0);
 				if (x)
 					atomic_long_add(x, &pn->lruvec_stat[i]);
 			}
@@ -4430,7 +4436,8 @@ static int alloc_mem_cgroup_per_node_info(struct mem_cgroup *memcg, int node)
 	if (!pn)
 		return 1;
 
-	pn->lruvec_stat_cpu = alloc_percpu(struct lruvec_stat);
+	rcu_assign_pointer(pn->lruvec_stat_cpu,
+			   alloc_percpu(struct lruvec_stat));
 	if (!pn->lruvec_stat_cpu) {
 		kfree(pn);
 		return 1;
-- 
2.20.1

