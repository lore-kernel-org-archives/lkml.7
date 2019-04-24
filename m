Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F8CC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 15:26:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5CA021902
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 15:26:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="manuagDv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731489AbfDXP0O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 11:26:14 -0400
Received: from mail.efficios.com ([167.114.142.138]:58050 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731113AbfDXPZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 11:25:43 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 9293E1D91E0;
        Wed, 24 Apr 2019 11:25:41 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id Ss8JZna-6OU2; Wed, 24 Apr 2019 11:25:41 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 26CE71D91CF;
        Wed, 24 Apr 2019 11:25:41 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 26CE71D91CF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1556119541;
        bh=HKvroncAGMEGmOUp7SnchUF8B52rTeenvfZlybbg6Hw=;
        h=From:To:Date:Message-Id;
        b=manuagDvDmaUX9s/0e0I0qi/Bfa8UlTQDPaHTdbabYTH9US3Bpqmp/e1EyyLG8ugi
         0YzMjBl/gbl/JErnSB9St/vdYL+Imjcdd4FfsiC50JlPlw6iv9vmm2Nxbtoy4kYE+c
         ZdGPpS+K33eoJmjsWmeOqD07vxgWeyIn7uQKyYdeL8MgFdwY9+3qxRXT+D6zDt19tZ
         6/3qfAJukHbuAEf2xHXIHAwbexnKi9iBI4zQImS8Z3Q/YavmuW5JQsGm48XW0FW27l
         ki08uH0IZqPk7jRCCe0x6Js4HgO1/UnVYgAxk7fGAOZTwm0U8qshWJFn3C2M5ZtFws
         JOkqbF0Z3+vWw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id az42ab1i1Odd; Wed, 24 Apr 2019 11:25:41 -0400 (EDT)
Received: from thinkos.internal.efficios.com (192-222-157-41.qc.cable.ebox.net [192.222.157.41])
        by mail.efficios.com (Postfix) with ESMTPSA id 9900E1D91B4;
        Wed, 24 Apr 2019 11:25:38 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@arm.linux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andi Kleen <andi@firstfloor.org>, Chris Lameter <cl@linux.com>,
        Ben Maurer <bmaurer@fb.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Joel Fernandes <joelaf@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kselftest@vger.kernel.org
Subject: [RFC PATCH for 5.2 08/10] rseq/selftests: aarch64 code signature: handle big-endian environment
Date:   Wed, 24 Apr 2019 11:25:00 -0400
Message-Id: <20190424152502.14246-9-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190424152502.14246-1-mathieu.desnoyers@efficios.com>
References: <20190424152502.14246-1-mathieu.desnoyers@efficios.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Handle compiling with -mbig-endian on aarch64, which generates binaries
with mixed code vs data endianness (little endian code, big endian
data).

Else mismatch between code endianness for the generated signatures and
data endianness for the RSEQ_SIG parameter passed to the rseq
registration will trigger application segmentation faults when the
kernel try to abort rseq critical sections.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
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
 tools/testing/selftests/rseq/rseq-arm64.h | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/rseq/rseq-arm64.h b/tools/testing/selftests/rseq/rseq-arm64.h
index b41a2a48e965..200dae9e4208 100644
--- a/tools/testing/selftests/rseq/rseq-arm64.h
+++ b/tools/testing/selftests/rseq/rseq-arm64.h
@@ -6,7 +6,20 @@
  * (C) Copyright 2018 - Will Deacon <will.deacon@arm.com>
  */
 
-#define RSEQ_SIG	0xd428bc00	/* BRK #0x45E0 */
+/*
+ * aarch64 -mbig-endian generates mixed endianness code vs data:
+ * little-endian code and big-endian data. Ensure the RSEQ_SIG signature
+ * matches code endianness.
+ */
+#define RSEQ_SIG_CODE	0xd428bc00	/* BRK #0x45E0.  */
+
+#ifdef __AARCH64EB__
+#define RSEQ_SIG_DATA	0x00bc28d4	/* BRK #0x45E0.  */
+#else
+#define RSEQ_SIG_DATA	RSEQ_SIG_CODE
+#endif
+
+#define RSEQ_SIG	RSEQ_SIG_DATA
 
 #define rseq_smp_mb()	__asm__ __volatile__ ("dmb ish" ::: "memory")
 #define rseq_smp_rmb()	__asm__ __volatile__ ("dmb ishld" ::: "memory")
@@ -121,7 +134,7 @@ do {										\
 
 #define RSEQ_ASM_DEFINE_ABORT(label, abort_label)				\
 	"	b	222f\n"							\
-	"	.inst 	"	__rseq_str(RSEQ_SIG) "\n"			\
+	"	.inst 	"	__rseq_str(RSEQ_SIG_CODE) "\n"			\
 	__rseq_str(label) ":\n"							\
 	"	b	%l[" __rseq_str(abort_label) "]\n"			\
 	"222:\n"
-- 
2.11.0

