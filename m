Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B480DCA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 12:43:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 920FD214D9
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 12:43:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389516AbfJ1Mnk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 08:43:40 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44679 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389456AbfJ1Mne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 08:43:34 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iP4Mh-0002Ln-Ag; Mon, 28 Oct 2019 13:43:19 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id ED2D41C0081;
        Mon, 28 Oct 2019 13:43:18 +0100 (CET)
Date:   Mon, 28 Oct 2019 12:43:18 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/core: Optimize perf_install_in_event()
Cc:     Andi Kleen <andi@firstfloor.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vince Weaver <vincent.weaver@maine.edu>, acme@kernel.org,
        kan.liang@linux.intel.com, Ingo Molnar <mingo@kernel.org>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <157226659857.29376.5471855612098417861.tip-bot2@tip-bot2>
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

Commit-ID:     db0503e4f6751f2c719d002ba1becd1811633e6e
Gitweb:        https://git.kernel.org/tip/db0503e4f6751f2c719d002ba1becd1811633e6e
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 21 Oct 2019 16:02:39 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 28 Oct 2019 12:51:02 +01:00

perf/core: Optimize perf_install_in_event()

Andi reported that when creating a lot of events, a lot of time is
spent in IPIs and asked if it would be possible to elide some of that.

Now when, as for example the perf-tool always does, events are created
disabled, then these events will not need to be scheduled when added
to the context (they're still disable) and therefore the IPI is not
required -- except for the very first event, that will need to set
ctx->is_active.

( It might be possible to set ctx->is_active remotely for cpu_ctx, but
  we really need the IPI for task_ctx, so lets not make that
  distinction. )

Also use __perf_effective_state() since group events depend on the
state of the leader, if the leader is OFF, the whole group is OFF.

So when sibling events are created enabled (XXX check tool) then we
only need a single IPI to create and enable the whole group (+ that
initial IPI to initialize the context).

Suggested-by: Andi Kleen <andi@firstfloor.org>
Reported-by: Andi Kleen <andi@firstfloor.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Cc: acme@kernel.org
Cc: kan.liang@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/events/core.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index f48d38b..ea70ca6 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2666,6 +2666,25 @@ perf_install_in_context(struct perf_event_context *ctx,
 	 */
 	smp_store_release(&event->ctx, ctx);
 
+	/*
+	 * perf_event_attr::disabled events will not run and can be initialized
+	 * without IPI. Except when this is the first event for the context, in
+	 * that case we need the magic of the IPI to set ctx->is_active.
+	 *
+	 * The IOC_ENABLE that is sure to follow the creation of a disabled
+	 * event will issue the IPI and reprogram the hardware.
+	 */
+	if (__perf_effective_state(event) == PERF_EVENT_STATE_OFF && ctx->nr_events) {
+		raw_spin_lock_irq(&ctx->lock);
+		if (ctx->task == TASK_TOMBSTONE) {
+			raw_spin_unlock_irq(&ctx->lock);
+			return;
+		}
+		add_event_to_ctx(event, ctx);
+		raw_spin_unlock_irq(&ctx->lock);
+		return;
+	}
+
 	if (!task) {
 		cpu_function_call(cpu, __perf_install_in_context, event);
 		return;
