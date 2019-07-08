Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D383AC606AC
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 11:53:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92DC220665
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 11:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562586836;
	bh=vYH3hjVR3EYQbIYtDmwT6EZI+ambUmWQAoInQAnAWFU=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=JZvzyXJ9xi7giR3xcOf4QlF/yB9kyPoT8u4cxaZvpgPXyJm6xi8pJN6QC5ZjSPwdo
	 uGFldQKH8yZGcewIO/MeUK8XHbKQL0I+kaXyjWbzrllnd5SgrpZcokpk9ohvTrBxeV
	 ugrb5BMdX66d1rFWXcsCgg2qifFUl64uI6wPaBK8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730615AbfGHLxz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 07:53:55 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34323 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbfGHLxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 07:53:54 -0400
Received: by mail-wm1-f66.google.com with SMTP id w9so12577085wmd.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 04:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=bXni40Fux6IMrzpRQIBARecp/8mb/LxrrORyekl12qY=;
        b=VzvIUvxD+7raqvLyAlj25MGu8ZT6jiw8ihkQSPJJLN13zqnXgISsgIqhSNBtwss28M
         wPVmyPX4NItJCmHYJW8wObjIXLEVK93g/ETiKxbut/8CyXyLDHPyQZHX6jXBPB04EpSb
         1jAUBYTKs8mYgD9YJkXXBF/xWUWt7edxmJS9/cpSV3fMuXo/bDZTsU059I83Uul6sjKg
         jG6WcXDYLFqCEUfRtCoq/tnrjUVrRoDgjsuc9P69PHqe6tNG6qtWDCnZPCYwMdyzETwM
         Q/nOqMqUMTGFTE3oYeBGb73GvN/S6m4Oy9X+njpCsky+xOvr5jBrwcqMy+Ofg2POOf8O
         Qlaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=bXni40Fux6IMrzpRQIBARecp/8mb/LxrrORyekl12qY=;
        b=GjElMZMuBSNs+nbLPsYT/C9v+bhlBcUKo+Ral7Ywniszc1fIuRu0dM6ytA7Jfe3o+C
         0tB8xFCJMZK+3lmdCXd08dVAfDmVql+jASm2LUAwYObZE/Dfet5xdwxmWu9JAOwbBh98
         zbzKx2S88nKCRrc6MKPZspzm8Sg3aop/xngtWPgL0j95Jbi69yA/rZa8BZxf1msrgeiC
         vW8mStACw8NqjYBibLmOEg67G74LdOLm3IkyT0qzFY6rm6QlPUljK6Pa3xwFTGe4EhTP
         fq4vHFCpq4n5CI9BbFAj5ZCtcX9IzPXrO/BjopT+leKVQ5DSbLCtsZQzMf3+B1ybqa/N
         wzHA==
X-Gm-Message-State: APjAAAUy895vjP+DA0AX/xPm2yHvsf4W1GgdGJJzmL4Vbon05tmml84i
        PzkzGqzslz7RDKDqpyMphvs=
X-Google-Smtp-Source: APXvYqw+FjZxyg8kk6nLT142L5y4STDpd5wfFnkq1wxUZtG/BU0is89qy2/XwgVSKs/iF+K/rKL9NA==
X-Received: by 2002:a1c:d10c:: with SMTP id i12mr16738585wmg.152.1562586831980;
        Mon, 08 Jul 2019 04:53:51 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id 4sm5235403wro.78.2019.07.08.04.53.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 08 Jul 2019 04:53:51 -0700 (PDT)
Date:   Mon, 8 Jul 2019 13:53:49 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] scheduler changes for v5.3
Message-ID: <20190708115349.GA14779@gmail.com>
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

   # HEAD: af24bde8df2029f067dc46aff0393c8f18ff6e2f sched/uclamp: Add uclamp support to energy_compute()

The main changes in this cycle were:

 - Remove the unused per rq load array and all its infrastructure,
   by Dietmar Eggemann.

 - Add utilization clamping support by Patrick Bellasi. This is a 
   refinement of the energy aware scheduling framework with support for 
   boosting of interactive and capping of background workloads: to make 
   sure critical GUI threads get maximum frequency ASAP, and to make sure 
   background processing doesn't unnecessarily move to cpufreq governor 
   to higher frequencies and less energy efficient CPU modes.

 - Add the bare minimum of tracepoints required for LISA EAS regression 
   testing, by Qais Yousef - which allows automated testing of various 
   power management features, including energy aware scheduling.

 - Restructure the former tsk_nr_cpus_allowed() facility that the -rt 
   kernel used to modify the scheduler's CPU affinity logic such as 
   migrate_disable() - introduce the task->cpus_ptr value instead of 
   taking the address of &task->cpus_allowed directly - by Sebastian
   Andrzej Siewior.

 - Misc optimizations, fixes, cleanups and small enhancements - see the 
   Git log for details.

 Thanks,

	Ingo

------------------>
Dietmar Eggemann (8):
      sched/fair: Remove rq->load
      sched/fair: Remove the rq->cpu_load[] update code
      sched/fair: Replace source_load() & target_load() with weighted_cpuload()
      sched/debug: Remove sd->*_idx range on sysctl
      sched/core: Remove rq->cpu_load[]
      sched/core: Remove sd->*_idx
      sched/fair: Remove sgs->sum_weighted_load
      sched/fair: Rename weighted_cpuload() to cpu_runnable_load()

Gao Xiang (1):
      sched/core: Add __sched tag for io_schedule()

Patrick Bellasi (11):
      sched/uclamp: Add CPU's clamp buckets refcounting
      sched/uclamp: Add bucket local max tracking
      sched/uclamp: Enforce last task's UCLAMP_MAX
      sched/uclamp: Add system default clamps
      sched/core: Allow sched_setattr() to use the current policy
      sched/uclamp: Extend sched_setattr() to support utilization clamping
      sched/uclamp: Reset uclamp values on RESET_ON_FORK
      sched/uclamp: Set default clamps for RT tasks
      sched/cpufreq, sched/uclamp: Add clamps for FAIR and RT tasks
      sched/uclamp: Add uclamp_util_with()
      sched/uclamp: Add uclamp support to energy_compute()

Pavel Begunkov (1):
      sched/wait: Deduplicate code with do-while

Peter Zijlstra (1):
      sched/core: Optimize try_to_wake_up() for local wakeups

Qais Yousef (6):
      sched/autogroup: Make autogroup_path() always available
      sched/debug: Add a new sched_trace_*() helper functions
      sched/debug: Add new tracepoints to track PELT at rq level
      sched/debug: Add new tracepoint to track PELT at se level
      sched/debug: Add sched_overutilized tracepoint
      sched/debug: Export the newly added tracepoints

Qian Cai (1):
      sched/fair: Fix "runnable_avg_yN_inv" not used warnings

Sebastian Andrzej Siewior (1):
      sched/core: Provide a pointer to the valid CPU mask

Valentin Schneider (1):
      sched/fair: Clean up definition of NOHZ blocked load functions

Vincent Guittot (1):
      sched/topology: Remove unused 'sd' parameter from arch_scale_cpu_capacity()

bsegall@google.com (1):
      sched/fair: Don't push cfs_bandwith slack timers forward


 Documentation/scheduler/sched-pelt.c       |   3 +-
 arch/arm/kernel/topology.c                 |   2 +-
 arch/ia64/kernel/mca.c                     |   2 +-
 arch/mips/include/asm/switch_to.h          |   4 +-
 arch/mips/kernel/mips-mt-fpaff.c           |   2 +-
 arch/mips/kernel/traps.c                   |   6 +-
 arch/powerpc/platforms/cell/spufs/sched.c  |   2 +-
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c  |   2 +-
 drivers/base/arch_topology.c               |   6 +-
 drivers/infiniband/hw/hfi1/affinity.c      |   6 +-
 drivers/infiniband/hw/hfi1/sdma.c          |   3 +-
 drivers/infiniband/hw/qib/qib_file_ops.c   |   7 +-
 fs/proc/array.c                            |   4 +-
 include/linux/arch_topology.h              |   2 +-
 include/linux/energy_model.h               |   2 +-
 include/linux/log2.h                       |  34 ++
 include/linux/sched.h                      |  79 +++-
 include/linux/sched/nohz.h                 |   8 -
 include/linux/sched/sysctl.h               |  11 +
 include/linux/sched/topology.h             |  25 +-
 include/trace/events/sched.h               |  31 ++
 include/uapi/linux/sched.h                 |  14 +-
 include/uapi/linux/sched/types.h           |  66 ++-
 init/Kconfig                               |  53 +++
 init/init_task.c                           |   3 +-
 kernel/cgroup/cpuset.c                     |   2 +-
 kernel/fork.c                              |   2 +
 kernel/power/energy_model.c                |   2 +-
 kernel/sched/autogroup.c                   |   2 -
 kernel/sched/core.c                        | 533 ++++++++++++++++++++++--
 kernel/sched/cpudeadline.c                 |   4 +-
 kernel/sched/cpufreq_schedutil.c           |  24 +-
 kernel/sched/cpupri.c                      |   4 +-
 kernel/sched/deadline.c                    |   8 +-
 kernel/sched/debug.c                       |  43 +-
 kernel/sched/fair.c                        | 623 ++++++++++-------------------
 kernel/sched/features.h                    |   1 -
 kernel/sched/pelt.c                        |  13 +-
 kernel/sched/pelt.h                        |   2 +-
 kernel/sched/rt.c                          |   8 +-
 kernel/sched/sched-pelt.h                  |   2 +-
 kernel/sched/sched.h                       | 134 +++++--
 kernel/sched/topology.c                    |  18 +-
 kernel/sched/wait.c                        |   8 +-
 kernel/sysctl.c                            |  16 +
 kernel/time/tick-sched.c                   |   2 -
 kernel/trace/trace_hwlat.c                 |   2 +-
 lib/smp_processor_id.c                     |   2 +-
 samples/trace_events/trace-events-sample.c |   2 +-
 49 files changed, 1216 insertions(+), 618 deletions(-)
