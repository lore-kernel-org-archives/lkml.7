Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF2C6C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 20:14:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB93E2068F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 20:14:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727227AbfKUUOz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 15:14:55 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:33394 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726554AbfKUUOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 15:14:30 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iXsqP-0004fN-Lf; Thu, 21 Nov 2019 21:14:25 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 076A81C1A4B;
        Thu, 21 Nov 2019 21:14:25 +0100 (CET)
Date:   Thu, 21 Nov 2019 20:14:24 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/entry/32: Fix NMI vs ESPFIX
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>, stable@kernel.org,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <157436726488.21853.6610771952435778450.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     895429076512e9d1cf5428181076299c90713159
Gitweb:        https://git.kernel.org/tip/895429076512e9d1cf5428181076299c90713159
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 20 Nov 2019 15:02:26 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 21 Nov 2019 19:37:44 +01:00

x86/entry/32: Fix NMI vs ESPFIX

When the NMI lands on an ESPFIX_SS, we are on the entry stack and must
swizzle, otherwise we'll run do_nmi() on the entry stack, which is
BAD.

Also, similar to the normal exception path, we need to correct the
ESPFIX magic before leaving the entry stack, otherwise pt_regs will
present a non-flat stack pointer.

Tested by running sigreturn_32 concurrent with perf-record.

Fixes: e5862d0515ad ("x86/entry/32: Leave the kernel via trampoline stack")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Andy Lutomirski <luto@kernel.org>
Cc: stable@kernel.org
---
 arch/x86/entry/entry_32.S | 53 +++++++++++++++++++++++++++++---------
 1 file changed, 41 insertions(+), 12 deletions(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index 647e2a2..0b8c931 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -205,6 +205,7 @@
 #define CS_FROM_ENTRY_STACK	(1 << 31)
 #define CS_FROM_USER_CR3	(1 << 30)
 #define CS_FROM_KERNEL		(1 << 29)
+#define CS_FROM_ESPFIX		(1 << 28)
 
 .macro FIXUP_FRAME
 	/*
@@ -342,8 +343,8 @@
 .endif
 .endm
 
-.macro SAVE_ALL_NMI cr3_reg:req
-	SAVE_ALL
+.macro SAVE_ALL_NMI cr3_reg:req unwind_espfix=0
+	SAVE_ALL unwind_espfix=\unwind_espfix
 
 	BUG_IF_WRONG_CR3
 
@@ -1526,6 +1527,10 @@ ENTRY(nmi)
 	ASM_CLAC
 
 #ifdef CONFIG_X86_ESPFIX32
+	/*
+	 * ESPFIX_SS is only ever set on the return to user path
+	 * after we've switched to the entry stack.
+	 */
 	pushl	%eax
 	movl	%ss, %eax
 	cmpw	$__ESPFIX_SS, %ax
@@ -1561,6 +1566,11 @@ ENTRY(nmi)
 	movl	%ebx, %esp
 
 .Lnmi_return:
+#ifdef CONFIG_X86_ESPFIX32
+	testl	$CS_FROM_ESPFIX, PT_CS(%esp)
+	jnz	.Lnmi_from_espfix
+#endif
+
 	CHECK_AND_APPLY_ESPFIX
 	RESTORE_ALL_NMI cr3_reg=%edi pop=4
 	jmp	.Lirq_return
@@ -1568,23 +1578,42 @@ ENTRY(nmi)
 #ifdef CONFIG_X86_ESPFIX32
 .Lnmi_espfix_stack:
 	/*
-	 * create the pointer to lss back
+	 * Create the pointer to LSS back
 	 */
 	pushl	%ss
 	pushl	%esp
 	addl	$4, (%esp)
-	/* copy the iret frame of 12 bytes */
-	.rept 3
-	pushl	16(%esp)
-	.endr
-	pushl	%eax
-	SAVE_ALL_NMI cr3_reg=%edi
+
+	/* Copy the (short) IRET frame */
+	pushl	4*4(%esp)	# flags
+	pushl	4*4(%esp)	# cs
+	pushl	4*4(%esp)	# ip
+
+	pushl	%eax		# orig_ax
+
+	SAVE_ALL_NMI cr3_reg=%edi unwind_espfix=1
 	ENCODE_FRAME_POINTER
-	FIXUP_ESPFIX_STACK			# %eax == %esp
+
+	/* clear CS_FROM_KERNEL, set CS_FROM_ESPFIX */
+	xorl	$(CS_FROM_ESPFIX | CS_FROM_KERNEL), PT_CS(%esp)
+
 	xorl	%edx, %edx			# zero error code
-	call	do_nmi
+	movl	%esp, %eax			# pt_regs pointer
+	jmp	.Lnmi_from_sysenter_stack
+
+.Lnmi_from_espfix:
 	RESTORE_ALL_NMI cr3_reg=%edi
-	lss	12+4(%esp), %esp		# back to espfix stack
+	/*
+	 * Because we cleared CS_FROM_KERNEL, IRET_FRAME 'forgot' to
+	 * fix up the gap and long frame:
+	 *
+	 *  3 - original frame	(exception)
+	 *  2 - ESPFIX block	(above)
+	 *  6 - gap		(FIXUP_FRAME)
+	 *  5 - long frame	(FIXUP_FRAME)
+	 *  1 - orig_ax
+	 */
+	lss	(1+5+6)*4(%esp), %esp			# back to espfix stack
 	jmp	.Lirq_return
 #endif
 END(nmi)
