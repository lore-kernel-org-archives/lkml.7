Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74E32C7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 09:38:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 510F5216C8
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 09:38:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730054AbfGWJiF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 05:38:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59284 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728284AbfGWJiE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 05:38:04 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 53D6181F0D;
        Tue, 23 Jul 2019 09:38:04 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9AF065F7C0;
        Tue, 23 Jul 2019 09:38:01 +0000 (UTC)
Date:   Tue, 23 Jul 2019 11:37:42 +0200
From:   Stanislaw Gruszka <sgruszka@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Fox <afox@redhat.com>,
        Stephen Johnston <sjohnsto@redhat.com>,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] sched/cputime: make scale_stime() more precise
Message-ID: <20190723093741.GB2955@redhat.com>
References: <20190718131834.GA22211@redhat.com>
 <20190719110349.GG3419@hirez.programming.kicks-ass.net>
 <20190722105240.GA27219@redhat.com>
 <20190722200034.GJ6698@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190722200034.GJ6698@worktop.programming.kicks-ass.net>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Tue, 23 Jul 2019 09:38:04 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 10:00:34PM +0200, Peter Zijlstra wrote:
> On Mon, Jul 22, 2019 at 12:52:41PM +0200, Stanislaw Gruszka wrote:
> > On Fri, Jul 19, 2019 at 01:03:49PM +0200, Peter Zijlstra wrote:
> > > > shows the problem even when sum_exec_runtime is not that big: 300000 secs.
> > > > 
> > > > The new implementation of scale_stime() does the additional div64_u64_rem()
> > > > in a loop but see the comment, as long it is used by cputime_adjust() this
> > > > can happen only once.
> > > 
> > > That only shows something after long long staring :/ There's no words on
> > > what the output actually means or what would've been expected.
> > > 
> > > Also, your example is incomplete; the below is a test for scale_stime();
> > > from this we can see that the division results in too large a number,
> > > but, important for our use-case in cputime_adjust(), it is a step
> > > function (due to loss in precision) and for every plateau we shift
> > > runtime into the wrong bucket.
> > > 
> > > Your proposed function works; but is atrocious, esp. on 32bit. That
> > > said, before we 'fixed' it, it had similar horrible divisions in, see
> > > commit 55eaa7c1f511 ("sched: Avoid cputime scaling overflow").
> > > 
> > > Included below is also an x86_64 implementation in 2 instructions.
> > > 
> > > I'm still trying see if there's anything saner we can do...
> > 
> > I was always proponent of removing scaling and export raw values
> > and sum_exec_runtime. But that has obvious drawback, reintroduce
> > 'top hiding' issue.
> 
> I think (but didn't grep) that we actually export sum_exec_runtime in
> /proc/ *somewhere*.

Yes, it is, in /proc/[PID]/schedstat for CONFIG_SCHEDSTAT=y and in
/proc/[PID]/sched for CONFIG_SCHED_DEBUG=y

> > But maybe we can export raw values in separate file i.e.
> > /proc/[pid]/raw_cpu_times ? So applications that require more precise
> > cputime values for very long-living processes can use this file.
> 
> There are no raw cpu_times, there are system and user samples, and
> samples are, by their very nature, an approximation. We just happen to
> track the samples in TICK_NSEC resolution these days, but they're still
> ticks (except on s390 and maybe other archs, which do time accounting in
> the syscall path).
> 
> But I think you'll find x86 people are quite opposed to doing TSC reads
> in syscall entry and exit :-)

By 'raw' I meant values that are stored in task_struct without
processing by cputime_adjust() -> scale_stime(). Idea is that
user space can make scaling using floating point, so do not have
to drop precision if numbers are big. 

That was discussed on my RFC and PATCH series posts:
https://lore.kernel.org/lkml/1364489605-5443-1-git-send-email-sgruszka@redhat.com/
https://lore.kernel.org/lkml/1365066635-2959-1-git-send-email-sgruszka@redhat.com/

There was objection that even if kernel does not tell what utime/stime
values mean exactly, users already got used to scaled behaviour and
changing this is 'semantic' ABI breakage. And obviously this would make
'top hiding' worm working again for unpatched top.

So perhaps we can add new exports of not-scaled utime/stime and achieve
the same goal without changing the meaning of existing fields. From
other hand, maybe nowadays better tools exist to provide exact cputimes
to user space i.e. 'perf stat' or bpf, so proposed addition is unneeded.

Stanislaw
