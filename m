Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C9A0C73C42
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 11:58:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51E2F21537
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 11:58:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbfGIL6R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 07:58:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:49536 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725947AbfGIL6Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 07:58:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 42AD8ABE7;
        Tue,  9 Jul 2019 11:58:15 +0000 (UTC)
Date:   Tue, 9 Jul 2019 13:58:14 +0200
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
Message-ID: <20190709115814.5nykd6yroae7wmxw@pathway.suse.cz>
References: <20190621140516.h36g4in26pe3rmly@pathway.suse.cz>
 <20190704103321.10022-1-pmladek@suse.com>
 <20190704103321.10022-1-pmladek@suse.com>
 <87r275j15h.fsf@linutronix.de>
 <20190708152311.7u6hs453phhjif3q@pathway.suse.cz>
 <20190708152311.7u6hs453phhjif3q@pathway.suse.cz>
 <874l3wng7g.fsf@linutronix.de>
 <20190709090609.shx7j2mst7wlkbqm@pathway.suse.cz>
 <20190709090609.shx7j2mst7wlkbqm@pathway.suse.cz>
 <87tvbv33w2.fsf@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tvbv33w2.fsf@linutronix.de>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2019-07-09 12:21:01, John Ogness wrote:
> On 2019-07-09, Petr Mladek <pmladek@suse.com> wrote:
> >>>> 1. The code claims that the cmpxchg(seq_newest) in
> >>>> prb_reserve_desc() guarantees that "The descriptor is ours until
> >>>> the COMMITTED bit is set."  This is not true if in that wind
> >>>> seq_newest wraps, allowing another writer to gain ownership of the
> >>>> same descriptor. For small descriptor arrays (such as in my test
> >>>> module), this situation is quite easy to reproduce.
> >>>
> >> Let me inline the function are talking about and add commentary to
> >> illustrate what I am saying:
> >> 
> >> static int prb_reserve_desc(struct prb_reserved_entry *entry)
> >> {
> >> 	unsigned long seq, seq_newest, seq_prev_wrap;
> >> 	struct printk_ringbuffer *rb = entry->rb;
> >> 	struct prb_desc *desc;
> >> 	int err;
> >> 
> >> 	/* Get descriptor for the next sequence number. */
> >> 	do {
> >> 		seq_newest = READ_ONCE(rb->seq_newest);
> >> 		seq = (seq_newest + 1) & PRB_SEQ_MASK;
> >> 		seq_prev_wrap = (seq - PRB_DESC_SIZE(rb)) & PRB_SEQ_MASK;
> >> 
> >> 		/*
> >> 		 * Remove conflicting descriptor from the previous wrap
> >> 		 * if ever used. It might fail when the related data
> >> 		 * have not been committed yet.
> >> 		 */
> >> 		if (seq_prev_wrap == READ_ONCE(rb->seq_oldest)) {
> >> 			err = prb_remove_desc_oldest(rb, seq_prev_wrap);
> >> 			if (err)
> >> 				return err;
> >> 		}
> >> 	} while (cmpxchg(&rb->seq_newest, seq_newest, seq) != seq_newest);
> >> 
> >> I am referring to this point in the code, after the
> >> cmpxchg(). seq_newest has been incremented but the descriptor is
> >> still in the unused state and seq is still 1 wrap behind. If an NMI
> >> occurs here and the NMI (or some other CPU) inserts enough entries to
> >> wrap the descriptor array, this descriptor will be reserved again,
> >> even though it has already been reserved.
> >
> > Not really, the NMI will not reach the cmpxchg() in this case.
> > prb_remove_desc_oldest() will return error.
> 
> Why will prb_remove_desc_oldest() fail? IIUC, it will return success
> because the descriptor is in the desc_miss state.
> 
> > It will not be able to remove the conflicting descriptor because
> > it will still be occupied by a two-wraps-old descriptor.

Ah, I see that this situation was not handled correctly.
But it can get fixed pretty easily, see an updated
prb_remove_desc_oldest() at the end of the mail.


> Please explain why with more details. Perhaps providing a function call
> chain?  Sorry if I'm missing the obvious here.

To be on the safe side, let's try it with real numbers.

Let's have array with 8 descriptors filled with the following
sequence numbers pointing to commited messages:

	desc[10]:  16 17 18 19 20 21 22 23
	rb->seq_oldest = 16;
	rb->seq_newest = 23;

then prb_reserve_desc() would do:

	seq_newest = 23;
	seq = 24;
	seq_prew_wrap = 16;

		 prb_remove_desc_oldest(rb, 16);

		 // let's say that it succeeds and
		 // rb->seq_oldest == 17;

	cmpxchg(&rb->seq_newest, 23, 24) == 23)

	// let's say that it succeds and it is immediately
	// interrupted by NMI before desc[0]->dst is set to 24.
	// So, we still have:

	desc[10]: 16 17 18 19 20 21 22 23
	rb->seq_oldest = 17;
	rb->seq_newest = 24;

Let's say that NMI tries to print 8 messages.
After 7 successfully reserved and commited messages
we could have:

	desc[10]: 16 25 26 27 28 29 30 31
	rb->seq_oldest = 24;
	rb->seq_newest = 31;

desc[0] still has the outdated information. Now, we try to reserve
the 8th message, then prb_reserve_desc() would do:

	seq_newest = 31;
	seq = 32;
	seq_prew_wrap = 24;

		 prb_remove_desc_oldest(rb, 24);

			desc_state = prb_read_desc(rb, 24, &desc);

			// desc_state == desc_miss because the
			// descriptor still points to the outdated
			// seq = 16.

		// prb_remove_desc_oldest(rb, 24) would continue with:
		switch (desc_state) {
		/*
		 * Another seq means that the oldest desciptor has already been
		 * removed and reused. Return success in this case.
		 */
		case desc_miss:
			return 0;

		BUG: This is obviously wrong!

But this is a special case that can get detected. desc->seq is exactly
1 wrap back than requested. The proper code would be:

static int prb_remove_desc_oldest(struct printk_ringbuffer *rb,
				  unsigned long seq_oldest)
{
	struct prb_desc desc;
	enum prb_desc_state desc_state;
	int err;

	desc_state = prb_read_desc(rb, seq_oldest, &desc);
	switch (desc_state) {
	case desc_miss:
		unsigned long seq_prev_wrap =
			(seq_oldest - PRB_DESC_SIZE(rb)) &
			PRB_SEQ_MASK;

		if (desc->dst ==
			(seq_prev_wrap |
			 PRB_COMMITED_MASK |
			 PRB_REUSABLE_MASK)) {
			 /*
			  * Special case: Reusable descriptor from the
			  * previous wrap means that the current
			  * oldest descriptor is reserved but the dst
			  * has not been updated yet.
			  */
			  return -ENOMEM;

		/*
		 * Any other desc_misc means that the oldest
		 * has been already removed and reused by a newer
		 * sequence number. Return success in this case.
		 * The attempt to update rb->seq_oldest will fail.
		 */
		return 0;

At this point, any prb_reserve() would fail exactly this way
until NMI returns and the message with seq == 24 gets commited.

Best Regards,
Petr
