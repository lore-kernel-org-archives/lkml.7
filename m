Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E00FC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 12:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CA9A20684
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 12:50:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbfCGMuh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 07:50:37 -0500
Received: from mx2.suse.de ([195.135.220.15]:55524 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726101AbfCGMug (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 07:50:36 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 71BE1AED4;
        Thu,  7 Mar 2019 12:50:34 +0000 (UTC)
Date:   Thu, 7 Mar 2019 13:50:33 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
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
Message-ID: <20190307125033.wwkxymneiga7itsn@pathway.suse.cz>
References: <20190212143003.48446-1-john.ogness@linutronix.de>
 <20190212143003.48446-9-john.ogness@linutronix.de>
 <20190304073856.GA552@jagdpanzerIV>
 <20190304100044.GC21004@jagdpanzerIV>
 <20190304110703.GA960@tigerII.localdomain>
 <87o96p9gtx.fsf@linutronix.de>
 <20190306155701.wc22i2no5swdcids@pathway.suse.cz>
 <87r2bjbt47.fsf@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r2bjbt47.fsf@linutronix.de>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2019-03-06 22:17:12, John Ogness wrote:
> On 2019-03-06, Petr Mladek <pmladek@suse.com> wrote:
> >> I would like to clarify that message supression (i.e. console loglevel)
> >> is a method of reducing what is printed. It does nothing to address the
> >> issues related to console printing. My proposal focusses on addressing
> >> the issues related to console printing.
> >> 
> >> Console printing is a convenient feature to allow a kernel to
> >> communicate information to a user without any reliance on
> >> userspace. IMHO there are 2 categories of messages that the kernel will
> >> communicate. The first is informational (usb events, wireless and
> >> ethernet connectivity, filesystem events, etc.). Since this category of
> >> messages occurs during normal runtime, we should expect that it does not
> >> cause adverse effects to the rest of the system (such as latencies and
> >> non-deterministic behavior).
> >>
> >> The second category is for emergency situations, where the kernel needs
> >> to report something unusual (panic, BUG, WARN, etc.). In some of these
> >> situations, it may be the last thing the kernel ever does. We should
> >> expect this category to focus on getting the message out as reliably as
> >> possible. Even if it means disturbing the system with large latencies.
> >> 
> >> _Both_ categories are important for the user, but their requirements are
> >> different:
> >> 
> >>    informational: non-disturbing
> >>    emergency:     reliable
> >
> > Isn't this already handled by the console_level?
> 
> You mean that the current console level is being used to set the
> boundary between emergency and informational messages? Definitely no!
> Take any Linux distribution and look at their default console_level
> setting. Even the kernel code defaults to a value of 7!

CONSOLE_LOGLEVEL_DEFAULT is one thing. The real life is another thing.
I could hardly imagine any distribution that would scary users by all
kernel messages.

For example, SUSE distro boots with "quiet" kernel parameter.
It seems that RedHat does the same as suggested by
https://lkml.kernel.org/r/20180619115726.3098-1-hdegoede@redhat.com
It means that the level '4' is typically used and even lower number
is wanted.

Well, SUSE (or systemd folks?) go even further. rsyslog sets
the console_loglevel to "1".


BTW: The default has been set to "7" in kernel-1.3.71 (1996-01-01).
There is no explanation for this. Well, it looks like a pre-SMP
era. printk() was not serialized with any lock. Also messages
to tty were written separately by tty_write_message(). I guess
the the default was primary for serial console and developers.


> My proposal is making this distinction clearer: a significant increase
> in reliability for emergency messages.

This is true if we fulfil several conditions. I am not sure that
the following list is complete but:

   + The commonly used consoles must provide the atomic write.
     Otherwise, it would have only few users.

   + The printk code and console atomic write must be really
     safe and maintainable.

   + The serialization of atomic consoles must not cause more
     problems than the current approach (always slow pr_err() vs.
     random printk() slow, unfair locking) [*]

   + The mixed order of directly printed and postponed messages
     must not cause too much confusion. We might need some
     userpace tools to sort them.


[*] I agree that the direct console handling has several advantages:

     + Avoid all the problems with console_lock.

     + It is more predictable (no random victims spending
       time with handling all messages).

     + It is a natural throttling of heavy printk() users.
       Less amount of lost messages (important ones never).
       Might reduce (remove) the problem with softlockups.


I am just not able to predict eventual problems. There was a reason
for the current state. People did not want always slow printk().


> Why is that a problem? The focus is reliabilty. We are talking about
> emergency messages here. Messages that should never occur for a
> correctly functioning system. It does not matter if the entire system
> slows down because of it.

This sounds too idealistic:

  + It expects that everyone is using the log levels consistently and
    with care. But many people believe that their messages are
    the most important ones.

  + Also it expects that all users use similar console_logleves
    in all situations. But it depends on the usecase. Sometimes
    warning and error messages do not make much sense without
    the context, e.g. info or even debug messages.


> > If it gets blocked for some reasons (nobody is perfect) it would
> > block all the other serialized CPUs as well.
> 
> Yes, blocking in an atomic context would be bad for any code.
> 
> > In each case, we really need to be careful about the complexity.
> > printk() is already complex enough. It might be acceptable if
> > it makes the design cleaner and less tangled. printk() would
> > deserve a redesign.
> 
> It is my belief that I am significantly simplifying printk because there
> are no more exotic contexts and situations. Emergency messages are
> atomic and immediate. Context does not matter. Informational messages
> are printed fully preemptible, so console drivers are free to do
> whatever magic they want to do. Do you see that as more complex than the
> current implementation of safe buffers, defers, hand-offs, exclusive
> consoles, and cond_rescheds?

This expects that we would be able to always offload all
non-emergency messages. I am not convinced that it is acceptable.
And I wrote this several times.

Also, please, keep the log buffer and console handling separate.
The new "lockless" log buffer solves problems that are currently
being solved by printk_safe code. While the atomic consoles
and kthread tries to solve problems with unpredictable
printk() cost (softlockups) and make the emergency messages
more reliable (lost messages).

The complexity depends on how the final code would look like.
It might be win if it is more straightforward and organized.
But there are some alarming things:

   + lockless code is always tricky

   + another console_loglevel setting is added

   + one more way to push messages to the console

   + messages are slit into 3 groups:
       + one group was subset of the other in the past
       + newly, two groups need to get joined and sorted
	 to get the original one

Best Regards,
Petr
