Return-Path: <SRS0=TpO6=UA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CCE9C28CC1
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 08:27:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D669527181
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 08:27:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vYykAfrj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbfFAI1k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Jun 2019 04:27:40 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:47405 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbfFAI1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jun 2019 04:27:40 -0400
Received: by mail-qk1-f201.google.com with SMTP id l185so10022771qkd.14
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jun 2019 01:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=tQONZkLtueIJmsrqjg22a3X0z/ivK0PabbnB1bEK3Y4=;
        b=vYykAfrjqYjTeKMaZ4MPs784EdcosVqWPoPPFPctM+cfCPVBLeTsSkvLvV1cgTXdbd
         giKd1ZVTp9JMpAH6ASt4Ga0rKc2Pc9LxkHlNwNOLbxWGfxSueKXeiDkBlFMvNTAJaVhf
         4m+GvSju4ZCDeUBuCY3VRLNEojl+dvuMNR/AMvAOvj2uYXOIgofVZQ9XCLUmFpJXFlm1
         FcUnIaBfCMpi4nrBBA5yxVDbrfJLYmiCTDqy41GHd/bGmPWpr8IbgMqbW4RmiCLBRHgG
         BUluEXQv2FZRGZHuLLL7hM+bZlTGGA/4bEWka8SjzkuDO40UP7Ki2OdYY+gF4n7DdhQO
         j02w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=tQONZkLtueIJmsrqjg22a3X0z/ivK0PabbnB1bEK3Y4=;
        b=I75GTAe2lWUVyeSo2ioOJHuEAS4ByICFsxdleVKjX45eG/cZhjVNMm1xE6PQZwGf1f
         EdFs98kJANz4s25BhWkPUwnXMmu1g1h5Q5J+3H+nHAZ3VyabM2KpPhcrlJTK/cmcBfSr
         baRRq0mqnVpoFDey1TQf9ipC1FOB2QfoBvCA0519/mrGt+MRxlDrN1Y/aErJisZ7Jx89
         gGDt/m6XURMksNHSXpnXSRDLifGsCdAfNxZgQN0/n/B0p/gK4G83BiiWsGo37CvUOQtg
         VZBkfH9Bah13k4hoWALhAoohNMkSSC5UA0K9iQi2IZOfZwsmzoG/xcRnxClbtN5ieX61
         ryig==
X-Gm-Message-State: APjAAAUa9xnW7mG6zjC5OLw0joIyQFZznBp6G+CGS2bI5zz0MUDGJ1cb
        SHINsCp9ICXWhaM7dbFfEusQqmuIJ+ki
X-Google-Smtp-Source: APXvYqyCkApeadO4PTmLMW1ao2cKb52ldut6zqYbockFjYBYyv+PGWM/POjpe++vr3xfEn/mrzhK/dIbfm7w
X-Received: by 2002:a0c:d917:: with SMTP id p23mr12400895qvj.162.1559377658688;
 Sat, 01 Jun 2019 01:27:38 -0700 (PDT)
Date:   Sat,  1 Jun 2019 01:27:22 -0700
Message-Id: <20190601082722.44543-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.rc1.257.g3120a18244-goog
Subject: [PATCH] perf cgroups: Don't rotate events for cgroups unnecessarily
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>, ak@linux.intel.com,
        eranian@google.com
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently perf_rotate_context assumes that if the context's nr_events !=
nr_active a rotation is necessary for perf event multiplexing. With
cgroups, nr_events is the total count of events for all cgroups and
nr_active will not include events in a cgroup other than the current
task's. This makes rotation appear necessary for cgroups when it is not.

Add a perf_event_context flag that is set when rotation is necessary.
Clear the flag during sched_out and set it when a flexible sched_in
fails due to resources.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 include/linux/perf_event.h |  5 +++++
 kernel/events/core.c       | 42 +++++++++++++++++++++++---------------
 2 files changed, 30 insertions(+), 17 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 15a82ff0aefe..7ab6c251aa3d 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -747,6 +747,11 @@ struct perf_event_context {
 	int				nr_stat;
 	int				nr_freq;
 	int				rotate_disable;
+	/*
+	 * Set when nr_events != nr_active, except tolerant to events not
+	 * needing to be active due to scheduling constraints, such as cgroups.
+	 */
+	int				rotate_necessary;
 	refcount_t			refcount;
 	struct task_struct		*task;
 
diff --git a/kernel/events/core.c b/kernel/events/core.c
index abbd4b3b96c2..41ae424b9f1d 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2952,6 +2952,12 @@ static void ctx_sched_out(struct perf_event_context *ctx,
 	if (!ctx->nr_active || !(is_active & EVENT_ALL))
 		return;
 
+	/*
+	 * If we had been multiplexing, no rotations are necessary now no events
+	 * are active.
+	 */
+	ctx->rotate_necessary = 0;
+
 	perf_pmu_disable(ctx->pmu);
 	if (is_active & EVENT_PINNED) {
 		list_for_each_entry_safe(event, tmp, &ctx->pinned_active, active_list)
@@ -3325,6 +3331,15 @@ static int flexible_sched_in(struct perf_event *event, void *data)
 			sid->can_add_hw = 0;
 	}
 
+	/*
+	 * If the group wasn't scheduled then set that multiplexing is necessary
+	 * for the context. Note, this won't be set if the event wasn't
+	 * scheduled due to event_filter_match failing due to the earlier
+	 * return.
+	 */
+	if (event->state == PERF_EVENT_STATE_INACTIVE)
+		sid->ctx->rotate_necessary = 1;
+
 	return 0;
 }
 
@@ -3690,24 +3705,17 @@ ctx_first_active(struct perf_event_context *ctx)
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
@@ -3716,7 +3724,7 @@ static bool perf_rotate_context(struct perf_cpu_context *cpuctx)
 	perf_pmu_disable(cpuctx->ctx.pmu);
 
 	if (task_rotate)
-		task_event = ctx_first_active(ctx);
+		task_event = ctx_first_active(task_ctx);
 	if (cpu_rotate)
 		cpu_event = ctx_first_active(&cpuctx->ctx);
 
@@ -3724,17 +3732,17 @@ static bool perf_rotate_context(struct perf_cpu_context *cpuctx)
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
-- 
2.22.0.rc1.257.g3120a18244-goog

