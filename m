Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11F8AC04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 17:03:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5CDA216F4
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 17:03:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729119AbfEHRDx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 13:03:53 -0400
Received: from mga03.intel.com ([134.134.136.65]:5319 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728982AbfEHRDF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 13:03:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 May 2019 10:03:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,446,1549958400"; 
   d="scan'208";a="169697586"
Received: from chang-linux-3.sc.intel.com ([172.25.66.171])
  by fmsmga002.fm.intel.com with ESMTP; 08 May 2019 10:03:04 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>
Cc:     Ravi Shankar <ravi.v.shankar@intel.com>,
        "Chang S . Bae" <chang.seok.bae@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH v7 12/18] x86/fsgsbase/64: GSBASE handling with FSGSBASE in the paranoid path
Date:   Wed,  8 May 2019 03:02:27 -0700
Message-Id: <1557309753-24073-13-git-send-email-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1557309753-24073-1-git-send-email-chang.seok.bae@intel.com>
References: <1557309753-24073-1-git-send-email-chang.seok.bae@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without FSGSBASE, user space cannot change GSBASE other than through
the PRCTL. On the transition from user space to kernel, SWAPGS is used
to swap the content of GSBASE and MSR_KERNEL_GS_BASE. However, SWAPGS
should only be used if entering from user mode to kernel mode.
Particularly in an super-atomic entry like the paranoid entry, the
differentiation of kernel and user GSBASE is based on the
kernel-enforced convention. A negative GSBASE indicates a kernel value
and a positive GSBASE means a user value.

In an FSGSBASE system, user space can set an arbitrary GSBASE value
without kernel interactions. Even, the value can be the same as the
kernel GSBASE. Therefore, the SWAPGS cannot be used in the paranoid
path, as the kernel-enforced convention is broken.

The new way to handle GSBASE is:

On entry:
	%rbx = RDGSBASE()
	kernel_GSBASE = FIND_PERCPU_BASE()
	WRGSBASE(kernel_GSBASE)

On exit:
	WRGSBASE(%rbx)

The original GSBASE will be always stashed on entry and restored at
exit. And the kernel GSBASE will be loaded in the paranoid path. The
new SAVE_AND_SET_GSBASE() macro wraps up the operations on the entry
side.

Obviously, for the non-paranoid path, it all keeps working exactly like
it does now.

Suggested-by: H. Peter Anvin <hpa@zytor.com>
Suggested-by: Andy Lutomirski <luto@kernel.org>
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
---
 arch/x86/entry/calling.h  |   6 +++
 arch/x86/entry/entry_64.S | 125 +++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 118 insertions(+), 13 deletions(-)

diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
index 6cbf793..d6eb584 100644
--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -380,6 +380,12 @@ For 32-bit we have the following conventions - kernel is built with
 	.endif
 .endm
 
+.macro SAVE_AND_SET_GSBASE scratch_reg:req save_reg:req
+	rdgsbase \save_reg
+	GET_PERCPU_BASE \scratch_reg
+	wrgsbase \scratch_reg
+.endm
+
 #endif /* CONFIG_X86_64 */
 
 .macro STACKLEAK_ERASE
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 034d8f8..c95999c 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -38,6 +38,7 @@
 #include <asm/export.h>
 #include <asm/frame.h>
 #include <asm/nospec-branch.h>
+#include <asm/fsgsbase.h>
 #include <linux/err.h>
 
 #include "calling.h"
@@ -933,8 +934,13 @@ ENTRY(\sym)
 	addq	$\ist_offset, CPU_TSS_IST(\shift_ist)
 	.endif
 
-	/* these procedures expect "no swapgs" flag in ebx */
 	.if \paranoid
+	/*
+	 * If the current system is FSGSBASE-enabled, the original
+	 * GSBASE is stashed in %rbx. On the other systems,
+	 * expect "no swapgs" flag in %ebx. (See details
+	 * in the paranoid_entry and paranoid_exit)
+	 */
 	jmp	paranoid_exit
 	.else
 	jmp	error_exit
@@ -1150,9 +1156,21 @@ idtentry machine_check		do_mce			has_error_code=0	paranoid=1
 #endif
 
 /*
- * Save all registers in pt_regs, and switch gs if needed.
- * Use slow, but surefire "are we in kernel?" check.
- * Return: ebx=0: need swapgs on exit, ebx=1: otherwise
+ * Save all registers in pt_regs.
+ *
+ * On non-FSGSBASE systems, traditionally, SWAPGS is used to swap
+ * the content of GSBASE and MSR_KERNEL_GS_BASE on the transition
+ * from user space to kernel. It is determined by the GSBASE value
+ * based on the kernel-enforced convention. If GSBASE is negative,
+ * it means a kernel value, and if the value is positive, it
+ * indicates a user value. On return, reset %ebx=0 if SWAPGS is
+ * needed at exit. And set %ebx=1 if not needed.
+ *
+ * On FSGSBASE systems, SWAPGS is not applicable to handle GSBASE,
+ * as the kernel-enforced convention is no longer valid. FSGSBASE
+ * instructions allow user space to set arbitrary GSBASE values.
+ * The new way of handling GSBASE, instead, is always stash GSBASE
+ * in %rbx and res tore it at exit.
  */
 ENTRY(paranoid_entry)
 	UNWIND_HINT_FUNC
@@ -1176,13 +1194,39 @@ ENTRY(paranoid_entry)
 	 */
 	SAVE_AND_SWITCH_TO_KERNEL_CR3 scratch_reg=%rax save_reg=%r14
 
-	movl	$1, %ebx
 	/*
-	 * The kernel-enforced convention is a negative GSBASE indicates
-	 * a kernel value.
+	 * The way handling GSBASE is quite different depending on
+	 * whether FSGSBASE is enabled or not. With FSGSBASE, we
+	 * cannot make any assumption in the GSBASE value. Whereas,
+	 * the traditional SWAPGS-based GSBASE handling has an
+	 * assumption that a negative GSBASE value always indicates
+	 * a kernel value. So, the path is split into two ways,
+	 * based on the FSGSBASE flag.
+	 */
+	ALTERNATIVE "jmp .Lparanoid_entry_no_fsgsbase",	"",\
+		X86_FEATURE_FSGSBASE
+
+	/*
+	 * The macro always stashes the (current) GSBSE in %rbx,
+	 * and retrieves and loads the kernel GSBASE. The stashed
+	 * GSBASE should be always restored at the exit. The
+	 * kernel GSBASE is set to be the per-CPU base.
 	 */
+	SAVE_AND_SET_GSBASE scratch_reg=%rax save_reg=%rbx
+	ret
+
+.Lparanoid_entry_no_fsgsbase:
+	/*
+	 * The macro reads the current GSBASE. And, based on the
+	 * value, it is determined whether current transition is
+	 * from user space to kernel or not. If the value is
+	 * nonnegative, it means a user space value, then do
+	 * SWAPGS and reset the flag (%ebx=0). Otherwise, set
+	 * the flag only (%ebx=1).
+	 */
+	movl	$1, %ebx
 	READ_MSR_GSBASE save_reg=%edx
-	testl	%edx, %edx	/* Negative -> in kernel */
+	testl	%edx, %edx
 	jns	.Lparanoid_entry_swapgs
 	ret
 
@@ -1202,25 +1246,55 @@ END(paranoid_entry)
  * be complicated.  Fortunately, we there's no good reason
  * to try to handle preemption here.
  *
- * On entry, ebx is "no swapgs" flag (1: don't need swapgs, 0: need it)
+ * On the entry, it is mentioned that why SWAPGS is not working
+ * with FSGSBASE and how GSBASE handling is different between
+ * FSGSBASE and non-FSGSBASE systems. And, therefore, the way
+ * to deal with GSBASE is diverged from there. At this point,
+ * therefore, %rbx or %ebx has different implications depending
+ * on the FSGSBASE availability.
+ *
+ * On FSGSBASE systems, the original GSBASE is always stashed
+ * in %rbx from the entry. At the exit here, it should be
+ * always restored.
+ *
+ * Whereas, on non-FSGSBASE systems, %ebx indicates "no swapgs"
+ * flag. 0 means that SWAPGS is needed here at exit, and 1
+ * means no need.
  */
 ENTRY(paranoid_exit)
 	UNWIND_HINT_REGS
 	DISABLE_INTERRUPTS(CLBR_ANY)
 	TRACE_IRQS_OFF_DEBUG
-	testl	%ebx, %ebx			/* swapgs needed? */
+
+	/*
+	 * As the way of handling GSBASE is already split from the
+	 * entry, GSBASE is dealt here accordingly in two different
+	 * ways.
+	 */
+	ALTERNATIVE "jmp .Lparanoid_exit_no_fsgsbase",	"nop",\
+		X86_FEATURE_FSGSBASE
+
+	/* On FSGSBASE systems, always restore the stashed GSBASE */
+	wrgsbase	%rbx
+	jmp	.Lparanoid_exit_no_swapgs;
+
+.Lparanoid_exit_no_fsgsbase:
+	/* On non-FSGSBASE systems, conditionally do SWAPGS */
+	testl	%ebx, %ebx
 	jnz	.Lparanoid_exit_no_swapgs
 	TRACE_IRQS_IRETQ
 	/* Always restore stashed CR3 value (see paranoid_entry) */
 	RESTORE_CR3	scratch_reg=%rbx save_reg=%r14
 	SWAPGS_UNSAFE_STACK
 	jmp	.Lparanoid_exit_restore
+
 .Lparanoid_exit_no_swapgs:
 	TRACE_IRQS_IRETQ_DEBUG
 	/* Always restore stashed CR3 value (see paranoid_entry) */
 	RESTORE_CR3	scratch_reg=%rbx save_reg=%r14
+
 .Lparanoid_exit_restore:
-	jmp restore_regs_and_return_to_kernel
+	jmp	restore_regs_and_return_to_kernel
 END(paranoid_exit)
 
 /*
@@ -1614,7 +1688,7 @@ end_repeat_nmi:
 	pushq	$-1				/* ORIG_RAX: no syscall to restart */
 
 	/*
-	 * Use paranoid_entry to handle SWAPGS, but no need to use paranoid_exit
+	 * Use paranoid_entry to handle GSBASE, but no need to useparanoid_exit
 	 * as we should not be calling schedule in NMI context.
 	 * Even with normal interrupts enabled. An NMI should not be
 	 * setting NEED_RESCHED or anything that normal interrupts and
@@ -1631,10 +1705,35 @@ end_repeat_nmi:
 	/* Always restore stashed CR3 value (see paranoid_entry) */
 	RESTORE_CR3 scratch_reg=%r15 save_reg=%r14
 
-	testl	%ebx, %ebx			/* swapgs needed? */
+	/*
+	 * The paranoid_entry, called in this NMI path, handles
+	 * GSBASE differently depending on the FSGSBASE. And the
+	 * paranoid_exit is not called here, so the part of
+	 * GSBASE handling at the exit should be equally executed,
+	 * not to break the semantics.
+	 *
+	 * On the paranoid_exit, the %rbx/%ebx implications are
+	 * different between FSGSBASE and non-FSGSBASE systems.
+	 * And accordingly the handling path is split into two
+	 * ways.
+	 *
+	 * On non-FSGSBASE systems, SWAPGS is needed only if %ebx=0.
+	 * On FSGSBASE systems, always restore the stashed GSBASE
+	 * from %rbx.
+	 */
+	ALTERNATIVE "jmp nmi_no_fsgsbase", "nop",\
+		X86_FEATURE_FSGSBASE
+
+	wrgsbase	%rbx
+	jmp	nmi_restore
+
+nmi_no_fsgsbase:
+	testl	%ebx, %ebx
 	jnz	nmi_restore
+
 nmi_swapgs:
 	SWAPGS_UNSAFE_STACK
+
 nmi_restore:
 	POP_REGS
 
-- 
2.7.4

