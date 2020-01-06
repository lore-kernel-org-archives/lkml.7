Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15256C33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 15:41:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E00C820731
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 15:41:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="c3/Johp/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbgAFPlb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 10:41:31 -0500
Received: from merlin.infradead.org ([205.233.59.134]:42570 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbgAFPla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 10:41:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Pr+QJhLWon8Zy2xzdYFdw8f98/n5SlmPPCm9dGfNuCU=; b=c3/Johp/zrnjTKuah4azV/J/z
        jHBViK0l3EwXzBzuZWUdyQQkJKnZL7zuKVNl6K08BVxu6TNGMkua4JmFf7Xu7dw/HiHRLh3zykrEq
        xkpI8oKCTPBdIwkcAxq8iPS0JA9BHMDYpSRn2oO7DknGdsHH8hwghXZodIVbrM9VFhIi7BmGi2A/Q
        FA2VwLuNSmgNAZR82xfiBIPmYBdmzxC7U7XVwR7gBr2LG4wZdFGwajQPbhcRS2NrirK6H8pXgWfZ/
        8qxXNhok1Kaxm9tHDZHUrvpgG/ITQKI9zgSBxOv8FsTPw0g0GPF5FDKYuXKrtGJb8nRcRH/pBwcvY
        5FW1a2Rpw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ioUVO-0003LZ-2q; Mon, 06 Jan 2020 15:41:22 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 513453006E0;
        Mon,  6 Jan 2020 16:39:47 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3A67D2B2844FB; Mon,  6 Jan 2020 16:41:19 +0100 (CET)
Date:   Mon, 6 Jan 2020 16:41:19 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Eric Biggers <ebiggers@kernel.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will@kernel.org>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-sparse@vger.kernel.org
Subject: Re: [PATCH] locking/refcount: add sparse annotations to dec-and-lock
 functions
Message-ID: <20200106154119.GV2810@hirez.programming.kicks-ass.net>
References: <20191226152922.2034-1-ebiggers@kernel.org>
 <20191228114918.GU2827@hirez.programming.kicks-ass.net>
 <201912301042.FB806E1133@keescook>
 <20191230191547.GA1501@zzz.localdomain>
 <201912301131.2C7C51E8C6@keescook>
 <20191230233814.2fgmsgtnhruhklnu@ltop.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191230233814.2fgmsgtnhruhklnu@ltop.local>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 31, 2019 at 12:38:14AM +0100, Luc Van Oostenryck wrote:
> On Mon, Dec 30, 2019 at 11:32:31AM -0800, Kees Cook wrote:
> > On Mon, Dec 30, 2019 at 01:15:47PM -0600, Eric Biggers wrote:
> > > 
> > > The annotation needs to go in the .h file, not the .c file, because sparse only
> > > analyzes individual translation units.
> > > 
> > > It needs to be a wrapper macro because it needs to tie the acquisition of the
> > > lock to the return value being true.  I.e. there's no annotation you can apply
> > > directly to the function prototype that means "if this function returns true, it
> > > acquires the lock that was passed in parameter N".
> > 
> > Gotcha. Well, I guess I leave it to Will and Peter to hash out...
> > 
> > Is there a meaningful proposal anywhere for sparse to DTRT here? If
> > not, it seems best to use what you've proposed until sparse reaches the
> > point of being able to do this on its own.
> 
> What "Right Thing" are you thinking about?
> One of the simplest situation with these conditional locks is:
> 
> 	if (test)
> 		lock();
> 
> 	do_stuff();
> 
> 	if (test)
> 		unlock();
> 
> No program can check that the second test gives the same result than
> the first one, it's undecidable. I mean, it's undecidable even on
> if single threaded and without interrupts. The best you can do is
> to simulate the whole thing (and be sure your simulation will halt).

Not quite what we're talking about. Instead consider this:

The normal flow would be something like:

extern void spin_lock(spinlock_t *lock) __acquires(lock);
extern void spin_unlock(spinlock_t *lock) __releases(lock);

extern bool _spin_trylock(spinlock_t *lock) __acquires(lock);

#define __cond_lock(x, c) ((c) ? ({ __acquire(x); 1; }) : 0)
#define spin_trylock(lock) __cond_lock(lock, _spin_lock)


	if (spin_trylock(lock)) {

		/* do crap */

		spin_unlock();
	}


So the proposal here:

  https://markmail.org/message/4obybcgqscznnx63

would have us write:

extern bool spin_trylock(spinlock_t *lock) __attribute__((context(lock, 0, spin_trylock(lock));

Basically have sparse do a transform on its own expression tree and
inject the very same crud we now do manually. This avoids cluttering the
kernel tree with this nonsense.
