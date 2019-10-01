Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 749B8C352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 08:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 488C620815
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 08:51:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="zmVGODov"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728159AbfJAIvB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 04:51:01 -0400
Received: from merlin.infradead.org ([205.233.59.134]:59112 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727361AbfJAIvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 04:51:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3oH0vnApdKGvy1w7jlfeLiiAGy7wlNVNQLM6PmEPn3g=; b=zmVGODovfQUHsQeZRZEzeV65A
        Smxrv6hDX43SJXZJaC/l5fdrMBDkWQ/eqk4O7f9gMrrPFQgq52ZckL+UTKYxosDsgwr2ybCZvmdW+
        x3BWTxE6W3sjTrfY23z31va3jMnZ02CndPTwjIQ5DR65TaEObUCuRpAPSDte3BUMIQtzSeVBslKd9
        0MopjGj2yrdnKE+p+02qt+AzuaQEoUAQJH0PV+nKbwSViBqTblbWHCoEGZOsUtLbC0M2C3DMJtM8b
        djVMfLz5F8qdAXACcTPv5b474TY8JM/QsNKN5MIf0zuM9Y/iXS0wWViwyyzJ/c0GuqRLa3N0aYfkD
        VSYym0YRg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iFDrg-0002Hv-KY; Tue, 01 Oct 2019 08:50:37 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AE82B304B4C;
        Tue,  1 Oct 2019 10:49:45 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 083E4265299B1; Tue,  1 Oct 2019 10:50:34 +0200 (CEST)
Date:   Tue, 1 Oct 2019 10:50:33 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Chris Metcalf <cmetcalf@ezchip.com>,
        Christoph Lameter <cl@linux.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kirill Tkhai <tkhai@yandex.ru>, Mike Galbraith <efault@gmx.de>,
        Oleg Nesterov <oleg@redhat.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [tip: sched/urgent] sched/membarrier: Fix
 p->mm->membarrier_state racy load
Message-ID: <20191001085033.GP4519@hirez.programming.kicks-ass.net>
References: <20190919173705.2181-5-mathieu.desnoyers@efficios.com>
 <156957184332.9866.1795367595934026999.tip-bot2@tip-bot2>
 <20191001084405.GA115089@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191001084405.GA115089@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2019 at 10:44:05AM +0200, Ingo Molnar wrote:
> 
> * tip-bot2 for Mathieu Desnoyers <tip-bot2@linutronix.de> wrote:
> 
> > The following commit has been merged into the sched/urgent branch of tip:
> > 
> > Commit-ID:     227a4aadc75ba22fcb6c4e1c078817b8cbaae4ce
> > Gitweb:        https://git.kernel.org/tip/227a4aadc75ba22fcb6c4e1c078817b8cbaae4ce
> > Author:        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > AuthorDate:    Thu, 19 Sep 2019 13:37:02 -04:00
> > Committer:     Ingo Molnar <mingo@kernel.org>
> > CommitterDate: Wed, 25 Sep 2019 17:42:30 +02:00
> > 
> > sched/membarrier: Fix p->mm->membarrier_state racy load
> 
> > +	rcu_read_unlock();
> >  	if (!fallback) {
> >  		preempt_disable();
> >  		smp_call_function_many(tmpmask, ipi_mb, NULL, 1);
> > @@ -136,6 +178,7 @@ static int membarrier_private_expedited(int flags)
> >  	}
> >  
> >  	cpus_read_lock();
> > +	rcu_read_lock();
> >  	for_each_online_cpu(cpu) {
> >  		struct task_struct *p;
> >  
> > @@ -157,8 +200,8 @@ static int membarrier_private_expedited(int flags)
> >  			else
> >  				smp_call_function_single(cpu, ipi_mb, NULL, 1);
> >  		}
> > -		rcu_read_unlock();
> >  	}
> > +	rcu_read_unlock();
> 
> I noticed this too late, but the locking in this part is now bogus:
> 
> 	rcu_read_lock();
> 	for_each_online_cpu(cpu) {
> 		struct task_struct *p;
> 
> 		/*
> 		 * Skipping the current CPU is OK even through we can be
> 		 * migrated at any point. The current CPU, at the point
> 		 * where we read raw_smp_processor_id(), is ensured to
> 		 * be in program order with respect to the caller
> 		 * thread. Therefore, we can skip this CPU from the
> 		 * iteration.
> 		 */
> 		if (cpu == raw_smp_processor_id())
> 			continue;
> 		rcu_read_lock();

Yeah, that one needs to go.

> 		p = rcu_dereference(cpu_rq(cpu)->curr);
> 		if (p && p->mm == mm)
> 			__cpumask_set_cpu(cpu, tmpmask);
> 	}
> 	rcu_read_unlock();
> 
> Note the double rcu_read_lock() ....
> 
> This bug is now upstream, so requires an urgent fix, as it should be 
> trivial to trigger with pretty much any membarrier user.

---
Subject: membarrier: Fix faulty merge

Commit 227a4aadc75b ("sched/membarrier: Fix p->mm->membarrier_state racy
load") got fat fingered by me when merging it with other patches. It
meant to move the rcu section out of the for loop but ended up doing it
partially, leaving a superfluous rcu_read_lock() inside, causing havok.

Fixes: 227a4aadc75b ("sched/membarrier: Fix p->mm->membarrier_state racy load")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/membarrier.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/sched/membarrier.c b/kernel/sched/membarrier.c
index a39bed2c784f..168479a7d61b 100644
--- a/kernel/sched/membarrier.c
+++ b/kernel/sched/membarrier.c
@@ -174,7 +174,6 @@ static int membarrier_private_expedited(int flags)
 		 */
 		if (cpu == raw_smp_processor_id())
 			continue;
-		rcu_read_lock();
 		p = rcu_dereference(cpu_rq(cpu)->curr);
 		if (p && p->mm == mm)
 			__cpumask_set_cpu(cpu, tmpmask);
