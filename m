Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C93ADC5B57D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 07:00:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9324D21721
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 07:00:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PZgwS9aO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726305AbfGBHAZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 03:00:25 -0400
Received: from mail-yb1-f202.google.com ([209.85.219.202]:37408 "EHLO
        mail-yb1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbfGBHAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 03:00:24 -0400
Received: by mail-yb1-f202.google.com with SMTP id z4so1899193ybo.4
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 00:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=DRpVxpKYEuhVQ2R7SXvDNRP8Do9Em+87V8id3oCDFg0=;
        b=PZgwS9aO0TUMKaUyLMaQ08y1R5wKrtrfeTsZft/tdNRlpG1bQhl0wCIa0MSvhqLO/x
         DUKgzxbLEUSPO7h7EjZUrRDafEqhMAHf/srGoP98SusnhKvPYGaWNx+MHDBITWIrsx7d
         UAcSLOth2oL+moRyxWTWA++LLec/YhqSAlKPdNoyKfQy84d2dmxBIqS9U1rLQ1B7RT/S
         Ewu0IRY19lEu7aGL0mf+jDQg+8f2ucWwW86tJXydAzETMzMi8Lqx+qAPfn7WQ7hfCmOE
         rOvBMYbUuG/0KzgnKLQvh4Vld4Guex5tsaT4VzEiU4NyxtulTiAQixJKLLyPNp+d431H
         PoEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=DRpVxpKYEuhVQ2R7SXvDNRP8Do9Em+87V8id3oCDFg0=;
        b=P9deeQPnbNeq3JQ7YAxLp4d/1Xv3KW8AXLlXOkk78SyRe7GbS1yidmLnLn5HfQjijy
         RnLH7BD6bzMEO7nB/EwnEzx98KwpGy4Zb8jAQW+XshGNRDdMvDu78yiROSy4XMeRBHPO
         FTPi3YaYkSYOekipAyi/rAjfnTmWPxXN26SjuyWry45rgy8Xtvq0x2gnSgSQMVabF8qi
         XquRH5x++I8++XrtB2DVQcfP/KrZZ01yJyTq9R/OBh+pkbDTQijJkWtmyHx7l8PyKNLe
         ysc8s6+Aunq8OIsbblNrAsYM6peOFt2bGQlPsDJD6MSMXwRWsrarSLkPJJlVaq3zICir
         s3Xw==
X-Gm-Message-State: APjAAAVNfYA9bpugPXk5OQGenbqztta5XvLxz0crG5Z5VeithdciUA3p
        MZL0ewMO7SQNp1QVjFHGLotcGda21RL9
X-Google-Smtp-Source: APXvYqyDtzJxwLv7clZEmERcM4T59nbfuEfsdMguD3bfLoL26yqqErhI7k5UvXjOsgmPiiMVmkY9Ia4g6Ep/
X-Received: by 2002:a0d:e1c1:: with SMTP id k184mr17335992ywe.153.1562050822661;
 Tue, 02 Jul 2019 00:00:22 -0700 (PDT)
Date:   Mon,  1 Jul 2019 23:59:49 -0700
In-Reply-To: <20190702065955.165738-1-irogers@google.com>
Message-Id: <20190702065955.165738-2-irogers@google.com>
Mime-Version: 1.0
References: <20190702065955.165738-1-irogers@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH 1/7] perf: propagate perf_install_in_context errors up
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

The current __perf_install_in_context can fail and the error is ignored.
Changing __perf_install_in_context can add new failure modes that need
errors propagating up. This change prepares for this.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 kernel/events/core.c | 38 +++++++++++++++++++++++++-------------
 1 file changed, 25 insertions(+), 13 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 785d708f8553..4faa90f5a934 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2558,11 +2558,12 @@ static int  __perf_install_in_context(void *info)
  *
  * Very similar to event_function_call, see comment there.
  */
-static void
+static int
 perf_install_in_context(struct perf_event_context *ctx,
 			struct perf_event *event,
 			int cpu)
 {
+	int err;
 	struct task_struct *task = READ_ONCE(ctx->task);
 
 	lockdep_assert_held(&ctx->mutex);
@@ -2577,15 +2578,15 @@ perf_install_in_context(struct perf_event_context *ctx,
 	smp_store_release(&event->ctx, ctx);
 
 	if (!task) {
-		cpu_function_call(cpu, __perf_install_in_context, event);
-		return;
+		err = cpu_function_call(cpu, __perf_install_in_context, event);
+		return err;
 	}
 
 	/*
 	 * Should not happen, we validate the ctx is still alive before calling.
 	 */
 	if (WARN_ON_ONCE(task == TASK_TOMBSTONE))
-		return;
+		return 0;
 
 	/*
 	 * Installing events is tricky because we cannot rely on ctx->is_active
@@ -2619,8 +2620,9 @@ perf_install_in_context(struct perf_event_context *ctx,
 	 */
 	smp_mb();
 again:
-	if (!task_function_call(task, __perf_install_in_context, event))
-		return;
+	err = task_function_call(task, __perf_install_in_context, event);
+	if (err)
+		return err;
 
 	raw_spin_lock_irq(&ctx->lock);
 	task = ctx->task;
@@ -2631,7 +2633,7 @@ perf_install_in_context(struct perf_event_context *ctx,
 		 * against perf_event_exit_task_context().
 		 */
 		raw_spin_unlock_irq(&ctx->lock);
-		return;
+		return 0;
 	}
 	/*
 	 * If the task is not running, ctx->lock will avoid it becoming so,
@@ -2643,6 +2645,7 @@ perf_install_in_context(struct perf_event_context *ctx,
 	}
 	add_event_to_ctx(event, ctx);
 	raw_spin_unlock_irq(&ctx->lock);
+	return 0;
 }
 
 /*
@@ -11103,7 +11106,9 @@ SYSCALL_DEFINE5(perf_event_open,
 		 */
 		for_each_sibling_event(sibling, group_leader) {
 			perf_event__state_init(sibling);
-			perf_install_in_context(ctx, sibling, sibling->cpu);
+			err = perf_install_in_context(ctx, sibling,
+						      sibling->cpu);
+			WARN_ON_ONCE(err);
 			get_ctx(ctx);
 		}
 
@@ -11113,7 +11118,9 @@ SYSCALL_DEFINE5(perf_event_open,
 		 * startup state, ready to be add into new context.
 		 */
 		perf_event__state_init(group_leader);
-		perf_install_in_context(ctx, group_leader, group_leader->cpu);
+		err = perf_install_in_context(ctx, group_leader,
+					      group_leader->cpu);
+		WARN_ON_ONCE(err);
 		get_ctx(ctx);
 	}
 
@@ -11128,7 +11135,8 @@ SYSCALL_DEFINE5(perf_event_open,
 
 	event->owner = current;
 
-	perf_install_in_context(ctx, event, event->cpu);
+	err = perf_install_in_context(ctx, event, event->cpu);
+	WARN_ON_ONCE(err);
 	perf_unpin_context(ctx);
 
 	if (move_group)
@@ -11247,7 +11255,8 @@ perf_event_create_kernel_counter(struct perf_event_attr *attr, int cpu,
 		goto err_unlock;
 	}
 
-	perf_install_in_context(ctx, event, cpu);
+	err = perf_install_in_context(ctx, event, cpu);
+	WARN_ON_ONCE(err);
 	perf_unpin_context(ctx);
 	mutex_unlock(&ctx->mutex);
 
@@ -11270,6 +11279,7 @@ void perf_pmu_migrate_context(struct pmu *pmu, int src_cpu, int dst_cpu)
 	struct perf_event_context *dst_ctx;
 	struct perf_event *event, *tmp;
 	LIST_HEAD(events);
+	int err;
 
 	src_ctx = &per_cpu_ptr(pmu->pmu_cpu_context, src_cpu)->ctx;
 	dst_ctx = &per_cpu_ptr(pmu->pmu_cpu_context, dst_cpu)->ctx;
@@ -11308,7 +11318,8 @@ void perf_pmu_migrate_context(struct pmu *pmu, int src_cpu, int dst_cpu)
 		if (event->state >= PERF_EVENT_STATE_OFF)
 			event->state = PERF_EVENT_STATE_INACTIVE;
 		account_event_cpu(event, dst_cpu);
-		perf_install_in_context(dst_ctx, event, dst_cpu);
+		err = perf_install_in_context(dst_ctx, event, dst_cpu);
+		WARN_ON_ONCE(err);
 		get_ctx(dst_ctx);
 	}
 
@@ -11321,7 +11332,8 @@ void perf_pmu_migrate_context(struct pmu *pmu, int src_cpu, int dst_cpu)
 		if (event->state >= PERF_EVENT_STATE_OFF)
 			event->state = PERF_EVENT_STATE_INACTIVE;
 		account_event_cpu(event, dst_cpu);
-		perf_install_in_context(dst_ctx, event, dst_cpu);
+		err = perf_install_in_context(dst_ctx, event, dst_cpu);
+		WARN_ON_ONCE(err);
 		get_ctx(dst_ctx);
 	}
 	mutex_unlock(&dst_ctx->mutex);
-- 
2.22.0.410.gd8fdbe21b5-goog

