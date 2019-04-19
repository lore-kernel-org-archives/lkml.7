Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA6B5C282DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:04:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C9A820645
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:04:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="ngRIF2F3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729278AbfDSTEF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:04:05 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42949 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729199AbfDSTEC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:04:02 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3JCqv31276491
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 19 Apr 2019 05:52:57 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3JCqv31276491
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1555678378;
        bh=vnbo52Q2DcFJonafJv5y+MfClGGxsBvqLUyG1XiWUeY=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=ngRIF2F3twp3AVGmiwrAofKorUSDs5k7flfzbw6joZMIXYjn68jUgP4AHASN7AMSG
         86uEEAD0ASs4FH3OLZe+Cg2Gr4E+Dt6WsxVszth7bmCyNiM3hxppcayg4WA90pA9/i
         efs5PtdKc+EOy1dW0aTjSi+O6pspbmtPA7Aw0x5ieFY1li8Yk6+g9nTdgoil64LTwH
         QLeRs8tN1afSYbrvhVVBAXqHQTiDTVFJPCUKKIFpH8ezgMnPWXgpWwVWL3eTZIPLgP
         xEDWQOVzyrLQ3n1lm5/hPvTNBzv5QYHwc19/yDKECJOG0Li1UqbT3ebKKgXWt0wk46
         I8qY+cJH9K0jQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3JCqtiZ276488;
        Fri, 19 Apr 2019 05:52:55 -0700
Date:   Fri, 19 Apr 2019 05:52:55 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Masami Hiramatsu <tipbot@zytor.com>
Message-ID: <tip-3ff9c075cc767b3060bdac12da72fc94dd7da1b8@git.kernel.org>
Cc:     hpa@zytor.com, rostedt@goodmis.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org, righi.andrea@gmail.com,
        mathieu.desnoyers@efficios.com, torvalds@linux-foundation.org,
        peterz@infradead.org, mhiramat@kernel.org, tglx@linutronix.de
Reply-To: torvalds@linux-foundation.org, mathieu.desnoyers@efficios.com,
          tglx@linutronix.de, peterz@infradead.org, mhiramat@kernel.org,
          rostedt@goodmis.org, hpa@zytor.com, righi.andrea@gmail.com,
          linux-kernel@vger.kernel.org, mingo@kernel.org
In-Reply-To: <155094059185.6137.15527904013362842072.stgit@devbox>
References: <155094059185.6137.15527904013362842072.stgit@devbox>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] x86/kprobes: Verify stack frame on kretprobe
Git-Commit-ID: 3ff9c075cc767b3060bdac12da72fc94dd7da1b8
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

Commit-ID:  3ff9c075cc767b3060bdac12da72fc94dd7da1b8
Gitweb:     https://git.kernel.org/tip/3ff9c075cc767b3060bdac12da72fc94dd7da1b8
Author:     Masami Hiramatsu <mhiramat@kernel.org>
AuthorDate: Sun, 24 Feb 2019 01:49:52 +0900
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 19 Apr 2019 14:26:05 +0200

x86/kprobes: Verify stack frame on kretprobe

Verify the stack frame pointer on kretprobe trampoline handler,
If the stack frame pointer does not match, it skips the wrong
entry and tries to find correct one.

This can happen if user puts the kretprobe on the function
which can be used in the path of ftrace user-function call.
Such functions should not be probed, so this adds a warning
message that reports which function should be blacklisted.

Tested-by: Andrea Righi <righi.andrea@gmail.com>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Acked-by: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Link: http://lkml.kernel.org/r/155094059185.6137.15527904013362842072.stgit@devbox
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/kprobes/core.c | 26 ++++++++++++++++++++++++++
 include/linux/kprobes.h        |  1 +
 2 files changed, 27 insertions(+)

diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index a034cb808e7e..18fbe9be2d68 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -569,6 +569,7 @@ void arch_prepare_kretprobe(struct kretprobe_instance *ri, struct pt_regs *regs)
 	unsigned long *sara = stack_addr(regs);
 
 	ri->ret_addr = (kprobe_opcode_t *) *sara;
+	ri->fp = sara;
 
 	/* Replace the return addr with trampoline addr */
 	*sara = (unsigned long) &kretprobe_trampoline;
@@ -759,15 +760,21 @@ static __used void *trampoline_handler(struct pt_regs *regs)
 	unsigned long flags, orig_ret_address = 0;
 	unsigned long trampoline_address = (unsigned long)&kretprobe_trampoline;
 	kprobe_opcode_t *correct_ret_addr = NULL;
+	void *frame_pointer;
+	bool skipped = false;
 
 	INIT_HLIST_HEAD(&empty_rp);
 	kretprobe_hash_lock(current, &head, &flags);
 	/* fixup registers */
 #ifdef CONFIG_X86_64
 	regs->cs = __KERNEL_CS;
+	/* On x86-64, we use pt_regs->sp for return address holder. */
+	frame_pointer = &regs->sp;
 #else
 	regs->cs = __KERNEL_CS | get_kernel_rpl();
 	regs->gs = 0;
+	/* On x86-32, we use pt_regs->flags for return address holder. */
+	frame_pointer = &regs->flags;
 #endif
 	regs->ip = trampoline_address;
 	regs->orig_ax = ~0UL;
@@ -789,8 +796,25 @@ static __used void *trampoline_handler(struct pt_regs *regs)
 		if (ri->task != current)
 			/* another task is sharing our hash bucket */
 			continue;
+		/*
+		 * Return probes must be pushed on this hash list correct
+		 * order (same as return order) so that it can be poped
+		 * correctly. However, if we find it is pushed it incorrect
+		 * order, this means we find a function which should not be
+		 * probed, because the wrong order entry is pushed on the
+		 * path of processing other kretprobe itself.
+		 */
+		if (ri->fp != frame_pointer) {
+			if (!skipped)
+				pr_warn("kretprobe is stacked incorrectly. Trying to fixup.\n");
+			skipped = true;
+			continue;
+		}
 
 		orig_ret_address = (unsigned long)ri->ret_addr;
+		if (skipped)
+			pr_warn("%ps must be blacklisted because of incorrect kretprobe order\n",
+				ri->rp->kp.addr);
 
 		if (orig_ret_address != trampoline_address)
 			/*
@@ -808,6 +832,8 @@ static __used void *trampoline_handler(struct pt_regs *regs)
 		if (ri->task != current)
 			/* another task is sharing our hash bucket */
 			continue;
+		if (ri->fp != frame_pointer)
+			continue;
 
 		orig_ret_address = (unsigned long)ri->ret_addr;
 		if (ri->rp && ri->rp->handler) {
diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index 201f0f2683f2..9a897256e481 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -173,6 +173,7 @@ struct kretprobe_instance {
 	struct kretprobe *rp;
 	kprobe_opcode_t *ret_addr;
 	struct task_struct *task;
+	void *fp;
 	char data[0];
 };
 
