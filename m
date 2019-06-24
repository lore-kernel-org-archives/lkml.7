Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F16C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 14:09:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67A3E212F5
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 14:09:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731927AbfFXOJx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 10:09:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:40594 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727728AbfFXOJv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 10:09:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B61CCADC4;
        Mon, 24 Jun 2019 14:09:49 +0000 (UTC)
Date:   Mon, 24 Jun 2019 16:09:48 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [RFC PATCH v2 1/2] printk-rb: add a new printk ringbuffer
 implementation
Message-ID: <20190624140948.l7ekcmz5ser3zfr2@pathway.suse.cz>
References: <20190607162349.18199-1-john.ogness@linutronix.de>
 <20190607162349.18199-2-john.ogness@linutronix.de>
 <20190621140516.h36g4in26pe3rmly@pathway.suse.cz>
 <87d0j31iyc.fsf@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87d0j31iyc.fsf@linutronix.de>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2019-06-24 10:33:15, John Ogness wrote:
> > 1. Linked list of descriptors
> > -----------------------------
> >
> > The list of descriptors makes the code more complicated
> > and I do not see much gain. It is possible that I just missed
> > something.
> >
> > If I get it correctly then the list could only grow by adding
> > never used members. The already added members are newer removed
> > neither shuffled.

Is the above paragraph correct, please?

> > If the above is true then we could achieve similar result
> > when using the array as a circular buffer. It would be
> > the same like when all members are linked from the beginning.
> 
> So you are suggesting using a multi-reader multi-writer lockless
> ringbuffer to implement a multi-reader multi-writer lockless
> ringbuffer. ;-)
> 
> The descriptor ringbuffer has fixed-size items, which simplifies the
> task. But I expect you will run into a chicken-egg scenario.

AFAIK, the main obstacle with the fully lockless solution was
that the entries did not have a fixed size.

If I understand it correctly, the list works exactly as a
ring buffer once all available descriptors are used.


> > It would allow to remove:
> >
> >     + desc->id because it will be the same as desc->seq
> >     + desc->next because the address of the next member
> > 		can be easily counted
> 
> Yes, you will remove these and then replace them with new variables to
> track array-element state.

Yes, it should easier to understand that, for example, a descriptor
is free by a flag named "free" than by some magic check of links.

It is not must to have. But the code is complicated. Anything
that might make it easier to understand is much appreciated.

> > I think that it might be much more safe when we mask the two
> > highest bits of seq number and use them for the flags.
> > Then we could track the state of the given sequence number
> > a very safe and straightforward way.
> 
> When I first started to design/code this, I implemented something quite
> similar: using a single variable to represent state and id. This works
> nicely for cmpxchg operations (lockless synchronization) and reader
> validation. The problem I ran into was a chicken-egg problem (which I
> suspect you will also run into).

Do you remember more details about the chicken-egg problem, please?
I believe that there might be one. Any hint just could save
me quite some time.

I have hit two big dead ends so far:

  1. I was not able to free data when there was no free descriptor
     and free descriptor when the data have already been freed.
     I was not able to make both operations race-free.

     I got inspiration from remove_oldest_descr() and solved this
     by failing to get descriptor when there was no free one.

     But it is possible that I just did not try hard enough.
     I see that your code is actually able to free the data
     and descriptor from assign_descriptor().


  2. I was not able to free the oldest data. I did not know
     how to make sure that the seq read from the data buffer
     was valid.

     My plan was to solve this by changing seq and state flags
     in the descriptor atomically. Then I would just check
     whether the seq was in valid bounds (I would ignore
     overflow) and that the flag "committed" was set. Then
     I would just set the flag "freed". The descriptor
     itself would be freed from prb_get_desc().

     But I might actually use similar approach like you
     are using in expire_oldest_data(). We could assume
     that as long as the desc->seq is within valid
     bounds (rb->first_seq <= seq <= rb->last_seq)
     then it is the right descriptor.


> I solved this problem by changing the design to use a linked list for
> the descriptors. At first I had kept state information for each
> descriptor. But later I realized that state information was not
> necessary because the linked list itself was providing implicit state
> information.

And this is my problem. I do not see how the list itself provides
the state information. Especially I do not see how it distinguishes
reserved and commited state, for example, from expire_oldest_data()
point of view.


> > Finally, here are some comments about the original patch:
> >
> > On Fri 2019-06-07 18:29:48, John Ogness wrote:
> >> See documentation for details.
> >
> > Please, mention here some basics. It might be enough to copy the
> > following sections from the documentation:
> >
> > Overview
> > Features
> > Behavior
>
> Ugh. Do we really want all that in a commit message?

2-3 pages of text for such a complicated commit is perfectly fine.
You could not build html/pdf variant easily when reading "git log -p".

> > Note that the documentation is written via .rst file. You need to
> > build html or pdf to get all the pieces together.
> 
> Yes, but isn't that how all the kernel docs are supposed to be for the
> future?

I could not talk for others. I have personally built the html version
for the first time just few weeks ago. And it was only because
I reviewed conversion of livepatch related documentation into rst.

I normally search for information using "cscope in emacs", "git
blame", "git log -p", "git grep", and "google in web browser".
I much prefer to find the information in the code sources or
in the related commit message.


> >> +/**
> >> + * struct prb_list - An abstract linked list of items.
> >> + * @oldest: The oldest item on the list.
> >> + * @newest: The newest item on the list.
> >
> > I admit that I got confused by this. I wonder if there is another
> > location in kernel where lists are handled this way.
> >
> > I have always seen in kernel only lists handled via the struct
> > list_head trick. Where the same structure is bundled in all
> > linked members.
> >
> > I can't find a good name. I would personally remove the structure
> > and add the members into the relates structures directly.
> 
> The only reason I made it a struct is so that I could just write
> l->oldest instead of rb->descr_list_oldest. But it is an otherwise
> useless struct that I can remove.

rb->last_lpos and rb->last_seq are short enough. And it is clear
what exactly is being compared.

> > Also I would personally use "first" and "last" because they are
> > shorter and easier to visually distinguish. I know that "oldest"
> > and "newest" are more clear but...
> 
> I don't like "oldest" and "newest" either, but it is immediately
> clear. How about:
> 
> rb->data_lpos_oldest (formerly rb->data_list.oldest)
> rb->data_lpos_newest (formerly rb->data_list.newest)
> rb->desc_id_oldest (formerly rb->descr_list.oldest)
> rb->desc_id_newest (formerly rb->descr_list.newest)
> 
> If using the strings "oldest" and "newest" are too ugly for people, I
> have no problems using first/last or head/tail, even if IMHO they add
> unnecessary confusion.

I do not have strong opinion. I am slightly biased because I am used
to "first"/"next" from the current code.

In each case when I compare:

rb->data_lpos_oldest (formerly rb->data_list.oldest)
rb->data_lpos_newest (formerly rb->data_list.newest)
rb->desc_id_oldest (formerly rb->descr_list.oldest)
rb->desc_id_newest (formerly rb->descr_list.newest)

rb->data_lpos_first (formerly rb->data_list.first)
rb->data_lpos_last (formerly rb->data_list.last)
rb->desc_id_first (formerly rb->descr_list.first)
rb->desc_id_last (formerly rb->descr_list.last)

then the 2nd variant helps me to spot the difference
and find the valuable information.

> >> + * @data_next: The logical position of the data next to this entry.
> >> + *             This is used to determine the length of the data as well as
> >> + *             identify where the next data begins.
> >
> > next_lpos
> 
> How about lpos_next?

next_lpos looks gramatically more correct. Well, I do not mind as long
as the style is consistent all over the code.

> >> +/**
> >> + * expire_oldest_data() - Invalidate the oldest data block.
> >> + * @rb: The ringbuffer containing the data block.
> >> + * @oldest_lpos: The logical position of the oldest data block.
> >> + *
> >> + * This function expects to "push" the pointer to the oldest data block
> >> + * forward, thus invalidating the oldest data block. However, before pushing,
> >> + * it is verified if the data block is valid. (For example, if the data block
> >> + * was reserved but not yet committed, it is not permitted to invalidate the
> >> + * "in use by a writer" data.)
> >> + *
> >> + * If the data is valid, it will be associated with a descriptor, which will
> >> + * then provide the necessary information to validate the data.
> >> + *
> >> + * Return: true if the oldest data was invalidated (regardless if this
> >> + *         task was the one that did it or not), otherwise false.
> >> + */
> >> +static bool expire_oldest_data(struct printk_ringbuffer *rb,
> >> +			       unsigned long oldest_lpos)
> >> +{
> > How is it ensured that the descriptor is not an outdated one?
> >
> > IMHO, there might be a garbage in the data array. It might be chance
> > point to an outdated descriptor that by chance pointed to this
> > data range in the past. I agree that it is very unlikely. But
> > we could not afford such a risk.
> 
> An outdated descriptor that has a data value (lpos) matching the oldest
> (lpos) would mean that the lpos has completely wrapped (4GB of data on a
> 32-bit system) without the descriptor having been recycled.

Ah, I missed that it takes long time until the positions are reused
(overflow). It would probably helped me when all the compared variables
were called lpos instead of data ;-)

> It should be
> possible to force such a situation on a 32-bit system, so this issue
> does need to be addressed. Thanks.

We might even be able to ignore this because both descriptors and data
arrays are reused. It should be impossible to wrap around lpos without
wrapping seq and vice versa.

Best Regards,
Petr
