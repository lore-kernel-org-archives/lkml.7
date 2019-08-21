Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E28B8C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 05:46:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9A7A2087E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 05:46:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727430AbfHUFqh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 01:46:37 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:53735 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726693AbfHUFqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 01:46:37 -0400
Received: from localhost ([127.0.0.1] helo=vostro.local)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1i0JS2-0003gk-4V; Wed, 21 Aug 2019 07:46:30 +0200
From:   John Ogness <john.ogness@linutronix.de>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: comments style: Re: [RFC PATCH v4 1/9] printk-rb: add a new printk ringbuffer implementation
References: <20190807222634.1723-1-john.ogness@linutronix.de>
        <20190807222634.1723-2-john.ogness@linutronix.de>
        <20190820085554.deuejmxn4kbqnq7n@pathway.suse.cz>
        <20190820092731.GA14137@jagdpanzerIV>
Date:   Wed, 21 Aug 2019 07:46:28 +0200
Message-ID: <87a7c3f4uj.fsf@linutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-08-20, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com> wrote:
> [..]
>> > +	 *
>> > +	 * Memory barrier involvement:
>> > +	 *
>> > +	 * If dB reads from gA, then dC reads from fG.
>> > +	 * If dB reads from gA, then dD reads from fH.
>> > +	 * If dB reads from gA, then dE reads from fE.
>> > +	 *
>> > +	 * Note that if dB reads from gA, then dC cannot read from fC.
>> > +	 * Note that if dB reads from gA, then dD cannot read from fD.
>> > +	 *
>> > +	 * Relies on:
>> > +	 *
>> > +	 * RELEASE from fG to gA
>> > +	 *    matching
>> > +	 * ADDRESS DEP. from dB to dC
>> > +	 *
>> > +	 * RELEASE from fH to gA
>> > +	 *    matching
>> > +	 * ADDRESS DEP. from dB to dD
>> > +	 *
>> > +	 * RELEASE from fE to gA
>> > +	 *    matching
>> > +	 * ACQUIRE from dB to dE
>> > +	 */
>> 
>> But I am not sure how much this is useful. It would take ages to decrypt
>> all these shortcuts (signs) and translate them into something
>> human readable. Also it might get outdated easily.
>> 
>> That said, I haven't found yet if there was a system in all
>> the shortcuts. I mean if they can be descrypted easily
>> out of head. Also I am not familiar with the notation
>> of the dependencies.
>
> Does not appear to be systematic to me, but maybe I'm missing something
> obvious. For chains like
>
> 		jA->cD->hA to jB
>
> I haven't found anything better than just git grep jA kernel/printk/
> so far.

I really struggled to find a way to label the code in order to document
the memory barriers. By grepping on "jA:" you will land at the exact
location.

> But once you'll grep for label cD, for instance, you'd see
> that it's not defined. It's mentioned but not defined
>
> 	kernel/printk/ringbuffer.c:      * jA->cD->hA.
> 	kernel/printk/ringbuffer.c:      * RELEASE from jA->cD->hA to jB

I tried to be very careful about the labeling, but you just found an
error. cD is supposed to be cC. (I probably refactored the labels and
missed this one.) Particularly with referencing labels from other files
I was not happy (which is the case with cC). This is one area that I
think it would be really helpful if the kernel guidelines had some
format.

The labels are necessary for the technical documentation of the
barriers. And, after spending much time in this, I find them very
useful. But I agree that there needs to be a better way to assign label
names.

FWIW, I chose a lowercase letter for each function and an uppercase
letter for each label within that function. The camel case (followed by
the colon) created a pair that was unique for grepping.

Petr, in case you missed it, this comment language came from my
discussion[0] with AndreaP.

> I was thinking about renaming labels. E.g.
>
> 	dataring_desc_init()
> 	{
> 		/* di1 */
> 		WRITE_ONCE(desc->begin_lpos, 1);
> 		/* di2 */
> 		WRITE_ONCE(desc->next_lpos, 1);
> 	}
>
> Where di stands for descriptor init.
>
> 	dataring_push()
> 	{
> 		/* dp1 */
> 		ret = get_new_lpos(dr, size, &begin_lpos, &next_lpos);
> 		...
> 		/* dp2 */
> 		smp_mb();
> 		...
> 	}
>
> Where dp stands for descriptor push. For dataring we can add a 'dr'
> prefix, to avoid confusion with desc barriers, which have 'd' prefix.
> And so on. Dunno.

Yeah, I spent a lot of time going in circles on this one.

I hope that we can agree that the labels are important. And that a
formal documentation of the barriers is also important. Yes, they are a
lot of work, but I find it makes it a lot easier to go back to the code
after I've been away for a while. Even now, as I go through your
feedback on code that I wrote over a month ago, I find the formal
comments critical to quickly understand _exactly_ why the memory
barriers exist.

Perhaps we should choose labels that are more clear, like:

    dataring_push:A
    dataring_push:B

Then we would see comments like:

    Memory barrier involvement:

    If _dataring_pop:B reads from dataring_datablock_setid:A, then
    _dataring_pop:C reads from dataring_push:G.

    If _dataring_pop:B reads from dataring_datablock_setid:A, then
    _dataring_pop:D reads from dataring_push:H.

    If _dataring_pop:B reads from dataring_datablock_setid:A, then
    _dataring_pop:E reads from dataring_push:E.

    Note that if _dataring_pop:B reads from dataring_datablock_setid:A, then
    _dataring_pop:C cannot read from dataring_push:C->dataring_desc_init:A.

    Note that if _dataring_pop:B reads from dataring_datablock_setid:A, then
    _dataring_pop:D cannot read from dataring_push:C->dataring_desc_init:B.

    Relies on:

    RELEASE from dataring_push:G to dataring_datablock_setid:A
       matching
    ADDRESS DEP. from _dataring_pop:B to _dataring_pop:C

    RELEASE from dataring_push:H to dataring_datablock_setid:A
       matching
    ADDRESS DEP. from _dataring_pop:B to _dataring_pop:D

    RELEASE from dataring_push:E to dataring_datablock_setid:A
       matching
    ACQUIRE from _dataring_pop:B to _dataring_pop:E

But then how should the labels in the code look? Just the letter looks
simple in code, but cannot be grepped.

    dataring_push()
    {
        ...
        /* E */
        ...
    }

The full label can be grepped, but is redundant with the function name.

    dataring_push()
    {
        ...
        /* dataring_push:E */
        ...
    }

Andrea suggested that the documentation should be within the code, which
I think is a good idea. Even if it means we have more comments than
code.

I am open to suggestions.

John Ogness

[0] https://lkml.kernel.org/r/20190630140855.GA6005@andrea
