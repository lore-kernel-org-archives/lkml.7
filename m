Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A51E6C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 20:21:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7597420706
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 20:21:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VjVfClqa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbfKVUVN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 15:21:13 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:44578 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726792AbfKVUVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 15:21:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=I7GabNt+5eo7tMhyga7wffGzqcP14sq3gRNQvRGj/vQ=; b=VjVfClqaLJlwztMw/cYTD1mT4
        0HRoE++9wHXahlu3bZis3PHXhtHY6/F0cJyK9yO0g7UHsSk/LfbVurnfrymwhQ18xUbTmO3Kko0mZ
        m4oa16hZ5dzUG2w6ZhSdMk7I4Fa3TJGVW9tPLySNNYDtbJ2H7nMqITOHxZu6lXVF6kFqt4aBd/BB/
        4hg55o/OE+LwYumM51gsQ2ge6ZP9krbPjn/Tz5eqzORWrPM7sdHf5uS+r/IpXT8dE/NadL37WhtKf
        qNJS3aEgmxrSdgaogBnin63fgJ60deWbSnWEW5UAs6jXDNd2xa1U68v5BA/GvYyVCGAEvVu6fA0cx
        VYGOy4F0g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iYFQM-0003bJ-U1; Fri, 22 Nov 2019 20:21:03 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 50DEB30068E;
        Fri, 22 Nov 2019 21:19:48 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B3DD220B2867F; Fri, 22 Nov 2019 21:20:59 +0100 (CET)
Date:   Fri, 22 Nov 2019 21:20:59 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Qian Cai <cai@lca.pw>, Thomas Gleixner <tglx@linutronix.de>,
        akpm@linux-foundation.org, cl@linux.com, keescook@chromium.org,
        penberg@kernel.org, rientjes@google.com, thgarnie@google.com,
        tytso@mit.edu, will@kernel.org, Ingo Molnar <mingo@kernel.org>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [tip: sched/urgent] sched/core: Avoid spurious lock dependencies
Message-ID: <20191122202059.GA2844@hirez.programming.kicks-ass.net>
References: <20191001091837.GK4536@hirez.programming.kicks-ass.net>
 <157363958888.29376.9190587096871610849.tip-bot2@tip-bot2>
 <20191122200122.wx7ltij2w7w37cbe@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191122200122.wx7ltij2w7w37cbe@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 22, 2019 at 09:01:22PM +0100, Sebastian Andrzej Siewior wrote:
> On 2019-11-13 10:06:28 [-0000], tip-bot2 for Peter Zijlstra wrote:
> > sched/core: Avoid spurious lock dependencies
> > 
> > While seemingly harmless, __sched_fork() does hrtimer_init(), which,
> > when DEBUG_OBJETS, can end up doing allocations.
> > 
> > This then results in the following lock order:
> > 
> >   rq->lock
> >     zone->lock.rlock
> >       batched_entropy_u64.lock
> > 
> > Which in turn causes deadlocks when we do wakeups while holding that
> > batched_entropy lock -- as the random code does.
> 
> Peter, can it _really_ cause deadlocks? My understanding was that the
> batched_entropy_u64.lock is a per-CPU lock and can _not_ cause a
> deadlock because it can be always acquired on multiple CPUs
> simultaneously (and it is never acquired cross-CPU).
> Lockdep is simply not smart enough to see that and complains about it
> like it would complain about a regular lock in this case.

That part yes. That is, even holding a per-cpu lock you can do a wakeup
to the local cpu and recurse back onto rq->lock.

However I don't think it can actually happen bceause this
is init_idle, and we only ever do that on hotplug, so actually creating
the concurrency required for the deadlock might be tricky.

Still, moving that thing out from under the lock was simple and correct.
