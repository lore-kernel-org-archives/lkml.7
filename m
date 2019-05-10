Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A6BCC04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 13:06:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9F3B21479
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 13:06:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PiOY8fFm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727568AbfEJNGo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 09:06:44 -0400
Received: from merlin.infradead.org ([205.233.59.134]:38476 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727174AbfEJNGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 09:06:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=m519XLqZSDnfkbpGbsv710zXFaUAfBMr21hl4yE19g0=; b=PiOY8fFm6G7g9DKI904lrKsYA
        K1kImV854iDFxCqS1cwiwkjOKkF/sa9TuNQfg51Qpdt8FZ9bBnyCeWRISBuCl1V+pUxKhuyUKXUyl
        YPYgLOjeJCjX1SlAWb1BArxXofce3cVtV1RiftBO6VCtqZc6SyG81BLo6P9Z7LT7yz77xq7ezbwbc
        mD+xST6qfOJYh2RkYECwTeHhHERMVZinTXkfxW8Fg+m9piOlSEsYLoXSQx26+aomYKuAhlkCn7eSl
        dsA5I/EK2Cq7VNUN6pCiphZA5ZxffF+lbuEARiqN7DFpyMTSMApCGAAI2Gk3MKe3/rFa+TtTYEKpF
        4yhP1S2yA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hP5EH-0005rl-8v; Fri, 10 May 2019 13:06:25 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 139362029F877; Fri, 10 May 2019 15:06:24 +0200 (CEST)
Date:   Fri, 10 May 2019 15:06:24 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Aaron Lu <aaron.lu@linux.alibaba.com>
Cc:     Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Tim Chen <tim.c.chen@linux.intel.com>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, subhra.mazumdar@oracle.com,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>, Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH v2 11/17] sched: Basic tracking of matching tasks
Message-ID: <20190510130624.GW2589@hirez.programming.kicks-ass.net>
References: <cover.1556025155.git.vpillai@digitalocean.com>
 <2364f2b65bf50826d881c84d7634b6565dfee527.1556025155.git.vpillai@digitalocean.com>
 <20190429033620.GA128241@aaronlu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190429033620.GA128241@aaronlu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 29, 2019 at 11:36:22AM +0800, Aaron Lu wrote:
> On Tue, Apr 23, 2019 at 04:18:16PM +0000, Vineeth Remanan Pillai wrote:
> > +/*
> > + * l(a,b)
> > + * le(a,b) := !l(b,a)
> > + * g(a,b)  := l(b,a)
> > + * ge(a,b) := !l(a,b)
> > + */
> > +
> > +/* real prio, less is less */
> > +static inline bool __prio_less(struct task_struct *a, struct task_struct *b, bool core_cmp)
> > +{
> > +	u64 vruntime;
> > +
> > +	int pa = __task_prio(a), pb = __task_prio(b);
> > +
> > +	if (-pa < -pb)
> > +		return true;
> > +
> > +	if (-pb < -pa)
> > +		return false;
> > +
> > +	if (pa == -1) /* dl_prio() doesn't work because of stop_class above */
> > +		return !dl_time_before(a->dl.deadline, b->dl.deadline);
> > +
> > +	vruntime = b->se.vruntime;
> > +	if (core_cmp) {
> > +		vruntime -= task_cfs_rq(b)->min_vruntime;
> > +		vruntime += task_cfs_rq(a)->min_vruntime;
> > +	}
> > +	if (pa == MAX_RT_PRIO + MAX_NICE) /* fair */
> > +		return !((s64)(a->se.vruntime - vruntime) <= 0);
> > +
> > +	return false;
> > +}
> 
> This unfortunately still doesn't work.
> 
> Consider the following task layout on two sibling CPUs(cpu0 and cpu1):
> 
>     rq0.cfs_rq    rq1.cfs_rq
>         |             |
>      se_bash        se_hog
> 
> se_hog is the sched_entity for a cpu intensive task and se_bash is the
> sched_entity for bash.
> 
> There are two problems:
> 1 SCHED_DEBIT
> when user execute some commands through bash, say ls, bash will fork.
> The newly forked ls' vruntime is set in the future due to SCHED_DEBIT.
> This made 'ls' lose in __prio_less() when compared with hog, whose
> vruntime may very likely be the same as its cfs_rq's min_vruntime.
> 
> This is OK since we do not want forked process to starve already running
> ones. The problem is, since hog keeps running, its vruntime will always
> sync with its cfs_rq's min_vruntime. OTOH, 'ls' can not run, its
> cfs_rq's min_vruntime doesn't proceed, making 'ls' always lose to hog.
> 
> 2 who schedules, who wins
> so I disabled SCHED_DEBIT, for testing's purpose. When cpu0 schedules,
> ls could win where both sched_entity's vruntime is the same as their
> cfs_rqs' min_vruntime. So does hog: when cpu1 schedules, hog can preempt
> ls in the same way. The end result is, interactive task can lose to cpu
> intensive task and ls can feel "dead".
> 
> I haven't figured out a way to solve this yet. A core wide cfs_rq's
> min_vruntime can probably solve this. Your suggestions are appreciated.

multi-queue virtual time is 'interesting'. I worked it out once and then
my head hurt, I've forgotten the details again. Esp. when combined with
affinity masks the simple things don't work right. For every
non-feasible weight scenario it comes apart.

I know pjt has an approximation somewhere that might work for us; but I
forgot those details again too.

On possible hack would be to allow min_vruntime to go backwards when
there is only a single task present; basically have min_vruntime =
p->vruntime when you enqueue the first task.
