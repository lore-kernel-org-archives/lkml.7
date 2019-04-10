Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EE5FC10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 11:06:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16DF6218D2
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 11:06:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731217AbfDJLGZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 07:06:25 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:59014 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731188AbfDJLGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 07:06:21 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hEB3Z-0005FP-WC; Wed, 10 Apr 2019 13:06:18 +0200
Message-Id: <20190410103647.028742712@linutronix.de>
User-Agent: quilt/0.65
Date:   Wed, 10 Apr 2019 12:28:32 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Alexander Potapenko <glider@google.com>
Subject: [RFC patch 38/41] tracing: Make ftrace_trace_userstack() static and
 conditional
References: <20190410102754.387743324@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's only used in trace.c and there is absolutely no point in compiling it
in when user space stack traces are not supported.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/trace.c |   14 ++++++++------
 kernel/trace/trace.h |    8 --------
 2 files changed, 8 insertions(+), 14 deletions(-)

--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -159,6 +159,8 @@ static union trace_eval_map_item *trace_
 #endif /* CONFIG_TRACE_EVAL_MAP_FILE */
 
 static int tracing_set_tracer(struct trace_array *tr, const char *buf);
+static void ftrace_trace_userstack(struct ring_buffer *buffer,
+				   unsigned long flags, int pc);
 
 #define MAX_TRACER_SIZE		100
 static char bootup_tracer_buf[MAX_TRACER_SIZE] __initdata;
@@ -2905,9 +2907,10 @@ void trace_dump_stack(int skip)
 }
 EXPORT_SYMBOL_GPL(trace_dump_stack);
 
+#ifdef CONFIG_USER_STACKTRACE_SUPPORT
 static DEFINE_PER_CPU(int, user_stack_count);
 
-void
+static void
 ftrace_trace_userstack(struct ring_buffer *buffer, unsigned long flags, int pc)
 {
 	struct trace_event_call *call = &event_user_stack;
@@ -2958,13 +2961,12 @@ ftrace_trace_userstack(struct ring_buffe
  out:
 	preempt_enable();
 }
-
-#ifdef UNUSED
-static void __trace_userstack(struct trace_array *tr, unsigned long flags)
+#else /* CONFIG_USER_STACKTRACE_SUPPORT */
+static void ftrace_trace_userstack(struct ring_buffer *buffer,
+				   unsigned long flags, int pc)
 {
-	ftrace_trace_userstack(tr, flags, preempt_count());
 }
-#endif /* UNUSED */
+#endif /* !CONFIG_USER_STACKTRACE_SUPPORT */
 
 #endif /* CONFIG_STACKTRACE */
 
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -782,17 +782,9 @@ void update_max_tr_single(struct trace_a
 #endif /* CONFIG_TRACER_MAX_TRACE */
 
 #ifdef CONFIG_STACKTRACE
-void ftrace_trace_userstack(struct ring_buffer *buffer, unsigned long flags,
-			    int pc);
-
 void __trace_stack(struct trace_array *tr, unsigned long flags, int skip,
 		   int pc);
 #else
-static inline void ftrace_trace_userstack(struct ring_buffer *buffer,
-					  unsigned long flags, int pc)
-{
-}
-
 static inline void __trace_stack(struct trace_array *tr, unsigned long flags,
 				 int skip, int pc)
 {


