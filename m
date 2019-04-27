Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE97C43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 677A620C01
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556329244;
	bh=thuLaB9hqWXQtSFwUPRbpUOLQ1cl+mUCiufuQoIJULQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iYoDTTN35WOQLdESabzGIxCAhZaFcSFVVfRgVX1MEQwdu2g7ptYvArkjukFMfLeaP
	 SmpPnrPi7z2lzOP+Ql3Z6WWbMnfO5URJfEL7tZnSJ7n4kcycjyj0ViUyKIIgALJC52
	 sz+z1ELEUMF1C0GWt5GFP0ErQxuoGck1RtPrpgJc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbfD0Bkn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 21:40:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:44346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728042AbfD0Bkj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 21:40:39 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C4A2321655;
        Sat, 27 Apr 2019 01:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556329238;
        bh=thuLaB9hqWXQtSFwUPRbpUOLQ1cl+mUCiufuQoIJULQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qcOpl+BF9OcnHvSxZkq/pJfeSDB2xAwu06aSVGoZcgMHMEBAxjoSgIqhjpRtqSCWd
         yhQkB8OEem7sWSUNgVCKeqW35jHJMjh9Sv5QMRhHJh4QtmIttjGlEaI+C3JFbl4rYT
         BzdlSMHHT2VOEeMwh5TMsjH0NOZQ1rrjfEu6gV/Q=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.0 74/79] perf/core: Fix perf_event_disable_inatomic() race
Date:   Fri, 26 Apr 2019 21:38:33 -0400
Message-Id: <20190427013838.6596-74-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190427013838.6596-1-sashal@kernel.org>
References: <20190427013838.6596-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

[ Upstream commit 1d54ad944074010609562da5c89e4f5df2f4e5db ]

Thomas-Mich Richter reported he triggered a WARN()ing from event_function_local()
on his s390. The problem boils down to:

	CPU-A				CPU-B

	perf_event_overflow()
	  perf_event_disable_inatomic()
	    @pending_disable = 1
	    irq_work_queue();

	sched-out
	  event_sched_out()
	    @pending_disable = 0

					sched-in
					perf_event_overflow()
					  perf_event_disable_inatomic()
					    @pending_disable = 1;
					    irq_work_queue(); // FAILS

	irq_work_run()
	  perf_pending_event()
	    if (@pending_disable)
	      perf_event_disable_local(); // WHOOPS

The problem exists in generic, but s390 is particularly sensitive
because it doesn't implement arch_irq_work_raise(), nor does it call
irq_work_run() from it's PMU interrupt handler (nor would that be
sufficient in this case, because s390 also generates
perf_event_overflow() from pmu::stop). Add to that the fact that s390
is a virtual architecture and (virtual) CPU-A can stall long enough
for the above race to happen, even if it would self-IPI.

Adding a irq_work_sync() to event_sched_in() would work for all hardare
PMUs that properly use irq_work_run() but fails for software PMUs.

Instead encode the CPU number in @pending_disable, such that we can
tell which CPU requested the disable. This then allows us to detect
the above scenario and even redirect the IPI to make up for the failed
queue.

Reported-by: Thomas-Mich Richter <tmricht@linux.ibm.com>
Tested-by: Thomas Richter <tmricht@linux.ibm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Hendrik Brueckner <brueckner@linux.ibm.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/events/core.c        | 52 ++++++++++++++++++++++++++++++-------
 kernel/events/ring_buffer.c |  4 +--
 2 files changed, 45 insertions(+), 11 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 2e2305a81047..124e1e3d06b9 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2007,8 +2007,8 @@ event_sched_out(struct perf_event *event,
 	event->pmu->del(event, 0);
 	event->oncpu = -1;
 
-	if (event->pending_disable) {
-		event->pending_disable = 0;
+	if (READ_ONCE(event->pending_disable) >= 0) {
+		WRITE_ONCE(event->pending_disable, -1);
 		state = PERF_EVENT_STATE_OFF;
 	}
 	perf_event_set_state(event, state);
@@ -2196,7 +2196,8 @@ EXPORT_SYMBOL_GPL(perf_event_disable);
 
 void perf_event_disable_inatomic(struct perf_event *event)
 {
-	event->pending_disable = 1;
+	WRITE_ONCE(event->pending_disable, smp_processor_id());
+	/* can fail, see perf_pending_event_disable() */
 	irq_work_queue(&event->pending);
 }
 
@@ -5803,10 +5804,45 @@ void perf_event_wakeup(struct perf_event *event)
 	}
 }
 
+static void perf_pending_event_disable(struct perf_event *event)
+{
+	int cpu = READ_ONCE(event->pending_disable);
+
+	if (cpu < 0)
+		return;
+
+	if (cpu == smp_processor_id()) {
+		WRITE_ONCE(event->pending_disable, -1);
+		perf_event_disable_local(event);
+		return;
+	}
+
+	/*
+	 *  CPU-A			CPU-B
+	 *
+	 *  perf_event_disable_inatomic()
+	 *    @pending_disable = CPU-A;
+	 *    irq_work_queue();
+	 *
+	 *  sched-out
+	 *    @pending_disable = -1;
+	 *
+	 *				sched-in
+	 *				perf_event_disable_inatomic()
+	 *				  @pending_disable = CPU-B;
+	 *				  irq_work_queue(); // FAILS
+	 *
+	 *  irq_work_run()
+	 *    perf_pending_event()
+	 *
+	 * But the event runs on CPU-B and wants disabling there.
+	 */
+	irq_work_queue_on(&event->pending, cpu);
+}
+
 static void perf_pending_event(struct irq_work *entry)
 {
-	struct perf_event *event = container_of(entry,
-			struct perf_event, pending);
+	struct perf_event *event = container_of(entry, struct perf_event, pending);
 	int rctx;
 
 	rctx = perf_swevent_get_recursion_context();
@@ -5815,10 +5851,7 @@ static void perf_pending_event(struct irq_work *entry)
 	 * and we won't recurse 'further'.
 	 */
 
-	if (event->pending_disable) {
-		event->pending_disable = 0;
-		perf_event_disable_local(event);
-	}
+	perf_pending_event_disable(event);
 
 	if (event->pending_wakeup) {
 		event->pending_wakeup = 0;
@@ -9998,6 +10031,7 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 
 
 	init_waitqueue_head(&event->waitq);
+	event->pending_disable = -1;
 	init_irq_work(&event->pending, perf_pending_event);
 
 	mutex_init(&event->mmap_mutex);
diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index 878c62ec0190..015a9f3b893e 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -393,7 +393,7 @@ void *perf_aux_output_begin(struct perf_output_handle *handle,
 		 * store that will be enabled on successful return
 		 */
 		if (!handle->size) { /* A, matches D */
-			event->pending_disable = 1;
+			event->pending_disable = smp_processor_id();
 			perf_output_wakeup(handle);
 			local_set(&rb->aux_nest, 0);
 			goto err_put;
@@ -481,7 +481,7 @@ void perf_aux_output_end(struct perf_output_handle *handle, unsigned long size)
 
 	if (wakeup) {
 		if (handle->aux_flags & PERF_AUX_FLAG_TRUNCATED)
-			handle->event->pending_disable = 1;
+			handle->event->pending_disable = smp_processor_id();
 		perf_output_wakeup(handle);
 	}
 
-- 
2.19.1

