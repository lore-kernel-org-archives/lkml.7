Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A034AC282CE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 19:22:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7668621738
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 19:22:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731811AbfDETV7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 15:21:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39390 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731183AbfDETV6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 15:21:58 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 48B503082E4F;
        Fri,  5 Apr 2019 19:21:58 +0000 (UTC)
Received: from llong.com (dhcp-17-47.bos.redhat.com [10.18.17.47])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6942761353;
        Fri,  5 Apr 2019 19:21:54 +0000 (UTC)
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
Subject: [PATCH-tip v2 00/12] locking/rwsem: Rwsem rearchitecture part 2
Date:   Fri,  5 Apr 2019 15:21:03 -0400
Message-Id: <20190405192115.17416-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Fri, 05 Apr 2019 19:21:58 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 v2:
  - Move the negative reader count checking patch (patch 12->10)
    forward to before the merge owner to count patch as suggested by
    Linus & expand the comment.
  - Change the reader-owned rwsem spinning from count based to time
    based to have better control of the max time allowed.

This is part 2 of a 3-part (0/1/2) series to rearchitect the internal
operation of rwsem.

part 0: merged into tip
part 1: https://lore.kernel.org/lkml/20190404174320.22416-1-longman@redhat.com/

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

Patch 8 enables a writer to spin on a reader-owned rwsem for at most
25us.

Patch 9 adds some new rwsem owner access helper functions.

Patch 10 handles the case of too many readers by reserving the sign
bit to designate that a reader lock attempt will fail and the locking
reader will be put to sleep. This will ensure that we will not overflow
the reader count.

Patch 11 merges the write-lock owner task pointer into the count.
Only 64-bit count has enough space to provide a reasonable number of
bits for reader count. This is for x86-64 only for the time being.

Patch 12 eliminates redundant computation of the merged owner-count.

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
  locking/rwsem: Enable time-based spinning on reader-owned rwsem
  locking/rwsem: Add more rwsem owner access helpers
  locking/rwsem: Guard against making count negative
  locking/rwsem: Merge owner into count on x86-64
  locking/rwsem: Remove redundant computation of writer lock word

 kernel/locking/lock_events_list.h |   4 +
 kernel/locking/rwsem-xadd.c       | 635 +++++++++++++++++++-----------
 kernel/locking/rwsem.c            |   3 +-
 kernel/locking/rwsem.h            | 290 +++++++++++---
 4 files changed, 647 insertions(+), 285 deletions(-)

-- 
2.18.1

