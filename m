Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBD7EC28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 13:23:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3C7820870
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 13:23:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="H/GUjC20"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728243AbfFENX4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 09:23:56 -0400
Received: from merlin.infradead.org ([205.233.59.134]:50948 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728181AbfFENXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 09:23:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=zgqwSxf3cFqg7sS7YYuXo6uC9XLJ8kJM9DmwUlw85p0=; b=H/GUjC20+gJA0G7HX/SbpQofme
        ub/zNGSrV++xqvU/y55A+LOIXunZtbrPzfgAsdHN9WGRX4fap6GlpBPotPN230WHXmKoZx+yQpsyF
        jo2jqKHWi1L9XceqXECDnrCpK/4bZYcXQXngzgoWCUk/p+8J1qt+mVI66NIrYIGHM3hl+djIxhhlS
        Q12Y89yPnn3/PmdruHupJq7X0chS7wQ2H4hqx5So76Ugjt/d3SkTf7XzWIN2ULJTjQ/ISFwgatnS2
        gTpfKpipWV7g7+pn1YIz6D4nWj+atIqgFlvrIks6TWMl5Rv5xTgND0q7tU0sQWt6I+xrLh/FRwK5y
        3abKSusA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hYVsJ-0006rN-2u; Wed, 05 Jun 2019 13:22:43 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 738C1202674D6; Wed,  5 Jun 2019 15:22:39 +0200 (CEST)
Message-Id: <20190605131944.652366009@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 05 Jun 2019 15:07:55 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@ACULAB.COM>,
        Borislav Petkov <bp@alien8.de>,
        Julia Cartwright <julia@ni.com>, Jessica Yu <jeyu@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Nadav Amit <namit@vmware.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Edward Cree <ecree@solarflare.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: [PATCH 02/15] x86: Move ENCODE_FRAME_POINTER to asm/frame.h
References: <20190605130753.327195108@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for wider use, move the ENCODE_FRAME_POINTER macros to
a common header and provide inline asm versions.

These macros are used to encode a pt_regs frame for the unwinder; see
unwind_frame.c:decode_frame_pointer().

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/entry/calling.h     |   15 -------------
 arch/x86/entry/entry_32.S    |   16 --------------
 arch/x86/include/asm/frame.h |   49 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 49 insertions(+), 31 deletions(-)

--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -172,21 +172,6 @@ For 32-bit we have the following convent
 	.endif
 .endm
 
-/*
- * This is a sneaky trick to help the unwinder find pt_regs on the stack.  The
- * frame pointer is replaced with an encoded pointer to pt_regs.  The encoding
- * is just setting the LSB, which makes it an invalid stack address and is also
- * a signal to the unwinder that it's a pt_regs pointer in disguise.
- *
- * NOTE: This macro must be used *after* PUSH_AND_CLEAR_REGS because it corrupts
- * the original rbp.
- */
-.macro ENCODE_FRAME_POINTER ptregs_offset=0
-#ifdef CONFIG_FRAME_POINTER
-	leaq 1+\ptregs_offset(%rsp), %rbp
-#endif
-.endm
-
 #ifdef CONFIG_PAGE_TABLE_ISOLATION
 
 /*
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -246,22 +246,6 @@
 .Lend_\@:
 .endm
 
-/*
- * This is a sneaky trick to help the unwinder find pt_regs on the stack.  The
- * frame pointer is replaced with an encoded pointer to pt_regs.  The encoding
- * is just clearing the MSB, which makes it an invalid stack address and is also
- * a signal to the unwinder that it's a pt_regs pointer in disguise.
- *
- * NOTE: This macro must be used *after* SAVE_ALL because it corrupts the
- * original rbp.
- */
-.macro ENCODE_FRAME_POINTER
-#ifdef CONFIG_FRAME_POINTER
-	mov %esp, %ebp
-	andl $0x7fffffff, %ebp
-#endif
-.endm
-
 .macro RESTORE_INT_REGS
 	popl	%ebx
 	popl	%ecx
--- a/arch/x86/include/asm/frame.h
+++ b/arch/x86/include/asm/frame.h
@@ -22,6 +22,35 @@
 	pop %_ASM_BP
 .endm
 
+#ifdef CONFIG_X86_64
+/*
+ * This is a sneaky trick to help the unwinder find pt_regs on the stack.  The
+ * frame pointer is replaced with an encoded pointer to pt_regs.  The encoding
+ * is just setting the LSB, which makes it an invalid stack address and is also
+ * a signal to the unwinder that it's a pt_regs pointer in disguise.
+ *
+ * NOTE: This macro must be used *after* PUSH_AND_CLEAR_REGS because it corrupts
+ * the original rbp.
+ */
+.macro ENCODE_FRAME_POINTER ptregs_offset=0
+	leaq 1+\ptregs_offset(%rsp), %rbp
+.endm
+#else /* !CONFIG_X86_64 */
+/*
+ * This is a sneaky trick to help the unwinder find pt_regs on the stack.  The
+ * frame pointer is replaced with an encoded pointer to pt_regs.  The encoding
+ * is just clearing the MSB, which makes it an invalid stack address and is also
+ * a signal to the unwinder that it's a pt_regs pointer in disguise.
+ *
+ * NOTE: This macro must be used *after* SAVE_ALL because it corrupts the
+ * original ebp.
+ */
+.macro ENCODE_FRAME_POINTER
+	mov %esp, %ebp
+	andl $0x7fffffff, %ebp
+.endm
+#endif /* CONFIG_X86_64 */
+
 #else /* !__ASSEMBLY__ */
 
 #define FRAME_BEGIN				\
@@ -30,12 +59,32 @@
 
 #define FRAME_END "pop %" _ASM_BP "\n"
 
+#ifdef CONFIG_X86_64
+#define ENCODE_FRAME_POINTER			\
+	"lea 1(%rsp), %rbp\n\t"
+#else /* !CONFIG_X86_64 */
+#define ENCODE_FRAME_POINTER			\
+	"movl %esp, %ebp\n\t"			\
+	"andl $0x7fffffff, %ebp\n\t"
+#endif /* CONFIG_X86_64 */
+
 #endif /* __ASSEMBLY__ */
 
 #define FRAME_OFFSET __ASM_SEL(4, 8)
 
 #else /* !CONFIG_FRAME_POINTER */
 
+#ifdef __ASSEMBLY__
+
+.macro ENCODE_FRAME_POINTER ptregs_offset=0
+.endm
+
+#else /* !__ASSEMBLY */
+
+#define ENCODE_FRAME_POINTER
+
+#endif
+
 #define FRAME_BEGIN
 #define FRAME_END
 #define FRAME_OFFSET 0


