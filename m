Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8810FC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 20:14:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6782E206CC
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 20:14:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbfKUUOe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 15:14:34 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:33395 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbfKUUOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 15:14:31 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iXsqP-0004fO-Ko; Thu, 21 Nov 2019 21:14:25 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 318A31C1A4C;
        Thu, 21 Nov 2019 21:14:25 +0100 (CET)
Date:   Thu, 21 Nov 2019 20:14:25 -0000
From:   "tip-bot2 for Andy Lutomirski" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/entry/32: Unwind the ESPFIX stack earlier on
 exception entry
Cc:     Andy Lutomirski <luto@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, stable@kernel.org,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <157436726513.21853.1350949697904778536.tip-bot2@tip-bot2>
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

Commit-ID:     a1a338e5b6fe9e0a39c57c232dc96c198bb53e47
Gitweb:        https://git.kernel.org/tip/a1a338e5b6fe9e0a39c57c232dc96c198bb53e47
Author:        Andy Lutomirski <luto@kernel.org>
AuthorDate:    Wed, 20 Nov 2019 10:10:49 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 21 Nov 2019 19:37:44 +01:00

x86/entry/32: Unwind the ESPFIX stack earlier on exception entry

Right now, we do some fancy parts of the exception entry path while SS
might have a nonzero base: we fill in regs->ss and regs->sp, and we
consider switching to the kernel stack. This results in regs->ss and
regs->sp referring to a non-flat stack and it may result in
overflowing the entry stack. The former issue means that we can try to
call iret_exc on a non-flat stack, which doesn't work.

Tested with selftests/x86/sigreturn_32.

Fixes: 45d7b255747c ("x86/entry/32: Enter the kernel via trampoline stack")
Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: stable@kernel.org
---
 arch/x86/entry/entry_32.S | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index d9f4019..647e2a2 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -210,8 +210,6 @@
 	/*
 	 * The high bits of the CS dword (__csh) are used for CS_FROM_*.
 	 * Clear them in case hardware didn't do this for us.
-	 *
-	 * Be careful: we may have nonzero SS base due to ESPFIX.
 	 */
 	andl	$0x0000ffff, 4*4(%esp)
 
@@ -307,12 +305,21 @@
 .Lfinished_frame_\@:
 .endm
 
-.macro SAVE_ALL pt_regs_ax=%eax switch_stacks=0 skip_gs=0
+.macro SAVE_ALL pt_regs_ax=%eax switch_stacks=0 skip_gs=0 unwind_espfix=0
 	cld
 .if \skip_gs == 0
 	PUSH_GS
 .endif
 	pushl	%fs
+
+	pushl	%eax
+	movl	$(__KERNEL_PERCPU), %eax
+	movl	%eax, %fs
+.if \unwind_espfix > 0
+	UNWIND_ESPFIX_STACK
+.endif
+	popl	%eax
+
 	FIXUP_FRAME
 	pushl	%es
 	pushl	%ds
@@ -326,8 +333,6 @@
 	movl	$(__USER_DS), %edx
 	movl	%edx, %ds
 	movl	%edx, %es
-	movl	$(__KERNEL_PERCPU), %edx
-	movl	%edx, %fs
 .if \skip_gs == 0
 	SET_KERNEL_GS %edx
 .endif
@@ -1153,18 +1158,17 @@ ENDPROC(entry_INT80_32)
 	lss	(%esp), %esp			/* switch to the normal stack segment */
 #endif
 .endm
+
 .macro UNWIND_ESPFIX_STACK
+	/* It's safe to clobber %eax, all other regs need to be preserved */
 #ifdef CONFIG_X86_ESPFIX32
 	movl	%ss, %eax
 	/* see if on espfix stack */
 	cmpw	$__ESPFIX_SS, %ax
-	jne	27f
-	movl	$__KERNEL_DS, %eax
-	movl	%eax, %ds
-	movl	%eax, %es
+	jne	.Lno_fixup_\@
 	/* switch to normal stack */
 	FIXUP_ESPFIX_STACK
-27:
+.Lno_fixup_\@:
 #endif
 .endm
 
@@ -1458,10 +1462,9 @@ END(page_fault)
 
 common_exception_read_cr2:
 	/* the function address is in %gs's slot on the stack */
-	SAVE_ALL switch_stacks=1 skip_gs=1
+	SAVE_ALL switch_stacks=1 skip_gs=1 unwind_espfix=1
 
 	ENCODE_FRAME_POINTER
-	UNWIND_ESPFIX_STACK
 
 	/* fixup %gs */
 	GS_TO_REG %ecx
@@ -1483,9 +1486,8 @@ END(common_exception_read_cr2)
 
 common_exception:
 	/* the function address is in %gs's slot on the stack */
-	SAVE_ALL switch_stacks=1 skip_gs=1
+	SAVE_ALL switch_stacks=1 skip_gs=1 unwind_espfix=1
 	ENCODE_FRAME_POINTER
-	UNWIND_ESPFIX_STACK
 
 	/* fixup %gs */
 	GS_TO_REG %ecx
