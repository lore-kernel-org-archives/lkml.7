Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC9E4C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 09:52:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95FC320842
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 09:52:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393001AbfIFJwW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 05:52:22 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:46805 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbfIFJwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 05:52:22 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i6AuS-000556-M7; Fri, 06 Sep 2019 11:52:04 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 2161F1C0744;
        Fri,  6 Sep 2019 11:52:04 +0200 (CEST)
Date:   Fri, 06 Sep 2019 09:52:03 -0000
From:   "tip-bot2 for Jiri Slaby" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/asm] x86/asm: Make some functions local labels
Cc:     Jiri Slaby <jslaby@suse.cz>, Borislav Petkov <bp@suse.de>,
        Andy Lutomirski <luto@kernel.org>,
        Cao jin <caoj.fnst@cn.fujitsu.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steve Winslow <swinslow@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wei Huang <wei@redhat.com>, "x86-ml" <x86@kernel.org>,
        Xiaoyao Li <xiaoyao.li@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20190906075550.23435-2-jslaby@suse.cz>
References: <20190906075550.23435-2-jslaby@suse.cz>
MIME-Version: 1.0
Message-ID: <156776352396.24167.1312164615608729301.tip-bot2@tip-bot2>
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

Commit-ID:     98ededb61fafd303f2337f68b0326a4b95e3cebe
Gitweb:        https://git.kernel.org/tip/98ededb61fafd303f2337f68b0326a4b95e3cebe
Author:        Jiri Slaby <jslaby@suse.cz>
AuthorDate:    Fri, 06 Sep 2019 09:55:50 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 06 Sep 2019 10:41:11 +02:00

x86/asm: Make some functions local labels

Boris suggests to make a local label (prepend ".L") to these functions
to eliminate them from the symbol table. These are functions with very
local names and really should not be visible anywhere.

Note that objtool won't see these functions anymore (to generate ORC
debug info). But all the functions are not annotated with ENDPROC, so
they won't have objtool's attention anyway.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Cao jin <caoj.fnst@cn.fujitsu.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steve Winslow <swinslow@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Wei Huang <wei@redhat.com>
Cc: x86-ml <x86@kernel.org>
Cc: Xiaoyao Li <xiaoyao.li@linux.intel.com>
Link: https://lkml.kernel.org/r/20190906075550.23435-2-jslaby@suse.cz
---
 arch/x86/boot/compressed/head_32.S |  4 ++--
 arch/x86/boot/compressed/head_64.S | 18 +++++++++---------
 arch/x86/entry/entry_64.S          |  4 ++--
 arch/x86/lib/copy_user_64.S        | 14 +++++++-------
 arch/x86/lib/getuser.S             | 16 ++++++++--------
 arch/x86/lib/putuser.S             | 22 +++++++++++-----------
 6 files changed, 39 insertions(+), 39 deletions(-)

diff --git a/arch/x86/boot/compressed/head_32.S b/arch/x86/boot/compressed/head_32.S
index 37380c0..5e30eaa 100644
--- a/arch/x86/boot/compressed/head_32.S
+++ b/arch/x86/boot/compressed/head_32.S
@@ -140,7 +140,7 @@ ENTRY(startup_32)
 /*
  * Jump to the relocated address.
  */
-	leal	relocated(%ebx), %eax
+	leal	.Lrelocated(%ebx), %eax
 	jmp	*%eax
 ENDPROC(startup_32)
 
@@ -209,7 +209,7 @@ ENDPROC(efi32_stub_entry)
 #endif
 
 	.text
-relocated:
+.Lrelocated:
 
 /*
  * Clear BSS (stack is currently empty)
diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index 6233ae3..d98cd48 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -87,7 +87,7 @@ ENTRY(startup_32)
 
 	call	verify_cpu
 	testl	%eax, %eax
-	jnz	no_longmode
+	jnz	.Lno_longmode
 
 /*
  * Compute the delta between where we were compiled to run at
@@ -322,7 +322,7 @@ ENTRY(startup_64)
 1:	popq	%rdi
 	subq	$1b, %rdi
 
-	call	adjust_got
+	call	.Ladjust_got
 
 	/*
 	 * At this point we are in long mode with 4-level paging enabled,
@@ -421,7 +421,7 @@ trampoline_return:
 
 	/* The new adjustment is the relocation address */
 	movq	%rbx, %rdi
-	call	adjust_got
+	call	.Ladjust_got
 
 /*
  * Copy the compressed kernel to the end of our buffer
@@ -440,7 +440,7 @@ trampoline_return:
 /*
  * Jump to the relocated address.
  */
-	leaq	relocated(%rbx), %rax
+	leaq	.Lrelocated(%rbx), %rax
 	jmp	*%rax
 
 #ifdef CONFIG_EFI_STUB
@@ -511,7 +511,7 @@ ENDPROC(efi64_stub_entry)
 #endif
 
 	.text
-relocated:
+.Lrelocated:
 
 /*
  * Clear BSS (stack is currently empty)
@@ -548,7 +548,7 @@ relocated:
  * first time we touch GOT).
  * RDI is the new adjustment to apply.
  */
-adjust_got:
+.Ladjust_got:
 	/* Walk through the GOT adding the address to the entries */
 	leaq	_got(%rip), %rdx
 	leaq	_egot(%rip), %rcx
@@ -622,7 +622,7 @@ ENTRY(trampoline_32bit_src)
 	movl	%eax, %cr4
 
 	/* Calculate address of paging_enabled() once we are executing in the trampoline */
-	leal	paging_enabled - trampoline_32bit_src + TRAMPOLINE_32BIT_CODE_OFFSET(%ecx), %eax
+	leal	.Lpaging_enabled - trampoline_32bit_src + TRAMPOLINE_32BIT_CODE_OFFSET(%ecx), %eax
 
 	/* Prepare the stack for far return to Long Mode */
 	pushl	$__KERNEL_CS
@@ -635,7 +635,7 @@ ENTRY(trampoline_32bit_src)
 	lret
 
 	.code64
-paging_enabled:
+.Lpaging_enabled:
 	/* Return from the trampoline */
 	jmp	*%rdi
 
@@ -647,7 +647,7 @@ paging_enabled:
 	.org	trampoline_32bit_src + TRAMPOLINE_32BIT_CODE_SIZE
 
 	.code32
-no_longmode:
+.Lno_longmode:
 	/* This isn't an x86-64 CPU, so hang intentionally, we cannot continue */
 1:
 	hlt
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index be9ca19..cf27324 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1058,10 +1058,10 @@ ENTRY(native_load_gs_index)
 ENDPROC(native_load_gs_index)
 EXPORT_SYMBOL(native_load_gs_index)
 
-	_ASM_EXTABLE(.Lgs_change, bad_gs)
+	_ASM_EXTABLE(.Lgs_change, .Lbad_gs)
 	.section .fixup, "ax"
 	/* running with kernelgs */
-bad_gs:
+.Lbad_gs:
 	SWAPGS					/* switch back to user gs */
 .macro ZAP_GS
 	/* This can't be a string because the preprocessor needs to see it. */
diff --git a/arch/x86/lib/copy_user_64.S b/arch/x86/lib/copy_user_64.S
index 4fe1601..86976b5 100644
--- a/arch/x86/lib/copy_user_64.S
+++ b/arch/x86/lib/copy_user_64.S
@@ -33,7 +33,7 @@
 102:
 	.section .fixup,"ax"
 103:	addl %ecx,%edx			/* ecx is zerorest also */
-	jmp copy_user_handle_tail
+	jmp .Lcopy_user_handle_tail
 	.previous
 
 	_ASM_EXTABLE_UA(100b, 103b)
@@ -113,7 +113,7 @@ ENTRY(copy_user_generic_unrolled)
 40:	leal (%rdx,%rcx,8),%edx
 	jmp 60f
 50:	movl %ecx,%edx
-60:	jmp copy_user_handle_tail /* ecx is zerorest also */
+60:	jmp .Lcopy_user_handle_tail /* ecx is zerorest also */
 	.previous
 
 	_ASM_EXTABLE_UA(1b, 30b)
@@ -177,7 +177,7 @@ ENTRY(copy_user_generic_string)
 	.section .fixup,"ax"
 11:	leal (%rdx,%rcx,8),%ecx
 12:	movl %ecx,%edx		/* ecx is zerorest also */
-	jmp copy_user_handle_tail
+	jmp .Lcopy_user_handle_tail
 	.previous
 
 	_ASM_EXTABLE_UA(1b, 11b)
@@ -210,7 +210,7 @@ ENTRY(copy_user_enhanced_fast_string)
 
 	.section .fixup,"ax"
 12:	movl %ecx,%edx		/* ecx is zerorest also */
-	jmp copy_user_handle_tail
+	jmp .Lcopy_user_handle_tail
 	.previous
 
 	_ASM_EXTABLE_UA(1b, 12b)
@@ -231,7 +231,7 @@ EXPORT_SYMBOL(copy_user_enhanced_fast_string)
  * eax uncopied bytes or 0 if successful.
  */
 ALIGN;
-copy_user_handle_tail:
+.Lcopy_user_handle_tail:
 	movl %edx,%ecx
 1:	rep movsb
 2:	mov %ecx,%eax
@@ -239,7 +239,7 @@ copy_user_handle_tail:
 	ret
 
 	_ASM_EXTABLE_UA(1b, 2b)
-END(copy_user_handle_tail)
+END(.Lcopy_user_handle_tail)
 
 /*
  * copy_user_nocache - Uncached memory copy with exception handling
@@ -364,7 +364,7 @@ ENTRY(__copy_user_nocache)
 	movl %ecx,%edx
 .L_fixup_handle_tail:
 	sfence
-	jmp copy_user_handle_tail
+	jmp .Lcopy_user_handle_tail
 	.previous
 
 	_ASM_EXTABLE_UA(1b, .L_fixup_4x8b_copy)
diff --git a/arch/x86/lib/getuser.S b/arch/x86/lib/getuser.S
index 304f958..9578eb8 100644
--- a/arch/x86/lib/getuser.S
+++ b/arch/x86/lib/getuser.S
@@ -115,7 +115,7 @@ ENDPROC(__get_user_8)
 EXPORT_SYMBOL(__get_user_8)
 
 
-bad_get_user_clac:
+.Lbad_get_user_clac:
 	ASM_CLAC
 bad_get_user:
 	xor %edx,%edx
@@ -123,7 +123,7 @@ bad_get_user:
 	ret
 
 #ifdef CONFIG_X86_32
-bad_get_user_8_clac:
+.Lbad_get_user_8_clac:
 	ASM_CLAC
 bad_get_user_8:
 	xor %edx,%edx
@@ -132,12 +132,12 @@ bad_get_user_8:
 	ret
 #endif
 
-	_ASM_EXTABLE_UA(1b, bad_get_user_clac)
-	_ASM_EXTABLE_UA(2b, bad_get_user_clac)
-	_ASM_EXTABLE_UA(3b, bad_get_user_clac)
+	_ASM_EXTABLE_UA(1b, .Lbad_get_user_clac)
+	_ASM_EXTABLE_UA(2b, .Lbad_get_user_clac)
+	_ASM_EXTABLE_UA(3b, .Lbad_get_user_clac)
 #ifdef CONFIG_X86_64
-	_ASM_EXTABLE_UA(4b, bad_get_user_clac)
+	_ASM_EXTABLE_UA(4b, .Lbad_get_user_clac)
 #else
-	_ASM_EXTABLE_UA(4b, bad_get_user_8_clac)
-	_ASM_EXTABLE_UA(5b, bad_get_user_8_clac)
+	_ASM_EXTABLE_UA(4b, .Lbad_get_user_8_clac)
+	_ASM_EXTABLE_UA(5b, .Lbad_get_user_8_clac)
 #endif
diff --git a/arch/x86/lib/putuser.S b/arch/x86/lib/putuser.S
index 14bf783..126dd6a 100644
--- a/arch/x86/lib/putuser.S
+++ b/arch/x86/lib/putuser.S
@@ -37,7 +37,7 @@
 ENTRY(__put_user_1)
 	ENTER
 	cmp TASK_addr_limit(%_ASM_BX),%_ASM_CX
-	jae bad_put_user
+	jae .Lbad_put_user
 	ASM_STAC
 1:	movb %al,(%_ASM_CX)
 	xor %eax,%eax
@@ -51,7 +51,7 @@ ENTRY(__put_user_2)
 	mov TASK_addr_limit(%_ASM_BX),%_ASM_BX
 	sub $1,%_ASM_BX
 	cmp %_ASM_BX,%_ASM_CX
-	jae bad_put_user
+	jae .Lbad_put_user
 	ASM_STAC
 2:	movw %ax,(%_ASM_CX)
 	xor %eax,%eax
@@ -65,7 +65,7 @@ ENTRY(__put_user_4)
 	mov TASK_addr_limit(%_ASM_BX),%_ASM_BX
 	sub $3,%_ASM_BX
 	cmp %_ASM_BX,%_ASM_CX
-	jae bad_put_user
+	jae .Lbad_put_user
 	ASM_STAC
 3:	movl %eax,(%_ASM_CX)
 	xor %eax,%eax
@@ -79,7 +79,7 @@ ENTRY(__put_user_8)
 	mov TASK_addr_limit(%_ASM_BX),%_ASM_BX
 	sub $7,%_ASM_BX
 	cmp %_ASM_BX,%_ASM_CX
-	jae bad_put_user
+	jae .Lbad_put_user
 	ASM_STAC
 4:	mov %_ASM_AX,(%_ASM_CX)
 #ifdef CONFIG_X86_32
@@ -91,16 +91,16 @@ ENTRY(__put_user_8)
 ENDPROC(__put_user_8)
 EXPORT_SYMBOL(__put_user_8)
 
-bad_put_user_clac:
+.Lbad_put_user_clac:
 	ASM_CLAC
-bad_put_user:
+.Lbad_put_user:
 	movl $-EFAULT,%eax
 	RET
 
-	_ASM_EXTABLE_UA(1b, bad_put_user_clac)
-	_ASM_EXTABLE_UA(2b, bad_put_user_clac)
-	_ASM_EXTABLE_UA(3b, bad_put_user_clac)
-	_ASM_EXTABLE_UA(4b, bad_put_user_clac)
+	_ASM_EXTABLE_UA(1b, .Lbad_put_user_clac)
+	_ASM_EXTABLE_UA(2b, .Lbad_put_user_clac)
+	_ASM_EXTABLE_UA(3b, .Lbad_put_user_clac)
+	_ASM_EXTABLE_UA(4b, .Lbad_put_user_clac)
 #ifdef CONFIG_X86_32
-	_ASM_EXTABLE_UA(5b, bad_put_user_clac)
+	_ASM_EXTABLE_UA(5b, .Lbad_put_user_clac)
 #endif
