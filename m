Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34A2AC10F06
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 10:52:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05D9120857
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 10:52:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbfCKKwK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 06:52:10 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:38055 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727261AbfCKKwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 06:52:09 -0400
Received: from localhost ([127.0.0.1] helo=vostro.local)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1h3IX9-00021p-IH; Mon, 11 Mar 2019 11:51:51 +0100
From:   John Ogness <john.ogness@linutronix.de>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Wang <wonderfly@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Jiri Slaby <jslaby@suse.com>,
        Peter Feiner <pfeiner@google.com>, linux-serial@vger.kernel.org
Subject: Re: [RFC PATCH v1 08/25] printk: add ring buffer and kthread
References: <20190212143003.48446-1-john.ogness@linutronix.de>
        <20190212143003.48446-9-john.ogness@linutronix.de>
        <20190304073856.GA552@jagdpanzerIV>
        <20190304100044.GC21004@jagdpanzerIV>
        <20190304110703.GA960@tigerII.localdomain>
        <87o96p9gtx.fsf@linutronix.de> <20190307051530.GC4893@jagdpanzerIV>
Date:   Mon, 11 Mar 2019 11:51:49 +0100
In-Reply-To: <20190307051530.GC4893@jagdpanzerIV> (Sergey Senozhatsky's
        message of "Thu, 7 Mar 2019 14:15:30 +0900")
Message-ID: <87va0pznsq.fsf@linutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-03-07, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com> wrote:
>> The current printk implementation will do a better job of getting the
>> informational messages out, but at an enormous cost to all the tasks
>> on the system (including the realtime tasks). I am proposing a printk
>> implementation where the tasks are not affected by console printing
>> floods.
>
> In new printk design the tasks are still affected by printing floods.
> Tasks have to line up and (busy) wait for each other, regardless of
> contexts.

They only line up and busy wait is to add the informational message to
the ring buffer. The current printk implementation is the same in this
respect. And as you've noted, the logbuf spinlock is not a source of
latencies.

> One of the late patch sets which I had (I never ever published it) was
> a different kind of printk-kthread offloading. The idea was that
> whatever should be printed (suppress_message_printing()) should be
> printed. We obviously can't loop in console_unlock() for ever and
> there is only one way to figure out if we can print out more messages,
> that's why printk became RCU stall detector and watchdog aware; and
> printk would break out and wake up printk_kthread if it sees that
> watchdog is about to get angry on that particular CPU. printk_kthread
> would run with preemption disabled and do the same thing: if it spent
> watchdog_threshold / 2 printing - breakout, enable local IRQ,
> cond_resched(). IOW watchdogs determine how much time we can spend on
> printing.

I studied and experimented with this (from your git). It was an
interesting idea of keeping the current logic, but allowing to offload
to a separate kthread if things were getting too overloaded. (It is also
where I got term "emergency" from.)

But I was satisfied with neither the direct printing (winner takes all,
printk-safe defers) nor _relying_ on a kthread for important messages in
an offload situation. This is what convinced me that the kernel needs a
new interface so that it can communicate the _really_ important things
synchronously: write_atomic().

>> I want messages of the information category to cause no disturbance
>> to the system. Give the kernel the freedom to communicate to users
>> without destroying its own performance. This can only be achieved if
>> the messages are printed from a _fully_ preemptible context.
> [..]
>> And I want messages of the emergency category to be as reliable as
>> possible, regardless of the costs to the system. Give the kernel a
>> clear mechanism to _reliably_ communicate critical information.  Such
>> messages should never appear on a correctly functioning system.
>
> I don't really understand the role of loglevel anymore.
>
> When I do ./a.out --loglevel=X  I have a clear understanding that
> all messages which fall into [critical, X] range will be in the logs,
> because I told that application that those messages are important to
> me right now. And it used to be the same with the kernel loglevel.

The loglevel is not related to logging. It specifies the amount of
console printing. But I will assume you are referring to creating log
files by having an external device store the console printing.

> But now the kernel will do its own thing:
>
>   - what the kernel considers important will go into the logs
>   - what the kernel doesn't consider important _maybe_ will end up
>     in the logs (preemptible printk kthread). And this is where
>     loglevel now. After the _maybe_ part.

"what the kernel considers" is a configuration option of the
administrator. The administrator can increase the verbocity of the
console (loglevel) without having negative effects on the system
itself. Also, if the system were to suddenly crash, those crash messages
shouldn't be in jeopardy just because the verbocity of the console was
turned up.

You (and Petr) talk about that _all_ console printing is for
emergencies. That if an administrator sets the loglevel to 7 it is
because the pr_info messages are just as important as the pr_emerg. And
if that is indeed the intention of console printing and loglevel, then
why is asynchronous printk calls for console messages even allowed
today? IMO that isn't taking the importance of the message very
seriously.

> If I'm not mistaken, Tetsuo reported that on a box under heavy OOM
> pressure he saw preemptible printk dragging 5 minutes behind the
> logbuf head. Preemptible printk is good for nothing. It's beyond
> useless, it's something else.

The informational messages are correctly timestamped and can be sorted
offline. They are informational, so any loss is less tragic. And they
aren't affecting system performance because they are being printed in
preemptible contexts.

John Ogness
