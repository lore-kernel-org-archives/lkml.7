Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BD56C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 14:22:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDA01205ED
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 14:22:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Rq4NLRtM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394414AbfIFOWv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 10:22:51 -0400
Received: from merlin.infradead.org ([205.233.59.134]:54640 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732187AbfIFOWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 10:22:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=D/HG6FAe0exGWGzTJ22srAQwFpD3yW3x+QAvgFaCLfw=; b=Rq4NLRtMcwj+UYfuPe5nd9ZmX
        ZyMk7Cccv0vCpL0WovQeyVS+MzLJdTvbT0/0asMg3eOCux2Xk3Sq0zv3QQJrN/9p0KfwcnPDYFXJV
        OyVRtZioxR4wZc3IwbZOWUbmuS4zXL1DE4sm0C8wAl5hlnN5+34Hu5uHN1s2pqQK6lO+x7OH70qjG
        dbT4GPmiLIW3R1BqB0HblAHj2gKBJV5DddElzHvBYEZOCxqu6V2F3HKmRH/xXdzFcQiXWzeASwdJP
        IRUYuL060utfwDxgiamIZe/BzuhbiHiVJyYXSngAeEKo5d2GiwMpBWjguUqXDaIPp5Bv8p9y3/+NB
        MLbl1NQLw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i6F8G-0001JX-Uk; Fri, 06 Sep 2019 14:22:37 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A9197306023;
        Fri,  6 Sep 2019 16:21:57 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1B14E29E28408; Fri,  6 Sep 2019 16:22:35 +0200 (CEST)
Date:   Fri, 6 Sep 2019 16:22:35 +0200
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
Message-ID: <20190906142235.GY2386@hirez.programming.kicks-ass.net>
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

Oooh, I think I see. So one solution would be to pass the NMI along in
chain like.  Send it to a single CPU at a time, when finished, send it
to the next.
