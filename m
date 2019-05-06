Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42A18C04AAD
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 07:54:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06CA4205C9
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 07:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557129293;
	bh=e966b/1Yp4nQuGEnI4V04Sw8/MJ30UFDtvp6Z98+Ww0=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=QOUsOcdQZ5tZ36k9Qu4DJbBlITCwn6U+SvFR+y9Aoil5jiV3sxOufUp9raEUEo0JM
	 LW86DUTiuM6iYI50qpHx3tDYxIa9R3hAcGstNw35Nz89i3UAKtZRcU3e+Qjb3pTDSR
	 py4lqf1abv4tqoWvktmFdzc3DL8GToWsYydTXT1E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbfEFHyw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 03:54:52 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40685 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbfEFHyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 03:54:51 -0400
Received: by mail-wr1-f66.google.com with SMTP id h4so15961026wre.7
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 00:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=QlWMUpiN08ghkvNU0TNefIPOhRJaupR0mXEFeH2amdM=;
        b=ijIaYDS0QtyEIt8Tjjw15F1reiULP+q2Rnc2E3CI8ogHDEydWtuq+WOOCQTsY8JFRi
         cvf8Jn/VdY/j+UiiBiiddk5s9hErH1Mi8NpLwTNIy0fFpTDJ8cMGnryzwsF8aVU3B0ZA
         T8a7z4RJaPoo56XMrBoYhqZm/aKUpjLcs2EQKExpLgiYgq9syfskZYDKdHzI1DiwK3lZ
         1aXhdezYjx3CFbU3P6jj+vvR5R+ltKkOPml+K8NenisNHDVQOc1pHbFcN49CEJ9NZvkm
         yQG/85Z70mVHv5VhLAgJzrc2MKkQfbFa3oi2CpNsSIruIRut461+OVW8nyaVKbdBdKkz
         AzGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=QlWMUpiN08ghkvNU0TNefIPOhRJaupR0mXEFeH2amdM=;
        b=CvN91BA6jxWDiz/s0TobLiGFjxqsoYAy1gsJvd6hRa/oMGcYeYeaISdlnDDcl5FwwE
         56M+N16K7TghhSLqMwUn6c7A0G5bgJGLqIJqIokbZa+mO+xEZUXfhPaEDlUMrGsk/H7v
         JIlefBca0BPMqA3eWaKXsce/mwSMAPCMJ5gMLW2u0DTQkh1kvLsKAg31RZXeqaa9WLSu
         KyRvZ0PG1sUeMlVohEBXslxfXFzSVdYPCH1N0+pWSSAD3yutGChLCStgmZTEydGBvDzO
         ZjeZPxKJpW2JslfPm8buFp3Ur97GBf/kHdvSjkMGVfI+s+MUozo4L6aFMuITgKIGnxJ/
         fJ4Q==
X-Gm-Message-State: APjAAAU/N56GREFma1SEoLD6LD70DQay/douCY6ssIOd1yVzrGyBR1ZQ
        0hF42hmSr2F8c1gjtSPebz0=
X-Google-Smtp-Source: APXvYqx2iI6FAvxpVUhvDzHkXqCewoA0C3TZ8QVy5Gh+GTr7puO08A65GUazUVjeaIsTLgjTVJ0MSg==
X-Received: by 2002:adf:d4c8:: with SMTP id w8mr2920371wrk.2.1557129289152;
        Mon, 06 May 2019 00:54:49 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id z16sm7205079wrt.26.2019.05.06.00.54.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 May 2019 00:54:48 -0700 (PDT)
Date:   Mon, 6 May 2019 09:54:46 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@us.ibm.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] RCU changes for v5.2
Message-ID: <20190506075446.GA105636@gmail.com>
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

   # HEAD: 94e4dcc75a47253c75084524e15735585cd220a1 Merge branch 'for-mingo' of git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu into core/rcu

This cycles's RCU changes include:

  - A couple of straggling RCU flavor consolidation updates
  - SRCU updates
  - RCU CPU stall-warning updates
  - Torture-test updates
  - An LKMM commit adding support for synchronize_srcu_expedited()

  - Documentation updates
  - Miscellaneous fixes

 Thanks,

	Ingo

------------------>
Akira Yokosawa (1):
      rcu: Move common code out of if-else block

Alan Stern (4):
      tools/memory-model: Rename some RCU relations
      tools/memory-model: Refactor some RCU relations
      tools/memory-model: Add SRCU support
      tools/memory-model: Update Documentation/explanation.txt to include SRCU support

Andrea Parri (1):
      tools/memory-model: Avoid duplicating herdtools versions

Cyrill Gorcunov (1):
      rcu: rcu_qs -- Use raise_softirq_irqoff to not save irqs twice

Joel Fernandes (Google) (1):
      rcu: Avoid unnecessary softirq when system is idle

Liu Song (1):
      rcu: Set rcutree.kthread_prio sysfs access to read-only

Luc Maranget (1):
      tools/memory-model: Dynamically check SRCU lock-to-unlock matching

Neeraj Upadhyay (5):
      rcu: Fix self-wakeups for grace-period kthread
      rcu: Default jiffies_to_sched_qs to jiffies_till_sched_qs
      rcu: Do a single rhp->func read in rcu_head_after_call_rcu()
      rcu: Fix nohz status in stall warning
      rcutorture: Fix expected forward progress duration in OOM notifier

Paul E. McKenney (37):
      tools/memory-model: Update README for addition of SRCU
      doc: Remove obsolete RCU update functions from RCU documentation
      doc: Describe choice of rcu_dereference() APIs and __rcu usage
      doc: Fix typos and otherwise modernize checklist.txt
      rcu: Unconditionally expedite during suspend/hibernate
      rcu: Make exit_rcu() handle non-preempted RCU readers
      MAINTAINERS: RCU now has its own email list
      MAINTAINERS: Add -rcu branch name ("dev")
      rcu: Allow rcu_nocbs= to specify all CPUs
      rcu: Report error for bad rcu_nocbs= parameter values
      rcu: Update jiffies_to_sched_qs and adjust_jiffies_till_sched_qs() comments
      rcu: Eliminate redundant NULL-pointer check
      rcu: Fix typo in tree_exp.h comment
      rcu: Correct READ_ONCE()/WRITE_ONCE() for ->rcu_read_unlock_special
      srcu: Check for in-flight callbacks in _cleanup_srcu_struct()
      srcu: Remove cleanup_srcu_struct_quiesced()
      rcu: Move RCU CPU stall-warning code out of update.c
      rcu: Move RCU CPU stall-warning code out of tree_plugin.h
      rcu: Move RCU CPU stall-warning code out of tree.c
      rcu: Inline RCU task stall-warning helper functions
      rcu: Move rcu_print_task_exp_stall() to tree_exp.h
      rcu: Inline RCU stall-warning info helper functions
      rcu: Move FAST_NO_HZ stall-warning code to tree_stall.h
      rcu: Organize functions in tree_stall.h
      rcu: Move irq-disabled stall-warning checking to tree_stall.h
      rcu: Move forward-progress checkers into tree_stall.h
      torture: Don't try to offline the last CPU
      tools/.../rcutorture: Convert to SPDX license identifier
      rcutorture: Make rcutorture_extend_mask() comment match the code
      rcutorture: Remove ->ext_irq_conflict field
      rcutorture: Fix cleanup path for invalid torture_type strings
      rcuperf: Fix cleanup path for invalid perf_type strings
      locktorture: NULL cxt.lwsa and cxt.lrsa to allow bad-arg detection
      torture: Suppress false-positive CONFIG_INITRAMFS_SOURCE complaint
      doc/kprobes: Update obsolete RCU update functions
      tools/memory-model: Add support for synchronize_srcu_expedited()
      net/ipv4/netfilter: Update comment from call_rcu_bh() to call_rcu()

Peter Zijlstra (1):
      Documentation/atomic_t: Clarify signed vs unsigned

SeongJae Park (2):
      sched/Documentation/kokr: Update Korean translation to update wake_up() & co. memory-barrier guarantees
      locking/memory-barriers/kokr: Update Korean translation to replace smp_cond_acquire() with smp_cond_load_acquire()

Tycho Andersen (1):
      doc: Repair some whitespace damage

Zhouyi Zhou (1):
      rcu: Fix force_qs_rnp() header comment


 .../Design/Data-Structures/Data-Structures.html    |   3 +-
 .../Expedited-Grace-Periods.html                   |   4 +-
 .../Memory-Ordering/Tree-RCU-Memory-Ordering.html  |   5 +-
 Documentation/RCU/NMI-RCU.txt                      |  13 +-
 Documentation/RCU/UP.txt                           |   6 +-
 Documentation/RCU/checklist.txt                    |  91 ++-
 Documentation/RCU/rcu.txt                          |   8 +-
 Documentation/RCU/rcu_dereference.txt              | 103 +++
 Documentation/RCU/rcubarrier.txt                   |  27 +-
 Documentation/RCU/whatisRCU.txt                    |  10 +-
 Documentation/admin-guide/kernel-parameters.txt    |   4 +-
 Documentation/atomic_t.txt                         |  17 +
 Documentation/kprobes.txt                          |   6 +-
 .../translations/ko_KR/memory-barriers.txt         |  49 +-
 MAINTAINERS                                        |  16 +-
 drivers/nvme/host/core.c                           |   2 +-
 include/linux/rcupdate.h                           |   6 +-
 include/linux/srcu.h                               |  36 +-
 kernel/locking/locktorture.c                       |   2 +
 kernel/rcu/rcu.h                                   |   1 +
 kernel/rcu/rcuperf.c                               |   5 +
 kernel/rcu/rcutorture.c                            |  21 +-
 kernel/rcu/srcutiny.c                              |   9 +-
 kernel/rcu/srcutree.c                              |  32 +-
 kernel/rcu/tiny.c                                  |   2 +-
 kernel/rcu/tree.c                                  | 508 +--------------
 kernel/rcu/tree.h                                  |  14 +-
 kernel/rcu/tree_exp.h                              |  36 +-
 kernel/rcu/tree_plugin.h                           | 257 +-------
 kernel/rcu/tree_stall.h                            | 709 +++++++++++++++++++++
 kernel/rcu/update.c                                |  59 +-
 kernel/torture.c                                   |   2 +
 net/ipv4/netfilter/ipt_CLUSTERIP.c                 |   2 +-
 tools/memory-model/Documentation/explanation.txt   | 289 +++++----
 tools/memory-model/README                          |  33 +-
 tools/memory-model/linux-kernel.bell               |  35 +-
 tools/memory-model/linux-kernel.cat                |  39 +-
 tools/memory-model/linux-kernel.def                |   6 +
 tools/memory-model/lock.cat                        |   3 -
 .../selftests/rcutorture/bin/configNR_CPUS.sh      |  17 +-
 .../selftests/rcutorture/bin/config_override.sh    |  17 +-
 .../selftests/rcutorture/bin/configcheck.sh        |  19 +-
 .../testing/selftests/rcutorture/bin/configinit.sh |  17 +-
 tools/testing/selftests/rcutorture/bin/cpus2use.sh |  17 +-
 .../testing/selftests/rcutorture/bin/functions.sh  |  17 +-
 tools/testing/selftests/rcutorture/bin/jitter.sh   |  17 +-
 .../testing/selftests/rcutorture/bin/kvm-build.sh  |  17 +-
 .../selftests/rcutorture/bin/kvm-find-errors.sh    |   5 +
 .../selftests/rcutorture/bin/kvm-recheck-lock.sh   |  17 +-
 .../selftests/rcutorture/bin/kvm-recheck-rcu.sh    |  17 +-
 .../rcutorture/bin/kvm-recheck-rcuperf-ftrace.sh   |  17 +-
 .../rcutorture/bin/kvm-recheck-rcuperf.sh          |  17 +-
 .../selftests/rcutorture/bin/kvm-recheck.sh        |  17 +-
 .../selftests/rcutorture/bin/kvm-test-1-run.sh     |  17 +-
 tools/testing/selftests/rcutorture/bin/kvm.sh      |  17 +-
 tools/testing/selftests/rcutorture/bin/mkinitrd.sh |  15 +-
 .../selftests/rcutorture/bin/parse-build.sh        |  17 +-
 .../selftests/rcutorture/bin/parse-console.sh      |  17 +-
 .../rcutorture/configs/lock/ver_functions.sh       |  17 +-
 .../rcutorture/configs/rcu/ver_functions.sh        |  17 +-
 .../rcutorture/configs/rcuperf/ver_functions.sh    |  17 +-
 61 files changed, 1374 insertions(+), 1458 deletions(-)
 create mode 100644 kernel/rcu/tree_stall.h
