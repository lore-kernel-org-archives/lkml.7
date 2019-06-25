Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED0EAC48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 12:03:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB558208CA
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 12:03:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728595AbfFYMDx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 08:03:53 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42503 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbfFYMDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 08:03:52 -0400
Received: from localhost ([127.0.0.1] helo=vostro.local)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1hfkAm-0006Fr-Ta; Tue, 25 Jun 2019 14:03:41 +0200
From:   John Ogness <john.ogness@linutronix.de>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
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
        <20190625071500.GB19050@jagdpanzerIV> <875zoujbq4.fsf@linutronix.de>
        <20190625090620.wufhvdxxiryumdra@pathway.suse.cz>
        <20190625100322.GD532@jagdpanzerIV>
Date:   Tue, 25 Jun 2019 14:03:39 +0200
In-Reply-To: <20190625100322.GD532@jagdpanzerIV> (Sergey Senozhatsky's message
        of "Tue, 25 Jun 2019 19:03:22 +0900")
Message-ID: <87woh9hnxg.fsf@linutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-06-25, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com> wrote:
>>>> In vprintk_emit(), are we going to always reserve 1024-byte
>>>> records, since we don't know the size in advance, e.g.
>>>> 
>>>> 	printk("%pS %s\n", regs->ip, current->name)
>>>> 		prb_reserve(&e, &rb, ????);
>>>> 
>>>> or are we going to run vscnprintf() on a NULL buffer first,
>>>> then reserve the exactly required number of bytes and afterwards
>>>> vscnprintf(s) -> prb_commit(&e)?
>>> 
>>> (As suggested by Petr) I want to use vscnprintf() on a NULL
>>> buffer. However, a NULL buffer is not sufficient because things like the
>>> loglevel are sometimes added via %s (for example, in /dev/kmsg). So
>>> rather than a NULL buffer, I would use a small buffer on the stack
>>> (large enough to store loglevel/cont information). This way we can use
>>> vscnprintf() to get the exact size _and_ printk_get_level() will see
>>> enough of the formatted string to parse what it needs.
>> 
>> vscnprintf() with NULL pointer is perfectly fine. Only the formatted
>> string has variable size.
>
> Yeah, that should work. Probably. Can't think of any issues, except
> for increased CPU usage. Some sprintf() format specifiers are heavier
> than the rest (pS/pF on ia64/ppc/hppa).
>
> OK, very theoretically.
>
> There is a difference.
>
> Doing "sz = vscprintf(NULL, msg); vscnprintf(buf, sz, msg)" for
> msg_print_text() and msg_print_ext_header() was safe, because the
> data - msg - would not change under us, we would work with logbuf
> records, IOW with data which is owned by printk() and printk only.
>
> But doing
> 		sz = vcsprintf(NULL, "xxx", random_pointer);
> 		if ((buf = prb_reserve(... sz))) {
> 			vscnprintf(buf, sz, "xxx", random_pointer);
> 			prb_commit(...);
> 		}
>
> might have different outcome sometimes. We probably (!!!) can have
> some race conditions. The problem is that, unlike msg_print_text()
> and msg_print_ext_header(), printk() works with pointers which it
> does not own nor control. IOW within single printk() we will access
> some random kernel pointers, then do prb stuff, then access those
> same pointers, expecting that none of them will ever change their
> state. A very simple example
>
> 		printk("Comm %s\n", current->comm)
>
> Suppose printk on CPU0 and ia64_mca_modify_comm on CPU1
>
> CPU0								CPU1
> printk(...)
>  sz = vscprintf(NULL, "Comm %s\n", current->comm);
> 								ia64_mca_modify_comm()
> 								  snprintf(comm, sizeof(comm), "%s %d", current->comm, previous_current->pid);
> 								  memcpy(current->comm, comm, sizeof(current->comm));
>  if ((buf = prb_reserve(... sz))) {
>    vscnprintf(buf, "Comm %s\n", current->comm);
> 				^^^^^^^^^^^^^^ ->comm has changed.
> 					       Nothing critical, we
> 					       should not corrupt
> 					       anything, but we will
> 					       truncate ->comm if its
> 					       new size is larger than
> 					       what it used to be when
> 					       we did vscprintf(NULL).
>    prb_commit(...);
>  }
>
> Probably there can be other examples.

This is a very good point, and quite important. It is not acceptable if
some crash output is cut off because of this effect.

In my v1 rfc series, I avoided this issue by having a separate dedicated
ringbuffer (rb_sprintf) that was used to allocate a temporary max-size
(2KB) buffer for sprinting to. Then _that_ was used for the real
ringbuffer input (strlen, prb_reserve, memcpy, prb_commit). That would
still be the approach of my choice.

John Ogness
