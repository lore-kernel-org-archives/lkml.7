Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2764FC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 12:59:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7C6F2053B
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 12:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574686791;
	bh=baidOzCXO6IdE2Fig3o53W/KpunMulZQGdVLJct36fQ=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=ScaXWW3gF9Ojc0tSg/HvxqsMwR5oLn5AvLe1ojyxMNYh2gkPWZ0A/TWDRXSn7U+o7
	 vU/Lu+eVRa/tukKQxA1MMEbwcvv1XF4zGxHEYdrHr1r2IQcEnaw32bdFDpzwukQPjH
	 r3UacbRTQsykiMVtVCwbx57DgQoeoZCTTfA4kCk4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727299AbfKYM7u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 07:59:50 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54508 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbfKYM7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 07:59:49 -0500
Received: by mail-wm1-f65.google.com with SMTP id b11so5898007wmj.4
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 04:59:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=yw839dhwZFyMUYw9/2uCgotqVjToQsaaRUJoGdH3uqI=;
        b=SNtNe7r1PHsV1Oqp94IjkFR9sBfZVXlevmh44+33YMooyqMA2uD0VgNYwbYcUQ+ib5
         b8pDtktHF5X1cA0+tNLvaZYX+BQ9BXWMEKSeDnfi4QJcP25KT268zzJKZbdEghq5iyHU
         DeWJq6C/3r0mvcng1RDQ89SDeWKwWBf1Grwy1HjHBNDO5sJQkQa3ra52JhsppXYxakl6
         INtqi5uRshRYypa4mDGJiJn+hquwlApwcdUlMZGkIPfsc7exAV6ZBaqTIju9lsa7gpYg
         sfU1ipLnT+V7w+CIkEsph29anmLODE41L/peqPLdaiACayZJ+WjnxP7WwhpfnzD1sA7e
         6feQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=yw839dhwZFyMUYw9/2uCgotqVjToQsaaRUJoGdH3uqI=;
        b=Y6maKzphOsfwCnY0VhsMdZoMSoL7BzXdhcLBhhR/nHhWLOYsawUc+dvQe01nJSFEK+
         m++64QqnRZcAONxrDWo+WdzXaTmDGD5fcXWT97w14V9L4liShQITiDl2Jqber+fQzkDa
         5Gh8LEXUHDIX60PfXyiLWkGZAJFe8Py1gC38ZMOhugaVbPoCID3cByWvY6AOZsPKZXqw
         kAI8HnxoVliTuo7XbW5wsuFqsyoWnJphHSenlCN6wZFbIyoWYrUtzzgMaJHGWlMpGjLj
         GOr4iBYN5g+qZhANmv/As+YAHfi6hbyZsjLngP0Wi7VDRSBXVabPsqbw5IfcpzplGZI2
         Ky2Q==
X-Gm-Message-State: APjAAAU0kEXuqd1Hn2cacwPnW0588H4Jfw2+CIoIYlzPMDgRrjbxFUFK
        m1UBL54YrvfhxjFPPlpt7GE=
X-Google-Smtp-Source: APXvYqx3cMKekN0vX9vF9CrfZalHeq5GLkfS5Ih3B8Xb/38S8N4wxPDL7MH/rviE1c6gHNqBjslKNw==
X-Received: by 2002:a05:600c:218c:: with SMTP id e12mr28639401wme.30.1574686786883;
        Mon, 25 Nov 2019 04:59:46 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id q5sm8254846wmc.27.2019.11.25.04.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 04:59:46 -0800 (PST)
Date:   Mon, 25 Nov 2019 13:59:44 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Mel Gorman <mgorman@suse.de>, Ben Segall <bsegall@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: [GIT PULL] scheduler changes for v5.5
Message-ID: <20191125125944.GA22218@gmail.com>
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

   # HEAD: de881a341c4143650fa50ce95cf450a5c94faa9f Merge branch 'sched/rt' into sched/core, to pick up commit

The biggest changes in this cycle were:

 - Make kcpustat vtime aware (Frederic Weisbecker)

 - Rework the CFS load_balance() logic (Vincent Guittot)

 - Misc cleanups, smaller enhancements, fixes.

The load-balancing rework is the most intrusive change: it replaces the 
old heuristics that have become less meaningful after the introduction of 
the PELT metrics, with a grounds-up load-balancing algorithm.

As such it's not really an iterative series, but replaces the old 
load-balancing logic with the new one. We hope there are no performance 
regressions left - but statistically it's highly probable that there *is* 
going to be some workload that is hurting from these chnages. If so then 
we'd prefer to have a look at that workload and fix its scheduling, 
instead of reverting the changes.

 Thanks,

	Ingo

------------------>
Frederic Weisbecker (22):
      sched/cputime: Rename vtime_account_system() to vtime_account_kernel()
      sched/cputime: Spare a seqcount lock/unlock cycle on context switch
      sched/vtime: Record CPU under seqcount for kcpustat needs
      sched/cputime: Add vtime idle task state
      sched/cputime: Add vtime guest task state
      context_tracking: Remove context_tracking_active()
      context_tracking: Rename context_tracking_is_enabled() => context_tracking_enabled()
      context_tracking: Rename context_tracking_is_cpu_enabled() to context_tracking_enabled_this_cpu()
      context_tracking: Introduce context_tracking_enabled_cpu()
      sched/vtime: Rename vtime_accounting_cpu_enabled() to vtime_accounting_enabled_this_cpu()
      sched/vtime: Introduce vtime_accounting_enabled_cpu()
      context_tracking: Check static key on context_tracking_enabled_*cpu()
      sched/kcpustat: Introduce vtime-aware kcpustat accessor for CPUTIME_SYSTEM
      procfs: Use vtime aware kcpustat accessor to fetch CPUTIME_SYSTEM
      cpufreq: Use vtime aware kcpustat accessor to fetch CPUTIME_SYSTEM
      leds: Use vtime aware kcpustat accessor to fetch CPUTIME_SYSTEM
      sched/cputime: Support other fields on kcpustat_field()
      sched/vtime: Bring up complete kcpustat accessor
      procfs: Use all-in-one vtime aware kcpustat accessor
      cpufreq: Use vtime aware kcpustat accessors for user time
      leds: Use all-in-one vtime aware kcpustat accessor
      rackmeter: Use vtime aware kcpustat accessor

Patrick Bellasi (1):
      sched/fair/util_est: Implement faster ramp-up EWMA on utilization increases

Peter Zijlstra (6):
      sched/fair: Better document newidle_balance()
      sched/core: Make pick_next_task_idle() more consistent
      sched/core: Optimize pick_next_task()
      sched/core: Simplify sched_class::pick_next_task()
      sched/fair: Use mul_u32_u32()
      sched/core: Further clarify sched_class::set_next_task()

Srivatsa S. Bhat (VMware) (1):
      sched/Kconfig: Fix spelling mistake in user-visible help text

Valentin Schneider (2):
      sched/topology: Don't set SD_BALANCE_WAKE on cpuset domain relax
      sched/uclamp: Fix overzealous type replacement

Vincent Guittot (14):
      sched/fair: Clean up asym packing
      sched/fair: Rename sg_lb_stats::sum_nr_running to sum_h_nr_running
      sched/fair: Remove meaningless imbalance calculation
      sched/fair: Rework load_balance()
      sched/fair: Use rq->nr_running when balancing load
      sched/fair: Use load instead of runnable load in load_balance()
      sched/fair: Spread out tasks evenly when not overloaded
      sched/fair: Use utilization to select misfit task
      sched/fair: Use load instead of runnable load in wakeup path
      sched/fair: Optimize find_idlest_group()
      sched/fair: Rework find_idlest_group()
      sched/fair: Fix rework of find_idlest_group()
      sched/fair: Add comments for group_type and balancing at SD_NUMA level
      sched/cpufreq: Move the cfs_rq_util_change() call to cpufreq_update_util()


 arch/ia64/kernel/time.c                 |    4 +-
 arch/powerpc/kernel/time.c              |    6 +-
 arch/s390/kernel/vtime.c                |    4 +-
 arch/x86/entry/calling.h                |    2 +-
 drivers/cpufreq/cpufreq.c               |   17 +-
 drivers/cpufreq/cpufreq_governor.c      |    6 +-
 drivers/leds/trigger/ledtrig-activity.c |   14 +-
 drivers/macintosh/rack-meter.c          |    7 +-
 fs/proc/stat.c                          |   56 +-
 include/linux/context_tracking.h        |   30 +-
 include/linux/context_tracking_state.h  |   21 +-
 include/linux/kernel_stat.h             |   18 +
 include/linux/sched.h                   |    9 +-
 include/linux/tick.h                    |    2 +-
 include/linux/vtime.h                   |   59 +-
 kernel/Kconfig.preempt                  |    2 +-
 kernel/context_tracking.c               |    6 +-
 kernel/sched/core.c                     |   18 +-
 kernel/sched/cputime.c                  |  288 ++++++-
 kernel/sched/deadline.c                 |   12 +-
 kernel/sched/fair.c                     | 1437 +++++++++++++++++++------------
 kernel/sched/features.h                 |    1 +
 kernel/sched/idle.c                     |   10 +-
 kernel/sched/rt.c                       |   12 +-
 kernel/sched/sched.h                    |   25 +-
 kernel/sched/stop_task.c                |    9 +-
 kernel/sched/topology.c                 |    9 +-
 kernel/time/tick-sched.c                |    2 +-
 28 files changed, 1331 insertions(+), 755 deletions(-)
