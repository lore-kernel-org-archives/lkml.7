Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C2AC28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 13:23:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24B872086A
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 13:23:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JdfIz4NG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728126AbfFENXX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 09:23:23 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40792 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728059AbfFENXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 09:23:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=2cRvEiy6AX1c/UshB3E5LNGwtAgyIx6T+wlXuCDBGJE=; b=JdfIz4NGxt/cRt+OmVDl21SH4n
        VuBL7FQRRQ1FrGW7RSH+Kmebn2uJ7LiQd5ubQbmGMMkhKjw+jr8WUeKNAE1mtahF3NQzyTp3s2OrM
        2u7bVrRifUGrCwgKyjKlq8TE34/D3hp+nC2/jIx5nXpb7KgGJMWdLDcCyZgYGQxqEQp2WMtIxQbsq
        B8z91OTbsjvKHJVulow1tzZWxBZk6FwddiIOJwo3xshCOekgvJQemw+WuxNk1AiDt0IZTHcHLoq/r
        QcF+Twgk5z1Zbq7IJA07VGk0riXGdbgfrH6JhmbB3lSd1ZC/OZk2G1NL+40+MRkAl6583VqbGnhtq
        /F3IwsnQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hYVsK-0004qa-Q6; Wed, 05 Jun 2019 13:22:44 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 9B42D20757B45; Wed,  5 Jun 2019 15:22:39 +0200 (CEST)
Message-Id: <20190605131945.254721704@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 05 Jun 2019 15:08:05 +0200
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
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH 12/15] x86/static_call: Add out-of-line static call implementation
References: <20190605130753.327195108@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josh Poimboeuf <jpoimboe@redhat.com>

Add the x86 out-of-line static call implementation.  For each key, a
permanent trampoline is created which is the destination for all static
calls for the given key.  The trampoline has a direct jump which gets
patched by static_call_update() when the destination function changes.

Cc: x86@kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Julia Cartwright <julia@ni.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Jason Baron <jbaron@akamai.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jiri Kosina <jkosina@suse.cz>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: David Laight <David.Laight@ACULAB.COM>
Cc: Jessica Yu <jeyu@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/00b08f2194e80241decbf206624b6580b9b8855b.1543200841.git.jpoimboe@redhat.com
---
 arch/x86/Kconfig                   |    1 
 arch/x86/include/asm/static_call.h |   28 +++++++++++++++++++++++++++
 arch/x86/kernel/Makefile           |    1 
 arch/x86/kernel/static_call.c      |   38 +++++++++++++++++++++++++++++++++++++
 4 files changed, 68 insertions(+)
 create mode 100644 arch/x86/include/asm/static_call.h
 create mode 100644 arch/x86/kernel/static_call.c

--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -198,6 +198,7 @@ config X86
 	select HAVE_FUNCTION_ARG_ACCESS_API
 	select HAVE_STACKPROTECTOR		if CC_HAS_SANE_STACKPROTECTOR
 	select HAVE_STACK_VALIDATION		if X86_64
+	select HAVE_STATIC_CALL
 	select HAVE_RSEQ
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_UNSTABLE_SCHED_CLOCK
--- /dev/null
+++ b/arch/x86/include/asm/static_call.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_STATIC_CALL_H
+#define _ASM_STATIC_CALL_H
+
+/*
+ * Manually construct a 5-byte direct JMP to prevent the assembler from
+ * optimizing it into a 2-byte JMP.
+ */
+#define __ARCH_STATIC_CALL_JMP_LABEL(key) ".L" __stringify(key ## _after_jmp)
+#define __ARCH_STATIC_CALL_TRAMP_JMP(key, func)				\
+	".byte 0xe9						\n"	\
+	".long " #func " - " __ARCH_STATIC_CALL_JMP_LABEL(key) "\n"	\
+	__ARCH_STATIC_CALL_JMP_LABEL(key) ":"
+
+/*
+ * This is a permanent trampoline which does a direct jump to the function.
+ * The direct jump get patched by static_call_update().
+ */
+#define ARCH_DEFINE_STATIC_CALL_TRAMP(key, func)			\
+	asm(".pushsection .text, \"ax\"				\n"	\
+	    ".align 4						\n"	\
+	    ".globl " STATIC_CALL_TRAMP_STR(key) "		\n"	\
+	    ".type " STATIC_CALL_TRAMP_STR(key) ", @function	\n"	\
+	    STATIC_CALL_TRAMP_STR(key) ":			\n"	\
+	    __ARCH_STATIC_CALL_TRAMP_JMP(key, func) "           \n"	\
+	    ".popsection					\n")
+
+#endif /* _ASM_STATIC_CALL_H */
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -63,6 +63,7 @@ obj-y			+= tsc.o tsc_msr.o io_delay.o rt
 obj-y			+= pci-iommu_table.o
 obj-y			+= resource.o
 obj-y			+= irqflags.o
+obj-y			+= static_call.o
 
 obj-y				+= process.o
 obj-y				+= fpu/
--- /dev/null
+++ b/arch/x86/kernel/static_call.c
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/static_call.h>
+#include <linux/memory.h>
+#include <linux/bug.h>
+#include <asm/text-patching.h>
+#include <asm/nospec-branch.h>
+
+#define CALL_INSN_SIZE 5
+
+void arch_static_call_transform(void *site, void *tramp, void *func)
+{
+	unsigned char opcodes[CALL_INSN_SIZE];
+	unsigned char insn_opcode;
+	unsigned long insn;
+	s32 dest_relative;
+
+	mutex_lock(&text_mutex);
+
+	insn = (unsigned long)tramp;
+
+	insn_opcode = *(unsigned char *)insn;
+	if (insn_opcode != 0xE9) {
+		WARN_ONCE(1, "unexpected static call insn opcode 0x%x at %pS",
+			  insn_opcode, (void *)insn);
+		goto unlock;
+	}
+
+	dest_relative = (long)(func) - (long)(insn + CALL_INSN_SIZE);
+
+	opcodes[0] = insn_opcode;
+	memcpy(&opcodes[1], &dest_relative, CALL_INSN_SIZE - 1);
+
+	text_poke_bp((void *)insn, opcodes, CALL_INSN_SIZE, NULL);
+
+unlock:
+	mutex_unlock(&text_mutex);
+}
+EXPORT_SYMBOL_GPL(arch_static_call_transform);


