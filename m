Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1E44C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 19:32:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C3552166E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 19:32:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="VAmESlyZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729285AbfEQTcg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 15:32:36 -0400
Received: from dc8-smtprelay2.synopsys.com ([198.182.47.102]:34308 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727478AbfEQTce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 15:32:34 -0400
Received: from mailhost.synopsys.com (badc-mailhost2.synopsys.com [10.192.0.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 811E4C00B9;
        Fri, 17 May 2019 19:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1558121559; bh=jcGpk2a5vkj1RkMrQMgetFu+xaKD/k6myHh9f6QeB78=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=VAmESlyZnrKT6tXepR99zRsPXZUN74uKCpdIA30Swz0WSgewQwYlcW6nJI8sZfDv6
         ZJHiNL+YsDHXvEepTi2KucANk/jnr9ySwkUYBKkumlMVRNilwUMxa7VpNvnJzk6NFc
         xJiteaNhn0bqV3H1zrSCOSO4RElAWIkMp487piVg9AvHyUEFIpHfLWXjUzbskzwqXR
         nSYVelNK/MwRCLZLsyk5aF5lc7ATWPVN+40Af/SBrA2HGFB5aTocIuOz45jnKUCGZn
         hhkQn8gwBqu5L3uNVF/3e0JnUOz0u5qHyjjznSfb0SLLLfpf9HFB66lz9kmwL7P70p
         ukW1BgFJ3rbfQ==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 9ABD9A0102;
        Fri, 17 May 2019 19:32:33 +0000 (UTC)
Received: from IN01WEHTCA.internal.synopsys.com (10.144.199.104) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 17 May 2019 12:32:32 -0700
Received: from IN01WEHTCB.internal.synopsys.com (10.144.199.105) by
 IN01WEHTCA.internal.synopsys.com (10.144.199.103) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Sat, 18 May 2019 01:02:42 +0530
Received: from vineetg-Latitude-E7450.internal.synopsys.com (10.10.161.89) by
 IN01WEHTCB.internal.synopsys.com (10.144.199.243) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Sat, 18 May 2019 01:02:29 +0530
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     <linux-snps-arc@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [PATCH 4/5] ARCv2: entry: rewrite to enable use of double load/stores LDD/STD
Date:   Fri, 17 May 2019 12:32:07 -0700
Message-ID: <1558121528-30184-5-git-send-email-vgupta@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1558121528-30184-1-git-send-email-vgupta@synopsys.com>
References: <1558121528-30184-1-git-send-email-vgupta@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.10.161.89]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 - the motivation was to be remove blatent copy-paste due to hasty support
   of CONFIG_ARC_IRQ_NO_AUTOSAVE support

 - but with refactoring we could use LDD/STD to greatly optimize the code

Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 arch/arc/include/asm/entry-arcv2.h | 297 +++++++++++++++++--------------------
 arch/arc/include/asm/linkage.h     |  18 +++
 arch/arc/kernel/asm-offsets.c      |   7 +
 arch/arc/kernel/entry-arcv2.S      |   4 +-
 4 files changed, 167 insertions(+), 159 deletions(-)

diff --git a/arch/arc/include/asm/entry-arcv2.h b/arch/arc/include/asm/entry-arcv2.h
index beaf655666cb..0733752ce7fe 100644
--- a/arch/arc/include/asm/entry-arcv2.h
+++ b/arch/arc/include/asm/entry-arcv2.h
@@ -46,7 +46,8 @@
  */
 
 /*------------------------------------------------------------------------*/
-.macro INTERRUPT_PROLOGUE	called_from
+.macro INTERRUPT_PROLOGUE
+
 	; (A) Before jumping to Interrupt Vector, hardware micro-ops did following:
 	;   1. SP auto-switched to kernel mode stack
 	;   2. STATUS32.Z flag set if in U mode at time of interrupt (U:1,K:0)
@@ -57,39 +58,87 @@
 	; (B) Manually saved some regs: r12,r25,r30, sp,fp,gp, ACCL pair
 
 #ifdef CONFIG_ARC_IRQ_NO_AUTOSAVE
-.ifnc \called_from, exception
-	st.as	r9, [sp, -10]	; save r9 in it's final stack slot
-	sub	sp, sp, 12	; skip JLI, LDI, EI
-
-	PUSH	lp_count
-	PUSHAX	lp_start
-	PUSHAX	lp_end
-	PUSH	blink
-
-	PUSH	r11
-	PUSH	r10
-
-	sub	sp, sp, 4	; skip r9
-
-	PUSH	r8
-	PUSH	r7
-	PUSH	r6
-	PUSH	r5
-	PUSH	r4
-	PUSH	r3
-	PUSH	r2
-	PUSH	r1
-	PUSH	r0
-.endif
-#endif
+	; carve pt_regs on stack (case #3), PC/STAT32 already on stack
+	sub	sp, sp, SZ_PT_REGS - 8
 
-#ifdef CONFIG_ARC_HAS_ACCL_REGS
-	PUSH	r59
-	PUSH	r58
+	__SAVE_REGFILE_HARD
+#else
+	; carve pt_regs on stack (case #4), which grew partially already
+	sub	sp, sp, PT_r0
 #endif
 
-	PUSH	r30
-	PUSH	r12
+	__SAVE_REGFILE_SOFT
+.endm
+
+/*------------------------------------------------------------------------*/
+.macro EXCEPTION_PROLOGUE
+
+	; (A) Before jumping to Exception Vector, hardware micro-ops did following:
+	;   1. SP auto-switched to kernel mode stack
+	;   2. STATUS32.Z flag set if in U mode at time of exception (U:1,K:0)
+	;
+	; (B) Manually save the complete reg file below
+
+	sub	sp, sp, SZ_PT_REGS	; carve pt_regs
+
+	; _HARD saves r10 clobbered by _SOFT as scratch hence comes first
+
+	__SAVE_REGFILE_HARD
+	__SAVE_REGFILE_SOFT
+
+	st	r0, [sp]	; orig_r0
+
+	lr	r10, [eret]
+	lr	r11, [erstatus]
+	ST2	r10, r11, PT_ret
+
+	lr	r10, [ecr]
+	lr	r11, [erbta]
+	ST2	r10, r11, PT_event
+	mov	r9, r10
+
+	; OUTPUT: r9 has ECR
+.endm
+
+/*------------------------------------------------------------------------
+ * This macro saves the registers manually which would normally be autosaved
+ * by hardware on taken interrupts. It is used by
+ *   - exception handlers (which don't have autosave)
+ *   - interrupt autosave disabled due to CONFIG_ARC_IRQ_NO_AUTOSAVE
+ */
+.macro __SAVE_REGFILE_HARD
+
+	ST2	r0,  r1,  PT_r0
+	ST2	r2,  r3,  PT_r2
+	ST2	r4,  r5,  PT_r4
+	ST2	r6,  r7,  PT_r6
+	ST2	r8,  r9,  PT_r8
+	ST2	r10, r11, PT_r10
+
+	st	blink, [sp, PT_blink]
+
+	lr	r10, [lp_end]
+	lr	r11, [lp_start]
+	ST2	r10, r11, PT_lpe
+
+	st	lp_count, [sp, PT_lpc]
+
+	; skip JLI, LDI, EI for now
+.endm
+
+/*------------------------------------------------------------------------
+ * This macros saves a bunch of other registers which can't be autosaved for
+ * various reasons:
+ *   - r12: the last caller saved scratch reg since hardware saves in pairs so r0-r11
+ *   - r30: free reg, used by gcc as scratch
+ *   - ACCL/ACCH pair when they exist
+ */
+.macro __SAVE_REGFILE_SOFT
+
+	ST2	gp, fp, PT_r26		; gp (r26), fp (r27)
+
+	st	r12, [sp, PT_sp + 4]
+	st	r30, [sp, PT_sp + 8]
 
 	; Saving pt_regs->sp correctly requires some extra work due to the way
 	; Auto stack switch works
@@ -100,46 +149,32 @@
 	; 2. Upon entry SP is always saved (for any inspection, unwinding etc),
 	;    but on return, restored only if U mode
 
-	lr	r9, [AUX_USER_SP]			; U mode SP
+	lr	r10, [AUX_USER_SP]	; U mode SP
 
-	mov.nz	r9, sp
-	add.nz	r9, r9, SZ_PT_REGS - PT_sp - 4		; K mode SP
+	; ISA requires ADD.nz to have same dest and src reg operands
+	mov.nz	r10, sp
+	add.nz	r10, r10, SZ_PT_REGS	; K mode SP
 
-	PUSH	r9					; SP (pt_regs->sp)
-
-	PUSH	fp
-	PUSH	gp
+	st	r10, [sp, PT_sp]	; SP (pt_regs->sp)
 
 #ifdef CONFIG_ARC_CURR_IN_REG
-	PUSH	r25			; user_r25
+	st	r25, [sp, PT_user_r25]
 	GET_CURR_TASK_ON_CPU	r25
-#else
-	sub	sp, sp, 4
 #endif
 
-.ifnc \called_from, exception
-	sub	sp, sp, 12	; BTA/ECR/orig_r0 placeholder per pt_regs
-.endif
+#ifdef CONFIG_ARC_HAS_ACCL_REGS
+	ST2	r58, r59, PT_sp + 12
+#endif
 
 .endm
 
 /*------------------------------------------------------------------------*/
-.macro INTERRUPT_EPILOGUE	called_from
+.macro __RESTORE_REGFILE_SOFT
 
-	; INPUT: r0 has STAT32 of calling context
-	; INPUT: Z flag set if returning to K mode
-.ifnc \called_from, exception
-	add	sp, sp, 12	; skip BTA/ECR/orig_r0 placeholderss
-.endif
-
-#ifdef CONFIG_ARC_CURR_IN_REG
-	POP	r25
-#else
-	add	sp, sp, 4
-#endif
+	LD2	gp, fp, PT_r26		; gp (r26), fp (r27)
 
-	POP	gp
-	POP	fp
+	ld	r12, [sp, PT_sp + 4]
+	ld	r30, [sp, PT_sp + 8]
 
 	; Restore SP (into AUX_USER_SP) only if returning to U mode
 	;  - for K mode, it will be implicitly restored as stack is unwound
@@ -147,129 +182,77 @@
 	;    but that doesn't really matter
 	bz	1f
 
-	POPAX	AUX_USER_SP
+	ld	r10, [sp, PT_sp]	; SP (pt_regs->sp)
+	sr	r10, [AUX_USER_SP]
 1:
-	POP	r12
-	POP	r30
 
-#ifdef CONFIG_ARC_HAS_ACCL_REGS
-	POP	r58
-	POP	r59
+#ifdef CONFIG_ARC_CURR_IN_REG
+	ld	r25, [sp, PT_user_r25]
 #endif
 
-#ifdef CONFIG_ARC_IRQ_NO_AUTOSAVE
-.ifnc \called_from, exception
-	POP	r0
-	POP	r1
-	POP	r2
-	POP	r3
-	POP	r4
-	POP	r5
-	POP	r6
-	POP	r7
-	POP	r8
-	POP	r9
-	POP	r10
-	POP	r11
-
-	POP	blink
-	POPAX	lp_end
-	POPAX	lp_start
-
-	POP	r9
-	mov	lp_count, r9
-
-	add	sp, sp, 12	; skip JLI, LDI, EI
-	ld.as	r9, [sp, -10]	; reload r9 which got clobbered
-.endif
+#ifdef CONFIG_ARC_HAS_ACCL_REGS
+	LD2	r58, r59, PT_sp + 12
 #endif
-
 .endm
 
 /*------------------------------------------------------------------------*/
-.macro EXCEPTION_PROLOGUE
+.macro __RESTORE_REGFILE_HARD
 
-	; (A) Before jumping to Exception Vector, hardware micro-ops did following:
-	;   1. SP auto-switched to kernel mode stack
-	;   2. STATUS32.Z flag set if in U mode at time of exception (U:1,K:0)
-	;
-	; (B) Manually save the complete reg file below
+	ld	blink, [sp, PT_blink]
 
-	PUSH	r9		; freeup a register: slot of erstatus
+	LD2	r10, r11, PT_lpe
+	sr	r10, [lp_end]
+	sr	r11, [lp_start]
 
-	PUSHAX	eret
-	sub	sp, sp, 12	; skip JLI, LDI, EI
-	PUSH	lp_count
-	PUSHAX	lp_start
-	PUSHAX	lp_end
-	PUSH	blink
+	ld	r10, [sp, PT_lpc]	; lp_count can't be target of LD
+	mov	lp_count, r10
 
-	PUSH	r11
-	PUSH	r10
+	LD2	r0,  r1,  PT_r0
+	LD2	r2,  r3,  PT_r2
+	LD2	r4,  r5,  PT_r4
+	LD2	r6,  r7,  PT_r6
+	LD2	r8,  r9,  PT_r8
+	LD2	r10, r11, PT_r10
+.endm
 
-	ld.as	r9,  [sp, 10]	; load stashed r9 (status32 stack slot)
-	lr	r10, [erstatus]
-	st.as	r10, [sp, 10]	; save status32 at it's right stack slot
 
-	PUSH	r9
-	PUSH	r8
-	PUSH	r7
-	PUSH	r6
-	PUSH	r5
-	PUSH	r4
-	PUSH	r3
-	PUSH	r2
-	PUSH	r1
-	PUSH	r0
+/*------------------------------------------------------------------------*/
+.macro INTERRUPT_EPILOGUE
 
-	; -- for interrupts, regs above are auto-saved by h/w in that order --
-	; Now do what ISR prologue does (manually save r12, sp, fp, gp, r25)
+	; INPUT: r0 has STAT32 of calling context
+	; INPUT: Z flag set if returning to K mode
 
-	INTERRUPT_PROLOGUE  exception
+	; _SOFT clobbers r10 restored by _HARD hence the order
 
-	PUSHAX	erbta
-	PUSHAX	ecr		; r9 contains ECR, expected by EV_Trap
+	__RESTORE_REGFILE_SOFT
+
+#ifdef CONFIG_ARC_IRQ_NO_AUTOSAVE
+	__RESTORE_REGFILE_HARD
+	add	sp, sp, SZ_PT_REGS - 8
+#else
+	add	sp, sp, PT_r0
+#endif
 
-	PUSH	r0		; orig_r0
-	; OUTPUT: r9 has ECR
 .endm
 
 /*------------------------------------------------------------------------*/
 .macro EXCEPTION_EPILOGUE
 
 	; INPUT: r0 has STAT32 of calling context
-	btst   r0, STATUS_U_BIT	; Z flag set if K, used in INTERRUPT_EPILOGUE
-
-	add	sp, sp, 8	; orig_r0/ECR don't need restoring
-	POPAX	erbta
-
-	INTERRUPT_EPILOGUE  exception
-
-	POP	r0
-	POP	r1
-	POP	r2
-	POP	r3
-	POP	r4
-	POP	r5
-	POP	r6
-	POP	r7
-	POP	r8
-	POP	r9
-	POP	r10
-	POP	r11
-
-	POP	blink
-	POPAX	lp_end
-	POPAX	lp_start
-
-	POP	r9
-	mov	lp_count, r9
-
-	add	sp, sp, 12	; skip JLI, LDI, EI
-	POPAX	eret
-	POPAX	erstatus
-
-	ld.as	r9, [sp, -12]	; reload r9 which got clobbered
+
+	btst	r0, STATUS_U_BIT	; Z flag set if K, used in restoring SP
+
+	ld	r10, [sp, PT_event + 4]
+	sr	r10, [erbta]
+
+	LD2	r10, r11, PT_ret
+	sr	r10, [eret]
+	sr	r11, [erstatus]
+
+	__RESTORE_REGFILE_SOFT
+	__RESTORE_REGFILE_HARD
+
+	add	sp, sp, SZ_PT_REGS
 .endm
 
 .macro FAKE_RET_FROM_EXCPN
diff --git a/arch/arc/include/asm/linkage.h b/arch/arc/include/asm/linkage.h
index b29f1a9fd6f7..7d90163f716f 100644
--- a/arch/arc/include/asm/linkage.h
+++ b/arch/arc/include/asm/linkage.h
@@ -13,6 +13,24 @@
 
 #ifdef __ASSEMBLY__
 
+.macro ST2 e, o, off
+#ifdef CONFIG_ARC_HAS_LL64
+	std	\e, [sp, \off]
+#else
+	st	\e, [sp, \off]
+	st	\o, [sp, \off+4]
+#endif
+.endm
+
+.macro LD2 e, o, off
+#ifdef CONFIG_ARC_HAS_LL64
+	ldd	\e, [sp, \off]
+#else
+	ld	\e, [sp, \off]
+	ld	\o, [sp, \off+4]
+#endif
+.endm
+
 #define ASM_NL		 `	/* use '`' to mark new line in macro */
 
 /* annotation for data we want in DCCM - if enabled in .config */
diff --git a/arch/arc/kernel/asm-offsets.c b/arch/arc/kernel/asm-offsets.c
index ecaf34e9235c..e90dccecfd83 100644
--- a/arch/arc/kernel/asm-offsets.c
+++ b/arch/arc/kernel/asm-offsets.c
@@ -58,7 +58,14 @@ int main(void)
 	DEFINE(PT_r5, offsetof(struct pt_regs, r5));
 	DEFINE(PT_r6, offsetof(struct pt_regs, r6));
 	DEFINE(PT_r7, offsetof(struct pt_regs, r7));
+	DEFINE(PT_r8, offsetof(struct pt_regs, r8));
+	DEFINE(PT_r10, offsetof(struct pt_regs, r10));
+	DEFINE(PT_r26, offsetof(struct pt_regs, r26));
 	DEFINE(PT_ret, offsetof(struct pt_regs, ret));
+	DEFINE(PT_blink, offsetof(struct pt_regs, blink));
+	DEFINE(PT_lpe, offsetof(struct pt_regs, lp_end));
+	DEFINE(PT_lpc, offsetof(struct pt_regs, lp_count));
+	DEFINE(PT_user_r25, offsetof(struct pt_regs, user_r25));
 
 	DEFINE(SZ_CALLEE_REGS, sizeof(struct callee_regs));
 	DEFINE(SZ_PT_REGS, sizeof(struct pt_regs));
diff --git a/arch/arc/kernel/entry-arcv2.S b/arch/arc/kernel/entry-arcv2.S
index 562089d62d9d..6cbf0ee8a20a 100644
--- a/arch/arc/kernel/entry-arcv2.S
+++ b/arch/arc/kernel/entry-arcv2.S
@@ -70,7 +70,7 @@ reserved:
 
 ENTRY(handle_interrupt)
 
-	INTERRUPT_PROLOGUE  irq
+	INTERRUPT_PROLOGUE
 
 	# irq control APIs local_irq_save/restore/disable/enable fiddle with
 	# global interrupt enable bits in STATUS32 (.IE for 1 prio, .E[] for 2 prio)
@@ -226,7 +226,7 @@ debug_marker_l1:
 	bset.nz	r11, r11, AUX_IRQ_ACT_BIT_U	; NZ means U
 	sr	r11, [AUX_IRQ_ACT]
 
-	INTERRUPT_EPILOGUE  irq
+	INTERRUPT_EPILOGUE
 	rtie
 
 ;####### Return from Exception / pure kernel mode #######
-- 
2.7.4

