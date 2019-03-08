Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ABA8C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 10:28:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6420120684
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 10:28:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbfCHK2W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 05:28:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:58908 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726254AbfCHK2V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 05:28:21 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2D320AD7B;
        Fri,  8 Mar 2019 10:28:20 +0000 (UTC)
Date:   Fri, 8 Mar 2019 11:28:19 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
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
Message-ID: <20190308102819.lirle4vlf7mdcetp@pathway.suse.cz>
References: <20190212143003.48446-1-john.ogness@linutronix.de>
 <20190212143003.48446-21-john.ogness@linutronix.de>
 <20190227094655.ecdwhsc2bf5spkqx@pathway.suse.cz>
 <87zhqhed3u.fsf@linutronix.de>
 <20190227135504.gqtcsdwpy4rd7xvs@pathway.suse.cz>
 <87a7i6ovt3.fsf@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a7i6ovt3.fsf@linutronix.de>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2019-03-08 05:05:12, John Ogness wrote:
> On 2019-02-27, Petr Mladek <pmladek@suse.com> wrote:
> >>>> Implement a non-sleeping NMI-safe write_atomic console function in
> >>>> order to support emergency printk messages.
> >>>
> >>> OK, it would be safe when prb_lock() is the only lock taken
> >>> in the NMI handler.
> >> 
> >> Which is the case. As I wrote to you already [0], NMI contexts are
> >> _never_ allowed to do things that rely on waiting forever for other
> >> CPUs.
> >
> > Who says _never_? I agree that it is not reasonable. But the
> > history shows that it happens.
> 
> Right, which is why it would need to become policy.
> 
> The emergency messages (aka write_atomic) introduce a new requirement to
> the kernel because this callback must be callable from any context. The
> console drivers must have some way of synchronizing. The CPU-reentrant
> spin lock is the only solution I am aware of.

I am not in position to decide if this requirement is acceptable
or not. We would need an opinion from Linus at minimum.

But it is not acceptable from my point of view. Note that
many spinlocks might be safely used in NMI in principle.

You want to introduce a single spinlock just because
printk() could be called anywhere. Most other subsystems
do not have this problem because they a more self-contained.

> If the ringbuffer was fully lockless

Exactly, I think that a solution would be fully lockless logbuffer.


> we should be able to have per-console CPU-reentrant spin locks
> as long as the ordering is preserved, which I expect shouldn't
> be a problem. If any NMI context needed a spin lock for its own
> purposes, it would need to use the CPU-reentrant spin lock of
> the first console so as to preserve the ordering in case of a panic.

IMHO, this is not acceptable. It would be nice to have direct output
from NMI but the cost looks to high here.

A solution would be to defer the console to irq_work or so.
We might also consider using trylock in NMI and have
the irq_work just as a fallback.

Best Regars,
Petr
