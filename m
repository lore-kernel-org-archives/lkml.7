Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F1E3C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 10:03:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EBEF2075E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 10:03:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fdnM3+wG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbfD3KDW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 06:03:22 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39268 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbfD3KDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 06:03:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=39jQJu1pe1SwtBVRvFUc6v25BF8YLDJOZ0iwNDid4sw=; b=fdnM3+wGbwVZVEY3nKXdhgTFR
        dq4kMJ+M/Fo86URyNEmTqhegBWXLApJtT1cQCGRZhE6IZgMwQiHRjEo8hJGtuqkxLyMjmKEDAKuyQ
        icr8yNzbCiQ2e41Qa2oBfmZ4FideevgGfmHlEa+fU+m6ajhdDFVFRLXOlA82MPsKlWYhwJ2HkMo2S
        C7O+ZIHCpudnuP31kKcPZG6CLicEOjvLI8IBqI0uPtvnpFts0NHIognu5ezPVFBey150X1IQ/WB4Y
        Qd2ezr6+P5S1kKWDn8btJxjGsTt80qQaX25iU7shLfYzMj9TAt0VaxKnfY7mb6CKWQEmp4GEAEFhn
        /ntbriRvg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hLPbd-0000S6-5u; Tue, 30 Apr 2019 10:03:21 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9B6DD29A242E4; Tue, 30 Apr 2019 12:03:18 +0200 (CEST)
Date:   Tue, 30 Apr 2019 12:03:18 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, andrea.parri@amarulasolutions.com
Subject: Re: Question about sched_setaffinity()
Message-ID: <20190430100318.GP2623@hirez.programming.kicks-ass.net>
References: <20190427180246.GA15502@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190427180246.GA15502@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 27, 2019 at 11:02:46AM -0700, Paul E. McKenney wrote:

> This actually passes rcutorture.  But, as Andrea noted, not klitmus.
> After some investigation, it turned out that klitmus was creating kthreads
> with PF_NO_SETAFFINITY, hence the failures.  But that prompted me to
> put checks into my code: After all, rcutorture can be fooled.
> 
> 	void synchronize_rcu(void)
> 	{
> 		int cpu;
> 
> 		for_each_online_cpu(cpu) {
> 			sched_setaffinity(current->pid, cpumask_of(cpu));
> 			WARN_ON_ONCE(raw_smp_processor_id() != cpu);
> 		}
> 	}
> 
> This triggers fairly quickly, usually in less than a minute of rcutorture
> testing.
>
> And further investigation shows that sched_setaffinity()
> always returned 0. 

> Is this expected behavior?  Is there some configuration or setup that I
> might be missing?

ISTR there is hotplug involved in RCU torture? In that case, it can be
sched_setaffinity() succeeds to place us on a CPU, which CPU hotplug
then takes away. So when we run the WARN thingy, we'll be running on a
different CPU than expected.

If OTOH, your loop is written like (as it really should be):

	void synchronize_rcu(void)
	{
		int cpu;

		cpus_read_lock();
		for_each_online_cpu(cpu) {
			sched_setaffinity(current->pid, cpumask_of(cpu));
			WARN_ON_ONCE(raw_smp_processor_id() != cpu);
		}
		cpus_read_unlock();
	}

Then I'm not entirely sure how we can return 0 and not run on the
expected CPU. If we look at __set_cpus_allowed_ptr(), the only paths out
to 0 are:

 - if the mask didn't change
 - if we already run inside the new mask
 - if we migrated ourself with the stop-task
 - if we're not in fact running

That last case should never trigger in your circumstances, since @p ==
current and current is obviously running. But for completeness, the
wakeup of @p would do the task placement in that case.

