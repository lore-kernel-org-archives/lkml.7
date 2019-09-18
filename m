Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F00DC4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 07:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 586CE21907
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 07:33:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729274AbfIRHdN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 03:33:13 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:45063 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725298AbfIRHdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 03:33:13 -0400
Received: from localhost ([127.0.0.1] helo=vostro.local)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1iAUSU-0008LA-Tw; Wed, 18 Sep 2019 09:33:03 +0200
From:   John Ogness <john.ogness@linutronix.de>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Theodore Ts'o <tytso@mit.edu>, Paul Turner <pjt@google.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Prarit Bhargava <prarit@redhat.com>
Subject: Re: printk meeting at LPC
References: <20190807222634.1723-1-john.ogness@linutronix.de>
        <20190904123531.GA2369@hirez.programming.kicks-ass.net>
        <20190905130513.4fru6yvjx73pjx7p@pathway.suse.cz>
        <20190905143118.GP2349@hirez.programming.kicks-ass.net>
        <alpine.DEB.2.21.1909051736410.1902@nanos.tec.linutronix.de>
        <20190905121101.60c78422@oasis.local.home>
        <alpine.DEB.2.21.1909091507540.1791@nanos.tec.linutronix.de>
        <87k1acz5rx.fsf@linutronix.de> <20190918012546.GA12090@jagdpanzerIV>
        <20190917220849.17a1226a@oasis.local.home>
        <20190918023654.GB15380@jagdpanzerIV>
Date:   Wed, 18 Sep 2019 09:33:01 +0200
In-Reply-To: <20190918023654.GB15380@jagdpanzerIV> (Sergey Senozhatsky's
        message of "Wed, 18 Sep 2019 11:36:54 +0900")
Message-ID: <87lfumnjo2.fsf@linutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-09-18, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com> wrote:
>>>> 2. A kernel thread will be created for each registered console,
>>>> each responsible for being the sole printers to their respective
>>>> consoles. With this, console printing is _fully_ decoupled from
>>>> printk() callers.
>>> 
>>> sysrq over serial?
>>> 
>>> offloading this to kthread may be unreliable.
>> 
>> But we also talked about an "emergency flush" which will not wait for
>> the kthreads to finish and just output everything it can find in the
>> printk buffers (expecting that the consoles have an "emergency"
>> handler. We can add a sysrq to do an emergency flush.

The problem with only a flush here is that the sysrq output may not fit
in the ringbuffer (ftrace, for example). It probably makes more sense to
have a switch to enter/exit "synchronous state", where all atomic
consoles are flushed upon enter and all future printk's are synchronous
on atomic consoles until exit.

I expect sysrq to be the only valid use of "synchronous state" other
than oops/panic. Although I suppose PeterZ would like a boot argument to
always run the consoles in this state.

> I agree that when consoles have ->atomic_write then it surely makes
> sense to switch to emergency mode. I like the emergency state
> approach, but I'm not sure how it can be completely invisible to the
> rest of the system.  Quoting John:
>
>     : Unlike oops_in_progress, this state will not be visible to
>     : anything outside of the printk infrastructure.
>
> For instance, tty/sysrq must be able to switch printk emergency
> on/off.

The switch/flush _will_ be visible. But not the state. So, for example,
it won't be possible for some random driver to determine if we are in an
emergency state. (Well, I don't know if oops_in_progress will really
disappear. But at least the printk/console stuff will no longer rely on
it.)

> We also figured out that some PM (hibernation/suspend/etc.) stages
> (very early and/or very late ones) [2] also should have printk in
> emergency mode, plus some other parts of the kernel [3].
>
> [1] https://lore.kernel.org/lkml/20170815025625.1977-4-sergey.senozhatsky@gmail.com/
> [2] https://lore.kernel.org/lkml/20170815025625.1977-7-sergey.senozhatsky@gmail.com/
> [3] https://lore.kernel.org/lkml/20170815025625.1977-8-sergey.senozhatsky@gmail.com/

Thanks for bringing up that RFC thread again. I haven't looked at it in
over a year. I will go through it again to see if there is anything I've
overlooked. Particularly the suspend stuff.

John Ogness
