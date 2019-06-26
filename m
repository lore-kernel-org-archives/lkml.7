Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22CD4C48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 21:44:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1A3820665
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 21:44:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbfFZVoH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 17:44:07 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50398 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbfFZVoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 17:44:07 -0400
Received: from localhost ([127.0.0.1] helo=vostro.local)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1hgFht-00084M-VS; Wed, 26 Jun 2019 23:43:58 +0200
From:   John Ogness <john.ogness@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [RFC PATCH v2 1/2] printk-rb: add a new printk ringbuffer implementation
References: <20190607162349.18199-1-john.ogness@linutronix.de>
        <20190607162349.18199-2-john.ogness@linutronix.de>
        <20190621140516.h36g4in26pe3rmly@pathway.suse.cz>
        <87d0j31iyc.fsf@linutronix.de>
        <20190626211610.GY7905@worktop.programming.kicks-ass.net>
Date:   Wed, 26 Jun 2019 23:43:56 +0200
In-Reply-To: <20190626211610.GY7905@worktop.programming.kicks-ass.net> (Peter
        Zijlstra's message of "Wed, 26 Jun 2019 23:16:10 +0200")
Message-ID: <87k1d8koo3.fsf@linutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-06-26, Peter Zijlstra <peterz@infradead.org> wrote:
>> Here are the writer-relevant memory barriers and their associated
>> variables:
>> 
>> MB1: data_list.oldest
>> MB2: data_list.newest
>> MB3: data_block.id
>> MB4: descr.data_next
>> MB5: descr_list.newest
>> MB6: descr.next
>
> I think this is the fundamental divergence in parlance.
>
> You seem to associate a barrier with a (single) variable, where
> normally a barrier is between two (or more) variables.

The litmus tests I posted to answer your previous questions should
(hopefully) show that I already understand this. The above list shows
the _key_ loads/stores that are used to guarantee ordering (for these
and other memory operations). And yes, I now understand that my comments
need to list all the operations that are being ordered based on these
key loads/stores.

> As you wrote in that other email (I'm stlil going through all that);
> your MB5 isn't desc_list.newest, but rather between desc_list.newest
> and descr.next.

Here is where I have massive problems communicating. I don't understand
why you say the barrier is _between_ newest and next. I would say the
barrier is _on_ newest to _synchronize_ with next (or something). I am
struggling with terminology. (To be honest, I'd much rather just post
litmus tests.)

For example, if we have:

WRITE_ONCE(&a, 1);
WRITE_ONCE(&b, 1);
WRITE_ONCE(&c, 1);
smp_store_release(&d, 1);

and:

local_d = smp_load_acquire(&d);
local_a = READ_ONCE(&a);
local_b = READ_ONCE(&b);
local_c = READ_ONCE(&c);

How do you describe that? Do you say the memory barrier is between a and
d? Or between a, b, c, d? (a, b, c aren't ordered, but they are one-way
synchronized with d).

I would say there is a barrier on d to synchronize a, b, c.

John Ogness
