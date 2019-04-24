Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAC8FC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 15:26:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 735F521902
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 15:26:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="N0nkysab"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731430AbfDXP0K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 11:26:10 -0400
Received: from mail.efficios.com ([167.114.142.138]:57984 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731233AbfDXPZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 11:25:43 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id ECF101D91FB;
        Wed, 24 Apr 2019 11:25:42 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id rcqGGMwzfx31; Wed, 24 Apr 2019 11:25:42 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 4CD241D91F3;
        Wed, 24 Apr 2019 11:25:42 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 4CD241D91F3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1556119542;
        bh=AuAXMy3iLCz73+j1txs+aAZdmlzykjM9QU0ANC1hzHo=;
        h=From:To:Date:Message-Id;
        b=N0nkysab/vOtfmikmM/vvgwMtJg7Nu6dd5AZ+yTDeRkOp960fQGaCwhWp6Ez8wjj3
         U2l0ziw8hKSvq6oeWhytQZFgmgO9BHNx2M3hnJIyKUNp09bI/dxAs9yPVwlgBfe3g0
         tjTG+2KvQEnLsqRdieWSrN1fMqHQ5JqSdOw8W88Ovu4g7OOR87OKb27I9a5dylExaL
         8ebzsAZSU7oqnH0nUERH8sSwC0qKM/kaFA9YAqEN0A03tqqlO05B41Q7H3kBj84zp4
         gMGHVdYDJDO23gO3txSwuhSYPFdrduI4oQL91wsKxqTzr6cupX8yZmFP04B1RCVQt8
         jzNTqcOnJmABQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id fsFpeYlmSrc1; Wed, 24 Apr 2019 11:25:42 -0400 (EDT)
Received: from thinkos.internal.efficios.com (192-222-157-41.qc.cable.ebox.net [192.222.157.41])
        by mail.efficios.com (Postfix) with ESMTPSA id 228721D91BF;
        Wed, 24 Apr 2019 11:25:40 -0400 (EDT)
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
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [RFC PATCH for 5.2 10/10] rseq/selftests: mips: use break instruction for RSEQ_SIG
Date:   Wed, 24 Apr 2019 11:25:02 -0400
Message-Id: <20190424152502.14246-11-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190424152502.14246-1-mathieu.desnoyers@efficios.com>
References: <20190424152502.14246-1-mathieu.desnoyers@efficios.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use break as guard instruction for the restartable sequence abort
handler.

Previously, the chosen signature was simply data, based on the
assumption that it could always sit in a literal pool. However,
some compilation environments favor disabling literal pool. Therefore,
ensure the signature is a valid uncommon trap instruction.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC: Paul Burton <paul.burton@mips.com>
CC: James Hogan <jhogan@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
---
 tools/testing/selftests/rseq/rseq-mips.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rseq/rseq-mips.h b/tools/testing/selftests/rseq/rseq-mips.h
index fe3eabcdcbe5..eb53a6adfbbb 100644
--- a/tools/testing/selftests/rseq/rseq-mips.h
+++ b/tools/testing/selftests/rseq/rseq-mips.h
@@ -7,7 +7,11 @@
  * (C) Copyright 2016-2018 - Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
  */
 
-#define RSEQ_SIG	0x53053053
+/*
+ * RSEQ_SIG uses the break instruction. The instruction pattern is
+ *	0350000d        break    0x350
+ */
+#define RSEQ_SIG	0x0350000d
 
 #define rseq_smp_mb()	__asm__ __volatile__ ("sync" ::: "memory")
 #define rseq_smp_rmb()	rseq_smp_mb()
-- 
2.11.0

