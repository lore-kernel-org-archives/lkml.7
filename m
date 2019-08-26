Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DC13C3A59E
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 08:22:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46A712087E
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 08:22:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730515AbfHZIWB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 04:22:01 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39060 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730379AbfHZIWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 04:22:00 -0400
Received: from localhost ([127.0.0.1] helo=vostro.local)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1i2AGB-000414-2M; Mon, 26 Aug 2019 10:21:55 +0200
From:   John Ogness <john.ogness@linutronix.de>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Andrea Parri <andrea.parri@amarulasolutions.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: assign_desc() barriers: Re: [RFC PATCH v4 1/9] printk-rb: add a new printk ringbuffer implementation
References: <20190807222634.1723-1-john.ogness@linutronix.de>
        <20190807222634.1723-2-john.ogness@linutronix.de>
        <20190820082253.ybys4fsakxxdvahx@pathway.suse.cz>
        <20190820141429.hkrnynmr5ou4lem2@pathway.suse.cz>
        <87v9urdq05.fsf@linutronix.de>
        <20190822115329.oy5mw3nycwue6dkw@pathway.suse.cz>
        <87wof2knhe.fsf@linutronix.de>
Date:   Mon, 26 Aug 2019 10:21:53 +0200
In-Reply-To: <87wof2knhe.fsf@linutronix.de> (John Ogness's message of "Sun, 25
        Aug 2019 04:06:21 +0200")
Message-ID: <87k1b0cp5q.fsf@linutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-08-25, John Ogness <john.ogness@linutronix.de> wrote:
>>>>>> --- /dev/null
>>>>>> +++ b/kernel/printk/ringbuffer.c
>>>>>> +static bool assign_desc(struct prb_reserved_entry *e)
>>>>>> +{
[...]
>>>>>> +	atomic_long_set_release(&d->id, atomic_long_read(&d->id) +
>>>>>> +				DESCS_COUNT(rb));
>>>>> 
>>>>> atomic_long_set_release() might be a bit confusing here.
>>>>> There is no related acquire.
>>> 
>>> As the comment states, this release is for prb_getdesc() users. The
>>> only prb_getdesc() user is _dataring_pop().  (i.e. the descriptor's
>>> ID is not what _dataring_pop() was expecting), then the tail must
>>> have moved and _dataring_pop() needs to see that. Since there are no
>>> data dependencies between descriptor ID and tail_pos, an explicit
>>> memory barrier is used. More on this below.
>
>>   + The two related barriers are in different source files
>>     and APIs:
>>
>>        + assign_desc() in ringbuffer.c; ringbuffer API
>>        + _dataring_pop in dataring.c; dataring API
>
> Agreed. This is a consequence of the ID management being within the
> high-level ringbuffer code. I could have added an smp_rmb() to the
> NULL case in prb_getdesc(). Then both barriers would be in the same
> file. However, this would mean smp_rmb() is called many times
> (particularly by readers) when it is not necessary.

What I wrote here is wrong. prb_getdesc() is not called "many times
(particularly by readers)". It is only called once within the writer
function _dataring_pop().

Looking at this again, I think it would be better to move the smp_rmb()
into the NULL case of prb_getdesc(). Then both barrier pairs are located
(and documented) in the same file. This also simplifies the
documentation by not saying "the caller's smp_rmb() everywhere".

I would also change _dataring_pop() so that the smp_rmb() is located
within the handling of the other two failed checks (begin_lpos !=
tail_lpos and !_datablock_valid()). Then the out: at the end is just
return atomic_long_read(&dr->tail_lpos).

After modifying the code in this way, I think it looks more straight
forward and would have avoided your confusion: The RMB in
dataring.c:_dataring_pop() matches the MB in dataring.c:dataring_push()
and the RMB in ringbuffer.c:prb_getdesc() matches the SET_RELEASE in
ringbuffer.c:assign_desc().

John Ogness
