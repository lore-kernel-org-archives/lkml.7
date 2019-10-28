Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63613CA9EC2
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 12:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 437E3214D9
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 12:43:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbfJ1Mnj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 08:43:39 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44678 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389453AbfJ1Mnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 08:43:33 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iP4Mh-0002Lq-Lh; Mon, 28 Oct 2019 13:43:19 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 4D0131C047C;
        Mon, 28 Oct 2019 13:43:19 +0100 (CET)
Date:   Mon, 28 Oct 2019 12:43:19 -0000
From:   "tip-bot2 for Alexey Budankov" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86: Synchronize PMU task contexts on optimized
 context switches
Cc:     Alexey Budankov <alexey.budankov@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@redhat.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Stephane Eranian <eranian@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <9c6445a9-bdba-ef03-3859-f1f91198f27a@linux.intel.com>
References: <9c6445a9-bdba-ef03-3859-f1f91198f27a@linux.intel.com>
MIME-Version: 1.0
Message-ID: <157226659905.29376.4151373731366750163.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     c2b98a8661514f29a44ebd0925cf4b1503beb48c
Gitweb:        https://git.kernel.org/tip/c2b98a8661514f29a44ebd0925cf4b1503beb48c
Author:        Alexey Budankov <alexey.budankov@linux.intel.com>
AuthorDate:    Wed, 23 Oct 2019 10:13:56 +03:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 28 Oct 2019 12:51:01 +01:00

perf/x86: Synchronize PMU task contexts on optimized context switches

Install Intel specific PMU task context synchronization adapter and
extend optimized context switch path with PMU specific task context
synchronization to fix LBR callstack virtualization on context switches.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Song Liu <songliubraving@fb.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Link: https://lkml.kernel.org/r/9c6445a9-bdba-ef03-3859-f1f91198f27a@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/events/intel/core.c |  7 +++++++
 kernel/events/core.c         | 13 ++++++++++++-
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index bbf6588..dc64b16 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3820,6 +3820,12 @@ static void intel_pmu_sched_task(struct perf_event_context *ctx,
 	intel_pmu_lbr_sched_task(ctx, sched_in);
 }
 
+static void intel_pmu_swap_task_ctx(struct perf_event_context *prev,
+				    struct perf_event_context *next)
+{
+	intel_pmu_lbr_swap_task_ctx(prev, next);
+}
+
 static int intel_pmu_check_period(struct perf_event *event, u64 value)
 {
 	return intel_pmu_has_bts_period(event, value) ? -EINVAL : 0;
@@ -3955,6 +3961,7 @@ static __initconst const struct x86_pmu intel_pmu = {
 
 	.guest_get_msrs		= intel_guest_get_msrs,
 	.sched_task		= intel_pmu_sched_task,
+	.swap_task_ctx		= intel_pmu_swap_task_ctx,
 
 	.check_period		= intel_pmu_check_period,
 
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 0940c88..f48d38b 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -3204,10 +3204,21 @@ static void perf_event_context_sched_out(struct task_struct *task, int ctxn,
 		raw_spin_lock(&ctx->lock);
 		raw_spin_lock_nested(&next_ctx->lock, SINGLE_DEPTH_NESTING);
 		if (context_equiv(ctx, next_ctx)) {
+			struct pmu *pmu = ctx->pmu;
+
 			WRITE_ONCE(ctx->task, next);
 			WRITE_ONCE(next_ctx->task, task);
 
-			swap(ctx->task_ctx_data, next_ctx->task_ctx_data);
+			/*
+			 * PMU specific parts of task perf context can require
+			 * additional synchronization. As an example of such
+			 * synchronization see implementation details of Intel
+			 * LBR call stack data profiling;
+			 */
+			if (pmu->swap_task_ctx)
+				pmu->swap_task_ctx(ctx, next_ctx);
+			else
+				swap(ctx->task_ctx_data, next_ctx->task_ctx_data);
 
 			/*
 			 * RCU_INIT_POINTER here is safe because we've not
