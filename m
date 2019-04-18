Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78546C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 08:57:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4621B217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 08:57:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YCY2bSLh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388351AbfDRI5Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 04:57:16 -0400
Received: from merlin.infradead.org ([205.233.59.134]:37482 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388196AbfDRI5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 04:57:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=D7zLSethVEHi5khOP5DxgDAOzGNMwOwjlxQFcCjRB10=; b=YCY2bSLhNMwOPC9qSyTNvm8PI
        QgyRNywbT/boF4zeFD90uc0T9Vdm/R0M28Kj7yl3NEDh9vGEuaQ2kvv28CA9Zr+shh/ZsRwlSWsLy
        N5UUQBoXY4Sq0FS2CzvFblZh7Fu2dF/O4mbnWR8/RY2JELoVZ94KoiX88bBG/+wmj+wcgpLsShp9S
        CzB59tW4Dd08tiNwAmwDxsjXYwcKTKQcd8lFihwbxJMWbl5vkMegKxIn6Q3CjY8OxrN4idT+i5rnk
        KOAn5QL+jLw1UmRO1uANmxrRCQbbXgqM4Sh/nIRka9StnGWhWHKg/f/1KejQs1mVTEY0qr+ecRmVn
        LOAuoKH4w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hH2qt-0000k6-IL; Thu, 18 Apr 2019 08:57:03 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1F64529B98552; Thu, 18 Apr 2019 10:57:02 +0200 (CEST)
Date:   Thu, 18 Apr 2019 10:57:02 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        huang ying <huang.ying.caritas@gmail.com>
Subject: Re: [PATCH v4 11/16] locking/rwsem: Enable readers spinning on writer
Message-ID: <20190418085702.GW12232@hirez.programming.kicks-ass.net>
References: <20190413172259.2740-1-longman@redhat.com>
 <20190413172259.2740-12-longman@redhat.com>
 <20190417135659.GH4038@hirez.programming.kicks-ass.net>
 <725e9765-b46e-5adb-1e81-90aefc6c38ad@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <725e9765-b46e-5adb-1e81-90aefc6c38ad@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 01:34:01PM -0400, Waiman Long wrote:
> On 04/17/2019 09:56 AM, Peter Zijlstra wrote:
> > On Sat, Apr 13, 2019 at 01:22:54PM -0400, Waiman Long wrote:
> >> @@ -549,7 +582,7 @@ static noinline enum owner_state rwsem_spin_on_owner(struct rw_semaphore *sem)
> >>  	return !owner ? OWNER_NULL : OWNER_READER;
> >>  }
> >>  
> >> -static bool rwsem_optimistic_spin(struct rw_semaphore *sem)
> >> +static bool rwsem_optimistic_spin(struct rw_semaphore *sem, bool wlock)
> >>  {
> >>  	bool taken = false;
> >>  	bool is_rt_task = rt_task(current);
> >> @@ -558,9 +591,6 @@ static bool rwsem_optimistic_spin(struct rw_semaphore *sem)
> >>  	preempt_disable();
> >>  
> >>  	/* sem->wait_lock should not be held when doing optimistic spinning */
> >> -	if (!rwsem_can_spin_on_owner(sem))
> >> -		goto done;
> >> -
> >>  	if (!osq_lock(&sem->osq))
> >>  		goto done;
> >>  
> >> @@ -580,10 +610,11 @@ static bool rwsem_optimistic_spin(struct rw_semaphore *sem)
> >>  		/*
> >>  		 * Try to acquire the lock
> >>  		 */
> >> -		if (rwsem_try_write_lock_unqueued(sem)) {
> >> -			taken = true;
> >> +		taken = wlock ? rwsem_try_write_lock_unqueued(sem)
> >> +			      : rwsem_try_read_lock_unqueued(sem);
> >> +
> >> +		if (taken)
> >>  			break;
> >> -		}
> >>  
> >>  		/*
> >>  		 * An RT task cannot do optimistic spinning if it cannot
> > Alternatively you pass the trylock function as an argument:
> >
> > static bool rwsem_optimistic_spin(struct rw_semaphore *sem,
> > 				  bool (*trylock)(struct rw_semaphore *sem))
> > {
> > 	...
> > 		if (trylock(sem)) {
> > 			taken = true;
> > 			goto unlock;
> > 		}
> > 	...
> > }
> >
> With retpoline, an indirect function call will be slower.

With compiler optimization we can avoid that. Just mark the function as
__always_inline, there's only two call-sites, each with a different
trylock.

It might have already done that anyway, and used constant propagation
on your bool, but the function pointer one is far easier to read.
