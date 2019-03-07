Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0A18C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 11:54:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8586F20835
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 11:54:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Knrk3NQu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbfCGLwy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 06:52:54 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:39642 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbfCGLwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 06:52:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=jTZTkE7R0FuioCOO1jzakCVlSh4d903b9RMZ07cf9bs=; b=Knrk3NQuwRHvWSzTJz04TFCRLW
        WpBCht85ELxEvF3Evwiw/g0izZQ9+2zME2tYNPECLgif0RIzI6iDSz7bAhC8mRpamJDN7i1jrJTm8
        WqrSdhbdoBl8vq1SDNJtKDZPUUxx7JYIl4UQEci5GWfLNKyixWa4P63P+AeWDYnB1tVvbl10iYyut
        5FXi2PifBnj4qx2fPeqWYddjT0SD5CUHs1QItwqo2NtYYeOmfPFD3pWkK92jZTmatP+IstnBrOhLo
        NS9610Ud3JNW1NYWvPZtQzByhn/DtCwTCO8GLZyK4SbqVjzg5oVQ5jYAneMLv06wwFfwvGQJdfA7H
        ah3keceQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h1rZl-0001WS-2S; Thu, 07 Mar 2019 11:52:37 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 8DE1520297BC8; Thu,  7 Mar 2019 12:52:35 +0100 (CET)
Message-Id: <20190307115159.349746915@infradead.org>
User-Agent: quilt/0.65
Date:   Thu, 07 Mar 2019 12:45:14 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     torvalds@linux-foundation.org, tglx@linutronix.de, hpa@zytor.com,
        julien.thierry@arm.com, will.deacon@arm.com, luto@amacapital.net,
        mingo@kernel.org, catalin.marinas@arm.com, james.morse@arm.com,
        valentin.schneider@arm.com, brgerst@gmail.com, jpoimboe@redhat.com,
        luto@kernel.org, bp@alien8.de, dvlasenk@redhat.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        dvyukov@google.com, rostedt@goodmis.org
Subject: [PATCH 03/20] x86/uaccess: Move copy_user_handle_tail into asm
References: <20190307114511.870090179@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By writing the function in asm we avoid cross object code flow and
objtool no longer gets confused about a 'stray' CLAC.

Also; the asm version is actually _simpler_.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/asm.h        |   24 -------------------
 arch/x86/include/asm/uaccess_64.h |    3 --
 arch/x86/lib/copy_user_64.S       |   48 ++++++++++++++++++++++++++++++++++++++
 arch/x86/lib/usercopy_64.c        |   20 ---------------
 4 files changed, 48 insertions(+), 47 deletions(-)

--- a/arch/x86/include/asm/asm.h
+++ b/arch/x86/include/asm/asm.h
@@ -148,30 +148,6 @@
 	_ASM_PTR (entry);					\
 	.popsection
 
-.macro ALIGN_DESTINATION
-	/* check for bad alignment of destination */
-	movl %edi,%ecx
-	andl $7,%ecx
-	jz 102f				/* already aligned */
-	subl $8,%ecx
-	negl %ecx
-	subl %ecx,%edx
-100:	movb (%rsi),%al
-101:	movb %al,(%rdi)
-	incq %rsi
-	incq %rdi
-	decl %ecx
-	jnz 100b
-102:
-	.section .fixup,"ax"
-103:	addl %ecx,%edx			/* ecx is zerorest also */
-	jmp copy_user_handle_tail
-	.previous
-
-	_ASM_EXTABLE_UA(100b, 103b)
-	_ASM_EXTABLE_UA(101b, 103b)
-	.endm
-
 #else
 # define _EXPAND_EXTABLE_HANDLE(x) #x
 # define _ASM_EXTABLE_HANDLE(from, to, handler)			\
--- a/arch/x86/include/asm/uaccess_64.h
+++ b/arch/x86/include/asm/uaccess_64.h
@@ -208,9 +208,6 @@ __copy_from_user_flushcache(void *dst, c
 }
 
 unsigned long
-copy_user_handle_tail(char *to, char *from, unsigned len);
-
-unsigned long
 mcsafe_handle_tail(char *to, char *from, unsigned len);
 
 #endif /* _ASM_X86_UACCESS_64_H */
--- a/arch/x86/lib/copy_user_64.S
+++ b/arch/x86/lib/copy_user_64.S
@@ -16,6 +16,30 @@
 #include <asm/smap.h>
 #include <asm/export.h>
 
+.macro ALIGN_DESTINATION
+	/* check for bad alignment of destination */
+	movl %edi,%ecx
+	andl $7,%ecx
+	jz 102f				/* already aligned */
+	subl $8,%ecx
+	negl %ecx
+	subl %ecx,%edx
+100:	movb (%rsi),%al
+101:	movb %al,(%rdi)
+	incq %rsi
+	incq %rdi
+	decl %ecx
+	jnz 100b
+102:
+	.section .fixup,"ax"
+103:	addl %ecx,%edx			/* ecx is zerorest also */
+	jmp copy_user_handle_tail
+	.previous
+
+	_ASM_EXTABLE_UA(100b, 103b)
+	_ASM_EXTABLE_UA(101b, 103b)
+	.endm
+
 /*
  * copy_user_generic_unrolled - memory copy with exception handling.
  * This version is for CPUs like P4 that don't have efficient micro
@@ -194,6 +218,30 @@ ENDPROC(copy_user_enhanced_fast_string)
 EXPORT_SYMBOL(copy_user_enhanced_fast_string)
 
 /*
+ * Try to copy last bytes and clear the rest if needed.
+ * Since protection fault in copy_from/to_user is not a normal situation,
+ * it is not necessary to optimize tail handling.
+ *
+ * Input:
+ * rdi destination
+ * rsi source
+ * rdx count
+ *
+ * Output:
+ * eax uncopied bytes or 0 if successful.
+ */
+ALIGN;
+copy_user_handle_tail:
+	movl %edx,%ecx
+1:	rep movsb
+2:	mov %ecx,%eax
+	ASM_CLAC
+	ret
+
+	_ASM_EXTABLE_UA(1b, 2b)
+ENDPROC(copy_user_handle_tail)
+
+/*
  * copy_user_nocache - Uncached memory copy with exception handling
  * This will force destination out of cache for more performance.
  *
--- a/arch/x86/lib/usercopy_64.c
+++ b/arch/x86/lib/usercopy_64.c
@@ -55,26 +55,6 @@ unsigned long clear_user(void __user *to
 EXPORT_SYMBOL(clear_user);
 
 /*
- * Try to copy last bytes and clear the rest if needed.
- * Since protection fault in copy_from/to_user is not a normal situation,
- * it is not necessary to optimize tail handling.
- */
-__visible unsigned long
-copy_user_handle_tail(char *to, char *from, unsigned len)
-{
-	for (; len; --len, to++) {
-		char c;
-
-		if (__get_user_nocheck(c, from++, sizeof(char)))
-			break;
-		if (__put_user_nocheck(c, to, sizeof(char)))
-			break;
-	}
-	clac();
-	return len;
-}
-
-/*
  * Similar to copy_user_handle_tail, probe for the write fault point,
  * but reuse __memcpy_mcsafe in case a new read error is encountered.
  * clac() is handled in _copy_to_iter_mcsafe().


