Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94617ECE58D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 12:59:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 751DC218DE
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 12:59:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731348AbfJIM7e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 08:59:34 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50915 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731237AbfJIM7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 08:59:32 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iIBYr-0002pS-6h; Wed, 09 Oct 2019 14:59:25 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 886A01C0270;
        Wed,  9 Oct 2019 14:59:19 +0200 (CEST)
Date:   Wed, 09 Oct 2019 12:59:19 -0000
From:   "tip-bot2 for Song Liu" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/core: Fix corner case in perf_rotate_context()
Cc:     Song Liu <songliubraving@fb.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        <kernel-team@fb.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191008165949.920548-1-songliubraving@fb.com>
References: <20191008165949.920548-1-songliubraving@fb.com>
MIME-Version: 1.0
Message-ID: <157062595948.9978.4521559810702776433.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     7fa343b7fdc4f351de4e3f28d5c285937dd1f42f
Gitweb:        https://git.kernel.org/tip/7fa343b7fdc4f351de4e3f28d5c285937dd1f42f
Author:        Song Liu <songliubraving@fb.com>
AuthorDate:    Tue, 08 Oct 2019 09:59:49 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 09 Oct 2019 12:44:13 +02:00

perf/core: Fix corner case in perf_rotate_context()

In perf_rotate_context(), when the first cpu flexible event fail to
schedule, cpu_rotate is 1, while cpu_event is NULL. Since cpu_event is
NULL, perf_rotate_context will _NOT_ call cpu_ctx_sched_out(), thus
cpuctx->ctx.is_active will have EVENT_FLEXIBLE set. Then, the next
perf_event_sched_in() will skip all cpu flexible events because of the
EVENT_FLEXIBLE bit.

In the next call of perf_rotate_context(), cpu_rotate stays 1, and
cpu_event stays NULL, so this process repeats. The end result is, flexible
events on this cpu will not be scheduled (until another event being added
to the cpuctx).

Here is an easy repro of this issue. On Intel CPUs, where ref-cycles
could only use one counter, run one pinned event for ref-cycles, one
flexible event for ref-cycles, and one flexible event for cycles. The
flexible ref-cycles is never scheduled, which is expected. However,
because of this issue, the cycles event is never scheduled either.

 $ perf stat -e ref-cycles:D,ref-cycles,cycles -C 5 -I 1000

           time             counts unit events
    1.000152973         15,412,480      ref-cycles:D
    1.000152973      <not counted>      ref-cycles     (0.00%)
    1.000152973      <not counted>      cycles         (0.00%)
    2.000486957         18,263,120      ref-cycles:D
    2.000486957      <not counted>      ref-cycles     (0.00%)
    2.000486957      <not counted>      cycles         (0.00%)

To fix this, when the flexible_active list is empty, try rotate the
first event in the flexible_groups. Also, rename ctx_first_active() to
ctx_event_to_rotate(), which is more accurate.

Signed-off-by: Song Liu <songliubraving@fb.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: <kernel-team@fb.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sasha Levin <sashal@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Fixes: 8d5bce0c37fa ("perf/core: Optimize perf_rotate_context() event scheduling")
Link: https://lkml.kernel.org/r/20191008165949.920548-1-songliubraving@fb.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/events/core.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 2b8265a..9ec0b0b 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -3779,11 +3779,23 @@ static void rotate_ctx(struct perf_event_context *ctx, struct perf_event *event)
 	perf_event_groups_insert(&ctx->flexible_groups, event);
 }
 
+/* pick an event from the flexible_groups to rotate */
 static inline struct perf_event *
-ctx_first_active(struct perf_event_context *ctx)
+ctx_event_to_rotate(struct perf_event_context *ctx)
 {
-	return list_first_entry_or_null(&ctx->flexible_active,
-					struct perf_event, active_list);
+	struct perf_event *event;
+
+	/* pick the first active flexible event */
+	event = list_first_entry_or_null(&ctx->flexible_active,
+					 struct perf_event, active_list);
+
+	/* if no active flexible event, pick the first event */
+	if (!event) {
+		event = rb_entry_safe(rb_first(&ctx->flexible_groups.tree),
+				      typeof(*event), group_node);
+	}
+
+	return event;
 }
 
 static bool perf_rotate_context(struct perf_cpu_context *cpuctx)
@@ -3808,9 +3820,9 @@ static bool perf_rotate_context(struct perf_cpu_context *cpuctx)
 	perf_pmu_disable(cpuctx->ctx.pmu);
 
 	if (task_rotate)
-		task_event = ctx_first_active(task_ctx);
+		task_event = ctx_event_to_rotate(task_ctx);
 	if (cpu_rotate)
-		cpu_event = ctx_first_active(&cpuctx->ctx);
+		cpu_event = ctx_event_to_rotate(&cpuctx->ctx);
 
 	/*
 	 * As per the order given at ctx_resched() first 'pop' task flexible
