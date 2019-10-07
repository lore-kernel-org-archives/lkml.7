Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA8D4C352AA
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 11:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3C1C2173B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 11:25:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="17fNCOpT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728157AbfJGLZB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 07:25:01 -0400
Received: from merlin.infradead.org ([205.233.59.134]:58250 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727784AbfJGLXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 07:23:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=lwCdN/3T5/UsVXSBXFx+DDFuWyX3jALdyXzFEnubA3Y=; b=17fNCOpTsACcjC+Xs1Vhh37u7m
        PwRUWIo8RsjvsFfEV2yMe7WIoyE5gqSgsB3ajyWy0UC9dUiDm70HbI7MewmiBt6u6YtqD7qe6+MPI
        Y/H8F/mPAM7sZfexxFjqfqbk5A2ls3QaI9MV+XsLf6Wp2Dnb2anqJLnmttR/QzNeUTzHmpeM/27pY
        qm4ZOww36o69hbCbpWz5VLzZsu77y96fXoyxVAJW3ZvglNiThJqS7jJqQrJWOr7s/LEK+AyGe11Hv
        BwTFt08MCmwxBcSYTHFmsvKfsgZ/amzNsFVa3mu7d95Y7C9ZyZC2av5NOsr8b9o4J2rClHDAj3sBg
        Lt+nvWdg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iHR6x-0002BP-RA; Mon, 07 Oct 2019 11:23:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1BCCB30705E;
        Mon,  7 Oct 2019 13:22:36 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id A729420244E30; Mon,  7 Oct 2019 13:23:26 +0200 (CEST)
Message-Id: <20191007083830.64667428.5@infradead.org>
User-Agent: quilt/0.65
Date:   Mon, 07 Oct 2019 10:27:10 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, mhiramat@kernel.org, bristot@redhat.com,
        jbaron@akamai.com, torvalds@linux-foundation.org,
        tglx@linutronix.de, mingo@kernel.org, namit@vmware.com,
        hpa@zytor.com, luto@kernel.org, ard.biesheuvel@linaro.org,
        jpoimboe@redhat.com
Subject: [PATCH v2 02/13] static_call: Add basic static call infrastructure
References: <20191007082708.01393931.1@infradead.org>
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

  https://lkml.kernel.org/r/20181005081333.15018-1-ard.biesheuvel@linaro.org, jpoimboe@redhat.com
  https://lkml.kernel.org/r/20181006015110.653946300@goodmis.org

There are two implementations, depending on arch support:

 1) out-of-line: patched trampolines (CONFIG_HAVE_STATIC_CALL)
 2) basic function pointers

For more details, see the comments in include/linux/static_call.h.

[peterz: simplified interface]
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/Kconfig                      |    3 
 include/linux/static_call.h       |  134 ++++++++++++++++++++++++++++++++++++++
 include/linux/static_call_types.h |   15 ++++
 3 files changed, 152 insertions(+)
 create mode 100644 include/linux/static_call.h
 create mode 100644 include/linux/static_call_types.h

--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -960,6 +960,9 @@ config RELR
 config ARCH_HAS_MEM_ENCRYPT
 	bool
 
+config HAVE_STATIC_CALL
+	bool
+
 source "kernel/gcov/Kconfig"
 
 source "scripts/gcc-plugins/Kconfig"
--- /dev/null
+++ b/include/linux/static_call.h
@@ -0,0 +1,134 @@
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
+ *   DECLARE_STATIC_CALL(name, func);
+ *   DEFINE_STATIC_CALL(name, func);
+ *   static_call(name)(args...);
+ *   static_call_update(name, func);
+ *
+ * Usage example:
+ *
+ *   # Start with the following functions (with identical prototypes):
+ *   int func_a(int arg1, int arg2);
+ *   int func_b(int arg1, int arg2);
+ *
+ *   # Define a 'my_name' reference, associated with func_a() by default
+ *   DEFINE_STATIC_CALL(my_name, func_a);
+ *
+ *   # Call func_a()
+ *   static_call(my_name)(arg1, arg2);
+ *
+ *   # Update 'my_name' to point to func_b()
+ *   static_call_update(my_name, &func_b);
+ *
+ *   # Call func_b()
+ *   static_call(my_name)(arg1, arg2);
+ *
+ *
+ * Implementation details:
+ *
+ *    This requires some arch-specific code (CONFIG_HAVE_STATIC_CALL).
+ *    Otherwise basic indirect calls are used (with function pointers).
+ *
+ *    Each static_call() site calls into a trampoline associated with the name.
+ *    The trampoline has a direct branch to the default function.  Updates to a
+ *    name will modify the trampoline's branch destination.
+ *
+ *    If the arch has CONFIG_HAVE_STATIC_CALL_INLINE, then the call sites
+ *    themselves will be patched at runtime to call the functions directly,
+ *    rather than calling through the trampoline.  This requires objtool or a
+ *    compiler plugin to detect all the static_call() sites and annotate them
+ *    in the .static_call_sites section.
+ */
+
+#include <linux/types.h>
+#include <linux/cpu.h>
+#include <linux/static_call_types.h>
+
+#ifdef CONFIG_HAVE_STATIC_CALL
+#include <asm/static_call.h>
+/*
+ * Either @site or @tramp can be NULL.
+ */
+extern void arch_static_call_transform(void *site, void *tramp, void *func);
+#endif
+
+
+#define DECLARE_STATIC_CALL(name, func)					\
+	extern struct static_call_key STATIC_CALL_NAME(name);		\
+	extern typeof(func) STATIC_CALL_TRAMP(name)
+
+#define static_call_update(name, func)					\
+({									\
+	BUILD_BUG_ON(!__same_type(*(func), STATIC_CALL_TRAMP(name)));	\
+	__static_call_update(&STATIC_CALL_NAME(name),			\
+			     &STATIC_CALL_TRAMP(name), func);		\
+})
+
+#if defined(CONFIG_HAVE_STATIC_CALL)
+
+struct static_call_key {
+	void *func;
+};
+
+#define DEFINE_STATIC_CALL(name, _func)					\
+	DECLARE_STATIC_CALL(name, _func);				\
+	struct static_call_key STATIC_CALL_NAME(name) = {		\
+		.func = _func,						\
+	};								\
+	ARCH_DEFINE_STATIC_CALL_TRAMP(name, _func)
+
+#define static_call(name)	STATIC_CALL_TRAMP(name)
+
+static inline
+void __static_call_update(struct static_call_key *key, void *tramp, void *func)
+{
+	cpus_read_lock();
+	WRITE_ONCE(key->func, func);
+	arch_static_call_transform(NULL, tramp, func);
+	cpus_read_unlock();
+}
+
+#define EXPORT_STATIC_CALL(name)	EXPORT_SYMBOL(STATIC_CALL_TRAMP(name))
+#define EXPORT_STATIC_CALL_GPL(name)	EXPORT_SYMBOL_GPL(STATIC_CALL_TRAMP(name))
+
+#else /* Generic implementation */
+
+struct static_call_key {
+	void *func;
+};
+
+#define DEFINE_STATIC_CALL(name, _func)					\
+	DECLARE_STATIC_CALL(name, _func);				\
+	struct static_call_key STATIC_CALL_NAME(name) = {		\
+		.func = _func,						\
+	}
+
+#define static_call(name)						\
+	((typeof(STATIC_CALL_TRAMP(name))*)(STATIC_CALL_NAME(name).func))
+
+static inline
+void __static_call_update(struct static_call_key *key, void *tramp, void *func)
+{
+	WRITE_ONCE(key->func, func);
+}
+
+#define EXPORT_STATIC_CALL(name)	EXPORT_SYMBOL(STATIC_CALL_NAME(name))
+#define EXPORT_STATIC_CALL_GPL(key)	EXPORT_SYMBOL_GPL(STATIC_CALL_NAME(name))
+
+#endif /* CONFIG_HAVE_STATIC_CALL */
+
+#endif /* _LINUX_STATIC_CALL_H */
--- /dev/null
+++ b/include/linux/static_call_types.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _STATIC_CALL_TYPES_H
+#define _STATIC_CALL_TYPES_H
+
+#include <linux/stringify.h>
+
+#define STATIC_CALL_PREFIX	____static_call_
+#define STATIC_CALL_PREFIX_STR	__stringify(STATIC_CALL_PREFIX)
+
+#define STATIC_CALL_NAME(name)	__PASTE(STATIC_CALL_PREFIX, name)
+
+#define STATIC_CALL_TRAMP(name)	    STATIC_CALL_NAME(name##_tramp)
+#define STATIC_CALL_TRAMP_STR(name) __stringify(STATIC_CALL_TRAMP(name))
+
+#endif /* _STATIC_CALL_TYPES_H */


