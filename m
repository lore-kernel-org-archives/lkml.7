Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A47DDC606C1
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:23:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DA5A20665
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:23:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732600AbfGHPXT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 11:23:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:34854 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388157AbfGHPXO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 11:23:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BC5D9AF9C;
        Mon,  8 Jul 2019 15:23:12 +0000 (UTC)
Date:   Mon, 8 Jul 2019 17:23:11 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Andrea Parri <andrea.parri@amarulasolutions.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH POC] printk_ringbuffer: Alternative implementation of
 lockless printk ringbuffer
Message-ID: <20190708152311.7u6hs453phhjif3q@pathway.suse.cz>
References: <20190621140516.h36g4in26pe3rmly@pathway.suse.cz>
 <20190704103321.10022-1-pmladek@suse.com>
 <20190704103321.10022-1-pmladek@suse.com>
 <87r275j15h.fsf@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r275j15h.fsf@linutronix.de>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2019-07-04 16:59:54, John Ogness wrote:
> Hi Petr,
> 
> On 2019-07-04, Petr Mladek <pmladek@suse.com> wrote:
> > This is POC that implements the lockless printk ringbuffer slightly
> > different way. I believe that it is worth considering because it looks
> > much easier to deal with. The reasons are:
> >
> > 	+ The state of each entry is always clear.
> >
> > 	+ The write access rights and validity of the data
> > 	  are clear from the state of the entry.
> >
> > 	+ It seems that three barriers are enough to synchronize
> > 	  readers vs. writers. The rest is done implicitely
> > 	  using atomic operations.
> >
> > Of course, I might have missed some critical race that can't get
> > solved by the new design easily. But I do not see it at the moment.
> 
> Two things jump out at me when looking at the implementation:
> 
> 1. The code claims that the cmpxchg(seq_newest) in prb_reserve_desc()
> guarantees that "The descriptor is ours until the COMMITTED bit is set."
> This is not true if in that wind seq_newest wraps, allowing another
> writer to gain ownership of the same descriptor. For small descriptor
> arrays (such as in my test module), this situation is quite easy to
> reproduce.

I am not sure that I fully understand the problem. seq_newest
wraps at 2^30 (32-bit) and at 2^62 (64-bit). It takes a while
to reuse an existing one. And it does not depend on the size
of the array.

In addition, new sequence number can get assigned only when
the descriptor with the conflicting (sharing the same struct
prb_desc) sequence number is in reusable state. It means
that it has to be committed before.

> This was one of the reasons I chose to use a linked list. When the
> descriptor is atomically removed from the linked list, it can _never_ be
> used (or even seen) by any other writer until the owning writer is done
> with it.
> 
> I'm not yet sure how that could be fixed with this implementation. The
> state information is in a separate variable than the head pointer for
> the descriptor array (seq_newest). This means you cannot atomically
> reserve descriptors.

In my implementation, the sequence numbers are atomically reserved
in prb_reserve_desc() by

	} while (cmpxchg(&rb->seq_newest, seq_newest, seq) != newest_seqs);

where seq is always seq_newest + 1. We are here only when the
conflicting seq from the previous wrap is in reusable state
and the related datablock is moved outside valid lpos range.
This is ensured by prb_remove_desc_oldest(rb, seq_prev_wrap).

Now, the CPU that succeeded with cmpxchg() becomes
the exclusive owner of the respective descriptor. The sequence
number is written into this descriptor _after_ cmpxchg() succeeded.

It is safe because:

    + previous values are not longer used (descriptor has been marked
      as reusable, lpos from the related datablock were moved
      outside valid range (lpos_oldest, lpos_newest).

    + new values are ignored by readers and other writers until
      the right sequence number and the committed flag is set
      in the descriptor.


> 2. Another issue is when prb_reserve() fails and sets the descriptor as
> unused. As it is now, no reader can read beyond that descriptor until it
> is recycled. Readers need to know that the descriptor is bad and can be
> skipped over. It might be better to handle this the way I did: go ahead
> and set the state to committed, but have invalid lpos/lpos_next values
> (for example: lpos_next=lpos) so the reader knows it can skip over the
> descriptor.

This is exactly what the code does, see prb_make_desc_unused().
It marks the descriptor as committed so that it can get reused.
And it sets lpos and lpos_next to the same value so that
the situation can get eventually detected by readers.


> > The code compiles but it is not really tested. I wanted to send it
> > ASAP in a good enough state before we spend more time on cleaning
> > up either of the proposals.
> 
> I am glad to see you put together your implementation. If anything, it
> shows you understand the design! If after seeing my next version (v3)
> you are still convinced that using a linked list for the descriptors is
> too complex, then I can help support your idea to move to an array.

I am definitely interested into seeing v3 of your approach. I believe
that it will be much easier to understand. Then it will be easier to
compare.


BTW: There is one potential problem with my alternative approach.

     The descriptors and the related data blocks might get reserved
     in different order. Now, the descriptor might get reused only
     when the related datablock is moved outside the valid range.
     This operation might move also other data blocks outside
     the range and invalidate descriptors that were reserved later.
     As a result we might need to invalidate more messages in
     the log buffer then would be really necessary.

     If I get it properly, this problem does not exist with
     the implementation using links. It is because the descriptors
     are linked in the same order as the reserved data blocks.

     I am not sure how big the problem, with more invalidated messages,
     would be in reality. I am not sure if it would be worth
     a more complicated implementation.

     Alternative solution would be to somehow mix tricks from
     both approaches and get something that is easier to deal
     with and has less drawbacks. I am not sure it is possible.
     Anyway, I still need to fully understand the linked approach
     first.

Best Regards,
Petr
