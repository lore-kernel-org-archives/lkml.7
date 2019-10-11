Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75877C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 14:02:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5490C20640
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 14:02:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728263AbfJKOCW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 10:02:22 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:32857 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727950AbfJKOCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 10:02:21 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iIvUi-0001Yy-2e; Fri, 11 Oct 2019 16:02:12 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 81A081C0178;
        Fri, 11 Oct 2019 16:02:11 +0200 (CEST)
Date:   Fri, 11 Oct 2019 14:02:11 -0000
From:   "tip-bot2 for Jiri Slaby" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/asm] x86/asm: Make more symbols local
Cc:     Jiri Slaby <jslaby@suse.cz>, Borislav Petkov <bp@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, bp@alien8.de,
        hpa@zytor.com, Ingo Molnar <mingo@kernel.org>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191011092213.31470-1-jslaby@suse.cz>
References: <20191011092213.31470-1-jslaby@suse.cz>
MIME-Version: 1.0
Message-ID: <157080253134.9978.12838764433984468954.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     30a2441cae7b149ff484a697bf9eb8de53240a4f
Gitweb:        https://git.kernel.org/tip/30a2441cae7b149ff484a697bf9eb8de53240a4f
Author:        Jiri Slaby <jslaby@suse.cz>
AuthorDate:    Fri, 11 Oct 2019 11:22:13 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 11 Oct 2019 15:56:30 +02:00

x86/asm: Make more symbols local

During the assembly cleanup patchset review, I found more symbols which
are used only locally. So make them really local by prepending ".L" to
them. Namely:

 - wakeup_idt is used only in realmode/rm/wakeup_asm.S.
 - in_pm32 is used only in boot/pmjump.S.
 - retint_user is used only in entry/entry_64.S, perhaps since commit
   2ec67971facc ("x86/entry/64/compat: Remove most of the fast system
   call machinery"), where entry_64_compat's caller was removed.

Drop GLOBAL from all of them too. I do not see more candidates in the
series.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Acked-by: Borislav Petkov <bp@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: bp@alien8.de
Cc: hpa@zytor.com
Link: https://lkml.kernel.org/r/20191011092213.31470-1-jslaby@suse.cz
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/boot/pmjump.S            | 6 +++---
 arch/x86/entry/entry_64.S         | 4 ++--
 arch/x86/realmode/rm/wakeup_asm.S | 6 +++---
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/x86/boot/pmjump.S b/arch/x86/boot/pmjump.S
index c22f9a7..ea88d52 100644
--- a/arch/x86/boot/pmjump.S
+++ b/arch/x86/boot/pmjump.S
@@ -40,13 +40,13 @@ GLOBAL(protected_mode_jump)
 
 	# Transition to 32-bit mode
 	.byte	0x66, 0xea		# ljmpl opcode
-2:	.long	in_pm32			# offset
+2:	.long	.Lin_pm32		# offset
 	.word	__BOOT_CS		# segment
 ENDPROC(protected_mode_jump)
 
 	.code32
 	.section ".text32","ax"
-GLOBAL(in_pm32)
+.Lin_pm32:
 	# Set up data segments for flat 32-bit mode
 	movl	%ecx, %ds
 	movl	%ecx, %es
@@ -72,4 +72,4 @@ GLOBAL(in_pm32)
 	lldt	%cx
 
 	jmpl	*%eax			# Jump to the 32-bit entrypoint
-ENDPROC(in_pm32)
+ENDPROC(.Lin_pm32)
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index b7c3ea4..86cbb22 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -616,7 +616,7 @@ ret_from_intr:
 	jz	retint_kernel
 
 	/* Interrupt came from user space */
-GLOBAL(retint_user)
+.Lretint_user:
 	mov	%rsp,%rdi
 	call	prepare_exit_to_usermode
 	TRACE_IRQS_IRETQ
@@ -1372,7 +1372,7 @@ ENTRY(error_exit)
 	TRACE_IRQS_OFF
 	testb	$3, CS(%rsp)
 	jz	retint_kernel
-	jmp	retint_user
+	jmp	.Lretint_user
 END(error_exit)
 
 /*
diff --git a/arch/x86/realmode/rm/wakeup_asm.S b/arch/x86/realmode/rm/wakeup_asm.S
index 05ac9c1..dad6198 100644
--- a/arch/x86/realmode/rm/wakeup_asm.S
+++ b/arch/x86/realmode/rm/wakeup_asm.S
@@ -73,7 +73,7 @@ ENTRY(wakeup_start)
 	movw	%ax, %fs
 	movw	%ax, %gs
 
-	lidtl	wakeup_idt
+	lidtl	.Lwakeup_idt
 
 	/* Clear the EFLAGS */
 	pushl $0
@@ -171,8 +171,8 @@ END(wakeup_gdt)
 
 	/* This is the standard real-mode IDT */
 	.balign	16
-GLOBAL(wakeup_idt)
+.Lwakeup_idt:
 	.word	0xffff		/* limit */
 	.long	0		/* address */
 	.word	0
-END(wakeup_idt)
+END(.Lwakeup_idt)
