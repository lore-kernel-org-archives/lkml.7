Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58D50C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 20:27:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3148421925
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 20:27:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729031AbfCUU06 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 16:26:58 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:39386 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728957AbfCUU0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 16:26:55 -0400
Received: from localhost ([127.0.0.1] helo=flow.W.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1h74H2-00057y-Sz; Thu, 21 Mar 2019 21:26:49 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 17/24] x86/fpu: Always store the registers in copy_fpstate_to_sigframe()
Date:   Thu, 21 Mar 2019 21:26:25 +0100
Message-Id: <20190321202632.16810-18-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190321202632.16810-1-bigeasy@linutronix.de>
References: <20190321202632.16810-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rik van Riel <riel@surriel.com>

copy_fpstate_to_sigframe() stores the registers directly to user space.
This is okay because the FPU register are valid and saving it directly
avoids saving it into kernel memory and making a copy.
However… We can't keep doing this if we are going to restore the FPU
registers on the return to userland. It is possible that the FPU
registers will be invalidated in the middle of the save operation and
this should be done with disabled preemption / BH.

Save the FPU registers to task's FPU struct and copy them to the user
memory later on.

This code is extracted from an earlier version of the patchset while
there still was lazy-FPU on x86.

Signed-off-by: Rik van Riel <riel@surriel.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/x86/include/asm/fpu/internal.h | 43 -----------------------------
 arch/x86/kernel/fpu/signal.c        | 34 +++++++++--------------
 2 files changed, 13 insertions(+), 64 deletions(-)

diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index b12874b7cf0cf..18f78be133f3a 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -127,20 +127,6 @@ extern void fpstate_sanitize_xstate(struct fpu *fpu);
 		     _ASM_EXTABLE_HANDLE(1b, 2b, ex_handler_fprestore)	\
 		     : output : input)
 
-static inline int copy_fregs_to_user(struct fregs_state __user *fx)
-{
-	return user_insn(fnsave %[fx]; fwait,  [fx] "=m" (*fx), "m" (*fx));
-}
-
-static inline int copy_fxregs_to_user(struct fxregs_state __user *fx)
-{
-	if (IS_ENABLED(CONFIG_X86_32))
-		return user_insn(fxsave %[fx], [fx] "=m" (*fx), "m" (*fx));
-	else
-		return user_insn(fxsaveq %[fx], [fx] "=m" (*fx), "m" (*fx));
-
-}
-
 static inline void copy_kernel_to_fxregs(struct fxregs_state *fx)
 {
 	if (IS_ENABLED(CONFIG_X86_32))
@@ -315,35 +301,6 @@ static inline void copy_kernel_to_xregs(struct xregs_state *xstate, u64 mask)
 	XSTATE_XRESTORE(xstate, lmask, hmask);
 }
 
-/*
- * Save xstate to user space xsave area.
- *
- * We don't use modified optimization because xrstor/xrstors might track
- * a different application.
- *
- * We don't use compacted format xsave area for
- * backward compatibility for old applications which don't understand
- * compacted format of xsave area.
- */
-static inline int copy_xregs_to_user(struct xregs_state __user *buf)
-{
-	int err;
-
-	/*
-	 * Clear the xsave header first, so that reserved fields are
-	 * initialized to zero.
-	 */
-	err = __clear_user(&buf->header, sizeof(buf->header));
-	if (unlikely(err))
-		return -EFAULT;
-
-	stac();
-	XSTATE_OP(XSAVE, buf, -1, -1, err);
-	clac();
-
-	return err;
-}
-
 /*
  * Restore xstate from user space xsave area.
  */
diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index 6475320939ce3..f55f16d9e7e4e 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -118,22 +118,6 @@ static inline int save_xstate_epilog(void __user *buf, int ia32_frame)
 	return err;
 }
 
-static inline int copy_fpregs_to_sigframe(struct xregs_state __user *buf)
-{
-	int err;
-
-	if (use_xsave())
-		err = copy_xregs_to_user(buf);
-	else if (use_fxsr())
-		err = copy_fxregs_to_user((struct fxregs_state __user *) buf);
-	else
-		err = copy_fregs_to_user((struct fregs_state __user *) buf);
-
-	if (unlikely(err) && __clear_user(buf, fpu_user_xstate_size))
-		err = -EFAULT;
-	return err;
-}
-
 /*
  * Save the fpu, extended register state to the user signal frame.
  *
@@ -144,8 +128,8 @@ static inline int copy_fpregs_to_sigframe(struct xregs_state __user *buf)
  *	buf == buf_fx for 64-bit frames and 32-bit fsave frame.
  *	buf != buf_fx for 32-bit frames with fxstate.
  *
- * Save the state directly to the user frame pointed by the aligned pointer
- * 'buf_fx'.
+ * Save the state to task's fpu->state and then copy it to the user frame
+ * pointed by the aligned pointer 'buf_fx'.
  *
  * If this is a 32-bit frame with fxstate, put a fsave header before
  * the aligned state at 'buf_fx'.
@@ -155,6 +139,8 @@ static inline int copy_fpregs_to_sigframe(struct xregs_state __user *buf)
  */
 int copy_fpstate_to_sigframe(void __user *buf, void __user *buf_fx, int size)
 {
+	struct fpu *fpu = &current->thread.fpu;
+	struct xregs_state *xsave = &fpu->state.xsave;
 	struct task_struct *tsk = current;
 	int ia32_fxstate = (buf != buf_fx);
 
@@ -169,9 +155,15 @@ int copy_fpstate_to_sigframe(void __user *buf, void __user *buf_fx, int size)
 			sizeof(struct user_i387_ia32_struct), NULL,
 			(struct _fpstate_32 __user *) buf) ? -1 : 1;
 
-	/* Save the live register state to the user directly. */
-	if (copy_fpregs_to_sigframe(buf_fx))
-		return -1;
+	copy_fpregs_to_fpstate(fpu);
+
+	if (using_compacted_format()) {
+		copy_xstate_to_user(buf_fx, xsave, 0, size);
+	} else {
+		fpstate_sanitize_xstate(fpu);
+		if (__copy_to_user(buf_fx, xsave, fpu_user_xstate_size))
+			return -1;
+	}
 
 	/* Save the fsave header for the 32-bit frames. */
 	if ((ia32_fxstate || !use_fxsr()) && save_fsave_header(tsk, buf))
-- 
2.20.1

