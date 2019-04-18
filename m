Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07163C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 08:52:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB9432083D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 08:52:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fAK7nV75"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388280AbfDRIwn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 04:52:43 -0400
Received: from merlin.infradead.org ([205.233.59.134]:37426 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfDRIwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 04:52:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ABfuDNegMmvg64HlNWj/EUfOOiHsDeMbbxpXc0NqIN4=; b=fAK7nV75mYvErbSmiAxQBkXjX
        khDcOUJQU0c7rfZVGGW0+tHHV3CIoHN6gbRY2SxsR0Ir0upDNhjyYAw88qlHyY/gp3DOIRZRqwcAO
        oPKkmufVhv40v+t28qdYloXz7WKRTyIsavza5YQc6nxmLWoZHd7/KlFYc7OsqpBuF7GmmJslrDThL
        vIFQtNsNIfiFOBxw3yN4bAfD9jjQUfVA6wFdqQxJKNGQHiU815NaG4Qnc3fBW54QF/k5sUhSOjgNS
        MJRD+59JVF7uFGwKBLaV8DhTFfYUlchcy0DGRC1YYO4KuwSDUCdli/HtBqMLKkGQ9ISULuzPjBr09
        pynYN87jA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hH2mT-0000j4-UE; Thu, 18 Apr 2019 08:52:30 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E53A129B98550; Thu, 18 Apr 2019 10:52:27 +0200 (CEST)
Date:   Thu, 18 Apr 2019 10:52:27 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        huang ying <huang.ying.caritas@gmail.com>
Subject: Re: [PATCH v4 09/16] locking/rwsem: Ensure an RT task will not spin
 on reader
Message-ID: <20190418085227.GV12232@hirez.programming.kicks-ass.net>
References: <20190413172259.2740-1-longman@redhat.com>
 <20190413172259.2740-10-longman@redhat.com>
 <20190417131841.GF4038@hirez.programming.kicks-ass.net>
 <1c37b8f2-232e-7ced-0483-31c8c6a4ffd1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c37b8f2-232e-7ced-0483-31c8c6a4ffd1@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 02:47:07PM -0400, Waiman Long wrote:
> >> @@ -566,13 +573,28 @@ static bool rwsem_optimistic_spin(struct rw_semaphore *sem)
> >>  		}
> >>  
> >>  		/*
> >> -		 * When there's no owner, we might have preempted between the
> >> -		 * owner acquiring the lock and setting the owner field. If
> >> -		 * we're an RT task that will live-lock because we won't let
> >> -		 * the owner complete.
> >> +		 * An RT task cannot do optimistic spinning if it cannot
> >> +		 * be sure the lock holder is running or live-lock may
> >> +		 * happen if the current task and the lock holder happen
> >> +		 * to run in the same CPU.
> >> +		 *
> >> +		 * When there's no owner or is reader-owned, an RT task
> >> +		 * will stop spinning if the owner state is not a writer
> >> +		 * at the previous iteration of the loop. This allows the
> >> +		 * RT task to recheck if the task that steals the lock is
> >> +		 * a spinnable writer. If so, it can keeps on spinning.
> >> +		 *
> >> +		 * If the owner is a writer, the need_resched() check is
> >> +		 * done inside rwsem_spin_on_owner(). If the owner is not
> >> +		 * a writer, need_resched() check needs to be done here.
> >>  		 */
> >> -		if (!sem->owner && (need_resched() || rt_task(current)))
> >> -			break;
> >> +		if (owner_state != OWNER_WRITER) {
> >> +			if (need_resched())
> >> +				break;
> >> +			if (is_rt_task && (prev_owner_state != OWNER_WRITER))
> >> +				break;
> >> +		}
> >> +		prev_owner_state = owner_state;
> >>  
> >>  		/*
> >>  		 * The cpu_relax() call is a compiler barrier which forces
> > This patch confuses me mightily. I mean, I see what it does, but I can't
> > figure out why. The Changelog is just one big source of confusion.
> 
> Sorry for confusing you. If count and owner are separate, there is a
> time lag where the owner is NULL, but the lock is not free yet.

Right.

> Similarly, the lock could be free but another task may have stolen the
> lock if the waiter bit isn't set.

> In the former case,

(free)

> an extra iteration gives it more time for the lock holder to release
> the lock.


> In the latter case,

(stolen)

> if the new lock owner is a writer and set owner in time,
> the RT task can keep on spinning. Will clarify that in the commit log
> and the comment.

Blergh.. so by going around once extra, you hope ->owner will be set
again and we keep spinning. And this is actually measurable.

Yuck yuck yuck. I much prefer getting rid of that hole, as you do later
on in the series, that would avoid this complecity. Let me continue
reading...



