Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 846EEC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 07:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55429217F5
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 07:13:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbfH1HNs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 03:13:48 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:45818 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726154AbfH1HNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 03:13:47 -0400
Received: from localhost ([127.0.0.1] helo=vostro.local)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1i2s9G-0001nS-3j; Wed, 28 Aug 2019 09:13:42 +0200
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
Subject: Re: numlist API Re: [RFC PATCH v4 1/9] printk-rb: add a new printk ringbuffer implementation
References: <20190807222634.1723-1-john.ogness@linutronix.de>
        <20190807222634.1723-2-john.ogness@linutronix.de>
        <20190823171802.eo2chwyktibeub7a@pathway.suse.cz>
        <20190823171802.eo2chwyktibeub7a@pathway.suse.cz>
        <87sgpnmqdo.fsf@linutronix.de>
        <20190827130349.6mrnhdlqyqokgsfk@pathway.suse.cz>
Date:   Wed, 28 Aug 2019 09:13:39 +0200
In-Reply-To: <20190827130349.6mrnhdlqyqokgsfk@pathway.suse.cz> (Petr Mladek's
        message of "Tue, 27 Aug 2019 15:03:49 +0200")
Message-ID: <87o909lq3g.fsf@linutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-08-27, Petr Mladek <pmladek@suse.com> wrote:
> The API is complicated because of the callbacks. It depends on a logic
> that is implemented externally. It makes it abstract to some extent.
>
> My view is that the API would be much cleaner and easier to review
> when the ID handling is "hardcoded" (helper functions). It could be
> made abstract anytime later when there is another user.
>
> There should always be a reason why to make a code more complicated
> than necessary. It seems that the only reason is some theoretical
> future user and its theoretical requirements.

FWIW, I did _not_ create the numlist and dataring structures in order to
support some theoretical future user. PeterZ helped[0] me realize that
RFCv2 was actually using multiple internal data structures. Each of
these internal data structures has their own set of memory barriers and
semantics. By explicitly refactoring them behind strong APIs, the memory
barriers could be clearly visible and the semantics clearly defined.

For me this was a great help in _simplifying_ the design. For me it also
greatly simplified debugging, testing, and verifying because I could
write tests for numlist and datalist that explicitly targeted those data
structures. Once I believed they were bullet-proof, I could move on to
higher-level tests of the printk_ringbuffer. And once I believed the
printk_ringbuffer was bullet-proof, I could move on to the higher-level
printk tests. When a problem was found, I could effectively isolate
which component failed their job.

I understand that we disagree about the abstractions being a
simplification. And I'm not sure how to proceed in this regard. (Maybe
once we get everything bullet-proof, we can put everything back together
into a monolith like RFCv2.) Either way, please understand that the
abstractions were done for the benefit of printk_ringbuffer, not for any
theoretical future user.

John Ogness

[0] https://lkml.kernel.org/r/20190628154435.GZ7905@worktop.programming.kicks-ass.net
