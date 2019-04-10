Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAE89C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 11:06:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2DAC21971
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 11:06:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731227AbfDJLG0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 07:06:26 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:59023 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731196AbfDJLGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 07:06:22 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hEB3b-0005G1-R2; Wed, 10 Apr 2019 13:06:20 +0200
Message-Id: <20190410103647.119410023@linutronix.de>
User-Agent: quilt/0.65
Date:   Wed, 10 Apr 2019 12:28:33 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Alexander Potapenko <glider@google.com>
Subject: [RFC patch 39/41] tracing: Simplify stack trace retrieval
References: <20190410102754.387743324@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the indirection through struct stack_trace by using the storage
array based interfaces.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/trace.c |   34 +++++++++-------------------------
 1 file changed, 9 insertions(+), 25 deletions(-)

--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2776,20 +2776,16 @@ static void __ftrace_trace_stack(struct
 	struct ring_buffer_event *event;
 	struct ftrace_stack *fstack;
 	struct stack_entry *entry;
-	struct stack_trace trace;
-	int size = FTRACE_KSTACK_ENTRIES;
+	unsigned int size, nent;
 	int stackidx;
 
-	trace.nr_entries	= 0;
-	trace.skip		= skip;
-
 	/*
 	 * Add one, for this function and the call to save_stack_trace()
 	 * If regs is set, then these functions will not be in the way.
 	 */
 #ifndef CONFIG_UNWINDER_ORC
 	if (!regs)
-		trace.skip++;
+		skip++;
 #endif
 
 	/*
@@ -2816,28 +2812,22 @@ static void __ftrace_trace_stack(struct
 	barrier();
 
 	fstack = this_cpu_ptr(ftrace_stacks.stacks) + (stackidx - 1);
-	trace.entries		= fstack->calls;
-	trace.max_entries	= FTRACE_KSTACK_ENTRIES;
+	nent = ARRAY_SIZE(fstack->calls);
 
 	if (regs)
-		save_stack_trace_regs(regs, &trace);
+		nent = stack_trace_save_regs(regs, fstack->calls, nent, skip);
 	else
-		save_stack_trace(&trace);
-
-	if (trace.nr_entries > size)
-		size = trace.nr_entries;
-
-	size *= sizeof(unsigned long);
+		nent = stack_trace_save(fstack->calls, nent, skip);
 
+	size = nent * sizeof(unsigned long);
 	event = __trace_buffer_lock_reserve(buffer, TRACE_STACK,
 					    sizeof(*entry) + size, flags, pc);
 	if (!event)
 		goto out;
 	entry = ring_buffer_event_data(event);
 
-	memcpy(&entry->caller, trace.entries, size);
-
-	entry->size = trace.nr_entries;
+	memcpy(&entry->caller, fstack->calls, size);
+	entry->size = nent;
 
 	if (!call_filter_check_discard(call, entry, buffer, event))
 		__buffer_unlock_commit(buffer, event);
@@ -2916,7 +2906,6 @@ ftrace_trace_userstack(struct ring_buffe
 	struct trace_event_call *call = &event_user_stack;
 	struct ring_buffer_event *event;
 	struct userstack_entry *entry;
-	struct stack_trace trace;
 
 	if (!(global_trace.trace_flags & TRACE_ITER_USERSTACKTRACE))
 		return;
@@ -2947,12 +2936,7 @@ ftrace_trace_userstack(struct ring_buffe
 	entry->tgid		= current->tgid;
 	memset(&entry->caller, 0, sizeof(entry->caller));
 
-	trace.nr_entries	= 0;
-	trace.max_entries	= FTRACE_STACK_ENTRIES;
-	trace.skip		= 0;
-	trace.entries		= entry->caller;
-
-	save_stack_trace_user(&trace);
+	stack_trace_save_user(entry->caller, FTRACE_STACK_ENTRIES, 0);
 	if (!call_filter_check_discard(call, entry, buffer, event))
 		__buffer_unlock_commit(buffer, event);
 


