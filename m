Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7191FC282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FC7620645
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:06:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="L3EjChIT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729608AbfDSTGk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:06:40 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42949 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729239AbfDSTGW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:06:22 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3JAhmhv236701
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 19 Apr 2019 03:43:48 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3JAhmhv236701
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1555670629;
        bh=4R459gU3WfBGhvJB+jBso5J1ILgSpXhSaVVM7XigipA=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=L3EjChITixve5bm8l/3Vf1Yddg5qzLgLJJaM8GttoNUsyUk6qkzRALjZ2OBydOIuh
         TlcTWLC5YWO6c6JXRrwjuI2zFGJghFYKiMEinPiP3GiloglWX8Nk3/Dlo9VBWcj/yo
         ZcULs4dVv3ZohyPpoifRE1/tgjHohIXNd8HMYaGYfDxQ0OAB+kOlsAr2cCe6t2nNHN
         8+VsBfniOMoYBSSHFm3MoW0hWo2FS81VivH6DsQWddFMgcN4VkFno/yUcrEZdqSP+r
         CljCNYQOfafAVTxwDtAWgAbcuBVWxnSZrZgx0g9WPVNl3EC8YyBHZDiB0Fh7ZNmA9o
         AEp16HMXEc81A==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3JAhlJZ236698;
        Fri, 19 Apr 2019 03:43:47 -0700
Date:   Fri, 19 Apr 2019 03:43:47 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Mathieu Desnoyers <tipbot@zytor.com>
Message-ID: <tip-83b0b15bcb0f700e7c1d070aae2e7841170a4c33@git.kernel.org>
Cc:     linux@arm.linux.org.uk, mtk.manpages@gmail.com,
        catalin.marinas@arm.com, boqun.feng@gmail.com, davejwatson@fb.com,
        peterz@infradead.org, pjt@google.com, akpm@linux-foundation.org,
        josh@joshtriplett.org, cl@linux.com, linux-kernel@vger.kernel.org,
        will.deacon@arm.com, joelaf@google.com,
        torvalds@linux-foundation.org, hpa@zytor.com,
        mathieu.desnoyers@efficios.com, bmaurer@fb.com, tglx@linutronix.de,
        rostedt@goodmis.org, paulmck@linux.vnet.ibm.com, mingo@kernel.org,
        luto@amacapital.net
Reply-To: josh@joshtriplett.org, cl@linux.com,
          linux-kernel@vger.kernel.org, joelaf@google.com,
          will.deacon@arm.com, pjt@google.com, akpm@linux-foundation.org,
          boqun.feng@gmail.com, peterz@infradead.org, davejwatson@fb.com,
          linux@arm.linux.org.uk, mtk.manpages@gmail.com,
          catalin.marinas@arm.com, mingo@kernel.org, luto@amacapital.net,
          bmaurer@fb.com, rostedt@goodmis.org, tglx@linutronix.de,
          paulmck@linux.vnet.ibm.com, mathieu.desnoyers@efficios.com,
          hpa@zytor.com, torvalds@linux-foundation.org
In-Reply-To: <20190305194755.2602-3-mathieu.desnoyers@efficios.com>
References: <20190305194755.2602-3-mathieu.desnoyers@efficios.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:core/rseq] rseq: Remove superfluous rseq_len from task_struct
Git-Commit-ID: 83b0b15bcb0f700e7c1d070aae2e7841170a4c33
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

Commit-ID:  83b0b15bcb0f700e7c1d070aae2e7841170a4c33
Gitweb:     https://git.kernel.org/tip/83b0b15bcb0f700e7c1d070aae2e7841170a4c33
Author:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
AuthorDate: Tue, 5 Mar 2019 14:47:54 -0500
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 19 Apr 2019 12:39:32 +0200

rseq: Remove superfluous rseq_len from task_struct

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

No change in functionality intended.

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
Link: http://lkml.kernel.org/r/20190305194755.2602-3-mathieu.desnoyers@efficios.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/sched.h | 4 ----
 kernel/rseq.c         | 6 ++----
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 1549584a1538..50606a6e73d6 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1057,7 +1057,6 @@ struct task_struct {
 
 #ifdef CONFIG_RSEQ
 	struct rseq __user *rseq;
-	u32 rseq_len;
 	u32 rseq_sig;
 	/*
 	 * RmW on rseq_event_mask must be performed atomically
@@ -1855,12 +1854,10 @@ static inline void rseq_fork(struct task_struct *t, unsigned long clone_flags)
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
@@ -1869,7 +1866,6 @@ static inline void rseq_fork(struct task_struct *t, unsigned long clone_flags)
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
