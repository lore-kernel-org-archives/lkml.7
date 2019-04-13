Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43272C10F11
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 20:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 198F02084E
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 20:50:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727271AbfDMUuh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 16:50:37 -0400
Received: from terminus.zytor.com ([198.137.202.136]:36507 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbfDMUuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 16:50:37 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3DKnOdg2265328
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 13 Apr 2019 13:49:24 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3DKnNsQ2265325;
        Sat, 13 Apr 2019 13:49:23 -0700
Date:   Sat, 13 Apr 2019 13:49:23 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Sebastian Andrzej Siewior <tipbot@zytor.com>
Message-ID: <tip-fbcc9e0c37ba3186c41b5eb1aee2f7f3b711bc1e@git.kernel.org>
Cc:     Jason@zx2c4.com, mingo@redhat.com, tglx@linutronix.de,
        pbonzini@redhat.com, dave.hansen@intel.com, rkrcmar@redhat.com,
        riel@surriel.com, bp@suse.de, jannh@google.com,
        kvm@vger.kernel.org, bigeasy@linutronix.de, mingo@kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org, luto@kernel.org,
        hpa@zytor.com
Reply-To: jannh@google.com, riel@surriel.com, bp@suse.de,
          pbonzini@redhat.com, dave.hansen@intel.com, rkrcmar@redhat.com,
          Jason@zx2c4.com, mingo@redhat.com, tglx@linutronix.de,
          hpa@zytor.com, linux-kernel@vger.kernel.org, luto@kernel.org,
          mingo@kernel.org, x86@kernel.org, kvm@vger.kernel.org,
          bigeasy@linutronix.de
In-Reply-To: <20190403164156.19645-6-bigeasy@linutronix.de>
References: <20190403164156.19645-6-bigeasy@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/fpu] x86/fpu: Remove fpu->initialized usage in
 copy_fpstate_to_sigframe()
Git-Commit-ID: fbcc9e0c37ba3186c41b5eb1aee2f7f3b711bc1e
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

Commit-ID:  fbcc9e0c37ba3186c41b5eb1aee2f7f3b711bc1e
Gitweb:     https://git.kernel.org/tip/fbcc9e0c37ba3186c41b5eb1aee2f7f3b711bc1e
Author:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate: Wed, 3 Apr 2019 18:41:34 +0200
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Tue, 9 Apr 2019 20:48:11 +0200

x86/fpu: Remove fpu->initialized usage in copy_fpstate_to_sigframe()

With lazy-FPU support the (now named variable) ->initialized was set to
true if the CPU's FPU registers were holding a valid state of the
FPU registers for the active process. If it was set to false then the
FPU state was saved in fpu->state and the FPU was deactivated.

With lazy-FPU gone, ->initialized is always true for user threads and
kernel threads never call this function so ->initialized is always true
in copy_fpstate_to_sigframe().

The using_compacted_format() check is also a leftover from the lazy-FPU
time. In the

  ->initialized == false

case copy_to_user() would copy the compacted buffer while userland would
expect the non-compacted format instead. So in order to save the FPU
state in the non-compacted form it issues XSAVE to save the *current*
FPU state.

If the FPU is not enabled, the attempt raises the FPU trap, the trap
restores the FPU contents and re-enables the FPU and XSAVE is invoked
again and succeeds.

*This* does not longer work since commit

  bef8b6da9522 ("x86/fpu: Handle #NM without FPU emulation as an error")

Remove the check for ->initialized because it is always true and remove
the false condition. Update the comment to reflect that the state is
always live.

 [ bp: Massage. ]

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
Link: https://lkml.kernel.org/r/20190403164156.19645-6-bigeasy@linutronix.de
---
 arch/x86/kernel/fpu/signal.c | 35 ++++++++---------------------------
 1 file changed, 8 insertions(+), 27 deletions(-)

diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index 7296a9bb78e7..c1a5999affa0 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -144,9 +144,8 @@ static inline int copy_fpregs_to_sigframe(struct xregs_state __user *buf)
  *	buf == buf_fx for 64-bit frames and 32-bit fsave frame.
  *	buf != buf_fx for 32-bit frames with fxstate.
  *
- * If the fpu, extended register state is live, save the state directly
- * to the user frame pointed by the aligned pointer 'buf_fx'. Otherwise,
- * copy the thread's fpu state to the user frame starting at 'buf_fx'.
+ * Save the state directly to the user frame pointed by the aligned pointer
+ * 'buf_fx'.
  *
  * If this is a 32-bit frame with fxstate, put a fsave header before
  * the aligned state at 'buf_fx'.
@@ -157,7 +156,6 @@ static inline int copy_fpregs_to_sigframe(struct xregs_state __user *buf)
 int copy_fpstate_to_sigframe(void __user *buf, void __user *buf_fx, int size)
 {
 	struct fpu *fpu = &current->thread.fpu;
-	struct xregs_state *xsave = &fpu->state.xsave;
 	struct task_struct *tsk = current;
 	int ia32_fxstate = (buf != buf_fx);
 
@@ -172,29 +170,12 @@ int copy_fpstate_to_sigframe(void __user *buf, void __user *buf_fx, int size)
 			sizeof(struct user_i387_ia32_struct), NULL,
 			(struct _fpstate_32 __user *) buf) ? -1 : 1;
 
-	if (fpu->initialized || using_compacted_format()) {
-		/* Save the live register state to the user directly. */
-		if (copy_fpregs_to_sigframe(buf_fx))
-			return -1;
-		/* Update the thread's fxstate to save the fsave header. */
-		if (ia32_fxstate)
-			copy_fxregs_to_kernel(fpu);
-	} else {
-		/*
-		 * It is a *bug* if kernel uses compacted-format for xsave
-		 * area and we copy it out directly to a signal frame. It
-		 * should have been handled above by saving the registers
-		 * directly.
-		 */
-		if (boot_cpu_has(X86_FEATURE_XSAVES)) {
-			WARN_ONCE(1, "x86/fpu: saving compacted-format xsave area to a signal frame!\n");
-			return -1;
-		}
-
-		fpstate_sanitize_xstate(fpu);
-		if (__copy_to_user(buf_fx, xsave, fpu_user_xstate_size))
-			return -1;
-	}
+	/* Save the live registers state to the user frame directly. */
+	if (copy_fpregs_to_sigframe(buf_fx))
+		return -1;
+	/* Update the thread's fxstate to save the fsave header. */
+	if (ia32_fxstate)
+		copy_fxregs_to_kernel(fpu);
 
 	/* Save the fsave header for the 32-bit frames. */
 	if ((ia32_fxstate || !use_fxsr()) && save_fsave_header(tsk, buf))
