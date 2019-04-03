Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBD1FC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 16:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DAB42082C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 16:42:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728657AbfDCQm5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 12:42:57 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:42024 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728012AbfDCQmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 12:42:39 -0400
Received: from localhost ([127.0.0.1] helo=flow.W.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hBiy8-0004GO-4i; Wed, 03 Apr 2019 18:42:32 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 25/27] x86/fpu: Add a fastpath to copy_fpstate_to_sigframe()
Date:   Wed,  3 Apr 2019 18:41:54 +0200
Message-Id: <20190403164156.19645-26-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190403164156.19645-1-bigeasy@linutronix.de>
References: <20190403164156.19645-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the CPU holds the FPU register for the current task then we can try to save
them directly to the userland stack frame. This has to be done with the
pagefault disabled because we can't fault (while the FPU registers are locked)
and therefore the operation might fail.
If it fails try the slowpath which can handle faults.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/x86/kernel/fpu/signal.c | 34 ++++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index f20e1d1fffa29..baf1588d7060c 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -144,8 +144,10 @@ static inline int copy_fpregs_to_sigframe(struct xregs_state __user *buf)
  *	buf == buf_fx for 64-bit frames and 32-bit fsave frame.
  *	buf != buf_fx for 32-bit frames with fxstate.
  *
- * Save the state to task's fpu->state and then copy it to the user frame
- * pointed by the aligned pointer 'buf_fx'.
+ * Try to save it directly to the user frame with disabled page fault handler.
+ * If this fails then do the slow path where the FPU state is first saved to
+ * task's fpu->state and then copy it to the user frame pointed by the aligned
+ * pointer 'buf_fx'.
  *
  * If this is a 32-bit frame with fxstate, put a fsave header before
  * the aligned state at 'buf_fx'.
@@ -159,6 +161,7 @@ int copy_fpstate_to_sigframe(void __user *buf, void __user *buf_fx, int size)
 	struct xregs_state *xsave = &fpu->state.xsave;
 	struct task_struct *tsk = current;
 	int ia32_fxstate = (buf != buf_fx);
+	int ret = -EFAULT;
 
 	ia32_fxstate &= (IS_ENABLED(CONFIG_X86_32) ||
 			 IS_ENABLED(CONFIG_IA32_EMULATION));
@@ -174,22 +177,29 @@ int copy_fpstate_to_sigframe(void __user *buf, void __user *buf_fx, int size)
 	fpregs_lock();
 	/*
 	 * If we do not need to load the FPU registers at return to userspace
-	 * then the CPU has the current state and we need to save it. Otherwise
-	 * it is already done and we can skip it.
+	 * then the CPU has the current state. Try to save it directly to
+	 * userland's stack frame if it does not cause a pagefault. If it does,
+	 * try the slowpath.
 	 */
 	if (!test_thread_flag(TIF_NEED_FPU_LOAD)) {
-		copy_fpregs_to_fpstate(fpu);
+		pagefault_disable();
+		ret = copy_fpregs_to_sigframe(buf_fx);
+		pagefault_enable();
+		if (ret)
+			copy_fpregs_to_fpstate(fpu);
 		set_thread_flag(TIF_NEED_FPU_LOAD);
 	}
 	fpregs_unlock();
 
-	if (using_compacted_format()) {
-		if (copy_xstate_to_user(buf_fx, xsave, 0, size))
-			return -1;
-	} else {
-		fpstate_sanitize_xstate(fpu);
-		if (__copy_to_user(buf_fx, xsave, fpu_user_xstate_size))
-			return -1;
+	if (ret) {
+		if (using_compacted_format()) {
+			if (copy_xstate_to_user(buf_fx, xsave, 0, size))
+				return -1;
+		} else {
+			fpstate_sanitize_xstate(fpu);
+			if (__copy_to_user(buf_fx, xsave, fpu_user_xstate_size))
+				return -1;
+		}
 	}
 
 	/* Save the fsave header for the 32-bit frames. */
-- 
2.20.1

