Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E193FC3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 11:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B86BA22DBF
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 11:28:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mYBA1iC8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729493AbfIDL2j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 07:28:39 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53658 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727351AbfIDL2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 07:28:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ylEYuetQjRSTjE1zCpDEWeA2Rhzr2VKqQz1x4DO54Ds=; b=mYBA1iC87c0Wifn9jMnoJAkC9
        GBfiEPqEwwGDBj33t+snQ/+CE2BgmzBICVrwMZ/I/KZIoatF8uOW9HqlmLwdjJ/xfpLMg+IzrD/9Q
        O4eOnnVjfIBIG/ELqQvl0Mh8Fc5r1e/ZmAX8b/KurwtBvBD1n1kTlUnHigPPjr2f5NoEpDIrh6gOH
        woAnK1XrgwIAszYsd6wxKP09VDRfBk/W8Bjwe/m3RcX3d1JbW8zSYP1GyN9gmGiCy3RxLNZ6kzqZw
        ztrGuHQijWzK5jAnJDN52lYQPc45Lh3HbkxDQHM+OEcXK6UH96aFFH1IEwcxFuVm3qz8K1zvWV5rO
        zOz2jw7zQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i5TSZ-0004nM-4W; Wed, 04 Sep 2019 11:28:23 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5AF8D306027;
        Wed,  4 Sep 2019 13:27:43 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D348529C0A898; Wed,  4 Sep 2019 13:28:19 +0200 (CEST)
Date:   Wed, 4 Sep 2019 13:28:19 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     paulmck <paulmck@linux.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Russell King, ARM Linux" <linux@armlinux.org.uk>,
        Chris Metcalf <cmetcalf@ezchip.com>,
        Chris Lameter <cl@linux.com>, Kirill Tkhai <tkhai@yandex.ru>,
        Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [RFC PATCH 1/2] Fix: sched/membarrier: p->mm->membarrier_state
 racy load
Message-ID: <20190904112819.GD2349@hirez.programming.kicks-ass.net>
References: <20190903201135.1494-1-mathieu.desnoyers@efficios.com>
 <20190903202434.GX2349@hirez.programming.kicks-ass.net>
 <1029906102.725.1567543307658.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1029906102.725.1567543307658.JavaMail.zimbra@efficios.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 03, 2019 at 04:41:47PM -0400, Mathieu Desnoyers wrote:
> As discussed on IRC, one alternative for the multi-threaded case would
> be to grab the task list lock and iterate over all existing tasks to
> set the bit, so we don't have to touch an extra cache line from the
> scheduler.
> 
> In order to keep the speed of the common single-threaded library
> constructor common case fast, we simply set the bit in the current
> task struct, and rely on clone() propagating the flag to children
> threads (which it already does).

Something like the completely untested thing below.

And yes, that do_each_thread/while_each_thread thing is unfortunate and
yuck too, but supposedly that's a slow path not many people are expected
to hit anyway, right?

---
 include/linux/sched.h     |  4 ++++
 kernel/sched/membarrier.c | 20 +++++++++++++++++---
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 33b310a826d7..dbafafb8ef40 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1136,6 +1136,10 @@ struct task_struct {
 	unsigned long			numa_pages_migrated;
 #endif /* CONFIG_NUMA_BALANCING */
 
+#ifdef CONFIG_MEMBARRIER
+	atomic_t			membarrier_state;
+#endif
+
 #ifdef CONFIG_RSEQ
 	struct rseq __user *rseq;
 	u32 rseq_sig;
diff --git a/kernel/sched/membarrier.c b/kernel/sched/membarrier.c
index aa8d75804108..961f6affbf38 100644
--- a/kernel/sched/membarrier.c
+++ b/kernel/sched/membarrier.c
@@ -72,8 +72,8 @@ static int membarrier_global_expedited(void)
 
 		rcu_read_lock();
 		p = task_rcu_dereference(&cpu_rq(cpu)->curr);
-		if (p && p->mm && (atomic_read(&p->mm->membarrier_state) &
-				   MEMBARRIER_STATE_GLOBAL_EXPEDITED)) {
+		if (p && (atomic_read(&p->membarrier_state) &
+			  MEMBARRIER_STATE_GLOBAL_EXPEDITED)) {
 			if (!fallback)
 				__cpumask_set_cpu(cpu, tmpmask);
 			else
@@ -185,7 +185,9 @@ static int membarrier_register_global_expedited(void)
 	if (atomic_read(&mm->membarrier_state) &
 	    MEMBARRIER_STATE_GLOBAL_EXPEDITED_READY)
 		return 0;
+
 	atomic_or(MEMBARRIER_STATE_GLOBAL_EXPEDITED, &mm->membarrier_state);
+	atomic_or(MEMBARRIER_STATE_GLOBAL_EXPEDITED, &p->membarrier_state);
 	if (atomic_read(&mm->mm_users) == 1 && get_nr_threads(p) == 1) {
 		/*
 		 * For single mm user, single threaded process, we can
@@ -196,6 +198,17 @@ static int membarrier_register_global_expedited(void)
 		 */
 		smp_mb();
 	} else {
+		struct task_struct *g, *t;
+
+		read_lock(&tasklist_lock);
+		do_each_thread(g, t) {
+			if (t->mm == mm) {
+				atomic_or(MEMBARRIER_STATE_GLOBAL_EXPEDITED,
+					  &t->membarrier_state);
+			}
+		} while_each_thread(g, t);
+		read_unlock(&tasklist_lock);
+
 		/*
 		 * For multi-mm user threads, we need to ensure all
 		 * future scheduler executions will observe the new
@@ -229,9 +242,10 @@ static int membarrier_register_private_expedited(int flags)
 	if (atomic_read(&mm->membarrier_state) & state)
 		return 0;
 	atomic_or(MEMBARRIER_STATE_PRIVATE_EXPEDITED, &mm->membarrier_state);
-	if (flags & MEMBARRIER_FLAG_SYNC_CORE)
+	if (flags & MEMBARRIER_FLAG_SYNC_CORE) {
 		atomic_or(MEMBARRIER_STATE_PRIVATE_EXPEDITED_SYNC_CORE,
 			  &mm->membarrier_state);
+	}
 	if (!(atomic_read(&mm->mm_users) == 1 && get_nr_threads(p) == 1)) {
 		/*
 		 * Ensure all future scheduler executions will observe the
