Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAA2BC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 12:03:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86EC2206DD
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 12:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551787389;
	bh=/4C1OcASGxkHY+gH0UrqgvWskVcljWU4NXk9QWULjqw=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=NbxJ58zodthSKHGgTv/Tj/25H/LFMJqe50wrecCH0LNYtklJks8TpBIxrA5ZZ71Ya
	 bD3fTycNXkUUYDx7LWJYcYfcPU2m3fQcvKzKaqPuwbizd9rZo8iWCOZee3ZIw7RpRI
	 HglEj8sVAjC7GdS1J21eYLnypKUky9mzPoJBFzOY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbfCEMDI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 07:03:08 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39567 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728009AbfCEMDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 07:03:07 -0500
Received: by mail-wm1-f67.google.com with SMTP id z84so2278461wmg.4
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2019 04:03:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=JEzyc1MaoL7ST0GWsr0oLukVZHkXWX6U1Dsp3uKwCt8=;
        b=szisdr80DFtVV+VRJSRg7dIeODoAkYygszOqC/TslPFwOFTR8ahLj7RE/bMzUYvLZ9
         AENGxGkll5B9p6STOxtexEqXmmqSRi8DhdDgq9nDpLCRNka/SoMcR4GPOurCS4AdmG69
         s/BJvPVWa96XoEDeyg33xcAH1OwWAFJiFrK2HpFEHi5fs5e3HIXiPO3dQ9cu/Efmq9rB
         JCKqlcNVNosi/WIG+KGsfO/fktcty/BNEQYJrKU1Z27mwpbK49+8NvsU8+iezegAuN/+
         G+oN6wMK5VwxmWT85NrQJEdwfIZOeSGRxLfDmTq+A0ZHUpFaKLx2YWw5oAxsTOf3tHj/
         zlvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=JEzyc1MaoL7ST0GWsr0oLukVZHkXWX6U1Dsp3uKwCt8=;
        b=s1IRUzttKhP652C2BTt7/wAarHoTkVciADTSj/T/FTlxZbc3SDgBbclVF5UOk05GFo
         WLjbWH0jKRAR8eHvsrn+VNpGF3bzy98fpaReE+vyxgz0nyKY+lLNTLzg1eO65Sa9pimt
         bpJOBGQHyeEVS/6wVdjkKkWD5MKhmgXA02s6jjTV29WkFFei8WiaUdyq9fVM0XlMgkAD
         +WxV+AJLgUMkEZMkalNm9zqVvSdBdhbIqNa1qAiKoA6D9rIYUHDMKk/g3JCAGXkGqrQb
         DO/03wlTLGWlCDLGXmQBbt8qXjQL9hTqr3pTH8REfgu6KABBM7n0eemnCaFnlUhzkg50
         7nWw==
X-Gm-Message-State: APjAAAV2glW9wUwx+YEttcc6lZcnJZIuc87qthKvF9tX8DZTPw3Vt9qI
        /v4KD9Grf9kqN9kgjih5LpYwyv4D
X-Google-Smtp-Source: APXvYqz9qb1KnEY2isQPS+qvAir1eJsO9tbzRyWoWoyaLBwqyjaFemReU3xRV+NnuyRffPWjfiMP8g==
X-Received: by 2002:a1c:7d8c:: with SMTP id y134mr2661817wmc.102.1551787384751;
        Tue, 05 Mar 2019 04:03:04 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id k20sm10412951wre.41.2019.03.05.04.03.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Mar 2019 04:03:03 -0800 (PST)
Date:   Tue, 5 Mar 2019 13:03:01 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@us.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] RCU updates for v5.1
Message-ID: <20190305120301.GA93284@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest core-rcu-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-rcu-for-linus

   # HEAD: cae45e1c6c541283a1bd155aa7b0a57e353b4df4 Merge branch 'rcu-next' of git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu into core/rcu

The main RCU related changes in this cycle were:

 - Additional cleanups after RCU flavor consolidation
 - Grace-period forward-progress cleanups and improvements
 - Documentation updates
 - Miscellaneous fixes
 - spin_is_locked() conversions to lockdep
 - SPDX changes to RCU source and header files
 - SRCU updates
 - Torture-test updates, including nolibc updates and moving
   nolibc to tools/include

 Thanks,

	Ingo

------------------>
Andrea Parri (1):
      tools/memory-model: Model smp_mb__after_unlock_lock()

Joel Fernandes (Google) (1):
      rcu: Add sparse check to rcu_assign_pointer()

Junchang Wang (2):
      doc: Fix outdated links
      RCU/torture.txt: Remove section MODULE PARAMETERS

Paul E. McKenney (59):
      tools/memory-model: Add scripts to check github litmus tests
      tools/memory-model: Make scripts take "-j" abbreviation for "--jobs"
      sched: Replace call_rcu_sched() with call_rcu()
      sched: Replace synchronize_sched() with synchronize_rcu()
      rcu: Rename and comment changes due to only one rcuo kthread per CPU
      rcu: Make expedited IPI handler return after handling critical section
      rcu: Inline force_quiescent_state() into rcu_force_quiescent_state()
      rcu: Eliminate RCU_BH_FLAVOR and RCU_SCHED_FLAVOR
      rcu: Inline rcu_kthread_do_work() into its sole remaining caller
      rcu: Determine expedited-GP IPI handler at build time
      rcu: Consolidate PREEMPT and !PREEMPT synchronize_rcu_expedited()
      rcu: Consolidate PREEMPT and !PREEMPT synchronize_rcu()
      rcu: Inline _synchronize_rcu_expedited() into synchronize_rcu_expedited()
      rcu: Discard separate per-CPU callback counts
      rcu: Remove wrapper definitions for obsolete RCU update functions
      rcu: Accommodate zero jiffies_till_first_fqs and kthread kicking
      rcu: Move rcu_cpu_kthread_task to rcu_data structure
      rcu: Move rcu_cpu_kthread_status to rcu_data structure
      rcu: Remove unused rcu_cpu_kthread_loops per-CPU variable
      rcu: Move rcu_cpu_has_work to rcu_data structure
      rcu: Remove unused rcu_cpu_kthread_cpu per-CPU variable
      rcu: Update NOCB comments
      rcu: Improve diagnostics for failed RCU grace-period start
      rcu: Protect rcu_check_gp_kthread_starvation() access to ->gp_flags
      rcu: Add sysrq rcu_node-dump capability
      doc: Now jiffies_till_sched_qs solicits help from cond_resched()
      doc: CPU-hotplug notifiers cannot invoke synchronize_srcu() or srcu_barrier()
      rcu: Docbook for rcu_head_init() and rcu_head_after_call_rcu()
      rcu: Rename rcu_check_callbacks() to rcu_sched_clock_irq()
      rcu: Rename rcu_process_callbacks() to rcu_core() for Tree RCU
      rcu: Remove preemption disabling from expedited CPU selection
      rcu: Repair rcu_nmi_exit() docbook header
      rcu: Fix obsolete DYNTICK_IRQ_NONIDLE comment
      include/asm-generic: Remove spin_is_locked() comment
      virt/kvm: Replace spin_is_locked() with lockdep
      srcu: Check for invalid idx argument in srcu_read_unlock()
      rcutorture: Record grace periods in forward-progress histogram
      torture: Explain and simplify odd "for" loop in mkinitrd.sh
      rcutorture: Add grace period after CPU offline
      rcuperf: Stop abusing IS_ENABLED()
      rcu/rcu.h: Convert to SPDX license identifier
      rcu/rcuperf: Convert to SPDX license identifier
      rcu/rcu_segcblist: Convert to SPDX license identifier
      rcu/rcutorture: Convert to SPDX license identifier
      rcu/srcu: Convert to SPDX license identifier
      rcu/sync: Convert to SPDX license identifier
      rcu/tiny: Convert to SPDX license identifier
      rcu/tree: Convert to SPDX license identifier
      rcu/update: Convert to SPDX license identifier
      linux/rcu_node_tree: Convert to SPDX license identifier
      linux/rcupdate: Convert to SPDX license identifier
      linux/rcu_segcblist: Convert to SPDX license identifier
      linux/rcu_sync: Convert to SPDX license identifier
      linux/rcutiny: Convert to SPDX license identifier
      linux/rcutree: Convert to SPDX license identifier
      linux/srcu: Convert to SPDX license identifier
      torture: Convert to SPDX license identifier
      linux/torture: Convert to SPDX license identifier
      locking/locktorture: Convert to SPDX license identifier

Sebastian Andrzej Siewior (1):
      srcu: Remove srcu_queue_delayed_work_on()

Willy Tarreau (5):
      rcutorture/nolibc: Fix the clobbered registers in the MIPS syscall definition
      rcutorture/nolibc: Fix some poor indentation and alignment
      rcutorture/nolibc: Add a bit of documentation to explain how to use nolibc
      tools headers: Move the nolibc header from rcutorture to tools/include/nolibc/
      MAINTAINERS: Add myself as the maintainer for the nolibc header file(s)

Zhang, Jun (2):
      rcu: Do RCU GP kthread self-wakeup from softirq and interrupt
      rcu: Prevent needless ->gp_seq_needed update in __note_gp_changes()


 .../Expedited-Grace-Periods/ExpSchedFlow.svg       |  18 +-
 .../Expedited-Grace-Periods.html                   |  26 +-
 .../Memory-Ordering/Tree-RCU-Memory-Ordering.html  |   6 +-
 .../TreeRCU-callback-invocation.svg                |   2 +-
 .../RCU/Design/Memory-Ordering/TreeRCU-gp.svg      |   8 +-
 .../RCU/Design/Memory-Ordering/TreeRCU-qs.svg      |   6 +-
 .../RCU/Design/Requirements/Requirements.html      |  20 +-
 Documentation/RCU/stallwarn.txt                    |  15 +-
 Documentation/RCU/torture.txt                      | 169 +------------
 Documentation/RCU/whatisRCU.txt                    |   4 +-
 Documentation/admin-guide/kernel-parameters.txt    |  32 ++-
 MAINTAINERS                                        |   6 +
 include/asm-generic/bug.h                          |   3 -
 include/linux/rcu_node_tree.h                      |  17 +-
 include/linux/rcu_segcblist.h                      |  17 +-
 include/linux/rcu_sync.h                           |  15 +-
 include/linux/rcupdate.h                           |  91 +------
 include/linux/rcutiny.h                            |  17 +-
 include/linux/rcutree.h                            |  19 +-
 include/linux/srcu.h                               |  18 +-
 include/linux/srcutiny.h                           |  17 +-
 include/linux/srcutree.h                           |  20 +-
 include/linux/torture.h                            |  20 +-
 kernel/locking/locktorture.c                       |  21 +-
 kernel/rcu/rcu.h                                   |  21 +-
 kernel/rcu/rcu_segcblist.c                         |  17 +-
 kernel/rcu/rcu_segcblist.h                         |  17 +-
 kernel/rcu/rcuperf.c                               |  27 +--
 kernel/rcu/rcutorture.c                            |  59 +++--
 kernel/rcu/srcutiny.c                              |  17 +-
 kernel/rcu/srcutree.c                              |  72 ++----
 kernel/rcu/sync.c                                  |  15 +-
 kernel/rcu/tiny.c                                  |  19 +-
 kernel/rcu/tree.c                                  | 267 +++++++++++++--------
 kernel/rcu/tree.h                                  |  53 ++--
 kernel/rcu/tree_exp.h                              | 201 ++++++----------
 kernel/rcu/tree_plugin.h                           | 238 +++++-------------
 kernel/rcu/update.c                                |  17 +-
 kernel/sched/cpufreq.c                             |   4 +-
 kernel/sched/cpufreq_schedutil.c                   |   2 +-
 kernel/sched/sched.h                               |   2 +-
 kernel/sched/topology.c                            |   4 +-
 kernel/time/timer.c                                |   2 +-
 kernel/torture.c                                   |  25 +-
 .../rcutorture/bin => include/nolibc}/nolibc.h     | 118 +++++++--
 tools/memory-model/.gitignore                      |   1 +
 tools/memory-model/README                          |   2 +
 tools/memory-model/linux-kernel.bell               |   3 +-
 tools/memory-model/linux-kernel.cat                |   4 +-
 tools/memory-model/linux-kernel.def                |   1 +
 tools/memory-model/scripts/README                  |  70 ++++++
 tools/memory-model/scripts/checkalllitmus.sh       |  53 ++--
 tools/memory-model/scripts/checkghlitmus.sh        |  65 +++++
 tools/memory-model/scripts/checklitmus.sh          |  74 +-----
 tools/memory-model/scripts/checklitmushist.sh      |  60 +++++
 tools/memory-model/scripts/cmplitmushist.sh        |  87 +++++++
 tools/memory-model/scripts/initlitmushist.sh       |  68 ++++++
 tools/memory-model/scripts/judgelitmus.sh          |  78 ++++++
 tools/memory-model/scripts/newlitmushist.sh        |  61 +++++
 tools/memory-model/scripts/parseargs.sh            | 136 +++++++++++
 tools/memory-model/scripts/runlitmushist.sh        |  87 +++++++
 tools/testing/selftests/rcutorture/bin/mkinitrd.sh |  27 ++-
 virt/kvm/kvm_main.c                                |   2 +-
 63 files changed, 1395 insertions(+), 1268 deletions(-)
 rename tools/{testing/selftests/rcutorture/bin => include/nolibc}/nolibc.h (94%)
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
