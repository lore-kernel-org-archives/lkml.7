Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1896C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 13:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9215520828
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 13:45:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbfH1Np5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 09:45:57 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47324 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726432AbfH1Nn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 09:43:57 -0400
Received: from localhost ([127.0.0.1] helo=vostro.local)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1i2yEq-0004f4-BX; Wed, 28 Aug 2019 15:43:52 +0200
From:   John Ogness <john.ogness@linutronix.de>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Andrea Parri <parri.andrea@gmail.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: dataring_push() barriers Re: [RFC PATCH v4 1/9] printk-rb: add a new printk ringbuffer implementation
References: <20190807222634.1723-1-john.ogness@linutronix.de>
        <20190807222634.1723-2-john.ogness@linutronix.de>
        <20190820135004.7vatbrzphfsgsnw2@pathway.suse.cz>
        <20190820135004.7vatbrzphfsgsnw2@pathway.suse.cz>
        <87r25aklsy.fsf@linutronix.de>
        <20190827143635.4taqjj6wjz7gdlea@pathway.suse.cz>
Date:   Wed, 28 Aug 2019 15:43:50 +0200
In-Reply-To: <20190827143635.4taqjj6wjz7gdlea@pathway.suse.cz> (Petr Mladek's
        message of "Tue, 27 Aug 2019 16:36:35 +0200")
Message-ID: <87pnkpjtgp.fsf@linutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-08-27, Petr Mladek <pmladek@suse.com> wrote:
>>>> +/**
>>>> + * dataring_push() - Reserve a data block in the data array.
>>>> + *
>>>> + * @dr:   The data ringbuffer to reserve data in.
>>>> + *
>>>> + * @size: The size to reserve.
>>>> + *
>>>> + * @desc: A pointer to a descriptor to store the data block information.
>>>> + *
>>>> + * @id:   The ID of the descriptor to be associated.
>>>> + *        The data block will not be set with @id, but rather initialized with
>>>> + *        a value that is explicitly different than @id. This is to handle the
>>>> + *        case when newly available garbage by chance matches the descriptor
>>>> + *        ID.
>>>> + *
>>>> + * This function expects to move the head pointer forward. If this would
>>>> + * result in overtaking the data array index of the tail, the tail data block
>>>> + * will be invalidated.
>>>> + *
>>>> + * Return: A pointer to the reserved writer data, otherwise NULL.
>>>> + *
>>>> + * This will only fail if it was not possible to invalidate the tail data
>>>> + * block.
>>>> + */
>>>> +char *dataring_push(struct dataring *dr, unsigned int size,
>>>> +		    struct dr_desc *desc, unsigned long id)
>>>> +{
>>>> +	unsigned long begin_lpos;
>>>> +	unsigned long next_lpos;
>>>> +	struct dr_datablock *db;
>>>> +	bool ret;
>>>> +
>>>> +	to_db_size(&size);
>>>> +
>>>> +	do {
>>>> +		/* fA: */
>>>> +		ret = get_new_lpos(dr, size, &begin_lpos, &next_lpos);
>>>> +
>>>> +		/*
>>>> +		 * fB:
>>>> +		 *
>>>> +		 * The data ringbuffer tail may have been pushed (by this or
>>>> +		 * any other task). The updated @tail_lpos must be visible to
>>>> +		 * all observers before changes to @begin_lpos, @next_lpos, or
>>>> +		 * @head_lpos by this task are visible in order to allow other
>>>> +		 * tasks to recognize the invalidation of the data
>>>> +		 * blocks.
>>>
>>> This sounds strange. The write barrier should be done only on CPU
>>> that really modified tail_lpos. I.e. it should be in _dataring_pop()
>>> after successful dr->tail_lpos modification.
>> 
>> The problem is that there are no data dependencies between the different
>> variables. When a new datablock is being reserved, it is critical that
>> all other observers see that the tail_lpos moved forward _before_ any
>> other changes. _dataring_pop() uses an smp_rmb() to synchronize for
>> tail_lpos movement.
>
> It should be symmetric. It makes sense that _dataring_pop() uses an
> smp_rmb(). Then there should be wmb() in dataring_push().

dataring_pop() is adjusting the tail. dataring_push() is adjusting the
head. These operations are handled (ordered) separately. They do not
need be happening in lockstep. They don't need to be happening on the
same CPU.

> The wmb() should be done only by the CPU that actually did the write.
> And it should be done after the write. This is why I suggested to
> do it after cmpxchg(dr->head_lpos).

If CPU0 issues an smp_wmb() after moving the tail and (after seeing the
moved tail) CPU1 issues an smp_wmb() after updating the head, it is
still possible for CPU2 to see the head move (and possibly even overtake
the tail) before seeing the tail move.

If a CPU didn't move the tail but _will_ move the head, only a full
memory barrier will allow _all_ observers to see the tail move before
seeing the head move.

>> This CPU is about to make some changes and may have seen an updated
>> tail_lpos. An smp_wmb() is useless if this is not the CPU that
>> performed that update. The full memory barrier ensures that all other
>> observers will see what this CPU sees before any of its future
>> changes are seen.
>
> I do not understand it. Full memory barrier will not cause that all
> CPUs will see the same.

I did not write that. I wrote (emphasis added):

    The full memory barrier ensures that all other observers will see
    what _this_ CPU sees before any of _its_ future changes are seen.

> These barriers need to be symmetric.

They are. The comments for fB list the pairs (all being
smp_mb()/smp_rmb() pairings).

> Back to our situation:
>
>     + rmb() should not be needed here because get_new_lpos() provided
>       a valid lpos.
>
>     + wmb() is not needed because we have not written anything yet
>
> If there was a race with another CPU than cmpxchg(dr->head_lpos)
> would fail and we will need to repeat everything again.

It's not about racing to update the head. It's about making sure that
_all_ CPUs observe that a datablock was invalidated _before_ observing
that _this_ CPU started modifying other shared variables. And again,
this CPU might _not_ be the one that invalidated the datablock
(i.e. moved the tail).

John Ogness
