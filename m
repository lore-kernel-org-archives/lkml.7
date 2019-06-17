Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16CCEC31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 22:20:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D27F420833
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 22:20:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="fCHFksyU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728932AbfFQWUy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 18:20:54 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37505 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728857AbfFQWUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 18:20:52 -0400
Received: by mail-ed1-f65.google.com with SMTP id w13so18450723eds.4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 15:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CEyjZ/OPRVDF8VCB3FogJp9F8HKrmkFa0mIitPxQ/tE=;
        b=fCHFksyUSUX8x+SUTeDgKSNDVgTkG/DDS10h/gz3h1WNF8WW9nfCxSKjVnkKUY0X4g
         KRmSfPEf0FCX0gdzjSwUW48WWu+5QqZgGG+vL3ape75s/akGO7Dw1FYN8BQYIu9Veoip
         LDilNWAy05t6N7HQ8IdRpv1l14pNMcU2Pwh5U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CEyjZ/OPRVDF8VCB3FogJp9F8HKrmkFa0mIitPxQ/tE=;
        b=Py08RAXgH+2rpMmyjtiydfBzSVlqE9y1MmDRYLKKoFekj2Xb9pitXBE85JvE5DEhsU
         sDZgw5FnnfscZcrO4V9+5M7AK6pqyHvDvMTx/n/v74ya/KECFlqRiEPH9emGHMYkGukm
         eL3pPCM0Hdwjb41V6pnjyWBrGNPr/bXDuaYmBjTgyex/41r286kPAzt97gfR9ykc39pK
         iXGQsmyYPcewT+MwyM2UyIG0lKj8mnTMcpJh35KZvBikDX8JOzXBPPhNIy5TyBGkfakR
         DRFtfV8d89TkY7RHJbdbFD9xGpnNl6l0g9dhCHGjD3jpStSPy0ZWqxdqrbsdpE5GT3M3
         s0MA==
X-Gm-Message-State: APjAAAVdsLwicmmUTRpPaGddwX6OzfVjaqnL56jTMsWF0KQxYSY65Lkz
        682wC/y+d/n4CJBNUKKCCmcsJHYC0rxuTOXU
X-Google-Smtp-Source: APXvYqyEI95X8UVGUaoKcwX+YMLzDP6YPn/iSxtDQq0PMPL0pifJv60KiTPtL+ht4OZau3AnmPrE+w==
X-Received: by 2002:a50:bd83:: with SMTP id y3mr105408665edh.120.1560810050438;
        Mon, 17 Jun 2019 15:20:50 -0700 (PDT)
Received: from prevas-ravi.prevas.se (ip-5-186-113-204.cgn.fibianet.dk. [5.186.113.204])
        by smtp.gmail.com with ESMTPSA id 9sm1034852ejg.49.2019.06.17.15.20.49
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 17 Jun 2019 15:20:50 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Jason Baron <jbaron@akamai.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v6 7/8] dynamic_debug: add asm-generic implementation for DYNAMIC_DEBUG_RELATIVE_POINTERS
Date:   Tue, 18 Jun 2019 00:20:33 +0200
Message-Id: <20190617222034.10799-8-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190617222034.10799-1-linux@rasmusvillemoes.dk>
References: <20190617222034.10799-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A 64 bit architecture can allow reducing the size of the kernel image by
selecting HAVE_DYNAMIC_DEBUG_RELATIVE_POINTERS, but it must provide
a proper DEFINE_DYNAMIC_DEBUG_METADATA macro for emitting the struct
_ddebug in assembly. However, since that does not involve any
instructions, this generic implementation should be usable by most if
not all.

It relies on

(1) standard assembly directives that should work on
all architectures
(2) the "i" constraint for an constant, and
(3) %cN emitting the constant operand N without punctuation

and of course the layout of _ddebug being what one expects.

Now, clang before 9.0 doesn't satisfy (3) for non-x86 targets.

Moreover, it turns out that gcc 4.8 in some corner cases emits (dead) code
which ends up causing the link to fail (emitting a reference to the
dynamic debug descriptor without emitting the assembly that defines
it).

Hence, make the config option available only for relatively new
compilers - I have not been able to reproduce the gcc problem with any
newer versions, and this implementation has been in -next for a whole
cycle without other problems reported.

I've succesfully built x86-64, arm64 and ppc64 defconfig +
CONFIG_DYNAMIC_DEBUG + patches to hook up this header, and boot-tested
the x86-64 one.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 include/asm-generic/dynamic_debug.h | 116 ++++++++++++++++++++++++++++
 include/linux/jump_label.h          |   2 +
 lib/Kconfig.debug                   |   5 +-
 3 files changed, 122 insertions(+), 1 deletion(-)
 create mode 100644 include/asm-generic/dynamic_debug.h

diff --git a/include/asm-generic/dynamic_debug.h b/include/asm-generic/dynamic_debug.h
new file mode 100644
index 000000000000..f1dd3019cd98
--- /dev/null
+++ b/include/asm-generic/dynamic_debug.h
@@ -0,0 +1,116 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_GENERIC_DYNAMIC_DEBUG_H
+#define _ASM_GENERIC_DYNAMIC_DEBUG_H
+
+#ifndef _DYNAMIC_DEBUG_H
+#error "don't include asm/dynamic_debug.h directly"
+#endif
+
+#include <linux/build_bug.h>
+#ifdef CONFIG_JUMP_LABEL
+#include <linux/jump_label.h>
+#endif
+
+/*
+ * We need to know the exact layout of struct _ddebug in order to
+ * initialize it in assembly. Check that all members are at expected
+ * offsets - if any of these fail, the arch cannot use this generic
+ * dynamic_debug.h. DYNAMIC_DEBUG_RELATIVE_POINTERS is pointless for
+ * !64BIT, so we expect the static_key to be at an 8-byte boundary
+ * since it contains stuff which is long-aligned.
+ */
+
+static_assert(BITS_PER_LONG == 64);
+static_assert(offsetof(struct _ddebug, modname_disp)  == 0);
+static_assert(offsetof(struct _ddebug, function_disp) == 4);
+static_assert(offsetof(struct _ddebug, filename_disp) == 8);
+static_assert(offsetof(struct _ddebug, format_disp)   == 12);
+static_assert(offsetof(struct _ddebug, flags_lineno)  == 16);
+
+#ifdef CONFIG_JUMP_LABEL
+static_assert(offsetof(struct _ddebug, key)        == 24);
+static_assert(offsetof(struct static_key, enabled) == 0);
+static_assert(offsetof(struct static_key, type)    == 8);
+
+/* <4 bytes padding>, .enabled, <4 bytes padding>, .type */
+# ifdef DEBUG
+# define _DPRINTK_ASM_KEY_INIT \
+	"\t.int 0\n" "\t.int 1\n" "\t.int 0\n" "\t.quad "__stringify(__JUMP_TYPE_TRUE)"\n"
+# else
+# define _DPRINTK_ASM_KEY_INIT \
+	"\t.int 0\n" "\t.int 0\n" "\t.int 0\n" "\t.quad "__stringify(__JUMP_TYPE_FALSE)"\n"
+# endif
+#else /* !CONFIG_JUMP_LABEL */
+#define _DPRINTK_ASM_KEY_INIT ""
+#endif
+
+/*
+ * There's a bit of magic involved here.
+ *
+ * First, unlike the bug table entries, we need to define an object in
+ * assembly which we can reference from C code (for use by the
+ * DYNAMIC_DEBUG_BRANCH macro), but we don't want 'name' to have
+ * external linkage (that would require use of globally unique
+ * identifiers, which we can't guarantee). Fortunately, the "extern"
+ * keyword just tells the compiler that _somebody_ provides that
+ * symbol - usually that somebody is the linker, but in this case it's
+ * the assembler, and since we do not do .globl name, the symbol gets
+ * internal linkage.
+ *
+ * So far so good. The next problem is that there's no scope in
+ * assembly, so the identifier 'name' has to be unique within each
+ * translation unit - otherwise all uses of that identifier end up
+ * referring to the same struct _ddebug instance. pr_debug and friends
+ * do this by use of indirection and __UNIQUE_ID(), and new users of
+ * DEFINE_DYNAMIC_DEBUG_METADATA() should do something similar. We
+ * need to catch cases where this is not done at build time.
+ *
+ * With assembly-level .ifndef we can ensure that we only define a
+ * given identifier once, preventing "symbol 'foo' already defined"
+ * errors. But we still need to detect and fail on multiple uses of
+ * the same identifer. The simplest, and wrong, solution to that is to
+ * add an .else .error branch to the .ifndef. The problem is that just
+ * because the DEFINE_DYNAMIC_DEBUG_METADATA() macro is only expanded
+ * once with a given identifier, the compiler may emit the assembly
+ * code multiple times, e.g. if the macro appears in an inline
+ * function. Now, in a normal case like
+ *
+ *   static inline get_next_id(void) { static int v; return ++v; }
+ *
+ * all inlined copies of get_next_id are _supposed_ to refer to the
+ * same object 'v'. So we do need to allow this chunk of assembly to
+ * appear multiple times with the same 'name', as long as they all
+ * came from the same DEFINE_DYNAMIC_DEBUG_METADATA() instance. To do
+ * that, we pass __COUNTER__ to the asm(), and set an assembler symbol
+ * name.ddebug.once to that value when we first define 'name'. When we
+ * meet a second attempt at defining 'name', we compare
+ * name.ddebug.once to %6 and error out if they are different.
+ */
+
+#define DEFINE_DYNAMIC_DEBUG_METADATA(name, fmt)			\
+	extern struct _ddebug name;					\
+	asm volatile(".ifndef " __stringify(name) "\n"			\
+		     ".pushsection __verbose,\"aw\"\n"			\
+		     ".type "__stringify(name)", STT_OBJECT\n"		\
+		     ".size "__stringify(name)", %c5\n"			\
+		     "1:\n"						\
+		     __stringify(name) ":\n"				\
+		     "\t.int %c0 - 1b /* _ddebug::modname_disp */\n"	\
+		     "\t.int %c1 - 1b /* _ddebug::function_disp */\n"	\
+		     "\t.int %c2 - 1b /* _ddebug::filename_disp */\n"	\
+		     "\t.int %c3 - 1b /* _ddebug::format_disp */\n"	\
+		     "\t.int %c4      /* _ddebug::flags_lineno */\n"	\
+		     _DPRINTK_ASM_KEY_INIT				\
+		     "\t.org 1b+%c5\n"					\
+		     ".popsection\n"					\
+		     ".set "__stringify(name)".ddebug.once, %c6\n"	\
+		     ".elseif "__stringify(name)".ddebug.once - %c6\n"	\
+		     ".line "__stringify(__LINE__) " - 1\n"             \
+		     ".error \"'"__stringify(name)"' used as _ddebug identifier more than once\"\n" \
+		     ".endif\n"						\
+		     : : "i" (KBUILD_MODNAME), "i" (__func__),		\
+		       "i" (__FILE__), "i" (fmt),			\
+		       "i" (_DPRINTK_FLAGS_LINENO_INIT),		\
+		       "i" (sizeof(struct _ddebug)), "i" (__COUNTER__))
+
+#endif /* _ASM_GENERIC_DYNAMIC_DEBUG_H */
diff --git a/include/linux/jump_label.h b/include/linux/jump_label.h
index 3e113a1fa0f1..2b027d2ef3d0 100644
--- a/include/linux/jump_label.h
+++ b/include/linux/jump_label.h
@@ -190,6 +190,8 @@ struct module;
 
 #ifdef CONFIG_JUMP_LABEL
 
+#define __JUMP_TYPE_FALSE	0
+#define __JUMP_TYPE_TRUE	1
 #define JUMP_TYPE_FALSE		0UL
 #define JUMP_TYPE_TRUE		1UL
 #define JUMP_TYPE_LINKED	2UL
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index f3d2e234c15f..7f2bc0175b88 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -171,11 +171,14 @@ config DYNAMIC_DEBUG_RELATIVE_POINTERS
 	bool "Reduce size of dynamic debug metadata"
 	depends on DYNAMIC_DEBUG
 	depends on HAVE_DYNAMIC_DEBUG_RELATIVE_POINTERS
+	depends on (GCC_VERSION >= 50000 || CLANG_VERSION >= 90000)
 	help
 	  If you say Y here, the static memory footprint of the kernel
 	  image will be reduced somewhat (about 40K for a typical
 	  distro kernel). There is no performance difference either
-	  way.
+	  way. This relies on some compile-time magic, so if your
+	  toolchain fails to build the kernel with this option, just
+	  say N.
 
 endmenu # "printk and dmesg options"
 
-- 
2.20.1

