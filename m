Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 727DBC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 20:01:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F64D20704
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 20:01:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbfKVUB0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 15:01:26 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:35627 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbfKVUBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 15:01:25 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iYF7K-0004uQ-D7; Fri, 22 Nov 2019 21:01:22 +0100
Date:   Fri, 22 Nov 2019 21:01:22 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     linux-tip-commits@vger.kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Qian Cai <cai@lca.pw>, Thomas Gleixner <tglx@linutronix.de>,
        akpm@linux-foundation.org, cl@linux.com, keescook@chromium.org,
        penberg@kernel.org, rientjes@google.com, thgarnie@google.com,
        tytso@mit.edu, will@kernel.org, Ingo Molnar <mingo@kernel.org>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [tip: sched/urgent] sched/core: Avoid spurious lock dependencies
Message-ID: <20191122200122.wx7ltij2w7w37cbe@linutronix.de>
References: <20191001091837.GK4536@hirez.programming.kicks-ass.net>
 <157363958888.29376.9190587096871610849.tip-bot2@tip-bot2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <157363958888.29376.9190587096871610849.tip-bot2@tip-bot2>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-11-13 10:06:28 [-0000], tip-bot2 for Peter Zijlstra wrote:
> sched/core: Avoid spurious lock dependencies
> 
> While seemingly harmless, __sched_fork() does hrtimer_init(), which,
> when DEBUG_OBJETS, can end up doing allocations.
> 
> This then results in the following lock order:
> 
>   rq->lock
>     zone->lock.rlock
>       batched_entropy_u64.lock
> 
> Which in turn causes deadlocks when we do wakeups while holding that
> batched_entropy lock -- as the random code does.

Peter, can it _really_ cause deadlocks? My understanding was that the
batched_entropy_u64.lock is a per-CPU lock and can _not_ cause a
deadlock because it can be always acquired on multiple CPUs
simultaneously (and it is never acquired cross-CPU).
Lockdep is simply not smart enough to see that and complains about it
like it would complain about a regular lock in this case.

Sebastian
