Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB545C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 15:25:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8DA121903
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 15:25:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="NYYnydFS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731230AbfDXPZm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 11:25:42 -0400
Received: from mail.efficios.com ([167.114.142.138]:58050 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731190AbfDXPZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 11:25:40 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 582311D91AC;
        Wed, 24 Apr 2019 11:25:38 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id xp10Gm7esdl9; Wed, 24 Apr 2019 11:25:38 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 0B1ED1D91A2;
        Wed, 24 Apr 2019 11:25:38 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 0B1ED1D91A2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1556119538;
        bh=WV0aLN7pvahQr5sToC9GKACvUzvM6D05m4T4cPR6y/0=;
        h=From:To:Date:Message-Id;
        b=NYYnydFSY5ix74g7uTysol7rkU5AcI88nIQN7QW/4UmEmEC4ru52xyF8lsVQdgSyl
         Q7vesXrqoRgZPCIon4NtshUHSOcfvh1wNGKv/tvSHDOPSwgK/wcGMLpcCWEPCm4w5t
         1dtJGOFVmt6bgw1XXo5DTHpQeW9rarIU/bhmV2Bt4m7o7dS5QkkMP2Eoipq3jygJzn
         cWHestucfEAIMhfItGgIZSLs5ZObiE8AgaCOnbRmJhyVWmueXS0zjIeCYkNoiINMgc
         THNid+8HP2HVVxU+2H+e6FF5Q4s8m40Ffl16iw88k7UGmOWsYAAWKiOhgW2A4GwE7v
         o4s8D7PCHY4Og==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id zs56E0wFIrbj; Wed, 24 Apr 2019 11:25:37 -0400 (EDT)
Received: from thinkos.internal.efficios.com (192-222-157-41.qc.cable.ebox.net [192.222.157.41])
        by mail.efficios.com (Postfix) with ESMTPSA id 64BA21D9185;
        Wed, 24 Apr 2019 11:25:37 -0400 (EDT)
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
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RFC PATCH for 5.2 06/10] rseq/selftests: s390: use trap4 for RSEQ_SIG
Date:   Wed, 24 Apr 2019 11:24:58 -0400
Message-Id: <20190424152502.14246-7-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190424152502.14246-1-mathieu.desnoyers@efficios.com>
References: <20190424152502.14246-1-mathieu.desnoyers@efficios.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Use trap4 as the guard instruction for the restartable sequence abort
handler.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 tools/testing/selftests/rseq/rseq-s390.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rseq/rseq-s390.h b/tools/testing/selftests/rseq/rseq-s390.h
index 7c4f3a70b6c7..1d05c5187ae6 100644
--- a/tools/testing/selftests/rseq/rseq-s390.h
+++ b/tools/testing/selftests/rseq/rseq-s390.h
@@ -1,6 +1,13 @@
 /* SPDX-License-Identifier: LGPL-2.1 OR MIT */
 
-#define RSEQ_SIG	0x53053053
+/*
+ * RSEQ_SIG uses the trap4 instruction. As Linux does not make use of the
+ * access-register mode nor the linkage stack this instruction will always
+ * cause a special-operation exception (the trap-enabled bit in the DUCT
+ * is and will stay 0). The instruction pattern is
+ *	b2 ff 0f ff	trap4   4095(%r0)
+ */
+#define RSEQ_SIG	0xB2FF0FFF
 
 #define rseq_smp_mb()	__asm__ __volatile__ ("bcr 15,0" ::: "memory")
 #define rseq_smp_rmb()	rseq_smp_mb()
-- 
2.11.0

