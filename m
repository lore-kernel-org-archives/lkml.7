Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EB90C43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 12:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1E8F2064B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 12:32:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="B6CI9VtI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbfLFMcM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 07:32:12 -0500
Received: from merlin.infradead.org ([205.233.59.134]:47668 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbfLFMcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 07:32:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=HChchxal1vKq3ok9Joj98uYh27jwuE/ofFxDJGk+ASg=; b=B6CI9VtIRPr1O5K5oFxkxH5pn
        Qtbs1WM//zfvRRmwZzBwTTqQ2PXrsqKccu9XPfWLYRtW7m95WwUEYJ4dCR3pzdcTA3I0A3jHjJJ1u
        W1ApRNjW8d/N61mN8wd3RA4P4LHpKi6JO19H8MQNkxogHbbaHm1WapqDvQ2D/sTXtd6GHcIVzRK0b
        nS5fDUsiP/q/y4rvOSjGuFBK16U9l2x+GBaftUelvsqIP+t7HK6fDX72IoBmpx03/iED40OKsn0c1
        EGwe9sXh6WwMKFV52/hyikdWLPmM36zxkrnJnAPgwNBgi1uxJF34DiuC9e/ewNCgEXoVGBzslyrZs
        OVfmWK9+A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1idCmC-00070O-BV; Fri, 06 Dec 2019 12:32:04 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2DB9430025A;
        Fri,  6 Dec 2019 13:30:44 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D19232B27F3BE; Fri,  6 Dec 2019 13:32:01 +0100 (CET)
Date:   Fri, 6 Dec 2019 13:32:01 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: Problem with WARN_ON in mutex_trylock() and rxrpc
Message-ID: <20191206123201.GC2871@hirez.programming.kicks-ass.net>
References: <26229.1575547344@warthog.procyon.org.uk>
 <20191205132212.GK2827@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191205132212.GK2827@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 05, 2019 at 02:22:12PM +0100, Peter Zijlstra wrote:

> At the very least I'm going to do a lockdep patch that verifies the lock
> stack is 'empty' for the current irq_context when it changes.

Something like the below..

diff --git a/include/linux/irqflags.h b/include/linux/irqflags.h
index 21619c92c377..c0a314dc9969 100644
--- a/include/linux/irqflags.h
+++ b/include/linux/irqflags.h
@@ -21,11 +21,13 @@
   extern void trace_softirqs_off(unsigned long ip);
   extern void lockdep_hardirqs_on(unsigned long ip);
   extern void lockdep_hardirqs_off(unsigned long ip);
+  extern void lockdep_leave_irq_context(void);
 #else
   static inline void trace_softirqs_on(unsigned long ip) { }
   static inline void trace_softirqs_off(unsigned long ip) { }
   static inline void lockdep_hardirqs_on(unsigned long ip) { }
   static inline void lockdep_hardirqs_off(unsigned long ip) { }
+  static inline void lockdep_leave_irq_context(void) { }
 #endif
 
 #ifdef CONFIG_TRACE_IRQFLAGS
@@ -41,6 +43,8 @@ do {						\
 } while (0)
 # define trace_hardirq_exit()			\
 do {						\
+	if (current->hardirq_context == 1)	\
+		lockdep_leave_irq_context();	\
 	current->hardirq_context--;		\
 } while (0)
 # define lockdep_softirq_enter()		\
@@ -49,6 +53,8 @@ do {						\
 } while (0)
 # define lockdep_softirq_exit()			\
 do {						\
+	if (current->softirq_context == 1)	\
+		lockdep_leave_irq_context();	\
 	current->softirq_context--;		\
 } while (0)
 #else
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 32282e7112d3..5c1102967927 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -3600,6 +3600,43 @@ static inline unsigned int task_irq_context(struct task_struct *task)
 	return 2 * !!task->hardirq_context + !!task->softirq_context;
 }
 
+/*
+ * Validate the current irqcontext holds no locks.
+ */
+void lockdep_leave_irq_context(void)
+{
+	struct task_struct *curr = current;
+	unsigned int irq_context = task_irq_context(curr);
+	int depth = curr->lockdep_depth;
+	struct held_lock *hlock;
+
+	if (unlikely(!debug_locks || curr->lockdep_recursion))
+		return;
+
+	if (!depth)
+		return;
+
+	if (curr->held_locks[depth-1].irq_context != irq_context)
+		return;
+
+	pr_warn("\n");
+	pr_warn("========================================================\n");
+	pr_warn("WARNING: Leaving (soft/hard) IRQ context with locks held\n");
+	print_kernel_ident();
+	pr_warn("--------------------------------------------------------\n");
+
+	for (; depth; depth--) {
+		hlock = curr->held_locks + depth - 1;
+		if (hlock->irq_context != irq_context)
+			break;
+		print_lock(hlock);
+	}
+
+	pr_warn("\nstack backtrace:\n");
+	dump_stack();
+}
+NOKPROBE_SYMBOL(lockdep_leave_irq_context);
+
 static int separate_irq_context(struct task_struct *curr,
 		struct held_lock *hlock)
 {
