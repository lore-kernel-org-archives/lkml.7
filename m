Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CBCBC282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 15:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1128E2084D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 15:15:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="ILqDJJHk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbfDLPPW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 11:15:22 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36747 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726944AbfDLPPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 11:15:20 -0400
Received: by mail-qk1-f196.google.com with SMTP id k130so5859167qke.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 08:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PRTUaF678C5HIzdBjBIPSEr+aHrXt+S0IRBXo9MeAws=;
        b=ILqDJJHkPZz+eoKOvEr4x0/kgN/IBd0kCMfXy7rPlSfiWsGSmDI6DjyrVYmzgB/KgJ
         o/a/0Y1afe7RfkMShz9vwu+3rR2TVnT91QuwBCSOdI5Q13s8C0dbu9xj3PjV4IRsSngj
         +xYSZhSKjRK1gaqwdDvmiaOzBR7OeV2vcxlhnLdTeOQSTfrRfivBEbyYNTxVKLSnp+CB
         zjIsSHe6XO4EZuIEVpRXex1t0Chpz6YqKKdL/mvxmkyCEQpYZDkvyznHQ6p01d47B6DJ
         dw6CszzzPqXfI2qk2mij7G5QVuKJIXQGJm+0/35AP73eRIX1DEbeAooXRbZCZUFLrkSP
         7iKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PRTUaF678C5HIzdBjBIPSEr+aHrXt+S0IRBXo9MeAws=;
        b=bgbI6+uBvV+WUytB2/Fw64ebOn/LwhzTSJCxOilm9gyiP7e8OR/oOdzBXidfO6Uzsd
         NOxDnQtyEhYQVJDA8FmvtaEVT4P26t1w5pXTqrATJmwv90AZksA7/FJb1/tp/V0E0U9F
         /Ce2OL1eJF5Dti72GJ5JPiUTq4MpNflXbkLUJgxYDrqkBPHN16azKx0QNazX32KmfIx8
         01sLAXQ8/zwvlOaxWldCklC3sPmSPZfNBsVvLZ/e2HIpf+vCA32SfLZjBdI5VfFAqTpX
         XLjnaglPPvN3Fv+A+cpVn0d1ELFtFrie2uYfKCGpC+LgKYl5pWbBwN4XTnj3anwIKbcp
         YI1Q==
X-Gm-Message-State: APjAAAUD1xXomffYMYHEcQ3wYAjyzivedFoFtxSMtfEjyZ21/SsOAhwB
        OU5NsOau3zFN6HhpVUJ0ogpPvKKvd/E=
X-Google-Smtp-Source: APXvYqysIlg0nPC2TAIyhyZGpUry9fm9BHzZ/cusQuSfW34/ihXJ8nq+qmczg5uW0MTGOcK5jfgKsQ==
X-Received: by 2002:a37:4f95:: with SMTP id d143mr45617065qkb.253.1555082119044;
        Fri, 12 Apr 2019 08:15:19 -0700 (PDT)
Received: from localhost (pool-108-27-252-85.nycmny.fios.verizon.net. [108.27.252.85])
        by smtp.gmail.com with ESMTPSA id x24sm13094296qtm.65.2019.04.12.08.15.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Apr 2019 08:15:18 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 2/4] mm: memcontrol: move stat/event counting functions out-of-line
Date:   Fri, 12 Apr 2019 11:15:05 -0400
Message-Id: <20190412151507.2769-3-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190412151507.2769-1-hannes@cmpxchg.org>
References: <20190412151507.2769-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are getting too big to be inlined in every callsite. They were
stolen from vmstat.c, which already out-of-lines them, and they have
only been growing since. The callsites aren't that hot, either.

Move __mod_memcg_state()
     __mod_lruvec_state() and
     __count_memcg_events() out of line and add kerneldoc comments.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 include/linux/memcontrol.h | 62 +++---------------------------
 mm/memcontrol.c            | 79 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 84 insertions(+), 57 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 139be7d44c29..cae7d1b11eea 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -580,22 +580,7 @@ static inline unsigned long memcg_page_state_local(struct mem_cgroup *memcg,
 	return x;
 }
 
-/* idx can be of type enum memcg_stat_item or node_stat_item */
-static inline void __mod_memcg_state(struct mem_cgroup *memcg,
-				     int idx, int val)
-{
-	long x;
-
-	if (mem_cgroup_disabled())
-		return;
-
-	x = val + __this_cpu_read(memcg->vmstats_percpu->stat[idx]);
-	if (unlikely(abs(x) > MEMCG_CHARGE_BATCH)) {
-		atomic_long_add(x, &memcg->vmstats[idx]);
-		x = 0;
-	}
-	__this_cpu_write(memcg->vmstats_percpu->stat[idx], x);
-}
+void __mod_memcg_state(struct mem_cgroup *memcg, int idx, int val);
 
 /* idx can be of type enum memcg_stat_item or node_stat_item */
 static inline void mod_memcg_state(struct mem_cgroup *memcg,
@@ -657,31 +642,8 @@ static inline unsigned long lruvec_page_state_local(struct lruvec *lruvec,
 	return x;
 }
 
-static inline void __mod_lruvec_state(struct lruvec *lruvec,
-				      enum node_stat_item idx, int val)
-{
-	struct mem_cgroup_per_node *pn;
-	long x;
-
-	/* Update node */
-	__mod_node_page_state(lruvec_pgdat(lruvec), idx, val);
-
-	if (mem_cgroup_disabled())
-		return;
-
-	pn = container_of(lruvec, struct mem_cgroup_per_node, lruvec);
-
-	/* Update memcg */
-	__mod_memcg_state(pn->memcg, idx, val);
-
-	/* Update lruvec */
-	x = val + __this_cpu_read(pn->lruvec_stat_cpu->count[idx]);
-	if (unlikely(abs(x) > MEMCG_CHARGE_BATCH)) {
-		atomic_long_add(x, &pn->lruvec_stat[idx]);
-		x = 0;
-	}
-	__this_cpu_write(pn->lruvec_stat_cpu->count[idx], x);
-}
+void __mod_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
+			int val);
 
 static inline void mod_lruvec_state(struct lruvec *lruvec,
 				    enum node_stat_item idx, int val)
@@ -723,22 +685,8 @@ unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
 						gfp_t gfp_mask,
 						unsigned long *total_scanned);
 
-static inline void __count_memcg_events(struct mem_cgroup *memcg,
-					enum vm_event_item idx,
-					unsigned long count)
-{
-	unsigned long x;
-
-	if (mem_cgroup_disabled())
-		return;
-
-	x = count + __this_cpu_read(memcg->vmstats_percpu->events[idx]);
-	if (unlikely(x > MEMCG_CHARGE_BATCH)) {
-		atomic_long_add(x, &memcg->vmevents[idx]);
-		x = 0;
-	}
-	__this_cpu_write(memcg->vmstats_percpu->events[idx], x);
-}
+void __count_memcg_events(struct mem_cgroup *memcg, enum vm_event_item idx,
+			  unsigned long count);
 
 static inline void count_memcg_events(struct mem_cgroup *memcg,
 				      enum vm_event_item idx,
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 109608b8091f..3535270ebeec 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -687,6 +687,85 @@ mem_cgroup_largest_soft_limit_node(struct mem_cgroup_tree_per_node *mctz)
 	return mz;
 }
 
+/**
+ * __mod_memcg_state - update cgroup memory statistics
+ * @memcg: the memory cgroup
+ * @idx: the stat item - can be enum memcg_stat_item or enum node_stat_item
+ * @val: delta to add to the counter, can be negative
+ */
+void __mod_memcg_state(struct mem_cgroup *memcg, int idx, int val)
+{
+	long x;
+
+	if (mem_cgroup_disabled())
+		return;
+
+	x = val + __this_cpu_read(memcg->vmstats_percpu->stat[idx]);
+	if (unlikely(abs(x) > MEMCG_CHARGE_BATCH)) {
+		atomic_long_add(x, &memcg->vmstats[idx]);
+		x = 0;
+	}
+	__this_cpu_write(memcg->vmstats_percpu->stat[idx], x);
+}
+
+/**
+ * __mod_lruvec_state - update lruvec memory statistics
+ * @lruvec: the lruvec
+ * @idx: the stat item
+ * @val: delta to add to the counter, can be negative
+ *
+ * The lruvec is the intersection of the NUMA node and a cgroup. This
+ * function updates the all three counters that are affected by a
+ * change of state at this level: per-node, per-cgroup, per-lruvec.
+ */
+void __mod_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
+			int val)
+{
+	struct mem_cgroup_per_node *pn;
+	long x;
+
+	/* Update node */
+	__mod_node_page_state(lruvec_pgdat(lruvec), idx, val);
+
+	if (mem_cgroup_disabled())
+		return;
+
+	pn = container_of(lruvec, struct mem_cgroup_per_node, lruvec);
+
+	/* Update memcg */
+	__mod_memcg_state(pn->memcg, idx, val);
+
+	/* Update lruvec */
+	x = val + __this_cpu_read(pn->lruvec_stat_cpu->count[idx]);
+	if (unlikely(abs(x) > MEMCG_CHARGE_BATCH)) {
+		atomic_long_add(x, &pn->lruvec_stat[idx]);
+		x = 0;
+	}
+	__this_cpu_write(pn->lruvec_stat_cpu->count[idx], x);
+}
+
+/**
+ * __count_memcg_events - account VM events in a cgroup
+ * @memcg: the memory cgroup
+ * @idx: the event item
+ * @count: the number of events that occured
+ */
+void __count_memcg_events(struct mem_cgroup *memcg, enum vm_event_item idx,
+			  unsigned long count)
+{
+	unsigned long x;
+
+	if (mem_cgroup_disabled())
+		return;
+
+	x = count + __this_cpu_read(memcg->vmstats_percpu->events[idx]);
+	if (unlikely(x > MEMCG_CHARGE_BATCH)) {
+		atomic_long_add(x, &memcg->vmevents[idx]);
+		x = 0;
+	}
+	__this_cpu_write(memcg->vmstats_percpu->events[idx], x);
+}
+
 static unsigned long memcg_events_local(struct mem_cgroup *memcg,
 					int event)
 {
-- 
2.21.0

