Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D6FFC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 03:12:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E268D20850
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 03:12:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jP76D9jq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729344AbfCADM0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 22:12:26 -0500
Received: from mail-oi1-f201.google.com ([209.85.167.201]:49254 "EHLO
        mail-oi1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbfCADMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 22:12:25 -0500
Received: by mail-oi1-f201.google.com with SMTP id a6so9916752oib.16
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 19:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=hC9+KSqOfhghtXwTt0v7+bYNbD8DdeCfRg/HFFLJAeA=;
        b=jP76D9jqMpYrWUIxuvCrRMU2LZuPijnrnELxsec/YFtHPen/gOscyJjNR6FaFXdfTV
         LPaL/3zMF2wHLxfyNWrpCsL/w0ur1bdy3CSQpilJU2DRCpZlj4kdeif+0hUKTzKSsoE4
         I3PdkXE7UsVUqXmvHD1wqHFAXAo4rkS6VCQ6tCT3kOpOPHvG3oxnPqVNNHXonB3HbHHc
         JPm5onXFDpgQ5BZnewQp5qU2knRNM1gH6wHPE4Wwr38yPqhO4cSrQaxSRzImh9J5qz6E
         tEO99MD34asSt2G2MnOwjqQz5JK6KeVwr7eiUv0q7J4cMnI6P/gZuta21QDiVXPfLawk
         qdvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=hC9+KSqOfhghtXwTt0v7+bYNbD8DdeCfRg/HFFLJAeA=;
        b=nFgfB8yekLLIbj9Y5C7ndMilGM6XSTCAPpyMDgJBdeRO9ksKQjyFIv32jVanRU+TnC
         5VEBCmSNOCO2Q48c3w6+wxuMhY6aBhaiylqgtlnqkkJLdGXkDrFnJkp+jEZ5Q2hISzlE
         WKNWE7C+UeHXnA0s0Ag0BokTmm567mtRFhmGPLdlGhiuhz4UIPFisB8/vg+jAAqlV02s
         pikgAnrWx5/GjbLAhQpcF6ddONTEQiZXbsXof82JVRqw6qirzTYnMwGZaUfY/42/vib8
         kk915yD3P7m2TEUKXrHHAmAJHzmg4lRfqnW1LZ0y7+wC3OgdnSQZNAFy9kW7WHh5ujGb
         MPrg==
X-Gm-Message-State: APjAAAWv4NUAxgXSvNFHO7F9cpfpXZ7Moz+bd7Re7k+Tl3KjwxgaDgZi
        BseEFcJZu9yIWg1nc80Ne1Qr3f2mxg==
X-Google-Smtp-Source: APXvYqx90sayLEaLUXzAnkk0uNpBcBJvkWOJBKm6MkssnI+8gPtNlYjsdqc7YptM4tZ1fWJLA+PpAhfD/w==
X-Received: by 2002:a05:6830:8b:: with SMTP id a11mr1703155oto.33.1551409944690;
 Thu, 28 Feb 2019 19:12:24 -0800 (PST)
Date:   Fri,  1 Mar 2019 04:12:00 +0100
Message-Id: <20190301031201.7416-1-jannh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.352.gf09ad66450-goog
Subject: [PATCH 1/2] x86/unwind: handle NULL pointer calls better in frame unwinder
From:   Jann Horn <jannh@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        jannh@google.com
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        syzbot <syzbot+ca95b2b7aef9e7cbd6ab@syzkaller.appspotmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the frame unwinder is invoked for an oops caused by a call to NULL,
it currently skips the parent function because BP still points to the
parent's stack frame; the (nonexistent) current function only has the first
half of a stack frame, and BP doesn't point to it yet.

Add a special case for IP==0 that calculates a fake BP from SP, then uses
the real BP for the next frame.

Note that this handles first_frame specially: We return information about
the parent function as long as the saved IP is >=first_frame, even if the
fake BP points below it.

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
-- 
2.21.0.352.gf09ad66450-goog

