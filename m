Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A108C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 07:55:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B02C20842
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 07:55:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388188AbfIFHz4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 03:55:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:34468 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726323AbfIFHzy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 03:55:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 45A8FADBF;
        Fri,  6 Sep 2019 07:55:52 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     bp@alien8.de
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>, Andy Lutomirski <luto@kernel.org>
Subject: [PATCH 2/2] x86/asm: Make some functions local labels
Date:   Fri,  6 Sep 2019 09:55:50 +0200
Message-Id: <20190906075550.23435-2-jslaby@suse.cz>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190906075550.23435-1-jslaby@suse.cz>
References: <20190906075550.23435-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Boris suggests to make a local label (prepend ".L") from these functions
to eliminate them from the symbol table. These are functions with very
local names and really should not be visible anywhere.

Note that objtool won't see these functions anymore (to generate ORC
debug info). But all the functions are not annotated with ENDPROC, so
they won't have objtool's attention anyway.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: x86@kernel.org
---
 arch/x86/boot/compressed/head_32.S |  4 ++--
 arch/x86/boot/compressed/head_64.S | 18 +++++++++---------
 arch/x86/entry/entry_64.S          |  4 ++--
 arch/x86/lib/copy_user_64.S        | 14 +++++++-------
 arch/x86/lib/getuser.S             | 16 ++++++++--------
 arch/x86/lib/putuser.S             | 22 +++++++++++-----------
 6 files changed, 39 insertions(+), 39 deletions(-)

diff --git a/arch/x86/boot/compressed/head_32.S b/arch/x86/boot/compressed/head_32.S
index 37380c0d5999..5e30eaaf8576 100644
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
index 6233ae35d0d9..d98cd483377e 100644
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
index af077ded1969..b7c3ea4cb19d 100644
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
index 4fe1601dbc5d..86976b55ae74 100644
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
index 304f958c27b2..9578eb88fc87 100644
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
index 14bf78341d3c..126dd6a9ec9b 100644
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
-- 
2.23.0

