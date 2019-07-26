Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3DD7C76190
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 21:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 926BB22CBE
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 21:24:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728390AbfGZVYM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 17:24:12 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50433 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728353AbfGZVYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 17:24:09 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hr7hA-00030y-0X; Fri, 26 Jul 2019 23:24:08 +0200
Message-Id: <20190726212124.409766323@linutronix.de>
User-Agent: quilt/0.65
Date:   Fri, 26 Jul 2019 23:19:40 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [patch 4/8] tracing: Use CONFIG_PREEMPTION
References: <20190726211936.226129163@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_PREEMPTION is selected by CONFIG_PREEMPT and by
CONFIG_PREEMPT_RT. Both PREEMPT and PREEMPT_RT require the same
functionality which today depends on CONFIG_PREEMPT.

Switch the conditionals in the tracer over to CONFIG_PREEMPTION.

This is the first step to make the tracer work on RT. The other small
tweaks are submitted separately.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/trace/Kconfig                 |    4 ++--
 kernel/trace/ftrace.c                |    2 +-
 kernel/trace/ring_buffer_benchmark.c |    2 +-
 kernel/trace/trace_events.c          |    4 ++--
 4 files changed, 6 insertions(+), 6 deletions(-)

--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -179,7 +179,7 @@ config TRACE_PREEMPT_TOGGLE
 config PREEMPTIRQ_EVENTS
 	bool "Enable trace events for preempt and irq disable/enable"
 	select TRACE_IRQFLAGS
-	select TRACE_PREEMPT_TOGGLE if PREEMPT
+	select TRACE_PREEMPT_TOGGLE if PREEMPTION
 	select GENERIC_TRACER
 	default n
 	help
@@ -214,7 +214,7 @@ config PREEMPT_TRACER
 	bool "Preemption-off Latency Tracer"
 	default n
 	depends on !ARCH_USES_GETTIMEOFFSET
-	depends on PREEMPT
+	depends on PREEMPTION
 	select GENERIC_TRACER
 	select TRACER_MAX_TRACE
 	select RING_BUFFER_ALLOW_SWAP
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -2814,7 +2814,7 @@ int ftrace_shutdown(struct ftrace_ops *o
 		 * synchornize_rcu_tasks() will wait for those tasks to
 		 * execute and either schedule voluntarily or enter user space.
 		 */
-		if (IS_ENABLED(CONFIG_PREEMPT))
+		if (IS_ENABLED(CONFIG_PREEMPTION))
 			synchronize_rcu_tasks();
 
  free_ops:
--- a/kernel/trace/ring_buffer_benchmark.c
+++ b/kernel/trace/ring_buffer_benchmark.c
@@ -267,7 +267,7 @@ static void ring_buffer_producer(void)
 		if (consumer && !(cnt % wakeup_interval))
 			wake_up_process(consumer);
 
-#ifndef CONFIG_PREEMPT
+#ifndef CONFIG_PREEMPTION
 		/*
 		 * If we are a non preempt kernel, the 10 second run will
 		 * stop everything while it runs. Instead, we will call
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -255,12 +255,12 @@ void *trace_event_buffer_reserve(struct
 	local_save_flags(fbuffer->flags);
 	fbuffer->pc = preempt_count();
 	/*
-	 * If CONFIG_PREEMPT is enabled, then the tracepoint itself disables
+	 * If CONFIG_PREEMPTION is enabled, then the tracepoint itself disables
 	 * preemption (adding one to the preempt_count). Since we are
 	 * interested in the preempt_count at the time the tracepoint was
 	 * hit, we need to subtract one to offset the increment.
 	 */
-	if (IS_ENABLED(CONFIG_PREEMPT))
+	if (IS_ENABLED(CONFIG_PREEMPTION))
 		fbuffer->pc--;
 	fbuffer->trace_file = trace_file;
 


