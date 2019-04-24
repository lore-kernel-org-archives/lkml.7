Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73C25C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 15:25:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EC5921905
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 15:25:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="LFinkbyx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731172AbfDXPZi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 11:25:38 -0400
Received: from mail.efficios.com ([167.114.142.138]:57770 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727995AbfDXPZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 11:25:37 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 2DC621D9146;
        Wed, 24 Apr 2019 11:25:35 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id lEmgGk7ohO1e; Wed, 24 Apr 2019 11:25:34 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id B268F1D9139;
        Wed, 24 Apr 2019 11:25:34 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com B268F1D9139
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1556119534;
        bh=jI7SyLyER8knY1Qqz93H28hkqJrCH49JEc+aDoORYNQ=;
        h=From:To:Date:Message-Id;
        b=LFinkbyx92ebQ71UHe/ZRgNzvjjYOSEmPS72g/VAVpUUIaEN5Mman67LgBgwKJydw
         HcUUpBF4fVPjNRqTOJktszzOfjxt2TXYxoFiJdr9TY4majqZ8TpiP3YaAXhGXm5CzL
         +gBRnvNVIaY8hTK3W5GNoj01f+0nIa4iBM5btA/t1JS2j5TGBKpQPvfaGyC9kRWweR
         L0aVaCuXZCC0A3zOGp87/PEEbV/cCy2Om2vkweZIaFmCAW5toy71vO84pua0bwUsxZ
         X9SgP9/z82ViGPteiT4Ur8HexEDBvZbMOiYRynNG+9ICSL4B2RVEh0nHChsJDRWEtn
         pJhO/q1kShXaQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id JPX-M5LCT9Ks; Wed, 24 Apr 2019 11:25:34 -0400 (EDT)
Received: from thinkos.internal.efficios.com (192-222-157-41.qc.cable.ebox.net [192.222.157.41])
        by mail.efficios.com (Postfix) with ESMTPSA id 2DE8A1D9133;
        Wed, 24 Apr 2019 11:25:34 -0400 (EDT)
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
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RFC PATCH for 5.2 00/10] Restartable Sequences selftests updates
Date:   Wed, 24 Apr 2019 11:24:52 -0400
Message-Id: <20190424152502.14246-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Those rseq selftests updates are hereby submitted for feedback.

They change the per-architecture pre-abort signatures to ensure those
are valid trap instructions.

The way exit points are presented to debuggers is enhanced, ensuring
all exit points are present, so debuggers don't have to disassemble
rseq critical section to properly skip over them.

Also, discussions with the glibc community is reaching a concensus
of exposing a __rseq_handled symbol from glibc to coexist with
rseq early adopters. Update the rseq selftest code to use this
symbol.

Feedback is welcome.

Thanks,

Mathieu

Martin Schwidefsky (1):
  rseq/selftests: s390: use trap4 for RSEQ_SIG

Mathieu Desnoyers (9):
  rseq/selftests: Add __rseq_exit_point_array section for debuggers
  rseq/selftests: Introduce __rseq_cs_ptr_array, rename __rseq_table to
    __rseq_cs
  rseq/selftests: Use __rseq_handled symbol to coexist with glibc
  rseq/selftests: s390: use jg instruction for jumps outside of the asm
  rseq/selftests: x86: use ud1 instruction as RSEQ_SIG opcode
  rseq/selftests: arm: use udf instruction for RSEQ_SIG
  rseq/selftests: aarch64 code signature: handle big-endian environment
  rseq/selftests: powerpc code signature: generate valid instructions
  rseq/selftests: mips: use break instruction for RSEQ_SIG

 tools/testing/selftests/rseq/rseq-arm.h   | 132 ++++++++++++++++++++++++++----
 tools/testing/selftests/rseq/rseq-arm64.h |  74 ++++++++++++++++-
 tools/testing/selftests/rseq/rseq-mips.h  |  87 +++++++++++++++++---
 tools/testing/selftests/rseq/rseq-ppc.h   |  90 ++++++++++++++++++--
 tools/testing/selftests/rseq/rseq-s390.h  |  78 ++++++++++++++++--
 tools/testing/selftests/rseq/rseq-x86.h   | 120 +++++++++++++++++++++++++--
 tools/testing/selftests/rseq/rseq.c       |  55 +++++++++++--
 tools/testing/selftests/rseq/rseq.h       |   1 +
 8 files changed, 583 insertions(+), 54 deletions(-)

-- 
2.11.0

