Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29E14C282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:30:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA16520449
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:30:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="f1DjX9pR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbfDSSaH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:30:07 -0400
Received: from mail.efficios.com ([167.114.142.138]:38607 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727905AbfDSSaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:30:03 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 778FA1D9905;
        Fri, 19 Apr 2019 10:53:35 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id gZQSW0OyLaqL; Fri, 19 Apr 2019 10:53:34 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 507841D98FE;
        Fri, 19 Apr 2019 10:53:34 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 507841D98FE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1555685614;
        bh=hErcMdnSpUv2p3dd/YlCqcD31et9obliClDrjlVFl8Q=;
        h=From:To:Date:Message-Id;
        b=f1DjX9pRg+QcClDWDusuf1II6YifiGFiJb5vwRMPs4ALEK2RkEG4iP7xo4iecZ9aK
         JdjNnei/LXMm++upEB1wNfK1lBWjUixR5IVRQNIz5+Na7eZciJyvr0GLRrn39TUlU9
         qe/5npYkbMEeZzS8ga93nFXy/uEW3aS32TMCel4pZc6TJ6rMGVqbOJfj3Mz4BZmKyN
         r17rd4Nu9XkORgWao8czWi5IGVuFllPoKtTrOpYfDdNSOlQfAIawABTxfm81KH0AZW
         K/bASN0kd27bdbQwzz98bSBAUxaLEWAUi88+CiidX/PSzzb5iTNSJj9XaNMcTHsL55
         Ahv/SwnGFrC6w==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id mcN2FEZfVl5l; Fri, 19 Apr 2019 10:53:34 -0400 (EDT)
Received: from localhost.localdomain (192-222-157-41.qc.cable.ebox.net [192.222.157.41])
        by mail.efficios.com (Postfix) with ESMTPSA id CC7F01D98F7;
        Fri, 19 Apr 2019 10:53:33 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Ingo Molnar <mingo@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joel Fernandes <joelaf@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Watson <davejwatson@fb.com>,
        Will Deacon <will.deacon@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        Andi Kleen <andi@firstfloor.org>,
        linux-kselftest@vger.kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Chris Lameter <cl@linux.com>,
        Russell King <linux@arm.linux.org.uk>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Paul Turner <pjt@google.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Maurer <bmaurer@fb.com>, linux-api@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH] rseq/selftests: x86: Work-around bogus gcc-8 optimisation
Date:   Fri, 19 Apr 2019 10:53:27 -0400
Message-Id: <20190419145327.12736-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At least the following versions of gcc-8:
- gcc version 8.0.1 20180414 (experimental) [trunk revision 259383] (Ubuntu 8-20180414-1ubuntu2)
- gcc 8.2.0-7ubuntu1 (Ubuntu 18.10 (Cosmic)),

generate broken assembler with asm goto that have a thread-local storage
"m" input operand on both x86-32 and x86-64. For instance:

__thread int var;

static int fct(void)
{
        asm goto (      "jmp %l[testlabel]\n\t"
                        : : [var] "m" (var) : : testlabel);
        return 0;
testlabel:
        return 1;
}

int main()
{
        return fct();
}

% gcc-8 -O2 -o test-asm-goto test-asm-goto.c
/tmp/ccAdHJbe.o: In function `main':
test-asm-goto.c:(.text.startup+0x1): undefined reference to `.L2'
collect2: error: ld returned 1 exit status

% gcc-8 -m32 -O2 -o test-asm-goto test-asm-goto.c
/tmp/ccREsVXA.o: In function `main':
test-asm-goto.c:(.text.startup+0x1): undefined reference to `.L2'
collect2: error: ld returned 1 exit status

Work-around this compiler bug in the rseq-x86.h header by passing the
address of the __rseq_abi TLS as a register operand rather than using
the "m" input operand.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC: Ingo Molnar <mingo@redhat.com>
CC: Peter Zijlstra <peterz@infradead.org>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Joel Fernandes <joelaf@google.com>
CC: Catalin Marinas <catalin.marinas@arm.com>
CC: Dave Watson <davejwatson@fb.com>
CC: Will Deacon <will.deacon@arm.com>
CC: Shuah Khan <shuah@kernel.org>
CC: Andi Kleen <andi@firstfloor.org>
CC: linux-kselftest@vger.kernel.org
CC: "H . Peter Anvin" <hpa@zytor.com>
CC: Chris Lameter <cl@linux.com>
CC: Russell King <linux@arm.linux.org.uk>
CC: Michael Kerrisk <mtk.manpages@gmail.com>
CC: "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>
CC: Paul Turner <pjt@google.com>
CC: Boqun Feng <boqun.feng@gmail.com>
CC: Josh Triplett <josh@joshtriplett.org>
CC: Steven Rostedt <rostedt@goodmis.org>
CC: Ben Maurer <bmaurer@fb.com>
CC: linux-api@vger.kernel.org
CC: Andy Lutomirski <luto@amacapital.net>
CC: Andrew Morton <akpm@linux-foundation.org>
CC: Linus Torvalds <torvalds@linux-foundation.org>
---
 tools/testing/selftests/rseq/rseq-x86.h | 144 ++++++++++++------------
 1 file changed, 70 insertions(+), 74 deletions(-)

diff --git a/tools/testing/selftests/rseq/rseq-x86.h b/tools/testing/selftests/rseq/rseq-x86.h
index 1780faf30f28..b2da6004fe30 100644
--- a/tools/testing/selftests/rseq/rseq-x86.h
+++ b/tools/testing/selftests/rseq/rseq-x86.h
@@ -16,6 +16,16 @@
  */
 #define RSEQ_SIG	0x53053053
 
+/*
+ * Due to a compiler optimization bug in gcc-8 with asm goto and TLS asm input
+ * operands, we cannot use "m" input operands, and rather pass the __rseq_abi
+ * address through a "r" input operand.
+ */
+
+/* Offset of cpu_id and rseq_cs fields in struct rseq. */
+#define RSEQ_CPU_ID_OFFSET	4
+#define RSEQ_CS_OFFSET		8
+
 #ifdef __x86_64__
 
 #define rseq_smp_mb()	\
@@ -75,12 +85,12 @@ do {									\
 #define RSEQ_ASM_STORE_RSEQ_CS(label, cs_label, rseq_cs)		\
 		RSEQ_INJECT_ASM(1)					\
 		"leaq " __rseq_str(cs_label) "(%%rip), %%rax\n\t"	\
-		"movq %%rax, %[" __rseq_str(rseq_cs) "]\n\t"		\
+		"movq %%rax, " __rseq_str(rseq_cs) "\n\t"		\
 		__rseq_str(label) ":\n\t"
 
 #define RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, label)		\
 		RSEQ_INJECT_ASM(2)					\
-		"cmpl %[" __rseq_str(cpu_id) "], %[" __rseq_str(current_cpu_id) "]\n\t" \
+		"cmpl %[" __rseq_str(cpu_id) "], " __rseq_str(current_cpu_id) "\n\t" \
 		"jnz " __rseq_str(label) "\n\t"
 
 #define RSEQ_ASM_DEFINE_ABORT(label, teardown, abort_label)		\
@@ -113,14 +123,14 @@ int rseq_cmpeqv_storev(intptr_t *v, intptr_t expect, intptr_t newv, int cpu)
 		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
 #endif
 		/* Start rseq by storing table entry pointer into rseq_cs. */
-		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, rseq_cs)
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, RSEQ_CS_OFFSET(%[rseq_abi]))
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_CPU_ID_OFFSET(%[rseq_abi]), 4f)
 		RSEQ_INJECT_ASM(3)
 		"cmpq %[v], %[expect]\n\t"
 		"jnz %l[cmpfail]\n\t"
 		RSEQ_INJECT_ASM(4)
 #ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_CPU_ID_OFFSET(%[rseq_abi]), %l[error1])
 		"cmpq %[v], %[expect]\n\t"
 		"jnz %l[error2]\n\t"
 #endif
@@ -131,8 +141,7 @@ int rseq_cmpeqv_storev(intptr_t *v, intptr_t expect, intptr_t newv, int cpu)
 		RSEQ_ASM_DEFINE_ABORT(4, "", abort)
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
-		  [current_cpu_id]	"m" (__rseq_abi.cpu_id),
-		  [rseq_cs]		"m" (__rseq_abi.rseq_cs),
+		  [rseq_abi]		"r" (&__rseq_abi),
 		  [v]			"m" (*v),
 		  [expect]		"r" (expect),
 		  [newv]		"r" (newv)
@@ -175,15 +184,15 @@ int rseq_cmpnev_storeoffp_load(intptr_t *v, intptr_t expectnot,
 		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
 #endif
 		/* Start rseq by storing table entry pointer into rseq_cs. */
-		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, rseq_cs)
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, RSEQ_CS_OFFSET(%[rseq_abi]))
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_CPU_ID_OFFSET(%[rseq_abi]), 4f)
 		RSEQ_INJECT_ASM(3)
 		"movq %[v], %%rbx\n\t"
 		"cmpq %%rbx, %[expectnot]\n\t"
 		"je %l[cmpfail]\n\t"
 		RSEQ_INJECT_ASM(4)
 #ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_CPU_ID_OFFSET(%[rseq_abi]), %l[error1])
 		"movq %[v], %%rbx\n\t"
 		"cmpq %%rbx, %[expectnot]\n\t"
 		"je %l[error2]\n\t"
@@ -198,8 +207,7 @@ int rseq_cmpnev_storeoffp_load(intptr_t *v, intptr_t expectnot,
 		RSEQ_ASM_DEFINE_ABORT(4, "", abort)
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
-		  [current_cpu_id]	"m" (__rseq_abi.cpu_id),
-		  [rseq_cs]		"m" (__rseq_abi.rseq_cs),
+		  [rseq_abi]		"r" (&__rseq_abi),
 		  /* final store input */
 		  [v]			"m" (*v),
 		  [expectnot]		"r" (expectnot),
@@ -237,11 +245,11 @@ int rseq_addv(intptr_t *v, intptr_t count, int cpu)
 		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
 #endif
 		/* Start rseq by storing table entry pointer into rseq_cs. */
-		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, rseq_cs)
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, RSEQ_CS_OFFSET(%[rseq_abi]))
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_CPU_ID_OFFSET(%[rseq_abi]), 4f)
 		RSEQ_INJECT_ASM(3)
 #ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_CPU_ID_OFFSET(%[rseq_abi]), %l[error1])
 #endif
 		/* final store */
 		"addq %[count], %[v]\n\t"
@@ -250,8 +258,7 @@ int rseq_addv(intptr_t *v, intptr_t count, int cpu)
 		RSEQ_ASM_DEFINE_ABORT(4, "", abort)
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
-		  [current_cpu_id]	"m" (__rseq_abi.cpu_id),
-		  [rseq_cs]		"m" (__rseq_abi.rseq_cs),
+		  [rseq_abi]		"r" (&__rseq_abi),
 		  /* final store input */
 		  [v]			"m" (*v),
 		  [count]		"er" (count)
@@ -287,14 +294,14 @@ int rseq_cmpeqv_trystorev_storev(intptr_t *v, intptr_t expect,
 		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
 #endif
 		/* Start rseq by storing table entry pointer into rseq_cs. */
-		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, rseq_cs)
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, RSEQ_CS_OFFSET(%[rseq_abi]))
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_CPU_ID_OFFSET(%[rseq_abi]), 4f)
 		RSEQ_INJECT_ASM(3)
 		"cmpq %[v], %[expect]\n\t"
 		"jnz %l[cmpfail]\n\t"
 		RSEQ_INJECT_ASM(4)
 #ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_CPU_ID_OFFSET(%[rseq_abi]), %l[error1])
 		"cmpq %[v], %[expect]\n\t"
 		"jnz %l[error2]\n\t"
 #endif
@@ -308,8 +315,7 @@ int rseq_cmpeqv_trystorev_storev(intptr_t *v, intptr_t expect,
 		RSEQ_ASM_DEFINE_ABORT(4, "", abort)
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
-		  [current_cpu_id]	"m" (__rseq_abi.cpu_id),
-		  [rseq_cs]		"m" (__rseq_abi.rseq_cs),
+		  [rseq_abi]		"r" (&__rseq_abi),
 		  /* try store input */
 		  [v2]			"m" (*v2),
 		  [newv2]		"r" (newv2),
@@ -363,8 +369,8 @@ int rseq_cmpeqv_cmpeqv_storev(intptr_t *v, intptr_t expect,
 		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error3])
 #endif
 		/* Start rseq by storing table entry pointer into rseq_cs. */
-		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, rseq_cs)
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, RSEQ_CS_OFFSET(%[rseq_abi]))
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_CPU_ID_OFFSET(%[rseq_abi]), 4f)
 		RSEQ_INJECT_ASM(3)
 		"cmpq %[v], %[expect]\n\t"
 		"jnz %l[cmpfail]\n\t"
@@ -373,7 +379,7 @@ int rseq_cmpeqv_cmpeqv_storev(intptr_t *v, intptr_t expect,
 		"jnz %l[cmpfail]\n\t"
 		RSEQ_INJECT_ASM(5)
 #ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_CPU_ID_OFFSET(%[rseq_abi]), %l[error1])
 		"cmpq %[v], %[expect]\n\t"
 		"jnz %l[error2]\n\t"
 		"cmpq %[v2], %[expect2]\n\t"
@@ -386,8 +392,7 @@ int rseq_cmpeqv_cmpeqv_storev(intptr_t *v, intptr_t expect,
 		RSEQ_ASM_DEFINE_ABORT(4, "", abort)
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
-		  [current_cpu_id]	"m" (__rseq_abi.cpu_id),
-		  [rseq_cs]		"m" (__rseq_abi.rseq_cs),
+		  [rseq_abi]		"r" (&__rseq_abi),
 		  /* cmp2 input */
 		  [v2]			"m" (*v2),
 		  [expect2]		"r" (expect2),
@@ -438,14 +443,14 @@ int rseq_cmpeqv_trymemcpy_storev(intptr_t *v, intptr_t expect,
 		"movq %[dst], %[rseq_scratch1]\n\t"
 		"movq %[len], %[rseq_scratch2]\n\t"
 		/* Start rseq by storing table entry pointer into rseq_cs. */
-		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, rseq_cs)
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, RSEQ_CS_OFFSET(%[rseq_abi]))
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_CPU_ID_OFFSET(%[rseq_abi]), 4f)
 		RSEQ_INJECT_ASM(3)
 		"cmpq %[v], %[expect]\n\t"
 		"jnz 5f\n\t"
 		RSEQ_INJECT_ASM(4)
 #ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 6f)
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_CPU_ID_OFFSET(%[rseq_abi]), 6f)
 		"cmpq %[v], %[expect]\n\t"
 		"jnz 7f\n\t"
 #endif
@@ -493,8 +498,7 @@ int rseq_cmpeqv_trymemcpy_storev(intptr_t *v, intptr_t expect,
 #endif
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
-		  [current_cpu_id]	"m" (__rseq_abi.cpu_id),
-		  [rseq_cs]		"m" (__rseq_abi.rseq_cs),
+		  [rseq_abi]		"r" (&__rseq_abi),
 		  /* final store input */
 		  [v]			"m" (*v),
 		  [expect]		"r" (expect),
@@ -602,12 +606,12 @@ do {									\
 
 #define RSEQ_ASM_STORE_RSEQ_CS(label, cs_label, rseq_cs)		\
 		RSEQ_INJECT_ASM(1)					\
-		"movl $" __rseq_str(cs_label) ", %[rseq_cs]\n\t"	\
+		"movl $" __rseq_str(cs_label) ", " __rseq_str(rseq_cs) "\n\t"	\
 		__rseq_str(label) ":\n\t"
 
 #define RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, label)		\
 		RSEQ_INJECT_ASM(2)					\
-		"cmpl %[" __rseq_str(cpu_id) "], %[" __rseq_str(current_cpu_id) "]\n\t" \
+		"cmpl %[" __rseq_str(cpu_id) "], " __rseq_str(current_cpu_id) "\n\t" \
 		"jnz " __rseq_str(label) "\n\t"
 
 #define RSEQ_ASM_DEFINE_ABORT(label, teardown, abort_label)		\
@@ -640,14 +644,14 @@ int rseq_cmpeqv_storev(intptr_t *v, intptr_t expect, intptr_t newv, int cpu)
 		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
 #endif
 		/* Start rseq by storing table entry pointer into rseq_cs. */
-		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, rseq_cs)
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, RSEQ_CS_OFFSET(%[rseq_abi]))
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_CPU_ID_OFFSET(%[rseq_abi]), 4f)
 		RSEQ_INJECT_ASM(3)
 		"cmpl %[v], %[expect]\n\t"
 		"jnz %l[cmpfail]\n\t"
 		RSEQ_INJECT_ASM(4)
 #ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_CPU_ID_OFFSET(%[rseq_abi]), %l[error1])
 		"cmpl %[v], %[expect]\n\t"
 		"jnz %l[error2]\n\t"
 #endif
@@ -658,8 +662,7 @@ int rseq_cmpeqv_storev(intptr_t *v, intptr_t expect, intptr_t newv, int cpu)
 		RSEQ_ASM_DEFINE_ABORT(4, "", abort)
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
-		  [current_cpu_id]	"m" (__rseq_abi.cpu_id),
-		  [rseq_cs]		"m" (__rseq_abi.rseq_cs),
+		  [rseq_abi]		"r" (&__rseq_abi),
 		  [v]			"m" (*v),
 		  [expect]		"r" (expect),
 		  [newv]		"r" (newv)
@@ -702,15 +705,15 @@ int rseq_cmpnev_storeoffp_load(intptr_t *v, intptr_t expectnot,
 		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
 #endif
 		/* Start rseq by storing table entry pointer into rseq_cs. */
-		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, rseq_cs)
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, RSEQ_CS_OFFSET(%[rseq_abi]))
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_CPU_ID_OFFSET(%[rseq_abi]), 4f)
 		RSEQ_INJECT_ASM(3)
 		"movl %[v], %%ebx\n\t"
 		"cmpl %%ebx, %[expectnot]\n\t"
 		"je %l[cmpfail]\n\t"
 		RSEQ_INJECT_ASM(4)
 #ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_CPU_ID_OFFSET(%[rseq_abi]), %l[error1])
 		"movl %[v], %%ebx\n\t"
 		"cmpl %%ebx, %[expectnot]\n\t"
 		"je %l[error2]\n\t"
@@ -725,8 +728,7 @@ int rseq_cmpnev_storeoffp_load(intptr_t *v, intptr_t expectnot,
 		RSEQ_ASM_DEFINE_ABORT(4, "", abort)
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
-		  [current_cpu_id]	"m" (__rseq_abi.cpu_id),
-		  [rseq_cs]		"m" (__rseq_abi.rseq_cs),
+		  [rseq_abi]		"r" (&__rseq_abi),
 		  /* final store input */
 		  [v]			"m" (*v),
 		  [expectnot]		"r" (expectnot),
@@ -764,11 +766,11 @@ int rseq_addv(intptr_t *v, intptr_t count, int cpu)
 		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
 #endif
 		/* Start rseq by storing table entry pointer into rseq_cs. */
-		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, rseq_cs)
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, RSEQ_CS_OFFSET(%[rseq_abi]))
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_CPU_ID_OFFSET(%[rseq_abi]), 4f)
 		RSEQ_INJECT_ASM(3)
 #ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_CPU_ID_OFFSET(%[rseq_abi]), %l[error1])
 #endif
 		/* final store */
 		"addl %[count], %[v]\n\t"
@@ -777,8 +779,7 @@ int rseq_addv(intptr_t *v, intptr_t count, int cpu)
 		RSEQ_ASM_DEFINE_ABORT(4, "", abort)
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
-		  [current_cpu_id]	"m" (__rseq_abi.cpu_id),
-		  [rseq_cs]		"m" (__rseq_abi.rseq_cs),
+		  [rseq_abi]		"r" (&__rseq_abi),
 		  /* final store input */
 		  [v]			"m" (*v),
 		  [count]		"ir" (count)
@@ -814,14 +815,14 @@ int rseq_cmpeqv_trystorev_storev(intptr_t *v, intptr_t expect,
 		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
 #endif
 		/* Start rseq by storing table entry pointer into rseq_cs. */
-		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, rseq_cs)
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, RSEQ_CS_OFFSET(%[rseq_abi]))
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_CPU_ID_OFFSET(%[rseq_abi]), 4f)
 		RSEQ_INJECT_ASM(3)
 		"cmpl %[v], %[expect]\n\t"
 		"jnz %l[cmpfail]\n\t"
 		RSEQ_INJECT_ASM(4)
 #ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_CPU_ID_OFFSET(%[rseq_abi]), %l[error1])
 		"cmpl %[v], %[expect]\n\t"
 		"jnz %l[error2]\n\t"
 #endif
@@ -836,8 +837,7 @@ int rseq_cmpeqv_trystorev_storev(intptr_t *v, intptr_t expect,
 		RSEQ_ASM_DEFINE_ABORT(4, "", abort)
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
-		  [current_cpu_id]	"m" (__rseq_abi.cpu_id),
-		  [rseq_cs]		"m" (__rseq_abi.rseq_cs),
+		  [rseq_abi]		"r" (&__rseq_abi),
 		  /* try store input */
 		  [v2]			"m" (*v2),
 		  [newv2]		"m" (newv2),
@@ -881,15 +881,15 @@ int rseq_cmpeqv_trystorev_storev_release(intptr_t *v, intptr_t expect,
 		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
 #endif
 		/* Start rseq by storing table entry pointer into rseq_cs. */
-		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, rseq_cs)
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, RSEQ_CS_OFFSET(%[rseq_abi]))
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_CPU_ID_OFFSET(%[rseq_abi]), 4f)
 		RSEQ_INJECT_ASM(3)
 		"movl %[expect], %%eax\n\t"
 		"cmpl %[v], %%eax\n\t"
 		"jnz %l[cmpfail]\n\t"
 		RSEQ_INJECT_ASM(4)
 #ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_CPU_ID_OFFSET(%[rseq_abi]), %l[error1])
 		"movl %[expect], %%eax\n\t"
 		"cmpl %[v], %%eax\n\t"
 		"jnz %l[error2]\n\t"
@@ -905,8 +905,7 @@ int rseq_cmpeqv_trystorev_storev_release(intptr_t *v, intptr_t expect,
 		RSEQ_ASM_DEFINE_ABORT(4, "", abort)
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
-		  [current_cpu_id]	"m" (__rseq_abi.cpu_id),
-		  [rseq_cs]		"m" (__rseq_abi.rseq_cs),
+		  [rseq_abi]		"r" (&__rseq_abi),
 		  /* try store input */
 		  [v2]			"m" (*v2),
 		  [newv2]		"r" (newv2),
@@ -952,8 +951,8 @@ int rseq_cmpeqv_cmpeqv_storev(intptr_t *v, intptr_t expect,
 		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error3])
 #endif
 		/* Start rseq by storing table entry pointer into rseq_cs. */
-		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, rseq_cs)
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, RSEQ_CS_OFFSET(%[rseq_abi]))
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_CPU_ID_OFFSET(%[rseq_abi]), 4f)
 		RSEQ_INJECT_ASM(3)
 		"cmpl %[v], %[expect]\n\t"
 		"jnz %l[cmpfail]\n\t"
@@ -962,7 +961,7 @@ int rseq_cmpeqv_cmpeqv_storev(intptr_t *v, intptr_t expect,
 		"jnz %l[cmpfail]\n\t"
 		RSEQ_INJECT_ASM(5)
 #ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_CPU_ID_OFFSET(%[rseq_abi]), %l[error1])
 		"cmpl %[v], %[expect]\n\t"
 		"jnz %l[error2]\n\t"
 		"cmpl %[expect2], %[v2]\n\t"
@@ -976,8 +975,7 @@ int rseq_cmpeqv_cmpeqv_storev(intptr_t *v, intptr_t expect,
 		RSEQ_ASM_DEFINE_ABORT(4, "", abort)
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
-		  [current_cpu_id]	"m" (__rseq_abi.cpu_id),
-		  [rseq_cs]		"m" (__rseq_abi.rseq_cs),
+		  [rseq_abi]		"r" (&__rseq_abi),
 		  /* cmp2 input */
 		  [v2]			"m" (*v2),
 		  [expect2]		"r" (expect2),
@@ -1029,15 +1027,15 @@ int rseq_cmpeqv_trymemcpy_storev(intptr_t *v, intptr_t expect,
 		"movl %[dst], %[rseq_scratch1]\n\t"
 		"movl %[len], %[rseq_scratch2]\n\t"
 		/* Start rseq by storing table entry pointer into rseq_cs. */
-		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, rseq_cs)
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, RSEQ_CS_OFFSET(%[rseq_abi]))
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_CPU_ID_OFFSET(%[rseq_abi]), 4f)
 		RSEQ_INJECT_ASM(3)
 		"movl %[expect], %%eax\n\t"
 		"cmpl %%eax, %[v]\n\t"
 		"jnz 5f\n\t"
 		RSEQ_INJECT_ASM(4)
 #ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 6f)
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_CPU_ID_OFFSET(%[rseq_abi]), 6f)
 		"movl %[expect], %%eax\n\t"
 		"cmpl %%eax, %[v]\n\t"
 		"jnz 7f\n\t"
@@ -1087,8 +1085,7 @@ int rseq_cmpeqv_trymemcpy_storev(intptr_t *v, intptr_t expect,
 #endif
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
-		  [current_cpu_id]	"m" (__rseq_abi.cpu_id),
-		  [rseq_cs]		"m" (__rseq_abi.rseq_cs),
+		  [rseq_abi]		"r" (&__rseq_abi),
 		  /* final store input */
 		  [v]			"m" (*v),
 		  [expect]		"m" (expect),
@@ -1142,15 +1139,15 @@ int rseq_cmpeqv_trymemcpy_storev_release(intptr_t *v, intptr_t expect,
 		"movl %[dst], %[rseq_scratch1]\n\t"
 		"movl %[len], %[rseq_scratch2]\n\t"
 		/* Start rseq by storing table entry pointer into rseq_cs. */
-		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, rseq_cs)
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, RSEQ_CS_OFFSET(%[rseq_abi]))
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_CPU_ID_OFFSET(%[rseq_abi]), 4f)
 		RSEQ_INJECT_ASM(3)
 		"movl %[expect], %%eax\n\t"
 		"cmpl %%eax, %[v]\n\t"
 		"jnz 5f\n\t"
 		RSEQ_INJECT_ASM(4)
 #ifdef RSEQ_COMPARE_TWICE
-		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 6f)
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_CPU_ID_OFFSET(%[rseq_abi]), 6f)
 		"movl %[expect], %%eax\n\t"
 		"cmpl %%eax, %[v]\n\t"
 		"jnz 7f\n\t"
@@ -1201,8 +1198,7 @@ int rseq_cmpeqv_trymemcpy_storev_release(intptr_t *v, intptr_t expect,
 #endif
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
-		  [current_cpu_id]	"m" (__rseq_abi.cpu_id),
-		  [rseq_cs]		"m" (__rseq_abi.rseq_cs),
+		  [rseq_abi]		"r" (&__rseq_abi),
 		  /* final store input */
 		  [v]			"m" (*v),
 		  [expect]		"m" (expect),
-- 
2.17.1

