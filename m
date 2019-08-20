Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20EE5C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 19:44:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D18CE214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 19:44:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ERMFp3EH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730708AbfHTToV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 15:44:21 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:49533 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729231AbfHTToV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 15:44:21 -0400
Received: by mail-pf1-f202.google.com with SMTP id s10so5514476pfd.16
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 12:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=omNibtwt01VLQFVdtqmNwtyJ+PQcOYPH4P7JrKJGBHQ=;
        b=ERMFp3EHZIgg8ffBSgtfdYniINiXh7pwT1vdhtM5z7zLIx7UYk3vyExbxxsMn2hRC3
         iHstfj+h4z8fSbPZ0bxTgAUOo9LGPCIHfOTWVLOHjod5zVLFN8kzwdfk6h5tvNIgw+7m
         VYX7tMNsNYKKCHVm9eb6pPq2I5wW4FPFAujwlkOQeBg+nS+ntCAA3hsMjv7caatVh4Rb
         UCBwnBeWxCzSbF1USpLvA1wt+pqlxd0Pm+ZKWOuRH06WZQGCOrRq6ju8s3vmrdlisESl
         RNVuMHAlbPWcgCARRscEGcUoZGWUZwIvtAX9vRJYTwsYzUR5otE43q/P1k/O+Sh/wnCd
         tjrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=omNibtwt01VLQFVdtqmNwtyJ+PQcOYPH4P7JrKJGBHQ=;
        b=tugb87n0/wCLFdLiHdOpy8ra1G5D3LG3zuaEIB7mLx9saavXY5p6ukVvlHZ+odQRfk
         8M+GB2aSjYIec9AnPD0CSgQ5B/eW702w4OK67vnzDGMDclaoY1EcrZ4jsu42tMRG2lCb
         Ue9loyi/620bwHKF+eprMXbiP00eycF2NyHgauWErshNVZyCmeiwbHlgPvHMCEhcIVif
         5rwMSLNvgKdQyct9lyAEyn4is5mLulq8HeG4Af0Q0LgYAh+KA3b4HDKWiXd9LXyOo8Rg
         JCAqu1iO9PwpGMidRqbcB8k476R7iFGjZbc3nd73Bt9uCmbRG74Kw/94Rr6Q349pru1A
         TJNQ==
X-Gm-Message-State: APjAAAUBoVUheohKx/vuvrpL4NiWG0j39T+x1wi8iB9qlaPTXYmGJ/zP
        7YZUZGHnSeIPna4iI6V4S+x2BGcx5A==
X-Google-Smtp-Source: APXvYqx3nsorEv8UAKQAMrJL3TVWts1+mHrM8FXsRScTtZ22lsdqR4twHG1BmstfcFHp8NNrzNPcxpyfaA==
X-Received: by 2002:a65:6093:: with SMTP id t19mr19510560pgu.79.1566330259888;
 Tue, 20 Aug 2019 12:44:19 -0700 (PDT)
Date:   Tue, 20 Aug 2019 12:43:51 -0700
Message-Id: <20190820194351.107486-1-nhuck@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH] ARM: UNWINDER_FRAME_POINTER implementation for Clang
From:   Nathan Huckleberry <nhuck@google.com>
To:     linux@armlinux.org.uk
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com, miles.chen@mediatek.com,
        ndesaulniers@google.com, Nathan Huckleberry <nhuck@google.com>,
        Tri Vo <trong@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The stackframe setup when compiled with clang is different.
Since the stack unwinder expects the gcc stackframe setup it
fails to print backtraces. This patch adds support for the
clang stackframe setup.

Link: https://github.com/ClangBuiltLinux/linux/issues/35
Cc: clang-built-linux@googlegroups.com
Suggested-by: Tri Vo <trong@google.com>
Signed-off-by: Nathan Huckleberry <nhuck@google.com>
---
Changes from RFC
* Push extra register to satisfy 8 byte alignment requirement
* Add clarifying comments
* Separate code into its own file

 arch/arm/Kconfig.debug         |   4 +-
 arch/arm/Makefile              |   5 +-
 arch/arm/lib/Makefile          |   8 +-
 arch/arm/lib/backtrace-clang.S | 224 +++++++++++++++++++++++++++++++++
 4 files changed, 237 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm/lib/backtrace-clang.S

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
index c3624ca6c0bc..729e223b83fe 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -36,7 +36,10 @@ KBUILD_CFLAGS	+= $(call cc-option,-mno-unaligned-access)
 endif
 
 ifeq ($(CONFIG_FRAME_POINTER),y)
-KBUILD_CFLAGS	+=-fno-omit-frame-pointer -mapcs -mno-sched-prolog
+KBUILD_CFLAGS	+=-fno-omit-frame-pointer
+  ifeq ($(CONFIG_CC_IS_GCC),y)
+  KBUILD_CFLAGS += -mapcs -mno-sched-prolog
+  endif
 endif
 
 ifeq ($(CONFIG_CPU_BIG_ENDIAN),y)
diff --git a/arch/arm/lib/Makefile b/arch/arm/lib/Makefile
index b25c54585048..e10a769c72ec 100644
--- a/arch/arm/lib/Makefile
+++ b/arch/arm/lib/Makefile
@@ -5,7 +5,7 @@
 # Copyright (C) 1995-2000 Russell King
 #
 
-lib-y		:= backtrace.o changebit.o csumipv6.o csumpartial.o   \
+lib-y		:= changebit.o csumipv6.o csumpartial.o               \
 		   csumpartialcopy.o csumpartialcopyuser.o clearbit.o \
 		   delay.o delay-loop.o findbit.o memchr.o memcpy.o   \
 		   memmove.o memset.o setbit.o                        \
@@ -19,6 +19,12 @@ lib-y		:= backtrace.o changebit.o csumipv6.o csumpartial.o   \
 mmu-y		:= clear_user.o copy_page.o getuser.o putuser.o       \
 		   copy_from_user.o copy_to_user.o
 
+ifdef CONFIG_CC_IS_CLANG
+  lib-y += backtrace-clang.o
+else
+  lib-y += backtrace.o
+endif
+
 # using lib_ here won't override already available weak symbols
 obj-$(CONFIG_UACCESS_WITH_MEMCPY) += uaccess_with_memcpy.o
 
diff --git a/arch/arm/lib/backtrace-clang.S b/arch/arm/lib/backtrace-clang.S
new file mode 100644
index 000000000000..2b02014dbdd1
--- /dev/null
+++ b/arch/arm/lib/backtrace-clang.S
@@ -0,0 +1,224 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ *  linux/arch/arm/lib/backtrace-clang.S
+ *
+ *  Copyright (C) 2019 Nathan Huckleberry
+ *
+ */
+#include <linux/kern_levels.h>
+#include <linux/linkage.h>
+#include <asm/assembler.h>
+		.text
+
+/* fp is 0 or stack frame */
+
+#define frame	r4
+#define sv_fp	r5
+#define sv_pc	r6
+#define mask	r7
+#define sv_lr   r8
+
+ENTRY(c_backtrace)
+
+#if !defined(CONFIG_FRAME_POINTER) || !defined(CONFIG_PRINTK)
+		ret	lr
+ENDPROC(c_backtrace)
+#else
+
+
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
+ *             <smaller addresses>
+ *
+ * Functions start with the following code sequence:
+ * corrected pc =>  stmfd sp!, {..., fp, lr}
+ *		    add fp, sp, #x
+ *		    stmfd sp!, {r0 - r3} (optional)
+ *
+ *
+ *
+ *
+ *
+ *
+ * The diagram below shows an example stack setup
+ * 	for dump_stack.
+ *
+ * The frame for c_backtrace has pointers to the
+ * 	code of dump_stack. This is why the frame of
+ * 	c_backtrace is used to for the pc calculation
+ * 	of dump_stack. This is why we must move back
+ * 	a frame to print dump_stack.
+ *
+ * The stored locals for dump_stack are in dump_stack's
+ * 	frame. This means that to fully print dump_stack's frame
+ * 	we need the both the frame for dump_stack (for locals) and the
+ * 	frame that was called by dump_stack (for pc).
+ *
+ * To print locals we must know where the function start is. If
+ * 	we read the function prologue opcodes we can determine
+ * 	which variables are stored in the stack frame.
+ *
+ * To find the function start of dump_stack we can look at the
+ * 	stored LR of show_stack. It points at the instruction
+ * 	directly after the bl dump_stack. We can then read the
+ * 	offset from the bl opcode to determine where the branch takes us.
+ * 	The address calculated must be the start of dump_stack.
+ *
+ * c_backtrace frame           dump_stack:
+ * {[LR]    }  ============|   ...
+ * {[FP]    }  =======|    |   bl c_backtrace
+ *                    |    |=> ...
+ * {[R4-R10]}         |
+ * {[R0-R3] }         |        show_stack:
+ * dump_stack frame   |        ...
+ * {[LR]    } =============|   bl dump_stack
+ * {[FP]    } <=======|    |=> ...
+ * {[R4-R10]}
+ * {[R0-R3] }
+ */
+
+stmfd   sp!, {r4 - r9, fp, lr}	@ Save an extra register
+				@ to ensure 8 byte alignment
+movs	frame, r0		@ if frame pointer is zero
+beq	no_frame		@ we have no stack frames
+
+tst	r1, #0x10		@ 26 or 32-bit mode?
+moveq	mask, #0xfc000003
+movne	mask, #0		@ mask for 32-bit
+
+/*
+ * Switches the current frame to be the frame for dump_stack.
+ */
+		add     frame, sp, #24          @ switch to false frame
+for_each_frame:	tst	frame, mask		@ Check for address exceptions
+		bne	no_frame
+
+/*
+ * sv_fp is the stack frame with the locals for the current considered
+ * 	function.
+ * sv_pc is the saved lr frame the frame above. This is a pointer to a
+ * 	code address within the current considered function, but
+ * 	it is not the function start. This value gets updated to be
+ * 	the function start later if it is possible.
+ */
+1001:		ldr	sv_pc, [frame, #4]	@ get saved 'pc'
+1002:		ldr	sv_fp, [frame, #0]	@ get saved fp
+
+		teq     sv_fp, #0               @ make sure next frame exists
+		beq     no_frame
+
+/*
+ * sv_lr is the lr from the function that called the current function. This
+ * 	is a pointer to a code address in the current function's caller.
+ * 	sv_lr-4 is the instruction used to call the current function.
+ * This sv_lr can be used to calculate the function start if the function
+ * 	was called using a bl instruction. If the function start
+ * 	can be recovered sv_pc is overwritten with the function start.
+ * If the current function was called using a function pointer we cannot
+ * 	recover the function start and instead continue with sv_pc as
+ * 	an arbitrary value within the current function. If this is the case
+ * 	we cannot print registers for the current function, but the stacktrace
+ * 	is still printed properly.
+ */
+1003:		ldr     sv_lr, [sv_fp, #4]      @ get saved lr from next frame
+
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
+
+finished_setup:
+
+		bic	sv_pc, sv_pc, mask	@ mask PC/LR for the mode
+
+/*
+ * Print the function (sv_pc) and where it was called
+ * 	from (sv_lr).
+ */
+1004:		mov     r0, sv_pc
+
+		mov     r1, sv_lr
+		mov	r2, frame
+		bic	r1, r1, mask		@ mask PC/LR for the mode
+		bl	dump_backtrace_entry
+
+/*
+ * Test if the function start is a stmfd instruction
+ * 	to determine which registers were stored in the function
+ * 	prologue.
+ * If we could not recover the sv_pc because we were called through
+ * 	a function pointer the comparison will fail and no registers
+ * 	will print.
+ */
+1005:		ldr	r1, [sv_pc, #0]		@ if stmfd sp!, {..., fp, lr}
+		ldr	r3, .Ldsi		@ instruction exists,
+		teq	r3, r1, lsr #11
+		ldr     r0, [frame]             @ locals are stored in
+						@ the preceding frame
+		subeq	r0, r0, #4
+		bleq	dump_backtrace_stm	@ dump saved registers
+
+/*
+ * If we are out of frames or if the next frame
+ * 	is invalid.
+ */
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
+no_frame:	ldmfd	sp!, {r4 - r9, fp, pc}
+ENDPROC(c_backtrace)
+		.pushsection __ex_table,"a"
+		.align	3
+		.long	1001b, 1006b
+		.long	1002b, 1006b
+		.long	1003b, 1006b
+		.long	1004b, 1006b
+		.long   1005b, 1006b
+		.popsection
+
+.Lbad:		.asciz	"Backtrace aborted due to bad frame pointer <%p>\n"
+		.align
+.Ldsi:		.word	0xe92d4800 >> 11	@ stmfd sp!, {... fp, lr}
+		.word	0xe92d0000 >> 11	@ stmfd sp!, {}
+		.word   0x0b000000              @ bl if these bits are set
+
+#endif
-- 
2.23.0.rc1.153.gdeed80330f-goog

