Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5537C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 21:02:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 830F02082E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 21:02:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbfEOVCV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 17:02:21 -0400
Received: from mga11.intel.com ([192.55.52.93]:15270 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727806AbfEOVCK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 17:02:10 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 May 2019 14:02:10 -0700
X-ExtLoop1: 1
Received: from otc-lr-04.jf.intel.com ([10.54.39.157])
  by fmsmga001.fm.intel.com with ESMTP; 15 May 2019 14:02:10 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, tglx@linutronix.de, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     eranian@google.com, tj@kernel.org, mark.rutland@arm.com,
        irogers@google.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V2 4/4] perf cgroup: Add fast path for cgroup switch
Date:   Wed, 15 May 2019 14:01:32 -0700
Message-Id: <1557954092-67275-5-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1557954092-67275-1-git-send-email-kan.liang@linux.intel.com>
References: <1557954092-67275-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Generic visit_groups_merge() is used in cgroup context switch to sched
in cgroup events, which has high overhead especially in frequent context
switch with several events and cgroups involved. Because it feeds all
events on a given CPU to pinned/flexible_sched_in() regardless the
cgroup.

Add a fast path to only feed the specific cgroup events to
pinned/flexible_sched_in() in cgroup context switch for non-multiplexing
case.

Don't need event_filter_match() to filter cgroup and CPU in fast path.
Only pmu_filter_match() is enough.

Don't need to specially handle system-wide event for fast path. Move it
to slow path.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 kernel/events/core.c | 92 ++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 75 insertions(+), 17 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 6891c74..67b0135 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1780,6 +1780,20 @@ perf_event_groups_first_cgroup(struct perf_event_groups *groups,
 	return match;
 }
 
+static struct perf_event *
+perf_event_groups_next_cgroup(struct perf_event *event)
+{
+	struct perf_event *next;
+
+	next = rb_entry_safe(rb_next(&event->group_node), typeof(*event), group_node);
+	if (next && (next->cpu == event->cpu) &&
+	    (next->cgrp_group_index == event->cgrp_group_index) &&
+	    (next->cgrp_id == event->cgrp_id))
+		return next;
+
+	return NULL;
+}
+
 static void
 perf_event_groups_insert(struct perf_event_groups *groups,
 			 struct perf_event *event)
@@ -3464,13 +3478,69 @@ static void cpu_ctx_sched_out(struct perf_cpu_context *cpuctx,
 	ctx_sched_out(&cpuctx->ctx, cpuctx, event_type);
 }
 
+struct sched_in_data {
+	struct perf_event_context *ctx;
+	struct perf_cpu_context *cpuctx;
+	int can_add_hw;
+	enum event_type_t event_type;
+};
+
+#ifdef CONFIG_CGROUP_PERF
+
+static void cgroup_visit_groups(struct perf_event *evt, void *data,
+				int (*func)(struct perf_event *, void *, int (*)(struct perf_event *)))
+{
+	while (evt) {
+		if (func(evt, (void *)data, pmu_filter_match))
+			break;
+		evt = perf_event_groups_next_cgroup(evt);
+	}
+}
+
+static int cgroup_visit_groups_merge(int cpu, void *data,
+				     int (*func)(struct perf_event *, void *, int (*)(struct perf_event *)))
+{
+	struct sched_in_data *sid = data;
+	struct cgroup_subsys_state *css;
+	struct perf_cgroup *cgrp;
+	struct perf_event *evt, *rotated_evt = NULL;
+
+	for (css = &sid->cpuctx->cgrp->css; css; css = css->parent) {
+		/* root cgroup doesn't have events */
+		if (css->id == 1)
+			return 0;
+
+		cgrp = container_of(css, struct perf_cgroup, css);
+		/* Only visit groups when the cgroup has events */
+		if (cgrp->cgrp_event_type & sid->event_type) {
+			if (CGROUP_PINNED(sid->event_type))
+				evt = *per_cpu_ptr(cgrp->pinned_event, cpu);
+			else {
+				evt = *per_cpu_ptr(cgrp->flexible_event, cpu);
+				rotated_evt = *per_cpu_ptr(cgrp->rotated_event, cpu);
+			}
+			cgroup_visit_groups(evt, data, func);
+			cgroup_visit_groups(rotated_evt, data, func);
+		}
+	}
+
+	return 0;
+}
+#endif
+
 static int visit_groups_merge(struct perf_event_groups *groups, int cpu,
 			      int (*func)(struct perf_event *, void *, int (*)(struct perf_event *)),
 			      void *data)
 {
 	struct perf_event **evt, *evt1, *evt2;
+	struct sched_in_data *sid = data;
 	int ret;
 
+#ifdef CONFIG_CGROUP_PERF
+	/* fast path for cgroup switch, not support multiplexing */
+	if ((sid->event_type) && !sid->cpuctx->hrtimer_active)
+		return cgroup_visit_groups_merge(cpu, data, func);
+#endif
 	evt1 = perf_event_groups_first(groups, -1);
 	evt2 = perf_event_groups_first(groups, cpu);
 
@@ -3486,23 +3556,17 @@ static int visit_groups_merge(struct perf_event_groups *groups, int cpu,
 			evt = &evt2;
 		}
 
-		ret = func(*evt, data, event_filter_match);
-		if (ret)
-			return ret;
-
+		if (!perf_cgroup_skip_switch(sid->event_type, *evt, CGROUP_PINNED(sid->event_type))) {
+			ret = func(*evt, data, event_filter_match);
+			if (ret)
+				return ret;
+		}
 		*evt = perf_event_groups_next(*evt);
 	}
 
 	return 0;
 }
 
-struct sched_in_data {
-	struct perf_event_context *ctx;
-	struct perf_cpu_context *cpuctx;
-	int can_add_hw;
-	enum event_type_t event_type;
-};
-
 static int pinned_sched_in(struct perf_event *event, void *data,
 			   int (*filter_match)(struct perf_event *))
 {
@@ -3511,9 +3575,6 @@ static int pinned_sched_in(struct perf_event *event, void *data,
 	if (event->state <= PERF_EVENT_STATE_OFF)
 		return 0;
 
-	if (perf_cgroup_skip_switch(sid->event_type, event, true))
-		return 0;
-
 	if (!filter_match(event))
 		return 0;
 
@@ -3540,9 +3601,6 @@ static int flexible_sched_in(struct perf_event *event, void *data,
 	if (event->state <= PERF_EVENT_STATE_OFF)
 		return 0;
 
-	if (perf_cgroup_skip_switch(sid->event_type, event, false))
-		return 0;
-
 	if (!filter_match(event))
 		return 0;
 
-- 
2.7.4

