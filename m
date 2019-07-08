Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE533C606A7
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 09:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C70A20651
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 09:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562578524;
	bh=83f54rUK9OlwZGXTmSl7C//yjrl+eQvESDDLN+7JyFk=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=gkBKzzfYGAbsQ2oyTMWoFd2K3OKkBIuP0N6lpbEBsl/xaAmhc7prkbDCLDFgk/T2W
	 oQGUvgxQVjtbXHIN0Df5i2Iv3stqPa53oDoc82Vu9mI6N668nQalYGq899DB1nIRwF
	 rVHIKpEcsLZRfWy4xnwS2ORnSVjJgdBsUv9UDasc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729840AbfGHJfX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 05:35:23 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33430 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728725AbfGHJfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 05:35:22 -0400
Received: by mail-wr1-f66.google.com with SMTP id n9so16273209wru.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 02:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=XYVD7q3KC16RGpAK+q6liM9weRe3VNFOCPHZu8WNuqU=;
        b=H9Ogj9zrCzlTT5tsKY73uEJP8G1B/cUrBXhesbuK3IDl1ktuH+9+GYp1L/F3iEmqJk
         JsmGfzhWiH5OJQ2V0QubaWOsEcpFd+UdPN7EyKa+QoG62tTq0w2o7yx4nRcPVb7zPcw/
         tBhBSp8CHZkYJD3D0HDdAHb9hXD05x/f0CWwqKyJlR7rGrQTpvkoW1nbQPvR8Gu/MosV
         z4rKPLa5/D2NCeISWbHZYhX7drz4no5FM7t90WKGQFkRaQ69Y1yZcXOfTPb1IxdrgixD
         YXP1XQqLNO/sKEUoJIUhlok9v0c2N0cIQ6h6qmK06/Eu2gQlfiNsXTAn9jvgLENS9R9l
         wY7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=XYVD7q3KC16RGpAK+q6liM9weRe3VNFOCPHZu8WNuqU=;
        b=eTPOlO6Ai2/QiRPEVRgUtNKITYjS/GG/rB6MIqcTCvHR6SGO/FoBy1lCfGIsX+2Lx4
         O5ueE5CrPk79eu8emLfIYSSjxk/1rE6s3hVUykoGvCkfMzF5rfQFIn3HBJULLxHcc6Pw
         vKj92LimOBS9trEJ7PuXd2vouxKSFtemVheo+xDZuRmUwMEWVdu5FNlz4EmPiN3UMmw7
         a7xX0SYlmR1Sw5Dt2q3CJ6M1icZH6aNz8WGjhZF+LLs17gKlL4q6H+sJJ2YwzrDJ/KXY
         UB21pQkrR84dbOrZnwdhG8oub/6D01ZdjzRcevXmLgTp4PYrZ+2yMsk9fniRjKWfdcqM
         0UYg==
X-Gm-Message-State: APjAAAXEP1USeh0XnOTCkzbuibDBtqCfwU5LoW9sZ07Cu2Bt4Cs38mW/
        tLByfZZ1QrMaFpR55igC72U=
X-Google-Smtp-Source: APXvYqxpZ/i6MN+LrbGAIoDX9pyCZRtIDFL/rDeCjwh7Qf6SGSBj9MGD6lgUVSbq87MSopzx6J1zFA==
X-Received: by 2002:adf:a55b:: with SMTP id j27mr18089631wrb.154.1562578519310;
        Mon, 08 Jul 2019 02:35:19 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id w20sm45625750wra.96.2019.07.08.02.35.18
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 08 Jul 2019 02:35:18 -0700 (PDT)
Date:   Mon, 8 Jul 2019 11:35:16 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Will Deacon <will.deacon@arm.com>,
        "Paul E. McKenney" <paulmck@us.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] locking changes for v5.3
Message-ID: <20190708093516.GA57558@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest locking-core-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-core-for-linus

   # HEAD: 9156e545765e467e6268c4814cfa609ebb16237e locking/lockdep: increase size of counters for lockdep statistics

The main changes in this cycle are:

 - rwsem scalability improvements, phase #2, by Waiman Long, which are 
   rather impressive:

    "On a 2-socket 40-core 80-thread Skylake system with 40 reader and 
     writer locking threads, the min/mean/max locking operations done in a 
     5-second testing window before the patchset were:

      40 readers, Iterations Min/Mean/Max = 1,807/1,808/1,810
      40 writers, Iterations Min/Mean/Max = 1,807/50,344/151,255

     After the patchset, they became:

      40 readers, Iterations Min/Mean/Max = 30,057/31,359/32,741
      40 writers, Iterations Min/Mean/Max = 94,466/95,845/97,098"

   There's a lot of changes to the locking implementation that makes it 
   similar to qrwlock, including owner handoff for more fair locking.

   Another microbenchmark shows how across the spectrum the improvements 
   are:

    "With a locking microbenchmark running on 5.1 based kernel, the total 
     locking rates (in kops/s) on a 2-socket Skylake system with equal 
     numbers of readers and writers (mixed) before and after this 
     patchset were:

     # of Threads   Before Patch      After Patch
     ------------   ------------      -----------
          2            2,618             4,193
          4            1,202             3,726
          8              802             3,622
         16              729             3,359
         32              319             2,826
         64              102             2,744"

   The changes are extensive and the patch-set has been through several 
   iterations addressing various locking workloads. There might be more 
   regressions, but unless they are pathological I believe we want to use 
   this new implementation as the baseline going forward.

 - jump-label optimizations by Daniel Bristot de Oliveira: the primary 
   motivation was to remove IPI disturbance of isolated RT-workload CPUs, 
   which resulted in the implementation of batched jump-label updates.
   Beyond the improvement of the real-time characteristics kernel, in one 
   test this patchset improved static key update overhead from 57 msecs 
   to just 1.4 msecs - which is a nice speedup as well.

 - atomic64_t cross-arch type cleanups by Mark Rutland: over the last ~10 
   years of atomic64_t existence the various types used by the APIs only 
   had to be self-consistent within each architecture - which means they 
   became wildly inconsistent across architectures. Mark puts and end to 
   this by reworking all the atomic64 implementations to use 's64' as the 
   base type for atomic64_t, and to ensure that this type is consistently 
   used for parameters and return values in the API, avoiding further 
   problems in this area.

 - A large set of small improvements to lockdep by Yuyang Du: type 
   cleanups, output cleanups, function return type and othr cleanups all 
   around the place.

 - A set of percpu ops cleanups and fixes by Peter Zijlstra.

 - Misc other changes - please see the Git log for more details.

 Thanks,

	Ingo

------------------>
Anders Roxell (1):
      locking/lockdep: Remove the unused print_lock_trace() function

Arnd Bergmann (1):
      locking/lockdep: Move mark_lock() inside CONFIG_TRACE_IRQFLAGS && CONFIG_PROVE_LOCKING

Daniel Bristot de Oliveira (6):
      jump_label: Add a jump_label_can_update() helper
      x86/jump_label: Add a __jump_label_set_jump_code() helper
      jump_label: Sort entries of the same key by the code
      x86/alternative: Batch of patch operations
      jump_label: Batch updates if arch supports it
      x86/jump_label: Batch jump label updates

Imre Deak (2):
      locking/lockdep: Fix OOO unlock when hlocks need merging
      locking/lockdep: Fix merging of hlocks with non-zero references

Kobe Wu (2):
      locking/lockdep: Remove unnecessary DEBUG_LOCKS_WARN_ON()
      locking/lockdep: increase size of counters for lockdep statistics

Mark Rutland (18):
      locking/atomic, crypto/nx: Prepare for atomic64_read() conversion
      locking/atomic, s390/pci: Prepare for atomic64_read() conversion
      locking/atomic: Use s64 for atomic64
      locking/atomic, alpha: Use s64 for atomic64
      locking/atomic, arc: Use s64 for atomic64
      locking/atomic, arm: Use s64 for atomic64
      locking/atomic, arm64: Use s64 for atomic64
      locking/atomic, ia64: Use s64 for atomic64
      locking/atomic, mips: Use s64 for atomic64
      locking/atomic, powerpc: Use s64 for atomic64
      locking/atomic, riscv: Fix atomic64_sub_if_positive() offset argument
      locking/atomic, riscv: Use s64 for atomic64
      locking/atomic, s390: Use s64 for atomic64
      locking/atomic, sparc: Use s64 for atomic64
      locking/atomic, x86: Use s64 for atomic64
      locking/atomic: Use s64 for atomic64_t on 64-bit
      locking/atomic, crypto/nx: Remove redundant casts
      locking/atomic, s390/pci: Remove redundant casts

Michael Forney (1):
      locking/atomics: Use sed(1) instead of non-standard head(1) option

Nikolay Borisov (1):
      locking/lockdep: Rename lockdep_assert_held_exclusive() -> lockdep_assert_held_write()

Peter Zijlstra (8):
      locking/lock_events: Use raw_cpu_{add,inc}() for stats
      Documentation/atomic_t.txt: Clarify pure non-rmw usage
      x86/atomic: Fix smp_mb__{before,after}_atomic()
      x86/percpu: Differentiate this_cpu_{}() and __this_cpu_{}()
      x86/percpu: Relax smp_processor_id()
      x86/percpu, x86/irq: Relax {set,get}_irq_regs()
      x86/percpu, sched/fair: Avoid local_clock()
      x86/percpu: Optimize raw_cpu_xchg()

Sebastian Andrzej Siewior (1):
      locking/lockdep: Don't complain about incorrect name for no validate class

Waiman Long (17):
      futex: Consolidate duplicated timer setup code
      locking/rwsem: Make owner available even if !CONFIG_RWSEM_SPIN_ON_OWNER
      locking/rwsem: Remove rwsem_wake() wakeup optimization
      locking/rwsem: Implement a new locking scheme
      locking/rwsem: Merge rwsem.h and rwsem-xadd.c into rwsem.c
      locking/rwsem: Code cleanup after files merging
      locking/rwsem: Make rwsem_spin_on_owner() return owner state
      locking/rwsem: Implement lock handoff to prevent lock starvation
      locking/rwsem: Always release wait_lock before waking up tasks
      locking/rwsem: More optimal RT task handling of null owner
      locking/rwsem: Wake up almost all readers in wait queue
      locking/rwsem: Clarify usage of owner's nonspinaable bit
      locking/rwsem: Enable readers spinning on writer
      locking/rwsem: Make rwsem->owner an atomic_long_t
      locking/rwsem: Enable time-based spinning on reader-owned rwsem
      locking/rwsem: Adaptive disabling of reader optimistic spinning
      locking/rwsem: Guard against making count negative

YueHaibing (1):
      x86/jump_label: Make tp_vec_nr static

Yuyang Du (23):
      locking/lockdep: Change all print_*() return type to void
      locking/lockdep: Add description and explanation in lockdep design doc
      locking/lockdep: Adjust lock usage bit character checks
      locking/lockdep: Remove useless conditional macro
      locking/lockdep: Print the right depth for chain key collision
      locking/lockdep: Update obsolete struct field description
      locking/lockdep: Use lockdep_init_task for task initiation consistently
      locking/lockdep: Define INITIAL_CHAIN_KEY for chain keys to start with
      locking/lockdep: Change the range of class_idx in held_lock struct
      locking/lockdep: Remove unused argument in validate_chain() and check_deadlock()
      locking/lockdep: Update comment
      locking/lockdep: Change type of the element field in circular_queue
      locking/lockdep: Change the return type of __cq_dequeue()
      locking/lockdep: Avoid constant checks in __bfs by using offset reference
      locking/lockdep: Update comments on dependency search
      locking/lockdep: Add explanation to lock usage rules in lockdep design doc
      locking/lockdep: Remove redundant argument in check_deadlock
      locking/lockdep: Remove unused argument in __lock_release
      locking/lockdep: Refactorize check_noncircular and check_redundant
      locking/lockdep: Check redundant dependency only when CONFIG_LOCKDEP_SMALL
      locking/lockdep: Consolidate lock usage bit initialization
      locking/lockdep: Adjust new bit cases in mark_lock
      locking/lockdep: Remove !dir in lock irq usage check


 Documentation/atomic_t.txt               |    9 +-
 Documentation/locking/lockdep-design.txt |  112 ++-
 arch/alpha/include/asm/atomic.h          |   20 +-
 arch/arc/include/asm/atomic.h            |   41 +-
 arch/arm/include/asm/atomic.h            |   50 +-
 arch/arm64/include/asm/atomic_ll_sc.h    |   20 +-
 arch/arm64/include/asm/atomic_lse.h      |   34 +-
 arch/ia64/include/asm/atomic.h           |   20 +-
 arch/mips/include/asm/atomic.h           |   22 +-
 arch/powerpc/include/asm/atomic.h        |   44 +-
 arch/riscv/include/asm/atomic.h          |   44 +-
 arch/s390/include/asm/atomic.h           |   38 +-
 arch/s390/pci/pci_debug.c                |    2 +-
 arch/sparc/include/asm/atomic_64.h       |    8 +-
 arch/x86/events/core.c                   |    2 +-
 arch/x86/include/asm/atomic.h            |    8 +-
 arch/x86/include/asm/atomic64_32.h       |   66 +-
 arch/x86/include/asm/atomic64_64.h       |   46 +-
 arch/x86/include/asm/barrier.h           |    4 +-
 arch/x86/include/asm/irq_regs.h          |    4 +-
 arch/x86/include/asm/jump_label.h        |    2 +
 arch/x86/include/asm/percpu.h            |  236 ++---
 arch/x86/include/asm/smp.h               |    3 +-
 arch/x86/include/asm/text-patching.h     |   15 +
 arch/x86/kernel/alternative.c            |  154 +++-
 arch/x86/kernel/jump_label.c             |  121 ++-
 drivers/crypto/nx/nx-842-pseries.c       |    6 +-
 drivers/infiniband/core/device.c         |    2 +-
 drivers/tty/tty_ldisc.c                  |    8 +-
 fs/dax.c                                 |    2 +-
 include/asm-generic/atomic64.h           |   20 +-
 include/linux/jump_label.h               |    3 +
 include/linux/lockdep.h                  |   36 +-
 include/linux/percpu-rwsem.h             |    4 +-
 include/linux/rwsem.h                    |   16 +-
 include/linux/sched/wake_q.h             |    5 +
 include/linux/smp.h                      |   45 +-
 include/linux/types.h                    |    2 +-
 init/init_task.c                         |    2 +
 kernel/fork.c                            |    3 -
 kernel/futex.c                           |   69 +-
 kernel/jump_label.c                      |   64 +-
 kernel/locking/Makefile                  |    2 +-
 kernel/locking/lock_events.h             |   45 +-
 kernel/locking/lock_events_list.h        |   12 +-
 kernel/locking/lockdep.c                 |  742 ++++++++-------
 kernel/locking/lockdep_internals.h       |   36 +-
 kernel/locking/rwsem-xadd.c              |  745 ---------------
 kernel/locking/rwsem.c                   | 1453 +++++++++++++++++++++++++++++-
 kernel/locking/rwsem.h                   |  306 +------
 kernel/sched/fair.c                      |    5 +-
 lib/Kconfig.debug                        |    8 +-
 lib/atomic64.c                           |   32 +-
 scripts/atomic/check-atomics.sh          |    2 +-
 security/apparmor/label.c                |    8 +-
 55 files changed, 2788 insertions(+), 2020 deletions(-)
 delete mode 100644 kernel/locking/rwsem-xadd.c
