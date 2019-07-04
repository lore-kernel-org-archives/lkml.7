Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 562A4C0651F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 15:00:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 333C8218A6
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 15:00:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727429AbfGDPAI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 11:00:08 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59258 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727066AbfGDPAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 11:00:08 -0400
Received: from localhost ([127.0.0.1] helo=vostro.local)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1hj3DI-0004JQ-LG; Thu, 04 Jul 2019 16:59:56 +0200
From:   John Ogness <john.ogness@linutronix.de>
To:     Petr Mladek <pmladek@suse.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH POC] printk_ringbuffer: Alternative implementation of lockless printk ringbuffer
References: <20190621140516.h36g4in26pe3rmly@pathway.suse.cz>
        <20190704103321.10022-1-pmladek@suse.com>
Date:   Thu, 04 Jul 2019 16:59:54 +0200
In-Reply-To: <20190704103321.10022-1-pmladek@suse.com> (Petr Mladek's message
        of "Thu, 4 Jul 2019 12:33:21 +0200")
Message-ID: <87r275j15h.fsf@linutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Petr,

On 2019-07-04, Petr Mladek <pmladek@suse.com> wrote:
> This is POC that implements the lockless printk ringbuffer slightly
> different way. I believe that it is worth considering because it looks
> much easier to deal with. The reasons are:
>
> 	+ The state of each entry is always clear.
>
> 	+ The write access rights and validity of the data
> 	  are clear from the state of the entry.
>
> 	+ It seems that three barriers are enough to synchronize
> 	  readers vs. writers. The rest is done implicitely
> 	  using atomic operations.
>
> Of course, I might have missed some critical race that can't get
> solved by the new design easily. But I do not see it at the moment.

Two things jump out at me when looking at the implementation:

1. The code claims that the cmpxchg(seq_newest) in prb_reserve_desc()
guarantees that "The descriptor is ours until the COMMITTED bit is set."
This is not true if in that wind seq_newest wraps, allowing another
writer to gain ownership of the same descriptor. For small descriptor
arrays (such as in my test module), this situation is quite easy to
reproduce.

This was one of the reasons I chose to use a linked list. When the
descriptor is atomically removed from the linked list, it can _never_ be
used (or even seen) by any other writer until the owning writer is done
with it.

I'm not yet sure how that could be fixed with this implementation. The
state information is in a separate variable than the head pointer for
the descriptor array (seq_newest). This means you cannot atomically
reserve descriptors.

2. Another issue is when prb_reserve() fails and sets the descriptor as
unused. As it is now, no reader can read beyond that descriptor until it
is recycled. Readers need to know that the descriptor is bad and can be
skipped over. It might be better to handle this the way I did: go ahead
and set the state to committed, but have invalid lpos/lpos_next values
(for example: lpos_next=lpos) so the reader knows it can skip over the
descriptor.

> The code compiles but it is not really tested. I wanted to send it
> ASAP in a good enough state before we spend more time on cleaning
> up either of the proposals.

I am glad to see you put together your implementation. If anything, it
shows you understand the design! If after seeing my next version (v3)
you are still convinced that using a linked list for the descriptors is
too complex, then I can help support your idea to move to an array.

Thank you for taking so much time for this!

John Ogness
