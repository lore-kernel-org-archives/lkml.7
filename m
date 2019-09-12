Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 096F3C4CEC5
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 13:48:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C813D20CC7
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 13:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568296091;
	bh=7oylp5CxOhNpYn3U2ca6Im+P2+1WJynqgSDAjEI39AM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=giOCbZ0LBnhMBB5klglObpsxHaBHqVfhZtt1vWhlnG4XKBj3O4ZaruSAD04xTG33h
	 YQGqGJt4yZph3+wGk4STdRilG6UaJ9IFQZVe88eRVZFlXZiT2WTYKcUHJwEItKrIqY
	 3gh+4fsMAEBS9NbjU7A+AJe34OywWWVGuOagwId4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732316AbfILNsK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 09:48:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:34160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732258AbfILNsJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 09:48:09 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D101620856;
        Thu, 12 Sep 2019 13:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568296088;
        bh=7oylp5CxOhNpYn3U2ca6Im+P2+1WJynqgSDAjEI39AM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QHIHYTTUG0NmDONZPRScPVrmpwDctw+3rsAT8BN0mvlQSXhWRIY4Ulel4ozHUDQqA
         jY6h1RaMoBzke1010tIkiHGJwgoDvUL2y8xLVAFT9Lw3TsvGyHcO8h+ehjkFBBtiLc
         RtVuu3abN+g6I3Z1AiIgRTaKPGaJHm/bfeIDuFGM=
Date:   Thu, 12 Sep 2019 14:48:02 +0100
From:   Will Deacon <will@kernel.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        paulmck <paulmck@linux.ibm.com>, Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Russell King, ARM Linux" <linux@armlinux.org.uk>,
        Chris Metcalf <cmetcalf@ezchip.com>,
        Chris Lameter <cl@linux.com>, Kirill Tkhai <tkhai@yandex.ru>,
        Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC PATCH 4/4] Fix: sched/membarrier: p->mm->membarrier_state
 racy load (v2)
Message-ID: <20190912134802.mhxyy25xemy5sycm@willie-the-truck>
References: <20190906082305.GU2349@hirez.programming.kicks-ass.net>
 <20190908134909.12389-1-mathieu.desnoyers@efficios.com>
 <CAHk-=wg3AANn8K3OyT7KRNvVC5s0rvWVxXJ=_R+TAd3CGdcF+A@mail.gmail.com>
 <137355288.1941.1568108882233.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <137355288.1941.1568108882233.JavaMail.zimbra@efficios.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 10, 2019 at 05:48:02AM -0400, Mathieu Desnoyers wrote:
> ----- On Sep 8, 2019, at 5:51 PM, Linus Torvalds torvalds@linux-foundation.org wrote:
> 
> > On Sun, Sep 8, 2019 at 6:49 AM Mathieu Desnoyers
> > <mathieu.desnoyers@efficios.com> wrote:
> >>
> >> +static void sync_runqueues_membarrier_state(struct mm_struct *mm)
> >> +{
> >> +       int membarrier_state = atomic_read(&mm->membarrier_state);
> >> +       bool fallback = false;
> >> +       cpumask_var_t tmpmask;
> >> +
> >> +       if (!zalloc_cpumask_var(&tmpmask, GFP_NOWAIT)) {
> >> +               /* Fallback for OOM. */
> >> +               fallback = true;
> >> +       }
> >> +
> >> +       /*
> >> +        * For each cpu runqueue, if the task's mm match @mm, ensure that all
> >> +        * @mm's membarrier state set bits are also set in in the runqueue's
> >> +        * membarrier state. This ensures that a runqueue scheduling
> >> +        * between threads which are users of @mm has its membarrier state
> >> +        * updated.
> >> +        */
> >> +       cpus_read_lock();
> >> +       rcu_read_lock();
> >> +       for_each_online_cpu(cpu) {
> >> +               struct rq *rq = cpu_rq(cpu);
> >> +               struct task_struct *p;
> >> +
> >> +               p = task_rcu_dereference(&rq->curr);
> >> +               if (p && p->mm == mm) {
> >> +                       if (!fallback)
> >> +                               __cpumask_set_cpu(cpu, tmpmask);
> >> +                       else
> >> +                               smp_call_function_single(cpu, ipi_sync_rq_state,
> >> +                                                        mm, 1);
> >> +               }
> >> +       }
> > 
> > I really absolutely detest this whole "fallback" code.
> > 
> > It will never get any real testing, and the code is just broken.
> > 
> > Why don't you just use the mm_cpumask(mm) unconditionally? Yes, it
> > will possibly call too many CPU's, but this fallback code is just
> > completely disgusting.
> > 
> > Do a simple and clean implementation. Then, if you can show real
> > performance issues (which I doubt), maybe do something else, but even
> > then you should never do something that will effectively create cases
> > that have absolutely zero test-coverage.
> 
> A few points worth mentioning here:
> 
> 1) As I stated earlier, using mm_cpumask in its current form is not
>    an option for membarrier. For two reasons:
> 
>    A) The mask is not populated on all architectures (e.g. arm64 does
>       not populate it),
> 
>    B) Even if it was populated on all architectures, we would need to
>       carefully audit and document every spot where this mm_cpumask
>       is set or cleared within each architecture code, and ensure we
>       have the required memory barriers between user-space memory
>       accesses and those stores, documenting those requirements into
>       each architecture code in the process. This seems to be a lot of
>       useless error-prone code churn.
> 
> 2) I should actually use GFP_KERNEL rather than GFP_NOWAIT in this
>    membarrier registration code. But it can still fail. However, the other
>    membarrier code using the same fallback pattern (private and global
>    expedited) documents that those membarrier commands do not block in
>    the membarrier(2) man page, so GFP_NOWAIT is appropriate in those cases.
> 
> 3) Testing-wise, I fully agree with your argument of lacking test coverage.
>    One option I'm considering would be to add a selftest based on the
>    fault-injection infrastructure, which would ensure that we have coverage
>    of the failure case in the kernel selftests.
> 
> Thoughts ?

So the man page for sys_membarrier states that the expedited variants "never
block", which feels pretty strong. Do any other system calls claim to
provide this guarantee without a failure path if blocking is necessary?
Given that the whole thing is preemptible, I'm also curious as to how
exactly userspace relies on this non-blocking guarantee.  I'd have thought
that you could either just bite the bullet and block in the rare case that
you need to when allocating the cpumask, or you could just return
-EWOULDBLOCK on allocation failure, given that I suspect there are very few
users of this system call right now and it's not yet supported by glibc
afaik.

Will
