Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51838C606A8
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 09:22:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AEF82064B
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 09:22:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729839AbfGHJWr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 05:22:47 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38857 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729806AbfGHJWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 05:22:43 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hkPr7-0004pb-0t; Mon, 08 Jul 2019 11:22:41 +0200
Date:   Mon, 08 Jul 2019 09:05:37 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] x86/fpu for 5.3-rc1
References: <156257673794.14831.1593297636367057887.tglx@nanos.tec.linutronix.de>
Message-ID: <156257673796.14831.15725585116804363393.tglx@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest x86-fpu-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-fpu-for-linus

up to:  7891bc0ab739: x86/fpu: Inline fpu__xstate_clear_all_cpu_caps()

A small set of updates for the FPU code:

  - Make the no387/nofxsr command line options useful by restricting them
    to 32bit and actually clearing all dependencies to prevent random
    crashes and malfunction.

  - Simplify and cleanup the kernel_fpu_*() helpers

Thanks,

	tglx

------------------>
Christoph Hellwig (3):
      x86/fpu: Simplify kernel_fpu_end()
      x86/fpu: Simplify kernel_fpu_begin()
      x86/fpu: Remove the fpu__save() export

Sebastian Andrzej Siewior (2):
      x86/fpu: Make 'no387' and 'nofxsr' command line options useful
      x86/fpu: Inline fpu__xstate_clear_all_cpu_caps()


 arch/x86/include/asm/fpu/xstate.h |  1 -
 arch/x86/kernel/cpu/cpuid-deps.c  |  5 ++++
 arch/x86/kernel/fpu/core.c        | 52 +++++++++++----------------------------
 arch/x86/kernel/fpu/init.c        | 19 ++++++--------
 arch/x86/kernel/fpu/xstate.c      | 11 +--------
 5 files changed, 29 insertions(+), 59 deletions(-)

diff --git a/arch/x86/include/asm/fpu/xstate.h b/arch/x86/include/asm/fpu/xstate.h
index 7e42b285c856..c6136d79f8c0 100644
--- a/arch/x86/include/asm/fpu/xstate.h
+++ b/arch/x86/include/asm/fpu/xstate.h
@@ -47,7 +47,6 @@ extern u64 xstate_fx_sw_bytes[USER_XSTATE_FX_SW_WORDS];
 extern void __init update_regset_xstate_info(unsigned int size,
 					     u64 xstate_mask);
 
-void fpu__xstate_clear_all_cpu_caps(void);
 void *get_xsave_addr(struct xregs_state *xsave, int xfeature_nr);
 const void *get_xsave_field_ptr(int xfeature_nr);
 int using_compacted_format(void);
diff --git a/arch/x86/kernel/cpu/cpuid-deps.c b/arch/x86/kernel/cpu/cpuid-deps.c
index 2c0bd38a44ab..e794e3860fc8 100644
--- a/arch/x86/kernel/cpu/cpuid-deps.c
+++ b/arch/x86/kernel/cpu/cpuid-deps.c
@@ -20,6 +20,7 @@ struct cpuid_dep {
  * but it's difficult to tell that to the init reference checker.
  */
 static const struct cpuid_dep cpuid_deps[] = {
+	{ X86_FEATURE_FXSR,		X86_FEATURE_FPU	      },
 	{ X86_FEATURE_XSAVEOPT,		X86_FEATURE_XSAVE     },
 	{ X86_FEATURE_XSAVEC,		X86_FEATURE_XSAVE     },
 	{ X86_FEATURE_XSAVES,		X86_FEATURE_XSAVE     },
@@ -27,7 +28,11 @@ static const struct cpuid_dep cpuid_deps[] = {
 	{ X86_FEATURE_PKU,		X86_FEATURE_XSAVE     },
 	{ X86_FEATURE_MPX,		X86_FEATURE_XSAVE     },
 	{ X86_FEATURE_XGETBV1,		X86_FEATURE_XSAVE     },
+	{ X86_FEATURE_CMOV,		X86_FEATURE_FXSR      },
+	{ X86_FEATURE_MMX,		X86_FEATURE_FXSR      },
+	{ X86_FEATURE_MMXEXT,		X86_FEATURE_MMX       },
 	{ X86_FEATURE_FXSR_OPT,		X86_FEATURE_FXSR      },
+	{ X86_FEATURE_XSAVE,		X86_FEATURE_FXSR      },
 	{ X86_FEATURE_XMM,		X86_FEATURE_FXSR      },
 	{ X86_FEATURE_XMM2,		X86_FEATURE_XMM       },
 	{ X86_FEATURE_XMM3,		X86_FEATURE_XMM2      },
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 649fbc3fcf9f..12c70840980e 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -43,18 +43,6 @@ static DEFINE_PER_CPU(bool, in_kernel_fpu);
  */
 DEFINE_PER_CPU(struct fpu *, fpu_fpregs_owner_ctx);
 
-static void kernel_fpu_disable(void)
-{
-	WARN_ON_FPU(this_cpu_read(in_kernel_fpu));
-	this_cpu_write(in_kernel_fpu, true);
-}
-
-static void kernel_fpu_enable(void)
-{
-	WARN_ON_FPU(!this_cpu_read(in_kernel_fpu));
-	this_cpu_write(in_kernel_fpu, false);
-}
-
 static bool kernel_fpu_disabled(void)
 {
 	return this_cpu_read(in_kernel_fpu);
@@ -94,42 +82,33 @@ bool irq_fpu_usable(void)
 }
 EXPORT_SYMBOL(irq_fpu_usable);
 
-static void __kernel_fpu_begin(void)
+void kernel_fpu_begin(void)
 {
-	struct fpu *fpu = &current->thread.fpu;
+	preempt_disable();
 
 	WARN_ON_FPU(!irq_fpu_usable());
+	WARN_ON_FPU(this_cpu_read(in_kernel_fpu));
 
-	kernel_fpu_disable();
+	this_cpu_write(in_kernel_fpu, true);
 
-	if (!(current->flags & PF_KTHREAD)) {
-		if (!test_thread_flag(TIF_NEED_FPU_LOAD)) {
-			set_thread_flag(TIF_NEED_FPU_LOAD);
-			/*
-			 * Ignore return value -- we don't care if reg state
-			 * is clobbered.
-			 */
-			copy_fpregs_to_fpstate(fpu);
-		}
+	if (!(current->flags & PF_KTHREAD) &&
+	    !test_thread_flag(TIF_NEED_FPU_LOAD)) {
+		set_thread_flag(TIF_NEED_FPU_LOAD);
+		/*
+		 * Ignore return value -- we don't care if reg state
+		 * is clobbered.
+		 */
+		copy_fpregs_to_fpstate(&current->thread.fpu);
 	}
 	__cpu_invalidate_fpregs_state();
 }
-
-static void __kernel_fpu_end(void)
-{
-	kernel_fpu_enable();
-}
-
-void kernel_fpu_begin(void)
-{
-	preempt_disable();
-	__kernel_fpu_begin();
-}
 EXPORT_SYMBOL_GPL(kernel_fpu_begin);
 
 void kernel_fpu_end(void)
 {
-	__kernel_fpu_end();
+	WARN_ON_FPU(!this_cpu_read(in_kernel_fpu));
+
+	this_cpu_write(in_kernel_fpu, false);
 	preempt_enable();
 }
 EXPORT_SYMBOL_GPL(kernel_fpu_end);
@@ -155,7 +134,6 @@ void fpu__save(struct fpu *fpu)
 	trace_x86_fpu_after_save(fpu);
 	fpregs_unlock();
 }
-EXPORT_SYMBOL_GPL(fpu__save);
 
 /*
  * Legacy x87 fpstate state init:
diff --git a/arch/x86/kernel/fpu/init.c b/arch/x86/kernel/fpu/init.c
index ef0030e3fe6b..6ce7e0a23268 100644
--- a/arch/x86/kernel/fpu/init.c
+++ b/arch/x86/kernel/fpu/init.c
@@ -204,12 +204,6 @@ static void __init fpu__init_system_xstate_size_legacy(void)
 	 */
 
 	if (!boot_cpu_has(X86_FEATURE_FPU)) {
-		/*
-		 * Disable xsave as we do not support it if i387
-		 * emulation is enabled.
-		 */
-		setup_clear_cpu_cap(X86_FEATURE_XSAVE);
-		setup_clear_cpu_cap(X86_FEATURE_XSAVEOPT);
 		fpu_kernel_xstate_size = sizeof(struct swregs_state);
 	} else {
 		if (boot_cpu_has(X86_FEATURE_FXSR))
@@ -252,17 +246,20 @@ static void __init fpu__init_parse_early_param(void)
 	char *argptr = arg;
 	int bit;
 
+#ifdef CONFIG_X86_32
 	if (cmdline_find_option_bool(boot_command_line, "no387"))
+#ifdef CONFIG_MATH_EMULATION
 		setup_clear_cpu_cap(X86_FEATURE_FPU);
+#else
+		pr_err("Option 'no387' required CONFIG_MATH_EMULATION enabled.\n");
+#endif
 
-	if (cmdline_find_option_bool(boot_command_line, "nofxsr")) {
+	if (cmdline_find_option_bool(boot_command_line, "nofxsr"))
 		setup_clear_cpu_cap(X86_FEATURE_FXSR);
-		setup_clear_cpu_cap(X86_FEATURE_FXSR_OPT);
-		setup_clear_cpu_cap(X86_FEATURE_XMM);
-	}
+#endif
 
 	if (cmdline_find_option_bool(boot_command_line, "noxsave"))
-		fpu__xstate_clear_all_cpu_caps();
+		setup_clear_cpu_cap(X86_FEATURE_XSAVE);
 
 	if (cmdline_find_option_bool(boot_command_line, "noxsaveopt"))
 		setup_clear_cpu_cap(X86_FEATURE_XSAVEOPT);
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 3c36dd1784db..7b4c52aa929f 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -67,15 +67,6 @@ static unsigned int xstate_comp_offsets[sizeof(xfeatures_mask)*8];
  */
 unsigned int fpu_user_xstate_size;
 
-/*
- * Clear all of the X86_FEATURE_* bits that are unavailable
- * when the CPU has no XSAVE support.
- */
-void fpu__xstate_clear_all_cpu_caps(void)
-{
-	setup_clear_cpu_cap(X86_FEATURE_XSAVE);
-}
-
 /*
  * Return whether the system supports a given xfeature.
  *
@@ -709,7 +700,7 @@ static void fpu__init_disable_system_xstate(void)
 {
 	xfeatures_mask = 0;
 	cr4_clear_bits(X86_CR4_OSXSAVE);
-	fpu__xstate_clear_all_cpu_caps();
+	setup_clear_cpu_cap(X86_FEATURE_XSAVE);
 }
 
 /*

