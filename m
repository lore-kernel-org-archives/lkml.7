Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E016EC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 14:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0A982183E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 14:40:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DcwjK6XQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389276AbfDROkn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 10:40:43 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57292 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731317AbfDROkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 10:40:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=fLXzu6aQ2r9iLPnXbOeIFwwObsTLPBzstUXrcF7xVLU=; b=DcwjK6XQIr02F1B9KQ1eUFZq+
        pPUB2jesFAYjJ7cCjcZLhrMfXU88hOsKQFWoRLjDN75AVg1FlYIIXQCY6xp3cDSIZ79T2nXCaM6iz
        CwSBcqsoa3vUgJDe1h0oKsjudJg94Hm0GIEwglpI4HhYrHTfcmrrU9DHCHTQrz9BpRKbOeeGNNIEK
        bMqTx01FsPtsxcIwi6KYTxkliaSdLq72hw5TaxFmNZO4GjTU/MIMZo6s14nlCzSENmMeYIo5sbfYg
        Z2zCqiUiPSqAvyf8BqzFUeoyTOZMDibeDT4QWBI0cY8rudalACVpULL1NfSyktAjSE4ziBjqmy67j
        XuydThd6g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hH8DO-0003p8-JY; Thu, 18 Apr 2019 14:40:38 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9A7BB29BB189E; Thu, 18 Apr 2019 16:40:36 +0200 (CEST)
Date:   Thu, 18 Apr 2019 16:40:36 +0200
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
Message-ID: <20190418144036.GE12232@hirez.programming.kicks-ass.net>
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

> Yes, if you have a 32k processor system that have all the CPUs trying
> to acquire the same read-lock, we will have a problem.

Having more CPUs than that is not impossible these days.

> Or as Linus had said that if we could have tasks kept
> preempted right after doing the fetch_add with newly scheduled tasks
> doing the fetch_add at the same lock again, we could have overflow with
> less CPUs.

That.

> How about disabling preemption before fetch_all and re-enable
> it afterward to address the latter concern? 

Performance might be an issue, look at what preempt_disable() +
preempt_enable() generate for ARM64 for example. That's not particularly
pretty.

> I have no solution for the first case, though.

A cmpxchg() loop can fix this, but that again has performance
implications like you mentioned a while back.
