Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2983C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 12:35:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BB722084F
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 12:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551789305;
	bh=/gS/xxS4g9AXVzmC854Ui/Gbve41oM3h2TU/jYbGXlA=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=Ow4OJp5bPlED5rSHP86xJJbqTOlNs/2Qi4xNmqDjXVSo23rHhQeLdjyqnfAcc4a+1
	 rBlY9FaA8l0JGDz2e1xU+VJv3XKlmkfcXiUkh+p/7XY7dyiwyKOKF8PeEL0oTMXO5L
	 q1Gj+meaYTelBlBLRK5Rqb37NUbPE8nuiNNdlg4c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728243AbfCEMfD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 07:35:03 -0500
Received: from mail-wr1-f42.google.com ([209.85.221.42]:33274 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbfCEMfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 07:35:03 -0500
Received: by mail-wr1-f42.google.com with SMTP id i12so9269695wrw.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2019 04:35:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=BCjIGrIi3anBz2Mw/WtBY60OI0AgtprIldyRTwj8iHI=;
        b=ivugsuePbCNDVRHzwe8c8VLtXLbFDISaBtzgsuxEgUmr2c3Yp6ZMkOCnVZM8AjTLjP
         5Yg//llx9Wpin6VNJAuwUwdvfMPspWe/bFYdICrFTQ+CK05R/IJu1ZfMHaNiQ/Ep9HCF
         vof3Z67NnDNpjiCZrORof4IIxAKNmO8llfz8Zud4KwzRoWcFxxigtKeBU8QyFJV6tSXI
         NB5VZD/MNTURE5dkaoRx/Vn8A0IBSKOuSFiuf9hiNvrHRxmDZj0+WuYNuUOogEFmg3Kn
         9Hsv8KH97xE1G2xqwG+P1y2rZ+ZK4A1+BEHtEzauTwIKlwVFYMjfKO78HApVcd3OnbDJ
         hZrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=BCjIGrIi3anBz2Mw/WtBY60OI0AgtprIldyRTwj8iHI=;
        b=a/ZYOFwu3veUOX0p+9vm5AFLTx5g0uPbn+xF0546B2HDSN9ddPSlziHg+wvWlRMYHB
         rQ5KJuE+wQq0eAcQmQflvP6MZEEOd+/Q+t0WOMhPz+MZnRKWeohtlhk/lBBC1g3iq6Nq
         kLnSWNYwJAUVL8cM9Yo89O8f3Qaa6qwtIuF5UtBVtwZhyubWuOoEKim+oOE9zqNndj3n
         mvPjofXbbf9PPlCpjH3CfB03MAkpFvywJlRVEsGDrEN2QH09lXg/y7NJmMY0RHOgRgJk
         3vH2HxNqepn9g/h2PPH1bf1SWoK2E2dWZGWau9v68dOpIbDeRlGlH8vf73duenZkISJS
         IfDA==
X-Gm-Message-State: APjAAAWvPDBjQimm6Xa1FzUhuX0CRq6+RrfrsK8Nwenx7eVXhNts6bNF
        5DNS20CtnkQp7zORYhmH9DE=
X-Google-Smtp-Source: APXvYqxTSWN0fVAuVEBkXNLWDTrPHaaZbrLDdOkNK8Er2p30Nw5msx1X3ERF3RcclRiOQieszTdgIQ==
X-Received: by 2002:adf:9167:: with SMTP id j94mr17159889wrj.106.1551789300619;
        Tue, 05 Mar 2019 04:35:00 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id f6sm10937325wrs.45.2019.03.05.04.34.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Mar 2019 04:35:00 -0800 (PST)
Date:   Tue, 5 Mar 2019 13:34:57 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@us.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] locking changes for v5.1
Message-ID: <20190305123457.GA2839@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest locking-core-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-core-for-linus

   # HEAD: 28d49e282665e2a51cc91b716937fccfa24d80e1 locking/lockdep: Shrink struct lock_class_key

The biggest part of this tree is the new auto-generated atomics API 
wrappers by Mark Rutland.

The primary motivation was to allow instrumentation without uglifying the 
primary source code.

The linecount increase comes from adding the auto-generated files to the 
Git space as well:

 include/asm-generic/atomic-instrumented.h     | 1689 ++++++++++++++++--
 include/asm-generic/atomic-long.h             | 1174 ++++++++++---
 include/linux/atomic-fallback.h               | 2295 +++++++++++++++++++++++++
 include/linux/atomic.h                        | 1241 +------------

I preferred this approach, so that the full call stack of the (already 
complex) locking APIs is still fully visible in 'git grep'.

But if this is excessive we could certainly hide them.

There's a separate build-time mechanism to determine whether the headers 
are out of date (they should never be stale if we do our job right).

Anyway, nothing from this should be visible to regular kernel developers.

Other changes:

 - Add support for dynamic keys, which removes a source of false 
   positives in the workqueue code, among other things. (Bart Van Assche)

 - Updates to tools/memory-model (Andrea Parri, Paul E. McKenney)

 - qspinlock, wake_q and lockdep micro-optimizations (Waiman Long)

 - misc other updates and enhancements.

 Thanks,

	Ingo

------------------>
Anders Roxell (1):
      locking/atomics: Change 'fold' to 'grep'

Andrea Parri (1):
      tools/memory-model: Model smp_mb__after_unlock_lock()

Bart Van Assche (21):
      locking/lockdep: Fix two 32-bit compiler warnings
      locking/lockdep: Fix reported required memory size (1/2)
      locking/lockdep: Fix reported required memory size (2/2)
      locking/lockdep: Avoid that add_chain_cache() adds an invalid chain to the cache
      locking/lockdep: Reorder struct lock_class members
      locking/lockdep: Make zap_class() remove all matching lock order entries
      locking/lockdep: Initialize the locks_before and locks_after lists earlier
      locking/lockdep: Split lockdep_free_key_range() and lockdep_reset_lock()
      locking/lockdep: Make it easy to detect whether or not inside a selftest
      locking/lockdep: Update two outdated comments
      locking/lockdep: Free lock classes that are no longer in use
      locking/lockdep: Reuse list entries that are no longer in use
      locking/lockdep: Introduce lockdep_next_lockchain() and lock_chain_count()
      locking/lockdep: Fix a comment in add_chain_cache()
      locking/lockdep: Reuse lock chains that have been freed
      locking/lockdep: Check data structure consistency
      locking/lockdep: Verify whether lock objects are small enough to be used as class keys
      locking/lockdep: Add support for dynamic keys
      kernel/workqueue: Use dynamic lockdep keys for workqueues
      lockdep/lib/tests: Fix run_tests.sh
      lockdep/lib/tests: Test dynamic key registration

Borislav Petkov (1):
      locking/atomics: Fix out-of-tree build

Davidlohr Bueso (2):
      sched/wake_q: Add branch prediction hint to wake_q_add() cmpxchg
      sched/wake_q: Reduce reference counting for special users

Elena Reshetova (2):
      refcount_t: Add ACQUIRE ordering on success for dec(sub)_and_test() variants
      futex: Convert futex_pi_state.refcount to refcount_t

Frederic Weisbecker (2):
      locking/lockdep: Simplify mark_held_locks()
      locking/lockdep: Provide enum lock_usage_bit mask names

Greg Kroah-Hartman (1):
      futex: No need to check return value of debugfs_create functions

Ingo Molnar (1):
      locking/atomics: Fix scripts/atomic/ script permissions

Mark Rutland (7):
      locking/atomics: Add common header generation files
      locking/atomics: Switch to generated fallbacks
      locking/atomics: Switch to generated atomic-long
      locking/atomics: Switch to generated instrumentation
      locking/atomics: Check generated headers are up-to-date
      arm64, locking/atomics: Use instrumented atomics
      locking/atomics: Check atomic headers with sha1sum

Paul E. McKenney (2):
      tools/memory-model: Add scripts to check github litmus tests
      tools/memory-model: Make scripts take "-j" abbreviation for "--jobs"

Peter Zijlstra (3):
      locking/percpu-rwsem: Remove preempt_disable variants
      locking/lockdep: Add module_param to enable consistency checks
      locking/lockdep: Shrink struct lock_class_key

Valentin Schneider (2):
      cpu/hotplug: Mute hotplug lockdep during init
      Revert "sched/core: Take the hotplug lock in sched_init_smp()"

Waiman Long (5):
      locking/lockdep: Add debug_locks check in __lock_downgrade()
      locking/lockdep: Add debug_locks check in __lock_downgrade()
      locking/qspinlock: Handle > 4 slowpath nesting levels
      locking/qspinlock_stat: Track the no MCS node available case
      locking/qspinlock: Remove unnecessary BUG_ON() call


 Documentation/core-api/refcount-vs-atomic.rst |   24 +-
 Kbuild                                        |   18 +-
 MAINTAINERS                                   |    1 +
 arch/arm64/include/asm/atomic.h               |  237 +--
 arch/arm64/include/asm/atomic_ll_sc.h         |   28 +-
 arch/arm64/include/asm/atomic_lse.h           |   38 +-
 arch/arm64/include/asm/cmpxchg.h              |   60 +-
 arch/arm64/include/asm/sync_bitops.h          |   16 +-
 arch/x86/include/asm/refcount.h               |   22 +-
 fs/locks.c                                    |   32 +-
 include/asm-generic/atomic-instrumented.h     | 1689 ++++++++++++++++--
 include/asm-generic/atomic-long.h             | 1174 ++++++++++---
 include/linux/atomic-fallback.h               | 2295 +++++++++++++++++++++++++
 include/linux/atomic.h                        | 1241 +------------
 include/linux/lockdep.h                       |   54 +-
 include/linux/percpu-rwsem.h                  |   24 +-
 include/linux/sched/wake_q.h                  |    4 +-
 include/linux/workqueue.h                     |   28 +-
 kernel/cpu.c                                  |    9 +
 kernel/futex.c                                |   26 +-
 kernel/locking/lockdep.c                      |  966 +++++++++--
 kernel/locking/lockdep_internals.h            |    7 +-
 kernel/locking/lockdep_proc.c                 |   12 +-
 kernel/locking/qspinlock.c                    |   21 +-
 kernel/locking/qspinlock_stat.h               |   21 +-
 kernel/locking/rwsem-xadd.c                   |    4 +-
 kernel/sched/core.c                           |   67 +-
 kernel/workqueue.c                            |   59 +-
 lib/locking-selftest.c                        |    2 +
 lib/refcount.c                                |   18 +-
 scripts/atomic/atomic-tbl.sh                  |  186 ++
 scripts/atomic/atomics.tbl                    |   41 +
 scripts/atomic/check-atomics.sh               |   33 +
 scripts/atomic/fallbacks/acquire              |    9 +
 scripts/atomic/fallbacks/add_negative         |   16 +
 scripts/atomic/fallbacks/add_unless           |   16 +
 scripts/atomic/fallbacks/andnot               |    7 +
 scripts/atomic/fallbacks/dec                  |    7 +
 scripts/atomic/fallbacks/dec_and_test         |   15 +
 scripts/atomic/fallbacks/dec_if_positive      |   15 +
 scripts/atomic/fallbacks/dec_unless_positive  |   14 +
 scripts/atomic/fallbacks/fence                |   11 +
 scripts/atomic/fallbacks/fetch_add_unless     |   23 +
 scripts/atomic/fallbacks/inc                  |    7 +
 scripts/atomic/fallbacks/inc_and_test         |   15 +
 scripts/atomic/fallbacks/inc_not_zero         |   14 +
 scripts/atomic/fallbacks/inc_unless_negative  |   14 +
 scripts/atomic/fallbacks/read_acquire         |    7 +
 scripts/atomic/fallbacks/release              |    8 +
 scripts/atomic/fallbacks/set_release          |    7 +
 scripts/atomic/fallbacks/sub_and_test         |   16 +
 scripts/atomic/fallbacks/try_cmpxchg          |   11 +
 scripts/atomic/gen-atomic-fallback.sh         |  181 ++
 scripts/atomic/gen-atomic-instrumented.sh     |  182 ++
 scripts/atomic/gen-atomic-long.sh             |  101 ++
 scripts/atomic/gen-atomics.sh                 |   20 +
 tools/lib/lockdep/include/liblockdep/common.h |    2 +
 tools/lib/lockdep/include/liblockdep/mutex.h  |   11 +-
 tools/lib/lockdep/run_tests.sh                |    6 +-
 tools/lib/lockdep/tests/ABBA.c                |    9 +
 tools/memory-model/.gitignore                 |    1 +
 tools/memory-model/README                     |    2 +
 tools/memory-model/linux-kernel.bell          |    3 +-
 tools/memory-model/linux-kernel.cat           |    4 +-
 tools/memory-model/linux-kernel.def           |    1 +
 tools/memory-model/scripts/README             |   70 +
 tools/memory-model/scripts/checkalllitmus.sh  |   53 +-
 tools/memory-model/scripts/checkghlitmus.sh   |   65 +
 tools/memory-model/scripts/checklitmus.sh     |   74 +-
 tools/memory-model/scripts/checklitmushist.sh |   60 +
 tools/memory-model/scripts/cmplitmushist.sh   |   87 +
 tools/memory-model/scripts/initlitmushist.sh  |   68 +
 tools/memory-model/scripts/judgelitmus.sh     |   78 +
 tools/memory-model/scripts/newlitmushist.sh   |   61 +
 tools/memory-model/scripts/parseargs.sh       |  136 ++
 tools/memory-model/scripts/runlitmushist.sh   |   87 +
 76 files changed, 7814 insertions(+), 2237 deletions(-)
 create mode 100644 include/linux/atomic-fallback.h
 create mode 100755 scripts/atomic/atomic-tbl.sh
 create mode 100755 scripts/atomic/atomics.tbl
 create mode 100755 scripts/atomic/check-atomics.sh
 create mode 100755 scripts/atomic/fallbacks/acquire
 create mode 100755 scripts/atomic/fallbacks/add_negative
 create mode 100755 scripts/atomic/fallbacks/add_unless
 create mode 100755 scripts/atomic/fallbacks/andnot
 create mode 100755 scripts/atomic/fallbacks/dec
 create mode 100755 scripts/atomic/fallbacks/dec_and_test
 create mode 100755 scripts/atomic/fallbacks/dec_if_positive
 create mode 100755 scripts/atomic/fallbacks/dec_unless_positive
 create mode 100755 scripts/atomic/fallbacks/fence
 create mode 100755 scripts/atomic/fallbacks/fetch_add_unless
 create mode 100755 scripts/atomic/fallbacks/inc
 create mode 100755 scripts/atomic/fallbacks/inc_and_test
 create mode 100755 scripts/atomic/fallbacks/inc_not_zero
 create mode 100755 scripts/atomic/fallbacks/inc_unless_negative
 create mode 100755 scripts/atomic/fallbacks/read_acquire
 create mode 100755 scripts/atomic/fallbacks/release
 create mode 100755 scripts/atomic/fallbacks/set_release
 create mode 100755 scripts/atomic/fallbacks/sub_and_test
 create mode 100755 scripts/atomic/fallbacks/try_cmpxchg
 create mode 100755 scripts/atomic/gen-atomic-fallback.sh
 create mode 100755 scripts/atomic/gen-atomic-instrumented.sh
 create mode 100755 scripts/atomic/gen-atomic-long.sh
 create mode 100644 scripts/atomic/gen-atomics.sh
 create mode 100644 tools/memory-model/.gitignore
 create mode 100644 tools/memory-model/scripts/README
 create mode 100644 tools/memory-model/scripts/checkghlitmus.sh
 create mode 100644 tools/memory-model/scripts/checklitmushist.sh
 create mode 100644 tools/memory-model/scripts/cmplitmushist.sh
 create mode 100644 tools/memory-model/scripts/initlitmushist.sh
 create mode 100644 tools/memory-model/scripts/judgelitmus.sh
 create mode 100644 tools/memory-model/scripts/newlitmushist.sh
 create mode 100644 tools/memory-model/scripts/parseargs.sh
 create mode 100644 tools/memory-model/scripts/runlitmushist.sh
