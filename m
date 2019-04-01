Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E960C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 13:44:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDC7A20700
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 13:44:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728734AbfDANow (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 09:44:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:50626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726867AbfDANoX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 09:44:23 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2EA8213F2;
        Mon,  1 Apr 2019 13:44:21 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1hAxEa-0003P0-TN; Mon, 01 Apr 2019 09:44:20 -0400
Message-Id: <20190401134420.795904625@goodmis.org>
User-Agent: quilt/0.65
Date:   Mon, 01 Apr 2019 09:41:06 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Roland McGrath <roland@hack.frob.com>,
        Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        Palmer Dabbelt <palmer@sifive.com>
Subject: [PATCH 2/6 v3] tracing/syscalls: Pass in hardcoded 6 into syscall_get_arguments()
References: <20190401134104.676620247@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (Red Hat)" <rostedt@goodmis.org>

The only users that calls syscall_get_arguments() with a variable and not a
hard coded '6' is ftrace_syscall_enter(). syscall_get_arguments() can be
optimized by removing a variable input, and always grabbing 6 arguments
regardless of what the system call actually uses.

Change ftrace_syscall_enter() to pass the 6 args into a local stack array
and copy the necessary arguments into the trace event as needed.

This is needed to remove two parameters from syscall_get_arguments().

Link: http://lkml.kernel.org/r/20161107213233.627583542@goodmis.org

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_syscalls.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
index f93a56d2db27..e9f5bbbad6d9 100644
--- a/kernel/trace/trace_syscalls.c
+++ b/kernel/trace/trace_syscalls.c
@@ -314,6 +314,7 @@ static void ftrace_syscall_enter(void *data, struct pt_regs *regs, long id)
 	struct ring_buffer_event *event;
 	struct ring_buffer *buffer;
 	unsigned long irq_flags;
+	unsigned long args[6];
 	int pc;
 	int syscall_nr;
 	int size;
@@ -347,7 +348,8 @@ static void ftrace_syscall_enter(void *data, struct pt_regs *regs, long id)
 
 	entry = ring_buffer_event_data(event);
 	entry->nr = syscall_nr;
-	syscall_get_arguments(current, regs, 0, sys_data->nb_args, entry->args);
+	syscall_get_arguments(current, regs, 0, 6, args);
+	memcpy(entry->args, args, sizeof(unsigned long) * sys_data->nb_args);
 
 	event_trigger_unlock_commit(trace_file, buffer, event, entry,
 				    irq_flags, pc);
@@ -583,6 +585,7 @@ static void perf_syscall_enter(void *ignore, struct pt_regs *regs, long id)
 	struct syscall_metadata *sys_data;
 	struct syscall_trace_enter *rec;
 	struct hlist_head *head;
+	unsigned long args[6];
 	bool valid_prog_array;
 	int syscall_nr;
 	int rctx;
@@ -613,8 +616,8 @@ static void perf_syscall_enter(void *ignore, struct pt_regs *regs, long id)
 		return;
 
 	rec->nr = syscall_nr;
-	syscall_get_arguments(current, regs, 0, sys_data->nb_args,
-			       (unsigned long *)&rec->args);
+	syscall_get_arguments(current, regs, 0, 6, args);
+	memcpy(&rec->args, args, sizeof(unsigned long) * sys_data->nb_args);
 
 	if ((valid_prog_array &&
 	     !perf_call_bpf_enter(sys_data->enter_event, regs, sys_data, rec)) ||
-- 
2.20.1


