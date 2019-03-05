Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F13A0C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 19:48:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEECC205F4
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 19:48:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="DTSO3Q9K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728471AbfCETsQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 14:48:16 -0500
Received: from mail.efficios.com ([167.114.142.138]:37202 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727365AbfCETsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 14:48:13 -0500
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id C8801A18C3;
        Tue,  5 Mar 2019 14:48:11 -0500 (EST)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id BDRVC-LG942r; Tue,  5 Mar 2019 14:48:11 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 457F2A18AF;
        Tue,  5 Mar 2019 14:48:11 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 457F2A18AF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1551815291;
        bh=o26ragWgiILg1CcR8/4MeimBvu3NWamtH8zmJwyFHmI=;
        h=From:To:Date:Message-Id;
        b=DTSO3Q9Kk64ozFgxLwCkI/oZiexDkNmMBzoeDM+uwgc+IJJE64AseloVq61J9v1Nu
         SlzTTUgixmKKqNVbaFf160DAkQTDghXmp2DVNxRUugeIpxHluHYaDclFzrrukMuHwa
         UA2I/wbNdgj5qfsxZUVCYgHv+Uy8nX67IColkNJ9XqyVMvDr0GMyRIR2Jf+gF4+LLq
         PiBYvT1UGhkO1dh9xNh7h/vWhzYAfT8TmY3QJJJcjjTPuxmOPOY9r6Um9G2N6RRjIi
         u30RQC7aq+2vknv73RvqMen7+MFjpPXvLHFxpZjF7hAHecLU/v7XlpbHvJT0qAUtZR
         hoMxJhe7cUCBw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id YjA5x-RSG2AD; Tue,  5 Mar 2019 14:48:11 -0500 (EST)
Received: from thinkos.internal.efficios.com (192-222-157-41.qc.cable.ebox.net [192.222.157.41])
        by mail.efficios.com (Postfix) with ESMTPSA id DB059A189F;
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
Subject: [PATCH for 5.1 2/3] rseq: cleanup: remove rseq_len from task_struct
Date:   Tue,  5 Mar 2019 14:47:54 -0500
Message-Id: <20190305194755.2602-3-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190305194755.2602-1-mathieu.desnoyers@efficios.com>
References: <20190305194755.2602-1-mathieu.desnoyers@efficios.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rseq system call, when invoked with flags of "0" or
"RSEQ_FLAG_UNREGISTER" values, expects the rseq_len parameter to
be equal to sizeof(struct rseq), which is fixed-size and fixed-layout,
specified in uapi linux/rseq.h.

Expecting a fixed size for rseq_len is a design choice that ensures
multiple libraries and application defining __rseq_abi in the same
process agree on its exact size.

Considering that this size is and will always be the same value, there
is no point in saving this value within task_struct rseq_len. Remove
this field from task_struct.

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
CC: Michael Kerrisk <mtk.manpages@gmail.com>
CC: Boqun Feng <boqun.feng@gmail.com>
CC: linux-api@vger.kernel.org
---
 include/linux/sched.h | 4 ----
 kernel/rseq.c         | 6 ++----
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index f9b43c989577..e355688fa82c 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1059,7 +1059,6 @@ struct task_struct {
 
 #ifdef CONFIG_RSEQ
 	struct rseq __user *rseq;
-	u32 rseq_len;
 	u32 rseq_sig;
 	/*
 	 * RmW on rseq_event_mask must be performed atomically
@@ -1852,12 +1851,10 @@ static inline void rseq_fork(struct task_struct *t, unsigned long clone_flags)
 {
 	if (clone_flags & CLONE_THREAD) {
 		t->rseq = NULL;
-		t->rseq_len = 0;
 		t->rseq_sig = 0;
 		t->rseq_event_mask = 0;
 	} else {
 		t->rseq = current->rseq;
-		t->rseq_len = current->rseq_len;
 		t->rseq_sig = current->rseq_sig;
 		t->rseq_event_mask = current->rseq_event_mask;
 	}
@@ -1866,7 +1863,6 @@ static inline void rseq_fork(struct task_struct *t, unsigned long clone_flags)
 static inline void rseq_execve(struct task_struct *t)
 {
 	t->rseq = NULL;
-	t->rseq_len = 0;
 	t->rseq_sig = 0;
 	t->rseq_event_mask = 0;
 }
diff --git a/kernel/rseq.c b/kernel/rseq.c
index 849afe749131..9424ee90589e 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -313,7 +313,7 @@ SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, rseq_len,
 		/* Unregister rseq for current thread. */
 		if (current->rseq != rseq || !current->rseq)
 			return -EINVAL;
-		if (current->rseq_len != rseq_len)
+		if (rseq_len != sizeof(*rseq))
 			return -EINVAL;
 		if (current->rseq_sig != sig)
 			return -EPERM;
@@ -321,7 +321,6 @@ SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, rseq_len,
 		if (ret)
 			return ret;
 		current->rseq = NULL;
-		current->rseq_len = 0;
 		current->rseq_sig = 0;
 		return 0;
 	}
@@ -335,7 +334,7 @@ SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, rseq_len,
 		 * the provided address differs from the prior
 		 * one.
 		 */
-		if (current->rseq != rseq || current->rseq_len != rseq_len)
+		if (current->rseq != rseq || rseq_len != sizeof(*rseq))
 			return -EINVAL;
 		if (current->rseq_sig != sig)
 			return -EPERM;
@@ -353,7 +352,6 @@ SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, rseq_len,
 	if (!access_ok(rseq, rseq_len))
 		return -EFAULT;
 	current->rseq = rseq;
-	current->rseq_len = rseq_len;
 	current->rseq_sig = sig;
 	/*
 	 * If rseq was previously inactive, and has just been
-- 
2.11.0

