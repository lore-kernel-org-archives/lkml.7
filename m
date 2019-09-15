Return-Path: <SRS0=lz0T=XK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5855EC4CECC
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 13:47:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35313214DE
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 13:47:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731570AbfIONrq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Sep 2019 09:47:46 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:37576 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730694AbfIONrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Sep 2019 09:47:45 -0400
Received: from localhost ([127.0.0.1] helo=vostro.local)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1i9UsC-0004QS-Ez; Sun, 15 Sep 2019 15:47:28 +0200
From:   John Ogness <john.ogness@linutronix.de>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>, Paul Turner <pjt@google.com>,
        Prarit Bhargava <prarit@redhat.com>
Subject: Re: printk meeting at LPC
References: <20190807222634.1723-1-john.ogness@linutronix.de>
        <20190904123531.GA2369@hirez.programming.kicks-ass.net>
        <20190905130513.4fru6yvjx73pjx7p@pathway.suse.cz>
        <20190905143118.GP2349@hirez.programming.kicks-ass.net>
        <alpine.DEB.2.21.1909051736410.1902@nanos.tec.linutronix.de>
        <20190905121101.60c78422@oasis.local.home>
        <alpine.DEB.2.21.1909091507540.1791@nanos.tec.linutronix.de>
        <87k1acz5rx.fsf@linutronix.de>
        <CAKMK7uHXTGKSyXgUOucNr4HSrcnBxVkkoqA=VzF4-=sZSq1MKw@mail.gmail.com>
Date:   Sun, 15 Sep 2019 15:47:26 +0200
In-Reply-To: <CAKMK7uHXTGKSyXgUOucNr4HSrcnBxVkkoqA=VzF4-=sZSq1MKw@mail.gmail.com>
        (Daniel Vetter's message of "Fri, 13 Sep 2019 16:48:48 +0200")
Message-ID: <87d0g18ydt.fsf@linutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-09-13, Daniel Vetter <daniel.vetter@ffwll.ch> wrote:
>> 2. A kernel thread will be created for each registered console, each
>> responsible for being the sole printers to their respective
>> consoles. With this, console printing is _fully_ decoupled from
>> printk() callers.
>
> Is the plan to split the console_lock up into a per-console thing? Or
> postponed for later on?

AFAICT, the only purpose for a console_lock would be to synchronize
between the console printing kthread and some other component that wants
to write to that same device. So a per-console console_lock should be
the proper solution. However, I will look into the details. My main
concerns about this are the suspend/resume logic and the code sitting
behind /dev/console. I will share details once I've sorted it all out.

>> 6. A new may-sleep function pr_flush() will be made available to wait
>> for all previously printk'd messages to be output on all consoles
>> before proceeding. For example:
>>
>>     pr_cont("Running test ABC... ");
>>     pr_flush();
>>
>>     do_test();
>>
>>     pr_cont("PASSED\n");
>>     pr_flush();
>
> Just crossed my mind: Could/should we lockdep-annotate pr_flush (take
> a lockdep map in there that we also take around the calls down into
> console drivers in each of the console printing kthreads or something
> like that)? Just to avoid too many surprises when people call pr_flush
> from within gpu drivers and wonder why it doesn't work so well.

Why would it not work so well? Basically the task calling pr_flush()
will monitor the lockless iterators of the various consoles until _all_
have hit/passed the latest sequence number from the time of the call.

> Although with this nice plan we'll take the modeset paths fully out of
> the printk paths (even for normal outputs) I hope, so should be a lot
> more reasonable.

You will be running in your own preemptible kthread, so any paths you
take should be safe.

> From gpu perspective this all sounds extremely good and first
> realistic plan that might lead us to an actually working bsod on
> linux.

Are you planning on basing the bsod stuff on write_atomic() (which is
used after entering an emergency state) or on the kmsg_dump facility? I
would expect kmsg_dump might be more appropriate, unless there are
concerns that the machine will die before getting that far (i.e. there
is a lot that happens between when an OOPS begins and when kmsg_dumpers
are invoked).

John Ogness
