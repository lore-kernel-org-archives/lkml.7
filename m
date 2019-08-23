Return-Path: <SRS0=py8C=WU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98128C3A5A3
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 06:05:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 622B62133F
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 06:05:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbfHXGFT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Aug 2019 02:05:19 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40794 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727346AbfHXGFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Aug 2019 02:05:18 -0400
Received: by mail-pg1-f193.google.com with SMTP id w10so7055583pgj.7
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 23:05:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BZ0RqVDzoSJHOg4NmUQ71MmjW4poj/lAzqqojt1Ihq0=;
        b=IZaERaeYOPOl1zqk0U2xO2/pAh2RoSiOLTWL9foEKrUZp2IqVBBdSx2pD1Du4P/mhI
         k1iwrO2hc7Lo+gZUbruU0ExlXmzzbt5kRuIYLXv5e6NJytvPHtYYNdR0pSX095cRWHoa
         41uCu7JHSLsGAt2yr7+ROyQIRKlDkFX52wuIiLfTKh5Wv5LyYc2AqU/9WPk+F33qxCsS
         H7Uy/zQNQ8p0ouvI7wWI/Bu7wh0GJ700cHcnjUcQO7+mfDW1EXDLLT7pnX8eZZpeXGk/
         u5EirNW//HoHNF1Dj7cCKB+7H563/SKlsy9MqRBmsd/7sqPoOyJDbV7uVcVEG35MWWPS
         Xeqg==
X-Gm-Message-State: APjAAAXYTNOqbu5D1N2W+u0NbhcuKd6OkPCg4dob7GzFKKehBEqhdd98
        6gD/dAQCZTj4ykDpnVS2RSA=
X-Google-Smtp-Source: APXvYqy1I65tnip7iCpEPwa+n05a92LlaG4tqicS4xzYSpje2+axGvt+NnBDEHsdJDAUi5dBmhrKxQ==
X-Received: by 2002:a62:388f:: with SMTP id f137mr9405209pfa.131.1566626716674;
        Fri, 23 Aug 2019 23:05:16 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id w2sm4300882pjr.27.2019.08.23.23.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2019 23:05:15 -0700 (PDT)
From:   Nadav Amit <namit@vmware.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Thomas Garnier <thgarnie@chromium.org>,
        Ingo Molnar <mingo@redhat.com>, Nadav Amit <namit@vmware.com>
Subject: [PATCH 3/7] x86/percpu: Use C for percpu accesses when possible
Date:   Fri, 23 Aug 2019 15:44:20 -0700
Message-Id: <20190823224424.15296-4-namit@vmware.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190823224424.15296-1-namit@vmware.com>
References: <20190823224424.15296-1-namit@vmware.com>
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
 arch/x86/include/asm/percpu.h | 115 +++++++++++++++++++++++++++++++---
 1 file changed, 105 insertions(+), 10 deletions(-)

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
-- 
2.17.1

