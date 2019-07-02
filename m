Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7D53C5B57D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 07:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CF032146F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 07:00:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E7ZY8bF2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbfGBHA2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 03:00:28 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:42822 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbfGBHAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 03:00:25 -0400
Received: by mail-pf1-f202.google.com with SMTP id y7so10331023pfy.9
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 00:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=2JtH0sMLDOyMYRKpdEbFwpDdkSG0ukvW55oY3VrO7rg=;
        b=E7ZY8bF2lYYpUQ3ilGVw/9MeH5oePltCLLAvMcBNCe6sQ1Y4McOHES5lcI2diYFvqn
         O7utv6QJNgyinzUJQKMScw8LTuVEdKoJWsieVW69J26t6eGjLVlQaIymXFBM8bMvrKd8
         af0N1/Q0fOYPzFsuWgV7BjtG/dVEzskVbxGM/61FzSQqd17WRyk+xiooOhLvkuQI+7vz
         yWHgHLnP4BPpqqiBmAw77T8/y8ZDwWl5amjwGLfudhDj8UVtKk17h2GySHIgpVkkrjNS
         5LWnB78Nip40bDPCQdVGqU+N/VdEvHFCiPbzqhnBznKVfLYj6PbDoedPF+yqDP3+yK2F
         ZAWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=2JtH0sMLDOyMYRKpdEbFwpDdkSG0ukvW55oY3VrO7rg=;
        b=LMpY//0tLKMGnT8tBldV2yTGewpw53u+LuxfZZAdH98nG8+nyhnR0ZY3eC8B3XUbgC
         Em1TpEx6fcSGcmUhDevS0ocTeIxCJe0ftyvfk2nw7AHVmfiBea6fGB3EogwfLTiGqpzp
         UiaYhSog3FxRgP0b4NwlUAhSMXj3iqJYeiLT+WYnt2zPPWRoO5kMmM9W7X3aEa7kV8F/
         Wl8sWb2XIbQE6R6H/iDY/TehAyNBQlDSI4U1PtVCVBP2vaD00Z3fFaSwG8h9nmfrk3tI
         GIS2ZCB5T+z5lIaCTpuw8mUPbskmHm1kf5H+RBKCgqrQT4GIQUaIknEWGz08mw1EFeTg
         EOfw==
X-Gm-Message-State: APjAAAXYxxrQgkmABSp80LTW8Oam8DMW/LqPY0j43tSTbnKnTLlTJFOs
        Gy3fEMomY9LciFHxNb05iM4i9jex4GUi
X-Google-Smtp-Source: APXvYqyxQVG6BziBdSivrMnMUmPe65ml8hDwiMA1YhfvJYQrN9iSPRiAaiy452fPcFiEZfWrE4q3H5glfTTG
X-Received: by 2002:a63:1b23:: with SMTP id b35mr178211pgb.128.1562050824793;
 Tue, 02 Jul 2019 00:00:24 -0700 (PDT)
Date:   Mon,  1 Jul 2019 23:59:50 -0700
In-Reply-To: <20190702065955.165738-1-irogers@google.com>
Message-Id: <20190702065955.165738-3-irogers@google.com>
Mime-Version: 1.0
References: <20190702065955.165738-1-irogers@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH 2/7] perf/cgroup: order events in RB tree by cgroup id
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
 kernel/events/core.c | 248 ++++++++++++++++++++++++++++++++-----------
 1 file changed, 185 insertions(+), 63 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 4faa90f5a934..9a2ad34184b8 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1530,6 +1530,32 @@ perf_event_groups_less(struct perf_event *left, struct perf_event *right)
 	if (left->cpu > right->cpu)
 		return false;
 
+#ifdef CONFIG_CGROUP_PERF
+	if (left->cgrp != right->cgrp) {
+		if (!left->cgrp)
+			/*
+			 * Left has no cgroup but right does, no cgroups come
+			 * first.
+			 */
+			return true;
+		if (!right->cgrp)
+			/*
+			 * Right has no cgroup but left does, no cgroups come
+			 * first.
+			 */
+			return false;
+		if (left->cgrp->css.cgroup != right->cgrp->css.cgroup) {
+			if (!left->cgrp->css.cgroup)
+				return true;
+			if (!right->cgrp->css.cgroup)
+				return false;
+			/* Two dissimilar cgroups, order by id. */
+			return left->cgrp->css.cgroup->id <
+					right->cgrp->css.cgroup->id;
+		}
+	}
+#endif
+
 	if (left->group_index < right->group_index)
 		return true;
 	if (left->group_index > right->group_index)
@@ -1609,25 +1635,48 @@ del_event_from_groups(struct perf_event *event, struct perf_event_context *ctx)
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
@@ -1640,12 +1689,26 @@ static struct perf_event *
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
@@ -3255,28 +3318,97 @@ static void cpu_ctx_sched_out(struct perf_cpu_context *cpuctx,
 	ctx_sched_out(&cpuctx->ctx, cpuctx, event_type);
 }
 
-static int visit_groups_merge(struct perf_event_groups *groups, int cpu,
-			      int (*func)(struct perf_event *, void *), void *data)
+static int visit_groups_merge(struct perf_event_context *ctx,
+			      struct perf_cpu_context *cpuctx,
+			      struct perf_event_groups *groups,
+			      int (*func)(struct perf_event_context *,
+					  struct perf_cpu_context *,
+					  struct perf_event *,
+					  int *),
+			      int *data)
 {
-	struct perf_event **evt, *evt1, *evt2;
-	int ret;
+#ifndef CONFIG_CGROUP_PERF
+	/*
+	 * Without cgroups, with a task context, iterate over per-CPU and any
+	 * CPU events.
+	 */
+	const int max_itrs = 2;
+#else
+	/*
+	 * The depth of cgroups is limited by MAX_PATH. It is unlikely that this
+	 * many parent-child related cgroups will have perf events
+	 * monitored. Limit the number of cgroup iterators to 16.
+	 */
+	const int max_cgroups_with_events_depth = 16;
+	/*
+	 * With cgroups we either iterate for a task context (per-CPU or any CPU
+	 * events) or for per CPU the global and per cgroup events.
+	 */
+	const int max_itrs = max(2, 1 + max_cgroups_with_events_depth);
+#endif
+	/* The number of iterators in use. */
+	int num_itrs;
+	/*
+	 * A set of iterators, the iterator for the visit is chosen by the
+	 * group_index.
+	 */
+	struct perf_event *itrs[max_itrs];
+	/* A reference to the selected iterator. */
+	struct perf_event **evt;
+	int ret, i, cpu = smp_processor_id();
 
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
+				if (itrs[num_itrs]) {
+					num_itrs++;
+					if (num_itrs == max_itrs) {
+						WARN_ONCE(
+				     max_cgroups_with_events_depth,
+				     "Insufficient iterators for cgroup depth");
+						break;
+					}
+				}
+			}
 		}
+#endif
+	}
 
-		ret = func(*evt, data);
+	while (true) {
+		/* Find lowest group_index event. */
+		evt = NULL;
+		for (i = 0; i < num_itrs; ++i) {
+			if (itrs[i] == NULL)
+				continue;
+			if (evt == NULL ||
+			    itrs[i]->group_index < (*evt)->group_index)
+				evt = &itrs[i];
+		}
+		if (evt == NULL)
+			break;
+
+		ret = func(ctx, cpuctx, *evt, data);
 		if (ret)
 			return ret;
 
@@ -3286,25 +3418,20 @@ static int visit_groups_merge(struct perf_event_groups *groups, int cpu,
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
@@ -3317,24 +3444,25 @@ static int pinned_sched_in(struct perf_event *event, void *data)
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
@@ -3344,30 +3472,24 @@ static void
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
2.22.0.410.gd8fdbe21b5-goog

