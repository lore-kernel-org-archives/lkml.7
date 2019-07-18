Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB1C5C7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 01:03:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78DA92084C
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 01:03:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbfGSBD4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 21:03:56 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39333 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbfGSBDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 21:03:54 -0400
Received: by mail-pf1-f196.google.com with SMTP id f17so9401392pfn.6
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 18:03:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BFRTMBy/T287KKr1EphlvGaEMitjr/ADop0pSgXQir8=;
        b=QGH6L5FZhA/H/e2gdv2rxI1hmffLbuN1hmi4yarAm+6h2LzdSa3KrjV4lB3C8rD0fz
         07vC6Qy2MC/8b1gtHYobeEofo9ukuBsaBmxVRVBmZbVuAbuGjWL/KbhT7r20xnWgyKwa
         Ltqsrufk0VCEaPyRqmN7mnVJyV51NoUBDDteXMvSana3tn1Ma18OA6UlHUuxV6y8YUZO
         fcbj3HTbvA6QUa3CuV8TF+FaT1fV6R3FmSFzHGjViFF+H7CCqzIyXDLHbVpMTJpccWM5
         xs/Xy5GDroOA9KvkV71nYCY0yybcW64lpuqdzjh1rikkZCcyWhH+7WjVtiZdaX8t0boS
         DK3Q==
X-Gm-Message-State: APjAAAXzngI7qZlwy5i/gzmkf5WDNqQJewlWcP7xvLklS5oiHhW6paPM
        w/q6NL8Wa6E6awiGAKAtj0Y=
X-Google-Smtp-Source: APXvYqzzLKPHER1uEqA92MdUk6tVZjy29Gl7swrq1AQEEkKKFVpJnDEFcJlGqgASlJ7iJoCpQzs4Og==
X-Received: by 2002:a63:c302:: with SMTP id c2mr47895345pgd.300.1563498233551;
        Thu, 18 Jul 2019 18:03:53 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id q144sm28887612pfc.103.2019.07.18.18.03.52
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 18 Jul 2019 18:03:52 -0700 (PDT)
From:   Nadav Amit <namit@vmware.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Nadav Amit <namit@vmware.com>
Subject: [RFC 3/7] x86/percpu: Use C for percpu accesses when possible
Date:   Thu, 18 Jul 2019 10:41:06 -0700
Message-Id: <20190718174110.4635-4-namit@vmware.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190718174110.4635-1-namit@vmware.com>
References: <20190718174110.4635-1-namit@vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The percpu code mostly uses inline assembly. Using segment qualifiers
allows to use C code instead, which enables the compiler to perform
various optimizations (e.g., CSE). For example, in __schedule() the
following two instructions:

  mov    %gs:0x7e5f1eff(%rip),%edx        # 0x10350 <cpu_number>
  movslq %edx,%rdx

Turn with this patch into:

  movslq %gs:0x7e5f2e6e(%rip),%rax        # 0x10350 <cpu_number>

In addition, operations that have no guarantee against concurrent
interrupts or preemption, such as __this_cpu_cmpxchg() can be further
optimized by the compiler when they are implemented in C, for example
in call_timer_fn().

Signed-off-by: Nadav Amit <namit@vmware.com>
---
 arch/x86/include/asm/percpu.h  | 115 ++++++++++++++++++++++++++++++---
 arch/x86/include/asm/preempt.h |   3 +-
 2 files changed, 107 insertions(+), 11 deletions(-)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index 1fe348884477..13987f9bc82f 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -439,13 +439,88 @@ do {									\
  */
 #define this_cpu_read_stable(var)	percpu_stable_op("mov", var)
 
+#if USE_X86_SEG_SUPPORT
+
+#define __raw_cpu_read(qual, pcp)					\
+({									\
+	*(qual __my_cpu_type(pcp) *)__my_cpu_ptr(&(pcp));		\
+})
+
+#define __raw_cpu_write(qual, pcp, val)					\
+	do {								\
+		*(qual __my_cpu_type(pcp) *)__my_cpu_ptr(&(pcp)) = (val); \
+	} while (0)
+
+/*
+ * Performance-wise, C operations are only more efficient than their inline
+ * assembly counterparts for non-volatile variables (__this_*) and for volatile
+ * loads and stores.
+ *
+ * Since we do not use assembly, we are free to define 64-bit operations
+ * on 32-bit architecture
+ */
+#define __raw_cpu_add(pcp, val)		do { __my_cpu_var(pcp) += (val); } while (0)
+#define __raw_cpu_and(pcp, val)		do { __my_cpu_var(pcp) &= (val); } while (0)
+#define __raw_cpu_or(pcp, val)		do { __my_cpu_var(pcp) |= (val); } while (0)
+#define __raw_cpu_add_return(pcp, val)	({ __my_cpu_var(pcp) += (val); })
+
+#define __raw_cpu_xchg(pcp, val)					\
+({									\
+	typeof(pcp) pxo_ret__ = __my_cpu_var(pcp);			\
+									\
+	__my_cpu_var(pcp) = (val);					\
+	pxo_ret__;							\
+})
+
+#define __raw_cpu_cmpxchg(pcp, oval, nval)				\
+({									\
+	__my_cpu_type(pcp) *__p = __my_cpu_ptr(&(pcp));			\
+									\
+	typeof(pcp) __ret = *__p;					\
+									\
+	if (__ret == (oval))						\
+		*__p = nval;						\
+	__ret;								\
+})
+
+#define raw_cpu_read_1(pcp)		__raw_cpu_read(, pcp)
+#define raw_cpu_read_2(pcp)		__raw_cpu_read(, pcp)
+#define raw_cpu_read_4(pcp)		__raw_cpu_read(, pcp)
+#define raw_cpu_write_1(pcp, val)	__raw_cpu_write(, pcp, val)
+#define raw_cpu_write_2(pcp, val)	__raw_cpu_write(, pcp, val)
+#define raw_cpu_write_4(pcp, val)	__raw_cpu_write(, pcp, val)
+#define raw_cpu_add_1(pcp, val)		__raw_cpu_add(pcp, val)
+#define raw_cpu_add_2(pcp, val)		__raw_cpu_add(pcp, val)
+#define raw_cpu_add_4(pcp, val)		__raw_cpu_add(pcp, val)
+#define raw_cpu_and_1(pcp, val)		__raw_cpu_and(pcp, val)
+#define raw_cpu_and_2(pcp, val)		__raw_cpu_and(pcp, val)
+#define raw_cpu_and_4(pcp, val)		__raw_cpu_and(pcp, val)
+#define raw_cpu_or_1(pcp, val)		__raw_cpu_or(pcp, val)
+#define raw_cpu_or_2(pcp, val)		__raw_cpu_or(pcp, val)
+#define raw_cpu_or_4(pcp, val)		__raw_cpu_or(pcp, val)
+#define raw_cpu_xchg_1(pcp, val)	__raw_cpu_xchg(pcp, val)
+#define raw_cpu_xchg_2(pcp, val)	__raw_cpu_xchg(pcp, val)
+#define raw_cpu_xchg_4(pcp, val)	__raw_cpu_xchg(pcp, val)
+#define raw_cpu_add_return_1(pcp, val)	__raw_cpu_add_return(pcp, val)
+#define raw_cpu_add_return_2(pcp, val)	__raw_cpu_add_return(pcp, val)
+#define raw_cpu_add_return_4(pcp, val)	__raw_cpu_add_return(pcp, val)
+#define raw_cpu_add_return_8(pcp, val)		__raw_cpu_add_return(pcp, val)
+#define raw_cpu_cmpxchg_1(pcp, oval, nval)	__raw_cpu_cmpxchg(pcp, oval, nval)
+#define raw_cpu_cmpxchg_2(pcp, oval, nval)	__raw_cpu_cmpxchg(pcp, oval, nval)
+#define raw_cpu_cmpxchg_4(pcp, oval, nval)	__raw_cpu_cmpxchg(pcp, oval, nval)
+
+#define this_cpu_read_1(pcp)		__raw_cpu_read(volatile, pcp)
+#define this_cpu_read_2(pcp)		__raw_cpu_read(volatile, pcp)
+#define this_cpu_read_4(pcp)		__raw_cpu_read(volatile, pcp)
+#define this_cpu_write_1(pcp, val)	__raw_cpu_write(volatile, pcp, val)
+#define this_cpu_write_2(pcp, val)	__raw_cpu_write(volatile, pcp, val)
+#define this_cpu_write_4(pcp, val)	__raw_cpu_write(volatile, pcp, val)
+
+#else
 #define raw_cpu_read_1(pcp)		percpu_from_op(, "mov", pcp)
 #define raw_cpu_read_2(pcp)		percpu_from_op(, "mov", pcp)
 #define raw_cpu_read_4(pcp)		percpu_from_op(, "mov", pcp)
 
-#define raw_cpu_write_1(pcp, val)	percpu_to_op(, "mov", (pcp), val)
-#define raw_cpu_write_2(pcp, val)	percpu_to_op(, "mov", (pcp), val)
-#define raw_cpu_write_4(pcp, val)	percpu_to_op(, "mov", (pcp), val)
 #define raw_cpu_add_1(pcp, val)		percpu_add_op(, (pcp), val)
 #define raw_cpu_add_2(pcp, val)		percpu_add_op(, (pcp), val)
 #define raw_cpu_add_4(pcp, val)		percpu_add_op(, (pcp), val)
@@ -477,6 +552,14 @@ do {									\
 #define this_cpu_write_1(pcp, val)	percpu_to_op(volatile, "mov", (pcp), val)
 #define this_cpu_write_2(pcp, val)	percpu_to_op(volatile, "mov", (pcp), val)
 #define this_cpu_write_4(pcp, val)	percpu_to_op(volatile, "mov", (pcp), val)
+
+#define raw_cpu_add_return_1(pcp, val)		percpu_add_return_op(, pcp, val)
+#define raw_cpu_add_return_2(pcp, val)		percpu_add_return_op(, pcp, val)
+#define raw_cpu_add_return_4(pcp, val)		percpu_add_return_op(, pcp, val)
+#define raw_cpu_cmpxchg_1(pcp, oval, nval)	percpu_cmpxchg_op(, pcp, oval, nval)
+#define raw_cpu_cmpxchg_2(pcp, oval, nval)	percpu_cmpxchg_op(, pcp, oval, nval)
+#define raw_cpu_cmpxchg_4(pcp, oval, nval)	percpu_cmpxchg_op(, pcp, oval, nval)
+#endif
 #define this_cpu_add_1(pcp, val)	percpu_add_op(volatile, (pcp), val)
 #define this_cpu_add_2(pcp, val)	percpu_add_op(volatile, (pcp), val)
 #define this_cpu_add_4(pcp, val)	percpu_add_op(volatile, (pcp), val)
@@ -490,13 +573,6 @@ do {									\
 #define this_cpu_xchg_2(pcp, nval)	percpu_xchg_op(volatile, pcp, nval)
 #define this_cpu_xchg_4(pcp, nval)	percpu_xchg_op(volatile, pcp, nval)
 
-#define raw_cpu_add_return_1(pcp, val)		percpu_add_return_op(, pcp, val)
-#define raw_cpu_add_return_2(pcp, val)		percpu_add_return_op(, pcp, val)
-#define raw_cpu_add_return_4(pcp, val)		percpu_add_return_op(, pcp, val)
-#define raw_cpu_cmpxchg_1(pcp, oval, nval)	percpu_cmpxchg_op(, pcp, oval, nval)
-#define raw_cpu_cmpxchg_2(pcp, oval, nval)	percpu_cmpxchg_op(, pcp, oval, nval)
-#define raw_cpu_cmpxchg_4(pcp, oval, nval)	percpu_cmpxchg_op(, pcp, oval, nval)
-
 #define this_cpu_add_return_1(pcp, val)		percpu_add_return_op(volatile, pcp, val)
 #define this_cpu_add_return_2(pcp, val)		percpu_add_return_op(volatile, pcp, val)
 #define this_cpu_add_return_4(pcp, val)		percpu_add_return_op(volatile, pcp, val)
@@ -527,6 +603,22 @@ do {									\
  * 32 bit must fall back to generic operations.
  */
 #ifdef CONFIG_X86_64
+
+#if USE_X86_SEG_SUPPORT
+
+#define raw_cpu_read_8(pcp)			__raw_cpu_read(, pcp)
+#define raw_cpu_write_8(pcp, val)		__raw_cpu_write(, pcp, val)
+#define raw_cpu_add_8(pcp, val)			__raw_cpu_add(pcp, val)
+#define raw_cpu_and_8(pcp, val)			__raw_cpu_and(pcp, val)
+#define raw_cpu_or_8(pcp, val)			__raw_cpu_or(pcp, val)
+#define raw_cpu_xchg_8(pcp, nval)		__raw_cpu_xchg(pcp, nval)
+#define raw_cpu_cmpxchg_8(pcp, oval, nval)	__raw_cpu_cmpxchg(pcp, oval, nval)
+
+#define this_cpu_read_8(pcp)			__raw_cpu_read(volatile, pcp)
+#define this_cpu_write_8(pcp, val)		__raw_cpu_write(volatile, pcp, val)
+
+#else
+
 #define raw_cpu_read_8(pcp)			percpu_from_op(, "mov", pcp)
 #define raw_cpu_write_8(pcp, val)		percpu_to_op(, "mov", (pcp), val)
 #define raw_cpu_add_8(pcp, val)			percpu_add_op(, (pcp), val)
@@ -538,6 +630,9 @@ do {									\
 
 #define this_cpu_read_8(pcp)			percpu_from_op(volatile, "mov", pcp)
 #define this_cpu_write_8(pcp, val)		percpu_to_op(volatile, "mov", (pcp), val)
+
+#endif
+
 #define this_cpu_add_8(pcp, val)		percpu_add_op(volatile, (pcp), val)
 #define this_cpu_and_8(pcp, val)		percpu_to_op(volatile, "and", (pcp), val)
 #define this_cpu_or_8(pcp, val)			percpu_to_op(volatile, "or", (pcp), val)
diff --git a/arch/x86/include/asm/preempt.h b/arch/x86/include/asm/preempt.h
index 99a7fa9ab0a3..60f97b288004 100644
--- a/arch/x86/include/asm/preempt.h
+++ b/arch/x86/include/asm/preempt.h
@@ -91,7 +91,8 @@ static __always_inline void __preempt_count_sub(int val)
  */
 static __always_inline bool __preempt_count_dec_and_test(void)
 {
-	return GEN_UNARY_RMWcc("decl", __preempt_count, e, __percpu_arg([var]));
+	return GEN_UNARY_RMWcc("decl", __my_cpu_var(__preempt_count), e,
+			       __percpu_arg([var]));
 }
 
 /*
-- 
2.17.1

