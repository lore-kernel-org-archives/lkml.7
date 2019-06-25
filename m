Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C858C48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 08:45:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38D3221783
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 08:45:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730802AbfFYIo6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 04:44:58 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41309 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbfFYIo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 04:44:58 -0400
Received: from localhost ([127.0.0.1] helo=vostro.local)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1hfh3t-0000XF-62; Tue, 25 Jun 2019 10:44:21 +0200
From:   John Ogness <john.ogness@linutronix.de>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [RFC PATCH v2 1/2] printk-rb: add a new printk ringbuffer implementation
References: <20190607162349.18199-1-john.ogness@linutronix.de>
        <20190607162349.18199-2-john.ogness@linutronix.de>
        <20190618045117.GA7419@jagdpanzerIV> <87imt2bl0k.fsf@linutronix.de>
        <20190625064543.GA19050@jagdpanzerIV>
        <20190625071500.GB19050@jagdpanzerIV>
Date:   Tue, 25 Jun 2019 10:44:19 +0200
In-Reply-To: <20190625071500.GB19050@jagdpanzerIV> (Sergey Senozhatsky's
        message of "Tue, 25 Jun 2019 16:15:00 +0900")
Message-ID: <875zoujbq4.fsf@linutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-06-25, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com> wrote:
>>>> +	struct prb_reserved_entry e;
>>>> +	char *s;
>>>> +
>>>> +	s = prb_reserve(&e, &rb, 32);
>>>> +	if (s) {
>>>> +		sprintf(s, "Hello, world!");
>>>> +		prb_commit(&e);
>>>> +	}
>>>
>>> A nit: snprintf().
>>>
>>> sprintf() is tricky, it may write "slightly more than was
>>> anticipated" bytes - all those string_nocheck(" disabled"),
>>> error_string("pK-error"), etc.
>> 
>> Agreed. Documentation should show good examples.
> 
> In vprintk_emit(), are we going to always reserve 1024-byte
> records, since we don't know the size in advance, e.g.
> 
> 	printk("%pS %s\n", regs->ip, current->name)
> 		prb_reserve(&e, &rb, ????);
> 
> or are we going to run vscnprintf() on a NULL buffer first,
> then reserve the exactly required number of bytes and afterwards
> vscnprintf(s) -> prb_commit(&e)?

(As suggested by Petr) I want to use vscnprintf() on a NULL
buffer. However, a NULL buffer is not sufficient because things like the
loglevel are sometimes added via %s (for example, in /dev/kmsg). So
rather than a NULL buffer, I would use a small buffer on the stack
(large enough to store loglevel/cont information). This way we can use
vscnprintf() to get the exact size _and_ printk_get_level() will see
enough of the formatted string to parse what it needs.

> I'm asking this because, well, if the most common usage
> pattern (printk->prb_reserve) will always reserve fixed
> size records (aka data blocks), then you _probably_ (??)
> can drop the 'variable size records' requirement from prb
> design and start looking at records (aka data blocks) as
> fixed sized chunks of bytes, which are always located at
> fixed offsets.

The average printk message size is well under 128 bytes. It would be
quite wasteful to always reserve 1K blocks.

John Ogness
