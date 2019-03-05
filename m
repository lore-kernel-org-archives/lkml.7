Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE832C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 21:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B313A2082C
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 21:01:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728635AbfCEVBn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 16:01:43 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:47316 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbfCEVBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 16:01:43 -0500
Received: from localhost ([127.0.0.1] helo=vostro.local)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1h1HBO-0006fN-Vo; Tue, 05 Mar 2019 22:01:03 +0100
From:   John Ogness <john.ogness@linutronix.de>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
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
Date:   Tue, 05 Mar 2019 22:00:58 +0100
In-Reply-To: <20190304110703.GA960@tigerII.localdomain> (Sergey Senozhatsky's
        message of "Mon, 4 Mar 2019 20:07:03 +0900")
Message-ID: <87o96p9gtx.fsf@linutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sergey,

Thanks for your feedback.

I am responding to this comment ahead of your previous comments because
it really cuts at the heart of the proposed design. After addressing
this point it will make it easier for me to respond to your other
comments.

NOTE: This is a lengthy response.

On 2019-03-04, Sergey Senozhatsky <sergey.senozhatsky@gmail.com> wrote:
>> But in general, channels which depend on preemptible printk will
>> become totally useless in some cases.
>
> Which brings me to a question - what are those messages/channels? Not
> important enough to be printed on consoles immediately, yet important
> enough to pass the suppress_message_printing() check.

I would like to clarify that message supression (i.e. console loglevel)
is a method of reducing what is printed. It does nothing to address the
issues related to console printing. My proposal focusses on addressing
the issues related to console printing.

Console printing is a convenient feature to allow a kernel to
communicate information to a user without any reliance on
userspace. IMHO there are 2 categories of messages that the kernel will
communicate. The first is informational (usb events, wireless and
ethernet connectivity, filesystem events, etc.). Since this category of
messages occurs during normal runtime, we should expect that it does not
cause adverse effects to the rest of the system (such as latencies and
non-deterministic behavior).

The second category is for emergency situations, where the kernel needs
to report something unusual (panic, BUG, WARN, etc.). In some of these
situations, it may be the last thing the kernel ever does. We should
expect this category to focus on getting the message out as reliably as
possible. Even if it means disturbing the system with large latencies.

_Both_ categories are important for the user, but their requirements are
different:

   informational: non-disturbing
   emergency:     reliable

But what if a console doesn't support the write_atomic() that the
emergency category requires? Then implement it. We currently have about
80 console drivers.

But what if can't be implemented? vt console, for example? Yes, the vt
console would be tricky. It doesn't even support the current
bust_spinlocks/oops_in_progress. But since the emergency category has a
clear requirement (reliability), it means that a vt write_atomic() does
not need to be concerned with system disturbance. That could help to
find an implementation that will work, even for vt.

> We may wave those semi-important messages good bye, I'm afraid,
> preemptible printk will take care of it.

You are talking about a system that is overloaded with messages to print
to the console. The current printk implementation will do a better job
of getting the informational messages out, but at an enormous cost to
all the tasks on the system (including the realtime tasks). I am
proposing a printk implementation where the tasks are not affected by
console printing floods. When the CPU is allowed to dedicate itself to
tasks, this obviously reduces the CPU available for console printing,
and thus more messages will be lost. It is a choice to clarify printk's
role (non-disturbance) and at the same time guarantee more determinism
for the kernel and its tasks.

As I've said, the messages of the informational category are also
important. There are things that can be done to help get these messages
out. For example:

- Creating printk-kthreads per console (and thus per-console locks) so
  that printk-buffer readers are not slowing each other down.

- Having printk-threads use priority-buckets based on loglevels so that
  (like the rt scheduler) more important messages are printed first.

- Assigning the printk-kthread of more important consoles an appropriate
  realtime priority.

> So... do we have a case here? Do we really need printk-kthread?

Obviously I answer yes to that.

I want messages of the information category to cause no disturbance to
the system. Give the kernel the freedom to communicate to users without
destroying its own performance. This can only be achieved if the
messages are printed from a _fully_ preemptible context.

And I want messages of the emergency category to be as reliable as
possible, regardless of the costs to the system. Give the kernel a clear
mechanism to _reliably_ communicate critical information. Such messages
should never appear on a correctly functioning system.

And again, both of the above have nothing to do with message
suppression. Here I am addressing the console printing issues:
reliability and disturbance.

John Ogness
