Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11E2CC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 07:58:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5E3020830
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 07:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557129529;
	bh=N510lvAJHM1RtRz9MAGMqY53fWR8sJhst1MSGoGY5mU=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=wLqGlE0gaBqFOxoJG8D/iA0xj7A4kgVmNpe32e/AWJRqfXwhnNBbG0eo990hSWGLz
	 bviR3m+V43O2EgzPW9qe3H6jjCpj+tr1vtGElctsJUxy5j3d3GxEgHvJ+lsuA6lIb/
	 UwNHVu4MYTvyR3lw/MME2ZRw1TndYD0zLBquV5N8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbfEFH6s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 03:58:48 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53674 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbfEFH6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 03:58:48 -0400
Received: by mail-wm1-f68.google.com with SMTP id q15so14510619wmf.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 00:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=hMsigY1Aef26SrDtiaLKRzrq5Qsr8HjliKK2zYWbA5k=;
        b=ZVHea1d8Pq8QwqakWeit6NGozGPdIWRe4bLUsMVRAlkkSL4TG7uJ3mXnaexFvPNGL9
         tcbrPeiiC/ljEW7lL0RfllNnkAPARljg63m0tU6B3VkA+NqQmGJbYBlN+mM5kywhXPBj
         zyGyKUnCJXjngIoVgSBA0BRtgyQI0fvlIBHZo32dw9XMaE3sFpmy+/5M018SgI63988J
         BFHC5iTsUfQ5z0WYXSz/41UrBB0igW7rbkfbvbcdhzIWyAX3ckiZHH3TPgehEz9kUYde
         w+ZOVgFiVJS5OEKxE0/WzsTg0q+EEx8qS38u7t9REq7FrqU41rGUDBkEVXCEOyRhlw51
         acRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=hMsigY1Aef26SrDtiaLKRzrq5Qsr8HjliKK2zYWbA5k=;
        b=gbrUBThrksP4YhmmoROu31ZI9lHDbwlqww8PAVwm/wUnJAQXogSn5JLZ0N3OEcNMTK
         qisPZRTw40ApsOSWmIHl0n3LIj5vPeGmypDAcztJ6u6DY++bAaa8TbPvGs2GHTJCqQ3o
         Yx5X4gtCg2oG8DpyiJwaOq00XxUiX1XMsqzWSjt8k7+BvV6VSWdv9yI1uyuI3CFHDHPZ
         9JdJzU8KXO5KuR21YIPQuqPzUwZoesM1oopEAY5Gg/GczqPZr2wkkctGlIvi46E8/rU0
         cCfMRxxFZZkLYQy2ikN9awZAxoyMVBsiwKbpdU+WOcotDKf2tztkBJAeuSIg/Xfq0ZRb
         rhzA==
X-Gm-Message-State: APjAAAVCGybDlwHsfypsM7AuRjcisVj3vUnKbCIhBMdBCtYrrCtDa+kY
        rbuhx5tVFVKsQr+yr6CbtOg=
X-Google-Smtp-Source: APXvYqyP+4MeAIgRFDGiYP5HbliKj5W637u6EPtPdVNn7rMExu4XR+W9DyXOpY4v57DI/PO2fjmlvw==
X-Received: by 2002:a1c:b189:: with SMTP id a131mr15389607wmf.107.1557129525946;
        Mon, 06 May 2019 00:58:45 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id v16sm10769046wru.76.2019.05.06.00.58.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 May 2019 00:58:45 -0700 (PDT)
Date:   Mon, 6 May 2019 09:58:42 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: [GIT PULL] RSEQ updates for v5.2
Message-ID: <20190506075842.GA110441@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest core-rseq-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-rseq-for-linus

   # HEAD: 83b0b15bcb0f700e7c1d070aae2e7841170a4c33 rseq: Remove superfluous rseq_len from task_struct

A cleanup and a fix to comments.

 Thanks,

	Ingo

------------------>
Mathieu Desnoyers (2):
      rseq: Clean up comments by reflecting removal of event counter
      rseq: Remove superfluous rseq_len from task_struct


 arch/arm/kernel/signal.c | 3 +--
 arch/x86/kernel/signal.c | 5 +----
 include/linux/sched.h    | 4 ----
 kernel/rseq.c            | 9 +++------
 4 files changed, 5 insertions(+), 16 deletions(-)

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
index 25e9a7b60eba..9424ee90589e 100644
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
@@ -314,7 +313,7 @@ SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, rseq_len,
 		/* Unregister rseq for current thread. */
 		if (current->rseq != rseq || !current->rseq)
 			return -EINVAL;
-		if (current->rseq_len != rseq_len)
+		if (rseq_len != sizeof(*rseq))
 			return -EINVAL;
 		if (current->rseq_sig != sig)
 			return -EPERM;
@@ -322,7 +321,6 @@ SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, rseq_len,
 		if (ret)
 			return ret;
 		current->rseq = NULL;
-		current->rseq_len = 0;
 		current->rseq_sig = 0;
 		return 0;
 	}
@@ -336,7 +334,7 @@ SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, rseq_len,
 		 * the provided address differs from the prior
 		 * one.
 		 */
-		if (current->rseq != rseq || current->rseq_len != rseq_len)
+		if (current->rseq != rseq || rseq_len != sizeof(*rseq))
 			return -EINVAL;
 		if (current->rseq_sig != sig)
 			return -EPERM;
@@ -354,7 +352,6 @@ SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, rseq_len,
 	if (!access_ok(rseq, rseq_len))
 		return -EFAULT;
 	current->rseq = rseq;
-	current->rseq_len = rseq_len;
 	current->rseq_sig = sig;
 	/*
 	 * If rseq was previously inactive, and has just been
