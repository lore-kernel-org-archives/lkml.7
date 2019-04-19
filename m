Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC4C7C282DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:06:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DE4F20645
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:06:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="SCEuOyDU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729338AbfDSTGY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:06:24 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42949 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726262AbfDSTGV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:06:21 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3JAh67n236666
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 19 Apr 2019 03:43:07 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3JAh67n236666
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1555670588;
        bh=RyB9VAIn2pS4GGEVIEMe9R1Aw22aFC/T0jRgQBrXIKw=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=SCEuOyDULZAPBpasGLrttZ8YrbA/oLS/nldGSsdFH3YTPLBQMCMKn6ltFM8hO/ZRp
         SeTEZgW+dFeO3w+YLOzNpMpfIc/auwTi+pfyRkI9VXQZUmoKbDyuvDtY90FAfA8lZE
         C6WwBSebQtUKHsex375tnZH/AA++gbUgJ2JWBCsCOmp7j9l5SO/B7Zb2vNiaMM2M+m
         7ciIJV5WIbV+b6ZYN34UA9dKOULAWSqLFqItItDEGcCkgLdI0V+emiHINGvRwZWeVO
         ysBY13w3Az0vQLh4fmJqxeDPuUqcccsH9+XR0OhOq7KruS5KFbtY/6+A8oj/vt4Xnn
         rtLyaLZ8lC+mg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3JAh6cq236663;
        Fri, 19 Apr 2019 03:43:06 -0700
Date:   Fri, 19 Apr 2019 03:43:06 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Mathieu Desnoyers <tipbot@zytor.com>
Message-ID: <tip-bff9504bfc9c5c6610b42d47f689f350fd969eb8@git.kernel.org>
Cc:     joelaf@google.com, pjt@google.com, bmaurer@fb.com,
        peterz@infradead.org, torvalds@linux-foundation.org, hpa@zytor.com,
        will.deacon@arm.com, paulmck@linux.vnet.ibm.com,
        tglx@linutronix.de, josh@joshtriplett.org, catalin.marinas@arm.com,
        mathieu.desnoyers@efficios.com, cl@linux.com, davejwatson@fb.com,
        linux@arm.linux.org.uk, mingo@kernel.org, rostedt@goodmis.org,
        mtk.manpages@gmail.com, luto@amacapital.net,
        akpm@linux-foundation.org, boqun.feng@gmail.com,
        linux-kernel@vger.kernel.org
Reply-To: joelaf@google.com, pjt@google.com, bmaurer@fb.com,
          peterz@infradead.org, torvalds@linux-foundation.org,
          hpa@zytor.com, will.deacon@arm.com, paulmck@linux.vnet.ibm.com,
          tglx@linutronix.de, josh@joshtriplett.org,
          catalin.marinas@arm.com, mathieu.desnoyers@efficios.com,
          cl@linux.com, davejwatson@fb.com, linux@arm.linux.org.uk,
          mingo@kernel.org, rostedt@goodmis.org, mtk.manpages@gmail.com,
          luto@amacapital.net, akpm@linux-foundation.org,
          boqun.feng@gmail.com, linux-kernel@vger.kernel.org
In-Reply-To: <20190305194755.2602-2-mathieu.desnoyers@efficios.com>
References: <20190305194755.2602-2-mathieu.desnoyers@efficios.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:core/rseq] rseq: Clean up comments by reflecting removal of
 event counter
Git-Commit-ID: bff9504bfc9c5c6610b42d47f689f350fd969eb8
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  bff9504bfc9c5c6610b42d47f689f350fd969eb8
Gitweb:     https://git.kernel.org/tip/bff9504bfc9c5c6610b42d47f689f350fd969eb8
Author:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
AuthorDate: Tue, 5 Mar 2019 14:47:53 -0500
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 19 Apr 2019 12:39:31 +0200

rseq: Clean up comments by reflecting removal of event counter

The "event counter" was removed from rseq before it was merged upstream.
However, a few comments in the source code still refer to it. Adapt the
comments to match reality.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Ben Maurer <bmaurer@fb.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Chris Lameter <cl@linux.com>
Cc: Dave Watson <davejwatson@fb.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Joel Fernandes <joelaf@google.com>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Michael Kerrisk <mtk.manpages@gmail.com>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Paul Turner <pjt@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: linux-api@vger.kernel.org
Link: http://lkml.kernel.org/r/20190305194755.2602-2-mathieu.desnoyers@efficios.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
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
