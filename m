Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36F8EC28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 13:23:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0705E20872
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 13:23:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="r+9XiNyH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728193AbfFENXf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 09:23:35 -0400
Received: from merlin.infradead.org ([205.233.59.134]:50946 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728180AbfFENXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 09:23:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=XCOFf8t/Vr4PnHMu/Ezv4KPVfApDXfi03GXCz9r25CY=; b=r+9XiNyHFRAsEQeWC5KbV3g/48
        XwsGkecIlhpZfTfTzHvZB4D2czHyZW1Wnkd0UKuv/1JWER1d+yPoQPPE7o3MGS0MpSqLNTYbU4eh1
        hQk6BOQiclJ5xWJT3zbHPojxY988P8BfqSlnXPOPP0+3gLhY4i4BMT273AOFg1Xo6cTWoElPlvoG0
        t5zJrPII5+1DhBiQ3nxJnU94R+m/MDvivh2P9JDmEIwI0KafynXAp/5MOIxlGx9dLyf3RTdXVL71f
        +P0PWcaV6/nmc021kudgxo900nl+WWig3xApYyau3zT60N1LGFiY+YIzDGyNlsc7P6v4QOStNB6cb
        K8DdEEJA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hYVsJ-0006rT-2f; Wed, 05 Jun 2019 13:22:43 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 942882075075E; Wed,  5 Jun 2019 15:22:39 +0200 (CEST)
Message-Id: <20190605131945.125037517@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 05 Jun 2019 15:08:03 +0200
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
Subject: [PATCH 10/15] static_call: Add basic static call infrastructure
References: <20190605130753.327195108@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josh Poimboeuf <jpoimboe@redhat.com>

Static calls are a replacement for global function pointers.  They use
code patching to allow direct calls to be used instead of indirect
calls.  They give the flexibility of function pointers, but with
improved performance.  This is especially important for cases where
retpolines would otherwise be used, as retpolines can significantly
impact performance.

The concept and code are an extension of previous work done by Ard
Biesheuvel and Steven Rostedt:

  https://lkml.kernel.org/r/20181005081333.15018-1-ard.biesheuvel@linaro.org
  https://lkml.kernel.org/r/20181006015110.653946300@goodmis.org

There are two implementations, depending on arch support:

 1) out-of-line: patched trampolines (CONFIG_HAVE_STATIC_CALL)
 2) basic function pointers

For more details, see the comments in include/linux/static_call.h.

Cc: x86@kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Julia Cartwright <julia@ni.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Jason Baron <jbaron@akamai.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jiri Kosina <jkosina@suse.cz>
Cc: Edward Cree <ecree@solarflare.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: David Laight <David.Laight@ACULAB.COM>
Cc: Jessica Yu <jeyu@kernel.org>
Cc: Nadav Amit <namit@vmware.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/a01f733889ebf4bc447507ab8041a60378eaa89f.1547073843.git.jpoimboe@redhat.com
---
 arch/Kconfig                      |    3 
 include/linux/static_call.h       |  135 ++++++++++++++++++++++++++++++++++++++
 include/linux/static_call_types.h |   13 +++
 3 files changed, 151 insertions(+)
 create mode 100644 include/linux/static_call.h
 create mode 100644 include/linux/static_call_types.h

--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -927,6 +927,9 @@ config LOCK_EVENT_COUNTS
 	  the chance of application behavior change because of timing
 	  differences. The counts are reported via debugfs.
 
+config HAVE_STATIC_CALL
+	bool
+
 source "kernel/gcov/Kconfig"
 
 source "scripts/gcc-plugins/Kconfig"
--- /dev/null
+++ b/include/linux/static_call.h
@@ -0,0 +1,135 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_STATIC_CALL_H
+#define _LINUX_STATIC_CALL_H
+
+/*
+ * Static call support
+ *
+ * Static calls use code patching to hard-code function pointers into direct
+ * branch instructions.  They give the flexibility of function pointers, but
+ * with improved performance.  This is especially important for cases where
+ * retpolines would otherwise be used, as retpolines can significantly impact
+ * performance.
+ *
+ *
+ * API overview:
+ *
+ *   DECLARE_STATIC_CALL(key, func);
+ *   DEFINE_STATIC_CALL(key, func);
+ *   static_call(key, args...);
+ *   static_call_update(key, func);
+ *
+ *
+ * Usage example:
+ *
+ *   # Start with the following functions (with identical prototypes):
+ *   int func_a(int arg1, int arg2);
+ *   int func_b(int arg1, int arg2);
+ *
+ *   # Define a 'my_key' reference, associated with func_a() by default
+ *   DEFINE_STATIC_CALL(my_key, func_a);
+ *
+ *   # Call func_a()
+ *   static_call(my_key, arg1, arg2);
+ *
+ *   # Update 'my_key' to point to func_b()
+ *   static_call_update(my_key, func_b);
+ *
+ *   # Call func_b()
+ *   static_call(my_key, arg1, arg2);
+ *
+ *
+ * Implementation details:
+ *
+ *    This requires some arch-specific code (CONFIG_HAVE_STATIC_CALL).
+ *    Otherwise basic indirect calls are used (with function pointers).
+ *
+ *    Each static_call() site calls into a trampoline associated with the key.
+ *    The trampoline has a direct branch to the default function.  Updates to a
+ *    key will modify the trampoline's branch destination.
+ */
+
+#include <linux/types.h>
+#include <linux/cpu.h>
+#include <linux/static_call_types.h>
+
+#ifdef CONFIG_HAVE_STATIC_CALL
+#include <asm/static_call.h>
+extern void arch_static_call_transform(void *site, void *tramp, void *func);
+#endif
+
+
+#define DECLARE_STATIC_CALL(key, func)					\
+	extern struct static_call_key key;				\
+	extern typeof(func) STATIC_CALL_TRAMP(key)
+
+
+#if defined(CONFIG_HAVE_STATIC_CALL)
+
+struct static_call_key {
+	void *func, *tramp;
+};
+
+#define DEFINE_STATIC_CALL(key, _func)					\
+	DECLARE_STATIC_CALL(key, _func);				\
+	struct static_call_key key = {					\
+		.func = _func,						\
+		.tramp = STATIC_CALL_TRAMP(key),			\
+	};								\
+	ARCH_DEFINE_STATIC_CALL_TRAMP(key, _func)
+
+#define static_call(key, args...) STATIC_CALL_TRAMP(key)(args)
+
+static inline void __static_call_update(struct static_call_key *key, void *func)
+{
+	cpus_read_lock();
+	WRITE_ONCE(key->func, func);
+	arch_static_call_transform(NULL, key->tramp, func);
+	cpus_read_unlock();
+}
+
+#define static_call_update(key, func)					\
+({									\
+	BUILD_BUG_ON(!__same_type(func, STATIC_CALL_TRAMP(key)));	\
+	__static_call_update(&key, func);				\
+})
+
+#define EXPORT_STATIC_CALL(key)						\
+	EXPORT_SYMBOL(STATIC_CALL_TRAMP(key))
+
+#define EXPORT_STATIC_CALL_GPL(key)					\
+	EXPORT_SYMBOL_GPL(STATIC_CALL_TRAMP(key))
+
+
+#else /* Generic implementation */
+
+struct static_call_key {
+	void *func;
+};
+
+#define DEFINE_STATIC_CALL(key, _func)					\
+	DECLARE_STATIC_CALL(key, _func);				\
+	struct static_call_key key = {					\
+		.func = _func,						\
+	}
+
+#define static_call(key, args...)					\
+	((typeof(STATIC_CALL_TRAMP(key))*)(key.func))(args)
+
+static inline void __static_call_update(struct static_call_key *key, void *func)
+{
+	WRITE_ONCE(key->func, func);
+}
+
+#define static_call_update(key, func)					\
+({									\
+	BUILD_BUG_ON(!__same_type(func, STATIC_CALL_TRAMP(key)));	\
+	__static_call_update(&key, func);				\
+})
+
+#define EXPORT_STATIC_CALL(key) EXPORT_SYMBOL(key)
+#define EXPORT_STATIC_CALL_GPL(key) EXPORT_SYMBOL_GPL(key)
+
+#endif /* CONFIG_HAVE_STATIC_CALL */
+
+#endif /* _LINUX_STATIC_CALL_H */
--- /dev/null
+++ b/include/linux/static_call_types.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _STATIC_CALL_TYPES_H
+#define _STATIC_CALL_TYPES_H
+
+#include <linux/stringify.h>
+
+#define STATIC_CALL_TRAMP_PREFIX ____static_call_tramp_
+#define STATIC_CALL_TRAMP_PREFIX_STR __stringify(STATIC_CALL_TRAMP_PREFIX)
+
+#define STATIC_CALL_TRAMP(key) __PASTE(STATIC_CALL_TRAMP_PREFIX, key)
+#define STATIC_CALL_TRAMP_STR(key) __stringify(STATIC_CALL_TRAMP(key))
+
+#endif /* _STATIC_CALL_TYPES_H */


