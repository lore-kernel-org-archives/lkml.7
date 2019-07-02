Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7915C06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 14:14:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5EF220665
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 14:14:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbfGBOOB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 10:14:01 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:45968 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbfGBOOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 10:14:01 -0400
Received: from localhost ([127.0.0.1] helo=vostro.local)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1hiJXa-0002RH-7F; Tue, 02 Jul 2019 16:13:50 +0200
From:   John Ogness <john.ogness@linutronix.de>
To:     Andrea Parri <andrea.parri@amarulasolutions.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [RFC PATCH v2 1/2] printk-rb: add a new printk ringbuffer implementation
References: <20190607162349.18199-1-john.ogness@linutronix.de>
        <20190607162349.18199-2-john.ogness@linutronix.de>
        <20190618114747.GQ3436@hirez.programming.kicks-ass.net>
        <87k1df28x4.fsf@linutronix.de>
        <20190626224034.GK2490@worktop.programming.kicks-ass.net>
        <87mui2ujh2.fsf@linutronix.de> <20190629210528.GA3922@andrea>
        <87imsnaky1.fsf@linutronix.de> <20190630140855.GA6005@andrea>
Date:   Tue, 02 Jul 2019 16:13:48 +0200
In-Reply-To: <20190630140855.GA6005@andrea> (Andrea Parri's message of "Sun,
        30 Jun 2019 16:08:55 +0200")
Message-ID: <87ef38cyn7.fsf@linutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-06-30, Andrea Parri <andrea.parri@amarulasolutions.com> wrote:
>> The significant events for 2 contexts that are accessing the same
>> addresses of a descriptor are:
>> 
>> P0(struct desc *d0)
>> {
>>         // adding a new descriptor d0
>> 
>>         WRITE_ONCE(d0->next, EOL);               // C
>>         WRITE_ONCE(d0->seq, X);                  // D
>>         cmpxchg_release(newest, Y, indexof(d0)); // E
>> }
>> 
>> P1(struct desc *d1)
>> {
>>         // adding a new descriptor d1 that comes after d0
>> 
>>         struct desc *d0;
>>         int r0, r1;
>> 
>>         r0 = READ_ONCE(newest);                 // A
>>         d0 = &array[r0];
>>         r1 = READ_ONCE(d0->seq);                // B
>>         WRITE_ONCE(d0->next, Z);                // F
>> }
>> 
>> d0 is the same address for P0 and P1. (The values of EOL, X, Y, Z are
>> unrelated and irrelevant.)
>
>   (1) If A reads from E, then B reads from D (or from another store
>       to ->seq, not reported in the snippet, which overwrites D)
>
>   (2) If A reads from E, then F overwrites C
>
> This, IIUC, for the informal descriptions of the (intended) guarantees.
> Back to the pairings in question: AFAICT,
>
>   (a) For (1), we rely on the pairing:
>
>         RELEASE from D to E  (matching)  ADDRESS DEP. from A to B
>
>   (b) For (2), we rely on the pairing:
>
>         RELEASE from C to E  (matching)  ADDRESS DEP. from A to F
>
> Does this make sense?

Yes. This is what I needed to see.

> IMO (and assuming that what I wrote above makes some sense), (a-b) and
> (1-2) above, together with the associated annotations of the code/ops,
> provide all the desired and necessary information to document MB5.
>
> For readability purposes, it could be nice to also keep the snippet you
> provided above (but let me stress, again, that such a snippet should be
> integrated with additional information as suggested above).
>
> As to "where to insert the memory barrier documentation", I really have
> no suggestion ATM.  I guess someone would split it (say, before A and E)
> while others could prefer to keep it within a same inline comment.

Thank you. This is the level of formalization I've been looking for. I
will rework the comments (and naming) and post a v3. It is probably best
for you to wait until then to look at this again. (And after going
through such formal processes, even _I_ am having difficulties
understanding what some of my memory barriers are supposed to be
synchronizing.)

John Ogness
