Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC5FCC10F11
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 21:01:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 870162084E
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 21:01:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727250AbfDMVBx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 17:01:53 -0400
Received: from terminus.zytor.com ([198.137.202.136]:34953 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726964AbfDMVBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 17:01:53 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3DL1UME2267456
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 13 Apr 2019 14:01:30 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3DL1Uev2267453;
        Sat, 13 Apr 2019 14:01:30 -0700
Date:   Sat, 13 Apr 2019 14:01:30 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Sebastian Andrzej Siewior <tipbot@zytor.com>
Message-ID: <tip-c2ff9e9a3d9d6c019394a22989a228d02970a8b1@git.kernel.org>
Cc:     rkrcmar@redhat.com, hpa@zytor.com, mingo@redhat.com,
        bigeasy@linutronix.de, tglx@linutronix.de, dave.hansen@intel.com,
        bp@suse.de, pbonzini@redhat.com, luto@kernel.org, jannh@google.com,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org, x86@kernel.org,
        riel@surriel.com, Jason@zx2c4.com, mingo@kernel.org
Reply-To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
          x86@kernel.org, riel@surriel.com, Jason@zx2c4.com,
          mingo@kernel.org, rkrcmar@redhat.com, hpa@zytor.com,
          mingo@redhat.com, bigeasy@linutronix.de, tglx@linutronix.de,
          dave.hansen@intel.com, bp@suse.de, luto@kernel.org,
          pbonzini@redhat.com, jannh@google.com
In-Reply-To: <20190403164156.19645-23-bigeasy@linutronix.de>
References: <20190403164156.19645-23-bigeasy@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/fpu] x86/fpu: Merge the two code paths in
 __fpu__restore_sig()
Git-Commit-ID: c2ff9e9a3d9d6c019394a22989a228d02970a8b1
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

Commit-ID:  c2ff9e9a3d9d6c019394a22989a228d02970a8b1
Gitweb:     https://git.kernel.org/tip/c2ff9e9a3d9d6c019394a22989a228d02970a8b1
Author:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate: Wed, 3 Apr 2019 18:41:51 +0200
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Fri, 12 Apr 2019 15:41:25 +0200

x86/fpu: Merge the two code paths in __fpu__restore_sig()

The ia32_fxstate case (32bit with fxsr) and the other (64bit frames or
32bit frames without fxsr) restore both from kernel memory and sanitize
the content.

The !ia32_fxstate version restores missing xstates from "init state"
while the ia32_fxstate doesn't and skips it.

Merge the two code paths and keep the !ia32_fxstate one. Copy only the
user_i387_ia32_struct data structure in the ia32_fxstate.

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
Link: https://lkml.kernel.org/r/20190403164156.19645-23-bigeasy@linutronix.de
---
 arch/x86/kernel/fpu/signal.c | 139 +++++++++++++++++--------------------------
 1 file changed, 54 insertions(+), 85 deletions(-)

diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index 9ea1eaa4c9b1..b13e86b29426 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -263,12 +263,17 @@ static inline int copy_user_to_fpregs_zeroing(void __user *buf, u64 xbv, int fx_
 
 static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
 {
+	struct user_i387_ia32_struct *envp = NULL;
+	int state_size = fpu_kernel_xstate_size;
 	int ia32_fxstate = (buf != buf_fx);
 	struct task_struct *tsk = current;
 	struct fpu *fpu = &tsk->thread.fpu;
-	int state_size = fpu_kernel_xstate_size;
+	struct user_i387_ia32_struct env;
+	union fpregs_state *state;
 	u64 xfeatures = 0;
 	int fx_only = 0;
+	int ret = 0;
+	void *tmp;
 
 	ia32_fxstate &= (IS_ENABLED(CONFIG_X86_32) ||
 			 IS_ENABLED(CONFIG_IA32_EMULATION));
@@ -303,105 +308,69 @@ static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
 		}
 	}
 
+	tmp = kzalloc(sizeof(*state) + fpu_kernel_xstate_size + 64, GFP_KERNEL);
+	if (!tmp)
+		return -ENOMEM;
+	state = PTR_ALIGN(tmp, 64);
+
+	if ((unsigned long)buf_fx % 64)
+		fx_only = 1;
+
+	/*
+	 * For 32-bit frames with fxstate, copy the fxstate so it can be
+	 * reconstructed later.
+	 */
 	if (ia32_fxstate) {
-		/*
-		 * For 32-bit frames with fxstate, copy the user state to the
-		 * thread's fpu state, reconstruct fxstate from the fsave
-		 * header. Validate and sanitize the copied state.
-		 */
-		struct user_i387_ia32_struct env;
-		union fpregs_state *state;
-		int err = 0;
-		void *tmp;
+		ret = __copy_from_user(&env, buf, sizeof(env));
+		if (ret)
+			goto err_out;
+		envp = &env;
+	}
 
-		tmp = kzalloc(sizeof(*state) + fpu_kernel_xstate_size + 64, GFP_KERNEL);
-		if (!tmp)
-			return -ENOMEM;
-		state = PTR_ALIGN(tmp, 64);
+	if (use_xsave() && !fx_only) {
+		u64 init_bv = xfeatures_mask & ~xfeatures;
 
 		if (using_compacted_format()) {
-			err = copy_user_to_xstate(&state->xsave, buf_fx);
+			ret = copy_user_to_xstate(&state->xsave, buf_fx);
 		} else {
-			err = __copy_from_user(&state->xsave, buf_fx, state_size);
+			ret = __copy_from_user(&state->xsave, buf_fx, state_size);
 
-			if (!err && state_size > offsetof(struct xregs_state, header))
-				err = validate_xstate_header(&state->xsave.header);
+			if (!ret && state_size > offsetof(struct xregs_state, header))
+				ret = validate_xstate_header(&state->xsave.header);
 		}
+		if (ret)
+			goto err_out;
 
-		if (err || __copy_from_user(&env, buf, sizeof(env))) {
-			err = -1;
-		} else {
-			sanitize_restored_xstate(state, &env, xfeatures, fx_only);
-			copy_kernel_to_fpregs(state);
-		}
-
-		kfree(tmp);
-		return err;
-	} else {
-		union fpregs_state *state;
-		void *tmp;
-		int ret;
-
-		tmp = kzalloc(sizeof(*state) + fpu_kernel_xstate_size + 64, GFP_KERNEL);
-		if (!tmp)
-			return -ENOMEM;
-		state = PTR_ALIGN(tmp, 64);
-
-		/*
-		 * For 64-bit frames and 32-bit fsave frames, restore the user
-		 * state to the registers directly (with exceptions handled).
-		 */
-		if ((unsigned long)buf_fx % 64)
-			fx_only = 1;
-
-		if (use_xsave() && !fx_only) {
-			u64 init_bv = xfeatures_mask & ~xfeatures;
-
-			if (using_compacted_format()) {
-				ret = copy_user_to_xstate(&state->xsave, buf_fx);
-			} else {
-				ret = __copy_from_user(&state->xsave, buf_fx, state_size);
-
-				if (!ret && state_size > offsetof(struct xregs_state, header))
-					ret = validate_xstate_header(&state->xsave.header);
-			}
-			if (ret)
-				goto err_out;
-
-			sanitize_restored_xstate(state, NULL, xfeatures, fx_only);
-
-			if (unlikely(init_bv))
-				copy_kernel_to_xregs(&init_fpstate.xsave, init_bv);
-			ret = copy_kernel_to_xregs_err(&state->xsave, xfeatures);
+		sanitize_restored_xstate(state, envp, xfeatures, fx_only);
 
-		} else if (use_fxsr()) {
-			ret = __copy_from_user(&state->fxsave, buf_fx, state_size);
-			if (ret)
-				goto err_out;
+		if (unlikely(init_bv))
+			copy_kernel_to_xregs(&init_fpstate.xsave, init_bv);
+		ret = copy_kernel_to_xregs_err(&state->xsave, xfeatures);
 
-			if (use_xsave()) {
-				u64 init_bv = xfeatures_mask & ~XFEATURE_MASK_FPSSE;
-				copy_kernel_to_xregs(&init_fpstate.xsave, init_bv);
-			}
-			state->fxsave.mxcsr &= mxcsr_feature_mask;
+	} else if (use_fxsr()) {
+		ret = __copy_from_user(&state->fxsave, buf_fx, state_size);
+		if (ret)
+			goto err_out;
 
-			ret = copy_kernel_to_fxregs_err(&state->fxsave);
-		} else {
-			ret = __copy_from_user(&state->fsave, buf_fx, state_size);
-			if (ret)
-				goto err_out;
-			ret = copy_kernel_to_fregs_err(&state->fsave);
+		sanitize_restored_xstate(state, envp, xfeatures, fx_only);
+		if (use_xsave()) {
+			u64 init_bv = xfeatures_mask & ~XFEATURE_MASK_FPSSE;
+			copy_kernel_to_xregs(&init_fpstate.xsave, init_bv);
 		}
 
-err_out:
-		kfree(tmp);
-		if (ret) {
-			fpu__clear(fpu);
-			return -1;
-		}
+		ret = copy_kernel_to_fxregs_err(&state->fxsave);
+	} else {
+		ret = __copy_from_user(&state->fsave, buf_fx, state_size);
+		if (ret)
+			goto err_out;
+		ret = copy_kernel_to_fregs_err(&state->fsave);
 	}
 
-	return 0;
+err_out:
+	kfree(tmp);
+	if (ret)
+		fpu__clear(fpu);
+	return ret;
 }
 
 static inline int xstate_sigframe_size(void)
