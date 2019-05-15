Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02DE2C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 21:02:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7AED20818
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 21:02:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727800AbfEOVCI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 17:02:08 -0400
Received: from mga11.intel.com ([192.55.52.93]:15270 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726319AbfEOVCF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 17:02:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 May 2019 14:02:05 -0700
X-ExtLoop1: 1
Received: from otc-lr-04.jf.intel.com ([10.54.39.157])
  by fmsmga001.fm.intel.com with ESMTP; 15 May 2019 14:02:05 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, tglx@linutronix.de, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     eranian@google.com, tj@kernel.org, mark.rutland@arm.com,
        irogers@google.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V2 1/4] perf: Fix system-wide events miscounting during cgroup monitoring
Date:   Wed, 15 May 2019 14:01:29 -0700
Message-Id: <1557954092-67275-2-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1557954092-67275-1-git-send-email-kan.liang@linux.intel.com>
References: <1557954092-67275-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

When counting system-wide events and cgroup events simultaneously, the
value of system-wide events are miscounting. For example,

    perf stat -e cycles,instructions -e cycles,instructions -G
cgroup1,cgroup1,cgroup2,cgroup2 -a -e cycles,instructions -I 1000

     1.096265502     12,375,398,872      cycles              cgroup1
     1.096265502      8,396,184,503      instructions        cgroup1
 #    0.10  insn per cycle
     1.096265502    109,609,027,112      cycles              cgroup2
     1.096265502     11,533,690,148      instructions        cgroup2
 #    0.14  insn per cycle
     1.096265502    121,672,937,058      cycles
     1.096265502     19,331,496,727      instructions               #
0.24  insn per cycle

The events are identical events for system-wide and cgroup. The
value of system-wide events is less than the sum of cgroup events,
which is wrong.

Both system-wide and cgroup are per-cpu. They share the same cpuctx
groups, cpuctx->flexible_groups/pinned_groups.
In context switch, cgroup switch tries to schedule all the events from
the cpuctx groups. The unmatched cgroup events can be filtered by its
event->cgrp. However, system-wide events, which event->cgrp is NULL, are
unconditionally switched. So the small period between the prev cgroup
sched_out and the new cgroup sched_in will be missed for system-wide
events.

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
If the new cgroup has pinned events, the flexible system-wide events
have to be scheduled out before all events schedule in, which give the
pinned events the best chance to be scheduled.
Otherwise, only cgroup events are scheduled in.

To track the event type in a cgroup, add cgrp_event_type for cgroup.
The event type of the cgroup and its ancestor is stored.

Fixes: e5d1367f17ba ("perf: Add cgroup support")
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 include/linux/perf_event.h |   1 +
 kernel/events/core.c       | 119 ++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 108 insertions(+), 12 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index e47ef76..3f12937 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -836,6 +836,7 @@ struct perf_cgroup_info {
 struct perf_cgroup {
 	struct cgroup_subsys_state	css;
 	struct perf_cgroup_info	__percpu *info;
+	int				cgrp_event_type;
 };
 
 /*
diff --git a/kernel/events/core.c b/kernel/events/core.c
index dc7dead..e7ca0474 100644
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
@@ -811,7 +833,22 @@ static void perf_cgroup_switch(struct task_struct *task, int mode)
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
@@ -830,7 +867,19 @@ static void perf_cgroup_switch(struct task_struct *task, int mode)
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
+			if (cpuctx->cgrp->cgrp_event_type & EVENT_CGROUP_PINNED_ONLY) {
+				cpu_ctx_sched_out(cpuctx, EVENT_FLEXIBLE);
+				cpu_ctx_sched_in(cpuctx, EVENT_ALL | EVENT_CGROUP_PINNED_ONLY, task);
+			} else
+				cpu_ctx_sched_in(cpuctx, EVENT_ALL | EVENT_CGROUP_ALL_ONLY, task);
 		}
 		perf_pmu_enable(cpuctx->ctx.pmu);
 		perf_ctx_unlock(cpuctx, cpuctx->task_ctx);
@@ -895,7 +944,7 @@ static inline int perf_cgroup_connect(int fd, struct perf_event *event,
 				      struct perf_event_attr *attr,
 				      struct perf_event *group_leader)
 {
-	struct perf_cgroup *cgrp;
+	struct perf_cgroup *cgrp, *tmp_cgrp;
 	struct cgroup_subsys_state *css;
 	struct fd f = fdget(fd);
 	int ret = 0;
@@ -913,6 +962,18 @@ static inline int perf_cgroup_connect(int fd, struct perf_event *event,
 	cgrp = container_of(css, struct perf_cgroup, css);
 	event->cgrp = cgrp;
 
+	if (event->attr.pinned)
+		cgrp->cgrp_event_type |= EVENT_CGROUP_PINNED_ONLY;
+	else
+		cgrp->cgrp_event_type |= EVENT_CGROUP_FLEXIBLE_ONLY;
+
+	/* Inherit cgrp_event_type from its ancestor */
+	for (css = css->parent; css; css = css->parent) {
+		tmp_cgrp = container_of(css, struct perf_cgroup, css);
+		if (tmp_cgrp->cgrp_event_type)
+			cgrp->cgrp_event_type |= tmp_cgrp->cgrp_event_type;
+	}
+
 	/*
 	 * all events in a group must monitor
 	 * the same cgroup because a task belongs
@@ -987,6 +1048,14 @@ list_update_cgroup_event(struct perf_event *event,
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
@@ -2944,13 +3013,23 @@ static void ctx_sched_out(struct perf_event_context *ctx,
 
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
@@ -3271,6 +3350,7 @@ struct sched_in_data {
 	struct perf_event_context *ctx;
 	struct perf_cpu_context *cpuctx;
 	int can_add_hw;
+	enum event_type_t event_type;
 };
 
 static int pinned_sched_in(struct perf_event *event, void *data)
@@ -3280,6 +3360,9 @@ static int pinned_sched_in(struct perf_event *event, void *data)
 	if (event->state <= PERF_EVENT_STATE_OFF)
 		return 0;
 
+	if (perf_cgroup_skip_switch(sid->event_type, event, true))
+		return 0;
+
 	if (!event_filter_match(event))
 		return 0;
 
@@ -3305,6 +3388,9 @@ static int flexible_sched_in(struct perf_event *event, void *data)
 	if (event->state <= PERF_EVENT_STATE_OFF)
 		return 0;
 
+	if (perf_cgroup_skip_switch(sid->event_type, event, false))
+		return 0;
+
 	if (!event_filter_match(event))
 		return 0;
 
@@ -3320,12 +3406,14 @@ static int flexible_sched_in(struct perf_event *event, void *data)
 
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
@@ -3335,12 +3423,14 @@ ctx_pinned_sched_in(struct perf_event_context *ctx,
 
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
@@ -3354,6 +3444,7 @@ ctx_sched_in(struct perf_event_context *ctx,
 	     enum event_type_t event_type,
 	     struct task_struct *task)
 {
+	enum event_type_t ctx_event_type = event_type & EVENT_ALL;
 	int is_active = ctx->is_active;
 	u64 now;
 
@@ -3362,7 +3453,7 @@ ctx_sched_in(struct perf_event_context *ctx,
 	if (likely(!ctx->nr_events))
 		return;
 
-	ctx->is_active |= (event_type | EVENT_TIME);
+	ctx->is_active |= (ctx_event_type | EVENT_TIME);
 	if (ctx->task) {
 		if (!is_active)
 			cpuctx->task_ctx = ctx;
@@ -3382,13 +3473,17 @@ ctx_sched_in(struct perf_event_context *ctx,
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

