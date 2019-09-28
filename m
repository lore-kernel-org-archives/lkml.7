Return-Path: <SRS0=c662=XX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE10C4360C
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Sep 2019 12:39:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AB8F20865
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Sep 2019 12:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569674352;
	bh=J4uU6rdEHGN04ZJMsETUeRku6RliIjN6p1mrFym50AE=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=PPrsapn0+nRcx/O61VsI8X7opO7FZ5r2RiIr439nqvNvnJGZUIRdqX8wLpax4PSVt
	 fmfLFZF1jHZaU9PoovxcX0FS5t5mj94/tcResQ7du40SADHPv8d/WjrFcRDhlTL9LB
	 cR2GSJg0k8pkMcY/QuAZOKlPosjxOWw0xr9Oy/Wk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728402AbfI1MjL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Sep 2019 08:39:11 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39672 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbfI1MjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Sep 2019 08:39:11 -0400
Received: by mail-wm1-f66.google.com with SMTP id v17so8071762wml.4
        for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2019 05:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=BUJ3u3liN1wv66tY3Eq1EVhTIVhsLYndF0D7/NZ9z9A=;
        b=sjM5e7boFitXIH78paeeLChQvF2NMmxTtkG22Ns9Gs/f35mSkDnODC1wU5pfHsykqC
         OSjoS5RplQtTae+x85FzAnID9KB3NIzEtEUDZwqIxRX6OK/5Ow0XYuwEzIM8GJ7pjWqI
         s4IxQG9D5ZAQ1m7E105f2YVsg9RMMOWGztsA4UrSLEYltupToAyExoxl435HlEeocvPF
         05sbE4jvvLMMBuCsH/orsBUybGR37tiSmmLp/C//PPB4Y74sN0w6KSo8aYmcTyJoEk/y
         /RSbObS5KJUbhlmS8GlBUkVxu0vBiizroAUdXOEgHCR7P2RwWsS9R2FTHivAcYOUCsJ0
         IIag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=BUJ3u3liN1wv66tY3Eq1EVhTIVhsLYndF0D7/NZ9z9A=;
        b=cdn3TRGVg1b9D4XVaP4jz2rgVsxDJzPegP3NBxT8P2y9fvlrm4JCNKNBZfiwsJlhT1
         F1l5Q6fe7opdqBOQXBSR9GmDR+U4hvU9rw2Gkvlhpedj+tei+tWGUFgMxOgZzVDGLmGJ
         zoDvQFtA/5bA59JKnzbvaIhnE8woXBPVZsVTfthqgF2Kl3U3EqYKhc19Ww9bYWdHCVJi
         Mvam9E1PN9s51Drrw6V9TLgiC/+tM12vLu4wM8ZX7o2PLTx7FjDJ6rC6Uimyk9NYUw7d
         cMQSmudCLXiW5cQSZz7yvxJ5h9dgNL8ybmT0vSj68RXir+V914cqVc5OzZOYYTuiQ7xY
         orug==
X-Gm-Message-State: APjAAAWe1IXLQdBNMNdJpAuFed4R7JRt8hZpidfRAg8TgazTlvQuBA3f
        7QVO4AHTLwGZrZ71KpI0I5U=
X-Google-Smtp-Source: APXvYqxX4D95SLkc6Mie1R4Xuijt4iu/bFRqxhFAYFrI2pfYyvD8NwuUFm/Ya8pYhYpmVZZdS6hdfQ==
X-Received: by 2002:a7b:cbd0:: with SMTP id n16mr10160549wmi.82.1569674347727;
        Sat, 28 Sep 2019 05:39:07 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id x6sm15767766wmf.38.2019.09.28.05.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Sep 2019 05:39:07 -0700 (PDT)
Date:   Sat, 28 Sep 2019 14:39:05 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] scheduler fixes
Message-ID: <20190928123905.GA97048@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest sched-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-for-linus

   # HEAD: 4892f51ad54ddff2883a60b6ad4323c1f632a9d6 sched/fair: Avoid redundant EAS calculation

The changes are:

 - Apply a number of membarrier related fixes and cleanups, which fixes a 
   use-after-free race in the membarrier code.

 - Introduce proper RCU protection for tasks on the runqueue - to get rid 
   of the subtle task_rcu_dereference() interface that was easy to get 
   wrong.

 - Misc fixes, but also an EAS speedup.

 Thanks,

	Ingo

------------------>
Eric W. Biederman (4):
      tasks: Add a count of task RCU users
      tasks, sched/core: Ensure tasks are available for a grace period after leaving the runqueue
      tasks, sched/core: With a grace period after finish_task_switch(), remove unnecessary code
      tasks, sched/core: RCUify the assignment of rq->curr

KeMeng Shi (1):
      sched/core: Fix migration to invalid CPU in __set_cpus_allowed_ptr()

Mathieu Desnoyers (7):
      sched/membarrier: Fix private expedited registration check
      sched/membarrier: Remove redundant check
      sched/membarrier: Call sync_core only before usermode for same mm
      sched/membarrier: Fix p->mm->membarrier_state racy load
      selftests, sched/membarrier: Add multi-threaded test
      sched/membarrier: Skip IPIs when mm->mm_users == 1
      sched/membarrier: Return -ENOMEM to userspace on memory allocation failure

Qian Cai (3):
      sched/fair: Remove unused cfs_rq_clock_task() function
      sched/core: Convert vcpu_is_preempted() from macro to an inline function
      sched/fair: Fix -Wunused-but-set-variable warnings

Quentin Perret (1):
      sched/fair: Avoid redundant EAS calculation

Valentin Schneider (2):
      sched/core: Fix preempt_schedule() interrupt return comment
      sched/core: Remove double update_max_interval() call on CPU startup


 fs/exec.c                                          |   2 +-
 include/linux/mm_types.h                           |  14 +-
 include/linux/rcuwait.h                            |  20 +-
 include/linux/sched.h                              |  10 +-
 include/linux/sched/mm.h                           |  10 +-
 include/linux/sched/task.h                         |   2 +-
 kernel/exit.c                                      |  74 +------
 kernel/fork.c                                      |   8 +-
 kernel/sched/core.c                                |  28 +--
 kernel/sched/fair.c                                |  39 +---
 kernel/sched/membarrier.c                          | 239 +++++++++++++--------
 kernel/sched/sched.h                               |  34 +++
 tools/testing/selftests/membarrier/.gitignore      |   3 +-
 tools/testing/selftests/membarrier/Makefile        |   5 +-
 .../{membarrier_test.c => membarrier_test_impl.h}  |  40 ++--
 .../membarrier/membarrier_test_multi_thread.c      |  73 +++++++
 .../membarrier/membarrier_test_single_thread.c     |  24 +++
 17 files changed, 375 insertions(+), 250 deletions(-)
 rename tools/testing/selftests/membarrier/{membarrier_test.c => membarrier_test_impl.h} (95%)
 create mode 100644 tools/testing/selftests/membarrier/membarrier_test_multi_thread.c
 create mode 100644 tools/testing/selftests/membarrier/membarrier_test_single_thread.c
