Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B776FC4360D
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 22:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BBD621479
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 22:18:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wtdqX5u3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731041AbfIHWS1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 18:18:27 -0400
Received: from merlin.infradead.org ([205.233.59.134]:39156 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbfIHWS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 18:18:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=P/awgzoK2k4GVGdBJaMhAEeA4IXyM1r5QKgABXCX0SM=; b=wtdqX5u3qOX9tdMucC4okD7MN
        qkLx1Cbmaa7AI8SZyp8M9+fPE6A2uXaxSFGu/i1YT2u6qvcARZmnAAT8WIPe7JUDCFsAZskuUHGbZ
        tLh2mtGVXB6eF+WpZlYd79fVZ8fb2AUT2spUFvU24SfnHI7h/seNYxLZ3+cGnXQoqjkuwjNWCKIlV
        dh8Ou+g4j8EcN2OnYcQ6DzWA5mjMGWeUbWA66yOKRKsBwkyivzFKow7y8BOno3jd9d43Ckm7bnX3G
        g4oTNo5AIMLshxD8fgMBXOtqlU0jMZ/L629x92KXRbgg9Wm16VRqaF7KqIsH9IioB6u1K8XPzl9Zl
        IQ0n8JLTA==;
Received: from [148.69.85.38] (helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i75VZ-0007hE-NM; Sun, 08 Sep 2019 22:18:10 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 48AA3980C91; Mon,  9 Sep 2019 00:18:09 +0200 (CEST)
Date:   Mon, 9 Sep 2019 00:18:09 +0200
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
Message-ID: <20190908221809.GA3637@worktop.programming.kicks-ass.net>
References: <20190807222634.1723-1-john.ogness@linutronix.de>
 <20190904123531.GA2369@hirez.programming.kicks-ass.net>
 <20190905130513.4fru6yvjx73pjx7p@pathway.suse.cz>
 <20190905143118.GP2349@hirez.programming.kicks-ass.net>
 <20190906090627.GX2386@hirez.programming.kicks-ass.net>
 <20190906124211.2dionk2kzcslaotz@pathway.suse.cz>
 <20190906140126.GY2349@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190906140126.GY2349@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 06, 2019 at 04:01:26PM +0200, Peter Zijlstra wrote:
> On Fri, Sep 06, 2019 at 02:42:11PM +0200, Petr Mladek wrote:

> > 7. People would complain when continuous lines become less
> >    reliable. It might be most visible when mixing backtraces
> >    from all CPUs. Simple sorting by prefix will not make
> >    it readable. The historic way was to synchronize CPUs
> >    by a spin lock. But then the cpu_lock() could cause
> >    deadlock.
> 
> Why? I'm running with that thing on, I've never seen a deadlock ever
> because of it. In fact, i've gotten output that is plain impossible with
> the current junk.
> 
> The cpu-lock is inside the all-backtrace spinlock, not outside. And as I
> said yesterday, only the lockless console has any wait-loops while
> holding the cpu-lock. It _will_ make progress.

So I've been a huge flaming idiot.. so while I'm not particularly
sympathetic to NMIs that block, there are a number of really trivial
deadlocks possible -- and it is a minor miracle I've not actually hit
them (I suppose because printk() isn't really all that common).

The whole cpu-lock thing I had needs to go. But not having it makes
lockless console output unreadable and unsable garbage.

I've got some ideas on a replacement, but I need to further consider it.

:-/
