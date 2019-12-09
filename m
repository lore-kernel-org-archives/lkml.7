Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 001E5C43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 22:30:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF7062071E
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 22:30:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q8FfRa48"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbfLIWah (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 17:30:37 -0500
Received: from mail-pl1-f201.google.com ([209.85.214.201]:55544 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726957AbfLIWah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 17:30:37 -0500
Received: by mail-pl1-f201.google.com with SMTP id 66so7952236plc.22
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 14:30:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=H8zY8HeBa5KgvYz/EjuIzaxJJDtXffnPSw98z/UW9TA=;
        b=q8FfRa48djMK3+hZG40gHYRHjkeKqFu1XPUjNxxhfhU8RuX03tiSXQ5xyK1rH1kMfi
         THyKYDjdclSsj0ohP6JqL4JBL2yw7Y0oJeK34d9Wn9TrmyquRgCBQj4xDJcPZ6j8cdVX
         Dc5vhfif04z8l5mi5kDyWBBOAWonV5jRToMcjJkCWjG94io2mNwFgtQ52TreEFXDAcv7
         Tm60QQvJvRKsrRNPkKgAOR8llDB3oEA4SRdLiHlsz0SgOFPvbeclKWPZmPDosbYYFqCe
         /Fh7DAko3mc7MOjh7rR0H0LSPx+LPUuGdnaGJ4VzQHGxiHabxiAIDQ0F06IHcTQnGvK7
         bQIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=H8zY8HeBa5KgvYz/EjuIzaxJJDtXffnPSw98z/UW9TA=;
        b=TLdku/Hg2oYHt4rH08EfNdrW69HZWHdldKM05uS8suo9Nr8B/ZEWSMPCY8AH+ywew3
         rCzDfduGu7asnGklMRCKlwu4+XRyKsFH8q954T3g/ZrhjMjIESImHHCGzSV3Y5vtN7iv
         Zt/8nMj8G2BahmgoA4MkiGo29KJzf88Oz/m/clPtvo4cP8ymzmifKapuhRnAbUpWNuZl
         XDu1/7hpfoR6+KwvMYIvIIa/LSNDksO6/k89mDxxN1BMCugU/B6/U4BcJ0qokVLZcnuw
         awqGuiKbs/8XlDY49b7qktm/FkaM3F2QsEsotiiJsZ1HjiSnConJb2p0IZknYARPs8rE
         mZ4g==
X-Gm-Message-State: APjAAAWp8sUgfK6GQlRbQI9Vauktw+a0Mm8vT1oMTwOpJcfmeBe82mov
        6AidR+mHsKEugHkQEYvMHcbKsoyctXL8cHzIogU=
X-Google-Smtp-Source: APXvYqwuF1WmX1BzBspd6h6vK8W97uJpf3NYCYCk359h3329pnhs3+m5+otdxZk1yHekVIIObM32DbRNR+l0TrS91ls=
X-Received: by 2002:a65:678f:: with SMTP id e15mr21151835pgr.130.1575930636283;
 Mon, 09 Dec 2019 14:30:36 -0800 (PST)
Date:   Mon,  9 Dec 2019 14:29:56 -0800
In-Reply-To: <20191209222956.239798-1-ndesaulniers@google.com>
Message-Id: <20191209222956.239798-3-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20191209222956.239798-1-ndesaulniers@google.com>
X-Mailer: git-send-email 2.24.0.393.g34dc348eaf-goog
Subject: [PATCH 2/2] hexagon: parenthesize registers in asm predicates
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     bcain@codeaurora.org
Cc:     Nick Desaulniers <ndesaulniers@google.com>, lee.jones@linaro.org,
        andriy.shevchenko@linux.intel.com, ztuowen@gmail.com,
        mika.westerberg@linux.intel.com, mcgrof@kernel.org,
        gregkh@linuxfoundation.org, alexios.zavras@intel.com,
        allison@lohutok.net, will@kernel.org, rfontana@redhat.com,
        tglx@linutronix.de, peterz@infradead.org, boqun.feng@gmail.com,
        mingo@redhat.com, akpm@linux-foundation.org, geert@linux-m68k.org,
        linux-hexagon@vger.kernel.org, clang-built-linux@googlegroups.com,
        linux-kernel@vger.kernel.org, Sid Manning <sidneym@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hexagon requires that register predicates in assembly be parenthesized.

Link: https://github.com/ClangBuiltLinux/linux/issues/754
Suggested-by: Sid Manning <sidneym@codeaurora.org>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 arch/hexagon/include/asm/atomic.h   |  8 ++++----
 arch/hexagon/include/asm/bitops.h   |  8 ++++----
 arch/hexagon/include/asm/cmpxchg.h  |  2 +-
 arch/hexagon/include/asm/futex.h    |  6 +++---
 arch/hexagon/include/asm/spinlock.h | 20 ++++++++++----------
 arch/hexagon/kernel/vm_entry.S      |  2 +-
 6 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/arch/hexagon/include/asm/atomic.h b/arch/hexagon/include/asm/atomic.h
index 12cd9231c4b8..0231d69c8bf2 100644
--- a/arch/hexagon/include/asm/atomic.h
+++ b/arch/hexagon/include/asm/atomic.h
@@ -91,7 +91,7 @@ static inline void atomic_##op(int i, atomic_t *v)			\
 		"1:	%0 = memw_locked(%1);\n"			\
 		"	%0 = "#op "(%0,%2);\n"				\
 		"	memw_locked(%1,P3)=%0;\n"			\
-		"	if !P3 jump 1b;\n"				\
+		"	if (!P3) jump 1b;\n"				\
 		: "=&r" (output)					\
 		: "r" (&v->counter), "r" (i)				\
 		: "memory", "p3"					\
@@ -107,7 +107,7 @@ static inline int atomic_##op##_return(int i, atomic_t *v)		\
 		"1:	%0 = memw_locked(%1);\n"			\
 		"	%0 = "#op "(%0,%2);\n"				\
 		"	memw_locked(%1,P3)=%0;\n"			\
-		"	if !P3 jump 1b;\n"				\
+		"	if (!P3) jump 1b;\n"				\
 		: "=&r" (output)					\
 		: "r" (&v->counter), "r" (i)				\
 		: "memory", "p3"					\
@@ -124,7 +124,7 @@ static inline int atomic_fetch_##op(int i, atomic_t *v)			\
 		"1:	%0 = memw_locked(%2);\n"			\
 		"	%1 = "#op "(%0,%3);\n"				\
 		"	memw_locked(%2,P3)=%1;\n"			\
-		"	if !P3 jump 1b;\n"				\
+		"	if (!P3) jump 1b;\n"				\
 		: "=&r" (output), "=&r" (val)				\
 		: "r" (&v->counter), "r" (i)				\
 		: "memory", "p3"					\
@@ -173,7 +173,7 @@ static inline int atomic_fetch_add_unless(atomic_t *v, int a, int u)
 		"	}"
 		"	memw_locked(%2, p3) = %1;"
 		"	{"
-		"		if !p3 jump 1b;"
+		"		if (!p3) jump 1b;"
 		"	}"
 		"2:"
 		: "=&r" (__oldval), "=&r" (tmp)
diff --git a/arch/hexagon/include/asm/bitops.h b/arch/hexagon/include/asm/bitops.h
index 47384b094b94..71429f756af0 100644
--- a/arch/hexagon/include/asm/bitops.h
+++ b/arch/hexagon/include/asm/bitops.h
@@ -38,7 +38,7 @@ static inline int test_and_clear_bit(int nr, volatile void *addr)
 	"1:	R12 = memw_locked(R10);\n"
 	"	{ P0 = tstbit(R12,R11); R12 = clrbit(R12,R11); }\n"
 	"	memw_locked(R10,P1) = R12;\n"
-	"	{if !P1 jump 1b; %0 = mux(P0,#1,#0);}\n"
+	"	{if (!P1) jump 1b; %0 = mux(P0,#1,#0);}\n"
 	: "=&r" (oldval)
 	: "r" (addr), "r" (nr)
 	: "r10", "r11", "r12", "p0", "p1", "memory"
@@ -62,7 +62,7 @@ static inline int test_and_set_bit(int nr, volatile void *addr)
 	"1:	R12 = memw_locked(R10);\n"
 	"	{ P0 = tstbit(R12,R11); R12 = setbit(R12,R11); }\n"
 	"	memw_locked(R10,P1) = R12;\n"
-	"	{if !P1 jump 1b; %0 = mux(P0,#1,#0);}\n"
+	"	{if (!P1) jump 1b; %0 = mux(P0,#1,#0);}\n"
 	: "=&r" (oldval)
 	: "r" (addr), "r" (nr)
 	: "r10", "r11", "r12", "p0", "p1", "memory"
@@ -88,7 +88,7 @@ static inline int test_and_change_bit(int nr, volatile void *addr)
 	"1:	R12 = memw_locked(R10);\n"
 	"	{ P0 = tstbit(R12,R11); R12 = togglebit(R12,R11); }\n"
 	"	memw_locked(R10,P1) = R12;\n"
-	"	{if !P1 jump 1b; %0 = mux(P0,#1,#0);}\n"
+	"	{if (!P1) jump 1b; %0 = mux(P0,#1,#0);}\n"
 	: "=&r" (oldval)
 	: "r" (addr), "r" (nr)
 	: "r10", "r11", "r12", "p0", "p1", "memory"
@@ -223,7 +223,7 @@ static inline int ffs(int x)
 	int r;
 
 	asm("{ P0 = cmp.eq(%1,#0); %0 = ct0(%1);}\n"
-		"{ if P0 %0 = #0; if !P0 %0 = add(%0,#1);}\n"
+		"{ if (P0) %0 = #0; if (!P0) %0 = add(%0,#1);}\n"
 		: "=&r" (r)
 		: "r" (x)
 		: "p0");
diff --git a/arch/hexagon/include/asm/cmpxchg.h b/arch/hexagon/include/asm/cmpxchg.h
index 6091322c3af9..92b8a02e588a 100644
--- a/arch/hexagon/include/asm/cmpxchg.h
+++ b/arch/hexagon/include/asm/cmpxchg.h
@@ -30,7 +30,7 @@ static inline unsigned long __xchg(unsigned long x, volatile void *ptr,
 	__asm__ __volatile__ (
 	"1:	%0 = memw_locked(%1);\n"    /*  load into retval */
 	"	memw_locked(%1,P0) = %2;\n" /*  store into memory */
-	"	if !P0 jump 1b;\n"
+	"	if (!P0) jump 1b;\n"
 	: "=&r" (retval)
 	: "r" (ptr), "r" (x)
 	: "memory", "p0"
diff --git a/arch/hexagon/include/asm/futex.h b/arch/hexagon/include/asm/futex.h
index cb635216a732..0191f7c7193e 100644
--- a/arch/hexagon/include/asm/futex.h
+++ b/arch/hexagon/include/asm/futex.h
@@ -16,7 +16,7 @@
 	    /* For example: %1 = %4 */ \
 	    insn \
 	"2: memw_locked(%3,p2) = %1;\n" \
-	"   if !p2 jump 1b;\n" \
+	"   if (!p2) jump 1b;\n" \
 	"   %1 = #0;\n" \
 	"3:\n" \
 	".section .fixup,\"ax\"\n" \
@@ -84,10 +84,10 @@ futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr, u32 oldval,
 	"1: %1 = memw_locked(%3)\n"
 	"   {\n"
 	"      p2 = cmp.eq(%1,%4)\n"
-	"      if !p2.new jump:NT 3f\n"
+	"      if (!p2.new) jump:NT 3f\n"
 	"   }\n"
 	"2: memw_locked(%3,p2) = %5\n"
-	"   if !p2 jump 1b\n"
+	"   if (!p2) jump 1b\n"
 	"3:\n"
 	".section .fixup,\"ax\"\n"
 	"4: %0 = #%6\n"
diff --git a/arch/hexagon/include/asm/spinlock.h b/arch/hexagon/include/asm/spinlock.h
index bfe07d842ff3..ef103b73bec8 100644
--- a/arch/hexagon/include/asm/spinlock.h
+++ b/arch/hexagon/include/asm/spinlock.h
@@ -30,9 +30,9 @@ static inline void arch_read_lock(arch_rwlock_t *lock)
 	__asm__ __volatile__(
 		"1:	R6 = memw_locked(%0);\n"
 		"	{ P3 = cmp.ge(R6,#0); R6 = add(R6,#1);}\n"
-		"	{ if !P3 jump 1b; }\n"
+		"	{ if (!P3) jump 1b; }\n"
 		"	memw_locked(%0,P3) = R6;\n"
-		"	{ if !P3 jump 1b; }\n"
+		"	{ if (!P3) jump 1b; }\n"
 		:
 		: "r" (&lock->lock)
 		: "memory", "r6", "p3"
@@ -46,7 +46,7 @@ static inline void arch_read_unlock(arch_rwlock_t *lock)
 		"1:	R6 = memw_locked(%0);\n"
 		"	R6 = add(R6,#-1);\n"
 		"	memw_locked(%0,P3) = R6\n"
-		"	if !P3 jump 1b;\n"
+		"	if (!P3) jump 1b;\n"
 		:
 		: "r" (&lock->lock)
 		: "memory", "r6", "p3"
@@ -61,7 +61,7 @@ static inline int arch_read_trylock(arch_rwlock_t *lock)
 	__asm__ __volatile__(
 		"	R6 = memw_locked(%1);\n"
 		"	{ %0 = #0; P3 = cmp.ge(R6,#0); R6 = add(R6,#1);}\n"
-		"	{ if !P3 jump 1f; }\n"
+		"	{ if (!P3) jump 1f; }\n"
 		"	memw_locked(%1,P3) = R6;\n"
 		"	{ %0 = P3 }\n"
 		"1:\n"
@@ -78,9 +78,9 @@ static inline void arch_write_lock(arch_rwlock_t *lock)
 	__asm__ __volatile__(
 		"1:	R6 = memw_locked(%0)\n"
 		"	{ P3 = cmp.eq(R6,#0);  R6 = #-1;}\n"
-		"	{ if !P3 jump 1b; }\n"
+		"	{ if (!P3) jump 1b; }\n"
 		"	memw_locked(%0,P3) = R6;\n"
-		"	{ if !P3 jump 1b; }\n"
+		"	{ if (!P3) jump 1b; }\n"
 		:
 		: "r" (&lock->lock)
 		: "memory", "r6", "p3"
@@ -94,7 +94,7 @@ static inline int arch_write_trylock(arch_rwlock_t *lock)
 	__asm__ __volatile__(
 		"	R6 = memw_locked(%1)\n"
 		"	{ %0 = #0; P3 = cmp.eq(R6,#0);  R6 = #-1;}\n"
-		"	{ if !P3 jump 1f; }\n"
+		"	{ if (!P3) jump 1f; }\n"
 		"	memw_locked(%1,P3) = R6;\n"
 		"	%0 = P3;\n"
 		"1:\n"
@@ -117,9 +117,9 @@ static inline void arch_spin_lock(arch_spinlock_t *lock)
 	__asm__ __volatile__(
 		"1:	R6 = memw_locked(%0);\n"
 		"	P3 = cmp.eq(R6,#0);\n"
-		"	{ if !P3 jump 1b; R6 = #1; }\n"
+		"	{ if (!P3) jump 1b; R6 = #1; }\n"
 		"	memw_locked(%0,P3) = R6;\n"
-		"	{ if !P3 jump 1b; }\n"
+		"	{ if (!P3) jump 1b; }\n"
 		:
 		: "r" (&lock->lock)
 		: "memory", "r6", "p3"
@@ -139,7 +139,7 @@ static inline unsigned int arch_spin_trylock(arch_spinlock_t *lock)
 	__asm__ __volatile__(
 		"	R6 = memw_locked(%1);\n"
 		"	P3 = cmp.eq(R6,#0);\n"
-		"	{ if !P3 jump 1f; R6 = #1; %0 = #0; }\n"
+		"	{ if (!P3) jump 1f; R6 = #1; %0 = #0; }\n"
 		"	memw_locked(%1,P3) = R6;\n"
 		"	%0 = P3;\n"
 		"1:\n"
diff --git a/arch/hexagon/kernel/vm_entry.S b/arch/hexagon/kernel/vm_entry.S
index 65a1ea0eed2f..554371d92bed 100644
--- a/arch/hexagon/kernel/vm_entry.S
+++ b/arch/hexagon/kernel/vm_entry.S
@@ -369,7 +369,7 @@ ret_from_fork:
 		R26.L = #LO(do_work_pending);
 		R0 = #VM_INT_DISABLE;
 	}
-	if P0 jump check_work_pending
+	if (P0) jump check_work_pending
 	{
 		R0 = R25;
 		callr R24
-- 
2.24.0.393.g34dc348eaf-goog

