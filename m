Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DE8AC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 07:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC7002133D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 07:16:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Dy8v+6Hg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbfDKHQk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 03:16:40 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36434 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbfDKHQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 03:16:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=4mcNXJvlohQBdQARF+BuZ/vie5JWkZ79tXZ3BKx5fv0=; b=Dy8v+6Hgm3ADk2e57EDPOLFfj
        07duP/Vzw0OKIKqfihsXrDyC5p/a1AK7diQ5/Ebjdt5SwchZNshEXtsrLDrOvt0sgwmcEQrlaj9bg
        OzdPkrkXKHzkjcUy2/y0gIgWHgD4KOGQVsUxT81FNLTq5h986YklcnSjhM61rwmcGNJdZ5H9ayiAA
        39jS3ilCQzPk7DOBODvvE9DhVKF1gAgjEWCt+8PLV9w/2Ucx7NQmcFqfzZFYJV0t1Z+jfGzz85UpW
        +LKymqIzeRuu9qnllK7u6g8zpL5Zyp2f2lp0UQG6m/ih7JoChU5HkRTxlRKVOGXyTA+O0s+KZNphs
        JXHL1TPCQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hETwo-0000zH-Ru; Thu, 11 Apr 2019 07:16:35 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9B9B729AA8DC3; Thu, 11 Apr 2019 09:16:32 +0200 (CEST)
Date:   Thu, 11 Apr 2019 09:16:32 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>
Subject: Re: [PATCH-tip v2 02/12] locking/rwsem: Implement lock handoff to
 prevent lock starvation
Message-ID: <20190411071632.GZ4038@hirez.programming.kicks-ass.net>
References: <20190405192115.17416-1-longman@redhat.com>
 <20190405192115.17416-3-longman@redhat.com>
 <20190410184429.GX4038@hirez.programming.kicks-ass.net>
 <bc06ff44-4dd0-f49c-c938-5f6c514e9596@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc06ff44-4dd0-f49c-c938-5f6c514e9596@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 10:25:16PM -0400, Waiman Long wrote:
> On 04/10/2019 02:44 PM, Peter Zijlstra wrote:

> > However there is another site that fiddles with the HANDOFF bit, namely
> > __rwsem_down_write_failed_common(), and that does:
> >
> > +                               atomic_long_or(RWSEM_FLAG_HANDOFF, &sem->count);
> >
> > _OUTSIDE_ of ->wait_lock, which would yield:
> >
> >   CPU0					CPU1
> >
> >   oldcount = atomic_long_fetch_add(adjustment, &sem->count)
> >
> > 					atomic_long_or(HANDOFF)
> >
> >   if (!(oldcount & HANDOFF))
> >     adjustment -= HANDOFF;
> >
> >   atomic_long_sub(adjustment)
> >
> > *whoops*, incremented HANDOFF on HANDOFF.
> >
> >
> > And there's not a comment in sight that would elucidate if this is
> > possible or not.
> >
> 
> A writer can only set the handoff bit if it is the first waiter in the
> queue. If it is the first waiter, a racing __rwsem_mark_wake() will see
> that the first waiter is a writer and so won't go into the reader path.
> I know I something don't spell out all the conditions that may look
> obvious to me but not to others. I will elaborate more in comments.

Aah, indeed.


