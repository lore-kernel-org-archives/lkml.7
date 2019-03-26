Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED0A3C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:41:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92D9520870
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553582506;
	bh=Aw/aK6OJr//9LkwjExrqRjkbJEJwjRevVmf/HsugzI4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EifMBFZB2jkXN4lLdLCAIjVbcRD3wG1p/gzsNY+rgVwRRjxBUzrVIrbeImgVSzwbF
	 q95DFvHxYho+kEjgCjXpFdoWEkIGPgv4Xq5/8DDLddtN6gx7frT6GxUusaZVD/GVlR
	 3hvqsjgEbmETl1zwxQuvLLpLT3jAZ1IDT5Xh4tfU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732757AbfCZGlp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 02:41:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:56348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732827AbfCZGkN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 02:40:13 -0400
Received: from localhost (unknown [104.132.152.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2AC452070B;
        Tue, 26 Mar 2019 06:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553582411;
        bh=Aw/aK6OJr//9LkwjExrqRjkbJEJwjRevVmf/HsugzI4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p9bORqu+zEK5zjwionQn/BoLBkAjY819kHL/JsTDkmxYJ7N/Bau4C+U0LYNG9XBv9
         PtYDe/noXooj6AxclUJEyhvdLWU06aMod9F9XXUk3rRWuIq698gjk0oaX316zlCkh9
         TDq+LtQPDKjyr8ZzgtcTefqJEBqYEE5YBwjKwAak=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jann Horn <jannh@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        syzbot <syzbot+ca95b2b7aef9e7cbd6ab@syzkaller.appspotmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org
Subject: [PATCH 5.0 47/52] x86/unwind: Handle NULL pointer calls better in frame unwinder
Date:   Tue, 26 Mar 2019 15:30:34 +0900
Message-Id: <20190326042703.481400091@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190326042700.963224437@linuxfoundation.org>
References: <20190326042700.963224437@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jann Horn <jannh@google.com>

commit f4f34e1b82eb4219d8eaa1c7e2e17ca219a6a2b5 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/include/asm/unwind.h  |    6 ++++++
 arch/x86/kernel/unwind_frame.c |   25 ++++++++++++++++++++++---
 2 files changed, 28 insertions(+), 3 deletions(-)

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
--- a/arch/x86/kernel/unwind_frame.c
+++ b/arch/x86/kernel/unwind_frame.c
@@ -320,10 +320,14 @@ bool unwind_next_frame(struct unwind_sta
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
@@ -398,6 +402,21 @@ void __unwind_start(struct unwind_state
 
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
@@ -410,7 +429,7 @@ void __unwind_start(struct unwind_state
 	 */
 	while (!unwind_done(state) &&
 	       (!on_stack(&state->stack_info, first_frame, sizeof(long)) ||
-			state->bp < first_frame))
+			(state->next_bp == NULL && state->bp < first_frame)))
 		unwind_next_frame(state);
 }
 EXPORT_SYMBOL_GPL(__unwind_start);


