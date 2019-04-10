Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6517BC10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 11:09:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A7FB222B6
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 11:09:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730465AbfDJLJQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 07:09:16 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:58812 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729727AbfDJLFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 07:05:49 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hEB35-000564-C5; Wed, 10 Apr 2019 13:05:47 +0200
Message-Id: <20190410103645.048761764@linutronix.de>
User-Agent: quilt/0.65
Date:   Wed, 10 Apr 2019 12:28:10 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Alexander Potapenko <glider@google.com>
Subject: [RFC patch 16/41] tracing: Remove the ULONG_MAX stack trace hackery
References: <20190410102754.387743324@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No architecture terminates the stack trace with ULONG_MAX anymore. As the
code checks the number of entries stored anyway there is no point in
keeping all that ULONG_MAX magic around.

The histogram code zeroes the storage before saving the stack, so if the
trace is shorter than the maximum number of entries it can terminate the
print loop if a zero entry is detected.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/trace_events_hist.c |    2 +-
 kernel/trace/trace_stack.c       |   20 +++++---------------
 2 files changed, 6 insertions(+), 16 deletions(-)

--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -5246,7 +5246,7 @@ static void hist_trigger_stacktrace_prin
 	unsigned int i;
 
 	for (i = 0; i < max_entries; i++) {
-		if (stacktrace_entries[i] == ULONG_MAX)
+		if (!stacktrace_entries[i])
 			return;
 
 		seq_printf(m, "%*c", 1 + spaces, ' ');
--- a/kernel/trace/trace_stack.c
+++ b/kernel/trace/trace_stack.c
@@ -18,8 +18,7 @@
 
 #include "trace.h"
 
-static unsigned long stack_dump_trace[STACK_TRACE_ENTRIES+1] =
-	 { [0 ... (STACK_TRACE_ENTRIES)] = ULONG_MAX };
+static unsigned long stack_dump_trace[STACK_TRACE_ENTRIES + 1];
 unsigned stack_trace_index[STACK_TRACE_ENTRIES];
 
 /*
@@ -52,10 +51,7 @@ void stack_trace_print(void)
 			   stack_trace_max.nr_entries);
 
 	for (i = 0; i < stack_trace_max.nr_entries; i++) {
-		if (stack_dump_trace[i] == ULONG_MAX)
-			break;
-		if (i+1 == stack_trace_max.nr_entries ||
-				stack_dump_trace[i+1] == ULONG_MAX)
+		if (i + 1 == stack_trace_max.nr_entries)
 			size = stack_trace_index[i];
 		else
 			size = stack_trace_index[i] - stack_trace_index[i+1];
@@ -150,8 +146,6 @@ check_stack(unsigned long ip, unsigned l
 		p = start;
 
 		for (; p < top && i < stack_trace_max.nr_entries; p++) {
-			if (stack_dump_trace[i] == ULONG_MAX)
-				break;
 			/*
 			 * The READ_ONCE_NOCHECK is used to let KASAN know that
 			 * this is not a stack-out-of-bounds error.
@@ -183,8 +177,6 @@ check_stack(unsigned long ip, unsigned l
 	}
 
 	stack_trace_max.nr_entries = x;
-	for (; x < i; x++)
-		stack_dump_trace[x] = ULONG_MAX;
 
 	if (task_stack_end_corrupted(current)) {
 		stack_trace_print();
@@ -286,7 +278,7 @@ static void *
 {
 	long n = *pos - 1;
 
-	if (n >= stack_trace_max.nr_entries || stack_dump_trace[n] == ULONG_MAX)
+	if (n >= stack_trace_max.nr_entries)
 		return NULL;
 
 	m->private = (void *)n;
@@ -360,12 +352,10 @@ static int t_show(struct seq_file *m, vo
 
 	i = *(long *)v;
 
-	if (i >= stack_trace_max.nr_entries ||
-	    stack_dump_trace[i] == ULONG_MAX)
+	if (i >= stack_trace_max.nr_entries)
 		return 0;
 
-	if (i+1 == stack_trace_max.nr_entries ||
-	    stack_dump_trace[i+1] == ULONG_MAX)
+	if (i + 1 == stack_trace_max.nr_entries)
 		size = stack_trace_index[i];
 	else
 		size = stack_trace_index[i] - stack_trace_index[i+1];


