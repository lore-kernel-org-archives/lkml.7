Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D3ECC10F11
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 17:23:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E0902147A
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 17:23:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727313AbfDMRXo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 13:23:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46494 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727074AbfDMRXn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 13:23:43 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BB38CC053B34;
        Sat, 13 Apr 2019 17:23:42 +0000 (UTC)
Received: from llong.com (ovpn-120-133.rdu2.redhat.com [10.10.120.133])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 442175D9C6;
        Sat, 13 Apr 2019 17:23:39 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        huang ying <huang.ying.caritas@gmail.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v4 00/16] locking/rwsem: Rwsem rearchitecture part 2
Date:   Sat, 13 Apr 2019 13:22:43 -0400
Message-Id: <20190413172259.2740-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Sat, 13 Apr 2019 17:23:43 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 v4:
  - Fix the missing initialization bug with !CONFIG_RWSEM_SPIN_ON_OWNER
    in patch 2.
  - Move the "Remove rwsem_wake() wakeup optimization" patch before
    the "Implement a new locking scheme" patch.
  - Add two new patches to merge the relevant content of rwsem.h and
    rwsem-xadd.c into rwsem.c as suggested by PeterZ.
  - Refactor the lock handoff patch to make all setting and clearing
    of the handoff bit serialized by wait_lock to ensure correctness.
  - Adapt the rest of the patches to the new code base.

 v3:
  - Add 2 more patches in front to fix build and testing issues found.
    Patch 1 can actually be merged on top of the patch "locking/rwsem:
    Enhance DEBUG_RWSEMS_WARN_ON() macro" in part 1.
  - Change the handoff patch (now patch 4) to set handoff bit immediately
    after wakeup for RT writers. The timeout limit is also tightened to
    4ms.
  - There is no code changes in other patches other than resolving conflicts
    with patches 1, 2 and 4.

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

Patch 1 fixes an testing issue with locking selftest introduced by the
patch "locking/rwsem: Enhance DEBUG_RWSEMS_WARN_ON() macro" in part 1.

Patch 2 makes owner a permanent member of the rw_semaphore structure and
set it irrespective of CONFIG_RWSEM_SPIN_ON_OWNER.

Patch 3 removes rwsem_wake() wakeup optimization as it doesn't work
with lock handoff.

Patch 4 implements a new rwsem locking scheme similar to what qrwlock
is current doing. Write lock is done by atomic_cmpxchg() while read
lock is still being done by atomic_add().

Patch 5 merges the content of rwsem.h and rwsem-xadd.c into rwsem.c just
like the mutex. The rwsem-xadd.c is removed and a bare-bone rwsem.h is
left for internal function declaration needed by percpu-rwsem.c.

Patch 6 optimizes the merged rwsem.c file to generate smaller object
file.

Patch 7 implments lock handoff to prevent lock starvation. It is expected
that throughput will be lower on workloads with highly contended rwsems
for better fairness.

Patch 8 makes rwsem_spin_on_owner() returns owner state.

Patch 9 disallows RT tasks to spin on a rwsem with unknown owner.

Patch 10 makes reader wakeup to wake almost all the readers in the wait
queue instead of just those in the front.

Patch 11 enables reader to spin on a writer-owned rwsem.

Patch 12 enables a writer to spin on a reader-owned rwsem for at most
25us.

Patch 13 adds some new rwsem owner access helper functions.

Patch 14 handles the case of too many readers by reserving the sign
bit to designate that a reader lock attempt will fail and the locking
reader will be put to sleep. This will ensure that we will not overflow
the reader count.

Patch 15 merges the write-lock owner task pointer into the count.
Only 64-bit count has enough space to provide a reasonable number of
bits for reader count. This is for x86-64 only for the time being.

Patch 16 eliminates redundant computation of the merged owner-count.

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

On workloads where the rwsem reader critical section is relatively long
(longer than the spinning period), optimistic of writer on reader-owned
rwsem may not be that helpful. In fact, the performance may regress
in some cases like the will-it-sclae page_fault1 microbenchmark. This
is likely due to the fact that larger reader groups where the readers
acquire the lock together are broken into smaller ones. So more work
will be needed to better tune the rwsem code to that kind of workload.

Waiman Long (16):
  locking/rwsem: Prevent unneeded warning during locking selftest
  locking/rwsem: Make owner available even if
    !CONFIG_RWSEM_SPIN_ON_OWNER
  locking/rwsem: Remove rwsem_wake() wakeup optimization
  locking/rwsem: Implement a new locking scheme
  locking/rwsem: Merge rwsem.h and rwsem-xadd.c into rwsem.c
  locking/rwsem: Code cleanup after files merging
  locking/rwsem: Implement lock handoff to prevent lock starvation
  locking/rwsem: Make rwsem_spin_on_owner() return owner state
  locking/rwsem: Ensure an RT task will not spin on reader
  locking/rwsem: Wake up almost all readers in wait queue
  locking/rwsem: Enable readers spinning on writer
  locking/rwsem: Enable time-based spinning on reader-owned rwsem
  locking/rwsem: Add more rwsem owner access helpers
  locking/rwsem: Guard against making count negative
  locking/rwsem: Merge owner into count on x86-64
  locking/rwsem: Remove redundant computation of writer lock word

 include/linux/rwsem.h             |    9 +-
 kernel/locking/Makefile           |    2 +-
 kernel/locking/lock_events_list.h |    4 +
 kernel/locking/rwsem-xadd.c       |  729 ---------------
 kernel/locking/rwsem.c            | 1403 ++++++++++++++++++++++++++++-
 kernel/locking/rwsem.h            |  305 +------
 lib/Kconfig.debug                 |    8 +-
 7 files changed, 1396 insertions(+), 1064 deletions(-)
 delete mode 100644 kernel/locking/rwsem-xadd.c

-- 
2.18.1

