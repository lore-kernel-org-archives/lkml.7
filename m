Return-Path: <SRS0=F9vw=WN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4D59C3A59D
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 02:13:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BFC02173B
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 02:13:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbfHQCNU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 22:13:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:58666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726012AbfHQCNU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 22:13:20 -0400
Received: from oasis.local.home (rrcs-76-79-140-27.west.biz.rr.com [76.79.140.27])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7009721721;
        Sat, 17 Aug 2019 02:13:18 +0000 (UTC)
Date:   Fri, 16 Aug 2019 22:13:13 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        paulmck <paulmck@linux.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 1/1] Fix: trace sched switch start/stop racy updates
Message-ID: <20190816221313.4b05b876@oasis.local.home>
In-Reply-To: <1642847744.23403.1566005809759.JavaMail.zimbra@efficios.com>
References: <241506096.21688.1565977319832.JavaMail.zimbra@efficios.com>
        <Pine.LNX.4.44L0.1908161505400.1525-100000@iolanthe.rowland.org>
        <CAEXW_YQrh42N5bYMmQJCFb6xa0nwXH8jmZMEAnGVBMjGF8wR1Q@mail.gmail.com>
        <alpine.DEB.2.21.1908162245440.1923@nanos.tec.linutronix.de>
        <CAHk-=wh9qDFfWJscAQw_w+obDmZvcE5jWJRdYPKYP6YhgoGgGA@mail.gmail.com>
        <1642847744.23403.1566005809759.JavaMail.zimbra@efficios.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Aug 2019 21:36:49 -0400 (EDT)
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> ----- On Aug 16, 2019, at 5:04 PM, Linus Torvalds torvalds@linux-foundation.org wrote:
> 
> > On Fri, Aug 16, 2019 at 1:49 PM Thomas Gleixner <tglx@linutronix.de> wrote:  
> >>
> >> Can we finally put a foot down and tell compiler and standard committee
> >> people to stop this insanity?  
> > 
> > It's already effectively done.
> > 
> > Yes, values can be read from memory multiple times if they need
> > reloading. So "READ_ONCE()" when the value can change is a damn good
> > idea.
> > 
> > But it should only be used if the value *can* change. Inside a locked
> > region it is actively pointless and misleading.
> > 
> > Similarly, WRITE_ONCE() should only be used if you have a _reason_ for
> > using it (notably if you're not holding a lock).
> > 
> > If people use READ_ONCE/WRITE_ONCE when there are locks that prevent
> > the values from changing, they are only making the code illegible.
> > Don't do it.  
> 
> I agree with your argument in the case where both read-side and write-side
> are protected by the same lock: READ/WRITE_ONCE are useless then. However,
> in the scenario we have here, only the write-side is protected by the lock
> against concurrent updates, but reads don't take any lock.

And because reads are not protected by any lock or memory barrier,
using READ_ONCE() is pointless. The CPU could be doing a lot of hidden
manipulation of that variable too.

Again, this is just to enable caching of the comm. Nothing more. It's a
"best effort" algorithm. We get it, we then can map a pid to a name. If
not, we just have a pid and we map "<...>".

Next you'll be asking for the memory barriers to guarantee a real hit.
And honestly, this information is not worth any overhead.

And most often we enable this before we enable the tracepoint we want
this information from, which requires modification of the text area and
will do a bunch of syncs across CPUs. That alone will most likely keep
any race from happening.

The only real bug is the check to know if we should add the probe or
not was done outside the lock, and when we hit the race, we could add a
probe twice, causing the kernel to spit out a warning. You fixed that,
and that's all that needs to be done. I'm now even more against adding
the READ_ONCE() or WRITE_ONCE().


-- Steve



> 
> If WRITE_ONCE has any use at all (protecting against store tearing and
> invented stores), it should be used even with a lock held in this
> scenario, because the lock does not prevent READ_ONCE() from observing
> transient states caused by lack of WRITE_ONCE() for the update.
> 
> So why does WRITE_ONCE exist in the first place ? Is it for documentation
> purposes only or are there actual situations where omitting it can cause
> bugs with real-life compilers ?
> 
> In terms of code change, should we favor only introducing WRITE_ONCE
> in new code, or should existing code matching those conditions be
> moved to WRITE_ONCE as bug fixes ?
> 
>
