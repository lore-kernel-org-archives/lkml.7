Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E64DC352AA
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 11:24:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC7BB21655
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 11:24:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LfbAnI0n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728093AbfJGLYj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 07:24:39 -0400
Received: from merlin.infradead.org ([205.233.59.134]:58346 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727857AbfJGLXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 07:23:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=+4AaKvmN8caIq9uHFeAUlJVL+zwFVFJntG/eK1n9Pp4=; b=LfbAnI0ntPE2F3Iptj9yEtt7Ud
        EAh7z+e4Q1ugEVS/XxvVad/7FecGayU1vkayfLNmZ4JcyrNctrQWIcvj8oxTTkgXMbOYCV+IluKFm
        cR+bxLnu4Cz68jOCsWl8WhLnt7SIE0OoWWfOT620JKXLQD1wnS0bh8fpGUEdeQJJGumfvC3Ucfqpq
        8WHJZk0jVF85hRRTIi1Ce81G1DeU3LTlMNBjhfO58NB9sUsDCSBSlLHVjL2AboRwHBK8QpBcIQ3F2
        MRdKAB4bhaFQMao9B3SbMW8FS8YAuDsijbEXyUXVkRKyYITudAPuyn+sLhyltBCdthJtx9UNSPiw+
        MfZvBCLQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iHR6x-0002BN-R4; Mon, 07 Oct 2019 11:23:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 24C7330706D;
        Mon,  7 Oct 2019 13:22:36 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id BB34920244E36; Mon,  7 Oct 2019 13:23:26 +0200 (CEST)
Message-Id: <20191007083830.81563732.6@infradead.org>
User-Agent: quilt/0.65
Date:   Mon, 07 Oct 2019 10:27:13 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, mhiramat@kernel.org, bristot@redhat.com,
        jbaron@akamai.com, torvalds@linux-foundation.org,
        tglx@linutronix.de, mingo@kernel.org, namit@vmware.com,
        hpa@zytor.com, luto@kernel.org, ard.biesheuvel@linaro.org,
        jpoimboe@redhat.com
Subject: [PATCH v2 05/13] x86/static_call: Add out-of-line static call implementation
References: <20191007082708.01393931.1@infradead.org>
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

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
[peterz: fixed trampoline, rewrote patching code]
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/Kconfig                   |    1 +
 arch/x86/include/asm/static_call.h |   22 ++++++++++++++++++++++
 arch/x86/kernel/Makefile           |    1 +
 arch/x86/kernel/static_call.c      |   31 +++++++++++++++++++++++++++++++
 4 files changed, 55 insertions(+)
 create mode 100644 arch/x86/include/asm/static_call.h
 create mode 100644 arch/x86/kernel/static_call.c

--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -205,6 +205,7 @@ config X86
 	select HAVE_FUNCTION_ARG_ACCESS_API
 	select HAVE_STACKPROTECTOR		if CC_HAS_SANE_STACKPROTECTOR
 	select HAVE_STACK_VALIDATION		if X86_64
+	select HAVE_STATIC_CALL
 	select HAVE_RSEQ
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_UNSTABLE_SCHED_CLOCK
--- /dev/null
+++ b/arch/x86/include/asm/static_call.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_STATIC_CALL_H
+#define _ASM_STATIC_CALL_H
+
+#include <asm/text-patching.h>
+
+/*
+ * For CONFIG_HAVE_STATIC_CALL, this is a permanent trampoline which
+ * does a direct jump to the function.  The direct jump gets patched by
+ * static_call_update().
+ */
+#define ARCH_DEFINE_STATIC_CALL_TRAMP(name, func)			\
+	asm(".pushsection .text, \"ax\"				\n"	\
+	    ".align 4						\n"	\
+	    ".globl " STATIC_CALL_TRAMP_STR(name) "		\n"	\
+	    STATIC_CALL_TRAMP_STR(name) ":			\n"	\
+	    "	jmp.d32 " #func "				\n"	\
+	    ".type " STATIC_CALL_TRAMP_STR(name) ", @function	\n"	\
+	    ".size " STATIC_CALL_TRAMP_STR(name) ", . - " STATIC_CALL_TRAMP_STR(name) " \n" \
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
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/static_call.h>
+#include <linux/memory.h>
+#include <linux/bug.h>
+#include <asm/text-patching.h>
+
+static void __static_call_transform(void *insn, u8 opcode, void *func)
+{
+	const void *code = text_gen_insn(opcode, (long)insn, (long)func);
+
+	if (WARN_ONCE(*(u8 *)insn != opcode,
+		      "unexpected static call insn opcode 0x%x at %pS\n",
+		      opcode, insn))
+		return;
+
+	if (memcmp(insn, code, CALL_INSN_SIZE) == 0)
+		return;
+
+	text_poke_bp(insn, code, CALL_INSN_SIZE, NULL);
+}
+
+void arch_static_call_transform(void *site, void *tramp, void *func)
+{
+	mutex_lock(&text_mutex);
+
+	if (tramp)
+		__static_call_transform(tramp, JMP32_INSN_OPCODE, func);
+
+	mutex_unlock(&text_mutex);
+}
+EXPORT_SYMBOL_GPL(arch_static_call_transform);


