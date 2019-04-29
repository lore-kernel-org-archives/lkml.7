Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA74C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 14:45:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0049C20656
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 14:45:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728614AbfD2Op2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 10:45:28 -0400
Received: from mga05.intel.com ([192.55.52.43]:1324 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728596AbfD2OpY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 10:45:24 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Apr 2019 07:45:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,409,1549958400"; 
   d="scan'208";a="154739507"
Received: from otc-lr-04.jf.intel.com ([10.54.39.157])
  by orsmga002.jf.intel.com with ESMTP; 29 Apr 2019 07:45:24 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, tglx@linutronix.de, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     eranian@google.com, tj@kernel.org, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 4/4] perf cgroup: Add fast path for cgroup switch
Date:   Mon, 29 Apr 2019 07:44:05 -0700
Message-Id: <1556549045-71814-5-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556549045-71814-1-git-send-email-kan.liang@linux.intel.com>
References: <1556549045-71814-1-git-send-email-kan.liang@linux.intel.com>
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
pinned/flexible_sched_in() in cgroup context switch.

Don't need event_filter_match() to filter cgroup and CPU in fast path.
Only pmu_filter_match() is enough.

Don't need to specially handle system-wide event anymore.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 kernel/events/core.c | 66 ++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 48 insertions(+), 18 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 5ecc048..16bb705 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -3310,6 +3310,47 @@ static void cpu_ctx_sched_out(struct perf_cpu_context *cpuctx,
 	ctx_sched_out(&cpuctx->ctx, cpuctx, event_type);
 }
 
+struct sched_in_data {
+	struct perf_event_context *ctx;
+	struct perf_cpu_context *cpuctx;
+	int can_add_hw;
+};
+
+#ifdef CONFIG_CGROUP_PERF
+
+static int cgroup_visit_groups_merge(struct perf_event_groups *groups, int cpu,
+				     int (*func)(struct perf_event *, void *, int (*)(struct perf_event *)),
+				     void *data)
+{
+	struct sched_in_data *sid = data;
+	struct cgroup_subsys_state *css;
+	struct perf_cgroup *cgrp;
+	struct perf_event *evt;
+	u64 cgrp_id;
+
+	for (css = &sid->cpuctx->cgrp->css; css; css = css->parent) {
+		/* root cgroup doesn't have events */
+		if (css->id == 1)
+			return 0;
+
+		cgrp = container_of(css, struct perf_cgroup, css);
+		cgrp_id = *this_cpu_ptr(cgrp->cgrp_id);
+		/* Only visit groups when the cgroup has events */
+		if (cgrp_id) {
+			evt = perf_event_groups_first_cgroup(groups, cpu, cgrp_id);
+			while (evt) {
+				if (func(evt, (void *)sid, pmu_filter_match))
+					break;
+				evt = perf_event_groups_next_cgroup(evt);
+			}
+			return 0;
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
@@ -3317,6 +3358,13 @@ static int visit_groups_merge(struct perf_event_groups *groups, int cpu,
 	struct perf_event **evt, *evt1, *evt2;
 	int ret;
 
+#ifdef CONFIG_CGROUP_PERF
+	struct sched_in_data *sid = data;
+
+	/* fast path for cgroup switch */
+	if (sid->cpuctx->cgrp_switch)
+		return cgroup_visit_groups_merge(groups, cpu, func, data);
+#endif
 	evt1 = perf_event_groups_first(groups, -1);
 	evt2 = perf_event_groups_first(groups, cpu);
 
@@ -3342,12 +3390,6 @@ static int visit_groups_merge(struct perf_event_groups *groups, int cpu,
 	return 0;
 }
 
-struct sched_in_data {
-	struct perf_event_context *ctx;
-	struct perf_cpu_context *cpuctx;
-	int can_add_hw;
-};
-
 static int pinned_sched_in(struct perf_event *event, void *data,
 			   int (*filter_match)(struct perf_event *))
 {
@@ -3356,12 +3398,6 @@ static int pinned_sched_in(struct perf_event *event, void *data,
 	if (event->state <= PERF_EVENT_STATE_OFF)
 		return 0;
 
-#ifdef CONFIG_CGROUP_PERF
-	/* Don't sched system-wide event when cgroup context switch */
-	if (sid->cpuctx->cgrp_switch && !event->cgrp)
-		return 0;
-#endif
-
 	if (!filter_match(event))
 		return 0;
 
@@ -3388,12 +3424,6 @@ static int flexible_sched_in(struct perf_event *event, void *data,
 	if (event->state <= PERF_EVENT_STATE_OFF)
 		return 0;
 
-#ifdef CONFIG_CGROUP_PERF
-	/* Don't sched system-wide event when cgroup context switch */
-	if (sid->cpuctx->cgrp_switch && !event->cgrp)
-		return 0;
-#endif
-
 	if (!filter_match(event))
 		return 0;
 
-- 
2.7.4

