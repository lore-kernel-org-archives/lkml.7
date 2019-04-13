Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF8DDC10F11
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 20:47:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE72C2084E
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 20:47:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727230AbfDMUru (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 16:47:50 -0400
Received: from terminus.zytor.com ([198.137.202.136]:55489 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726982AbfDMUrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 16:47:47 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3DKkXbB2264817
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 13 Apr 2019 13:46:33 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3DKkVVm2264814;
        Sat, 13 Apr 2019 13:46:31 -0700
Date:   Sat, 13 Apr 2019 13:46:31 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Sebastian Andrzej Siewior <tipbot@zytor.com>
Message-ID: <tip-39ea9baffda91df8bfee9b45610242a3191ea1ec@git.kernel.org>
Cc:     riel@surriel.com, linux-kernel@vger.kernel.org, hpa@zytor.com,
        jannh@google.com, dave.hansen@intel.com, mingo@kernel.org,
        mingo@redhat.com, x86@kernel.org, tglx@linutronix.de,
        pbonzini@redhat.com, bigeasy@linutronix.de, Jason@zx2c4.com,
        luto@kernel.org, rkrcmar@redhat.com, kvm@vger.kernel.org,
        bp@suse.de
Reply-To: bp@suse.de, kvm@vger.kernel.org, rkrcmar@redhat.com,
          Jason@zx2c4.com, luto@kernel.org, bigeasy@linutronix.de,
          pbonzini@redhat.com, tglx@linutronix.de, x86@kernel.org,
          mingo@redhat.com, mingo@kernel.org, dave.hansen@intel.com,
          jannh@google.com, hpa@zytor.com, linux-kernel@vger.kernel.org,
          riel@surriel.com
In-Reply-To: <20190403164156.19645-2-bigeasy@linutronix.de>
References: <20190403164156.19645-2-bigeasy@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/fpu] x86/fpu: Remove fpu->initialized usage in
 __fpu__restore_sig()
Git-Commit-ID: 39ea9baffda91df8bfee9b45610242a3191ea1ec
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

Commit-ID:  39ea9baffda91df8bfee9b45610242a3191ea1ec
Gitweb:     https://git.kernel.org/tip/39ea9baffda91df8bfee9b45610242a3191ea1ec
Author:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate: Wed, 3 Apr 2019 18:41:30 +0200
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Tue, 9 Apr 2019 19:27:29 +0200

x86/fpu: Remove fpu->initialized usage in __fpu__restore_sig()

This is a preparation for the removal of the ->initialized member in the
fpu struct.

__fpu__restore_sig() is deactivating the FPU via fpu__drop() and then
setting manually ->initialized followed by fpu__restore(). The result is
that it is possible to manipulate fpu->state and the state of registers
won't be saved/restored on a context switch which would overwrite
fpu->state:

fpu__drop(fpu):
  ...
  fpu->initialized = 0;
  preempt_enable();

  <--- context switch

Don't access the fpu->state while the content is read from user space
and examined/sanitized. Use a temporary kmalloc() buffer for the
preparation of the FPU registers and once the state is considered okay,
load it. Should something go wrong, return with an error and without
altering the original FPU registers.

The removal of fpu__initialize() is a nop because fpu->initialized is
already set for the user task.

 [ bp: Massage a bit. ]

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Dave Hansen <dave.hansen@intel.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Borislav Petkov <bp@suse.de>
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
Link: https://lkml.kernel.org/r/20190403164156.19645-2-bigeasy@linutronix.de
---
 arch/x86/include/asm/fpu/signal.h |  2 +-
 arch/x86/kernel/fpu/regset.c      |  5 ++---
 arch/x86/kernel/fpu/signal.c      | 40 +++++++++++++++------------------------
 3 files changed, 18 insertions(+), 29 deletions(-)

diff --git a/arch/x86/include/asm/fpu/signal.h b/arch/x86/include/asm/fpu/signal.h
index 44bbc39a57b3..7fb516b6893a 100644
--- a/arch/x86/include/asm/fpu/signal.h
+++ b/arch/x86/include/asm/fpu/signal.h
@@ -22,7 +22,7 @@ int ia32_setup_frame(int sig, struct ksignal *ksig,
 
 extern void convert_from_fxsr(struct user_i387_ia32_struct *env,
 			      struct task_struct *tsk);
-extern void convert_to_fxsr(struct task_struct *tsk,
+extern void convert_to_fxsr(struct fxregs_state *fxsave,
 			    const struct user_i387_ia32_struct *env);
 
 unsigned long
diff --git a/arch/x86/kernel/fpu/regset.c b/arch/x86/kernel/fpu/regset.c
index bc02f5144b95..5dbc099178a8 100644
--- a/arch/x86/kernel/fpu/regset.c
+++ b/arch/x86/kernel/fpu/regset.c
@@ -269,11 +269,10 @@ convert_from_fxsr(struct user_i387_ia32_struct *env, struct task_struct *tsk)
 		memcpy(&to[i], &from[i], sizeof(to[0]));
 }
 
-void convert_to_fxsr(struct task_struct *tsk,
+void convert_to_fxsr(struct fxregs_state *fxsave,
 		     const struct user_i387_ia32_struct *env)
 
 {
-	struct fxregs_state *fxsave = &tsk->thread.fpu.state.fxsave;
 	struct _fpreg *from = (struct _fpreg *) &env->st_space[0];
 	struct _fpxreg *to = (struct _fpxreg *) &fxsave->st_space[0];
 	int i;
@@ -350,7 +349,7 @@ int fpregs_set(struct task_struct *target, const struct user_regset *regset,
 
 	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf, &env, 0, -1);
 	if (!ret)
-		convert_to_fxsr(target, &env);
+		convert_to_fxsr(&target->thread.fpu.state.fxsave, &env);
 
 	/*
 	 * update the header bit in the xsave header, indicating the
diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index 55b80de13ea5..7296a9bb78e7 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -207,11 +207,11 @@ int copy_fpstate_to_sigframe(void __user *buf, void __user *buf_fx, int size)
 }
 
 static inline void
-sanitize_restored_xstate(struct task_struct *tsk,
+sanitize_restored_xstate(union fpregs_state *state,
 			 struct user_i387_ia32_struct *ia32_env,
 			 u64 xfeatures, int fx_only)
 {
-	struct xregs_state *xsave = &tsk->thread.fpu.state.xsave;
+	struct xregs_state *xsave = &state->xsave;
 	struct xstate_header *header = &xsave->header;
 
 	if (use_xsave()) {
@@ -238,7 +238,7 @@ sanitize_restored_xstate(struct task_struct *tsk,
 		 */
 		xsave->i387.mxcsr &= mxcsr_feature_mask;
 
-		convert_to_fxsr(tsk, ia32_env);
+		convert_to_fxsr(&state->fxsave, ia32_env);
 	}
 }
 
@@ -284,8 +284,6 @@ static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
 	if (!access_ok(buf, size))
 		return -EACCES;
 
-	fpu__initialize(fpu);
-
 	if (!static_cpu_has(X86_FEATURE_FPU))
 		return fpregs_soft_set(current, NULL,
 				       0, sizeof(struct user_i387_ia32_struct),
@@ -315,40 +313,32 @@ static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
 		 * header. Validate and sanitize the copied state.
 		 */
 		struct user_i387_ia32_struct env;
+		union fpregs_state *state;
 		int err = 0;
+		void *tmp;
 
-		/*
-		 * Drop the current fpu which clears fpu->initialized. This ensures
-		 * that any context-switch during the copy of the new state,
-		 * avoids the intermediate state from getting restored/saved.
-		 * Thus avoiding the new restored state from getting corrupted.
-		 * We will be ready to restore/save the state only after
-		 * fpu->initialized is again set.
-		 */
-		fpu__drop(fpu);
+		tmp = kzalloc(sizeof(*state) + fpu_kernel_xstate_size + 64, GFP_KERNEL);
+		if (!tmp)
+			return -ENOMEM;
+		state = PTR_ALIGN(tmp, 64);
 
 		if (using_compacted_format()) {
-			err = copy_user_to_xstate(&fpu->state.xsave, buf_fx);
+			err = copy_user_to_xstate(&state->xsave, buf_fx);
 		} else {
-			err = __copy_from_user(&fpu->state.xsave, buf_fx, state_size);
+			err = __copy_from_user(&state->xsave, buf_fx, state_size);
 
 			if (!err && state_size > offsetof(struct xregs_state, header))
-				err = validate_xstate_header(&fpu->state.xsave.header);
+				err = validate_xstate_header(&state->xsave.header);
 		}
 
 		if (err || __copy_from_user(&env, buf, sizeof(env))) {
-			fpstate_init(&fpu->state);
-			trace_x86_fpu_init_state(fpu);
 			err = -1;
 		} else {
-			sanitize_restored_xstate(tsk, &env, xfeatures, fx_only);
+			sanitize_restored_xstate(state, &env, xfeatures, fx_only);
+			copy_kernel_to_fpregs(state);
 		}
 
-		local_bh_disable();
-		fpu->initialized = 1;
-		fpu__restore(fpu);
-		local_bh_enable();
-
+		kfree(tmp);
 		return err;
 	} else {
 		/*
