Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63F59C49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 11:26:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22CCE2067B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 11:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568633210;
	bh=/SQ6nszME6DqMNxqX0+PBAFJlY4sYRndcEbo0dielu8=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=h3jM4ZpejauG2Fp4XB3KGdnYUYC7n86VrYFqzDwD24fYy01q/H3slQNQwqheYASrC
	 UKm96TWTtONLN2RIL73GECM83mJkW+SSxCbK+KU55sxK9O08whi+thZJ8+829OPcHG
	 +/GCJ2v3minkqe0tvSB9t5YrRlYvDgpr1DyhFZvo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730915AbfIPL0t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 07:26:49 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34593 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbfIPL0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 07:26:48 -0400
Received: by mail-wr1-f65.google.com with SMTP id a11so28696802wrx.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 04:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=hI7wK+SML3y/HNhZE9ifsf24oyGAL/7XMQjzf8xR46E=;
        b=oX2JSQEAIdOXJp0oKkuEncohGIF3z4g/YH5rDS5cSo5XTPdM3AYy8/sUonfzSOvwgD
         dBCProJCNjZEGRLrJrG/svJfAT5UBlHBRtEiR2XWSm+9jiCHTi0fB7bPfmLOidllfXR4
         E1pVoBcWMO/7XAI00V0Xs/9dl1j1x6uV7bcWhtD8aogwidKZPbbwh52wxU+nFhTpq59W
         Ja9LvtT7O+zfxaEsVQdwLxPD9MCry2BDch+YcjtIwtL1wgTt9gNgIhL5Qap17mY3LxPs
         viiVpPct6brTEFooZAZKxukIoRG0DZYA0UkMBCwZsPJpbwuSdBUrJYmAzsRWMjka347k
         TYtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=hI7wK+SML3y/HNhZE9ifsf24oyGAL/7XMQjzf8xR46E=;
        b=kA/3N/f8wdUclj/np706imIduFA/8OX6BNKL3tyR/MYz5YYYMsKMjoAEqGrOP+u/D4
         OMBtoiv13vstjkCQGJTWF7CPFIJLah2LGuGcRPaewKSTiMLsGnur/lAB47ORwJm5RsXh
         0z/ExMC3jx1amqegmVgY7iFTL8MtXoeLjiwt57D5Op92PDEoYRp/H22Z4G457QJMGDAZ
         SumHHDdAvoZjb0Saix7MDf/0t3ctfuQO3PuyEOTcv6M95rHJLkmM9R01Ciw0ibDMO6q0
         k1D9iSpIvxY3iIN/7wS2jxP+cPes+J32dwGSmyXCNzH7yHcaa9H4FyRnI4vjSQNlAnuv
         JG1w==
X-Gm-Message-State: APjAAAVZPidmi+YiEGPAP8wVoyQn9y0Y5Nr7UOQpC8wqwg969tEXjXEU
        J8D+MLVGO/W517R5IGiQ34g=
X-Google-Smtp-Source: APXvYqxbW7LZpLJwpiTlWA5H7e65ij2BvaQ9cTjW2WSFTZim7uTh6tROv3WXMLHT/07oC0rP4Ev9bw==
X-Received: by 2002:a5d:4146:: with SMTP id c6mr28829791wrq.205.1568633204037;
        Mon, 16 Sep 2019 04:26:44 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id 189sm28370737wma.6.2019.09.16.04.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 04:26:43 -0700 (PDT)
Date:   Mon, 16 Sep 2019 13:26:41 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@us.ibm.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] RCU changes for v5.4
Message-ID: <20190916112641.GA127977@gmail.com>
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

   # HEAD: 4a0fa886ab79ea85e8d1be2b0df143d8249779be Merge branch 'for-mingo' of git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu into core/rcu

This cycle's RCU changes were:

 - A few more RCU flavor consolidation cleanups.

 - Updates to RCU's list-traversal macros improving lockdep usability.

 - Forward-progress improvements for no-CBs CPUs: Avoid ignoring
   incoming callbacks during grace-period waits.

 - Forward-progress improvements for no-CBs CPUs: Use ->cblist
   structure to take advantage of others' grace periods.

 - Also added a small commit that avoids needlessly inflicting
   scheduler-clock ticks on callback-offloaded CPUs.

 - Forward-progress improvements for no-CBs CPUs: Reduce contention
   on ->nocb_lock guarding ->cblist.

 - Forward-progress improvements for no-CBs CPUs: Add ->nocb_bypass
   list to further reduce contention on ->nocb_lock guarding ->cblist.

 - Miscellaneous fixes.

 - Torture-test updates.

 - minor LKMM updates.

There's a linecount increase as a result of these changes:

 49 files changed, 1480 insertions(+), 786 deletions(-)

Of the +~700 lines increase, roughly half are documentation and 
diagnostics, the other half new code such as better queueing latencies 
for no-CBs CPUs.

Note that a somewhat non-standard merge commit slipped into the LKMM 
portions:

  07f038a408fb: Merge LKMM and RCU commits

We'll use a more standard merge commit format in the future.

 Thanks,

	Ingo

------------------>
Andrea Parri (2):
      tools/memory-model: Update the informal documentation
      MAINTAINERS: Update e-mail address for Andrea Parri

Byungchul Park (1):
      rcu: Change return type of rcu_spawn_one_boost_kthread()

Christoph Hellwig (1):
      rcu: Don't include <linux/ktime.h> in rcutiny.h

Denis Efremov (1):
      torture: Remove exporting of internal functions

Eric Dumazet (1):
      rcu: Allow rcu_do_batch() to dynamically adjust batch sizes

Joel Fernandes (Google) (11):
      rcu: Simplify rcu_note_context_switch exit from critical section
      treewide: Rename rcu_dereference_raw_notrace() to _check()
      rcu: Remove redundant debug_locks check in rcu_read_lock_sched_held()
      rcuperf: Make rcuperf kernel test more robust for !expedited mode
      tools/memory-model: Use cumul-fence instead of fence in ->prop example
      rcu: Add support for consolidated-RCU reader checking
      rcu/sync: Remove custom check for RCU readers
      ipv4: Add lockdep condition to fix for_each_entry()
      driver/core: Convert to use built-in RCU list checking
      x86/pci: Pass lockdep condition to pcm_mmcfg_list iterator
      acpi: Use built-in RCU list checking for acpi_ioremaps list

Mukesh Ojha (1):
      rcu: Fix spelling mistake "greate"->"great"

Paul E. McKenney (66):
      tools/memory-model: Make scripts be executable
      rcu: Simplify rcu_read_unlock_special() deferred wakeups
      rcu: Make rcu_read_unlock_special() checks match raise_softirq_irqoff()
      lockdep: Make print_lock() address visible
      time/tick-broadcast: Fix tick_broadcast_offline() lockdep complaint
      rcu: Restore barrier() to rcu_read_lock() and rcu_read_unlock()
      rcu: Add kernel parameter to dump trace after RCU CPU stall warning
      rcu: Add destroy_work_on_stack() to match INIT_WORK_ONSTACK()
      srcu: Avoid srcutorture security-based pointer obfuscation
      doc: Add rcutree.kthread_prio pointer to stallwarn.txt
      torture: Expand last_ts variable in kvm-test-1-run.sh
      rcutorture: Test TREE03 with the threadirqs kernel boot parameter
      rcutorture: Emulate userspace sojourn during call_rcu() floods
      rcutorture: Aggressive forward-progress tests shouldn't block shutdown
      rcu: Remove redundant "if" condition from rcu_gp_is_expedited()
      arm: Use common outgoing-CPU-notification code
      rcu/nocb: Rename rcu_data fields to prepare for forward-progress work
      rcu/nocb: Update comments to prepare for forward-progress work
      rcu/nocb: Provide separate no-CBs grace-period kthreads
      rcu/nocb: Rename nocb_follower_wait() to nocb_cb_wait()
      rcu/nocb: Rename wake_nocb_leader() to wake_nocb_gp()
      rcu/nocb: Rename __wake_nocb_leader() to __wake_nocb_gp()
      rcu/nocb: Rename wake_nocb_leader_defer() to wake_nocb_gp_defer()
      rcu/nocb: Rename rcu_organize_nocb_kthreads() local variable
      rcu/nocb: Rename and document no-CB CB kthread sleep trace event
      rcu/nocb: Rename rcu_nocb_leader_stride kernel boot parameter
      rcu/nocb: Print gp/cb kthread hierarchy if dump_tree
      rcu/nocb: Use separate flag to indicate disabled ->cblist
      rcu/nocb: Use separate flag to indicate offloaded ->cblist
      rcu/nocb: Add checks for offloaded callback processing
      rcu/nocb: Make rcutree_migrate_callbacks() start at leaf rcu_node structure
      rcu/nocb: Check for deferred nocb wakeups before nohz_full early exit
      rcu/nocb: Remove deferred wakeup checks for extended quiescent states
      rcu/nocb: Allow lockless use of rcu_segcblist_restempty()
      rcu/nocb: Allow lockless use of rcu_segcblist_empty()
      rcu/nocb: Leave ->cblist enabled for no-CBs CPUs
      rcu/nocb: Use rcu_segcblist for no-CBs CPUs
      rcu/nocb: Remove obsolete nocb_head and nocb_tail fields
      rcu/nocb: Remove obsolete nocb_q_count and nocb_q_count_lazy fields
      rcu/nocb: Remove obsolete nocb_cb_tail and nocb_cb_head fields
      rcu/nocb: Remove obsolete nocb_gp_head and nocb_gp_tail fields
      rcu/nocb: Use build-time no-CBs check in rcu_do_batch()
      rcu/nocb: Use build-time no-CBs check in rcu_core()
      rcu/nocb: Use build-time no-CBs check in rcu_pending()
      rcu/nocb: Suppress uninitialized false-positive in nocb_gp_wait()
      rcu/nohz: Turn off tick for offloaded CPUs
      rcu/nocb: Enable re-awakening under high callback load
      rcu/nocb: Never downgrade ->nocb_defer_wakeup in wake_nocb_gp_defer()
      rcu/nocb: Make __call_rcu_nocb_wake() safe for many callbacks
      rcu/nocb: Avoid needless wakeups of no-CBs grace-period kthread
      rcu/nocb: Avoid ->nocb_lock capture by corresponding CPU
      rcu/nocb: Round down for number of no-CBs grace-period kthreads
      rcu/nocb: Reduce contention at no-CBs registry-time CB advancement
      rcu/nocb: Reduce contention at no-CBs invocation-done time
      rcu/nocb: Reduce ->nocb_lock contention with separate ->nocb_gp_lock
      rcu/nocb: Unconditionally advance and wake for excessive CBs
      rcu/nocb: Atomic ->len field in rcu_segcblist structure
      rcu/nocb: Add bypass callback queueing
      rcu/nocb: EXP Check use and usefulness of ->nocb_lock_contended
      rcu/nocb: Print no-CBs diagnostics when rcutorture writer unduly delayed
      rcu/nocb: Avoid synchronous wakeup in __call_rcu_nocb_wake()
      rcu/nocb: Advance CBs after merge in rcutree_migrate_callbacks()
      rcu/nocb: Reduce nocb_cb_wait() leaf rcu_node ->lock contention
      rcu/nocb: Reduce __call_rcu_nocb_wake() leaf rcu_node ->lock contention
      rcu/nocb: Don't wake no-CBs GP kthread if timer posted under overload
      MAINTAINERS: Update from paulmck@linux.ibm.com to paulmck@kernel.org

Peter Zijlstra (1):
      idle: Prevent late-arriving interrupts from disrupting offline

Xiao Yang (1):
      rcuperf: Fix perf_type module-parameter description


 .../RCU/Design/Requirements/Requirements.html      |   73 +-
 Documentation/RCU/stallwarn.txt                    |    6 +
 Documentation/admin-guide/kernel-parameters.txt    |   17 +-
 MAINTAINERS                                        |   16 +-
 arch/arm/kernel/smp.c                              |    6 +-
 arch/powerpc/include/asm/kvm_book3s_64.h           |    2 +-
 arch/x86/pci/mmconfig-shared.c                     |    5 +-
 drivers/acpi/osl.c                                 |    6 +-
 drivers/base/base.h                                |    1 +
 drivers/base/core.c                                |   12 +
 drivers/base/power/runtime.c                       |   15 +-
 include/linux/rcu_segcblist.h                      |    9 +
 include/linux/rcu_sync.h                           |    4 +-
 include/linux/rculist.h                            |   36 +-
 include/linux/rcupdate.h                           |    9 +-
 include/linux/rcutiny.h                            |    2 +-
 include/trace/events/rcu.h                         |    4 +-
 kernel/locking/lockdep.c                           |    2 +-
 kernel/rcu/Kconfig.debug                           |   11 +
 kernel/rcu/rcu.h                                   |    1 +
 kernel/rcu/rcu_segcblist.c                         |  174 ++-
 kernel/rcu/rcu_segcblist.h                         |   54 +-
 kernel/rcu/rcuperf.c                               |   10 +-
 kernel/rcu/rcutorture.c                            |   30 +-
 kernel/rcu/srcutree.c                              |    5 +-
 kernel/rcu/tree.c                                  |  205 ++--
 kernel/rcu/tree.h                                  |   81 +-
 kernel/rcu/tree_exp.h                              |    8 +-
 kernel/rcu/tree_plugin.h                           | 1195 ++++++++++++--------
 kernel/rcu/tree_stall.h                            |    9 +
 kernel/rcu/update.c                                |  105 +-
 kernel/sched/core.c                                |   57 +-
 kernel/sched/idle.c                                |    5 +-
 kernel/torture.c                                   |    2 -
 kernel/trace/ftrace_internal.h                     |    8 +-
 kernel/trace/trace.c                               |    4 +-
 net/ipv4/fib_frontend.c                            |    3 +-
 tools/memory-model/Documentation/explanation.txt   |   53 +-
 tools/memory-model/README                          |   18 +-
 tools/memory-model/scripts/checkghlitmus.sh        |    0
 tools/memory-model/scripts/checklitmushist.sh      |    0
 tools/memory-model/scripts/cmplitmushist.sh        |    0
 tools/memory-model/scripts/initlitmushist.sh       |    0
 tools/memory-model/scripts/judgelitmus.sh          |    0
 tools/memory-model/scripts/newlitmushist.sh        |    0
 tools/memory-model/scripts/parseargs.sh            |    0
 tools/memory-model/scripts/runlitmushist.sh        |    0
 .../selftests/rcutorture/bin/kvm-test-1-run.sh     |    2 +-
 .../selftests/rcutorture/configs/rcu/TREE03.boot   |    1 +
 49 files changed, 1480 insertions(+), 786 deletions(-)
 mode change 100644 => 100755 tools/memory-model/scripts/checkghlitmus.sh
 mode change 100644 => 100755 tools/memory-model/scripts/checklitmushist.sh
 mode change 100644 => 100755 tools/memory-model/scripts/cmplitmushist.sh
 mode change 100644 => 100755 tools/memory-model/scripts/initlitmushist.sh
 mode change 100644 => 100755 tools/memory-model/scripts/judgelitmus.sh
 mode change 100644 => 100755 tools/memory-model/scripts/newlitmushist.sh
 mode change 100644 => 100755 tools/memory-model/scripts/parseargs.sh
 mode change 100644 => 100755 tools/memory-model/scripts/runlitmushist.sh

