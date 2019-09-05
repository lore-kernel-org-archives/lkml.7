Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D16BC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 14:31:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 742B7207E0
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 14:31:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RYrRG0cT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728923AbfIEObh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 10:31:37 -0400
Received: from merlin.infradead.org ([205.233.59.134]:45870 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727009AbfIEObg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 10:31:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=AhwZHS8zUJZ6Gu2eJctKeuPpXhbUkrdHOEk+XcNJ2GI=; b=RYrRG0cTtClPqZbRLIB+Sv54M
        gLP9vtJFQwJkKKVP7e34AeSEts9LAQiePASBpjRb3rLxsdDCxZPfUoaO3JnrgeHvNkAYWVLgafYR5
        xUYb4S3egpT7ewRUvRHLllUcQa2Yo6wx+18288xX/6eo3ExgNLYJLAeBsQ04UPlybetE6IHtezPzv
        gEP3T1eASHh9EIpE/xbpRMoxzaRZt2FstcLjxwR+D8DoI35lGdTR64CcVGX2N5QwtQppyNnARMJWl
        SBca4nSoabdd+1YW6b2Ug9aQUZJWUZH1GWkKvXta7rph19AEvVGau2HfAlJyCmzIJTkIYzd7Xaq+Z
        WMBXoUq4A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i5snB-00006n-1q; Thu, 05 Sep 2019 14:31:21 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A60B5303121;
        Thu,  5 Sep 2019 16:30:41 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9880729D35369; Thu,  5 Sep 2019 16:31:18 +0200 (CEST)
Date:   Thu, 5 Sep 2019 16:31:18 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v4 0/9] printk: new ringbuffer implementation
Message-ID: <20190905143118.GP2349@hirez.programming.kicks-ass.net>
References: <20190807222634.1723-1-john.ogness@linutronix.de>
 <20190904123531.GA2369@hirez.programming.kicks-ass.net>
 <20190905130513.4fru6yvjx73pjx7p@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190905130513.4fru6yvjx73pjx7p@pathway.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 05, 2019 at 03:05:13PM +0200, Petr Mladek wrote:

> The serialized approach used a lock. It was re-entrant and thus less
> error-prone but still a lock.
> 
> The lock was planed to be used not only to access the buffer but also
> for eventual locking inside lockless consoles. It might allow to
> have some synchronization even in lockless consoles. But it
> would be big-kernel-lock-like style. It might create yet
> another maze of problems.

I really don't see your point. All it does is limit buffer writers to a
single CPU, and does the same for the atomic/early console output.

But it must very much be a leaf lock -- that is, there must not be any
locking inside it -- and that is fine, if a console cannot do lockless
output, it simply cannot be marked as having an atomic/early console.

You've seen the force_earlyprintk patches I use [*], that stuff works
and is infinitely better than the current printk trainwreck -- and it
uses exactly such serialization -- although I only added it to make the
output actually readable. And _that_ is exactly why I propose adding it,
you need it _anyway_.

So the argument goes like:

 - synchronous output to lockless consoles (early serial) is mandatory
 - such output needs to be CPU serialized, otherwise it becomes
   unreadable garbage.
 - since we need that serialization anyway, might as well lift it up one
   layer an put it around the buffer.

Since a single-cpu buffer writer can be wait free (and relatively
simple), the only possible waiting is on the lockless console (polling
until the UART is ready for it's next byte). There is nothing else. It
will make progress.

> If we remove per-CPU buffers in NMI. We would need to synchronize
> again printing backtraces from all CPUs. Otherwise they would get
> mixed and hard to read. It might be solved by some prefix and
> sorting in userspace but...

It must have cpu prefixes anyway; the multi-writer thing will equally
mix them together. This is a complete non sequitur.

That current printk stuff is just pure and utter crap. Those NMI buffers
are a trainwreck and need to die a horrible death.

> I agree that this lockless variant is really complicated. I am not
> able to prove that it is race free as it is now. I understand
> the algorithm. But there are too many synchronization points.
> 
> Peter, have you seen my alternative approach, please. See
> https://lore.kernel.org/lkml/20190704103321.10022-1-pmladek@suse.com/
> 
> It uses two tricks:
> 
>    1. Two bits in the sequence number are used to track the state
>       of the related data. It allows to implement the entire
>       life cycle of each entry using atomic operation on a single
>       variable.
> 
>    2. There is a helper function to read valid data for each entry,
>       see prb_read_desc(). It checks the state before and after
>       reading the data to make sure that they are valid. And
>       it includes the needed read barriers. As a result there
>       are only three explicit barriers in the code. All other
>       are implicitly done by cmpxchg() atomic operations.
> 
> The alternative lockless approach is still more complicated than
> the serialized one. But I think that it is manageable thanks to
> the simplified state tracking. And I might safe use some pain
> in the long term.

I've not looked at it yet, sorry. But per the above argument of needing
the CPU serialization _anyway_, I don't see a compelling reason not to
use it.

It is simple, it works. Let's use it.

If you really fancy a multi-writer buffer, you can always switch to one
later, if you can convince someone it actually brings benefits and not
just head-aches.

So I have something roughly like the below; I'm suggesting you add the
line with + on:

  int early_vprintk(const char *fmt, va_list args)
  {
	char buf[256]; // teh suck!
	int old, n = vscnprintf(buf, sizeof(buf), fmt, args);

	old = cpu_lock();
+	printk_buffer_store(buf, n);
	early_console->write(early_console, buf, n);
	cpu_unlock(old);

	return n;
  }

(yes, yes, we can get rid of the on-stack @buf thing with a
reserve+commit API, but who cares :-))



[*] git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git debug/experimental
