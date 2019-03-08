Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 980C4C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 04:17:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BCED20851
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 04:17:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbfCHERq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 23:17:46 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:59532 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbfCHERq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 23:17:46 -0500
Received: from localhost ([127.0.0.1] helo=vostro.local)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1h26x0-0000wU-9N; Fri, 08 Mar 2019 05:17:38 +0100
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
        <87a7i6ovt3.fsf@linutronix.de>
Date:   Fri, 08 Mar 2019 05:17:36 +0100
In-Reply-To: <87a7i6ovt3.fsf@linutronix.de> (John Ogness's message of "Fri, 08
        Mar 2019 05:05:12 +0100")
Message-ID: <8736nyov8f.fsf@linutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-03-08, John Ogness <john.ogness@linutronix.de> wrote:
> If the ringbuffer was fully lockless, we should be able to have
> per-console CPU-reentrant spin locks as long as the ordering is
> preserved, which I expect shouldn't be a problem. If any NMI context
> needed a spin lock for its own purposes, it would need to use the
> CPU-reentrant spin lock of the first console so as to preserve the
> ordering in case of a panic.

This point is garbage. Sorry. I do not see how we could safely have
multiple CPU-reentrant spin locks. Example of a deadlock:

CPU0                  CPU1
printk                printk
  console2.lock         console1.lock
NMI                   NMI
  printk                printk
    console1.lock         console2.lock

>> ... it should not be a common lock for the ring buffer and all
>> consoles.
>
> If the ring buffer becomes fully lockless, then we could move to
> per-console CPU-reentrant spin locks.

A fully lockless ring buffer will reduce the scope of the one, global
CPU-reentrant spin lock. But I do not see how we can safely have
multiple of these. If it is part of printk, it is already implicitly on
every line of code.

John Ogness
