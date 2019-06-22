Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A37EDC43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 10:11:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B18320665
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 10:11:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="RIQ1oDTT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbfFVKLT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 06:11:19 -0400
Received: from terminus.zytor.com ([198.137.202.136]:44673 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbfFVKLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 06:11:18 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5MABBnm2097397
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 22 Jun 2019 03:11:11 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5MABBnm2097397
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561198272;
        bh=j/DNIi/iDremzgIMMeTl2wiB9+LG3io3oQ57FQWE0M4=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=RIQ1oDTTU9HmmkpZMPLlsztDWTqUAgZ0psAW/vt92xjA/yLFmtdqszDmeYin7/mdo
         V8sCmws6AaAk74jpWg8q2Y9cncW35BzcXV1v+Q9kZZ2iB5rCw4uQ9mmOXZ4uBoZYK5
         Bg/GZO5lQNJB8/WZpLud6CiAnvA9ZlnYkrSwj478sg6UOmhoQfiSM/qQmvdgpkLVr1
         zirE+1GocgXKyLf4iYrG74/wd/SLyDm7sMUcI3ZkeROA4ZLt10cj1Ba1dduG4eUCFV
         dss2jdkD6MZ8f0f9qsbNODrVW6aEw4jagqhS8VpNCApxs584GLDi2J/UFwu35OWjjT
         /xIB/mbWF819A==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5MABBOO2097394;
        Sat, 22 Jun 2019 03:11:11 -0700
Date:   Sat, 22 Jun 2019 03:11:11 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   "tip-bot for Chang S. Bae" <tipbot@zytor.com>
Message-ID: <tip-708078f65721b46d82d9934a3f0b36a2b8ad0656@git.kernel.org>
Cc:     ravi.v.shankar@intel.com, hpa@zytor.com, luto@kernel.org,
        dave.hansen@linux.intel.com, linux-kernel@vger.kernel.org,
        mingo@kernel.org, tglx@linutronix.de, chang.seok.bae@intel.com,
        ak@linux.intel.com
Reply-To: mingo@kernel.org, linux-kernel@vger.kernel.org,
          tglx@linutronix.de, chang.seok.bae@intel.com, ak@linux.intel.com,
          hpa@zytor.com, ravi.v.shankar@intel.com, luto@kernel.org,
          dave.hansen@linux.intel.com
In-Reply-To: <1557309753-24073-13-git-send-email-chang.seok.bae@intel.com>
References: <1557309753-24073-13-git-send-email-chang.seok.bae@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cpu] x86/entry/64: Handle FSGSBASE enabled paranoid
 entry/exit
Git-Commit-ID: 708078f65721b46d82d9934a3f0b36a2b8ad0656
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

Commit-ID:  708078f65721b46d82d9934a3f0b36a2b8ad0656
Gitweb:     https://git.kernel.org/tip/708078f65721b46d82d9934a3f0b36a2b8ad0656
Author:     Chang S. Bae <chang.seok.bae@intel.com>
AuthorDate: Wed, 8 May 2019 03:02:27 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sat, 22 Jun 2019 11:38:54 +0200

x86/entry/64: Handle FSGSBASE enabled paranoid entry/exit

Without FSGSBASE, user space cannot change GSBASE other than through a
PRCTL. The kernel enforces that the user space GSBASE value is postive as
negative values are used for detecting the kernel space GSBASE value in the
paranoid entry code.

If FSGSBASE is enabled, user space can set arbitrary GSBASE values without
kernel intervention, including negative ones, which breaks the paranoid
entry assumptions.

To avoid this, paranoid entry needs to unconditionally save the current
GSBASE value independent of the interrupted context, retrieve and write the
kernel GSBASE and unconditionally restore the saved value on exit. The
restore happens either in paranoid_exit or in the special exit path of the
NMI low level code.

All other entry code pathes which use unconditional SWAPGS are not affected
as they do not depend on the actual content.

[ tglx: Massaged changelogs and comments ]

Suggested-by: H. Peter Anvin <hpa@zytor.com>
Suggested-by: Andy Lutomirski <luto@kernel.org>
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Ravi Shankar <ravi.v.shankar@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lkml.kernel.org/r/1557309753-24073-13-git-send-email-chang.seok.bae@intel.com

---
 arch/x86/entry/calling.h  |  6 ++++
 arch/x86/entry/entry_64.S | 80 ++++++++++++++++++++++++++++++++++++++++-------
 2 files changed, 75 insertions(+), 11 deletions(-)

diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
index 9a524360ae2e..d3fbe2dc03ea 100644
--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -338,6 +338,12 @@ For 32-bit we have the following conventions - kernel is built with
 #endif
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
index aaa846f8850a..7f9f5119d6b1 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -38,6 +38,7 @@
 #include <asm/export.h>
 #include <asm/frame.h>
 #include <asm/nospec-branch.h>
+#include <asm/fsgsbase.h>
 #include <linux/err.h>
 
 #include "calling.h"
@@ -947,7 +948,6 @@ ENTRY(\sym)
 	addq	$\ist_offset, CPU_TSS_IST(\shift_ist)
 	.endif
 
-	/* these procedures expect "no swapgs" flag in ebx */
 	.if \paranoid
 	jmp	paranoid_exit
 	.else
@@ -1164,9 +1164,14 @@ idtentry machine_check		do_mce			has_error_code=0	paranoid=1
 #endif
 
 /*
- * Save all registers in pt_regs, and switch gs if needed.
- * Use slow, but surefire "are we in kernel?" check.
- * Return: ebx=0: need swapgs on exit, ebx=1: otherwise
+ * Save all registers in pt_regs. Return GSBASE related information
+ * in EBX depending on the availability of the FSGSBASE instructions:
+ *
+ * FSGSBASE	R/EBX
+ *     N        0 -> SWAPGS on exit
+ *              1 -> no SWAPGS on exit
+ *
+ *     Y        GSBASE value at entry, must be restored in paranoid_exit
  */
 ENTRY(paranoid_entry)
 	UNWIND_HINT_FUNC
@@ -1174,7 +1179,6 @@ ENTRY(paranoid_entry)
 	PUSH_AND_CLEAR_REGS save_ret=1
 	ENCODE_FRAME_POINTER 8
 
-1:
 	/*
 	 * Always stash CR3 in %r14.  This value will be restored,
 	 * verbatim, at exit.  Needed if paranoid_entry interrupted
@@ -1192,6 +1196,25 @@ ENTRY(paranoid_entry)
 	 */
 	SAVE_AND_SWITCH_TO_KERNEL_CR3 scratch_reg=%rax save_reg=%r14
 
+        /*
+	 * Handling GSBASE depends on the availability of FSGSBASE.
+	 *
+	 * Without FSGSBASE the kernel enforces that negative GSBASE
+	 * values indicate kernel GSBASE. With FSGSBASE no assumptions
+	 * can be made about the GSBASE value when entering from user
+	 * space.
+	*/
+	ALTERNATIVE "jmp .Lparanoid_entry_checkgs", "", X86_FEATURE_FSGSBASE
+
+	/*
+	 * Read the current GSBASE and store it in in %rbx unconditionally,
+	 * retrieve and set the current CPUs kernel GSBASE. The stored value
+	 * has to be restored in paranoid_exit unconditionally.
+	 */
+	SAVE_AND_SET_GSBASE scratch_reg=%rax save_reg=%rbx
+	ret
+
+.Lparanoid_entry_checkgs:
 	/* EBX = 1 -> kernel GSBASE active, no restore required */
 	movl	$1, %ebx
 	/*
@@ -1218,16 +1241,32 @@ END(paranoid_entry)
  *
  * We may be returning to very strange contexts (e.g. very early
  * in syscall entry), so checking for preemption here would
- * be complicated.  Fortunately, we there's no good reason
- * to try to handle preemption here.
+ * be complicated.  Fortunately, there's no good reason to try
+ * to handle preemption here.
  *
- * On entry, ebx is "no swapgs" flag (1: don't need swapgs, 0: need it)
+ * R/EBX contains the GSBASE related information depending on the
+ * availability of the FSGSBASE instructions:
+ *
+ * FSGSBASE	R/EBX
+ *     N        0 -> SWAPGS on exit
+ *              1 -> no SWAPGS on exit
+ *
+ *     Y        User space GSBASE, must be restored unconditionally
  */
 ENTRY(paranoid_exit)
 	UNWIND_HINT_REGS
 	DISABLE_INTERRUPTS(CLBR_ANY)
 	TRACE_IRQS_OFF_DEBUG
-	/* If EBX is 0, SWAPGS is required */
+
+	/* Handle GS depending on FSGSBASE availability */
+	ALTERNATIVE "jmp .Lparanoid_exit_checkgs", "nop",X86_FEATURE_FSGSBASE
+
+	/* With FSGSBASE enabled, unconditionally restore GSBASE */
+	wrgsbase	%rbx
+	jmp	.Lparanoid_exit_no_swapgs;
+
+.Lparanoid_exit_checkgs:
+	/* On non-FSGSBASE systems, conditionally do SWAPGS */
 	testl	%ebx, %ebx
 	jnz	.Lparanoid_exit_no_swapgs
 	TRACE_IRQS_IRETQ
@@ -1235,12 +1274,14 @@ ENTRY(paranoid_exit)
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
@@ -1651,10 +1692,27 @@ end_repeat_nmi:
 	/* Always restore stashed CR3 value (see paranoid_entry) */
 	RESTORE_CR3 scratch_reg=%r15 save_reg=%r14
 
-	testl	%ebx, %ebx			/* swapgs needed? */
+	/*
+	 * The above invocation of paranoid_entry stored the GSBASE
+	 * related information in R/EBX depending on the availability
+	 * of FSGSBASE.
+	 *
+	 * If FSGSBASE is enabled, restore the saved GSBASE value
+	 * unconditionally, otherwise take the conditional SWAPGS path.
+	 */
+	ALTERNATIVE "jmp nmi_no_fsgsbase", "", X86_FEATURE_FSGSBASE
+
+	wrgsbase	%rbx
+	jmp	nmi_restore
+
+nmi_no_fsgsbase:
+	/* EBX == 0 -> invoke SWAPGS */
+	testl	%ebx, %ebx
 	jnz	nmi_restore
+
 nmi_swapgs:
 	SWAPGS_UNSAFE_STACK
+
 nmi_restore:
 	POP_REGS
 
