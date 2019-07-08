Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25037C5B578
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 09:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE78F205ED
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 09:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562576969;
	bh=IN4HXUbNcWijv3CYmJAxE+HEYf0OBZ3ijyM9jf/sO7Y=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=Jb0nRz0I0b2H2T1rQqjXKEQYCvqiUrD6npazsyGTt/D3Tl977qPZKlz6cgV51wAjz
	 qB4HiBgm3HilcIpEXynTPiv3FhQG4A+uY1sycaeDe61QQzW/H9A7IDIli++nsr2UYh
	 Hm1OJl9hbq6XqQ3wbNs9gOdpH0N9rb2y5t9HOu8A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729669AbfGHJJ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 05:09:28 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35671 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726284AbfGHJJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 05:09:26 -0400
Received: by mail-wr1-f67.google.com with SMTP id y4so7541526wrm.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 02:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=tKAJbh75lFXDsmlEactm1A3egstkfVUzjG6Bu8j0qEs=;
        b=HzkhDVrLZAOmZfAW6kJk8eAsqILthXM4A3njVXq4sPVbbmVRKI5RXtRvgl3h8ApZkR
         cQkBzenkjMVAPPum9GTIH5dS38eh5zRFBg6Q3L2+y0UXUYgrlv/4ViHSnGIs7/rzA4ds
         2BI079HmtDXI6wf8yMCJVHJWmyGLokpr7M6bSBKYSJTTa7WgUTGsPVHn2s+yIfufWfyW
         2LYfuyp79/fQCu/rx/yd4sYoiS6mb3qQcQkJFY1TNjKFelwaiYzQTu/89YyBGIg8iqJS
         YeDTw31OLH7Uc29nNJd77Xee/uIGfaLYblSNQJMTnZrGiywt+sxXbXhtWHL1dF68f8EH
         inSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=tKAJbh75lFXDsmlEactm1A3egstkfVUzjG6Bu8j0qEs=;
        b=injkROtBa6Qf82KMTj1S0WStB9UjhqoaQ4NAnmcTU1/bcEoL48mWEQqAiviNUvGZ0h
         VhnsEiXriTQk96SFWwSbsc5ACDaxCHAXRb7Sigd1HEjO5PAISezSMce7jFaQUbgSjPLY
         G1qNzOda7vSBGjR19lLrt+5OJgi4MqShlrAhZx25RUa4JSjfj+xTfRqtpFROuPV2PkRV
         PgtGL9n2CL9KKdmtPkYbwZO+tMrbtnG1hvp7YfItHMD9ysS06Y50aswegbwBJ1LFylMS
         7aSJwkstHOnA9bNgYcWTlJ0rAgfvIIBHjamrrRcFlPxY4cUNYZDMiyA85o56CTCrND3P
         NabQ==
X-Gm-Message-State: APjAAAWJf/TEaiEMYZJt/iKoMq6wQQnZklPSKp5cL2dqDYvkNz4jWRRK
        /KD5Td1Hwp3eyL23UfK2aZRAJzs8
X-Google-Smtp-Source: APXvYqzzK+ADM2fl5qFsjFRxo3oax/lSg1aulpUbJLS+lPR39rb93aiucXoZCDjUXXdtB6x8vLPGNQ==
X-Received: by 2002:a5d:4489:: with SMTP id j9mr18077883wrq.15.1562576963176;
        Mon, 08 Jul 2019 02:09:23 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id z7sm5718477wrh.67.2019.07.08.02.09.21
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 08 Jul 2019 02:09:22 -0700 (PDT)
Date:   Mon, 8 Jul 2019 11:09:20 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@us.ibm.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] RCU changes for v5.3
Message-ID: <20190708090920.GA16500@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest core-rcu-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-rcu-for-linus

   # HEAD: 83086d654dd08c0f57381522e6819f421677706e Merge branch 'for-mingo' of git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu into core/rcu

The changes in this cycle are:

 - RCU flavor consolidation cleanups and optmizations
 - Documentation updates
 - Miscellaneous fixes
 - SRCU updates
 - RCU-sync flavor consolidation
 - Torture-test updates
 - Linux-kernel memory-consistency-model updates, most notably the addition of plain C-language accesses

 Thanks,

	Ingo

------------------>
Alan Stern (7):
      tools/memory-model: Prepare for data-race detection
      tools/memory-model: Add definitions of plain and marked accesses
      tools/memory-model: Add data-race detection
      Documentation: atomic_t.txt: Explain ordering provided by smp_mb__{before,after}_atomic()
      tools/memory-model: Expand definition of barrier
      tools/memory-model: Change definition of rcu-fence
      tools/memory-model: Improve data-race detection

Andrea Parri (3):
      rcu: Don't return a value from rcu_assign_pointer()
      tools/memory-model: Fix comment in MP+poonceonces.litmus
      tools/memory-model: Do not use "herd" to refer to "herd7"

Jiang Biao (2):
      rcu: Remove unused rdp local from synchronize_rcu_expedited()
      rcu: Make __call_srcu static

Joel Fernandes (Google) (7):
      lockdep: Add assertion to check if in an interrupt
      rcu: Add checks for dynticks counters in rcu_is_cpu_rrupt_from_idle()
      doc/rcuref: Document real world examples in kernel
      srcu: Remove unused vmlinux srcu linker entries
      module: Make srcu_struct ptr array as read-only
      rcutorture: Select from only online CPUs
      rcutorture: Add cpu0 to the set of CPUs to add jitter

Neeraj Upadhyay (2):
      rcu: Dump specified number of blocked tasks
      rcu: Correctly unlock root node in rcu_check_gp_start_stall()

Oleg Nesterov (4):
      rcu/sync: Kill rcu_sync_type/gp_type
      uprobes: Use DEFINE_STATIC_PERCPU_RWSEM() to initialize dup_mmap_sem
      locking/percpu-rwsem: Add DEFINE_PERCPU_RWSEM(), use it to initialize cgroup_threadgroup_rwsem
      rcu/sync: Simplify the state machine

Paul E. McKenney (32):
      rcu: Check for wakeup-safe conditions in rcu_read_unlock_special()
      rcu: Only do rcu_read_unlock_special() wakeups if expedited
      rcu: Allow rcu_read_unlock_special() to raise_softirq() if in_irq()
      rcu: Use irq_work to get scheduler's attention in clean context
      rcu: Inline invoke_rcu_callbacks() into its sole remaining caller
      rcu: Avoid self-IPI in sync_rcu_exp_select_node_cpus()
      rcu: Avoid self-IPI in sync_sched_exp_online_cleanup()
      rcu: Rename rcu_data's ->deferred_qs to ->exp_deferred_qs
      rcu: Make kfree_rcu() ignore NULL pointers
      rcu: Set a maximum limit for back-to-back callback invocation
      doc: Remove ".vnet" from paulmck email addresses
      srcu: Allocate per-CPU data for DEFINE_SRCU() in modules
      rcutorture: Add cond_resched() to forward-progress free-up loop
      rcutorture: Fix stutter_wait() return value and freelist checks
      torture: Allow inter-stutter interval to be specified
      torture: Make kvm-find-errors.sh and kvm-recheck.sh provide exit status
      rcutorture: Provide rudimentary Makefile
      rcutorture: Exempt tasks RCU from timely draining of grace periods
      rcutorture: Exempt TREE01 from forward-progress testing
      rcutorture: Give the scheduler a chance on PREEMPT && NO_HZ_FULL kernels
      rcutorture: Halt forward-progress checks at end of run
      rcutorture: Add trivial RCU implementation
      torture: Capture qemu output
      torture: Add function graph-tracing cheat sheet
      torture: Run kernel build in source directory
      torture: Make --cpus override idleness calculations
      torture: Add --trust-make to suppress "make clean"
      rcutorture: Dump trace buffer for callback pipe drain failures
      torture: Suppress propagating trace_printk() warning
      rcutorture: Upper case solves the case of the vanishing NULL pointer
      rcu: Upgrade sync_exp_work_done() to smp_mb()
      rcu: Fix irritating whitespace error in rcu_assign_pointer()

Sebastian Andrzej Siewior (2):
      rcu: Enable elimination of Tree-RCU softirq processing
      rcutorture: Tweak kvm options

Waiman Long (1):
      rcu: Force inlining of rcu_read_lock()

Zhenzhong Duan (1):
      doc: Fixup definition of rcupdate.rcu_task_stall_timeout


 Documentation/RCU/rcuref.txt                       |  21 +-
 Documentation/RCU/stallwarn.txt                    |   2 +-
 Documentation/RCU/whatisRCU.txt                    |   8 +-
 Documentation/admin-guide/kernel-parameters.txt    |   6 +
 Documentation/atomic_t.txt                         |  17 +-
 Documentation/core-api/circular-buffers.rst        |   2 +-
 Documentation/memory-barriers.txt                  |   2 +-
 .../translations/ko_KR/memory-barriers.txt         |   2 +-
 include/linux/lockdep.h                            |   7 +
 include/linux/module.h                             |   5 +
 include/linux/percpu-rwsem.h                       |  10 +-
 include/linux/rcu_sync.h                           |  40 ++--
 include/linux/rcupdate.h                           |  21 +-
 include/linux/sched.h                              |   2 +-
 include/linux/srcutree.h                           |  14 +-
 include/linux/torture.h                            |   2 +-
 kernel/cgroup/cgroup.c                             |   3 +-
 kernel/events/uprobes.c                            |   4 +-
 kernel/locking/locktorture.c                       |   2 +-
 kernel/locking/percpu-rwsem.c                      |   2 +-
 kernel/module.c                                    |   5 +
 kernel/rcu/rcu.h                                   |   5 +
 kernel/rcu/rcutorture.c                            |  96 +++++++--
 kernel/rcu/srcutree.c                              |  69 ++++++-
 kernel/rcu/sync.c                                  | 214 ++++++++++-----------
 kernel/rcu/tree.c                                  | 164 +++++++++++++---
 kernel/rcu/tree.h                                  |   6 +-
 kernel/rcu/tree_exp.h                              |  53 +++--
 kernel/rcu/tree_plugin.h                           | 195 ++++++-------------
 kernel/rcu/tree_stall.h                            |   4 +-
 kernel/rcu/update.c                                |  13 ++
 kernel/torture.c                                   |  23 ++-
 tools/include/linux/rcu.h                          |   4 +-
 tools/memory-model/linux-kernel.bell               |   6 +
 tools/memory-model/linux-kernel.cat                | 102 +++++++---
 tools/memory-model/linux-kernel.def                |   1 +
 .../litmus-tests/MP+poonceonces.litmus             |   2 +-
 tools/memory-model/litmus-tests/README             |   2 +-
 tools/memory-model/lock.cat                        |   2 +-
 tools/memory-model/scripts/README                  |   4 +-
 tools/memory-model/scripts/checkalllitmus.sh       |   2 +-
 tools/memory-model/scripts/checklitmus.sh          |   2 +-
 tools/memory-model/scripts/parseargs.sh            |   2 +-
 tools/memory-model/scripts/runlitmushist.sh        |   2 +-
 tools/testing/radix-tree/linux/rcupdate.h          |   2 +-
 tools/testing/selftests/rcutorture/Makefile        |   3 +
 .../testing/selftests/rcutorture/bin/configinit.sh |  39 ++--
 tools/testing/selftests/rcutorture/bin/cpus2use.sh |   5 +
 .../testing/selftests/rcutorture/bin/functions.sh  |  13 +-
 tools/testing/selftests/rcutorture/bin/jitter.sh   |  13 +-
 .../testing/selftests/rcutorture/bin/kvm-build.sh  |   9 +-
 .../selftests/rcutorture/bin/kvm-find-errors.sh    |   3 +
 .../selftests/rcutorture/bin/kvm-recheck.sh        |  13 +-
 .../selftests/rcutorture/bin/kvm-test-1-run.sh     |  23 +--
 tools/testing/selftests/rcutorture/bin/kvm.sh      |  14 +-
 .../selftests/rcutorture/bin/parse-build.sh        |   2 +-
 .../selftests/rcutorture/bin/parse-console.sh      |   1 +
 .../selftests/rcutorture/configs/rcu/CFcommon      |   3 +
 .../selftests/rcutorture/configs/rcu/TREE01.boot   |   1 +
 .../selftests/rcutorture/configs/rcu/TRIVIAL       |  14 ++
 .../selftests/rcutorture/configs/rcu/TRIVIAL.boot  |   3 +
 61 files changed, 845 insertions(+), 466 deletions(-)
 create mode 100644 tools/testing/selftests/rcutorture/Makefile
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/TRIVIAL
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/TRIVIAL.boot

