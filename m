Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DFD7C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 17:58:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78D762067D
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 17:58:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="K5bYlTKi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727979AbfGaR6I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 13:58:08 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38079 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726350AbfGaR6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 13:58:07 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6VHva7h3777692
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 31 Jul 2019 10:57:36 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6VHva7h3777692
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564595857;
        bh=cR1BkJ0GbpUK+Xsakva9+nE2ErJTB2ZsdHvnGlx+lPU=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=K5bYlTKizR3B+0L1YsSKvdnnDc2nh43YdZSIqJTVVAbYmgB3quk9Fk1C/r2rtbZjx
         Px4eCQ+ui95vZVozG1bh0RuKyHYQm2g7tlCfpU+IVW5XWBno2ioQDvFBnCg+Lwdp/5
         eBHXi3Akh1K7phU5oQQJVDvCkj8UzYYqRD+KvCk+E6q4Iy/SLHZ3FMHT/Rc2a9Gmi+
         hju+w1JrUEi6A+KyfN2jW9iBnZnGrsz49Vi+CgmlJtoXF0jv7tiq97pg5fkyU4InYI
         C21S3btXfagtEQBWmBYmpdM/h/9cn0eHg0T5UfWi4Hmt8HOEpTYpupvNIJ5/DxmZeL
         4SNR7+MlUuIGQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6VHvZbL3777689;
        Wed, 31 Jul 2019 10:57:35 -0700
Date:   Wed, 31 Jul 2019 10:57:35 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-30c937043b2db09ae3408f5534824f9ececdb581@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, paulmck@linux.ibm.com,
        tglx@linutronix.de, mhiramat@kernel.org, mingo@kernel.org,
        peterz@infradead.org, hpa@zytor.com, torvalds@linux-foundation.org,
        rostedt@goodmis.org, pbonzini@redhat.com
Reply-To: rostedt@goodmis.org, pbonzini@redhat.com, mingo@kernel.org,
          peterz@infradead.org, hpa@zytor.com,
          torvalds@linux-foundation.org, tglx@linutronix.de,
          paulmck@linux.ibm.com, mhiramat@kernel.org,
          linux-kernel@vger.kernel.org
In-Reply-To: <20190726212124.409766323@linutronix.de>
References: <20190726212124.409766323@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/rt] tracing: Use CONFIG_PREEMPTION
Git-Commit-ID: 30c937043b2db09ae3408f5534824f9ececdb581
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  30c937043b2db09ae3408f5534824f9ececdb581
Gitweb:     https://git.kernel.org/tip/30c937043b2db09ae3408f5534824f9ececdb581
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Fri, 26 Jul 2019 23:19:40 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 31 Jul 2019 19:03:35 +0200

tracing: Use CONFIG_PREEMPTION

CONFIG_PREEMPTION is selected by CONFIG_PREEMPT and by
CONFIG_PREEMPT_RT. Both PREEMPT and PREEMPT_RT require the same
functionality which today depends on CONFIG_PREEMPT.

Switch the conditionals in the tracer over to CONFIG_PREEMPTION.

This is the first step to make the tracer work on RT. The other small
tweaks are submitted separately.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Paul E. McKenney <paulmck@linux.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Link: http://lkml.kernel.org/r/20190726212124.409766323@linutronix.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/trace/Kconfig                 | 4 ++--
 kernel/trace/ftrace.c                | 2 +-
 kernel/trace/ring_buffer_benchmark.c | 2 +-
 kernel/trace/trace_events.c          | 4 ++--
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index d2c1fe0b451d..6a64d7772870 100644
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
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index eca34503f178..a800e867c1a3 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -2814,7 +2814,7 @@ int ftrace_shutdown(struct ftrace_ops *ops, int command)
 		 * synchornize_rcu_tasks() will wait for those tasks to
 		 * execute and either schedule voluntarily or enter user space.
 		 */
-		if (IS_ENABLED(CONFIG_PREEMPT))
+		if (IS_ENABLED(CONFIG_PREEMPTION))
 			synchronize_rcu_tasks();
 
  free_ops:
diff --git a/kernel/trace/ring_buffer_benchmark.c b/kernel/trace/ring_buffer_benchmark.c
index 0564f6db0561..09b0b49f346e 100644
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
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index c7506bc81b75..5a189fb8ec23 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -255,12 +255,12 @@ void *trace_event_buffer_reserve(struct trace_event_buffer *fbuffer,
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
 
