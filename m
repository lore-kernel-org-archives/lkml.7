Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDF29C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 22:31:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C41C620842
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 22:31:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727424AbfCFWbu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 17:31:50 -0500
Received: from terminus.zytor.com ([198.137.202.136]:35945 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727409AbfCFWbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 17:31:50 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x26MV8Mc1911295
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 6 Mar 2019 14:31:08 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x26MV7r21911292;
        Wed, 6 Mar 2019 14:31:07 -0800
Date:   Wed, 6 Mar 2019 14:31:07 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jann Horn <tipbot@zytor.com>
Message-ID: <tip-f4f34e1b82eb4219d8eaa1c7e2e17ca219a6a2b5@git.kernel.org>
Cc:     bp@alien8.de, yamada.masahiro@socionext.com,
        linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        tglx@linutronix.de, jannh@google.com, akpm@linux-foundation.org,
        hpa@zytor.com, mingo@kernel.org,
        syzbot+ca95b2b7aef9e7cbd6ab@syzkaller.appspotmail.com,
        michal.lkml@markovi.net
Reply-To: linux-kernel@vger.kernel.org, jannh@google.com, hpa@zytor.com,
          yamada.masahiro@socionext.com, bp@alien8.de, jpoimboe@redhat.com,
          tglx@linutronix.de, akpm@linux-foundation.org,
          michal.lkml@markovi.net,
          syzbot+ca95b2b7aef9e7cbd6ab@syzkaller.appspotmail.com,
          mingo@kernel.org
In-Reply-To: <20190301031201.7416-1-jannh@google.com>
References: <20190301031201.7416-1-jannh@google.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/unwind: Handle NULL pointer calls better in
 frame unwinder
Git-Commit-ID: f4f34e1b82eb4219d8eaa1c7e2e17ca219a6a2b5
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

Commit-ID:  f4f34e1b82eb4219d8eaa1c7e2e17ca219a6a2b5
Gitweb:     https://git.kernel.org/tip/f4f34e1b82eb4219d8eaa1c7e2e17ca219a6a2b5
Author:     Jann Horn <jannh@google.com>
AuthorDate: Fri, 1 Mar 2019 04:12:00 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 6 Mar 2019 23:03:26 +0100

x86/unwind: Handle NULL pointer calls better in frame unwinder

When the frame unwinder is invoked for an oops caused by a call to NULL, it
currently skips the parent function because BP still points to the parent's
stack frame; the (nonexistent) current function only has the first half of
a stack frame, and BP doesn't point to it yet.

Add a special case for IP==0 that calculates a fake BP from SP, then uses
the real BP for the next frame.

Note that this handles first_frame specially: Return information about the
parent function as long as the saved IP is >=first_frame, even if the fake
BP points below it.

With an artificially-added NULL call in prctl_set_seccomp(), before this
patch, the trace is:

Call Trace:
 ? prctl_set_seccomp+0x3a/0x50
 __x64_sys_prctl+0x457/0x6f0
 ? __ia32_sys_prctl+0x750/0x750
 do_syscall_64+0x72/0x160
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

After this patch, the trace is:

Call Trace:
 prctl_set_seccomp+0x3a/0x50
 __x64_sys_prctl+0x457/0x6f0
 ? __ia32_sys_prctl+0x750/0x750
 do_syscall_64+0x72/0x160
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

Signed-off-by: Jann Horn <jannh@google.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: syzbot <syzbot+ca95b2b7aef9e7cbd6ab@syzkaller.appspotmail.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Michal Marek <michal.lkml@markovi.net>
Cc: linux-kbuild@vger.kernel.org
Link: https://lkml.kernel.org/r/20190301031201.7416-1-jannh@google.com

---
 arch/x86/include/asm/unwind.h  |  6 ++++++
 arch/x86/kernel/unwind_frame.c | 25 ++++++++++++++++++++++---
 2 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/unwind.h b/arch/x86/include/asm/unwind.h
index 1f86e1b0a5cd..499578f7e6d7 100644
--- a/arch/x86/include/asm/unwind.h
+++ b/arch/x86/include/asm/unwind.h
@@ -23,6 +23,12 @@ struct unwind_state {
 #elif defined(CONFIG_UNWINDER_FRAME_POINTER)
 	bool got_irq;
 	unsigned long *bp, *orig_sp, ip;
+	/*
+	 * If non-NULL: The current frame is incomplete and doesn't contain a
+	 * valid BP. When looking for the next frame, use this instead of the
+	 * non-existent saved BP.
+	 */
+	unsigned long *next_bp;
 	struct pt_regs *regs;
 #else
 	unsigned long *sp;
diff --git a/arch/x86/kernel/unwind_frame.c b/arch/x86/kernel/unwind_frame.c
index 3dc26f95d46e..9b9fd4826e7a 100644
--- a/arch/x86/kernel/unwind_frame.c
+++ b/arch/x86/kernel/unwind_frame.c
@@ -320,10 +320,14 @@ bool unwind_next_frame(struct unwind_state *state)
 	}
 
 	/* Get the next frame pointer: */
-	if (state->regs)
+	if (state->next_bp) {
+		next_bp = state->next_bp;
+		state->next_bp = NULL;
+	} else if (state->regs) {
 		next_bp = (unsigned long *)state->regs->bp;
-	else
+	} else {
 		next_bp = (unsigned long *)READ_ONCE_TASK_STACK(state->task, *state->bp);
+	}
 
 	/* Move to the next frame if it's safe: */
 	if (!update_stack_state(state, next_bp))
@@ -398,6 +402,21 @@ void __unwind_start(struct unwind_state *state, struct task_struct *task,
 
 	bp = get_frame_pointer(task, regs);
 
+	/*
+	 * If we crash with IP==0, the last successfully executed instruction
+	 * was probably an indirect function call with a NULL function pointer.
+	 * That means that SP points into the middle of an incomplete frame:
+	 * *SP is a return pointer, and *(SP-sizeof(unsigned long)) is where we
+	 * would have written a frame pointer if we hadn't crashed.
+	 * Pretend that the frame is complete and that BP points to it, but save
+	 * the real BP so that we can use it when looking for the next frame.
+	 */
+	if (regs && regs->ip == 0 &&
+	    (unsigned long *)kernel_stack_pointer(regs) >= first_frame) {
+		state->next_bp = bp;
+		bp = ((unsigned long *)kernel_stack_pointer(regs)) - 1;
+	}
+
 	/* Initialize stack info and make sure the frame data is accessible: */
 	get_stack_info(bp, state->task, &state->stack_info,
 		       &state->stack_mask);
@@ -410,7 +429,7 @@ void __unwind_start(struct unwind_state *state, struct task_struct *task,
 	 */
 	while (!unwind_done(state) &&
 	       (!on_stack(&state->stack_info, first_frame, sizeof(long)) ||
-			state->bp < first_frame))
+			(state->next_bp == NULL && state->bp < first_frame)))
 		unwind_next_frame(state);
 }
 EXPORT_SYMBOL_GPL(__unwind_start);
