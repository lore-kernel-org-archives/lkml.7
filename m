Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E437AFC6196
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 23:08:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFBDB222CD
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 23:08:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732933AbfKFXIo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 18:08:44 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45503 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727656AbfKFXIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 18:08:07 -0500
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iSUP8-0004ik-9K; Thu, 07 Nov 2019 00:07:59 +0100
Message-Id: <20191106215534.241796846@linutronix.de>
User-Agent: quilt/0.65
Date:   Wed, 06 Nov 2019 22:55:34 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Darren Hart <darren@dvhart.com>,
        Yi Wang <wang.yi59@zte.com.cn>,
        Yang Tao <yang.tao172@zte.com.cn>,
        Oleg Nesterov <oleg@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        Carlos O'Donell <carlos@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: [patch 00/12] futex: Cure robust/PI futex exit races
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series addresses a couple of robust/PI futex exit races:

 1) The unlock races debugged and fixed by Yi and Yang

    These races are really subtle and I'm still puzzled how to trigger them
    reliably enough to decode them.

    The basic issue is that:

    A) An unlocking task can be killed between clearing the user space
       futex value and calling futex(FUTEX_WAKE).

    B) A woken up waiter can be killed before it can acquire the futex
       after returning to user space.

    In both cases the futex value is 0 and due to that the robust list exit
    code refuses to wake up waiters as the futex is not owned by the
    exiting task. As a consequence all other waiters might be blocked
    forever.

 2) Oleg provided a test case which causes an infinite loop in the
    futex_lock_pi() code.

    The problem there is that an exiting task might be preempted by a
    waiter in a state which makes the waiter busy wait for the exiting task
    to complete the robust/PI exit cleanup code.

    That's obviously impossible when the waiter has higher priority than
    the exiting task and both are pinned on the same CPU resulting in a
    live lock.

#1 is a straight forward and simple fix 

    The solution Yi and Yang provided looks solid and in the worst case
    causes a spurious wakeup of a waiter which is nothing to worry about
    as all waiter code has to be prepared for that anyway.

#2 is more complex

   In the current implementation there is no way to block until the exiting
   task has finished the cleanup.

   To fix this there is quite some code reshuffling required which at the
   same time is a valuable cleanup.

   The final solution is to guard the futex exit handling with a per task
   mutex and make the waiter block on that mutex until the exiting task has
   the cleanup completed.

   Details why a simpler solution is not feasible can be found here:

   https://lore.kernel.org/r/20191105152728.GA5666@redhat.com

   Ignore my confusion of fork vs. vfork at the beginning of the thread.
   Futexes do that to human brains. :)

The following series addresses both issues.

Patch 1 is a slightly polished version of the original Yi and Yang
submission. It is included for completeness sake and because it
creates conflicts with the larger surgery which fixes issue #2. 

Aside of that a few eyeballs more on that subtlety are definitely not
a bad thing especially as this has a user space component in it.

The rest of the series addresses issue #2 which is more or less a kernel
only problem, but extra eyeballs are appreciated.

I'm certainly not proud about the solution for #2 but it's the best I could
come up with without violating the user/kernel state consistency
constraints.

Rusty Russell was definitely right when he said that futexes are cursed,
but as Peter Zijlstra pointed out he should have named them SNAFUtex
right away.

The series is also available from git:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git WIP.locking/futex

Thanks,

	tglx

8<-------------

 fs/exec.c                |    2 
 include/linux/compat.h   |    2 
 include/linux/futex.h    |   38 +++--
 include/linux/sched.h    |    3 
 include/linux/sched/mm.h |    6 
 kernel/exit.c            |   30 ----
 kernel/fork.c            |   40 ++---
 kernel/futex.c           |  324 ++++++++++++++++++++++++++++++++++++++++-------
 8 files changed, 330 insertions(+), 115 deletions(-)






