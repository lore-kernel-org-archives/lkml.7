Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20C33C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 21:17:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD1E620684
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 21:17:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726364AbfCFVR3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 16:17:29 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:52450 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbfCFVR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 16:17:28 -0500
Received: from localhost ([127.0.0.1] helo=vostro.local)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1h1dud-00056P-W4; Wed, 06 Mar 2019 22:17:16 +0100
From:   John Ogness <john.ogness@linutronix.de>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org,
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
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [RFC PATCH v1 08/25] printk: add ring buffer and kthread
References: <20190212143003.48446-1-john.ogness@linutronix.de>
        <20190212143003.48446-9-john.ogness@linutronix.de>
        <20190304073856.GA552@jagdpanzerIV>
        <20190304100044.GC21004@jagdpanzerIV>
        <20190304110703.GA960@tigerII.localdomain>
        <87o96p9gtx.fsf@linutronix.de>
        <20190306155701.wc22i2no5swdcids@pathway.suse.cz>
Date:   Wed, 06 Mar 2019 22:17:12 +0100
Message-ID: <87r2bjbt47.fsf@linutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-03-06, Petr Mladek <pmladek@suse.com> wrote:
>> I would like to clarify that message supression (i.e. console loglevel)
>> is a method of reducing what is printed. It does nothing to address the
>> issues related to console printing. My proposal focusses on addressing
>> the issues related to console printing.
>> 
>> Console printing is a convenient feature to allow a kernel to
>> communicate information to a user without any reliance on
>> userspace. IMHO there are 2 categories of messages that the kernel will
>> communicate. The first is informational (usb events, wireless and
>> ethernet connectivity, filesystem events, etc.). Since this category of
>> messages occurs during normal runtime, we should expect that it does not
>> cause adverse effects to the rest of the system (such as latencies and
>> non-deterministic behavior).
>>
>> The second category is for emergency situations, where the kernel needs
>> to report something unusual (panic, BUG, WARN, etc.). In some of these
>> situations, it may be the last thing the kernel ever does. We should
>> expect this category to focus on getting the message out as reliably as
>> possible. Even if it means disturbing the system with large latencies.
>> 
>> _Both_ categories are important for the user, but their requirements are
>> different:
>> 
>>    informational: non-disturbing
>>    emergency:     reliable
>
> Isn't this already handled by the console_level?

You mean that the current console level is being used to set the
boundary between emergency and informational messages? Definitely no!
Take any Linux distribution and look at their default console_level
setting. Even the kernel code defaults to a value of 7!

> The informational messages can be reliably read via syslog, /dev/kmsg.
> They are related to the normal works when the system works well.

Yes, this is how things _could_ be. But why are users currently using
the kernel's console printing for informational messages? And why is the
kernel code encouraging it? Perhaps because users like being able to
receive messages without relying on userspace tools? IMO it is this mass
use of console printing for informational messages that is preventing
the implementation from becoming optimally reliable.

My proposal is making this distinction clearer: a significant increase
in reliability for emergency messages, and a fully preemptible printer
for informational messages. The fully preemptible printer will work just
as well as any userspace tool, but doesn't require userspace. Not
requiring userspace seems to me to be the part users are interested
in.

(But I might be wrong on this. Perhaps Linux is just "marketing" its
console printing feature incorrectly and users aren't aware that it is
only meant for emergencies.)

> The emergency messages (errors, warnings) are printed in emergency
> situations. They are printed as reliably as possible to the console
> because the userspace might not be reliable enough.

As reliably as _possible_? I hope that my series at least helps to show
that we can do a lot better about reliability.

> That said, the "atomic" consoles brings new possibilities
> and might be very useful in some scenarios. Also a more grained
> prioritization might be helpful.
>
> But each solution might just bring new problems. For example,
> the atomic consoles are still serialized between CPUs. It might
> slow down the entire system and not only on task.

Why is that a problem? The focus is reliabilty. We are talking about
emergency messages here. Messages that should never occur for a
correctly functioning system. It does not matter if the entire system
slows down because of it.

> If it gets blocked for some reasons (nobody is perfect) it would
> block all the other serialized CPUs as well.

Yes, blocking in an atomic context would be bad for any code.

> In each case, we really need to be careful about the complexity.
> printk() is already complex enough. It might be acceptable if
> it makes the design cleaner and less tangled. printk() would
> deserve a redesign.

It is my belief that I am significantly simplifying printk because there
are no more exotic contexts and situations. Emergency messages are
atomic and immediate. Context does not matter. Informational messages
are printed fully preemptible, so console drivers are free to do
whatever magic they want to do. Do you see that as more complex than the
current implementation of safe buffers, defers, hand-offs, exclusive
consoles, and cond_rescheds?

John Ogness
