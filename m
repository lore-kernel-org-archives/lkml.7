Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECB68C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 09:00:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC89B206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 09:00:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TE15QQH+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388342AbfDRJA6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 05:00:58 -0400
Received: from merlin.infradead.org ([205.233.59.134]:37518 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388195AbfDRJA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 05:00:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=yvS0k5aM27hlPF/X/NetOX/zP2CDvscIx40HsGn0V+g=; b=TE15QQH+J0bGEX9gYX0sejNVR
        C0dXnrNLV38tAzN+2yfZMAGyjEJhVl7PZPp6qzSGJOq+Hi8CE7UKty8nnYx4gM2xe25WwbYmnHG6I
        WYYbxfEpbw76RIgE0DjTXwqA10Tf4qNM0MF7HjwXq1vTiIHatLhO/+cHoyWpa4QXQAvFXcaxuyBkW
        XVu+CXbaCQv4af7lx+fMBJgF9cEewa8eptdeVhy98Extp8Nuyveo/vpi0YAWlIqAzfdXu702VHW8c
        I7tqOBWc/hZcVpTapNvp6dEqQTnTeFLlGup5QYrB50G3IdUxJGZmpOez8/cRKoT0Y46YGkABqSFNP
        bNd1TJj0g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hH2uX-0000kz-1R; Thu, 18 Apr 2019 09:00:49 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C509029B98541; Thu, 18 Apr 2019 11:00:47 +0200 (CEST)
Date:   Thu, 18 Apr 2019 11:00:47 +0200
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
Message-ID: <20190418090047.GX12232@hirez.programming.kicks-ass.net>
References: <20190413172259.2740-1-longman@redhat.com>
 <20190413172259.2740-12-longman@redhat.com>
 <20190417135841.GI4038@hirez.programming.kicks-ass.net>
 <8683197e-4eec-b89b-df44-3b61088944af@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8683197e-4eec-b89b-df44-3b61088944af@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 01:45:10PM -0400, Waiman Long wrote:
> On 04/17/2019 09:58 AM, Peter Zijlstra wrote:
> > On Sat, Apr 13, 2019 at 01:22:54PM -0400, Waiman Long wrote:
> >> +/*
> >> + * Try to acquire read lock before the reader is put on wait queue.
> >> + * Lock acquisition isn't allowed if the rwsem is locked or a writer handoff
> >> + * is ongoing.
> >> + */
> >> +static inline bool rwsem_try_read_lock_unqueued(struct rw_semaphore *sem)
> >> +{
> >> +	long count = atomic_long_read(&sem->count);
> >> +
> >> +	if (RWSEM_COUNT_WLOCKED_OR_HANDOFF(count))
> >> +		return false;
> >> +
> >> +	count = atomic_long_fetch_add_acquire(RWSEM_READER_BIAS, &sem->count);
> >> +	if (!RWSEM_COUNT_WLOCKED_OR_HANDOFF(count)) {
> >> +		rwsem_set_reader_owned(sem);
> >> +		lockevent_inc(rwsem_opt_rlock);
> >> +		return true;
> >> +	}
> >> +
> >> +	/* Back out the change */
> >> +	atomic_long_add(-RWSEM_READER_BIAS, &sem->count);
> >> +	return false;
> >> +}
> > Doesn't a cmpxchg 'loop' make more sense here?
> 
> Not really. A cmpxchg loop will have one more correctible failure mode -
> a new reader acquire the lock or a reader owner does an unlock. Failures
> caused by the setting of the handoff bit or writer acquiring the lock
> are the same for both cases. I don't see any advantage in using cmpxchg
> loop.

It depends on how many failures vs successes you have. I was expecting
failure to be the most common case, and then you go from 2 atomics to 1.


