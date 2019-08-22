Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 377F6C3A5A2
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 18:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 073E2233A2
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 18:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566500078;
	bh=FPP1pY/0kbUGQXD7i15i6X4JjhXn/mzA555+H72kiJ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pKFgOXukTjZj5KYcpUVKKbD67JEc08CjOnFUqUIDwQZlo6Bu7/+QErLokECGHwsQu
	 5BDMAdF1ZvjRcyaRkqRRgLUtGlGsqWiX1WOywshFhBQwbbzOku3OFtw9ph7tYg2tXK
	 eTYTDuEdGzfcryvgfMRy3jgPul2+PfjWhvPBiW7M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389124AbfHVSyh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 14:54:37 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36565 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730048AbfHVSyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 14:54:36 -0400
Received: by mail-wr1-f66.google.com with SMTP id r3so6397435wrt.3;
        Thu, 22 Aug 2019 11:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jp9olkOmGWnPU8xBZ7ac1VJmhm4c/v11qcnvAnVrBqk=;
        b=UfH48ywKi5+j6IuWYIiRlaQMqHG5ggF3KntnP0k2ysz6tpS/BcDDwpVm2eBaMMH0iV
         P3D/UXG9IK3Du9nR6ei+KMGuJ4Dm0V05xwVTxyScrme6MHS2EjKTtI7QG3VyMRqYJ3yJ
         W87Eg1XmK0iJX0xB3zzboBBTcize9yUPamtQyOD7quk430gW+2fMnW7TmaUjWgt4I93I
         g7eaGs0tSHEoHx3RARPupo/1ihshrOO98VquMG9KQy7y9FdlyNVGI3FZS5AQCR5+zlr9
         iJnoCsPDcGvhiG9+REg5OPZaqR2DA/7tRpmbP+1Ougcj/x5/S1RtQMgb6yXzF0sLSu+D
         ZApw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=jp9olkOmGWnPU8xBZ7ac1VJmhm4c/v11qcnvAnVrBqk=;
        b=BOq4P0pupIFnQa2VBLiT+ktG3PvhzfAoaus2R/HdKW2PVti1zwaNn4vIkHUnfiv3+s
         zdv/okFcbz3W3HeaZvfAbmGCWb9BPKCLdpzLWwFMlqgH5xt7Ol8lnQmbMLiGdRjrVF/K
         GqPgVveZG6VYDIS/jX/M9uRGFkrDBl0SBS5dGnacyaZjnRHAF5qD10/UaGXTHfjvSh/e
         ksCbiRbRcOjGE4ke5luiROePo3GianMKF+wzWfL1LCXK2Ym1MkE+Zmo/3tdC8fWwo/74
         mSgkSoul+BlH6lGWu4cVNacIS7dDq6T1tXV/+cuZX6uI4f1ykk51hjmf/RWEpzQ+Ivey
         AUhw==
X-Gm-Message-State: APjAAAXDLFXXu2FrSpI0TNm1dnz8eQFUfPCIeGF/I2094uSW88Ao4jFh
        wNqCWHqV7XsVIluF6lPiBJ8=
X-Google-Smtp-Source: APXvYqy3rqrGPwUxkZz1xxxx5NGjhmkQ8tP0s0NOOr11h9wMvrAIaO18/TK/RzMehu+DoSqPRA3EOQ==
X-Received: by 2002:a5d:4108:: with SMTP id l8mr442183wrp.113.1566500072634;
        Thu, 22 Aug 2019 11:54:32 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id a6sm352820wmj.15.2019.08.22.11.54.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2019 11:54:31 -0700 (PDT)
Date:   Thu, 22 Aug 2019 20:54:29 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        joel@joelfernandes.org, parri.andrea@gmail.com,
        byungchul.park@lge.com, peterz@infradead.org, mojha@codeaurora.org,
        ice_yangxiao@163.com, efremov@linux.com, edumazet@google.com
Subject: Re: [GIT PULL rcu/next + tools/memory-model] RCU and LKMM commits
 for 5.4
Message-ID: <20190822185429.GA110910@gmail.com>
References: <20190822151811.GA8894@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190822151811.GA8894@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Paul E. McKenney <paulmck@linux.ibm.com> wrote:

> Hello, Ingo,
> 
> This pull request contain the following changes:
> 
> 1.	A few more RCU flavor consolidation cleanups.
> 
> 	https://lore.kernel.org/lkml/20190801223132.GA14044@linux.ibm.com
> 
> 2.	Miscellaneous fixes.
> 
> 	https://lore.kernel.org/lkml/20190801223708.GA14862@linux.ibm.com
> 
> 	In addition, this includes a spelling fix in a comment and
> 	an email-address change in MAINTAINERS:
> 
> 	https://lore.kernel.org/lkml/1564386957-22833-1-git-send-email-mojha@codeaurora.org
> 	https://lore.kernel.org/lkml/20190805121517.4734-1-parri.andrea@gmail.com/
> 
> 3.	Updates to RCU's list-traversal macros improving lockdep usability.
> 
> 	https://lore.kernel.org/lkml/20190801224240.GA16092@linux.ibm.com/
> 
> 4.	Torture-test updates.
> 
> 	Fat fingered.  :-/  Please let me know if you would prefer that
> 	I resend, then redo this full pull request next week.
> 
> 5.	Forward-progress improvements for no-CBs CPUs: Avoid ignoring
> 	incoming callbacks during grace-period waits.
> 
> 	https://lore.kernel.org/lkml/20190801225009.GA17155@linux.ibm.com/
> 
> 6.	Forward-progress improvements for no-CBs CPUs: Use ->cblist
> 	structure to take advantage of others' grace periods.
> 
> 	https://lore.kernel.org/lkml/20190801230744.GA19115@linux.ibm.com/
> 
> 	Also added a small commit that avoids needlessly inflicting
> 	scheduler-clock ticks on callback-offloaded CPUs.
> 
> 7.	Forward-progress improvements for no-CBs CPUs: Reduce contention
> 	on ->nocb_lock guarding ->cblist.
> 
> 	https://lore.kernel.org/lkml/20190801231619.GA22610@linux.ibm.com/
> 
> 8.	Forward-progress improvements for no-CBs CPUs: Add ->nocb_bypass
> 	list to further reduce contention on ->nocb_lock guarding ->cblist.
> 
> 	https://lore.kernel.org/lkml/20190802151435.GA1081@linux.ibm.com/
> 
> 	(But only patches 1-10, as patch 10 proved to be quite valuable,
> 	but patches 11-14 need more work and testing time.)
> 
> 9.	LKMM updates.
> 
> 	https://lore.kernel.org/lkml/20190801222026.GA11315@linux.ibm.com/
> 
> 	(But only patches 1-3, as the remainder are either new or are
> 	related to ongoing work to verify LKMM against hardware memory
> 	models.)
> 
> Please note that this series encountered a merge conflict in -next:
> 
> 	https://lore.kernel.org/lkml/20190813155048.59dd9bdf@canb.auug.org.au/
> 
> Stephen's resolution looks good to me.
> 
> All of these changes have been subjected to 0day Test Robot and -next
> testing, and are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git for-mingo
> 
> for you to fetch changes up to 07f038a408fb215fd656de78304b6ff4c7e4e490:
> 
>   Merge LKMM and RCU commits (2019-08-13 14:41:48 -0700)
> 
> These changes do increase the size of the kernel by about 700 lines,
> mostly due to the no-CBs CPU forward-progress improvements.  Given that
> RCU forward progress has started to become an issue over the past year
> or so, these changes do not appear to me to be in any way optional.
> 
> ----------------------------------------------------------------
> Andrea Parri (2):
>       tools/memory-model: Update the informal documentation
>       MAINTAINERS: Update e-mail address for Andrea Parri
> 
> Byungchul Park (1):
>       rcu: Change return type of rcu_spawn_one_boost_kthread()
> 
> Denis Efremov (1):
>       torture: Remove exporting of internal functions
> 
> Eric Dumazet (1):
>       rcu: Allow rcu_do_batch() to dynamically adjust batch sizes
> 
> Joel Fernandes (Google) (11):
>       rcu: Simplify rcu_note_context_switch exit from critical section
>       treewide: Rename rcu_dereference_raw_notrace() to _check()
>       rcu: Remove redundant debug_locks check in rcu_read_lock_sched_held()
>       rcuperf: Make rcuperf kernel test more robust for !expedited mode
>       tools/memory-model: Use cumul-fence instead of fence in ->prop example
>       rcu: Add support for consolidated-RCU reader checking
>       rcu/sync: Remove custom check for RCU readers
>       ipv4: Add lockdep condition to fix for_each_entry()
>       driver/core: Convert to use built-in RCU list checking
>       x86/pci: Pass lockdep condition to pcm_mmcfg_list iterator
>       acpi: Use built-in RCU list checking for acpi_ioremaps list
> 
> Mukesh Ojha (1):
>       rcu: Fix spelling mistake "greate"->"great"
> 
> Paul E. McKenney (67):
>       tools/memory-model: Make scripts be executable
>       rcu: Simplify rcu_read_unlock_special() deferred wakeups
>       rcu: Make rcu_read_unlock_special() checks match raise_softirq_irqoff()
>       lockdep: Make print_lock() address visible
>       time/tick-broadcast: Fix tick_broadcast_offline() lockdep complaint
>       rcu: Restore barrier() to rcu_read_lock() and rcu_read_unlock()
>       rcu: Add kernel parameter to dump trace after RCU CPU stall warning
>       rcu: Add destroy_work_on_stack() to match INIT_WORK_ONSTACK()
>       srcu: Avoid srcutorture security-based pointer obfuscation
>       doc: Add rcutree.kthread_prio pointer to stallwarn.txt
>       torture: Expand last_ts variable in kvm-test-1-run.sh
>       rcutorture: Test TREE03 with the threadirqs kernel boot parameter
>       rcutorture: Emulate userspace sojourn during call_rcu() floods
>       rcutorture: Aggressive forward-progress tests shouldn't block shutdown
>       rcu: Remove redundant "if" condition from rcu_gp_is_expedited()
>       arm: Use common outgoing-CPU-notification code
>       Merge branches 'consolidate.2019.08.01b', 'fixes.2019.08.12a', 'lists.2019.08.13a' and 'torture.2019.08.01b' into HEAD
>       rcu/nocb: Rename rcu_data fields to prepare for forward-progress work
>       rcu/nocb: Update comments to prepare for forward-progress work
>       rcu/nocb: Provide separate no-CBs grace-period kthreads
>       rcu/nocb: Rename nocb_follower_wait() to nocb_cb_wait()
>       rcu/nocb: Rename wake_nocb_leader() to wake_nocb_gp()
>       rcu/nocb: Rename __wake_nocb_leader() to __wake_nocb_gp()
>       rcu/nocb: Rename wake_nocb_leader_defer() to wake_nocb_gp_defer()
>       rcu/nocb: Rename rcu_organize_nocb_kthreads() local variable
>       rcu/nocb: Rename and document no-CB CB kthread sleep trace event
>       rcu/nocb: Rename rcu_nocb_leader_stride kernel boot parameter
>       rcu/nocb: Print gp/cb kthread hierarchy if dump_tree
>       rcu/nocb: Use separate flag to indicate disabled ->cblist
>       rcu/nocb: Use separate flag to indicate offloaded ->cblist
>       rcu/nocb: Add checks for offloaded callback processing
>       rcu/nocb: Make rcutree_migrate_callbacks() start at leaf rcu_node structure
>       rcu/nocb: Check for deferred nocb wakeups before nohz_full early exit
>       rcu/nocb: Remove deferred wakeup checks for extended quiescent states
>       rcu/nocb: Allow lockless use of rcu_segcblist_restempty()
>       rcu/nocb: Allow lockless use of rcu_segcblist_empty()
>       rcu/nocb: Leave ->cblist enabled for no-CBs CPUs
>       rcu/nocb: Use rcu_segcblist for no-CBs CPUs
>       rcu/nocb: Remove obsolete nocb_head and nocb_tail fields
>       rcu/nocb: Remove obsolete nocb_q_count and nocb_q_count_lazy fields
>       rcu/nocb: Remove obsolete nocb_cb_tail and nocb_cb_head fields
>       rcu/nocb: Remove obsolete nocb_gp_head and nocb_gp_tail fields
>       rcu/nocb: Use build-time no-CBs check in rcu_do_batch()
>       rcu/nocb: Use build-time no-CBs check in rcu_core()
>       rcu/nocb: Use build-time no-CBs check in rcu_pending()
>       rcu/nocb: Suppress uninitialized false-positive in nocb_gp_wait()
>       rcu/nohz: Turn off tick for offloaded CPUs
>       rcu/nocb: Enable re-awakening under high callback load
>       rcu/nocb: Never downgrade ->nocb_defer_wakeup in wake_nocb_gp_defer()
>       rcu/nocb: Make __call_rcu_nocb_wake() safe for many callbacks
>       rcu/nocb: Avoid needless wakeups of no-CBs grace-period kthread
>       rcu/nocb: Avoid ->nocb_lock capture by corresponding CPU
>       rcu/nocb: Round down for number of no-CBs grace-period kthreads
>       rcu/nocb: Reduce contention at no-CBs registry-time CB advancement
>       rcu/nocb: Reduce contention at no-CBs invocation-done time
>       rcu/nocb: Reduce ->nocb_lock contention with separate ->nocb_gp_lock
>       rcu/nocb: Unconditionally advance and wake for excessive CBs
>       rcu/nocb: Atomic ->len field in rcu_segcblist structure
>       rcu/nocb: Add bypass callback queueing
>       rcu/nocb: EXP Check use and usefulness of ->nocb_lock_contended
>       rcu/nocb: Print no-CBs diagnostics when rcutorture writer unduly delayed
>       rcu/nocb: Avoid synchronous wakeup in __call_rcu_nocb_wake()
>       rcu/nocb: Advance CBs after merge in rcutree_migrate_callbacks()
>       rcu/nocb: Reduce nocb_cb_wait() leaf rcu_node ->lock contention
>       rcu/nocb: Reduce __call_rcu_nocb_wake() leaf rcu_node ->lock contention
>       rcu/nocb: Don't wake no-CBs GP kthread if timer posted under overload
>       Merge LKMM and RCU commits
> 
> Peter Zijlstra (1):
>       idle: Prevent late-arriving interrupts from disrupting offline
> 
> Xiao Yang (1):
>       rcuperf: Fix perf_type module-parameter description
> 
>  .../RCU/Design/Requirements/Requirements.html      |   73 +-
>  Documentation/RCU/stallwarn.txt                    |    6 +
>  Documentation/admin-guide/kernel-parameters.txt    |   17 +-
>  MAINTAINERS                                        |    2 +-
>  arch/arm/kernel/smp.c                              |    6 +-
>  arch/powerpc/include/asm/kvm_book3s_64.h           |    2 +-
>  arch/x86/pci/mmconfig-shared.c                     |    5 +-
>  drivers/acpi/osl.c                                 |    6 +-
>  drivers/base/base.h                                |    1 +
>  drivers/base/core.c                                |   12 +
>  drivers/base/power/runtime.c                       |   15 +-
>  include/linux/rcu_segcblist.h                      |    9 +
>  include/linux/rcu_sync.h                           |    4 +-
>  include/linux/rculist.h                            |   36 +-
>  include/linux/rcupdate.h                           |    9 +-
>  include/trace/events/rcu.h                         |    4 +-
>  kernel/locking/lockdep.c                           |    2 +-
>  kernel/rcu/Kconfig.debug                           |   11 +
>  kernel/rcu/rcu.h                                   |    1 +
>  kernel/rcu/rcu_segcblist.c                         |  174 ++-
>  kernel/rcu/rcu_segcblist.h                         |   54 +-
>  kernel/rcu/rcuperf.c                               |   10 +-
>  kernel/rcu/rcutorture.c                            |   30 +-
>  kernel/rcu/srcutree.c                              |    5 +-
>  kernel/rcu/tree.c                                  |  205 ++--
>  kernel/rcu/tree.h                                  |   81 +-
>  kernel/rcu/tree_exp.h                              |    8 +-
>  kernel/rcu/tree_plugin.h                           | 1195 ++++++++++++--------
>  kernel/rcu/tree_stall.h                            |    9 +
>  kernel/rcu/update.c                                |  105 +-
>  kernel/sched/core.c                                |   57 +-
>  kernel/sched/idle.c                                |    5 +-
>  kernel/torture.c                                   |    2 -
>  kernel/trace/ftrace_internal.h                     |    8 +-
>  kernel/trace/trace.c                               |    4 +-
>  net/ipv4/fib_frontend.c                            |    3 +-
>  tools/memory-model/Documentation/explanation.txt   |   53 +-
>  tools/memory-model/README                          |   18 +-
>  tools/memory-model/scripts/checkghlitmus.sh        |    0
>  tools/memory-model/scripts/checklitmushist.sh      |    0
>  tools/memory-model/scripts/cmplitmushist.sh        |    0
>  tools/memory-model/scripts/initlitmushist.sh       |    0
>  tools/memory-model/scripts/judgelitmus.sh          |    0
>  tools/memory-model/scripts/newlitmushist.sh        |    0
>  tools/memory-model/scripts/parseargs.sh            |    0
>  tools/memory-model/scripts/runlitmushist.sh        |    0
>  .../selftests/rcutorture/bin/kvm-test-1-run.sh     |    2 +-
>  .../selftests/rcutorture/configs/rcu/TREE03.boot   |    1 +
>  48 files changed, 1472 insertions(+), 778 deletions(-)
>  mode change 100644 => 100755 tools/memory-model/scripts/checkghlitmus.sh
>  mode change 100644 => 100755 tools/memory-model/scripts/checklitmushist.sh
>  mode change 100644 => 100755 tools/memory-model/scripts/cmplitmushist.sh
>  mode change 100644 => 100755 tools/memory-model/scripts/initlitmushist.sh
>  mode change 100644 => 100755 tools/memory-model/scripts/judgelitmus.sh
>  mode change 100644 => 100755 tools/memory-model/scripts/newlitmushist.sh
>  mode change 100644 => 100755 tools/memory-model/scripts/parseargs.sh
>  mode change 100644 => 100755 tools/memory-model/scripts/runlitmushist.sh

Pulled into tip:core/rcu, thanks a lot Paul!

The merge commit is a bit non-standard:

  07f038a408fb: Merge LKMM and RCU commits

but clear enough IMHO. Usually we try to keep this format:

  6c06b66e957c: Merge branch 'X' into Y

even for internal merge commits.

Thanks,

	Ingo
