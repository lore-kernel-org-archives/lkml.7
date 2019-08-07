Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDBBEC433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 18:36:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B819721E6C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 18:36:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389320AbfHGSgy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 14:36:54 -0400
Received: from mga04.intel.com ([192.55.52.120]:11851 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389057AbfHGSgy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 14:36:54 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Aug 2019 11:36:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,358,1559545200"; 
   d="scan'208";a="179586545"
Received: from otc-lr-04.jf.intel.com ([10.54.39.121])
  by orsmga006.jf.intel.com with ESMTP; 07 Aug 2019 11:36:51 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, tglx@linutronix.de, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     eranian@google.com, irogers@google.com, tj@kernel.org,
        mark.rutland@arm.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V3] perf/cgroup: Do not switch system-wide events in cgroup switch
Date:   Wed,  7 Aug 2019 11:36:29 -0700
Message-Id: <1565202989-47799-1-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

When counting system-wide events and cgroup events simultaneously, the
system-wide events are always scheduled during cgroup switch, which is
wrong and brings extra overhead.

Both system-wide and cgroup are per-cpu. They share the same cpuctx
groups, cpuctx->flexible_groups/pinned_groups.
In context switch, cgroup switch tries to schedule all the events from
the cpuctx groups. The unmatched cgroup events can be filtered by its
event->cgrp. However, system-wide events, which event->cgrp is NULL, are
unconditionally scheduled. It will bring extra overhead. Furthermore,
the small period between the prev cgroup schedule out and the new cgroup
schedule in will be missed for system-wide events.

Add new event type EVENT_CGROUP_FLEXIBLE_ONLY, EVENT_CGROUP_PINNED_ONLY,
and EVENT_CGROUP_ALL_ONLY.
- EVENT_FLEXIBLE | EVENT_CGROUP_FLEXIBLE_ONLY: Only switch cgroup
  events from EVENT_FLEXIBLE groups.
- EVENT_PINNED | EVENT_CGROUP_PINNED_ONLY: Only switch cgroup events
  from EVENT_PINNED groups.
- EVENT_ALL | EVENT_CGROUP_ALL_ONLY: Only switch cgroup events from both
  EVENT_FLEXIBLE and EVENT_PINNED groups.
For cgroup schedule out, only cgroup events are scheduled out now.
For cgroup schedule in, to keep the priority order (cpu pinned, cpu
flexible), the event type of the new cgroup has to be checked.
If the new cgroup and its ancestor have pinned events, the flexible
system-wide events have to be scheduled out before all events schedule
in, which give the pinned events the best chance to be scheduled.
Otherwise, only cgroup events are scheduled in.
Add nr_pinned_event to track the number of pinned event in a cgroup.

Here is test with 6 child cgroups (sibling cgroups), 1 parent cgroup
and system-wide events.
A specjbb benchmark is running in each child cgroup.
The perf command is as below.
   perf stat -e cycles,instructions -e cycles,instructions
   -e cycles,instructions -e cycles,instructions
   -e cycles,instructions -e cycles,instructions
   -e cycles,instructions -e cycles,instructions
   -G cgroup1,cgroup1,cgroup2,cgroup2,cgroup3,cgroup3
   -G cgroup4,cgroup4,cgroup5,cgroup5,cgroup6,cgroup6
   -G cgroup_parent,cgroup_parent
   -a -e cycles,instructions -I 1000

The average RT (Response Time) reported from specjbb is
used as key performance metrics. (The lower the better)
                                        RT(us)              Overhead
Baseline (no perf stat):                4286.9
Use cgroup perf, no patches:            4537.1                5.84%
Use cgroup perf, apply the patch:       4440.7                3.59%

Fixes: e5d1367f17ba ("perf: Add cgroup support")
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

The patch is originally from ("Optimize cgroup context switch") series.
https://lkml.kernel.org/r/1557954092-67275-1-git-send-email-kan.liang@linux.intel.com
The series tried to address two issues.
1. System-wide events are mistakenly scheduled during cgroup context switch.
2. The cgroup context switch sched_in is low efficient.

Now, Ian Rogers has taken over the patches for the second issue.
https://lkml.kernel.org/r/20190724223746.153620-1-irogers@google.com

This patch is to fix the first issue.

Changes since V2:
- Modify the change log.
  Move the performance data from cover letter into changelog.
- Add nr_pinned_event to track the number of pinned event in a cgroup.
  Check the pinned event for the new cgroup and its ancestor before schedule in.

 include/linux/perf_event.h |   1 +
 kernel/events/core.c       | 126 +++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 116 insertions(+), 11 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index e8ad3c5..ebb27ed 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -843,6 +843,7 @@ struct perf_cgroup_info {
 struct perf_cgroup {
 	struct cgroup_subsys_state	css;
 	struct perf_cgroup_info	__percpu *info;
+	unsigned int			nr_pinned_event;
 };
 
 /*
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 0463c11..64b4cf9 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -361,8 +361,18 @@ enum event_type_t {
 	/* see ctx_resched() for details */
 	EVENT_CPU = 0x8,
 	EVENT_ALL = EVENT_FLEXIBLE | EVENT_PINNED,
+
+	/* see perf_cgroup_switch() for details */
+	EVENT_CGROUP_FLEXIBLE_ONLY = 0x10,
+	EVENT_CGROUP_PINNED_ONLY = 0x20,
+	EVENT_CGROUP_ALL_ONLY = EVENT_CGROUP_FLEXIBLE_ONLY |
+				EVENT_CGROUP_PINNED_ONLY,
+
 };
 
+#define CGROUP_PINNED(type)	(type & EVENT_CGROUP_PINNED_ONLY)
+#define CGROUP_FLEXIBLE(type)	(type & EVENT_CGROUP_FLEXIBLE_ONLY)
+
 /*
  * perf_sched_events : >0 events exist
  * perf_cgroup_events: >0 per-cpu cgroup events exist on this cpu
@@ -667,6 +677,18 @@ perf_event_set_state(struct perf_event *event, enum perf_event_state state)
 
 #ifdef CONFIG_CGROUP_PERF
 
+/* Skip the system-wide event if only cgroup events are required. */
+static inline bool
+perf_cgroup_skip_switch(enum event_type_t event_type,
+			struct perf_event *event,
+			bool pinned)
+{
+	if (pinned)
+		return !!CGROUP_PINNED(event_type) && !event->cgrp;
+	else
+		return !!CGROUP_FLEXIBLE(event_type) && !event->cgrp;
+}
+
 static inline bool
 perf_cgroup_match(struct perf_event *event)
 {
@@ -693,6 +715,8 @@ perf_cgroup_match(struct perf_event *event)
 
 static inline void perf_detach_cgroup(struct perf_event *event)
 {
+	if (event->attr.pinned)
+		event->cgrp->nr_pinned_event--;
 	css_put(&event->cgrp->css);
 	event->cgrp = NULL;
 }
@@ -780,6 +804,22 @@ perf_cgroup_set_timestamp(struct task_struct *task,
 	}
 }
 
+/* Check if cgroup and its ancestor have pinned events attached */
+static bool
+cgroup_has_pinned_events(struct perf_cgroup *cgrp)
+{
+	struct cgroup_subsys_state *css;
+	struct perf_cgroup *tmp_cgrp;
+
+	for (css = &cgrp->css; css; css = css->parent) {
+		tmp_cgrp = container_of(css, struct perf_cgroup, css);
+		if (tmp_cgrp->nr_pinned_event > 0)
+			return true;
+	}
+
+	return false;
+}
+
 static DEFINE_PER_CPU(struct list_head, cgrp_cpuctx_list);
 
 #define PERF_CGROUP_SWOUT	0x1 /* cgroup switch out every event */
@@ -811,7 +851,22 @@ static void perf_cgroup_switch(struct task_struct *task, int mode)
 		perf_pmu_disable(cpuctx->ctx.pmu);
 
 		if (mode & PERF_CGROUP_SWOUT) {
-			cpu_ctx_sched_out(cpuctx, EVENT_ALL);
+			/*
+			 * The system-wide events and cgroup events share
+			 * the same cpuctx groups.
+			 * Decide which events to be switched based on
+			 * the types of events:
+			 * - EVENT_FLEXIBLE | EVENT_CGROUP_FLEXIBLE_ONLY:
+			 *   Only switch cgroup events from EVENT_FLEXIBLE
+			 *   groups.
+			 * - EVENT_PINNED | EVENT_CGROUP_PINNED_ONLY:
+			 *   Only switch cgroup events from EVENT_PINNED
+			 *   groups.
+			 * - EVENT_ALL | EVENT_CGROUP_ALL_ONLY:
+			 *   Only switch cgroup events from both EVENT_FLEXIBLE
+			 *   and EVENT_PINNED groups.
+			 */
+			cpu_ctx_sched_out(cpuctx, EVENT_ALL | EVENT_CGROUP_ALL_ONLY);
 			/*
 			 * must not be done before ctxswout due
 			 * to event_filter_match() in event_sched_out()
@@ -830,7 +885,19 @@ static void perf_cgroup_switch(struct task_struct *task, int mode)
 			 */
 			cpuctx->cgrp = perf_cgroup_from_task(task,
 							     &cpuctx->ctx);
-			cpu_ctx_sched_in(cpuctx, EVENT_ALL, task);
+
+			/*
+			 * To keep the following priority order:
+			 * cpu pinned, cpu flexible,
+			 * if the new cgroup has pinned events,
+			 * sched out all system-wide events from EVENT_FLEXIBLE
+			 * groups before sched in all events.
+			 */
+			if (cgroup_has_pinned_events(cpuctx->cgrp)) {
+				cpu_ctx_sched_out(cpuctx, EVENT_FLEXIBLE);
+				cpu_ctx_sched_in(cpuctx, EVENT_ALL | EVENT_CGROUP_PINNED_ONLY, task);
+			} else
+				cpu_ctx_sched_in(cpuctx, EVENT_ALL | EVENT_CGROUP_ALL_ONLY, task);
 		}
 		perf_pmu_enable(cpuctx->ctx.pmu);
 		perf_ctx_unlock(cpuctx, cpuctx->task_ctx);
@@ -913,6 +980,9 @@ static inline int perf_cgroup_connect(int fd, struct perf_event *event,
 	cgrp = container_of(css, struct perf_cgroup, css);
 	event->cgrp = cgrp;
 
+	if (event->attr.pinned)
+		cgrp->nr_pinned_event++;
+
 	/*
 	 * all events in a group must monitor
 	 * the same cgroup because a task belongs
@@ -987,6 +1057,14 @@ list_update_cgroup_event(struct perf_event *event,
 #else /* !CONFIG_CGROUP_PERF */
 
 static inline bool
+perf_cgroup_skip_switch(enum event_type_t event_type,
+			struct perf_event *event,
+			bool pinned)
+{
+	return false;
+}
+
+static inline bool
 perf_cgroup_match(struct perf_event *event)
 {
 	return true;
@@ -2965,13 +3043,23 @@ static void ctx_sched_out(struct perf_event_context *ctx,
 
 	perf_pmu_disable(ctx->pmu);
 	if (is_active & EVENT_PINNED) {
-		list_for_each_entry_safe(event, tmp, &ctx->pinned_active, active_list)
+		list_for_each_entry_safe(event, tmp, &ctx->pinned_active, active_list) {
+			if (perf_cgroup_skip_switch(event_type, event, true)) {
+				ctx->is_active |= EVENT_PINNED;
+				continue;
+			}
 			group_sched_out(event, cpuctx, ctx);
+		}
 	}
 
 	if (is_active & EVENT_FLEXIBLE) {
-		list_for_each_entry_safe(event, tmp, &ctx->flexible_active, active_list)
+		list_for_each_entry_safe(event, tmp, &ctx->flexible_active, active_list) {
+			if (perf_cgroup_skip_switch(event_type, event, false)) {
+				ctx->is_active |= EVENT_FLEXIBLE;
+				continue;
+			}
 			group_sched_out(event, cpuctx, ctx);
+		}
 	}
 	perf_pmu_enable(ctx->pmu);
 }
@@ -3292,6 +3380,7 @@ struct sched_in_data {
 	struct perf_event_context *ctx;
 	struct perf_cpu_context *cpuctx;
 	int can_add_hw;
+	enum event_type_t event_type;
 };
 
 static int pinned_sched_in(struct perf_event *event, void *data)
@@ -3301,6 +3390,9 @@ static int pinned_sched_in(struct perf_event *event, void *data)
 	if (event->state <= PERF_EVENT_STATE_OFF)
 		return 0;
 
+	if (perf_cgroup_skip_switch(sid->event_type, event, true))
+		return 0;
+
 	if (!event_filter_match(event))
 		return 0;
 
@@ -3326,6 +3418,9 @@ static int flexible_sched_in(struct perf_event *event, void *data)
 	if (event->state <= PERF_EVENT_STATE_OFF)
 		return 0;
 
+	if (perf_cgroup_skip_switch(sid->event_type, event, false))
+		return 0;
+
 	if (!event_filter_match(event))
 		return 0;
 
@@ -3344,12 +3439,14 @@ static int flexible_sched_in(struct perf_event *event, void *data)
 
 static void
 ctx_pinned_sched_in(struct perf_event_context *ctx,
-		    struct perf_cpu_context *cpuctx)
+		    struct perf_cpu_context *cpuctx,
+		    enum event_type_t event_type)
 {
 	struct sched_in_data sid = {
 		.ctx = ctx,
 		.cpuctx = cpuctx,
 		.can_add_hw = 1,
+		.event_type = event_type,
 	};
 
 	visit_groups_merge(&ctx->pinned_groups,
@@ -3359,12 +3456,14 @@ ctx_pinned_sched_in(struct perf_event_context *ctx,
 
 static void
 ctx_flexible_sched_in(struct perf_event_context *ctx,
-		      struct perf_cpu_context *cpuctx)
+		      struct perf_cpu_context *cpuctx,
+		      enum event_type_t event_type)
 {
 	struct sched_in_data sid = {
 		.ctx = ctx,
 		.cpuctx = cpuctx,
 		.can_add_hw = 1,
+		.event_type = event_type,
 	};
 
 	visit_groups_merge(&ctx->flexible_groups,
@@ -3378,6 +3477,7 @@ ctx_sched_in(struct perf_event_context *ctx,
 	     enum event_type_t event_type,
 	     struct task_struct *task)
 {
+	enum event_type_t ctx_event_type = event_type & EVENT_ALL;
 	int is_active = ctx->is_active;
 	u64 now;
 
@@ -3386,7 +3486,7 @@ ctx_sched_in(struct perf_event_context *ctx,
 	if (likely(!ctx->nr_events))
 		return;
 
-	ctx->is_active |= (event_type | EVENT_TIME);
+	ctx->is_active |= (ctx_event_type | EVENT_TIME);
 	if (ctx->task) {
 		if (!is_active)
 			cpuctx->task_ctx = ctx;
@@ -3406,13 +3506,17 @@ ctx_sched_in(struct perf_event_context *ctx,
 	/*
 	 * First go through the list and put on any pinned groups
 	 * in order to give them the best chance of going on.
+	 *
+	 * System-wide events may not be sched out in cgroup switch.
+	 * Unconditionally call sched_in() for cgroup events only switch.
+	 * The sched_in() will filter the events.
 	 */
-	if (is_active & EVENT_PINNED)
-		ctx_pinned_sched_in(ctx, cpuctx);
+	if ((is_active & EVENT_PINNED) || CGROUP_PINNED(event_type))
+		ctx_pinned_sched_in(ctx, cpuctx, CGROUP_PINNED(event_type));
 
 	/* Then walk through the lower prio flexible groups */
-	if (is_active & EVENT_FLEXIBLE)
-		ctx_flexible_sched_in(ctx, cpuctx);
+	if ((is_active & EVENT_FLEXIBLE) || CGROUP_FLEXIBLE(event_type))
+		ctx_flexible_sched_in(ctx, cpuctx, CGROUP_FLEXIBLE(event_type));
 }
 
 static void cpu_ctx_sched_in(struct perf_cpu_context *cpuctx,
-- 
2.7.4

