Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73B6FC76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 22:38:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E88121911
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 22:38:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XmXePXfJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387712AbfGXWif (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 18:38:35 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:38328 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387405AbfGXWie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 18:38:34 -0400
Received: by mail-qt1-f201.google.com with SMTP id r58so42861303qtb.5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 15:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=BHNx3fxgIAaIZGtj0Y4teHviUd3zpJGTp0ZxFmiQ/M0=;
        b=XmXePXfJ2+b7OUYzjP8p2v6gnrwa5zdmWN8+PDRLb8CqPxvZ22ID60Gv59vneL7oTf
         KckiJ5iuorOO5+NLBP3dzRW4snrMCDzGoSE15J1dBmz1xhbCSIm5c4OZLnquNY15UrUq
         lImHlPD5pLZCsxebTLqvl44y8N+f9qOm9FJJBG5KseIbB5i9R/tsWo7fCSyRB4bCsgVv
         Uybu1AXXlMuebS8GiNjJ/sxQFpn4yHDnikQCckjHWRUkEPRtnwlw61ZwIx8eNwK0fK2p
         mK8Mq9GF97FXQpHNVs20nzs/xHIVFZA2wCw4V/uZAGOG0nqbz/44qxrmmgyOEMbF+Vwg
         jCXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=BHNx3fxgIAaIZGtj0Y4teHviUd3zpJGTp0ZxFmiQ/M0=;
        b=O4l5DT+i3ou9aO2dpeXh+yE+4VR+tQPMZaDGL7LF5DfAvzMm9gEr3duX2Bb1Oy1EdS
         hH5rUZtQYJ2NaP3E/qINSfABnH3heHunGnoDzeXbCGULEczvoKIXsaNCw0JJGr2uG9wf
         8XEqs2/OxY/h2DjleN5aSuG+/4YhKFYRRRa6EhkSp8y7bV9IHxaeIZ/v6CrOnrGO9o+j
         krdnFwUQzlEAAk6y7MVYoe1G+nPnIg7g7W3+DAbzJETXZPBkfVZzWcVHd9tuoirqGdvl
         aDDeA0eiRJih4iJKgJ0FPPjf7TMW+AI0FrLM5AnoQL//ooGdz9Rbq+TyBZsYeaQkGpas
         mLrA==
X-Gm-Message-State: APjAAAWQWYx6umn4Veo7qTmSq1kkjChX14xplK8chwuUZLSUyhqR0aqx
        i3V8WMA2CoyHmSD4eOKnlYsXiFXylKgI
X-Google-Smtp-Source: APXvYqzS8EaBfAyHfmhTPGBmLpocc3q6DpRU2TN+O6nBia67EsTg1jvOZNjuKclRFnUX5YSY/7abG8O0GWqZ
X-Received: by 2002:a0c:ba0b:: with SMTP id w11mr61057366qvf.71.1564007913001;
 Wed, 24 Jul 2019 15:38:33 -0700 (PDT)
Date:   Wed, 24 Jul 2019 15:37:40 -0700
In-Reply-To: <20190724223746.153620-1-irogers@google.com>
Message-Id: <20190724223746.153620-2-irogers@google.com>
Mime-Version: 1.0
References: <20190702065955.165738-1-irogers@google.com> <20190724223746.153620-1-irogers@google.com>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
Subject: [PATCH v2 1/7] perf: propagate perf_install_in_context errors up
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
 kernel/events/core.c | 39 ++++++++++++++++++++++++++-------------
 1 file changed, 26 insertions(+), 13 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index eea9d52b010c..84a22a5c88b0 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2561,11 +2561,12 @@ static bool exclusive_event_installable(struct perf_event *event,
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
@@ -2582,15 +2583,15 @@ perf_install_in_context(struct perf_event_context *ctx,
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
@@ -2624,9 +2625,11 @@ perf_install_in_context(struct perf_event_context *ctx,
 	 */
 	smp_mb();
 again:
-	if (!task_function_call(task, __perf_install_in_context, event))
-		return;
+	err = task_function_call(task, __perf_install_in_context, event);
+	if (!err)
+		return 0;
 
+	WARN_ON_ONCE(err != -ESRCH);
 	raw_spin_lock_irq(&ctx->lock);
 	task = ctx->task;
 	if (WARN_ON_ONCE(task == TASK_TOMBSTONE)) {
@@ -2636,7 +2639,7 @@ perf_install_in_context(struct perf_event_context *ctx,
 		 * against perf_event_exit_task_context().
 		 */
 		raw_spin_unlock_irq(&ctx->lock);
-		return;
+		return 0;
 	}
 	/*
 	 * If the task is not running, ctx->lock will avoid it becoming so,
@@ -2648,6 +2651,7 @@ perf_install_in_context(struct perf_event_context *ctx,
 	}
 	add_event_to_ctx(event, ctx);
 	raw_spin_unlock_irq(&ctx->lock);
+	return 0;
 }
 
 /*
@@ -11130,7 +11134,9 @@ SYSCALL_DEFINE5(perf_event_open,
 		 */
 		for_each_sibling_event(sibling, group_leader) {
 			perf_event__state_init(sibling);
-			perf_install_in_context(ctx, sibling, sibling->cpu);
+			err = perf_install_in_context(ctx, sibling,
+						      sibling->cpu);
+			WARN_ON_ONCE(err);
 			get_ctx(ctx);
 		}
 
@@ -11140,7 +11146,9 @@ SYSCALL_DEFINE5(perf_event_open,
 		 * startup state, ready to be add into new context.
 		 */
 		perf_event__state_init(group_leader);
-		perf_install_in_context(ctx, group_leader, group_leader->cpu);
+		err = perf_install_in_context(ctx, group_leader,
+					      group_leader->cpu);
+		WARN_ON_ONCE(err);
 		get_ctx(ctx);
 	}
 
@@ -11155,7 +11163,8 @@ SYSCALL_DEFINE5(perf_event_open,
 
 	event->owner = current;
 
-	perf_install_in_context(ctx, event, event->cpu);
+	err = perf_install_in_context(ctx, event, event->cpu);
+	WARN_ON_ONCE(err);
 	perf_unpin_context(ctx);
 
 	if (move_group)
@@ -11274,7 +11283,8 @@ perf_event_create_kernel_counter(struct perf_event_attr *attr, int cpu,
 		goto err_unlock;
 	}
 
-	perf_install_in_context(ctx, event, cpu);
+	err = perf_install_in_context(ctx, event, cpu);
+	WARN_ON_ONCE(err);
 	perf_unpin_context(ctx);
 	mutex_unlock(&ctx->mutex);
 
@@ -11297,6 +11307,7 @@ void perf_pmu_migrate_context(struct pmu *pmu, int src_cpu, int dst_cpu)
 	struct perf_event_context *dst_ctx;
 	struct perf_event *event, *tmp;
 	LIST_HEAD(events);
+	int err;
 
 	src_ctx = &per_cpu_ptr(pmu->pmu_cpu_context, src_cpu)->ctx;
 	dst_ctx = &per_cpu_ptr(pmu->pmu_cpu_context, dst_cpu)->ctx;
@@ -11335,7 +11346,8 @@ void perf_pmu_migrate_context(struct pmu *pmu, int src_cpu, int dst_cpu)
 		if (event->state >= PERF_EVENT_STATE_OFF)
 			event->state = PERF_EVENT_STATE_INACTIVE;
 		account_event_cpu(event, dst_cpu);
-		perf_install_in_context(dst_ctx, event, dst_cpu);
+		err = perf_install_in_context(dst_ctx, event, dst_cpu);
+		WARN_ON_ONCE(err);
 		get_ctx(dst_ctx);
 	}
 
@@ -11348,7 +11360,8 @@ void perf_pmu_migrate_context(struct pmu *pmu, int src_cpu, int dst_cpu)
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
2.22.0.709.g102302147b-goog

