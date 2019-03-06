Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F7EDC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 07:44:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21B912064A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 07:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551858259;
	bh=TVbDoomyHHLtS3BZA80sGyRGqT2kuy/23Eb/hGrVcrM=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=hxOoCs58k6h+YGnL4cGI3OSks5IWBCju9pXnUO/xNSEZBxLuhFVOeJtDePx/TatjE
	 VZCwb4Yl5qkKyiTSRw0Y49qhKlCZgGuuZSm0+2h8OEJ767rMJYF1DrbFuDPixgH5O5
	 oNalCV961ntb28vzXHo+QIxLpww8IzqaIP4K/ocE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729503AbfCFHoR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 02:44:17 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55776 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729067AbfCFHoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 02:44:17 -0500
Received: by mail-wm1-f67.google.com with SMTP id q187so4895541wme.5
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2019 23:44:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=7eAXCNJkswADxusRlxQ8Dk5iVBGl8y/jvyOYHiLQ/FI=;
        b=MZzy18WcnQb9NTzENe0/NBEXErRR1AtMUfyR4P7yNxx7LN09UJqclV6Mm9XrGPxA6R
         nnj+nNLZMu8gbvM/9fIY/LKlYZqZOOxNvi09RTdbHH+ncXlaqdD1f1TvywZmyHr3Nl7s
         PN7q00XzsQGlMzy/vn0FGuHltyAUAWmg+2UR0+C027adhhxPb+VWLZTerJm1r2SX4+RR
         i7RA/fk6b0+WKcY+uADPmXGO7u88s9bdEvGU5zOWYyHU2Y2mW8qz62kSxLaxND4PWjpo
         WULxdikL4Z9tjZjYj0j7jN3Ac+Z4VwaXpI59nv28re0z2mI5AOVoPiARO5z+bxrDcO/u
         bROQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=7eAXCNJkswADxusRlxQ8Dk5iVBGl8y/jvyOYHiLQ/FI=;
        b=N26bvHBS3dZH4AZtFm3IzgMmrmZOz8Rfx5TFPHBfaOQnRfh30GXg9iJo44eZ/PjUVt
         ALk/V/EgqSX5H6OMofl/IxH14kP9dT/M0mQIgT4S0nUNWIdMlZ49DySJ2OIIYRbftiWF
         5eteqMg5tXmzUltUQ1cuLV6lHf9Pg637FTb8gaXfYbBk+MAFxJnYTsaL9O6tEqqsK9u+
         kt8il8a2tBZAvlX+uBrQSKKwSRlz1xTgdD9RlHRFaKdjn0F7tmQHYsj3jNVrSvTE8mKr
         q0hd2nRymsc0IC1KKV/fkawB5v3048qRjWlA+lboiuto83ed8SEVLalPCOVvjWgTy/Jz
         anyQ==
X-Gm-Message-State: APjAAAXmoMnMGHG7wMhOmG3Wadrbfl6/wfGAN7b2yYBd5Kis23zkVLi8
        mxYqZlr7XRXyYtEcBrAKfA8=
X-Google-Smtp-Source: APXvYqyE/KKNZ6ZaJhZ3sNv0yCv1CeppVyjOF8epc2JkXq3NNY9NucxWFIlCjG7dl6LPJa3qC+JZCA==
X-Received: by 2002:a7b:c94c:: with SMTP id i12mr1401338wml.2.1551858254172;
        Tue, 05 Mar 2019 23:44:14 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id w4sm1278848wmg.8.2019.03.05.23.44.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Mar 2019 23:44:13 -0800 (PST)
Date:   Wed, 6 Mar 2019 08:44:11 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] scheduler updates for v5.1
Message-ID: <20190306074411.GA21345@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest sched-core-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-core-for-linus

   # HEAD: ad01423aedaa7c6dd62d560b73a3cb39e6da3901 kthread: Do not use TIMER_IRQSAFE

The main changes in this cycle were:

 - refcount conversions

 - Solve the rq->leaf_cfs_rq_list can of worms for real.

 - improve power-aware scheduling

 - add sysctl knob for Energy Aware Scheduling

 - documentation updates

 - misc other changes

 Thanks,

	Ingo

------------------>
Andrea Parri (1):
      sched/core: Use READ_ONCE()/WRITE_ONCE() in move_queued_task()/task_rq_lock()

Dietmar Eggemann (1):
      sched/fair: Simplify post_init_entity_util_avg() by calling it with a task_struct pointer argument

Elena Reshetova (5):
      sched/core: Convert sighand_struct.count to refcount_t
      sched/core: Convert signal_struct.sigcnt to refcount_t
      sched/fair: Convert numa_group.refcount to refcount_t
      sched/core: Convert task_struct.usage to refcount_t
      sched/core: Convert task_struct.stack_refcount to refcount_t

Hidetoshi Seto (1):
      sched/debug: Initialize sd_sysctl_cpus if !CONFIG_CPUMASK_OFFSTACK

Hugo Lefeuvre (1):
      sched/wait: Use freezable_schedule() when possible

Julia Cartwright (1):
      kthread: Convert worker lock to raw spinlock

Luc Van Oostenryck (1):
      sched/topology: Fix percpu data types in struct sd_data & struct s_data

Lukas Bulwahn (1):
      MAINTAINERS, sched: Drop PREEMPTIBLE KERNEL section entry

Peter Zijlstra (3):
      sched/core: Give DCE a fighting chance
      sched/fair: Robustify CFS-bandwidth timer locking
      sched/fair: Add tmp_alone_branch assertion

Quentin Perret (3):
      sched/topology: Introduce a sysctl for Energy Aware Scheduling
      PM/EM: Document the Energy Model framework
      sched/doc: Document Energy Aware Scheduling

Sebastian Andrzej Siewior (1):
      kthread: Do not use TIMER_IRQSAFE

Thomas Gleixner (1):
      sched: Remove stale PF_MUTEX_TESTER bit

Valentin Schneider (3):
      sched/fair: Simplify nohz_balancer_kick()
      sched/fair: Explain LLC nohz kick condition
      sched/fair: Prune, fix and simplify the nohz_balancer_kick() comment block

Vincent Guittot (9):
      sched/fair: Trigger asym_packing during idle load balance
      sched/fair: Fix rounding bug for asym packing
      sched/fair: Fix unnecessary increase of balance interval
      sched/fair: Move the rq_of() helper function
      sched/fair: Update scale invariance of PELT
      sched/pelt: Skip updating util_est when utilization is higher than CPU's capacity
      sched/fair: Fix insertion in rq->leaf_cfs_rq_list
      sched/fair: Optimize update_blocked_averages()
      sched/fair: Fix O(nr_cgroups) in the load balancing path

Viresh Kumar (2):
      sched/fair: Remove unused 'sd' parameter from select_idle_smt()
      sched/fair: Use non-atomic cpumask_{set,clear}_cpu()


 Documentation/power/energy-model.txt     | 144 ++++++++++
 Documentation/scheduler/sched-energy.txt | 425 ++++++++++++++++++++++++++++
 Documentation/sysctl/kernel.txt          |  12 +
 MAINTAINERS                              |   9 +-
 fs/exec.c                                |   4 +-
 fs/proc/task_nommu.c                     |   2 +-
 include/linux/init_task.h                |   1 +
 include/linux/kthread.h                  |   9 +-
 include/linux/sched.h                    |  33 +--
 include/linux/sched/signal.h             |   5 +-
 include/linux/sched/sysctl.h             |   7 +
 include/linux/sched/task.h               |   4 +-
 include/linux/sched/task_stack.h         |   2 +-
 include/linux/sched/topology.h           |   8 +-
 include/linux/wait.h                     |   6 +-
 init/init_task.c                         |   6 +-
 kernel/fork.c                            |  24 +-
 kernel/kthread.c                         |  43 +--
 kernel/sched/core.c                      |  12 +-
 kernel/sched/deadline.c                  |   6 +-
 kernel/sched/debug.c                     |   4 +
 kernel/sched/fair.c                      | 458 ++++++++++++++++++-------------
 kernel/sched/isolation.c                 |   2 +-
 kernel/sched/pelt.c                      |  45 +--
 kernel/sched/pelt.h                      | 114 +++++++-
 kernel/sched/rt.c                        |   6 +-
 kernel/sched/sched.h                     |  54 +++-
 kernel/sched/topology.c                  |  33 ++-
 kernel/sysctl.c                          |  11 +
 29 files changed, 1165 insertions(+), 324 deletions(-)
 create mode 100644 Documentation/power/energy-model.txt
 create mode 100644 Documentation/scheduler/sched-energy.txt
