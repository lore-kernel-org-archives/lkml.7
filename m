Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0616C49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 12:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DD08214D9
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 12:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568637054;
	bh=objby5c89ZJ+ChbNO6hjFDc9hy7aomWzniGfjaty52o=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=eT3+OAr8o2jHrw8t7Ti4cB9BH8fA1KSuwIDDkq7UiBbmGMMvhLuVRWIAvB2eQa479
	 wqAiGdELeyqU9YRKJ++6jeuGwv4L21lSkQZ9amZjn7grBTgBZq3PDvxpt9QyJjgCLP
	 0ahyNey61aS/JrpszlT8E7HRlXbHRD1Jl3/KtQrE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732624AbfIPMax (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 08:30:53 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39883 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726930AbfIPMax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 08:30:53 -0400
Received: by mail-wr1-f67.google.com with SMTP id r3so8534418wrj.6
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 05:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=hMxXlh9zFLUfJBiAx98gGeK6kgAShuI4peDjRPtRM1c=;
        b=S7dTE9jiJX5hhQk0YS+X0BdXK3IFumIOUDWn6l/Xqq9RbIBhgwFMsoB4zHJubcYobI
         g6+Ky6PTegQkiih/AwSx+4+9yafgxdVG7ZxTLRqaDokJYGkt5oBqXIPaifMCDJaLw7pA
         KgrYOZ6yOqjdXmbBpJRTQ5DIXZqd2x5U3IJ1pA3ZZ2NRaIEiXl49Lq6y0Gs/549kFniN
         y+Z3IaOMpYSSksyr6CzyeHA3HBH6h+oTJ9Zyy5bvku40tug1PwQZ5tR6mKfWkmKzQ8I2
         vT+lobI2X1p/jJg9T28iRT5LiNi5qcZ4MFSJDneV3eUzD+lKFFHl+r3BHxIuFz8EHntC
         8RTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=hMxXlh9zFLUfJBiAx98gGeK6kgAShuI4peDjRPtRM1c=;
        b=fs1tR8e2Kj1GjCMicB3NTuVRSWMz3RpihKIqvPq0cS/3OWHbNJialUJ/tIALOvNJ18
         fj/+Y68URf2tFAaQKFXsxN8h7HahvJWaDyZUGpZyLQ14OJH/vgWa7arQD6FspcXBXyNH
         yVyUZo39yP7xrBLvNRb3X3CSs/qorJw4qa9iTfA75N/z1l63u7FgGR48ekcL8AY8Nmpk
         qESgZlC8qIh92arqCfTA/PNFyu/FSB2xv1MP3OxHZGRVd/T6FxHoOwrnJjcZgwHymYQ+
         YLBNB+fv9pw0HeyJKSBP53qx7zd121g8trPJXyAkYYtXOaOEk84A/z+KE+U+eWbBv43D
         sdeg==
X-Gm-Message-State: APjAAAUEqkwsKvysxTrpQ/tLnUhkVzwHZSxIbskjcdxQvOKRqoqjBlFf
        XU4CpKmikajkIrWiYlvUywg=
X-Google-Smtp-Source: APXvYqymBDb/uadD6Beg/iwZ2ztPqhr9/dBWBnIvcTQeePH4BRMm3F4ADpEJS1PaEbG6OKZkkFFSDA==
X-Received: by 2002:a5d:4ed0:: with SMTP id s16mr10345150wrv.248.1568637050256;
        Mon, 16 Sep 2019 05:30:50 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id o12sm15032359wrm.23.2019.09.16.05.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 05:30:49 -0700 (PDT)
Date:   Mon, 16 Sep 2019 14:30:47 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>
Subject: [GIT PULL] scheduler changes for v5.4
Message-ID: <20190916123047.GA102572@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest sched-core-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-core-for-linus

   # HEAD: 563c4f85f9f0d63b712081d5b4522152cdcb8b6b Merge branch 'sched/rt' into sched/core, to pick up -rt changes

The main changes in this cycle were:

 - MAINTAINERS: Add Mark Rutland as perf submaintainer, Juri Lelli and 
   Vincent Guittot as scheduler submaintainers. Add Dietmar Eggemann, 
   Steven Rostedt, Ben Segall and Mel Gorman as scheduler reviewers.

   As perf and the scheduler is getting bigger and more complex, document
   the status quo of current responsibilities and interests, and spread
   the review pain^H^H^H^H fun via an increase in the Cc: linecount 
   generated by scripts/get_maintainer.pl. :-)

 - Add another series of patches that brings the -rt (PREEMPT_RT) tree 
   closer to mainline: split the monolithic CONFIG_PREEMPT dependencies 
   into a new CONFIG_PREEMPTION category that will allow the eventual 
   introduction of CONFIG_PREEMPT_RT. Still a few more hundred patches to 
   go though.

 - Extend the CPU cgroup controller with uclamp.min and uclamp.max to 
   allow the finer shaping of CPU bandwidth usage.

 - Micro-optimize energy-aware wake-ups from O(CPUS^2) to O(CPUS).

 - Improve the behavior of high CPU count, high thread count applications 
   running under cpu.cfs_quota_us constraints.

 - Improve balancing with SCHED_IDLE (SCHED_BATCH) tasks present.

 - Improve CPU isolation housekeeping CPU allocation NUMA locality.

 - Fix deadline scheduler bandwidth calculations and logic when cpusets 
   rebuilds the topology, or when it gets deadline-throttled while it's 
   being offlined.

 - Convert the cpuset_mutex to percpu_rwsem, to allow it to be used from 
   setscheduler() system calls without creating global serialization. Add 
   new synchronization between cpuset topology-changing events and the 
   deadline acceptance tests in setscheduler(), which were broken before.

 - Rework the active_mm state machine to be less confusing and more 
   optimal.

 - Rework (simplify) the pick_next_task() slowpath.

 - Improve load-balancing on AMD EPYC systems.

 - ... and misc cleanups, smaller fixes and improvements - please see the 
   Git log for more details.

 Thanks,

	Ingo

------------------>
Dave Chiluk (1):
      sched/fair: Fix low cpu usage with high throttling by removing expiration of cpu-local slices

Juri Lelli (6):
      sched/deadline: Fix bandwidth accounting at all levels after offline migration
      cgroup/cpuset: Convert cpuset_mutex to percpu_rwsem
      cgroup/cpuset: Change cpuset_rwsem and hotplug lock order
      rcu/tree: Call setschedule() gp ktread to SCHED_FIFO outside of atomic region
      sched/core: Prevent race condition between cpuset and __sched_setscheduler()
      sched/core: Fix CPU controller for !RT_GROUP_SCHED

Mathieu Poirier (3):
      sched/topology: Add partition_sched_domains_locked()
      sched/core: Streamle calls to task_rq_unlock()
      cpusets: Rebuild root domain deadline accounting information

Matt Fleming (2):
      arch, ia64: Make NUMA select SMP
      sched/topology: Improve load balancing on AMD EPYC systems

Matthew Wilcox (Oracle) (1):
      sched/core: Convert get_task_struct() to return the task

Miles Chen (1):
      sched/psi: Correct overly pessimistic size calculation

Patrick Bellasi (6):
      sched/uclamp: Extend CPU's cgroup controller
      sched/uclamp: Propagate parent clamps
      sched/uclamp: Propagate system defaults to the root group
      sched/uclamp: Use TG's clamps to restrict TASK's clamps
      sched/uclamp: Update CPU's refcount on TG's clamp changes
      sched/uclamp: Always use 'enum uclamp_id' for clamp_id values

Paul E. McKenney (1):
      time/tick-broadcast: Fix tick_broadcast_offline() lockdep complaint

Peter Zijlstra (11):
      rcu/tree: Fix SCHED_FIFO params
      sched: Clean up active_mm reference counting
      stop_machine: Fix stop_cpus_in_progress ordering
      sched: Fix kerneldoc comment for ia64_set_curr_task
      sched/{rt,deadline}: Fix set_next_task vs pick_next_task
      sched: Rework CPU hotplug task selection
      sched: Add task_struct pointer to sched_class::set_curr_task
      sched/fair: Expose newidle_balance()
      sched: Allow put_prev_task() to drop rq->lock
      sched: Rework pick_next_task() slow-path
      sched, perf: MAINTAINERS update, add submaintainers and reviewers

Phil Auld (1):
      sched/fair: Use rq_lock/unlock in online_fair_sched_group

Qais Yousef (1):
      cpufreq: schedutil: fix equation in comment

Qian Cai (1):
      sched/core: Silence a warning in sched_init()

Quentin Perret (1):
      sched/fair: Speed-up energy-aware wake-ups

Thomas Gleixner (8):
      sched/preempt: Use CONFIG_PREEMPTION where appropriate
      rcu: Use CONFIG_PREEMPTION
      locking/spinlocks: Use CONFIG_PREEMPTION
      tracing: Use CONFIG_PREEMPTION
      kprobes: Use CONFIG_PREEMPTION
      x86: Use CONFIG_PREEMPTION
      x86/dumpstack: Indicate PREEMPT_RT in dumps
      x86/kvm: Use CONFIG_PREEMPTION

Valentin Schneider (3):
      sched/fair: Move init_numa_balancing() below task_numa_work()
      sched/fair: Move task_numa_work() init to init_numa_balancing()
      sched/fair: Change task_numa_work() storage to static

Vincent Guittot (1):
      sched/fair: Fix imbalance due to CPU affinity

Viresh Kumar (3):
      sched/fair: Start tracking SCHED_IDLE tasks count in cfs_rq
      sched/fair: Fall back to sched-idle CPU if idle CPU isn't found
      sched/fair: Introduce fits_capacity()

Wanpeng Li (1):
      sched/isolation: Prefer housekeeping CPU in local node

Yi Wang (1):
      sched/stats: Fix unlikely() use of sched_info_on()


 Documentation/admin-guide/cgroup-v2.rst |  34 ++
 Documentation/scheduler/sched-bwc.rst   |  74 +++-
 MAINTAINERS                             |   7 +
 arch/Kconfig                            |   2 +-
 arch/ia64/Kconfig                       |   1 +
 arch/x86/entry/entry_32.S               |   6 +-
 arch/x86/entry/entry_64.S               |   4 +-
 arch/x86/entry/thunk_32.S               |   2 +-
 arch/x86/entry/thunk_64.S               |   4 +-
 arch/x86/include/asm/preempt.h          |   2 +-
 arch/x86/kernel/cpu/amd.c               |   5 +
 arch/x86/kernel/dumpstack.c             |   7 +-
 arch/x86/kernel/kprobes/core.c          |   2 +-
 arch/x86/kernel/kvm.c                   |   2 +-
 include/asm-generic/preempt.h           |   4 +-
 include/linux/cgroup.h                  |   1 +
 include/linux/cpuset.h                  |  13 +-
 include/linux/preempt.h                 |   6 +-
 include/linux/rcupdate.h                |   2 +-
 include/linux/rcutree.h                 |   2 +-
 include/linux/sched.h                   |  11 +-
 include/linux/sched/deadline.h          |   8 +
 include/linux/sched/task.h              |   6 +-
 include/linux/sched/topology.h          |  10 +
 include/linux/spinlock.h                |   2 +-
 include/linux/spinlock_api_smp.h        |   2 +-
 include/linux/topology.h                |  14 +
 include/linux/torture.h                 |   2 +-
 init/Kconfig                            |  22 ++
 init/init_task.c                        |   2 +-
 init/main.c                             |   2 +-
 kernel/cgroup/cgroup.c                  |   2 +-
 kernel/cgroup/cpuset.c                  | 163 +++++++--
 kernel/events/core.c                    |   9 +-
 kernel/irq/manage.c                     |   3 +-
 kernel/kprobes.c                        |   2 +-
 kernel/locking/rtmutex.c                |   6 +-
 kernel/rcu/Kconfig                      |   8 +-
 kernel/rcu/tree.c                       |  12 +-
 kernel/rcu/tree_stall.h                 |   6 +-
 kernel/sched/core.c                     | 618 ++++++++++++++++++++++++++------
 kernel/sched/cpufreq_schedutil.c        |   6 +-
 kernel/sched/deadline.c                 | 134 ++++---
 kernel/sched/fair.c                     | 409 ++++++++++-----------
 kernel/sched/idle.c                     |  31 +-
 kernel/sched/isolation.c                |  12 +-
 kernel/sched/psi.c                      |   2 +-
 kernel/sched/rt.c                       |  74 ++--
 kernel/sched/sched.h                    |  63 ++--
 kernel/sched/stats.h                    |   7 +-
 kernel/sched/stop_task.c                |  22 +-
 kernel/sched/topology.c                 |  53 ++-
 kernel/stop_machine.c                   |   2 +
 kernel/trace/Kconfig                    |   6 +-
 kernel/trace/ftrace.c                   |   2 +-
 kernel/trace/ring_buffer_benchmark.c    |   2 +-
 kernel/trace/trace_events.c             |   4 +-
 kernel/trace/trace_sched_wakeup.c       |   3 +-
 mm/khugepaged.c                         |   2 +-
 mm/page_alloc.c                         |   2 +-
 60 files changed, 1323 insertions(+), 603 deletions(-)
