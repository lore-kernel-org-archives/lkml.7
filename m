Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E08F8C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 17:01:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A00C921882
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 17:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573232494;
	bh=6aq4krmlQOtVGPATClOa8Fm7XF3tB4IHE3ltvejjp2g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VqbOadKtOmISjt5zVR1AiOUVd2h4OgvE8/RmdtXpePh88cc44kUlxEtinSKMcF8iO
	 2g3Nltry7v4IUenzU7GlMsYN4s0bqH+XIwRXddiT4V8rTA/aYWN9krKDf/vP8ikd5y
	 DqwAiKheURbOLQKfPE7F6aThTYSpABRPi6RS8bPM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728981AbfKHRBd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 12:01:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:45264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726446AbfKHRBc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 12:01:32 -0500
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8535A21924;
        Fri,  8 Nov 2019 17:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573232491;
        bh=6aq4krmlQOtVGPATClOa8Fm7XF3tB4IHE3ltvejjp2g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rAp8+pfSHyAKMWwMUX1kXVK/rRRkoyX+WefmfqDcQAq87edQqp7jzG/aYeADWbJhp
         wskI4DwW39SToUGlrlpEDkgcrfTvm3QyjCR/PMXfqRUZO5o0S9FCACer1m8H+1XG9b
         EvzS8Q4zML9Bcks3lSSbW6l3d87OkcafbXUJVmS4=
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Will Deacon <will@kernel.org>, Yunjae Lee <lyj7694@gmail.com>,
        SeongJae Park <sj38.park@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Matt Turner <mattst88@gmail.com>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Richard Henderson <rth@twiddle.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Joe Perches <joe@perches.com>,
        Boqun Feng <boqun.feng@gmail.com>, linux-alpha@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH 01/13] compiler.h: Split {READ,WRITE}_ONCE definitions out into rwonce.h
Date:   Fri,  8 Nov 2019 17:01:08 +0000
Message-Id: <20191108170120.22331-2-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191108170120.22331-1-will@kernel.org>
References: <20191108170120.22331-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for allowing architectures to define their own
implementation of the 'READ_ONCE()' macro, move the generic
'{READ,WRITE}_ONCE()' definitions out of the unwieldy 'linux/compiler.h'
and into a new 'rwonce.h' header under 'asm-generic'.

Signed-off-by: Will Deacon <will@kernel.org>
---
 include/asm-generic/Kbuild          |   1 +
 include/asm-generic/rwonce.h        | 110 +++++++++++++++++++++++++++
 include/linux/compiler.h            | 114 +---------------------------
 include/linux/compiler_attributes.h |  12 +++
 4 files changed, 125 insertions(+), 112 deletions(-)
 create mode 100644 include/asm-generic/rwonce.h

diff --git a/include/asm-generic/Kbuild b/include/asm-generic/Kbuild
index adff14fcb8e4..2a7a1e94d4cb 100644
--- a/include/asm-generic/Kbuild
+++ b/include/asm-generic/Kbuild
@@ -4,4 +4,5 @@
 # (This file is not included when SRCARCH=um since UML borrows several
 # asm headers from the host architecutre.)
 
+mandatory-y += rwonce.h
 mandatory-y += simd.h
diff --git a/include/asm-generic/rwonce.h b/include/asm-generic/rwonce.h
new file mode 100644
index 000000000000..d189455ae038
--- /dev/null
+++ b/include/asm-generic/rwonce.h
@@ -0,0 +1,110 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Prevent the compiler from merging or refetching reads or writes. The
+ * compiler is also forbidden from reordering successive instances of
+ * READ_ONCE and WRITE_ONCE, but only when the compiler is aware of some
+ * particular ordering. One way to make the compiler aware of ordering is to
+ * put the two invocations of READ_ONCE or WRITE_ONCE in different C
+ * statements.
+ *
+ * These two macros will also work on aggregate data types like structs or
+ * unions. If the size of the accessed data type exceeds the word size of
+ * the machine (e.g., 32 bits or 64 bits) READ_ONCE() and WRITE_ONCE() will
+ * fall back to memcpy(). There's at least two memcpy()s: one for the
+ * __builtin_memcpy() and then one for the macro doing the copy of variable
+ * - '__u' allocated on the stack.
+ *
+ * Their two major use cases are: (1) Mediating communication between
+ * process-level code and irq/NMI handlers, all running on the same CPU,
+ * and (2) Ensuring that the compiler does not fold, spindle, or otherwise
+ * mutilate accesses that either do not require ordering or that interact
+ * with an explicit memory barrier or atomic instruction that provides the
+ * required ordering.
+ */
+#ifndef __ASM_GENERIC_RWONCE_H
+#define __ASM_GENERIC_RWONCE_H
+
+#ifndef __ASSEMBLY__
+
+#include <linux/compiler_attributes.h>
+#include <linux/kasan-checks.h>
+
+#include <uapi/linux/types.h>
+
+#include <asm/barrier.h>
+
+#define __READ_ONCE_SIZE						\
+({									\
+	switch (size) {							\
+	case 1: *(__u8 *)res = *(volatile __u8 *)p; break;		\
+	case 2: *(__u16 *)res = *(volatile __u16 *)p; break;		\
+	case 4: *(__u32 *)res = *(volatile __u32 *)p; break;		\
+	case 8: *(__u64 *)res = *(volatile __u64 *)p; break;		\
+	default:							\
+		barrier();						\
+		__builtin_memcpy((void *)res, (const void *)p, size);	\
+		barrier();						\
+	}								\
+})
+
+static __always_inline
+void __read_once_size(const volatile void *p, void *res, int size)
+{
+	__READ_ONCE_SIZE;
+}
+
+static __no_kasan_or_inline
+void __read_once_size_nocheck(const volatile void *p, void *res, int size)
+{
+	__READ_ONCE_SIZE;
+}
+
+static __always_inline void __write_once_size(volatile void *p, void *res, int size)
+{
+	switch (size) {
+	case 1: *(volatile __u8 *)p = *(__u8 *)res; break;
+	case 2: *(volatile __u16 *)p = *(__u16 *)res; break;
+	case 4: *(volatile __u32 *)p = *(__u32 *)res; break;
+	case 8: *(volatile __u64 *)p = *(__u64 *)res; break;
+	default:
+		barrier();
+		__builtin_memcpy((void *)p, (const void *)res, size);
+		barrier();
+	}
+}
+
+#define __READ_ONCE(x, check)						\
+({									\
+	union { typeof(x) __val; char __c[1]; } __u;			\
+	if (check)							\
+		__read_once_size(&(x), __u.__c, sizeof(x));		\
+	else								\
+		__read_once_size_nocheck(&(x), __u.__c, sizeof(x));	\
+	smp_read_barrier_depends(); /* Enforce dependency ordering from x */ \
+	__u.__val;							\
+})
+#define READ_ONCE(x) __READ_ONCE(x, 1)
+
+/*
+ * Use READ_ONCE_NOCHECK() instead of READ_ONCE() if you need
+ * to hide memory access from KASAN.
+ */
+#define READ_ONCE_NOCHECK(x) __READ_ONCE(x, 0)
+
+static __no_kasan_or_inline
+unsigned long read_word_at_a_time(const void *addr)
+{
+	kasan_check_read(addr, 1);
+	return *(unsigned long *)addr;
+}
+
+#define WRITE_ONCE(x, val) \
+({							\
+	union { typeof(x) __val; char __c[1]; } __u =	\
+		{ .__val = (__force typeof(x)) (val) }; \
+	__write_once_size(&(x), __u.__c, sizeof(x));	\
+	__u.__val;					\
+})
+
+#endif /* __ASSEMBLY__ */
+#endif	/* __ASM_GENERIC_RWONCE_H */
diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 5e88e7e33abe..6de09d2f42ad 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -177,118 +177,6 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 # define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __LINE__)
 #endif
 
-#include <uapi/linux/types.h>
-
-#define __READ_ONCE_SIZE						\
-({									\
-	switch (size) {							\
-	case 1: *(__u8 *)res = *(volatile __u8 *)p; break;		\
-	case 2: *(__u16 *)res = *(volatile __u16 *)p; break;		\
-	case 4: *(__u32 *)res = *(volatile __u32 *)p; break;		\
-	case 8: *(__u64 *)res = *(volatile __u64 *)p; break;		\
-	default:							\
-		barrier();						\
-		__builtin_memcpy((void *)res, (const void *)p, size);	\
-		barrier();						\
-	}								\
-})
-
-static __always_inline
-void __read_once_size(const volatile void *p, void *res, int size)
-{
-	__READ_ONCE_SIZE;
-}
-
-#ifdef CONFIG_KASAN
-/*
- * We can't declare function 'inline' because __no_sanitize_address confilcts
- * with inlining. Attempt to inline it may cause a build failure.
- * 	https://gcc.gnu.org/bugzilla/show_bug.cgi?id=67368
- * '__maybe_unused' allows us to avoid defined-but-not-used warnings.
- */
-# define __no_kasan_or_inline __no_sanitize_address notrace __maybe_unused
-#else
-# define __no_kasan_or_inline __always_inline
-#endif
-
-static __no_kasan_or_inline
-void __read_once_size_nocheck(const volatile void *p, void *res, int size)
-{
-	__READ_ONCE_SIZE;
-}
-
-static __always_inline void __write_once_size(volatile void *p, void *res, int size)
-{
-	switch (size) {
-	case 1: *(volatile __u8 *)p = *(__u8 *)res; break;
-	case 2: *(volatile __u16 *)p = *(__u16 *)res; break;
-	case 4: *(volatile __u32 *)p = *(__u32 *)res; break;
-	case 8: *(volatile __u64 *)p = *(__u64 *)res; break;
-	default:
-		barrier();
-		__builtin_memcpy((void *)p, (const void *)res, size);
-		barrier();
-	}
-}
-
-/*
- * Prevent the compiler from merging or refetching reads or writes. The
- * compiler is also forbidden from reordering successive instances of
- * READ_ONCE and WRITE_ONCE, but only when the compiler is aware of some
- * particular ordering. One way to make the compiler aware of ordering is to
- * put the two invocations of READ_ONCE or WRITE_ONCE in different C
- * statements.
- *
- * These two macros will also work on aggregate data types like structs or
- * unions. If the size of the accessed data type exceeds the word size of
- * the machine (e.g., 32 bits or 64 bits) READ_ONCE() and WRITE_ONCE() will
- * fall back to memcpy(). There's at least two memcpy()s: one for the
- * __builtin_memcpy() and then one for the macro doing the copy of variable
- * - '__u' allocated on the stack.
- *
- * Their two major use cases are: (1) Mediating communication between
- * process-level code and irq/NMI handlers, all running on the same CPU,
- * and (2) Ensuring that the compiler does not fold, spindle, or otherwise
- * mutilate accesses that either do not require ordering or that interact
- * with an explicit memory barrier or atomic instruction that provides the
- * required ordering.
- */
-#include <asm/barrier.h>
-#include <linux/kasan-checks.h>
-
-#define __READ_ONCE(x, check)						\
-({									\
-	union { typeof(x) __val; char __c[1]; } __u;			\
-	if (check)							\
-		__read_once_size(&(x), __u.__c, sizeof(x));		\
-	else								\
-		__read_once_size_nocheck(&(x), __u.__c, sizeof(x));	\
-	smp_read_barrier_depends(); /* Enforce dependency ordering from x */ \
-	__u.__val;							\
-})
-#define READ_ONCE(x) __READ_ONCE(x, 1)
-
-/*
- * Use READ_ONCE_NOCHECK() instead of READ_ONCE() if you need
- * to hide memory access from KASAN.
- */
-#define READ_ONCE_NOCHECK(x) __READ_ONCE(x, 0)
-
-static __no_kasan_or_inline
-unsigned long read_word_at_a_time(const void *addr)
-{
-	kasan_check_read(addr, 1);
-	return *(unsigned long *)addr;
-}
-
-#define WRITE_ONCE(x, val) \
-({							\
-	union { typeof(x) __val; char __c[1]; } __u =	\
-		{ .__val = (__force typeof(x)) (val) }; \
-	__write_once_size(&(x), __u.__c, sizeof(x));	\
-	__u.__val;					\
-})
-
 #endif /* __KERNEL__ */
 
 /*
@@ -356,4 +244,6 @@ static inline void *offset_to_ptr(const int *off)
 /* &a[0] degrades to a pointer: a different type from an array */
 #define __must_be_array(a)	BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
 
+#include <asm/rwonce.h>
+
 #endif /* __LINUX_COMPILER_H */
diff --git a/include/linux/compiler_attributes.h b/include/linux/compiler_attributes.h
index cdf016596659..7cb92286de9f 100644
--- a/include/linux/compiler_attributes.h
+++ b/include/linux/compiler_attributes.h
@@ -270,4 +270,16 @@
  */
 #define __weak                          __attribute__((__weak__))
 
+#ifdef CONFIG_KASAN
+/*
+ * We can't declare function 'inline' because __no_sanitize_address confilcts
+ * with inlining. Attempt to inline it may cause a build failure.
+ * 	https://gcc.gnu.org/bugzilla/show_bug.cgi?id=67368
+ * '__maybe_unused' allows us to avoid defined-but-not-used warnings.
+ */
+# define __no_kasan_or_inline __no_sanitize_address notrace __maybe_unused
+#else
+# define __no_kasan_or_inline __always_inline
+#endif
+
 #endif /* __LINUX_COMPILER_ATTRIBUTES_H */
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

