Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFD30C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 22:38:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E55C21911
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 22:38:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jZLlFoU4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388259AbfGXWix (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 18:38:53 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:52334 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbfGXWiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 18:38:52 -0400
Received: by mail-qk1-f201.google.com with SMTP id r200so40723136qke.19
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 15:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=MpC0Rd8Uwl82M7lWinurZdt7KtqhFE+iEQokqKBBr4s=;
        b=jZLlFoU4q5mjBFEepGi5ixBFvd9qeXoMdbe9LQ8OT/qIsHfRTxoy3+s89b2ZbW5Lzv
         qHMXUw0bDtLH5QD0sRR7/XIB5mMV+6EVb/bihRQco8S/Je0weCPre7OVkcoo/RvRIZMA
         iyAhabH0bhrLytnKZZa7fwEMG1O9tc8ML9jxSg5vhUEZbriLisGyqqku/66lHlBQY+iV
         xf7orzq/9RJ4cb2dRsjFILZaRVOAXlR7Y56sjk6DWr/45ZOFzPvsEir71OLy1m/ADbB8
         tGkvTyD+ZJlyR4zvgiTLoVT3P+q7C2+1yykvTwDx05noJxyMJ+1IoLpFrbB/TU4rlvGL
         42wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=MpC0Rd8Uwl82M7lWinurZdt7KtqhFE+iEQokqKBBr4s=;
        b=DDu8KqElTg+OXOfO8EGrXY0r+NrKXjjhnm908s8K60OIjPZuyomOSjGJgH8STM8Y9w
         diQLmR7R3+INOwxceMWmVE2lmBSRE3c0XE1Wbswjm6G71qj/PZxjl2SBSH95YMzmcVD/
         b8kwfgW3f+EvAvXGL0rylXy+Lis3EcCVFfwB/y/2S3AWTyGaRyig71jOL+miYdytL2Mc
         20B3Yo40uV42KxFyJOdwLdKdf74MPwosEmreXDQW7YwvdOg+Yt/VNheUiZrjQBi+pKHI
         oqeHSeFXY9HGvkoEzyzkkXq0HuSCuzQu/KD8pAmRKta703s2IWXNpq0oXMUYugIG1Dno
         VTrA==
X-Gm-Message-State: APjAAAVQdJ317dmJ2J5mM4kp/W6kDfKVSJndp3t2M1PC16VG9fPdpma1
        1wZwcHqxaYJdM7YQW18/BjGiemQZQir9
X-Google-Smtp-Source: APXvYqzLFYdllfy5nX/toUv40OWCHYatdT8Aq9bATneY5zxkpgcxgwpyukeKdGw8UwQeYa3NGKaHwonUXZiF
X-Received: by 2002:a37:98c3:: with SMTP id a186mr56793938qke.498.1564007930974;
 Wed, 24 Jul 2019 15:38:50 -0700 (PDT)
Date:   Wed, 24 Jul 2019 15:37:44 -0700
In-Reply-To: <20190724223746.153620-1-irogers@google.com>
Message-Id: <20190724223746.153620-6-irogers@google.com>
Mime-Version: 1.0
References: <20190702065955.165738-1-irogers@google.com> <20190724223746.153620-1-irogers@google.com>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
Subject: [PATCH v2 5/7] perf: cache perf_event_groups_first for cgroups
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a per-CPU cache of the pinned and flexible perf_event_groups_first
value for a cgroup avoiding an O(log(#perf events)) searches during
sched_in.

This patch is derived from an original patch by Kan Liang
<kan.liang@linux.intel.com>:
https://lkml.org/lkml/2019/5/15/1594

Signed-off-by: Ian Rogers <irogers@google.com>
---
 include/linux/perf_event.h |   6 ++
 kernel/events/core.c       | 142 ++++++++++++++++++++++++++-----------
 2 files changed, 106 insertions(+), 42 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 43f90cfa2c39..2d411786ab87 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -845,6 +845,12 @@ struct perf_cgroup_info {
 struct perf_cgroup {
 	struct cgroup_subsys_state	css;
 	struct perf_cgroup_info	__percpu *info;
+	/* A cache of the first event with the perf_cpu_context's
+	 * perf_event_context for the first event in pinned_groups or
+	 * flexible_groups. Avoids an rbtree search during sched_in.
+	 */
+	struct perf_event * __percpu    *pinned_event;
+	struct perf_event * __percpu    *flexible_event;
 };
 
 /*
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 2a2188908bed..c8b9c8611533 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1592,6 +1592,25 @@ perf_event_groups_insert(struct perf_event_groups *groups,
 
 	rb_link_node(&event->group_node, parent, node);
 	rb_insert_color(&event->group_node, &groups->tree);
+#ifdef CONFIG_CGROUP_PERF
+	if (is_cgroup_event(event)) {
+		struct perf_event **cgrp_event;
+
+		if (event->attr.pinned)
+			cgrp_event = per_cpu_ptr(event->cgrp->pinned_event,
+						 event->cpu);
+		else
+			cgrp_event = per_cpu_ptr(event->cgrp->flexible_event,
+						 event->cpu);
+		/*
+		 * Cgroup events for the same cgroup on the same CPU will
+		 * always be inserted at the right because of bigger
+		 * @groups->index. Only need to set *cgrp_event when it's NULL.
+		 */
+		if (!*cgrp_event)
+			*cgrp_event = event;
+	}
+#endif
 }
 
 /*
@@ -1606,6 +1625,9 @@ add_event_to_groups(struct perf_event *event, struct perf_event_context *ctx)
 	perf_event_groups_insert(groups, event);
 }
 
+static struct perf_event *
+perf_event_groups_next(struct perf_event *event);
+
 /*
  * Delete a group from a tree.
  */
@@ -1616,6 +1638,22 @@ perf_event_groups_delete(struct perf_event_groups *groups,
 	WARN_ON_ONCE(RB_EMPTY_NODE(&event->group_node) ||
 		     RB_EMPTY_ROOT(&groups->tree));
 
+#ifdef CONFIG_CGROUP_PERF
+	if (is_cgroup_event(event)) {
+		struct perf_event **cgrp_event;
+
+		if (event->attr.pinned)
+			cgrp_event = per_cpu_ptr(event->cgrp->pinned_event,
+						 event->cpu);
+		else
+			cgrp_event = per_cpu_ptr(event->cgrp->flexible_event,
+						 event->cpu);
+
+		if (*cgrp_event == event)
+			*cgrp_event = perf_event_groups_next(event);
+	}
+#endif
+
 	rb_erase(&event->group_node, &groups->tree);
 	init_event_group(event);
 }
@@ -1633,20 +1671,14 @@ del_event_from_groups(struct perf_event *event, struct perf_event_context *ctx)
 }
 
 /*
- * Get the leftmost event in the cpu/cgroup subtree.
+ * Get the leftmost event in the cpu subtree without a cgroup (ie task or
+ * system-wide).
  */
 static struct perf_event *
-perf_event_groups_first(struct perf_event_groups *groups, int cpu,
-			struct cgroup *cgrp)
+perf_event_groups_first_no_cgroup(struct perf_event_groups *groups, int cpu)
 {
 	struct perf_event *node_event = NULL, *match = NULL;
 	struct rb_node *node = groups->tree.rb_node;
-#ifdef CONFIG_CGROUP_PERF
-	int node_cgrp_id, cgrp_id = 0;
-
-	if (cgrp)
-		cgrp_id = cgrp->id;
-#endif
 
 	while (node) {
 		node_event = container_of(node, struct perf_event, group_node);
@@ -1660,18 +1692,10 @@ perf_event_groups_first(struct perf_event_groups *groups, int cpu,
 			continue;
 		}
 #ifdef CONFIG_CGROUP_PERF
-		node_cgrp_id = 0;
-		if (node_event->cgrp && node_event->cgrp->css.cgroup)
-			node_cgrp_id = node_event->cgrp->css.cgroup->id;
-
-		if (cgrp_id < node_cgrp_id) {
+		if (node_event->cgrp) {
 			node = node->rb_left;
 			continue;
 		}
-		if (cgrp_id > node_cgrp_id) {
-			node = node->rb_right;
-			continue;
-		}
 #endif
 		match = node_event;
 		node = node->rb_left;
@@ -3433,6 +3457,13 @@ static void min_heap_pop_push(struct perf_event_heap *heap,
 	}
 }
 
+static int pinned_sched_in(struct perf_event_context *ctx,
+			   struct perf_cpu_context *cpuctx,
+			   struct perf_event *event);
+static int flexible_sched_in(struct perf_event_context *ctx,
+			     struct perf_cpu_context *cpuctx,
+			     struct perf_event *event,
+			     int *can_add_hw);
 
 /*
  * Without cgroups, with a task context, there may be per-CPU and any
@@ -3442,11 +3473,7 @@ static void min_heap_pop_push(struct perf_event_heap *heap,
 
 static int visit_groups_merge(struct perf_event_context *ctx,
 			      struct perf_cpu_context *cpuctx,
-			      struct perf_event_groups *groups,
-			      int (*func)(struct perf_event_context *,
-					  struct perf_cpu_context *,
-					  struct perf_event *,
-					  int *),
+			      bool is_pinned,
 			      int *data)
 {
 	/*
@@ -3472,7 +3499,11 @@ static int visit_groups_merge(struct perf_event_context *ctx,
 #endif
 	int ret, cpu = smp_processor_id();
 
-	heap.storage[0] = perf_event_groups_first(groups, cpu, NULL);
+	struct perf_event_groups *groups = is_pinned
+					   ? &ctx->pinned_groups
+					   : &ctx->flexible_groups;
+
+	heap.storage[0] = perf_event_groups_first_no_cgroup(groups, cpu);
 	if (heap.storage[0])
 		heap.num_elements++;
 
@@ -3482,7 +3513,7 @@ static int visit_groups_merge(struct perf_event_context *ctx,
 		 * events.
 		 */
 		heap.storage[heap.num_elements] =
-				perf_event_groups_first(groups, -1, NULL);
+				perf_event_groups_first_no_cgroup(groups, -1);
 		if (heap.storage[heap.num_elements])
 			heap.num_elements++;
 	} else {
@@ -3492,14 +3523,22 @@ static int visit_groups_merge(struct perf_event_context *ctx,
 		 * For itrs[1..MAX] add an iterator for each cgroup parent that
 		 * has events.
 		 */
-		if (cpuctx->cgrp) {
+		struct perf_cgroup *cgrp = cpuctx->cgrp;
+
+		if (cgrp) {
 			struct cgroup_subsys_state *css;
 
-			for (css = &cpuctx->cgrp->css; css; css = css->parent) {
-				heap.storage[heap.num_elements] =
-						perf_event_groups_first(groups,
-								   cpu,
-								   css->cgroup);
+			for (css = &cgrp->css; css; css = css->parent) {
+				/* root cgroup doesn't have events */
+				if (css->id == 1)
+					break;
+
+				cgrp = container_of(css, struct perf_cgroup,
+						    css);
+				heap.storage[heap.num_elements] = is_pinned
+					? *per_cpu_ptr(cgrp->pinned_event, cpu)
+					: *per_cpu_ptr(cgrp->flexible_event,
+						       cpu);
 				if (heap.storage[heap.num_elements]) {
 					heap.num_elements++;
 					if (heap.num_elements ==
@@ -3516,7 +3555,12 @@ static int visit_groups_merge(struct perf_event_context *ctx,
 	min_heapify_all(&heap);
 
 	while (heap.num_elements > 0) {
-		ret = func(ctx, cpuctx, heap.storage[0], data);
+		if (is_pinned)
+			ret = pinned_sched_in(ctx, cpuctx, heap.storage[0]);
+		else
+			ret = flexible_sched_in(ctx, cpuctx, heap.storage[0],
+						data);
+
 		if (ret)
 			return ret;
 
@@ -3529,8 +3573,7 @@ static int visit_groups_merge(struct perf_event_context *ctx,
 
 static int pinned_sched_in(struct perf_event_context *ctx,
 			   struct perf_cpu_context *cpuctx,
-			   struct perf_event *event,
-			   int *unused)
+			   struct perf_event *event)
 {
 	if (event->state <= PERF_EVENT_STATE_OFF)
 		return 0;
@@ -3583,8 +3626,7 @@ ctx_pinned_sched_in(struct perf_event_context *ctx,
 {
 	visit_groups_merge(ctx,
 			   cpuctx,
-			   &ctx->pinned_groups,
-			   pinned_sched_in,
+			   /*is_pinned=*/true,
 			   NULL);
 }
 
@@ -3596,8 +3638,7 @@ ctx_flexible_sched_in(struct perf_event_context *ctx,
 
 	visit_groups_merge(ctx,
 			   cpuctx,
-			   &ctx->flexible_groups,
-			   flexible_sched_in,
+			   /*is_pinned=*/false,
 			   &can_add_hw);
 }
 
@@ -12417,18 +12458,35 @@ perf_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
 		return ERR_PTR(-ENOMEM);
 
 	jc->info = alloc_percpu(struct perf_cgroup_info);
-	if (!jc->info) {
-		kfree(jc);
-		return ERR_PTR(-ENOMEM);
-	}
+	if (!jc->info)
+		goto free_jc;
+
+	jc->pinned_event = alloc_percpu(struct perf_event *);
+	if (!jc->pinned_event)
+		goto free_jc_info;
+
+	jc->flexible_event = alloc_percpu(struct perf_event *);
+	if (!jc->flexible_event)
+		goto free_jc_pinned;
 
 	return &jc->css;
+
+free_jc_pinned:
+	free_percpu(jc->pinned_event);
+free_jc_info:
+	free_percpu(jc->info);
+free_jc:
+	kfree(jc);
+
+	return ERR_PTR(-ENOMEM);
 }
 
 static void perf_cgroup_css_free(struct cgroup_subsys_state *css)
 {
 	struct perf_cgroup *jc = container_of(css, struct perf_cgroup, css);
 
+	free_percpu(jc->pinned_event);
+	free_percpu(jc->flexible_event);
 	free_percpu(jc->info);
 	kfree(jc);
 }
-- 
2.22.0.709.g102302147b-goog

