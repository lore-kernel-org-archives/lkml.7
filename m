Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D1DCC10F11
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 21:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3566321721
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 21:05:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727314AbfDMVFE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 17:05:04 -0400
Received: from terminus.zytor.com ([198.137.202.136]:35751 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbfDMVFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 17:05:03 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3DL3hWx2267811
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 13 Apr 2019 14:03:43 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3DL3giC2267808;
        Sat, 13 Apr 2019 14:03:42 -0700
Date:   Sat, 13 Apr 2019 14:03:42 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Sebastian Andrzej Siewior <tipbot@zytor.com>
Message-ID: <tip-da2f32fb8dc7cbd9433cb2e990693734b30a2465@git.kernel.org>
Cc:     jannh@google.com, Jason@zx2c4.com, bigeasy@linutronix.de,
        tglx@linutronix.de, rkrcmar@redhat.com, riel@surriel.com,
        kvm@vger.kernel.org, dave.hansen@intel.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org, hpa@zytor.com,
        bp@suse.de, luto@kernel.org, pbonzini@redhat.com, mingo@redhat.com
Reply-To: jannh@google.com, tglx@linutronix.de, Jason@zx2c4.com,
          bigeasy@linutronix.de, riel@surriel.com, rkrcmar@redhat.com,
          dave.hansen@intel.com, mingo@kernel.org, kvm@vger.kernel.org,
          x86@kernel.org, linux-kernel@vger.kernel.org,
          pbonzini@redhat.com, mingo@redhat.com, hpa@zytor.com, bp@suse.de,
          luto@kernel.org
In-Reply-To: <20190403164156.19645-26-bigeasy@linutronix.de>
References: <20190403164156.19645-26-bigeasy@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/fpu] x86/fpu: Add a fastpath to copy_fpstate_to_sigframe()
Git-Commit-ID: da2f32fb8dc7cbd9433cb2e990693734b30a2465
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

Commit-ID:  da2f32fb8dc7cbd9433cb2e990693734b30a2465
Gitweb:     https://git.kernel.org/tip/da2f32fb8dc7cbd9433cb2e990693734b30a2465
Author:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate: Wed, 3 Apr 2019 18:41:54 +0200
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Fri, 12 Apr 2019 20:05:36 +0200

x86/fpu: Add a fastpath to copy_fpstate_to_sigframe()

Try to save the FPU registers directly to the userland stack frame if
the CPU holds the FPU registers for the current task. This has to be
done with the pagefault disabled because we can't fault (while the FPU
registers are locked) and therefore the operation might fail. If it
fails try the slowpath which can handle faults.

 [ bp: Massage a bit. ]

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Dave Hansen <dave.hansen@intel.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jann Horn <jannh@google.com>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: kvm ML <kvm@vger.kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Rik van Riel <riel@surriel.com>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20190403164156.19645-26-bigeasy@linutronix.de
---
 arch/x86/kernel/fpu/signal.c | 34 ++++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index a1bd7be70206..3c3167576216 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -144,8 +144,10 @@ static inline int copy_fpregs_to_sigframe(struct xregs_state __user *buf)
  *	buf == buf_fx for 64-bit frames and 32-bit fsave frame.
  *	buf != buf_fx for 32-bit frames with fxstate.
  *
- * Save the state to task's fpu->state and then copy it to the user frame
- * pointed to by the aligned pointer 'buf_fx'.
+ * Try to save it directly to the user frame with disabled page fault handler.
+ * If this fails then do the slow path where the FPU state is first saved to
+ * task's fpu->state and then copy it to the user frame pointed to by the
+ * aligned pointer 'buf_fx'.
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
@@ -173,23 +176,30 @@ int copy_fpstate_to_sigframe(void __user *buf, void __user *buf_fx, int size)
 
 	/*
 	 * If we do not need to load the FPU registers at return to userspace
-	 * then the CPU has the current state and we need to save it. Otherwise,
-	 * it has already been done and we can skip it.
+	 * then the CPU has the current state. Try to save it directly to
+	 * userland's stack frame if it does not cause a pagefault. If it does,
+	 * try the slowpath.
 	 */
 	fpregs_lock();
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
