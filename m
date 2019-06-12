Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF6F1C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 10:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 659AB208C2
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 10:57:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="SncEUmuT";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ofVm4CB8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438092AbfFLK5j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 06:57:39 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:33786 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406068AbfFLK5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 06:57:38 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 07775602F4; Wed, 12 Jun 2019 10:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1560337058;
        bh=oOZ98tsfUcMb5kz541ac534SCL+FNkZhdSUmPX7BTHQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SncEUmuTFA95G0lWYfzvqn/+JhytL2ktHBm0/+nodNZXY9tlZ15KX8HcSspTJwuLN
         DaliTKyBRaGsqF829cBYRMOy5Y41JpzTXf6WGVBFVrUCa9jaVRxn8txiHSNTkqkXgI
         o1Kw30eCRgt0o5MmPsqJMSCwiicHnblbsks0c2xM=
Received: from mojha-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A52AA60254;
        Wed, 12 Jun 2019 10:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1560337056;
        bh=oOZ98tsfUcMb5kz541ac534SCL+FNkZhdSUmPX7BTHQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ofVm4CB8H3Sgcc3nJPNFUbDhidsBbx6NoJNicT53OttDsSqE1m6K3Tr63RnmroxUs
         8RadmuexlwURofTdo5sDDv7sCGyPVkmYDApkLJJlNXFaSqfw29flvycOZ4nrbvsvjj
         MV8vh1ILnXNYXt5e6iRBsJCiu6d69foRuAs1Cm70=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A52AA60254
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
From:   Mukesh Ojha <mojha@codeaurora.org>
To:     linux-kernel@vger.kernel.org
Cc:     Mukesh Ojha <mojha@codeaurora.org>,
        Raghavendra Rao Ananta <rananta@codeaurora.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH V3] perf: event preserve and create across cpu hotplug
Date:   Wed, 12 Jun 2019 16:27:25 +0530
Message-Id: <1560337045-13298-1-git-send-email-mojha@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1559309956-32534-2-git-send-email-mojha@codeaurora.org>
References: <1559309956-32534-2-git-send-email-mojha@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Perf framework doesn't allow preserving CPU events across
CPU hotplugs. The events are scheduled out as and when the
CPU walks offline. Moreover, the framework also doesn't
allow the clients to create events on an offline CPU. As
a result, the clients have to keep on monitoring the CPU
state until it comes back online.

Therefore, introducing the perf framework to support creation
and preserving of (CPU) events for offline CPUs. Through
this, the CPU's online state would be transparent to the
client and it not have to worry about monitoring the CPU's
state. Success would be returned to the client even while
creating the event on an offline CPU. If during the lifetime
of the event the CPU walks offline, the event would be
preserved and would continue to count as soon as (and if) the
CPU comes back online.

Co-authored-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Raghavendra Rao Ananta <rananta@codeaurora.org>
Signed-off-by: Mukesh Ojha <mojha@codeaurora.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Alexei Starovoitov <ast@kernel.org>
---
Change in V3:
- Jiri has tried perf stat -a and removed one of the cpu from the other
  terminal. This resulted in a crash. Crash was because in
  event_function_call(), we were passing NULL as cpuctx in 
  func(event, NULL, ctx, data).Fixed it in this patch.

Change in V2:

As per long back discussion happened at
https://lkml.org/lkml/2018/2/15/1324

Peter.Z. has suggested to do thing in different way and shared
patch as well. This patch fixes the issue seen while trying
to achieve the purpose.

Fixed issue on top of Peter's patch:
===================================
1. Added a NULL check on task to avoid crash in __perf_install_in_context.

2. while trying to add event to context when cpu is offline.
   Inside add_event_to_ctx() to make consistent state machine while hotplug.

-event->state += PERF_EVENT_STATE_HOTPLUG_OFFSET;
+event->state = PERF_EVENT_STATE_HOTPLUG_OFFSET;

3. In event_function_call(), added a label 'remove_event_from_ctx' to
   delete events from context list while cpu is offline.

 include/linux/perf_event.h |   1 +
 kernel/events/core.c       | 122 ++++++++++++++++++++++++++++-----------------
 2 files changed, 78 insertions(+), 45 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 3dc01cf..52b14b2 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -511,6 +511,7 @@ enum perf_event_state {
 	PERF_EVENT_STATE_OFF		= -1,
 	PERF_EVENT_STATE_INACTIVE	=  0,
 	PERF_EVENT_STATE_ACTIVE		=  1,
+	PERF_EVENT_STATE_HOTPLUG_OFFSET	= -32,
 };
 
 struct file;
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 118ad1a..7f0bd11 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -248,6 +248,7 @@ static int event_function(void *info)
 static void event_function_call(struct perf_event *event, event_f func, void *data)
 {
 	struct perf_event_context *ctx = event->ctx;
+	struct perf_cpu_context *cpuctx = __get_cpu_context(ctx);
 	struct task_struct *task = READ_ONCE(ctx->task); /* verified in event_function */
 	struct event_function_struct efs = {
 		.event = event,
@@ -264,17 +265,18 @@ static void event_function_call(struct perf_event *event, event_f func, void *da
 		lockdep_assert_held(&ctx->mutex);
 	}
 
-	if (!task) {
-		cpu_function_call(event->cpu, event_function, &efs);
-		return;
-	}
-
 	if (task == TASK_TOMBSTONE)
 		return;
 
 again:
-	if (!task_function_call(task, event_function, &efs))
-		return;
+	if (task) {
+		if (!task_function_call(task, event_function, &efs))
+			return;
+	} else {
+		if (!cpu_function_call(event->cpu, event_function, &efs))
+			return;
+	}
+
 
 	raw_spin_lock_irq(&ctx->lock);
 	/*
@@ -286,11 +288,17 @@ static void event_function_call(struct perf_event *event, event_f func, void *da
 		raw_spin_unlock_irq(&ctx->lock);
 		return;
 	}
+
+	if (!task)
+		goto remove_event_from_ctx;
+
 	if (ctx->is_active) {
 		raw_spin_unlock_irq(&ctx->lock);
 		goto again;
 	}
-	func(event, NULL, ctx, data);
+
+remove_event_from_ctx:
+	func(event, cpuctx, ctx, data);
 	raw_spin_unlock_irq(&ctx->lock);
 }
 
@@ -2310,7 +2318,7 @@ static void perf_set_shadow_time(struct perf_event *event,
 	struct perf_event *event, *partial_group = NULL;
 	struct pmu *pmu = ctx->pmu;
 
-	if (group_event->state == PERF_EVENT_STATE_OFF)
+	if (group_event->state <= PERF_EVENT_STATE_OFF)
 		return 0;
 
 	pmu->start_txn(pmu, PERF_PMU_TXN_ADD);
@@ -2389,6 +2397,14 @@ static int group_can_go_on(struct perf_event *event,
 static void add_event_to_ctx(struct perf_event *event,
 			       struct perf_event_context *ctx)
 {
+	if (!ctx->task) {
+		struct perf_cpu_context *cpuctx =
+			container_of(ctx, struct perf_cpu_context, ctx);
+
+		if (!cpuctx->online)
+			event->state = PERF_EVENT_STATE_HOTPLUG_OFFSET;
+	}
+
 	list_add_event(event, ctx);
 	perf_group_attach(event);
 }
@@ -2576,11 +2592,6 @@ static int  __perf_install_in_context(void *info)
 	 */
 	smp_store_release(&event->ctx, ctx);
 
-	if (!task) {
-		cpu_function_call(cpu, __perf_install_in_context, event);
-		return;
-	}
-
 	/*
 	 * Should not happen, we validate the ctx is still alive before calling.
 	 */
@@ -2619,8 +2630,14 @@ static int  __perf_install_in_context(void *info)
 	 */
 	smp_mb();
 again:
-	if (!task_function_call(task, __perf_install_in_context, event))
-		return;
+
+	if (task) {
+		if (!task_function_call(task, __perf_install_in_context, event))
+			return;
+	} else {
+		if (!cpu_function_call(cpu, __perf_install_in_context, event))
+			return;
+	}
 
 	raw_spin_lock_irq(&ctx->lock);
 	task = ctx->task;
@@ -2637,7 +2654,7 @@ static int  __perf_install_in_context(void *info)
 	 * If the task is not running, ctx->lock will avoid it becoming so,
 	 * thus we can safely install the event.
 	 */
-	if (task_curr(task)) {
+	if (task && task_curr(task)) {
 		raw_spin_unlock_irq(&ctx->lock);
 		goto again;
 	}
@@ -11022,16 +11039,7 @@ static int perf_event_set_clock(struct perf_event *event, clockid_t clk_id)
 	}
 
 	if (!task) {
-		/*
-		 * Check if the @cpu we're creating an event for is online.
-		 *
-		 * We use the perf_cpu_context::ctx::mutex to serialize against
-		 * the hotplug notifiers. See perf_event_{init,exit}_cpu().
-		 */
-		struct perf_cpu_context *cpuctx =
-			container_of(ctx, struct perf_cpu_context, ctx);
-
-		if (!cpuctx->online) {
+		if (!cpu_possible(cpu)) {
 			err = -ENODEV;
 			goto err_locked;
 		}
@@ -11213,15 +11221,7 @@ struct perf_event *
 	}
 
 	if (!task) {
-		/*
-		 * Check if the @cpu we're creating an event for is online.
-		 *
-		 * We use the perf_cpu_context::ctx::mutex to serialize against
-		 * the hotplug notifiers. See perf_event_{init,exit}_cpu().
-		 */
-		struct perf_cpu_context *cpuctx =
-			container_of(ctx, struct perf_cpu_context, ctx);
-		if (!cpuctx->online) {
+		if (!cpu_possible(cpu)) {
 			err = -ENODEV;
 			goto err_unlock;
 		}
@@ -11949,17 +11949,48 @@ static void perf_swevent_init_cpu(unsigned int cpu)
 }
 
 #if defined CONFIG_HOTPLUG_CPU || defined CONFIG_KEXEC_CORE
+static void __perf_event_init_cpu_context(void *__info)
+{
+	struct perf_cpu_context *cpuctx = __info;
+	struct perf_event_context *ctx = &cpuctx->ctx;
+	struct perf_event_context *task_ctx = cpuctx->task_ctx;
+	struct perf_event *event;
+
+	perf_ctx_lock(cpuctx, task_ctx);
+	ctx_sched_out(ctx, cpuctx, EVENT_ALL);
+	if (task_ctx)
+		ctx_sched_out(task_ctx, cpuctx, EVENT_ALL);
+
+	list_for_each_entry_rcu(event, &ctx->event_list, event_entry)
+		perf_event_set_state(event, event->state - PERF_EVENT_STATE_HOTPLUG_OFFSET);
+
+	perf_event_sched_in(cpuctx, task_ctx, current);
+	perf_ctx_unlock(cpuctx, task_ctx);
+}
+
+static void _perf_event_init_cpu_context(int cpu, struct perf_cpu_context *cpuctx)
+{
+	smp_call_function_single(cpu, __perf_event_init_cpu_context, cpuctx, 1);
+}
+
 static void __perf_event_exit_context(void *__info)
 {
-	struct perf_event_context *ctx = __info;
-	struct perf_cpu_context *cpuctx = __get_cpu_context(ctx);
+	struct perf_cpu_context *cpuctx = __info;
+	struct perf_event_context *ctx = &cpuctx->ctx;
+	struct perf_event_context *task_ctx = cpuctx->task_ctx;
 	struct perf_event *event;
 
-	raw_spin_lock(&ctx->lock);
-	ctx_sched_out(ctx, cpuctx, EVENT_TIME);
-	list_for_each_entry(event, &ctx->event_list, event_entry)
-		__perf_remove_from_context(event, cpuctx, ctx, (void *)DETACH_GROUP);
-	raw_spin_unlock(&ctx->lock);
+	perf_ctx_lock(cpuctx, task_ctx);
+	ctx_sched_out(ctx, cpuctx, EVENT_ALL);
+	if (task_ctx)
+		ctx_sched_out(task_ctx, cpuctx, EVENT_ALL);
+
+	list_for_each_entry_rcu(event, &ctx->event_list, event_entry)
+		perf_event_set_state(event,
+			event->state + PERF_EVENT_STATE_HOTPLUG_OFFSET);
+
+	perf_event_sched_in(cpuctx, task_ctx, current);
+	perf_ctx_unlock(cpuctx, task_ctx);
 }
 
 static void perf_event_exit_cpu_context(int cpu)
@@ -11974,7 +12005,7 @@ static void perf_event_exit_cpu_context(int cpu)
 		ctx = &cpuctx->ctx;
 
 		mutex_lock(&ctx->mutex);
-		smp_call_function_single(cpu, __perf_event_exit_context, ctx, 1);
+		smp_call_function_single(cpu, __perf_event_exit_context, cpuctx, 1);
 		cpuctx->online = 0;
 		mutex_unlock(&ctx->mutex);
 	}
@@ -11982,7 +12013,7 @@ static void perf_event_exit_cpu_context(int cpu)
 	mutex_unlock(&pmus_lock);
 }
 #else
-
+static void _perf_event_init_cpu_context(int cpu, struct perf_cpu_context *cpuctx) { }
 static void perf_event_exit_cpu_context(int cpu) { }
 
 #endif
@@ -12003,6 +12034,7 @@ int perf_event_init_cpu(unsigned int cpu)
 
 		mutex_lock(&ctx->mutex);
 		cpuctx->online = 1;
+		_perf_event_init_cpu_context(cpu, cpuctx);
 		mutex_unlock(&ctx->mutex);
 	}
 	mutex_unlock(&pmus_lock);
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center,
Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project

