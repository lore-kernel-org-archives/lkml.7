Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9612C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 18:11:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6B4F2082F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 18:11:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726348AbfC1SL6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 14:11:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37098 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726171AbfC1SL6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 14:11:58 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B84CC307EA9F;
        Thu, 28 Mar 2019 18:11:57 +0000 (UTC)
Received: from llong.com (dhcp-17-19.bos.redhat.com [10.18.17.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9E6BC5D71A;
        Thu, 28 Mar 2019 18:11:54 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH 00/12] locking/rwsem: Rwsem rearchitecture part 2
Date:   Thu, 28 Mar 2019 14:10:54 -0400
Message-Id: <20190328181106.22887-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Thu, 28 Mar 2019 18:11:57 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is part 2 of a 3-part (0/1/2) series to rearchitect the internal
operation of rwsem.

part 0: https://lkml.org/lkml/2019/3/22/1662
part 1: https://lkml.org/lkml/2019/2/28/1124

This patchset revamps the current rwsem-xadd implementation to make
it saner and easier to work with. It also implements the following 3
new features:

 1) Waiter lock handoff
 2) Reader optimistic spinning
 3) Store write-lock owner in the atomic count (x86-64 only)

Waiter lock handoff is similar to the mechanism currently in the mutex
code. This ensures that lock starvation won't happen.

Reader optimistic spinning enables readers to acquire the lock more
quickly.  So workloads that use a mix of readers and writers should
see an increase in performance as long as the reader critical sections
are short.

Finally, storing the write-lock owner into the count will allow
optimistic spinners to get to the lock holder's task structure more
quickly and eliminating the timing gap where the write lock is acquired
but the owner isn't known yet. This is important for RT tasks where
spinning on a lock with an unknown owner is not allowed.

Because of the fact that multiple readers can share the same lock,
there is a natural preference for readers when measuring in term of
locking throughput as more readers are likely to get into the locking
fast path than the writers. With waiter lock handoff, we are not going
to starve the writers.

On a 8-socket 120-core 240-thread IvyBridge-EX system with 120 reader
and writer locking threads, the min/mean/max locking operations done
in a 5-second testing window before the patchset were:

  120 readers, Iterations Min/Mean/Max = 399/400/401
  120 writers, Iterations Min/Mean/Max = 400/33,389/211,359

After the patchset, they became:

  120 readers, Iterations Min/Mean/Max = 584/10,266/26,609
  120 writers, Iterations Min/Mean/Max = 22,080/29,016/38,728

So it was much fairer to readers. With less locking threads, the readers
were preferred than writers.

Patch 1 implements a new rwsem locking scheme similar to what qrwlock
is current doing. Write lock is done by atomic_cmpxchg() while read
lock is still being done by atomic_add().

Patch 2 implments lock handoff to prevent lock starvation.

Patch 3 removes rwsem_wake() wakeup optimization as it doesn't work
with lock handoff.

Patch 4 makes rwsem_spin_on_owner() returns owner state.

Patch 5 disallows RT tasks to spin on a rwsem with unknown owner.

Patch 6 makes reader wakeup to wake almost all the readers in the wait
queue instead of just those in the front.

Patch 7 enables reader to spin on a writer-owned rwsem.

Patch 8 enables lock waiters to spin on a reader-owned rwsem with
limited number of tries.

Patch 9 adds some new rwsem owner access helper functions.

Patch 10 merges the write-lock owner task pointer into the count.
Only 64-bit count has enough space to provide a reasonable number of
bits for reader count. This is for x86-64 only for the time being.

Patch 11 eliminates redundant computation of the merged owner-count.

Patch 12 handles the case of too many readers by reserving the sign
bit to designate that a reader lock attempt will fail and the locking
reader will be put to sleep. This will ensure that we will not overflow
the reader count.

With a locking microbenchmark running on 5.1 based kernel, the total
locking rates (in kops/s) on a 8-socket IvyBridge-EX system with equal
numbers of readers and writers (mixed) before and after this patchset
were:

   # of Threads   Before Patch      After Patch
   ------------   ------------      -----------
        2            1,179             9,436
        4            1,505             8,268
        8              721             7,041
       16              575             7,652
       32               70             2,189
       64               39               534

Waiman Long (12):
  locking/rwsem: Implement a new locking scheme
  locking/rwsem: Implement lock handoff to prevent lock starvation
  locking/rwsem: Remove rwsem_wake() wakeup optimization
  locking/rwsem: Make rwsem_spin_on_owner() return owner state
  locking/rwsem: Ensure an RT task will not spin on reader
  locking/rwsem: Wake up almost all readers in wait queue
  locking/rwsem: Enable readers spinning on writer
  locking/rwsem: Enable count-based spinning on reader
  locking/rwsem: Add more rwsem owner access helpers
  locking/rwsem: Merge owner into count on x86-64
  locking/rwsem: Remove redundant computation of writer lock word
  locking/rwsem: Make MSbit of count as guard bit to fail readlock

 kernel/locking/lock_events_list.h |   5 +
 kernel/locking/rwsem-xadd.c       | 619 +++++++++++++++++++-----------
 kernel/locking/rwsem.c            |   3 +-
 kernel/locking/rwsem.h            | 284 +++++++++++---
 4 files changed, 626 insertions(+), 285 deletions(-)

-- 
2.18.1

