Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51927C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 14:31:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1930E21479
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 14:31:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mlghnc4z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389315AbfDRObK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 10:31:10 -0400
Received: from merlin.infradead.org ([205.233.59.134]:40740 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388097AbfDRObJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 10:31:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=J1Rd8CJHOriTctJ+pY5mSELh59zsKZpvgRGWgzuNSlc=; b=mlghnc4zMJtXMOVGws2LWViNE
        wpdDlSyMTckeE2JlRdzDcVhbgK4WjXsiT939yYUV6IG4CQSwMnYR2kpXodB7O5Uf194cF1j52CQuD
        m2FDKU3xnIXfET0uc8ZzzMOSSacWioU22sqNSmehshicFLe0+IrAD2QVAn4unoByKR5eHhzsnwoA1
        6TIlDw9I1eE/9mz4LXaHevGymwsJGpf4B7VEwPXQoGN7pebxq8mfIuCVP3h5xGj7HhNpBEY/XZGyC
        pGMu5mZwUxmOYilXz8MBnPL2vMJmLRKkubUQycocx/vlR74eZBdVn9MeSor7T9XxpeGH4LfAhPH47
        tQZXmgQ0w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hH843-0002wY-TL; Thu, 18 Apr 2019 14:31:00 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9FF5329B9B7B7; Thu, 18 Apr 2019 16:30:58 +0200 (CEST)
Date:   Thu, 18 Apr 2019 16:30:58 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        huang ying <huang.ying.caritas@gmail.com>
Subject: Re: [PATCH v4 14/16] locking/rwsem: Guard against making count
 negative
Message-ID: <20190418143058.GD12232@hirez.programming.kicks-ass.net>
References: <20190413172259.2740-1-longman@redhat.com>
 <20190413172259.2740-15-longman@redhat.com>
 <20190418135151.GB12232@hirez.programming.kicks-ass.net>
 <d931916b-41f5-f12d-8c38-0cccbc00a301@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d931916b-41f5-f12d-8c38-0cccbc00a301@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2019 at 10:08:28AM -0400, Waiman Long wrote:
> On 04/18/2019 09:51 AM, Peter Zijlstra wrote:
> > On Sat, Apr 13, 2019 at 01:22:57PM -0400, Waiman Long wrote:
> >>  inline void __down_read(struct rw_semaphore *sem)
> >>  {
> >> +	long count = atomic_long_fetch_add_acquire(RWSEM_READER_BIAS,
> >> +						   &sem->count);
> >> +
> >> +	if (unlikely(count & RWSEM_READ_FAILED_MASK)) {
> >> +		rwsem_down_read_failed(sem, count);
> >>  		DEBUG_RWSEMS_WARN_ON(!is_rwsem_reader_owned(sem), sem);
> >>  	} else {
> >>  		rwsem_set_reader_owned(sem);
> > *groan*, that is not provably correct. It is entirely possible to get
> > enough fetch_add()s piled on top of one another to overflow regardless.
> >
> > Unlikely, yes, impossible, no.
> >
> > This makes me nervious as heck, I really don't want to ever have to
> > debug something like that :-(
> 
> The number of fetch_add() that can pile up is limited by the number of
> CPUs available in the system.

Uhhn, no. There is no preempt_disable() anywhere here. So even UP can
overflow if it has enough tasks.
