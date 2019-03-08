Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C28C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 04:05:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E17722081B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 04:05:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726348AbfCHEFa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 23:05:30 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:59512 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbfCHEF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 23:05:29 -0500
Received: from localhost ([127.0.0.1] helo=vostro.local)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1h26l0-0000gS-F1; Fri, 08 Mar 2019 05:05:14 +0100
From:   John Ogness <john.ogness@linutronix.de>
To:     Petr Mladek <pmladek@suse.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Wang <wonderfly@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Jiri Slaby <jslaby@suse.com>,
        Peter Feiner <pfeiner@google.com>,
        linux-serial@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [RFC PATCH v1 20/25] serial: 8250: implement write_atomic
References: <20190212143003.48446-1-john.ogness@linutronix.de>
        <20190212143003.48446-21-john.ogness@linutronix.de>
        <20190227094655.ecdwhsc2bf5spkqx@pathway.suse.cz>
        <87zhqhed3u.fsf@linutronix.de>
        <20190227135504.gqtcsdwpy4rd7xvs@pathway.suse.cz>
Date:   Fri, 08 Mar 2019 05:05:12 +0100
In-Reply-To: <20190227135504.gqtcsdwpy4rd7xvs@pathway.suse.cz> (Petr Mladek's
        message of "Wed, 27 Feb 2019 14:55:04 +0100")
Message-ID: <87a7i6ovt3.fsf@linutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-02-27, Petr Mladek <pmladek@suse.com> wrote:
>>>> Implement a non-sleeping NMI-safe write_atomic console function in
>>>> order to support emergency printk messages.
>>>
>>> OK, it would be safe when prb_lock() is the only lock taken
>>> in the NMI handler.
>> 
>> Which is the case. As I wrote to you already [0], NMI contexts are
>> _never_ allowed to do things that rely on waiting forever for other
>> CPUs.
>
> Who says _never_? I agree that it is not reasonable. But the
> history shows that it happens.

Right, which is why it would need to become policy.

The emergency messages (aka write_atomic) introduce a new requirement to
the kernel because this callback must be callable from any context. The
console drivers must have some way of synchronizing. The CPU-reentrant
spin lock is the only solution I am aware of.

> In principle, there is nothing wrong in using spinlock in NMI
> when it is used only in NMI.

The CPU-reentrant spin lock _will_ be used in NMI context and
potentially could be used from any line of NMI code (if, for example, a
panic is triggered). The problem is when you have 2 different spin locks
in NMI context and their ordering cannot be guaranteed. And since I am
introducing an implicit spin lock that potentially could be locked from
any line of code, any explicit use of a spin lock in NMI could would
really be adding a 2nd spin lock and thus deadlock potential.

If the ringbuffer was fully lockless, we should be able to have
per-console CPU-reentrant spin locks as long as the ordering is
preserved, which I expect shouldn't be a problem. If any NMI context
needed a spin lock for its own purposes, it would need to use the
CPU-reentrant spin lock of the first console so as to preserve the
ordering in case of a panic.

>>>    2. I am afraid that we need to add some locking between CPUs
>>>       to avoid mixing characters from directly printed messages.
>> 
>> That is exactly what console_atomic_lock() (actually prb_lock) is!
>
> Sure. But it should not be a common lock for the ring buffer and
> all consoles.

As long as the ring buffer requires a CPU-reentrant spin lock, I expect
that it _must_ be a common lock for all. Consider the situation that the
ring buffer writer code causes a panic. I think it is beneficial if at
least 1 level of printk recursion is supported so that even these
backtraces make it out on the emergency consoles.

If the ring buffer becomes fully lockless, then we could move to
per-console CPU-reentrant spin locks.

John Ogness
