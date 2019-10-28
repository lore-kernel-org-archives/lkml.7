Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44D8DCA9EC1
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 12:43:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25C1520578
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 12:43:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389496AbfJ1Mnh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 08:43:37 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44674 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389395AbfJ1Mnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 08:43:32 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iP4Mi-0002Nj-M4; Mon, 28 Oct 2019 13:43:20 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 593761C0482;
        Mon, 28 Oct 2019 13:43:20 +0100 (CET)
Date:   Mon, 28 Oct 2019 12:43:20 -0000
From:   "tip-bot2 for Alexey Budankov" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/core, perf/x86: Introduce swap_task_ctx()
 method at 'struct pmu'
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
In-Reply-To: <9a0aa84a-f062-9b64-3133-373658550c4b@linux.intel.com>
References: <9a0aa84a-f062-9b64-3133-373658550c4b@linux.intel.com>
MIME-Version: 1.0
Message-ID: <157226660008.29376.17028800323168322771.tip-bot2@tip-bot2>
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

Commit-ID:     fc1adfe306b71e094df636012f8c0fed971cad45
Gitweb:        https://git.kernel.org/tip/fc1adfe306b71e094df636012f8c0fed971cad45
Author:        Alexey Budankov <alexey.budankov@linux.intel.com>
AuthorDate:    Wed, 23 Oct 2019 10:11:04 +03:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 28 Oct 2019 12:50:59 +01:00

perf/core, perf/x86: Introduce swap_task_ctx() method at 'struct pmu'

Declare swap_task_ctx() methods at the generic and x86 specific
pmu types to bridge calls to platform specific PMU code on optimized
context switch path between equivalent task perf event contexts.

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
Link: https://lkml.kernel.org/r/9a0aa84a-f062-9b64-3133-373658550c4b@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/events/perf_event.h |  8 ++++++++
 include/linux/perf_event.h   |  9 +++++++++
 2 files changed, 17 insertions(+)

diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index ecacfbf..5384317 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -683,6 +683,14 @@ struct x86_pmu {
 	atomic_t	lbr_exclusive[x86_lbr_exclusive_max];
 
 	/*
+	 * perf task context (i.e. struct perf_event_context::task_ctx_data)
+	 * switch helper to bridge calls from perf/core to perf/x86.
+	 * See struct pmu::swap_task_ctx() usage for examples;
+	 */
+	void		(*swap_task_ctx)(struct perf_event_context *prev,
+					 struct perf_event_context *next);
+
+	/*
 	 * AMD bits
 	 */
 	unsigned int	amd_nb_constraints : 1;
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 4f77b22..011dcbd 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -410,6 +410,15 @@ struct pmu {
 	 */
 	size_t				task_ctx_size;
 
+	/*
+	 * PMU specific parts of task perf event context (i.e. ctx->task_ctx_data)
+	 * can be synchronized using this function. See Intel LBR callstack support
+	 * implementation and Perf core context switch handling callbacks for usage
+	 * examples.
+	 */
+	void (*swap_task_ctx)		(struct perf_event_context *prev,
+					 struct perf_event_context *next);
+					/* optional */
 
 	/*
 	 * Set up pmu-private data structures for an AUX area
