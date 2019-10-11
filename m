Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C76BC47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 09:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 648822196E
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 09:22:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727462AbfJKJWQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 05:22:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:52498 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726585AbfJKJWQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 05:22:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 68F89ADDA;
        Fri, 11 Oct 2019 09:22:14 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     bp@alien8.de
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH] x86/asm: Make more symbols local
Date:   Fri, 11 Oct 2019 11:22:13 +0200
Message-Id: <20191011092213.31470-1-jslaby@suse.cz>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During the assembly cleanup patchset reveiew, I found more symbols which
are used only locally. So make them really local by prepending ".L" to
them. Namely:
* wakeup_idt is used only in realmode/rm/wakeup_asm.S.
* in_pm32 is used only in boot/pmjump.S.
* retint_user is used only in entry/entry_64.S, perhaps since commit
  2ec67971facc ("x86/entry/64/compat: Remove most of the fast system
  call machinery"), where entry_64_compat's caller was removed.

Drop GLOBAL from all of them too. I do not see more candidates in the
series.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
---
 arch/x86/boot/pmjump.S            | 6 +++---
 arch/x86/entry/entry_64.S         | 4 ++--
 arch/x86/realmode/rm/wakeup_asm.S | 6 +++---
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/x86/boot/pmjump.S b/arch/x86/boot/pmjump.S
index c22f9a7d1aeb..ea88d52eeac7 100644
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
index b7c3ea4cb19d..86cbb22208c8 100644
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
index 05ac9c17c811..dad6198f1a26 100644
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
-- 
2.23.0

