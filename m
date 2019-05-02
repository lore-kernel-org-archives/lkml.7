Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11584C04AAA
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 17:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFA2520675
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 17:11:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbfEBRLt convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 13:11:49 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:55166 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbfEBRLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 13:11:49 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hMFFD-0005XZ-Os; Thu, 02 May 2019 19:11:39 +0200
Date:   Thu, 2 May 2019 19:11:39 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Qian Cai <cai@lca.pw>, dave.hansen@intel.com, tglx@linutronix.de,
        x86@kernel.org, "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        luto@amacapital.net, hpa@zytor.com, mingo@kernel.org
Subject: [PATCH v2] x86/fpu: Fault-in user stack if
 copy_fpstate_to_sigframe() fails
Message-ID: <20190502171139.mqtegctsg35cir2e@linutronix.de>
References: <1556657902.6132.13.camel@lca.pw>
 <20190501082312.GA3908@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20190501082312.GA3908@zn.tnic>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the compacted form, XSAVES may save only the XMM+SSE state but skip
FP (x87 state).

This is denoted by header->xfeatures = 6. The fastpath
(copy_fpregs_to_sigframe()) does that but _also_ initialises the FP
state (cwd to 0x37f, mxcsr as we do, remaining fields to 0).

The slowpath (copy_xstate_to_user()) leaves most of the FP
state untouched. Only mxcsr and mxcsr_flags are set due to
xfeatures_mxcsr_quirk(). Now that XFEATURE_MASK_FP is set
unconditionally, see

  04944b793e18 ("x86: xsave: set FP, SSE bits in the xsave header in the user sigcontext"),

on return from the signal, random garbage is loaded as the FP state.

Instead of utilizing copy_xstate_to_user(), fault-in the user memory
and retry the fast path. Ideally, the fast path succeeds on the second
attempt but may be retried again if the memory is swapped out due
to memory pressure. If the user memory can not be faulted-in then
get_user_pages() returns an error so we don't loop forever.

Fault in memory via get_user_pages_unlocked() so
copy_fpregs_to_sigframe() succeeds without a fault.

Fixes: 69277c98f5eef ("x86/fpu: Always store the registers in copy_fpstate_to_sigframe()")
Reported-by: Kurt Kanzenbach <kurt.kanzenbach@linutronix.de>
Suggested-by: Dave Hansen <dave.hansen@intel.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
v1…v2:
   - s/get_user_pages()/get_user_pages_unlocked()/
   - merge cleanups

I'm posting this all-in-one fix up replacing the original patch so we
don't have a merge window with known bugs (that is the one that the
patch was going the fix and the KASAN fallout that it introduced).

 arch/x86/kernel/fpu/signal.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index 7026f1c4e5e30..5a8d118bc423e 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -157,11 +157,9 @@ static inline int copy_fpregs_to_sigframe(struct xregs_state __user *buf)
  */
 int copy_fpstate_to_sigframe(void __user *buf, void __user *buf_fx, int size)
 {
-	struct fpu *fpu = &current->thread.fpu;
-	struct xregs_state *xsave = &fpu->state.xsave;
 	struct task_struct *tsk = current;
 	int ia32_fxstate = (buf != buf_fx);
-	int ret = -EFAULT;
+	int ret;
 
 	ia32_fxstate &= (IS_ENABLED(CONFIG_X86_32) ||
 			 IS_ENABLED(CONFIG_IA32_EMULATION));
@@ -174,11 +172,12 @@ int copy_fpstate_to_sigframe(void __user *buf, void __user *buf_fx, int size)
 			sizeof(struct user_i387_ia32_struct), NULL,
 			(struct _fpstate_32 __user *) buf) ? -1 : 1;
 
+retry:
 	/*
 	 * Load the FPU registers if they are not valid for the current task.
 	 * With a valid FPU state we can attempt to save the state directly to
-	 * userland's stack frame which will likely succeed. If it does not, do
-	 * the slowpath.
+	 * userland's stack frame which will likely succeed. If it does not,
+	 * resolve the fault in the user memory and try again.
 	 */
 	fpregs_lock();
 	if (test_thread_flag(TIF_NEED_FPU_LOAD))
@@ -187,20 +186,20 @@ int copy_fpstate_to_sigframe(void __user *buf, void __user *buf_fx, int size)
 	pagefault_disable();
 	ret = copy_fpregs_to_sigframe(buf_fx);
 	pagefault_enable();
-	if (ret && !test_thread_flag(TIF_NEED_FPU_LOAD))
-		copy_fpregs_to_fpstate(fpu);
-	set_thread_flag(TIF_NEED_FPU_LOAD);
 	fpregs_unlock();
 
 	if (ret) {
-		if (using_compacted_format()) {
-			if (copy_xstate_to_user(buf_fx, xsave, 0, size))
-				return -1;
-		} else {
-			fpstate_sanitize_xstate(fpu);
-			if (__copy_to_user(buf_fx, xsave, fpu_user_xstate_size))
-				return -1;
-		}
+		int aligned_size;
+		int nr_pages;
+
+		aligned_size = offset_in_page(buf_fx) + fpu_user_xstate_size;
+		nr_pages = DIV_ROUND_UP(aligned_size, PAGE_SIZE);
+
+		ret = get_user_pages_unlocked((unsigned long)buf_fx, nr_pages,
+					      NULL, FOLL_WRITE);
+		if (ret == nr_pages)
+			goto retry;
+		return -EFAULT;
 	}
 
 	/* Save the fsave header for the 32-bit frames. */
-- 
2.20.1

