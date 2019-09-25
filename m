Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B834DC4360D
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 15:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EA7E222CD
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 15:29:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439694AbfIYP3G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 11:29:06 -0400
Received: from mga03.intel.com ([134.134.136.65]:20435 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2439613AbfIYP3A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 11:29:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Sep 2019 08:28:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,548,1559545200"; 
   d="scan'208";a="196032285"
Received: from yyu32-desk1.sc.intel.com ([10.144.153.205])
  by FMSMGA003.fm.intel.com with ESMTP; 25 Sep 2019 08:28:58 -0700
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Rik van Riel <riel@surriel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH 5/6] x86/fpu/xstate: Define new functions for clearing fpregs and xstates
Date:   Wed, 25 Sep 2019 08:10:21 -0700
Message-Id: <20190925151022.21688-6-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190925151022.21688-1-yu-cheng.yu@intel.com>
References: <20190925151022.21688-1-yu-cheng.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fenghua Yu <fenghua.yu@intel.com>

Currently, fpu__clear() clears all fpregs and xstates.  Once XSAVES
supervisor states are introduced, supervisor settings must remain active
for signals; it is necessary to have separate functions:

 - Create fpu__clear_user_states(): clear only user settings for signals;
 - Create fpu__clear_all(): clear both user and supervisor settings in
   flush_thread().

Also modify copy_init_fpstate_to_fpregs() to take a mask from above two
functions.

Co-developed-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/include/asm/fpu/internal.h |  3 ++-
 arch/x86/kernel/fpu/core.c          | 32 ++++++++++++++++++-----------
 arch/x86/kernel/fpu/signal.c        |  4 ++--
 arch/x86/kernel/process.c           |  2 +-
 arch/x86/kernel/signal.c            |  2 +-
 5 files changed, 26 insertions(+), 17 deletions(-)

diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index f56ad1248b5d..ec08351fd5b4 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -31,7 +31,8 @@ extern void fpu__save(struct fpu *fpu);
 extern int  fpu__restore_sig(void __user *buf, int ia32_frame);
 extern void fpu__drop(struct fpu *fpu);
 extern int  fpu__copy(struct task_struct *dst, struct task_struct *src);
-extern void fpu__clear(struct fpu *fpu);
+extern void fpu__clear_user_states(struct fpu *fpu);
+extern void fpu__clear_all(struct fpu *fpu);
 extern int  fpu__exception_code(struct fpu *fpu, int trap_nr);
 extern int  dump_fpu(struct pt_regs *ptregs, struct user_i387_struct *fpstate);
 
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 12c70840980e..2c946ba78b1d 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -294,12 +294,12 @@ void fpu__drop(struct fpu *fpu)
  * Clear FPU registers by setting them up from
  * the init fpstate:
  */
-static inline void copy_init_fpstate_to_fpregs(void)
+static inline void copy_init_fpstate_to_fpregs(u64 features_mask)
 {
 	fpregs_lock();
 
 	if (use_xsave())
-		copy_kernel_to_xregs(&init_fpstate.xsave, -1);
+		copy_kernel_to_xregs(&init_fpstate.xsave, features_mask);
 	else if (static_cpu_has(X86_FEATURE_FXSR))
 		copy_kernel_to_fxregs(&init_fpstate.fxsave);
 	else
@@ -312,24 +312,32 @@ static inline void copy_init_fpstate_to_fpregs(void)
 	fpregs_unlock();
 }
 
+static void fpu__clear_states(struct fpu *fpu, u64 xfeatures_mask)
+{
+	WARN_ON_FPU(fpu != &current->thread.fpu);
+
+	fpu__drop(fpu);
+
+	/* Make sure fpstate is cleared and initialized. */
+	fpu__initialize(fpu);
+	if (static_cpu_has(X86_FEATURE_FPU))
+		copy_init_fpstate_to_fpregs(xfeatures_mask);
+}
+
 /*
  * Clear the FPU state back to init state.
  *
  * Called by sys_execve(), by the signal handler code and by various
  * error paths.
  */
-void fpu__clear(struct fpu *fpu)
+void fpu__clear_user_states(struct fpu *fpu)
 {
-	WARN_ON_FPU(fpu != &current->thread.fpu); /* Almost certainly an anomaly */
-
-	fpu__drop(fpu);
+	fpu__clear_states(fpu, xfeatures_mask_user());
+}
 
-	/*
-	 * Make sure fpstate is cleared and initialized.
-	 */
-	fpu__initialize(fpu);
-	if (static_cpu_has(X86_FEATURE_FPU))
-		copy_init_fpstate_to_fpregs();
+void fpu__clear_all(struct fpu *fpu)
+{
+	fpu__clear_states(fpu, xfeatures_mask_all);
 }
 
 /*
diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index c1f0688f35cf..25e7dddbc6fd 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -288,7 +288,7 @@ static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
 			 IS_ENABLED(CONFIG_IA32_EMULATION));
 
 	if (!buf) {
-		fpu__clear(fpu);
+		fpu__clear_user_states(fpu);
 		return 0;
 	}
 
@@ -412,7 +412,7 @@ static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
 
 err_out:
 	if (ret)
-		fpu__clear(fpu);
+		fpu__clear_user_states(fpu);
 	return ret;
 }
 
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 75fea0d48c0e..d360bf4d696b 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -139,7 +139,7 @@ void flush_thread(void)
 	flush_ptrace_hw_breakpoint(tsk);
 	memset(tsk->thread.tls_array, 0, sizeof(tsk->thread.tls_array));
 
-	fpu__clear(&tsk->thread.fpu);
+	fpu__clear_all(&tsk->thread.fpu);
 }
 
 void disable_TSC(void)
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index 8eb7193e158d..ce9421ec285f 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -763,7 +763,7 @@ handle_signal(struct ksignal *ksig, struct pt_regs *regs)
 		/*
 		 * Ensure the signal handler starts with the new fpu state.
 		 */
-		fpu__clear(fpu);
+		fpu__clear_user_states(fpu);
 	}
 	signal_setup_done(failed, ksig, stepping);
 }
-- 
2.17.1

