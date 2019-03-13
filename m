Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C737DC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 08:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95EF72147C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 08:19:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbfCMITr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 04:19:47 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:46436 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbfCMITq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 04:19:46 -0400
Received: from localhost ([127.0.0.1] helo=vostro.local)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1h3z6s-0000un-UF; Wed, 13 Mar 2019 09:19:35 +0100
From:   John Ogness <john.ogness@linutronix.de>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Wang <wonderfly@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Jiri Slaby <jslaby@suse.com>,
        Peter Feiner <pfeiner@google.com>,
        linux-serial@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sebastian Siewior <bigeasy@linutronix.de>
Subject: Re: [RFC PATCH v1 00/25] printk: new implementation
References: <20190212143003.48446-1-john.ogness@linutronix.de>
        <20190213025520.GA5803@jagdpanzerIV> <874l9721hf.fsf@linutronix.de>
        <20190304052335.GA6648@jagdpanzerIV> <87lg1rggcz.fsf@linutronix.de>
        <20190311105411.GA368@jagdpanzerIV>
        <20190312123857.juatd6fwtfmqajze@pathway.suse.cz>
        <874l8815uc.fsf@linutronix.de> <20190313021534.GB783@jagdpanzerIV>
Date:   Wed, 13 Mar 2019 09:19:32 +0100
In-Reply-To: <20190313021534.GB783@jagdpanzerIV> (Sergey Senozhatsky's message
        of "Wed, 13 Mar 2019 11:15:34 +0900")
Message-ID: <87d0mv9off.fsf@linutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-03-13, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com> wrote:
>>> I suggest the following way forward (separate patchsets):
>>>
>>>     1. Replace log buffer (least controversial thing)
>> 
>> Yes. I will post a series that only implements the ringbuffer using
>> your simplified API. That will be enough to remove printk_safe and
>> actually does most of the work of updating devkmsg, kmsg_dump, and
>> syslog.
>
> This may _not_ be enough to remove printk_safe. One of the reasons
> printk_safe "condom" came into existence was console_sem (which
> is a bit too important to ignore it):
>
> 	printk()
> 	 console_trylock()
> 	  console_unlock()
> 	   up()
> 	    raw_spin_lock_irqsave(&sem->lock, flags)
> 	     __up()
> 	      wake_up_process()
> 	       WARN/etc
> 	        printk()
> 		 console_trylock()
> 		  down_trylock()
> 		   raw_spin_lock_irqsave(&sem->lock, flags)  << deadlock
>
> Back then we were looking at
>
> 	printk->console_sem->lock->printk->console_sem->lock
>
> deadlock report from LG, if I'm not mistaken.

The main drawback of printk_safe is the safe buffers, which, aside from
bogus timestamping, may never make it back to the printk log buffer.

With the new ring buffer the safe buffers are not needed, even in the
recursive situation. As you are pointing out, the notification/wake
component of printk_safe will still be needed. I will leave that (small)
part in printk_safe.c.

John Ogness
