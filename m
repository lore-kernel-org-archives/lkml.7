Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5666C282DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:31:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 684DD21479
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:31:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kWlRO6zX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728129AbfDSTbG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:31:06 -0400
Received: from merlin.infradead.org ([205.233.59.134]:52654 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728073AbfDSTbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:31:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ELa/BoNgogW09jPqV6H1rC+L+BJBVw6vxwUI191D8hQ=; b=kWlRO6zXEXZqa6Za2wVX+2R1o
        cmUblHpBVp0MNUYXtKkyY1wWjgn+Lj3Dzuv+sAMZ84bmnKT6dSYD9wnpavtSo4qiEustANW+lCPTb
        sELrhk57H6/m+ViJDrq/2GXv533o2Yo9hBXVtVRv3NX1emYl7M4fftKAWmu+w1i41qH4uFdCRjze9
        /DqlUGIJc4vCczT3BVu9GYLxDhfJvHFOzebmSvj2SKRMS4OR082mhgWq8bbWIG53PWOYaNZYn+Teq
        3zTCTpyAJZ4AKCtXfLaHVvdezz1fRb5DUOGKY13NN2PD2lfIILDyMQjqt7zauflkIDHAp4+vBVyNj
        b0PMN51+Q==;
Received: from [92.65.108.250] (helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hHQjR-0005A8-7V; Fri, 19 Apr 2019 10:26:57 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id A355E984EDA; Fri, 19 Apr 2019 12:26:47 +0200 (CEST)
Date:   Fri, 19 Apr 2019 12:26:47 +0200
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
Message-ID: <20190419102647.GP7905@worktop.programming.kicks-ass.net>
References: <20190413172259.2740-1-longman@redhat.com>
 <20190413172259.2740-15-longman@redhat.com>
 <20190418135151.GB12232@hirez.programming.kicks-ass.net>
 <d931916b-41f5-f12d-8c38-0cccbc00a301@redhat.com>
 <20190418144036.GE12232@hirez.programming.kicks-ass.net>
 <4cbd3c18-c9c0-56eb-4e01-ee355a69057a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4cbd3c18-c9c0-56eb-4e01-ee355a69057a@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2019 at 10:54:19AM -0400, Waiman Long wrote:
> On 04/18/2019 10:40 AM, Peter Zijlstra wrote:

> > Having more CPUs than that is not impossible these days.
> >
> 
> Having more than 32k CPUs contending for the same cacheline will be
> horribly slow.

No question about that.

> >> How about disabling preemption before fetch_all and re-enable
> >> it afterward to address the latter concern? 
> > Performance might be an issue, look at what preempt_disable() +
> > preempt_enable() generate for ARM64 for example. That's not particularly
> > pretty.
> 
> That is just for the preempt kernel. Right? Thinking about it some more,
> the above scenario is less likely to happen for CONFIG_PREEMPT_VOLUNTARY
> kernel and the preempt_disable cost will be lower.

Depends a bit on what specific CONFIG knobs are used. IIRC something
like NOHZ_FULL will also select PREEMPT_COUNT, it will just not have the
actual preemption calls in.

> A preempt RT kernel is less likely to run on system with many CPUs
> anyway. We could make that a conifg option as well in a follow-on
> patch and let the distributors decide.

RT has a whole different rwsem implementation anyway, so we don't need
to worry about them.

> >> I have no solution for the first case, though.

> > A cmpxchg() loop can fix this, but that again has performance
> > implications like you mentioned a while back.

I thought of a horrible horrible alternative:

union rwsem_count {
	struct { /* assuming LP64-LE */
		unsigned short  other[3];
		unsigned short  readers;
	};
	unsigned long	value;
};

void down_read(struct rw_semaphore *sem)
{
	union rwsem_count c;
	unsigned short o;

	c.value = atomic_long_read(&sem->count);
	c.readers++;

	if (!c.readers || (c.value & RWSEM_FLAG_WRITER))
		goto slow;

	o = xchg(&((union rwsem_count *)sem)->readers, c.readers);
	if (o != c.readers-1) {
		c.value = atomic_long_fetch_add(&sem->count, o-(c.readers-1));
	} else {
		c.value = atomic_long_read(&sem->count);
		c.readers = o + 1;
	}

	if (!(c.value & RWSEM_FLAG_WRITER))
		return;

slow:
	rwsem_down_read_slow(sem, c.value);
}

It is deterministic in that is has at most 2 unconditional atomic ops,
no cmpxchg loop, and a best case of a single op.
