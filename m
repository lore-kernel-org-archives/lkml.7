Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C43F9C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 14:01:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E9052070C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 14:01:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AuKlieUk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393922AbfIFOBv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 10:01:51 -0400
Received: from merlin.infradead.org ([205.233.59.134]:54406 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388583AbfIFOBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 10:01:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=gpf5aAu9hWU9SqMV+6i5fNOUA7v0dYz/BncaYutlffM=; b=AuKlieUkpirc8zf1CLOUibTFG
        CeFioe4Ds3ylQvfnBpiIOOTXgRKTrBGPDkHQn1+L3SOPD+QhlJFLlZDiF1pIG/6hJCRA99v61VqPm
        Zd33OwHZfxcdDYcRJCCg9Hj4XMuGj71hJ/Q3nfKGU2DC7p9LCMN3WiDr+df6+1Mm1oIzemj+p5k/R
        8fyBg7Xmanash9Xtwlhn4lE81AAfNb2LbPJITy74w+pj+/wH8rEBZGvEAzj5ZIqqAHmW7bPCZjnqh
        yrVFK8DTfTYCEqGTgvBONTlGFWr4/62I5EIjFS1bJCYseaykjS7lTACioGEUUNLLLJOH3eD/ygXR+
        dC33fqKQQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i6Eno-0000z8-3V; Fri, 06 Sep 2019 14:01:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E074D3011DF;
        Fri,  6 Sep 2019 16:00:48 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 572FD29DB9119; Fri,  6 Sep 2019 16:01:26 +0200 (CEST)
Date:   Fri, 6 Sep 2019 16:01:26 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Andrea Parri <andrea.parri@amarulasolutions.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        John Ogness <john.ogness@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v4 0/9] printk: new ringbuffer implementation
Message-ID: <20190906140126.GY2349@hirez.programming.kicks-ass.net>
References: <20190807222634.1723-1-john.ogness@linutronix.de>
 <20190904123531.GA2369@hirez.programming.kicks-ass.net>
 <20190905130513.4fru6yvjx73pjx7p@pathway.suse.cz>
 <20190905143118.GP2349@hirez.programming.kicks-ass.net>
 <20190906090627.GX2386@hirez.programming.kicks-ass.net>
 <20190906124211.2dionk2kzcslaotz@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190906124211.2dionk2kzcslaotz@pathway.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 06, 2019 at 02:42:11PM +0200, Petr Mladek wrote:

> I wish it was that simple. It is possible that I see it too
> complicated. But this comes to my mind:
> 
> 1. The simple printk_buffer_store(buf, n) is not NMI safe. For this,
>    we might need the reserve-store approach.

Of course it is, and sure it has a reserve+commit internally. I'm sure I
posted an implenentation of something like this at some point.

It is lockless (wait-free in fact, which is stronger) and supports
multi-readers. I'm sure I posted something like that before, and ISTR
John has something like that around somewhere too.

The only thing I'm omitting is doing vscnprintf() twice, first to
determine the length, and then into the reservation. Partly because I
think that is silly and 256 chars should be plenty for everyone, partly
because that avoids having vscnprintf() inside the cpu_lock() and partly
because it is simpler to not do that.

> 2. The simple approach works only with lockless consoles. We need
>    something else for the rest at least for NMI. Simle offloading
>    to a kthread has been blocked for years. People wanted the
>    trylock-and-flush-immediately approach.

Have an irq_work to wake up a kthread that will print to shit consoles.
Seriously.. the trylock and flush stuff is horrific crap. You guys been
piling on the hack for years now, surely you're tired of that gunk?

(and if you _reallllly_ care, build a flush function that 'works'
mostly and waits for the kthread of choice to finish printing to the
'imporant' shit console).

> 3. console_lock works in tty as a big kernel lock. I do not know
>    much details. But people familiar with the code said that
>    it was a disaster. I assume that tty is still rather
>    important console. I am not sure how it would fit into the
>    simple approach.

The kernel thread in charge of printing doesn't care.

> 4. The console handling has got non-synchronous (console_trylock)
>    quite early (ver 2.4.10, year 2001). The reason was to do not
>    serialize CPUs by the speed of the console.
> 
>    Serialized output could remove many troubles. The logic in
>    console_unlock() is really crazy. It might be acceptable
>    for debugging. But is it acceptable on production systems?

The kernel thread doesn't care. If you care about independent consoles,
have a kernel thread per console. That way a fast console can print fast
while a slow console will print slow and everybody is happy.

> 5. John planed to use the cpu_lock in the lockless consoles.
>    I wonder if it was only in the console->write() callback
>    or if it would spread the lock more widely.

Right, I'm saying that since you need it anyway, lift it up one layer.
It makes everything simpler. More simpler is more better.

> 6. One huge nightmare is panic() and code called from there.
>    It is a maze of hacks, including arch-specific code, to
>    prevent deadlocks and get the messages out.
> 
>    Any lock might be blocked on any CPU at the moment. Or it
>    it might become blocked when CPUs are stopped by NMI.
> 
>    Fully lock-less log buffer might save us some headache.
>    I am not sure whether a single lock shared between printk()
>    writers and console drivers will make the situation easier
>    or more complicated.

So panic is a non issue for the lockless console.

It only matters if you care to get something out of the crap consoles.
So print everything to the lockless buffer and lockless consoles, then
try and force as much as you can out of the crap consoles.

If you die, tought luck, at least the lockless consoles and kdump image
have the whole message.

> 7. People would complain when continuous lines become less
>    reliable. It might be most visible when mixing backtraces
>    from all CPUs. Simple sorting by prefix will not make
>    it readable. The historic way was to synchronize CPUs
>    by a spin lock. But then the cpu_lock() could cause
>    deadlock.

Why? I'm running with that thing on, I've never seen a deadlock ever
because of it. In fact, i've gotten output that is plain impossible with
the current junk.

The cpu-lock is inside the all-backtrace spinlock, not outside. And as I
said yesterday, only the lockless console has any wait-loops while
holding the cpu-lock. It _will_ make progress.

> I would be really happy when we could ignore some of the problems
> or find an easy solution. I just want to make sure that we take
> into account all the known aspects.
> 
> I am sure that we could do better than we do now. I do not want
> to block any improvements. I am just a bit lost in the many
> black corners.

I hope the above helps. Also note that Linus' memory buffer is a
lockless console.
