Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60A66C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 19:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E83D205F4
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 19:48:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="jkKrIjUJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728596AbfCETs3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 14:48:29 -0500
Received: from mail.efficios.com ([167.114.142.138]:37166 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727049AbfCETsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 14:48:13 -0500
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id B8163A18C0;
        Tue,  5 Mar 2019 14:48:11 -0500 (EST)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id N4Ad0hL8xQQN; Tue,  5 Mar 2019 14:48:11 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id E2B08A18A4;
        Tue,  5 Mar 2019 14:48:10 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com E2B08A18A4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1551815290;
        bh=eb1sqs5ATNZZd67cX1RQ1dYsO//kC1wvU1X9qurzJoY=;
        h=From:To:Date:Message-Id;
        b=jkKrIjUJienNf1a8AxH6IPljKvrREc/FBgP6ztyk+vqOTlN8Y1qqwnWmpjTur/gFe
         h1of8H9AhTN8ugZMLM1LDCErLpAO+se8l8d1piUdC0fnNzt2iEPNPaXvkPphBoe+ub
         U6EYWBzzdYtGQISoL/fs9McmgDm82L4Tp3DNKRoGpdFx6BEOkQNXXQlWyRA1kyJLAn
         Wq/zS12cWPnUqSTtaOQYbktKSu6yDOWXaRQmgnN8PKqNqhcF1tcDgvFp3K+OY0BDo8
         +I+ULaV7OoDkVoTY9mt67jg6YTAQWsZT5JzX6zM5vbLEvhH+xJVgWoY254Qpv6v6F2
         3WuQ+Z/f1lDaQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id fa5h35tL3Mvz; Tue,  5 Mar 2019 14:48:10 -0500 (EST)
Received: from thinkos.internal.efficios.com (192-222-157-41.qc.cable.ebox.net [192.222.157.41])
        by mail.efficios.com (Postfix) with ESMTPSA id 857A2A1896;
        Tue,  5 Mar 2019 14:48:10 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
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
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH for 5.1 1/3] rseq: cleanup: Reflect removal of event counter in comments
Date:   Tue,  5 Mar 2019 14:47:53 -0500
Message-Id: <20190305194755.2602-2-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190305194755.2602-1-mathieu.desnoyers@efficios.com>
References: <20190305194755.2602-1-mathieu.desnoyers@efficios.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "event counter" was removed from rseq before it was merged upstream.
However, a few comments in the source code still refer to it. Adapt the
comments to match reality.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
CC: Peter Zijlstra <peterz@infradead.org>
CC: Paul Turner <pjt@google.com>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Andy Lutomirski <luto@amacapital.net>
CC: Andi Kleen <andi@firstfloor.org>
CC: Dave Watson <davejwatson@fb.com>
CC: Chris Lameter <cl@linux.com>
CC: Ingo Molnar <mingo@redhat.com>
CC: "H. Peter Anvin" <hpa@zytor.com>
CC: Ben Maurer <bmaurer@fb.com>
CC: Steven Rostedt <rostedt@goodmis.org>
CC: Josh Triplett <josh@joshtriplett.org>
CC: Linus Torvalds <torvalds@linux-foundation.org>
CC: Andrew Morton <akpm@linux-foundation.org>
CC: Russell King <linux@arm.linux.org.uk>
CC: Catalin Marinas <catalin.marinas@arm.com>
CC: Will Deacon <will.deacon@arm.com>
CC: Boqun Feng <boqun.feng@gmail.com>
---
 arch/arm/kernel/signal.c | 3 +--
 arch/x86/kernel/signal.c | 5 +----
 kernel/rseq.c            | 3 +--
 3 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/arch/arm/kernel/signal.c b/arch/arm/kernel/signal.c
index 76bb8de6bf6b..be5edfdde558 100644
--- a/arch/arm/kernel/signal.c
+++ b/arch/arm/kernel/signal.c
@@ -549,8 +549,7 @@ static void handle_signal(struct ksignal *ksig, struct pt_regs *regs)
 	int ret;
 
 	/*
-	 * Increment event counter and perform fixup for the pre-signal
-	 * frame.
+	 * Perform fixup for the pre-signal frame.
 	 */
 	rseq_signal_deliver(ksig, regs);
 
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index 08dfd4c1a4f9..22c233b509da 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -688,10 +688,7 @@ setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs)
 	sigset_t *set = sigmask_to_save();
 	compat_sigset_t *cset = (compat_sigset_t *) set;
 
-	/*
-	 * Increment event counter and perform fixup for the pre-signal
-	 * frame.
-	 */
+	/* Perform fixup for the pre-signal frame. */
 	rseq_signal_deliver(ksig, regs);
 
 	/* Set up the stack frame */
diff --git a/kernel/rseq.c b/kernel/rseq.c
index 25e9a7b60eba..849afe749131 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -254,8 +254,7 @@ static int rseq_ip_fixup(struct pt_regs *regs)
  * - signal delivery,
  * and return to user-space.
  *
- * This is how we can ensure that the entire rseq critical section,
- * consisting of both the C part and the assembly instruction sequence,
+ * This is how we can ensure that the entire rseq critical section
  * will issue the commit instruction only if executed atomically with
  * respect to other threads scheduled on the same CPU, and with respect
  * to signal handlers.
-- 
2.11.0

