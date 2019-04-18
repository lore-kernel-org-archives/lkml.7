Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A716CC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 12:44:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ED8C20835
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 12:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555591499;
	bh=2PlXePokWr1wSzRQwGc0o7shaYvzRCnydY+y0bEq9l4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wiD0v2+YBenavSMbdYWcguC5WHGnhdGg18WCfza90ZSwrdaAfjt/9jasCYcf1EUTP
	 8SlGGqI7it3ykDNwbggVtdhWubM++A4QS+0ZecHwarF1eEQo1DpoEbFflklThI2Jw6
	 EwXxwtdek+5cTCdDjxMkZAxSfwXhjtgJoMSWNAGM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388713AbfDRMo6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 08:44:58 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42804 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbfDRMo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 08:44:57 -0400
Received: by mail-wr1-f66.google.com with SMTP id g3so2805801wrx.9;
        Thu, 18 Apr 2019 05:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=84uhRl9AuEGIl1F/Od76UWaTAs3PNfVWrvKdwRlVU9Y=;
        b=uo2fPyh6WNOGizzs2OvVkhAEEg+j6wgXWoVu1+XZRSpK6DcQcLxvVI7oDH81dTxlQ0
         kuqzycDjaij3A5FLujrhHM04MGv/dj2SnIudVMlL2UPFcNj4E1TvYGsIaSpdXl2tWBX2
         1SRqawtHLOexMKWh8tt/2UXOT/9oD2s36qKxWwyWzXQTEv8lVvaZvaNo1qP3xjRJUw50
         e+PSuXlIsju5tvWYugyfTFx2PZpD1J6JwuBMIMnplyaeVZpR3kckkYJB1qrJ9mFesGt0
         mXthu5dDbbF03WV20UYJiTMYkLzpxk9D7w47pxfyW7TtDMHVpDnmTl5/MuEswshmlqWe
         sGEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=84uhRl9AuEGIl1F/Od76UWaTAs3PNfVWrvKdwRlVU9Y=;
        b=sAZB1jkamxiCJwKLXsJqS0Lkz8czpMJa8YgttrhCfuXThEzX5LNdof2RKYnstYgghY
         rzbBd8KW22W0CtUgY6HxR2XggBdOfbJTDqWruSBikCBYVIDYPrjfbiMKsh660ExuWCrL
         Ls0cA8eH/0DryPkCHoxmBSQhPEvJTfDl0U5cUI32XibTxqyNMboKvBD/FhI1NA9pDRsh
         R6IHteN2BHXeVa0IPFm28gp7CgXVrDuJ3W5pi5xdazqqfykER3KakEVr/kpy9I9PLZQK
         12A91QM+cZFjRYa+x32++V11ZuLSGEfh8SCdjAYJP+wP/z7zLWDhTfsHdTsOj9DA0MBP
         sd8g==
X-Gm-Message-State: APjAAAWHVznu+BbWxOdleNt1O9t8DV7qynmvn5NmMfBKG+IW06Et93j9
        smD+C0AEiMeLzHqyvJtDvtk=
X-Google-Smtp-Source: APXvYqxfL6oS52M4aC2Sd6GHX8oFW5wJPI5iL3EBmpyHb2T3WxSGR5D9H8pjr1MOVWRCbwGUOD9yUg==
X-Received: by 2002:adf:ea81:: with SMTP id s1mr14684136wrm.277.1555591495054;
        Thu, 18 Apr 2019 05:44:55 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id w11sm3393354wre.15.2019.04.18.05.44.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Apr 2019 05:44:54 -0700 (PDT)
Date:   Thu, 18 Apr 2019 14:44:51 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        stern@rowland.harvard.edu, Luc.Maranget@inria.fr,
        andrea.parri@amarulasolutions.com, sj38.park@gmail.com,
        peterz@infradead.org, tycho@tycho.ws, joel@joelfernandes.org,
        gorcunov@gmail.com, fishland@aliyun.com, akiyks@gmail.com,
        neeraju@codeaurora.org, zhouzhouyi@gmail.com
Subject: Re: [GIT PULL rcu/next + tools/memory-model] RCU and LKMM commits
 for 5.2
Message-ID: <20190418124451.GA104512@gmail.com>
References: <20190418123859.GA21854@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190418123859.GA21854@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Paul E. McKenney <paulmck@linux.ibm.com> wrote:

> Hello, Ingo,
> 
> This pull request contains the following changes:
> 
> 1.	An LKMM commit adding support for synchronize_srcu_expedited().
> 
> 	http://lkml.kernel.org/r/20190326234133.24962-8-paulmck@linux.ibm.com
> 
> 2.	A couple of straggling RCU flavor consolidation updates.
> 
> 	http://lkml.kernel.org/r/20190326230011.GA16275@linux.ibm.com
> 
> 3.	Documentation updates.
> 
> 	http://lkml.kernel.org/r/20190326230408.GA17069@linux.ibm.com
> 
> 4.	Miscellaneous fixes.
> 
> 	http://lkml.kernel.org/r/20190326231253.GA18343@linux.ibm.com
> 
> 5.	SRCU updates.
> 
> 	http://lkml.kernel.org/r/20190326231512.GA19843@linux.ibm.com
> 
> 6.	RCU CPU stall-warning updates.
> 
> 	http://lkml.kernel.org/r/20190326232208.GA20384@linux.ibm.com
> 
> 7.	Torture-test updates.
> 
> 	http://lkml.kernel.org/r/20190326233054.GA21523@linux.ibm.com
> 
> All of these changes have been subjected to 0day Test Robot and -next
> testing, and are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git for-mingo
> 
> for you to fetch changes up to 91df49e187c1a111e423fe0c3aec3472980385e4:
> 
>   Merge LKMM and RCU commits (2019-04-16 07:08:07 -0700)
> 
> ----------------------------------------------------------------
> Akira Yokosawa (1):
>       rcu: Move common code out of if-else block
> 
> Alan Stern (4):
>       tools/memory-model: Rename some RCU relations
>       tools/memory-model: Refactor some RCU relations
>       tools/memory-model: Add SRCU support
>       tools/memory-model: Update Documentation/explanation.txt to include SRCU support
> 
> Andrea Parri (1):
>       tools/memory-model: Avoid duplicating herdtools versions
> 
> Cyrill Gorcunov (1):
>       rcu: rcu_qs -- Use raise_softirq_irqoff to not save irqs twice
> 
> Joel Fernandes (Google) (1):
>       rcu: Avoid unnecessary softirq when system is idle
> 
> Liu Song (1):
>       rcu: Set rcutree.kthread_prio sysfs access to read-only
> 
> Luc Maranget (1):
>       tools/memory-model: Dynamically check SRCU lock-to-unlock matching
> 
> Neeraj Upadhyay (5):
>       rcu: Fix self-wakeups for grace-period kthread
>       rcu: Default jiffies_to_sched_qs to jiffies_till_sched_qs
>       rcu: Do a single rhp->func read in rcu_head_after_call_rcu()
>       rcu: Fix nohz status in stall warning
>       rcutorture: Fix expected forward progress duration in OOM notifier
> 
> Paul E. McKenney (39):
>       tools/memory-model: Update README for addition of SRCU
>       doc: Remove obsolete RCU update functions from RCU documentation
>       doc: Describe choice of rcu_dereference() APIs and __rcu usage
>       doc: Fix typos and otherwise modernize checklist.txt
>       rcu: Unconditionally expedite during suspend/hibernate
>       rcu: Make exit_rcu() handle non-preempted RCU readers
>       MAINTAINERS: RCU now has its own email list
>       MAINTAINERS: Add -rcu branch name ("dev")
>       rcu: Allow rcu_nocbs= to specify all CPUs
>       rcu: Report error for bad rcu_nocbs= parameter values
>       rcu: Update jiffies_to_sched_qs and adjust_jiffies_till_sched_qs() comments
>       rcu: Eliminate redundant NULL-pointer check
>       rcu: Fix typo in tree_exp.h comment
>       rcu: Correct READ_ONCE()/WRITE_ONCE() for ->rcu_read_unlock_special
>       srcu: Check for in-flight callbacks in _cleanup_srcu_struct()
>       srcu: Remove cleanup_srcu_struct_quiesced()
>       rcu: Move RCU CPU stall-warning code out of update.c
>       rcu: Move RCU CPU stall-warning code out of tree_plugin.h
>       rcu: Move RCU CPU stall-warning code out of tree.c
>       rcu: Inline RCU task stall-warning helper functions
>       rcu: Move rcu_print_task_exp_stall() to tree_exp.h
>       rcu: Inline RCU stall-warning info helper functions
>       rcu: Move FAST_NO_HZ stall-warning code to tree_stall.h
>       rcu: Organize functions in tree_stall.h
>       rcu: Move irq-disabled stall-warning checking to tree_stall.h
>       rcu: Move forward-progress checkers into tree_stall.h
>       torture: Don't try to offline the last CPU
>       tools/.../rcutorture: Convert to SPDX license identifier
>       rcutorture: Make rcutorture_extend_mask() comment match the code
>       rcutorture: Remove ->ext_irq_conflict field
>       rcutorture: Fix cleanup path for invalid torture_type strings
>       rcuperf: Fix cleanup path for invalid perf_type strings
>       locktorture: NULL cxt.lwsa and cxt.lrsa to allow bad-arg detection
>       torture: Suppress false-positive CONFIG_INITRAMFS_SOURCE complaint
>       doc/kprobes: Update obsolete RCU update functions
>       tools/memory-model: Add support for synchronize_srcu_expedited()
>       net/ipv4/netfilter: Update comment from call_rcu_bh() to call_rcu()
>       Merge branches 'consolidate.2019.04.09a', 'doc.2019.03.26b', 'fixes.2019.03.26b', 'srcu.2019.03.26b', 'stall.2019.03.26b' and 'torture.2019.03.26b' into HEAD
>       Merge LKMM and RCU commits
> 
> Peter Zijlstra (1):
>       Documentation/atomic_t: Clarify signed vs unsigned
> 
> SeongJae Park (2):
>       sched/Documentation/kokr: Update Korean translation to update wake_up() & co. memory-barrier guarantees
>       locking/memory-barriers/kokr: Update Korean translation to replace smp_cond_acquire() with smp_cond_load_acquire()
> 
> Tycho Andersen (1):
>       doc: Repair some whitespace damage
> 
> Zhouyi Zhou (1):
>       rcu: Fix force_qs_rnp() header comment
> 
>  .../Design/Data-Structures/Data-Structures.html    |   3 +-
>  .../Expedited-Grace-Periods.html                   |   4 +-
>  .../Memory-Ordering/Tree-RCU-Memory-Ordering.html  |   5 +-
>  Documentation/RCU/NMI-RCU.txt                      |  13 +-
>  Documentation/RCU/UP.txt                           |   6 +-
>  Documentation/RCU/checklist.txt                    |  91 ++-
>  Documentation/RCU/rcu.txt                          |   8 +-
>  Documentation/RCU/rcu_dereference.txt              | 103 +++
>  Documentation/RCU/rcubarrier.txt                   |  27 +-
>  Documentation/RCU/whatisRCU.txt                    |  10 +-
>  Documentation/admin-guide/kernel-parameters.txt    |   4 +-
>  Documentation/atomic_t.txt                         |  17 +
>  Documentation/kprobes.txt                          |   6 +-
>  .../translations/ko_KR/memory-barriers.txt         |  49 +-
>  MAINTAINERS                                        |  16 +-
>  drivers/nvme/host/core.c                           |   2 +-
>  include/linux/rcupdate.h                           |   6 +-
>  include/linux/srcu.h                               |  36 +-
>  kernel/locking/locktorture.c                       |   2 +
>  kernel/rcu/rcu.h                                   |   1 +
>  kernel/rcu/rcuperf.c                               |   5 +
>  kernel/rcu/rcutorture.c                            |  21 +-
>  kernel/rcu/srcutiny.c                              |   9 +-
>  kernel/rcu/srcutree.c                              |  32 +-
>  kernel/rcu/tiny.c                                  |   2 +-
>  kernel/rcu/tree.c                                  | 508 +--------------
>  kernel/rcu/tree.h                                  |  14 +-
>  kernel/rcu/tree_exp.h                              |  36 +-
>  kernel/rcu/tree_plugin.h                           | 257 +-------
>  kernel/rcu/tree_stall.h                            | 709 +++++++++++++++++++++
>  kernel/rcu/update.c                                |  59 +-
>  kernel/torture.c                                   |   2 +
>  net/ipv4/netfilter/ipt_CLUSTERIP.c                 |   2 +-
>  tools/memory-model/Documentation/explanation.txt   | 289 +++++----
>  tools/memory-model/README                          |  33 +-
>  tools/memory-model/linux-kernel.bell               |  35 +-
>  tools/memory-model/linux-kernel.cat                |  39 +-
>  tools/memory-model/linux-kernel.def                |   6 +
>  tools/memory-model/lock.cat                        |   3 -
>  .../selftests/rcutorture/bin/configNR_CPUS.sh      |  17 +-
>  .../selftests/rcutorture/bin/config_override.sh    |  17 +-
>  .../selftests/rcutorture/bin/configcheck.sh        |  19 +-
>  .../testing/selftests/rcutorture/bin/configinit.sh |  17 +-
>  tools/testing/selftests/rcutorture/bin/cpus2use.sh |  17 +-
>  .../testing/selftests/rcutorture/bin/functions.sh  |  17 +-
>  tools/testing/selftests/rcutorture/bin/jitter.sh   |  17 +-
>  .../testing/selftests/rcutorture/bin/kvm-build.sh  |  17 +-
>  .../selftests/rcutorture/bin/kvm-find-errors.sh    |   5 +
>  .../selftests/rcutorture/bin/kvm-recheck-lock.sh   |  17 +-
>  .../selftests/rcutorture/bin/kvm-recheck-rcu.sh    |  17 +-
>  .../rcutorture/bin/kvm-recheck-rcuperf-ftrace.sh   |  17 +-
>  .../rcutorture/bin/kvm-recheck-rcuperf.sh          |  17 +-
>  .../selftests/rcutorture/bin/kvm-recheck.sh        |  17 +-
>  .../selftests/rcutorture/bin/kvm-test-1-run.sh     |  17 +-
>  tools/testing/selftests/rcutorture/bin/kvm.sh      |  17 +-
>  tools/testing/selftests/rcutorture/bin/mkinitrd.sh |  15 +-
>  .../selftests/rcutorture/bin/parse-build.sh        |  17 +-
>  .../selftests/rcutorture/bin/parse-console.sh      |  17 +-
>  .../rcutorture/configs/lock/ver_functions.sh       |  17 +-
>  .../rcutorture/configs/rcu/ver_functions.sh        |  17 +-
>  .../rcutorture/configs/rcuperf/ver_functions.sh    |  17 +-
>  61 files changed, 1374 insertions(+), 1458 deletions(-)
>  create mode 100644 kernel/rcu/tree_stall.h

Pulled into tip:core/rcu, thanks a lot Paul!

	Ingo
