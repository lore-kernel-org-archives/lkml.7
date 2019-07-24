Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 883B8C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 22:38:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4231D2189F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 22:38:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WUwCVBwe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387920AbfGXWii (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 18:38:38 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:45393 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387405AbfGXWih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 18:38:37 -0400
Received: by mail-pg1-f201.google.com with SMTP id n3so19423984pgh.12
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 15:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=KDcIEWapVHh0yMAvEeT2/OJQEfMO7NyyE5Z1U7roqv0=;
        b=WUwCVBwe5wGSA1H9goEcLEDXvRONStXYMsln4zN/YMrwe1WB++/yYYnzfNWFlobXuk
         U1LCOZZxcPpl4rXhSOuOPkbjI8T3cR7Qncw2uGYODOCJQR7jizki9X4BZzreEYvoZHGz
         MnniCQa2mqJSlEREWTJmvYK0BrcDqUGEj3IVxrBOElZXQ6mnPvnCBQTxYgjPkhOX1f91
         vauIm/z7Yy86tcf4NbLz8DmduJcdIXhEDK4VLpMQhHPAyzCo4kbtiRAh1KrpjBUYsaLO
         HLldy5hQUHuoai2b426bP2gC7xPB5Bm1pQ9jkvIXiPVt7pK+iIwkCjFSw+Fb8l+SXJpj
         A2pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=KDcIEWapVHh0yMAvEeT2/OJQEfMO7NyyE5Z1U7roqv0=;
        b=VJ4LmeFID2+IcXwpV4hq8xRUZsi19zEMIALlVDDosmMs4Qtjl7k21psOXfndjA3tK6
         RwBQh/G7Z3d1VdMpHdiTed7bcjfVyFDWZbqbZ3ZMs7LlZdjbk241M9ouXJeXJbi586Ae
         R9EgDJyB1Rm9PvqE9ne3VdBIum1z6/ubDa4rhj7s+OjlvvNG/egrLjfXlCOahTXuJaGf
         WK397UF70Q4e5KAVl5mArLqa0EBWwVi4EDmWDPcGojA4CPSM2Bc7Jnm4lxSM4d6NMjsJ
         b86jZwdVrSRHtib7RHJ6LQI7bGeM8cievz46y5FlhJjJwVjTK2/5Ms6f+lSoai6Ugef8
         Hg6A==
X-Gm-Message-State: APjAAAUOOUzdgeeQuoAqJwn3COsEUFYHDgfWMuSFxAlHwF11u3zpCgAm
        Df1QknHPOMUxy694ZuWKOr8fEiKURMZu
X-Google-Smtp-Source: APXvYqzzfQHWur6XD0anyha5wy1Ns/6D+JiZI2kSPLkIVxQCnk1kFi7k7qSHYf9f4GR2oP8fJ6mrvcFoqvqM
X-Received: by 2002:a65:4b89:: with SMTP id t9mr14445535pgq.55.1564007916548;
 Wed, 24 Jul 2019 15:38:36 -0700 (PDT)
Date:   Wed, 24 Jul 2019 15:37:41 -0700
In-Reply-To: <20190724223746.153620-1-irogers@google.com>
Message-Id: <20190724223746.153620-3-irogers@google.com>
Mime-Version: 1.0
References: <20190702065955.165738-1-irogers@google.com> <20190724223746.153620-1-irogers@google.com>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
Subject: [PATCH v2 2/7] perf/cgroup: order events in RB tree by cgroup id
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

If one is monitoring 6 events on 20 cgroups the per-CPU RB tree will
hold 120 events. The scheduling in of the events currently iterates
over all events looking to see which events match the task's cgroup or
its cgroup hierarchy. If a task is in 1 cgroup with 6 events, then 114
events are considered unnecessarily.

This change orders events in the RB tree by cgroup id if it is present.
This means scheduling in may go directly to events associated with the
task's cgroup if one is present. The patch extends the 2 iterators in
visit_groups_merge to a set of iterators, where different iterators are
needed for the task's cgroup and parent cgroups. By considering the set
of iterators when visiting, the lowest group_index event may be selected
and the insertion order group_index property is maintained. This also
allows event rotation to function correctly, as although events are
grouped into a cgroup, rotation always selects the lowest group_index
event to rotate (delete/insert into the tree) and the set of iterators
make it so that the group_index order is maintained.

Cgroups can form a hierarchy with an unbounded number of events being
monitored in a child's parent's cgroup and their parent's parent's
cgroup and so on. This change limits the depth of cgroups that can have
monitored events to a constant (16). The change also scans the list of
events when considering the lowest group_index. Later patches will
improve the data structure to remove the constant limit and avoid a
linear search.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 kernel/events/core.c | 232 +++++++++++++++++++++++++++++++------------
 1 file changed, 168 insertions(+), 64 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 84a22a5c88b0..47df9935de0b 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1530,6 +1530,30 @@ perf_event_groups_less(struct perf_event *left, struct perf_event *right)
 	if (left->cpu > right->cpu)
 		return false;
 
+#ifdef CONFIG_CGROUP_PERF
+	if (left->cgrp != right->cgrp) {
+		if (!left->cgrp || !left->cgrp->css.cgroup) {
+			/*
+			 * Left has no cgroup but right does, no cgroups come
+			 * first.
+			 */
+			return true;
+		}
+		if (!right->cgrp || right->cgrp->css.cgroup) {
+			/*
+			 * Right has no cgroup but left does, no cgroups come
+			 * first.
+			 */
+			return false;
+		}
+		/* Two dissimilar cgroups, order by id. */
+		if (left->cgrp->css.cgroup->id < right->cgrp->css.cgroup->id)
+			return true;
+
+		return false;
+	}
+#endif
+
 	if (left->group_index < right->group_index)
 		return true;
 	if (left->group_index > right->group_index)
@@ -1609,25 +1633,48 @@ del_event_from_groups(struct perf_event *event, struct perf_event_context *ctx)
 }
 
 /*
- * Get the leftmost event in the @cpu subtree.
+ * Get the leftmost event in the cpu/cgroup subtree.
  */
 static struct perf_event *
-perf_event_groups_first(struct perf_event_groups *groups, int cpu)
+perf_event_groups_first(struct perf_event_groups *groups, int cpu,
+			struct cgroup *cgrp)
 {
 	struct perf_event *node_event = NULL, *match = NULL;
 	struct rb_node *node = groups->tree.rb_node;
+#ifdef CONFIG_CGROUP_PERF
+	int node_cgrp_id, cgrp_id = 0;
+
+	if (cgrp)
+		cgrp_id = cgrp->id;
+#endif
 
 	while (node) {
 		node_event = container_of(node, struct perf_event, group_node);
 
 		if (cpu < node_event->cpu) {
 			node = node->rb_left;
-		} else if (cpu > node_event->cpu) {
+			continue;
+		}
+		if (cpu > node_event->cpu) {
 			node = node->rb_right;
-		} else {
-			match = node_event;
+			continue;
+		}
+#ifdef CONFIG_CGROUP_PERF
+		node_cgrp_id = 0;
+		if (node_event->cgrp && node_event->cgrp->css.cgroup)
+			node_cgrp_id = node_event->cgrp->css.cgroup->id;
+
+		if (cgrp_id < node_cgrp_id) {
 			node = node->rb_left;
+			continue;
 		}
+		if (cgrp_id > node_cgrp_id) {
+			node = node->rb_right;
+			continue;
+		}
+#endif
+		match = node_event;
+		node = node->rb_left;
 	}
 
 	return match;
@@ -1640,12 +1687,26 @@ static struct perf_event *
 perf_event_groups_next(struct perf_event *event)
 {
 	struct perf_event *next;
+#ifdef CONFIG_CGROUP_PERF
+	int curr_cgrp_id = 0;
+	int next_cgrp_id = 0;
+#endif
 
 	next = rb_entry_safe(rb_next(&event->group_node), typeof(*event), group_node);
-	if (next && next->cpu == event->cpu)
-		return next;
+	if (next == NULL || next->cpu != event->cpu)
+		return NULL;
 
-	return NULL;
+#ifdef CONFIG_CGROUP_PERF
+	if (event->cgrp && event->cgrp->css.cgroup)
+		curr_cgrp_id = event->cgrp->css.cgroup->id;
+
+	if (next->cgrp && next->cgrp->css.cgroup)
+		next_cgrp_id = next->cgrp->css.cgroup->id;
+
+	if (curr_cgrp_id != next_cgrp_id)
+		return NULL;
+#endif
+	return next;
 }
 
 /*
@@ -3261,28 +3322,81 @@ static void cpu_ctx_sched_out(struct perf_cpu_context *cpuctx,
 	ctx_sched_out(&cpuctx->ctx, cpuctx, event_type);
 }
 
-static int visit_groups_merge(struct perf_event_groups *groups, int cpu,
-			      int (*func)(struct perf_event *, void *), void *data)
-{
-	struct perf_event **evt, *evt1, *evt2;
-	int ret;
+static int visit_groups_merge(struct perf_event_context *ctx,
+			      struct perf_cpu_context *cpuctx,
+			      struct perf_event_groups *groups,
+			      int (*func)(struct perf_event_context *,
+					  struct perf_cpu_context *,
+					  struct perf_event *,
+					  int *),
+			      int *data)
+{
+	/* The number of iterators in use. */
+	int num_itrs;
+	/*
+	 * A set of iterators, the iterator for the visit is chosen by the
+	 * group_index. The size of the array is sized such that there is space:
+	 * - for task contexts per-CPU and any-CPU events can be iterated.
+	 * - for CPU contexts:
+	 *   - without cgroups, global events can be iterated.
+	 *   - with cgroups, global events can be iterated and 16 sets of cgroup
+	 *     events. Cgroup events may monitor a cgroup at an arbitrary
+	 *     location within the cgroup hierarchy. An iterator is needed for
+	 *     each cgroup with events in the hierarchy. Potentially this is
+	 *     only limited by MAX_PATH.
+	 */
+	struct perf_event *itrs[IS_ENABLED(CONFIG_CGROUP_PERF) ? 17 : 2];
+	/* A reference to the selected iterator. */
+	struct perf_event **evt;
+	int ret, i, cpu = smp_processor_id();
+
+	itrs[0] = perf_event_groups_first(groups, cpu, NULL);
+
+	if (ctx != &cpuctx->ctx) {
+		/*
+		 * A task context only ever has an iterator for CPU or any CPU
+		 * events.
+		 */
+		itrs[1] = perf_event_groups_first(groups, -1, NULL);
+		num_itrs = 2;
+	} else {
+		/* Per-CPU events are by definition not on any CPU. */
+		num_itrs = 1;
+#ifdef CONFIG_CGROUP_PERF
+		/*
+		 * For itrs[1..MAX] add an iterator for each cgroup parent that
+		 * has events.
+		 */
+		if (cpuctx->cgrp) {
+			struct cgroup_subsys_state *css;
+
+			for (css = &cpuctx->cgrp->css; css; css = css->parent) {
+				itrs[num_itrs] = perf_event_groups_first(groups,
+								   cpu,
+								   css->cgroup);
+				if (itrs[num_itrs] &&
+				    WARN_ONCE(++num_itrs == ARRAY_SIZE(iters)
+				     "Insufficient iterators for cgroup depth"))
+					break;
+			}
+		}
+#endif
+	}
 
-	evt1 = perf_event_groups_first(groups, -1);
-	evt2 = perf_event_groups_first(groups, cpu);
-
-	while (evt1 || evt2) {
-		if (evt1 && evt2) {
-			if (evt1->group_index < evt2->group_index)
-				evt = &evt1;
-			else
-				evt = &evt2;
-		} else if (evt1) {
-			evt = &evt1;
-		} else {
-			evt = &evt2;
+	while (true) {
+		/* Find lowest group_index event. */
+		evt = NULL;
+		for (i = 0; i < num_itrs; ++i) {
+			if (itrs[i] == NULL)
+				continue;
+			if (evt == NULL ||
+			    itrs[i]->group_index < (*evt)->group_index)
+				evt = &itrs[i];
 		}
+		if (evt == NULL)
+			break;
 
-		ret = func(*evt, data);
+		ret = func(ctx, cpuctx, *evt, data);
 		if (ret)
 			return ret;
 
@@ -3292,25 +3406,20 @@ static int visit_groups_merge(struct perf_event_groups *groups, int cpu,
 	return 0;
 }
 
-struct sched_in_data {
-	struct perf_event_context *ctx;
-	struct perf_cpu_context *cpuctx;
-	int can_add_hw;
-};
-
-static int pinned_sched_in(struct perf_event *event, void *data)
+static int pinned_sched_in(struct perf_event_context *ctx,
+			   struct perf_cpu_context *cpuctx,
+			   struct perf_event *event,
+			   int *unused)
 {
-	struct sched_in_data *sid = data;
-
 	if (event->state <= PERF_EVENT_STATE_OFF)
 		return 0;
 
 	if (!event_filter_match(event))
 		return 0;
 
-	if (group_can_go_on(event, sid->cpuctx, sid->can_add_hw)) {
-		if (!group_sched_in(event, sid->cpuctx, sid->ctx))
-			list_add_tail(&event->active_list, &sid->ctx->pinned_active);
+	if (group_can_go_on(event, cpuctx, 1)) {
+		if (!group_sched_in(event, cpuctx, ctx))
+			list_add_tail(&event->active_list, &ctx->pinned_active);
 	}
 
 	/*
@@ -3323,24 +3432,25 @@ static int pinned_sched_in(struct perf_event *event, void *data)
 	return 0;
 }
 
-static int flexible_sched_in(struct perf_event *event, void *data)
+static int flexible_sched_in(struct perf_event_context *ctx,
+			     struct perf_cpu_context *cpuctx,
+			     struct perf_event *event,
+			     int *can_add_hw)
 {
-	struct sched_in_data *sid = data;
-
 	if (event->state <= PERF_EVENT_STATE_OFF)
 		return 0;
 
 	if (!event_filter_match(event))
 		return 0;
 
-	if (group_can_go_on(event, sid->cpuctx, sid->can_add_hw)) {
-		int ret = group_sched_in(event, sid->cpuctx, sid->ctx);
+	if (group_can_go_on(event, cpuctx, *can_add_hw)) {
+		int ret = group_sched_in(event, cpuctx, ctx);
 		if (ret) {
-			sid->can_add_hw = 0;
-			sid->ctx->rotate_necessary = 1;
+			*can_add_hw = 0;
+			ctx->rotate_necessary = 1;
 			return 0;
 		}
-		list_add_tail(&event->active_list, &sid->ctx->flexible_active);
+		list_add_tail(&event->active_list, &ctx->flexible_active);
 	}
 
 	return 0;
@@ -3350,30 +3460,24 @@ static void
 ctx_pinned_sched_in(struct perf_event_context *ctx,
 		    struct perf_cpu_context *cpuctx)
 {
-	struct sched_in_data sid = {
-		.ctx = ctx,
-		.cpuctx = cpuctx,
-		.can_add_hw = 1,
-	};
-
-	visit_groups_merge(&ctx->pinned_groups,
-			   smp_processor_id(),
-			   pinned_sched_in, &sid);
+	visit_groups_merge(ctx,
+			   cpuctx,
+			   &ctx->pinned_groups,
+			   pinned_sched_in,
+			   NULL);
 }
 
 static void
 ctx_flexible_sched_in(struct perf_event_context *ctx,
 		      struct perf_cpu_context *cpuctx)
 {
-	struct sched_in_data sid = {
-		.ctx = ctx,
-		.cpuctx = cpuctx,
-		.can_add_hw = 1,
-	};
+	int can_add_hw = 1;
 
-	visit_groups_merge(&ctx->flexible_groups,
-			   smp_processor_id(),
-			   flexible_sched_in, &sid);
+	visit_groups_merge(ctx,
+			   cpuctx,
+			   &ctx->flexible_groups,
+			   flexible_sched_in,
+			   &can_add_hw);
 }
 
 static void
-- 
2.22.0.709.g102302147b-goog

