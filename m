Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E6CEC2D0C2
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 10:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 457DF21D7D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 10:24:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727514AbgACKY0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 05:24:26 -0500
Received: from mx2.suse.de ([195.135.220.15]:47864 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725972AbgACKYZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 05:24:25 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C2B03B266;
        Fri,  3 Jan 2020 10:24:22 +0000 (UTC)
Date:   Fri, 3 Jan 2020 11:24:20 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Andrea Parri <parri.andrea@gmail.com>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        kexec@lists.infradead.org
Subject: Re: [RFC PATCH v5 1/3] printk-rb: new printk ringbuffer
 implementation (writer)
Message-ID: <20200103102420.n6i5chgxaygfvx5h@pathway.suse.cz>
References: <20191128015235.12940-1-john.ogness@linutronix.de>
 <20191128015235.12940-2-john.ogness@linutronix.de>
 <20191221142235.GA7824@andrea>
 <87imm7820z.fsf@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87imm7820z.fsf@linutronix.de>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2019-12-23 17:01:00, John Ogness wrote:
> Hi Andrea,
> 
> On 2019-12-21, Andrea Parri <parri.andrea@gmail.com> wrote:
> >> +	*desc_out = READ_ONCE(*desc);
> >> +
> >> +	/* Load data before re-checking state. */
> >> +	smp_rmb(); /* matches LMM_REF(desc_reserve:A) */
> >
> > I looked for a matching WRITE_ONCE() or some other type of marked write,
> > but I could not find it.  What is the rationale?  Or what did I miss?

Good question. READ_ONCE() looks superfluous here because it is
surrounded by two read barriers. In each case, there is no
corresponding WRITE_ONCE().

Note that we are copying the entire struct prb_desc here. All values
are written only when state_val is in desc_reserved state. It happens
between two full write barriers:

  + A writer is allowed to modify the descriptor after successful
    cmpxchg in desc_reserve(), see LMM_TAG(desc_reserve:A).

  + The writer must not touch the descriptor after changing
    state_var to committed state, see
    LMM_TAG(prb_commit:A) in prb_commit().

These barriers are mentioned in the comments for the two
read barriers here.

> >> +	do {
> >> +		next_lpos = get_next_lpos(data_ring, begin_lpos, size);
> >> +
> >> +		if (!data_push_tail(rb, data_ring,
> >> +				    next_lpos - DATA_SIZE(data_ring))) {
> >> +			/* Failed to allocate, specify a data-less block. */
> >> +			blk_lpos->begin = INVALID_LPOS;
> >> +			blk_lpos->next = INVALID_LPOS;
> >> +			return NULL;
> >> +		}
> >> +	} while (!atomic_long_try_cmpxchg(&data_ring->head_lpos, &begin_lpos,
> >> +					  next_lpos));
> >> +
> >> +	/*
> >> +	 * No barrier is needed here. The data validity is defined by
> >> +	 * the state of the associated descriptor. They are marked as
> >> +	 * invalid at the moment. And only the winner of the above
> >> +	 * cmpxchg() could write here.
> >> +	 */
> >
> > The (successful) CMPXCHG provides a full barrier.  This comment suggests
> > that that could be somehow relaxed?  Or the comment could be improved?
> 
> You are correct. There is no need for the full barrier here. This code
> is based on Petr's POC. I focussed on making sure needed barriers are in
> place, but did not try to eliminate excessive barriers.

I hope that I'll get better understanding of the guarantees
of different atomic operations one day. There are so many variants now.

BTW: Documentation/memory-barriers.txt describes various aspects of
the memory barriers. It describes implicit barriers provided
by spin locks, mutexes, semaphores, and various scheduler-related
operations.

But I can't find any explanation of the various variants of the atomic
operations: acquire, release, fetch, return, try, relaxed. I can find
some clues here and there but it is hard to get the picture.

Best Regards,
Petr
