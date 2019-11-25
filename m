Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85B05C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 10:53:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 450C120835
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 10:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574679214;
	bh=V14NOArA/s5fMBfFsdvOzqfNAFoRdPEIAndHi4VHWWY=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=BnW97jOQdWxCWW2jW9yZ01z/PjEsOpjvnu04g0C33jW0HpzpaGkTcu4h0lfngUzIF
	 dXaasE9dyT5Rpwzjz3SxnshLyT5PKY1JeojaRCtNqfYmivKYzyoi67HXnWmSegUd8E
	 lpoIidbacAui7q2PEpZbdACSD2eMwVtGg/NGTWS4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727566AbfKYKxc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 05:53:32 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43164 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727278AbfKYKxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 05:53:32 -0500
Received: by mail-wr1-f67.google.com with SMTP id n1so17396050wra.10
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 02:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=OkytE82UAIdwtzd0xcYfMKdQtZ+YdM4GF6oUgahQDKo=;
        b=my1UGmRxRmx0uNeVeQ7CrcRpk2E98unkN8UT4KfDyWJy4oWwE2aEg0fvd69lvduXYM
         aJw2zJc5neYbJkhwa4vuJiOZ6fBMWL2pmwo+7ArvMf+wEmBjXYGZbZ2Y4MJw7Lrj98Lv
         LlJOD9YOSY6/ReeoqxaZvWaUkRR/xAh875Tfe3INMw6jfKJNX5IGTJxHkqmoufupsGSx
         mzPE2SCbygUz0mcWgVYAiWPtWVcBrZHe0Sp6KUXB58v/Om81akfJtPAczfsM3Js84d2b
         dQwogE1pJ0L4HE9R0jXQ6hw9y5EgWvH4Pq3KcAvFPKRMtkCT+/fyQK8ubMVOKlRx2BJy
         bzcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=OkytE82UAIdwtzd0xcYfMKdQtZ+YdM4GF6oUgahQDKo=;
        b=c+BG0bRDGY/SzPtQy2V1URewKpo6rxYYVFZgU62ce3TvlCTZucYQMV1WK2LxblHXjB
         S+VcWbHBK9++t5NtbV/L0h9/zwAU9Ib4qxz92ToCyequPKqVh/eSnlEf9LJ0Ujei69jm
         +Q1B5Oy2IDfoqAgfOE+GNmw8EhhGxI70NOx8nBJKIG299xpR9/3UPnYBiCLrSh9cZx5X
         /hAFJM63V1ZdR5Biivgb3xEeEyi/f+r2aJCTyQkM8iSHz+52VbZnC9Aq5QFR92OXfsgU
         q6Cpl0KgZJBcR9RevdvR4Esap7FpM7M4GBhCn88Ys3Nt+h5n5YlbxvPAhzd3L0WapJ4b
         9d+A==
X-Gm-Message-State: APjAAAWJvrjIsmgAT5GasvvwhOIgR8B0rO4I4uyw/4+IXaiO6gkxj+h/
        h6O/jvtCe3Vi3foAYJ7smJs=
X-Google-Smtp-Source: APXvYqyKRbMRKZc5IeJ04imSv0UChi+6cQZCdYw5sIeewh1ipXwtD82sn7WqlhRpvVkO9XTeuaA2Rw==
X-Received: by 2002:adf:f18c:: with SMTP id h12mr31284604wro.122.1574679209084;
        Mon, 25 Nov 2019 02:53:29 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id k18sm10157738wrm.82.2019.11.25.02.53.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 02:53:28 -0800 (PST)
Date:   Mon, 25 Nov 2019 11:53:26 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] RCU changes for v5.5
Message-ID: <20191125105326.GA20115@gmail.com>
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

   # HEAD: 43e0ae7ae0f567a3f8c10ec7a4078bc482660921 Merge branch 'for-mingo' of git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu into core/rcu

The main changes in this cycle were:

  - Dynamic tick (nohz) updates, perhaps most notably changes to
    force the tick on when needed due to lengthy in-kernel execution
    on CPUs on which RCU is waiting.
    
  - Linux-kernel memory consistency model updates.

  - Replace rcu_swap_protected() with rcu_prepace_pointer().
    
  - Torture-test updates.
   
  - Documentation updates.
    
  - Miscellaneous fixes.

 Thanks,

	Ingo

------------------>
Alan Stern (4):
      tools/memory-model: Fix data race detection for unordered store and load
      tools/memory-model/Documentation: Fix typos in explanation.txt
      tools/memory-model/Documentation: Put redefinition of rcu-fence into explanation.txt
      tools/memory-model/Documentation: Add plain accesses and data races to explanation.txt

Chuhong Yuan (1):
      locktorture: Replace strncmp() with str_has_prefix()

Dan Carpenter (1):
      rcu: Fix uninitialized variable in nocb_gp_wait()

Ethan Hansen (3):
      rcu: Remove unused function rcutorture_record_progress()
      rcu: Remove unused variable rcu_perf_writer_state
      rcu: Remove unused function hlist_bl_del_init_rcu()

Frederic Weisbecker (1):
      nohz: Add TICK_DEP_BIT_RCU

Joel Fernandes (Google) (10):
      rcu: Reset CPU hints when reporting a quiescent state
      Revert docs from "rcu: Restore barrier() to rcu_read_lock() and rcu_read_unlock()"
      Revert docs from "treewide: Rename rcu_dereference_raw_notrace() to _check()"
      docs: rcu: Correct links referring to titles
      docs: rcu: Increase toctree to 3
      Restore docs "treewide: Rename rcu_dereference_raw_notrace() to _check()"
      Restore docs "rcu: Restore barrier() to rcu_read_lock() and rcu_read_unlock()"
      doc: Update list_for_each_entry_rcu() documentation
      workqueue: Convert for_each_wq to use built-in list check
      rcu: Ensure that ->rcu_urgent_qs is set before resched IPI

Mauro Carvalho Chehab (1):
      docs: rcu: convert some articles from html to ReST

Paul E. McKenney (27):
      time: Export tick start/stop functions for rcutorture
      rcu: Force on tick when invoking lots of callbacks
      rcutorture: Force on tick for readers and callback flooders
      stop_machine: Provide RCU quiescent state in multi_cpu_stop()
      rcu: Make CPU-hotplug removal operations enable tick
      rcutorture: Emulate dyntick aspect of userspace nohz_full sojourn
      rcutorture: Remove CONFIG_HOTPLUG_CPU=n from scenarios
      rcutorture: Separate warnings for each failure type
      rcutorture: Make in-kernel-loop testing more brutal
      rcu: Force tick on for nohz_full CPUs not reaching quiescent states
      rcu: Force nohz_full tick on upon irq enter instead of exit
      rcu: Confine ->core_needs_qs accesses to the corresponding CPU
      rcu: Make kernel-mode nohz_full CPUs invoke the RCU core processing
      rcu: Remove obsolete descriptions for rcu_barrier tracepoint
      rcu: Update descriptions for rcu_nocb_wake tracepoint
      rcu: Update descriptions for rcu_future_grace_period tracepoint
      rcu: Suppress levelspread uninitialized messages
      rcu: Upgrade rcu_swap_protected() to rcu_replace_pointer()
      x86/kvm/pmu: Replace rcu_swap_protected() with rcu_replace_pointer()
      drm/i915: Replace rcu_swap_protected() with rcu_replace_pointer()
      drivers/scsi: Replace rcu_swap_protected() with rcu_replace_pointer()
      fs/afs: Replace rcu_swap_protected() with rcu_replace_pointer()
      bpf/cgroup: Replace rcu_swap_protected() with rcu_replace_pointer()
      net/core: Replace rcu_swap_protected() with rcu_replace_pointer()
      net/netfilter: Replace rcu_swap_protected() with rcu_replace_pointer()
      net/sched: Replace rcu_swap_protected() with rcu_replace_pointer()
      security/safesetid: Replace rcu_swap_protected() with rcu_replace_pointer()

Sebastian Andrzej Siewior (1):
      Documentation: Rename rcu_node_context_switch() to rcu_note_context_switch()

Wolfgang M. Reimer (1):
      locking: locktorture: Do not include rwlock.h directly

kbuild test robot (1):
      rcu: Several rcu_segcblist functions can be static


 .../Design/Data-Structures/Data-Structures.html    | 1391 --------
 .../RCU/Design/Data-Structures/Data-Structures.rst | 1163 +++++++
 .../Expedited-Grace-Periods.html                   |  668 ----
 .../Expedited-Grace-Periods.rst                    |  521 +++
 .../Design/Memory-Ordering/Tree-RCU-Diagram.html   |    9 -
 .../Memory-Ordering/Tree-RCU-Memory-Ordering.html  |  704 ----
 .../Memory-Ordering/Tree-RCU-Memory-Ordering.rst   |  624 ++++
 .../RCU/Design/Memory-Ordering/TreeRCU-gp.svg      |    2 +-
 .../RCU/Design/Memory-Ordering/TreeRCU-qs.svg      |    2 +-
 .../RCU/Design/Requirements/Requirements.html      | 3401 --------------------
 .../RCU/Design/Requirements/Requirements.rst       | 2704 ++++++++++++++++
 Documentation/RCU/index.rst                        |    7 +-
 Documentation/RCU/lockdep.txt                      |   18 +-
 Documentation/RCU/whatisRCU.txt                    |   14 +-
 arch/x86/kvm/pmu.c                                 |    4 +-
 drivers/gpu/drm/i915/gem/i915_gem_context.c        |    2 +-
 drivers/scsi/scsi.c                                |    4 +-
 drivers/scsi/scsi_sysfs.c                          |    8 +-
 fs/afs/vl_list.c                                   |    4 +-
 include/linux/rculist_bl.h                         |   28 -
 include/linux/rcupdate.h                           |   18 +
 include/linux/rcutiny.h                            |    1 +
 include/linux/rcutree.h                            |    1 +
 include/linux/tick.h                               |    7 +-
 include/trace/events/rcu.h                         |   47 +-
 include/trace/events/timer.h                       |    3 +-
 kernel/bpf/cgroup.c                                |    4 +-
 kernel/locking/locktorture.c                       |    9 +-
 kernel/rcu/rcu.h                                   |    4 +-
 kernel/rcu/rcu_segcblist.c                         |    6 +-
 kernel/rcu/rcuperf.c                               |   16 -
 kernel/rcu/rcutorture.c                            |   44 +-
 kernel/rcu/tree.c                                  |   73 +-
 kernel/rcu/tree.h                                  |    1 +
 kernel/rcu/tree_plugin.h                           |    2 +-
 kernel/stop_machine.c                              |    1 +
 kernel/time/tick-sched.c                           |   11 +
 kernel/workqueue.c                                 |   10 +-
 net/core/dev.c                                     |    4 +-
 net/core/sock_reuseport.c                          |    4 +-
 net/netfilter/nf_tables_api.c                      |    5 +-
 net/sched/act_api.c                                |    2 +-
 net/sched/act_csum.c                               |    4 +-
 net/sched/act_ct.c                                 |    3 +-
 net/sched/act_ctinfo.c                             |    4 +-
 net/sched/act_ife.c                                |    2 +-
 net/sched/act_mirred.c                             |    4 +-
 net/sched/act_mpls.c                               |    2 +-
 net/sched/act_police.c                             |    6 +-
 net/sched/act_sample.c                             |    4 +-
 net/sched/act_skbedit.c                            |    4 +-
 net/sched/act_tunnel_key.c                         |    4 +-
 net/sched/act_vlan.c                               |    2 +-
 security/safesetid/securityfs.c                    |    4 +-
 tools/memory-model/Documentation/explanation.txt   |  602 +++-
 tools/memory-model/linux-kernel.cat                |    2 +-
 .../selftests/rcutorture/configs/rcu/TASKS03       |    3 -
 .../selftests/rcutorture/configs/rcu/TREE02        |    3 -
 .../selftests/rcutorture/configs/rcu/TREE04        |    3 -
 .../selftests/rcutorture/configs/rcu/TREE06        |    3 -
 .../selftests/rcutorture/configs/rcu/TREE08        |    3 -
 .../selftests/rcutorture/configs/rcu/TREE09        |    3 -
 .../selftests/rcutorture/configs/rcu/TRIVIAL       |    3 -
 .../selftests/rcutorture/doc/TREE_RCU-kconfig.txt  |    1 -
 64 files changed, 5830 insertions(+), 6390 deletions(-)
 delete mode 100644 Documentation/RCU/Design/Data-Structures/Data-Structures.html
 create mode 100644 Documentation/RCU/Design/Data-Structures/Data-Structures.rst
 delete mode 100644 Documentation/RCU/Design/Expedited-Grace-Periods/Expedited-Grace-Periods.html
 create mode 100644 Documentation/RCU/Design/Expedited-Grace-Periods/Expedited-Grace-Periods.rst
 delete mode 100644 Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Diagram.html
 delete mode 100644 Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.html
 create mode 100644 Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
 delete mode 100644 Documentation/RCU/Design/Requirements/Requirements.html
 create mode 100644 Documentation/RCU/Design/Requirements/Requirements.rst
