Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94487C606CF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 01:34:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6573C21537
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 01:34:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726580AbfGIBex (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 21:34:53 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43572 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbfGIBew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 21:34:52 -0400
Received: from localhost ([127.0.0.1] helo=vostro.local)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1hkf1p-0003xm-RV; Tue, 09 Jul 2019 03:34:45 +0200
From:   John Ogness <john.ogness@linutronix.de>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Andrea Parri <andrea.parri@amarulasolutions.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH POC] printk_ringbuffer: Alternative implementation of lockless printk ringbuffer
References: <20190621140516.h36g4in26pe3rmly@pathway.suse.cz>
        <20190704103321.10022-1-pmladek@suse.com>
        <20190704103321.10022-1-pmladek@suse.com>
        <87r275j15h.fsf@linutronix.de>
        <20190708152311.7u6hs453phhjif3q@pathway.suse.cz>
Date:   Tue, 09 Jul 2019 03:34:43 +0200
In-Reply-To: <20190708152311.7u6hs453phhjif3q@pathway.suse.cz> (Petr Mladek's
        message of "Mon, 8 Jul 2019 17:23:11 +0200")
Message-ID: <874l3wng7g.fsf@linutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-07-08, Petr Mladek <pmladek@suse.com> wrote:
>>> This is POC that implements the lockless printk ringbuffer slightly
>>> different way. I believe that it is worth considering because it looks
>>> much easier to deal with. The reasons are:
>>>
>>> 	+ The state of each entry is always clear.
>>>
>>> 	+ The write access rights and validity of the data
>>> 	  are clear from the state of the entry.
>>>
>>> 	+ It seems that three barriers are enough to synchronize
>>> 	  readers vs. writers. The rest is done implicitely
>>> 	  using atomic operations.
>>>
>>> Of course, I might have missed some critical race that can't get
>>> solved by the new design easily. But I do not see it at the moment.
>> 
>> Two things jump out at me when looking at the implementation:
>> 
>> 1. The code claims that the cmpxchg(seq_newest) in prb_reserve_desc()
>> guarantees that "The descriptor is ours until the COMMITTED bit is
>> set."  This is not true if in that wind seq_newest wraps, allowing
>> another writer to gain ownership of the same descriptor. For small
>> descriptor arrays (such as in my test module), this situation is
>> quite easy to reproduce.
>
> I am not sure that I fully understand the problem. seq_newest
> wraps at 2^30 (32-bit) and at 2^62 (64-bit). It takes a while
> to reuse an existing one. And it does not depend on the size
> of the array.

I am not referring to unsigned long overflowing. I am referring to array
index wrapping. This _does_ depend on the size of the array.

> In addition, new sequence number can get assigned only when
> the descriptor with the conflicting (sharing the same struct
> prb_desc) sequence number is in reusable state. It means
> that it has to be committed before.

Correct. But taking it _out_ of the reusable state is not atomic, which
opens the window I am referring to.

>> This was one of the reasons I chose to use a linked list. When the
>> descriptor is atomically removed from the linked list, it can _never_ be
>> used (or even seen) by any other writer until the owning writer is done
>> with it.
>> 
>> I'm not yet sure how that could be fixed with this implementation. The
>> state information is in a separate variable than the head pointer for
>> the descriptor array (seq_newest). This means you cannot atomically
>> reserve descriptors.
>
> In my implementation, the sequence numbers are atomically reserved
> in prb_reserve_desc() by
>
> 	} while (cmpxchg(&rb->seq_newest, seq_newest, seq) != newest_seqs);
>
> where seq is always seq_newest + 1. We are here only when the
> conflicting seq from the previous wrap is in reusable state
> and the related datablock is moved outside valid lpos range.
> This is ensured by prb_remove_desc_oldest(rb, seq_prev_wrap).
>
> Now, the CPU that succeeded with cmpxchg() becomes
> the exclusive owner of the respective descriptor. The sequence
> number is written into this descriptor _after_ cmpxchg() succeeded.
>
> It is safe because:
>
>     + previous values are not longer used (descriptor has been marked
>       as reusable, lpos from the related datablock were moved
>       outside valid range (lpos_oldest, lpos_newest).
>
>     + new values are ignored by readers and other writers until
>       the right sequence number and the committed flag is set
>       in the descriptor.

Let me inline the function are talking about and add commentary to
illustrate what I am saying:

static int prb_reserve_desc(struct prb_reserved_entry *entry)
{
	unsigned long seq, seq_newest, seq_prev_wrap;
	struct printk_ringbuffer *rb = entry->rb;
	struct prb_desc *desc;
	int err;

	/* Get descriptor for the next sequence number. */
	do {
		seq_newest = READ_ONCE(rb->seq_newest);
		seq = (seq_newest + 1) & PRB_SEQ_MASK;
		seq_prev_wrap = (seq - PRB_DESC_SIZE(rb)) & PRB_SEQ_MASK;

		/*
		 * Remove conflicting descriptor from the previous wrap
		 * if ever used. It might fail when the related data
		 * have not been committed yet.
		 */
		if (seq_prev_wrap == READ_ONCE(rb->seq_oldest)) {
			err = prb_remove_desc_oldest(rb, seq_prev_wrap);
			if (err)
				return err;
		}
	} while (cmpxchg(&rb->seq_newest, seq_newest, seq) != seq_newest);

I am referring to this point in the code, after the
cmpxchg(). seq_newest has been incremented but the descriptor is still
in the unused state and seq is still 1 wrap behind. If an NMI occurs
here and the NMI (or some other CPU) inserts enough entries to wrap the
descriptor array, this descriptor will be reserved again, even though it
has already been reserved.

	/*
	 * The descriptor is ours until the COMMITTED bit is set.
	 * Set its sequence number with all flags cleared.
	 */
	desc = SEQ_TO_DESC(rb, seq);
	WRITE_ONCE(desc->dst, seq);

	/*
	 * Make sure that anyone sees the new dst/seq before
	 * lpos values and data are manipulated. It is related
	 * to the read berrier in prb_read_desc().
	 */
	smp_wmb();

*Now* the descriptor is ours. Not before. And it is only exclusively
ours if the above mentioned situation doesn't occur.

This window doesn't exist with the list approach because reserving a
descriptor simply involves removing the tail (oldest) of the committed
list, which is an atomic operation.

	entry->seq = seq;
	return 0;
}

>> 2. Another issue is when prb_reserve() fails and sets the descriptor
>> as unused. As it is now, no reader can read beyond that descriptor
>> until it is recycled. Readers need to know that the descriptor is bad
>> and can be skipped over. It might be better to handle this the way I
>> did: go ahead and set the state to committed, but have invalid
>> lpos/lpos_next values (for example: lpos_next=lpos) so the reader
>> knows it can skip over the descriptor.
>
> This is exactly what the code does, see prb_make_desc_unused().
> It marks the descriptor as committed so that it can get reused.
> And it sets lpos and lpos_next to the same value so that
> the situation can get eventually detected by readers.

Indeed. Sorry for the noise.

> BTW: There is one potential problem with my alternative approach.
>
>      The descriptors and the related data blocks might get reserved
>      in different order. Now, the descriptor might get reused only
>      when the related datablock is moved outside the valid range.
>      This operation might move also other data blocks outside
>      the range and invalidate descriptors that were reserved later.
>      As a result we might need to invalidate more messages in
>      the log buffer then would be really necessary.
>
>      If I get it properly, this problem does not exist with the
>      implementation using links. It is because the descriptors are
>      linked in the same order as the reserved data blocks.

Descriptors in the committed list are ordered in commit order (not the
reserve order). However, if there are not enough descriptors
(i.e. avgdatabits is higher than the true average) this problem exists
with the list approach as well.

>      I am not sure how big the problem, with more invalidated messages,
>      would be in reality. I am not sure if it would be worth
>      a more complicated implementation.

I am also not sure how big the problem is in a practical sense. However
to help avoid this issue, I will increase the descbits:avgdatabits ratio
for v3.

>      Anyway, I still need to fully understand the linked approach
>      first.

You may want to wait for v3. I've now split the ringbuffer into multiple
generic data structures (as unintentionally suggested[0] by PeterZ),
which helps to clarify the role of each data structure and also isolates
the memory barriers so that it is clear which data structure requires
which memory barriers.

John Ogness

[0] https://lkml.kernel.org/r/20190628154435.GZ7905@worktop.programming.kicks-ass.net
