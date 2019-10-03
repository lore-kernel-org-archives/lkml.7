Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C99DC32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:12:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35BDC21783
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:12:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388116AbfJCQMr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:12:47 -0400
Received: from foss.arm.com ([217.140.110.172]:48278 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388084AbfJCQMj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:12:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0D4C8337;
        Thu,  3 Oct 2019 09:12:39 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A91493F739;
        Thu,  3 Oct 2019 09:12:36 -0700 (PDT)
Date:   Thu, 3 Oct 2019 17:12:34 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Marco Elver <elver@google.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Alexander Potapenko <glider@google.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Paul Turner <pjt@google.com>, Daniel Axtens <dja@axtens.net>,
        Anatol Pomazau <anatol@google.com>,
        Will Deacon <willdeacon@google.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>
Subject: Re: Kernel Concurrency Sanitizer (KCSAN)
Message-ID: <20191003161233.GB38140@lakrids.cambridge.arm.com>
References: <CANpmjNPJ_bHjfLZCAPV23AXFfiPiyXXqqu72n6TgWzb2Gnu1eA@mail.gmail.com>
 <20190920163123.GC55224@lakrids.cambridge.arm.com>
 <CACT4Y+ZwyBhR8pB7jON8eVObCGbJ54L8Sbz6Wfmy3foHkPb_fA@mail.gmail.com>
 <CANpmjNM+aEzySwuMDkEvsVaeTooxExuTRAv-nzjhp7npT8a3ag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNM+aEzySwuMDkEvsVaeTooxExuTRAv-nzjhp7npT8a3ag@mail.gmail.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 20, 2019 at 07:51:04PM +0200, Marco Elver wrote:
> On Fri, 20 Sep 2019 at 18:47, Dmitry Vyukov <dvyukov@google.com> wrote:
> >
> > On Fri, Sep 20, 2019 at 6:31 PM Mark Rutland <mark.rutland@arm.com> wrote:
> > >
> > > On Fri, Sep 20, 2019 at 04:18:57PM +0200, Marco Elver wrote:
> > > > We would like to share a new data-race detector for the Linux kernel:
> > > > Kernel Concurrency Sanitizer (KCSAN) --
> > > > https://github.com/google/ktsan/wiki/KCSAN  (Details:
> > > > https://github.com/google/ktsan/blob/kcsan/Documentation/dev-tools/kcsan.rst)
> > >
> > > Nice!
> > >
> > > BTW kcsan_atomic_next() is missing a stub definition in <linux/kcsan.h>
> > > when !CONFIG_KCSAN:
> > >
> > > https://github.com/google/ktsan/commit/a22a093a0f0d0b582c82cdbac4f133a3f61d207c#diff-19d7c475b4b92aab8ba440415ab786ec
> > >
> > > ... and I think the kcsan_{begin,end}_atomic() stubs need to be static
> > > inline too.
> 
> Thanks for catching, fixed and pushed. Feel free to rebase your arm64 branch.

Great; I've just done so!

What's the plan for posting a PATCH or RFC series?

The rest of this email is rabbit-holing on the issue KCSAN spotted;
sorry about that!

[...]

> > > We have some interesting splats at boot time in stop_machine, which
> > > don't seem to have been hit/fixed on x86 yet in the kcsan-with-fixes
> > > branch, e.g.
> > >
> > > [    0.237939] ==================================================================
> > > [    0.239431] BUG: KCSAN: data-race in multi_cpu_stop+0xa8/0x198 and set_state+0x80/0xb0
> > > [    0.241189]
> > > [    0.241606] write to 0xffff00001003bd00 of 4 bytes by task 24 on cpu 3:
> > > [    0.243435]  set_state+0x80/0xb0
> > > [    0.244328]  multi_cpu_stop+0x16c/0x198
> > > [    0.245406]  cpu_stopper_thread+0x170/0x298
> > > [    0.246565]  smpboot_thread_fn+0x40c/0x560
> > > [    0.247696]  kthread+0x1a8/0x1b0
> > > [    0.248586]  ret_from_fork+0x10/0x18
> > > [    0.249589]
> > > [    0.250006] read to 0xffff00001003bd00 of 4 bytes by task 14 on cpu 1:
> > > [    0.251804]  multi_cpu_stop+0xa8/0x198
> > > [    0.252851]  cpu_stopper_thread+0x170/0x298
> > > [    0.254008]  smpboot_thread_fn+0x40c/0x560
> > > [    0.255135]  kthread+0x1a8/0x1b0
> > > [    0.256027]  ret_from_fork+0x10/0x18
> > > [    0.257036]
> > > [    0.257449] Reported by Kernel Concurrency Sanitizer on:
> > > [    0.258918] CPU: 1 PID: 14 Comm: migration/1 Not tainted 5.3.0-00007-g67ab35a199f4-dirty #3
> > > [    0.261241] Hardware name: linux,dummy-virt (DT)
> > > [    0.262517] ==================================================================>
> 
> Thanks, the fixes in -with-fixes were ones I only encountered with
> Syzkaller, where I disable KCSAN during boot. I've just added a fix
> for this race and pushed to kcsan-with-fixes.

I think that's:

  https://github.com/google/ktsan/commit/c1bc8ab013a66919d8347c2392f320feabb14f92

... but that doesn't look quite right to me, as it leaves us with the shape:

	do {
		if (READ_ONCE(msdata->state) != curstate) {
			curstate = msdata->state;
			switch (curstate) {
				...
			}
			ack_state(msdata);
		}
	} while (curstate != MULTI_STOP_EXIT);

I don't believe that we have a guarantee of read-after-read ordering
between the READ_ONCE(msdata->state) and the subsequent plain access of
msdata->state, as we've been caught out on that in the past, e.g.

  https://lore.kernel.org/lkml/1506527369-19535-1-git-send-email-will.deacon@arm.com/

... which I think means we could switch on a stale value of
msdata->state. That would mean we might handle the same state twice,
calling ack_state() more times than expected and corrupting the count.

The compiler could also replace uses of curstate with a reload of
msdata->state. If it did so for the while condition, we could skip the
expected ack_state() for MULTI_STOP_EXIT, though it looks like that
might not matter.

I think we need to make sure that we use a consistent snapshot,
something like the below. Assuming I'm not barking up the wrong tree, I
can spin this as a proper patch.

Thanks,
Mark.

---->8----
diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
index b4f83f7bdf86..67a0b454b5b5 100644
--- a/kernel/stop_machine.c
+++ b/kernel/stop_machine.c
@@ -167,7 +167,7 @@ static void set_state(struct multi_stop_data *msdata,
        /* Reset ack counter. */
        atomic_set(&msdata->thread_ack, msdata->num_threads);
        smp_wmb();
-       msdata->state = newstate;
+       WRITE_ONCE(msdata->state, newstate);
 }
 
 /* Last one to ack a state moves to the next state. */
@@ -186,7 +186,7 @@ void __weak stop_machine_yield(const struct cpumask *cpumask)
 static int multi_cpu_stop(void *data)
 {
        struct multi_stop_data *msdata = data;
-       enum multi_stop_state curstate = MULTI_STOP_NONE;
+       enum multi_stop_state newstate, curstate = MULTI_STOP_NONE;
        int cpu = smp_processor_id(), err = 0;
        const struct cpumask *cpumask;
        unsigned long flags;
@@ -210,8 +210,9 @@ static int multi_cpu_stop(void *data)
        do {
                /* Chill out and ensure we re-read multi_stop_state. */
                stop_machine_yield(cpumask);
-               if (msdata->state != curstate) {
-                       curstate = msdata->state;
+               newstate = READ_ONCE(msdata->state);
+               if (newstate != curstate) {
+                       curstate = newstate;
                        switch (curstate) {
                        case MULTI_STOP_DISABLE_IRQ:
                                local_irq_disable();

