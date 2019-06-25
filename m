Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 190E8C48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 08:47:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8536215EA
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 08:47:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="HHlVD9LC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730870AbfFYIrQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 04:47:16 -0400
Received: from terminus.zytor.com ([198.137.202.136]:57723 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbfFYIrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 04:47:16 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5P8hnJ33533481
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 25 Jun 2019 01:43:49 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5P8hnJ33533481
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561452230;
        bh=UJyWbOXZasfdr0iSMfDvpdwATDMZcJ4qRcAeZiPEYnk=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=HHlVD9LC77vtf0jwXbKfmhcpZnpVrEl7e908yx/GsTqVTbVd2AI0n/adJmlh2lsT+
         GMfckyn5dPkC9gK/RqtX9pm+Z7jcpNRukAdspSBveZiOi/rqLxLsYGmhx5+gd79eIx
         t8RTXlLi49O1XTqUEb8I0pQQ5+SKzUKALJS84mpaDL1qAwrXPVHvq9lyTpTs3DywA4
         Wh7bHQ/dSAmXXP3YEiqfG/8cPQakY6+tHVRy20ioj/yOuAlSbbJ3J69n5VDGijLbMr
         sV23Yoc32jxsGjjJqggxgnhIXj62uybbCYtmtc///OvzDqpQHlOLSG7acK+XDgRBI1
         9del7FNsdQXkg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5P8hnAO3533478;
        Tue, 25 Jun 2019 01:43:49 -0700
Date:   Tue, 25 Jun 2019 01:43:49 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Ian Rogers <tipbot@zytor.com>
Message-ID: <tip-fd7d55172d1e2e501e6da0a5c1de25f06612dc2e@git.kernel.org>
Cc:     hpa@zytor.com, irogers@google.com, tglx@linutronix.de,
        vincent.weaver@maine.edu, peterz@infradead.org, acme@kernel.org,
        jolsa@redhat.com, bp@alien8.de, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        kan.liang@linux.intel.com, acme@redhat.com,
        alexander.shishkin@linux.intel.com, eranian@google.com,
        namhyung@kernel.org
Reply-To: linux-kernel@vger.kernel.org, mingo@kernel.org,
          alexander.shishkin@linux.intel.com, namhyung@kernel.org,
          eranian@google.com, acme@redhat.com, kan.liang@linux.intel.com,
          vincent.weaver@maine.edu, peterz@infradead.org, hpa@zytor.com,
          irogers@google.com, tglx@linutronix.de,
          torvalds@linux-foundation.org, bp@alien8.de, acme@kernel.org,
          jolsa@redhat.com
In-Reply-To: <20190601082722.44543-1-irogers@google.com>
References: <20190601082722.44543-1-irogers@google.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf/cgroups: Don't rotate events for cgroups
 unnecessarily
Git-Commit-ID: fd7d55172d1e2e501e6da0a5c1de25f06612dc2e
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  fd7d55172d1e2e501e6da0a5c1de25f06612dc2e
Gitweb:     https://git.kernel.org/tip/fd7d55172d1e2e501e6da0a5c1de25f06612dc2e
Author:     Ian Rogers <irogers@google.com>
AuthorDate: Sat, 1 Jun 2019 01:27:22 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 24 Jun 2019 19:30:04 +0200

perf/cgroups: Don't rotate events for cgroups unnecessarily

Currently perf_rotate_context assumes that if the context's nr_events !=
nr_active a rotation is necessary for perf event multiplexing. With
cgroups, nr_events is the total count of events for all cgroups and
nr_active will not include events in a cgroup other than the current
task's. This makes rotation appear necessary for cgroups when it is not.

Add a perf_event_context flag that is set when rotation is necessary.
Clear the flag during sched_out and set it when a flexible sched_in
fails due to resources.

Signed-off-by: Ian Rogers <irogers@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Link: https://lkml.kernel.org/r/20190601082722.44543-1-irogers@google.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/perf_event.h |  5 +++++
 kernel/events/core.c       | 42 ++++++++++++++++++++++--------------------
 2 files changed, 27 insertions(+), 20 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 3dc01cf98e16..2ddae518dce6 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -749,6 +749,11 @@ struct perf_event_context {
 	int				nr_stat;
 	int				nr_freq;
 	int				rotate_disable;
+	/*
+	 * Set when nr_events != nr_active, except tolerant to events not
+	 * necessary to be active due to scheduling constraints, such as cgroups.
+	 */
+	int				rotate_necessary;
 	refcount_t			refcount;
 	struct task_struct		*task;
 
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 118ad1aef6af..23efe6792abc 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2952,6 +2952,12 @@ static void ctx_sched_out(struct perf_event_context *ctx,
 	if (!ctx->nr_active || !(is_active & EVENT_ALL))
 		return;
 
+	/*
+	 * If we had been multiplexing, no rotations are necessary, now no events
+	 * are active.
+	 */
+	ctx->rotate_necessary = 0;
+
 	perf_pmu_disable(ctx->pmu);
 	if (is_active & EVENT_PINNED) {
 		list_for_each_entry_safe(event, tmp, &ctx->pinned_active, active_list)
@@ -3319,10 +3325,13 @@ static int flexible_sched_in(struct perf_event *event, void *data)
 		return 0;
 
 	if (group_can_go_on(event, sid->cpuctx, sid->can_add_hw)) {
-		if (!group_sched_in(event, sid->cpuctx, sid->ctx))
-			list_add_tail(&event->active_list, &sid->ctx->flexible_active);
-		else
+		int ret = group_sched_in(event, sid->cpuctx, sid->ctx);
+		if (ret) {
 			sid->can_add_hw = 0;
+			sid->ctx->rotate_necessary = 1;
+			return 0;
+		}
+		list_add_tail(&event->active_list, &sid->ctx->flexible_active);
 	}
 
 	return 0;
@@ -3690,24 +3699,17 @@ ctx_first_active(struct perf_event_context *ctx)
 static bool perf_rotate_context(struct perf_cpu_context *cpuctx)
 {
 	struct perf_event *cpu_event = NULL, *task_event = NULL;
-	bool cpu_rotate = false, task_rotate = false;
-	struct perf_event_context *ctx = NULL;
+	struct perf_event_context *task_ctx = NULL;
+	int cpu_rotate, task_rotate;
 
 	/*
 	 * Since we run this from IRQ context, nobody can install new
 	 * events, thus the event count values are stable.
 	 */
 
-	if (cpuctx->ctx.nr_events) {
-		if (cpuctx->ctx.nr_events != cpuctx->ctx.nr_active)
-			cpu_rotate = true;
-	}
-
-	ctx = cpuctx->task_ctx;
-	if (ctx && ctx->nr_events) {
-		if (ctx->nr_events != ctx->nr_active)
-			task_rotate = true;
-	}
+	cpu_rotate = cpuctx->ctx.rotate_necessary;
+	task_ctx = cpuctx->task_ctx;
+	task_rotate = task_ctx ? task_ctx->rotate_necessary : 0;
 
 	if (!(cpu_rotate || task_rotate))
 		return false;
@@ -3716,7 +3718,7 @@ static bool perf_rotate_context(struct perf_cpu_context *cpuctx)
 	perf_pmu_disable(cpuctx->ctx.pmu);
 
 	if (task_rotate)
-		task_event = ctx_first_active(ctx);
+		task_event = ctx_first_active(task_ctx);
 	if (cpu_rotate)
 		cpu_event = ctx_first_active(&cpuctx->ctx);
 
@@ -3724,17 +3726,17 @@ static bool perf_rotate_context(struct perf_cpu_context *cpuctx)
 	 * As per the order given at ctx_resched() first 'pop' task flexible
 	 * and then, if needed CPU flexible.
 	 */
-	if (task_event || (ctx && cpu_event))
-		ctx_sched_out(ctx, cpuctx, EVENT_FLEXIBLE);
+	if (task_event || (task_ctx && cpu_event))
+		ctx_sched_out(task_ctx, cpuctx, EVENT_FLEXIBLE);
 	if (cpu_event)
 		cpu_ctx_sched_out(cpuctx, EVENT_FLEXIBLE);
 
 	if (task_event)
-		rotate_ctx(ctx, task_event);
+		rotate_ctx(task_ctx, task_event);
 	if (cpu_event)
 		rotate_ctx(&cpuctx->ctx, cpu_event);
 
-	perf_event_sched_in(cpuctx, ctx, current);
+	perf_event_sched_in(cpuctx, task_ctx, current);
 
 	perf_pmu_enable(cpuctx->ctx.pmu);
 	perf_ctx_unlock(cpuctx, cpuctx->task_ctx);
