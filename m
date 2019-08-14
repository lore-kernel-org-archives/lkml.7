Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 121D0C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 10:41:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4085204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 10:41:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbfHNKlj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 06:41:39 -0400
Received: from foss.arm.com ([217.140.110.172]:51806 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726230AbfHNKlj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 06:41:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CC16A28;
        Wed, 14 Aug 2019 03:41:38 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0BE723F706;
        Wed, 14 Aug 2019 03:41:36 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     ak@linux.intel.com, akpm@linux-foundation.org,
        bigeasy@linutronix.de, bp@suse.de, catalin.marinas@arm.com,
        davem@davemloft.net, hch@lst.de, kan.liang@intel.com,
        mark.rutland@arm.com, mingo@kernel.org, peterz@infradead.org,
        riel@surriel.com, will@kernel.org
Subject: [PATCH 0/9] kthread detection cleanup
Date:   Wed, 14 Aug 2019 11:41:22 +0100
Message-Id: <20190814104131.20190-1-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A reasonable amount of kernel code looks at task_struct::mm to determine
whether a thread is a kthread or a real user task. This isn't quite right,
since kthreads can have a non-NULL mm when calling use_mm().

The correct way to check whether a task is a kthread is to check whether
PF_KTHREAD is set in task_struct::flags, but doing so is a bit unwieldy.

To make this a bit nicer, this series adds a new is_kthread(tsk) helper,
converts existing code to make use of it, and fixes up a number of erroneous
checks of current->mm.  Hopefully this will push people to use the right
approach in future.

I'm sure there are other instances in the kernel tree where we don't check this
correctly. In this series I'm just trying to fix the instances I'm reasonably
confident are incorrect.

This series is based on v5.3-rc3, and I've pushed it out to my
sched/kthread-cleanup branch on kernel.org [1,2].

Thanks,
Mark.

[1] git://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git sched/kthread-cleanup
[2] https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/log/?h=sched/kthread-cleanup

Mark Rutland (9):
  sched/core: add is_kthread() helper
  sched: treewide: use is_kthread()
  kmemleak: correctly check for kthreads
  arm/perf: correctly check for kthreads
  arm64: correctly check for ktrheads
  sparc/perf: correctly check for kthreads
  x86/lbr: correctly check for kthreads
  x86/fpu: correctly check for kthreads
  samples/kretprobe: correctly check for kthreads

 arch/alpha/kernel/process.c         |  2 +-
 arch/arc/kernel/process.c           |  2 +-
 arch/arm/kernel/perf_callchain.c    |  2 +-
 arch/arm/kernel/process.c           |  2 +-
 arch/arm/mm/init.c                  |  2 +-
 arch/arm64/kernel/process.c         |  6 +++---
 arch/c6x/kernel/process.c           |  2 +-
 arch/csky/kernel/process.c          |  2 +-
 arch/h8300/kernel/process.c         |  2 +-
 arch/hexagon/kernel/process.c       |  2 +-
 arch/ia64/kernel/process.c          |  2 +-
 arch/m68k/kernel/process.c          |  2 +-
 arch/microblaze/kernel/process.c    |  2 +-
 arch/mips/kernel/process.c          |  4 ++--
 arch/nds32/kernel/process.c         |  4 ++--
 arch/nios2/kernel/process.c         |  2 +-
 arch/openrisc/kernel/process.c      |  2 +-
 arch/parisc/kernel/process.c        |  2 +-
 arch/powerpc/kernel/process.c       |  2 +-
 arch/riscv/kernel/process.c         |  2 +-
 arch/s390/kernel/process.c          |  2 +-
 arch/sh/kernel/process_32.c         |  2 +-
 arch/sh/kernel/process_64.c         |  2 +-
 arch/sparc/kernel/perf_event.c      |  2 +-
 arch/sparc/kernel/process_32.c      |  2 +-
 arch/sparc/kernel/process_64.c      |  2 +-
 arch/um/kernel/process.c            |  2 +-
 arch/unicore32/kernel/process.c     |  2 +-
 arch/x86/events/intel/lbr.c         |  2 +-
 arch/x86/include/asm/fpu/internal.h |  2 +-
 arch/x86/kernel/fpu/core.c          |  2 +-
 arch/x86/kernel/process_32.c        |  2 +-
 arch/x86/kernel/process_64.c        |  2 +-
 arch/xtensa/kernel/process.c        |  2 +-
 block/blk-cgroup.c                  |  2 +-
 drivers/tty/sysrq.c                 |  2 +-
 fs/coredump.c                       |  2 +-
 fs/file_table.c                     |  4 ++--
 fs/namespace.c                      |  2 +-
 fs/proc/base.c                      |  4 ++--
 include/linux/cgroup.h              |  2 +-
 include/linux/sched.h               | 13 ++++++++++++-
 kernel/cgroup/freezer.c             |  4 ++--
 kernel/events/core.c                |  2 +-
 kernel/exit.c                       |  2 +-
 kernel/fork.c                       |  6 +++---
 kernel/freezer.c                    |  4 ++--
 kernel/futex.c                      |  2 +-
 kernel/kthread.c                    |  6 +++---
 kernel/livepatch/transition.c       |  2 +-
 kernel/ptrace.c                     |  2 +-
 kernel/sched/core.c                 |  8 ++++----
 kernel/sched/idle.c                 |  2 +-
 kernel/sched/wait.c                 |  2 +-
 kernel/signal.c                     |  2 +-
 kernel/stacktrace.c                 |  2 +-
 lib/is_single_threaded.c            |  2 +-
 mm/kmemleak.c                       |  6 +++---
 mm/memcontrol.c                     |  2 +-
 mm/oom_kill.c                       |  4 ++--
 mm/page_alloc.c                     |  2 +-
 mm/vmacache.c                       |  2 +-
 mm/vmscan.c                         |  2 +-
 samples/kprobes/kretprobe_example.c |  2 +-
 security/smack/smack_access.c       |  2 +-
 security/smack/smack_lsm.c          |  4 ++--
 security/yama/yama_lsm.c            |  2 +-
 67 files changed, 97 insertions(+), 86 deletions(-)

-- 
2.11.0

