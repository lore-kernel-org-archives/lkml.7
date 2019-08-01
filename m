Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8644AC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 23:11:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 495D8206B8
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 23:11:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mNeODb68"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731719AbfHAXK7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 19:10:59 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:43962 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbfHAXK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 19:10:58 -0400
Received: by mail-qk1-f202.google.com with SMTP id v4so62702459qkj.10
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 16:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=ffo0BEX4jn42Yj5bUFNrkZDBWd6yUTSShv6ZHrslX3E=;
        b=mNeODb68KyfrlgjqNv33Xg/FSlCCmow4/hK2vhdiK+OD+CTeUXLyspZ5BtEPOvKIc6
         /dJSoM9T6cBhwiYd+NMaegQx90ASLf/iCJxcuu8GRVFkfTTxd6bmcTkFV18N/j181Kgy
         EIUcgyhm4T007BOE4bTLbGwWSguEX2ltfDJs5JMmCbofOQn7nIPl7ORwp/RWD+YbSxwB
         Q5I5yrCP0UTGwD7bvVL9jTiza3kAmRgxusu6MnaRMvQgdLyAQpQRD+F9OcOE6i5bnYZE
         4IRiFAysIAsmi95HXRBmf7/o/w3m0dV8sczmAK36Y8Y/ea0VecIsgdzxRVtTO1ShX5R9
         X16g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=ffo0BEX4jn42Yj5bUFNrkZDBWd6yUTSShv6ZHrslX3E=;
        b=rajyen8kixssPftGQz4EmLkAOSJ0Nm9V7ZN4nKfJZ23b0hJu+T32+VTsoDVAVezPg6
         k7v8V9CLWsaiiV7KN59145g7caLIXTm2WoIdzeH2ygZAjUo62KzOz7KyMT3wcGvrx690
         rEA9CNWOCd4g1R7+MFmP0TgbfCstJLMabcsqMFwbE+ByDO/103SB2QwABGf5I4fhCMsx
         CIgArwGlrhfaKwBWlqdHs41aeSXX4rJjW//hOLC9cS/G41GUL9B1BANiGmzNY0vKKxhm
         5o3Q+ZReCUjAZSr6tOCoRfiySaY5OW0rEPBadr7nOVhb439E5YnPIFfF8lJu/0+lXtzE
         LuHw==
X-Gm-Message-State: APjAAAWyqQ4mWsFtmOsTRo7tIetxWp4NeFzIhpQrKybPCARyOKkvC/00
        N2+8qBCorBTWJDAyJYlz23DV0qbWPg==
X-Google-Smtp-Source: APXvYqx3/2L7Ue39VqTWAOtf5PC9qB/K8/QDnKZdPk8vOdoQ7Y9a9as1I3budbZKzaojusFLgDXZORBsaA==
X-Received: by 2002:ac8:524a:: with SMTP id y10mr94383841qtn.100.1564701057204;
 Thu, 01 Aug 2019 16:10:57 -0700 (PDT)
Date:   Thu,  1 Aug 2019 16:10:46 -0700
Message-Id: <20190801231046.105022-1-nhuck@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
Subject: [RFC PATCH] ARM: UNWINDER_FRAME_POINTER implementation for Clang
From:   Nathan Huckleberry <nhuck@google.com>
To:     linux@armlinux.org.uk
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nathan Huckleberry <nhuck@google.com>,
        clang-built-linux@googlegroups.com, Tri Vo <trong@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The stackframe setup when compiled with clang is different.
Since the stack unwinder expects the gcc stackframe setup it
fails to print backtraces. This patch adds support for the
clang stackframe setup.

Cc: clang-built-linux@googlegroups.com
Suggested-by: Tri Vo <trong@google.com>
Signed-off-by: Nathan Huckleberry <nhuck@google.com>
---
 arch/arm/Kconfig.debug   |   4 +-
 arch/arm/Makefile        |   2 +-
 arch/arm/lib/backtrace.S | 134 ++++++++++++++++++++++++++++++++++++---
 3 files changed, 128 insertions(+), 12 deletions(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 85710e078afb..92fca7463e21 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -56,7 +56,7 @@ choice
 
 config UNWINDER_FRAME_POINTER
 	bool "Frame pointer unwinder"
-	depends on !THUMB2_KERNEL && !CC_IS_CLANG
+	depends on !THUMB2_KERNEL
 	select ARCH_WANT_FRAME_POINTERS
 	select FRAME_POINTER
 	help
@@ -1872,7 +1872,7 @@ config DEBUG_UNCOMPRESS
 	  When this option is set, the selected DEBUG_LL output method
 	  will be re-used for normal decompressor output on multiplatform
 	  kernels.
-	  
+
 
 config UNCOMPRESS_INCLUDE
 	string
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index c3624ca6c0bc..a593d9c4e18a 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -36,7 +36,7 @@ KBUILD_CFLAGS	+= $(call cc-option,-mno-unaligned-access)
 endif
 
 ifeq ($(CONFIG_FRAME_POINTER),y)
-KBUILD_CFLAGS	+=-fno-omit-frame-pointer -mapcs -mno-sched-prolog
+KBUILD_CFLAGS	+=-fno-omit-frame-pointer $(call cc-option,-mapcs,) $(call cc-option,-mno-sched-prolog,)
 endif
 
 ifeq ($(CONFIG_CPU_BIG_ENDIAN),y)
diff --git a/arch/arm/lib/backtrace.S b/arch/arm/lib/backtrace.S
index 1d5210eb4776..fd64eec9f6ae 100644
--- a/arch/arm/lib/backtrace.S
+++ b/arch/arm/lib/backtrace.S
@@ -14,10 +14,7 @@
 @ fp is 0 or stack frame
 
 #define frame	r4
-#define sv_fp	r5
-#define sv_pc	r6
 #define mask	r7
-#define offset	r8
 
 ENTRY(c_backtrace)
 
@@ -25,7 +22,8 @@ ENTRY(c_backtrace)
 		ret	lr
 ENDPROC(c_backtrace)
 #else
-		stmfd	sp!, {r4 - r8, lr}	@ Save an extra register so we have a location...
+		stmfd   sp!, {r4 - r8, fp, lr}	@ Save an extra register
+						@ so we have a location..
 		movs	frame, r0		@ if frame pointer is zero
 		beq	no_frame		@ we have no stack frames
 
@@ -35,11 +33,119 @@ ENDPROC(c_backtrace)
  THUMB(		orreq	mask, #0x03		)
 		movne	mask, #0		@ mask for 32-bit
 
-1:		stmfd	sp!, {pc}		@ calculate offset of PC stored
-		ldr	r0, [sp], #4		@ by stmfd for this CPU
-		adr	r1, 1b
-		sub	offset, r0, r1
 
+#if defined(CONFIG_CC_IS_CLANG)
+/*
+ * Clang does not store pc or sp in function prologues
+ * 		so we don't know exactly where the function
+ * 		starts.
+ * We can treat the current frame's lr as the saved pc and the
+ * 		preceding frame's lr as the lr, but we can't
+ * 		trace the most recent call.
+ * Inserting a false stack frame allows us to reference the
+ * 		function called last in the stacktrace.
+ * If the call instruction was a bl we can look at the callers
+ * 		branch instruction to calculate the saved pc.
+ * We can recover the pc in most cases, but in cases such as
+ * 		calling function pointers we cannot. In this
+ * 		case, default to using the lr. This will be
+ * 		some address in the function, but will not
+ * 		be the function start.
+ * Unfortunately due to the stack frame layout we can't dump
+ *              r0 - r3, but these are less frequently saved.
+ *
+ * Stack frame layout:
+ *             <larger addresses>
+ *             saved lr
+ *    frame => saved fp
+ *             optionally saved caller registers (r4 - r10)
+ *             optionally saved arguments (r0 - r3)
+ *             <top of stack frame>
+ *             <smaller addressses>
+ *
+ * Functions start with the following code sequence:
+ * corrected pc =>  stmfd sp!, {..., fp, lr}
+ *		    add fp, sp, #x
+ *		    stmfd sp!, {r0 - r3} (optional)
+ */
+#define sv_fp	r5
+#define sv_pc	r6
+#define sv_lr   r8
+		add     frame, sp, #20          @ switch to false frame
+for_each_frame:	tst	frame, mask		@ Check for address exceptions
+		bne	no_frame
+
+1001:		ldr	sv_pc, [frame, #4]	@ get saved 'pc'
+1002:		ldr	sv_fp, [frame, #0]	@ get saved fp
+
+		teq     sv_fp, #0               @ make sure next frame exists
+		beq     no_frame
+
+1003:		ldr     sv_lr, [sv_fp, #4]      @ get saved lr from next frame
+
+		//try to find function start
+		ldr     r0, [sv_lr, #-4]        @ get call instruction
+		ldr     r3, .Ldsi+8
+		and     r2, r3, r0              @ is this a bl call
+		teq     r2, r3
+		bne     finished_setup          @ give up if it's not
+		and     r0, #0xffffff           @ get call offset 24-bit int
+		lsl     r0, r0, #8              @ sign extend offset
+		asr     r0, r0, #8
+		ldr     sv_pc, [sv_fp, #4]      @ get lr address
+		add     sv_pc, sv_pc, #-4	@ get call instruction address
+		add     sv_pc, sv_pc, #8        @ take care of prefetch
+		add     sv_pc, sv_pc, r0, lsl #2 @ find function start
+		b       finished_setup
+
+finished_setup:
+
+		bic	sv_pc, sv_pc, mask	@ mask PC/LR for the mode
+
+1004:		mov     r0, sv_pc
+
+		mov     r1, sv_lr
+		mov	r2, frame
+		bic	r1, r1, mask		@ mask PC/LR for the mode
+		bl	dump_backtrace_entry
+
+1005:		ldr	r1, [sv_pc, #0]		@ if stmfd sp!, {..., fp, lr}
+		ldr	r3, .Ldsi		@ instruction exists,
+		teq	r3, r1, lsr #11
+		ldr     r0, [frame]             @ locals are stored in
+						@ the preceding frame
+		subeq	r0, r0, #4
+		bleq	dump_backtrace_stm	@ dump saved registers
+
+		teq	sv_fp, #0		@ zero saved fp means
+		beq	no_frame		@ no further frames
+
+		cmp	sv_fp, frame		@ next frame must be
+		mov	frame, sv_fp		@ above the current frame
+		bhi	for_each_frame
+
+1006:		adr	r0, .Lbad
+		mov	r1, frame
+		bl	printk
+no_frame:	ldmfd	sp!, {r4 - r8, fp, pc}
+ENDPROC(c_backtrace)
+		.pushsection __ex_table,"a"
+		.align	3
+		.long	1001b, 1006b
+		.long	1002b, 1006b
+		.long	1003b, 1006b
+		.long	1004b, 1006b
+		.popsection
+
+.Lbad:		.asciz	"Backtrace aborted due to bad frame pointer <%p>\n"
+		.align
+.Ldsi:		.word	0xe92d4800 >> 11	@ stmfd sp!, {... fp, lr}
+		.word	0xe92d0000 >> 11	@ stmfd sp!, {}
+		.word   0x0b000000              @ bl if these bits are set
+
+ENDPROC(c_backtrace)
+
+#else
 /*
  * Stack frame layout:
  *             optionally saved caller registers (r4 - r10)
@@ -55,6 +161,15 @@ ENDPROC(c_backtrace)
  *                  stmfd sp!, {r0 - r3} (optional)
  * corrected pc =>  stmfd sp!, {..., fp, ip, lr, pc}
  */
+#define sv_fp	r5
+#define sv_pc	r6
+#define offset	r8
+
+1:		stmfd	sp!, {pc}		@ calculate offset of PC stored
+		ldr	r0, [sp], #4		@ by stmfd for this CPU
+		adr	r1, 1b
+		sub	offset, r0, r1
+
 for_each_frame:	tst	frame, mask		@ Check for address exceptions
 		bne	no_frame
 
@@ -98,7 +213,7 @@ for_each_frame:	tst	frame, mask		@ Check for address exceptions
 1006:		adr	r0, .Lbad
 		mov	r1, frame
 		bl	printk
-no_frame:	ldmfd	sp!, {r4 - r8, pc}
+no_frame:	ldmfd	sp!, {r4 - r8, fp, pc}
 ENDPROC(c_backtrace)
 		
 		.pushsection __ex_table,"a"
@@ -115,3 +230,4 @@ ENDPROC(c_backtrace)
 		.word	0xe92d0000 >> 11	@ stmfd sp!, {}
 
 #endif
+#endif
-- 
2.22.0.770.g0f2c4a37fd-goog

