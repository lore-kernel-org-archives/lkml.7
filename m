Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45763C606B0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 09:06:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23CF5216C4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 09:06:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726081AbfGIJGM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 05:06:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:34872 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725989AbfGIJGM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 05:06:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 75E29ADBF;
        Tue,  9 Jul 2019 09:06:10 +0000 (UTC)
Date:   Tue, 9 Jul 2019 11:06:09 +0200
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
Message-ID: <20190709090609.shx7j2mst7wlkbqm@pathway.suse.cz>
References: <20190621140516.h36g4in26pe3rmly@pathway.suse.cz>
 <20190704103321.10022-1-pmladek@suse.com>
 <20190704103321.10022-1-pmladek@suse.com>
 <87r275j15h.fsf@linutronix.de>
 <20190708152311.7u6hs453phhjif3q@pathway.suse.cz>
 <20190708152311.7u6hs453phhjif3q@pathway.suse.cz>
 <874l3wng7g.fsf@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874l3wng7g.fsf@linutronix.de>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2019-07-09 03:34:43, John Ogness wrote:
> On 2019-07-08, Petr Mladek <pmladek@suse.com> wrote:
> >> 1. The code claims that the cmpxchg(seq_newest) in prb_reserve_desc()
> >> guarantees that "The descriptor is ours until the COMMITTED bit is
> >> set."  This is not true if in that wind seq_newest wraps, allowing
> >> another writer to gain ownership of the same descriptor. For small
> >> descriptor arrays (such as in my test module), this situation is
> >> quite easy to reproduce.
> >
> Let me inline the function are talking about and add commentary to
> illustrate what I am saying:
> 
> static int prb_reserve_desc(struct prb_reserved_entry *entry)
> {
> 	unsigned long seq, seq_newest, seq_prev_wrap;
> 	struct printk_ringbuffer *rb = entry->rb;
> 	struct prb_desc *desc;
> 	int err;
> 
> 	/* Get descriptor for the next sequence number. */
> 	do {
> 		seq_newest = READ_ONCE(rb->seq_newest);
> 		seq = (seq_newest + 1) & PRB_SEQ_MASK;
> 		seq_prev_wrap = (seq - PRB_DESC_SIZE(rb)) & PRB_SEQ_MASK;
> 
> 		/*
> 		 * Remove conflicting descriptor from the previous wrap
> 		 * if ever used. It might fail when the related data
> 		 * have not been committed yet.
> 		 */
> 		if (seq_prev_wrap == READ_ONCE(rb->seq_oldest)) {
> 			err = prb_remove_desc_oldest(rb, seq_prev_wrap);
> 			if (err)
> 				return err;
> 		}
> 	} while (cmpxchg(&rb->seq_newest, seq_newest, seq) != seq_newest);
> 
> I am referring to this point in the code, after the
> cmpxchg(). seq_newest has been incremented but the descriptor is still
> in the unused state and seq is still 1 wrap behind. If an NMI occurs
> here and the NMI (or some other CPU) inserts enough entries to wrap the
> descriptor array, this descriptor will be reserved again, even though it
> has already been reserved.

Not really, the NMI will not reach the cmpxchg() in this case.
prb_remove_desc_oldest() will return error. It will not
be able to remove the conflicting descriptor because it will
still be occupied by a two-wraps-old descriptor.

BTW: I did meet these problems in some early variatns. But everything
started working at some point. I always looked how you solved
a particular situation in the link-based approach. Then I
somehow translated it into the pure-array variant.


> > BTW: There is one potential problem with my alternative approach.
> >
> >      The descriptors and the related data blocks might get reserved
> >      in different order. Now, the descriptor might get reused only
> >      when the related datablock is moved outside the valid range.
> >      This operation might move also other data blocks outside
> >      the range and invalidate descriptors that were reserved later.
> >      As a result we might need to invalidate more messages in
> >      the log buffer then would be really necessary.
> >
> >      If I get it properly, this problem does not exist with the
> >      implementation using links. It is because the descriptors are
> >      linked in the same order as the reserved data blocks.
> 
> Descriptors in the committed list are ordered in commit order (not the
> reserve order). However, if there are not enough descriptors
> (i.e. avgdatabits is higher than the true average) this problem exists
> with the list approach as well.

Thanks for the explanation.

> >      I am not sure how big the problem, with more invalidated messages,
> >      would be in reality. I am not sure if it would be worth
> >      a more complicated implementation.
> 
> I am also not sure how big the problem is in a practical sense. However
> to help avoid this issue, I will increase the descbits:avgdatabits ratio
> for v3.

Yup, it sounds reasonable. The number of reserved but not committed
descriptors is basically limited by the number of CPUs.

The only unknown variable is the length of the messages. Which brings
another problem. We might need a solution for continuous lines.
People would want it. Also storing one line in many entries would
be quite inefficient. But let's discuss this later when
printk() gets converted into the lockless ring buffer.


> >      Anyway, I still need to fully understand the linked approach
> >      first.
> 
> You may want to wait for v3. I've now split the ringbuffer into multiple
> generic data structures (as unintentionally suggested[0] by PeterZ),
> which helps to clarify the role of each data structure and also isolates
> the memory barriers so that it is clear which data structure requires
> which memory barriers.

Sure, I am interested to see v3.

Best Regards,
Petr
