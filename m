Return-Path: <SRS0=t9Bv=TF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B22C004C9
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 12:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF7DF208C0
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 12:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557060480;
	bh=pR9PQ6G1YOt1VAwZsgV9j0CrbdtAuMbL4g4Dexhqj0s=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=bLUZSMaMH0AH/yMxJs7S3somoHMYY5bI4JPR+qV3Np4heFUQtgYhHD9k9o3Q421/w
	 DqOoIZVSjSdTQlAAsnfaIuPZJqvclElLhpvjqPGkISOcGEn3pgM18ZTkGGy4eloj+g
	 ss8uCtLXE+BCgR8Xk9yBonD7bLmyTf1bkXdi+QqU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727719AbfEEMrw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 May 2019 08:47:52 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37195 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726395AbfEEMrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 May 2019 08:47:52 -0400
Received: by mail-wr1-f67.google.com with SMTP id a12so3574608wrn.4
        for <linux-kernel@vger.kernel.org>; Sun, 05 May 2019 05:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=xzX8PxtdIrCn70kyYllzxAahweO1KUUmhXkNfhIW86o=;
        b=InHbDuB8Nrgjx4Q/MbsYBHA18Yw264KS0HjDLcBZV9dlTEX0IUrNWLfwhU+ad+pLE2
         GNYOzRq/Abkry7wF2B6t/RpDopVAXdS5FeMRlaPst+cEB5N/mRl4CKiAcq1JDgKg/KTi
         /jlO/qX2OWiuKA0EVBU6YefhOvN0YriXH0Y1DnQaM0GTRrJA+qtT2C5+a99hXvS9jeui
         gILUyajMfD3XVEfu9Z9oJkARnkyN7sLMicZthKy4LjhGKxTfOq4H413Rc9bQnmJtkTRO
         1EV3a52ivBpFgbYRWSTzkmCt/awUUjPaoF/07GqDa+07TyRpmUzRUj25kqS1hXa3aV6D
         motA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=xzX8PxtdIrCn70kyYllzxAahweO1KUUmhXkNfhIW86o=;
        b=rL3OZapOrNW6U/PocX9+ciLFSnHMDIZU2mgfsa2WBWLfT8zWlZqHDKXjPQmD1bda2x
         WEjJvVdp1n+0YcwK+cydTbmK0YtDWl+aqsN/S0r6k0uCMzIRJbjNwKQ76Xz0GznWmm5B
         /mbpZLyj45RwUb/IlaKQKcx4OWuHPxh200qtww1/o6CJcAQlDo8qbU2bklGMv6xbQCbV
         3TN86oY2FKkAQzyPVJgFO2soaC8aTnXBlkhHd9Y/jBoZZ97sc/Gdn+ZVCLTRXLcHykLo
         0cHQom8ZQLsr1rUTcAC5xjuoVmsQpF8CiIPD6FIO3DQxbUsoleeFnTpJXAI2uq4sj/FU
         8+hA==
X-Gm-Message-State: APjAAAWTH+RqLa0fnM0QKNgAdZP/KdDgkgq6glBThzvdBd/XyqaEGBwD
        fx/9HyQm+os3lYSOnrYsOi4=
X-Google-Smtp-Source: APXvYqwBFtRSMabzkoqs5H31ieeI/bhf5FcnIkWR7/xDwXykytJr+tMtSuhgBqK4ZmTJK6l9KYS9fQ==
X-Received: by 2002:a5d:4403:: with SMTP id z3mr15023599wrq.186.1557060469222;
        Sun, 05 May 2019 05:47:49 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id o13sm12960004wrg.40.2019.05.05.05.47.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 05 May 2019 05:47:48 -0700 (PDT)
Date:   Sun, 5 May 2019 14:47:46 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@infradead.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] perf fixes
Message-ID: <20190505124746.GA57834@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest perf-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-for-linus

   # HEAD: 6f55967ad9d9752813e36de6d5fdbd19741adfc7 perf/x86/intel: Fix race in intel_pmu_disable_event()

I'd like to apologize for this very late pull request: I was dithering 
through the week whether to send the fixes, and then yesterday Jiri's 
crash fix for a regression introduced in this cycle clearly marked 
perf/urgent as 'must merge now'.

Most of the commits are tooling fixes, plus there's three kernel fixes 
via four commits:

 - race fix in the Intel PEBS code
 - fix an AUX bug and roll back a previous attempt
 - fix AMD family 17h generic HW cache-event perf  counters

The largest diffstat contribution comes from the AMD fix - a new event 
table is introduced, which is a fairly low risk change but has a large 
linecount.

 Thanks,

	Ingo

------------------>
Alexander Shishkin (2):
      perf/ring_buffer: Fix AUX software double buffering
      perf/x86/intel/pt: Remove software double buffering PMU capability

Arnaldo Carvalho de Melo (5):
      tools uapi x86: Sync vmx.h with the kernel
      perf bench numa: Add define for RUSAGE_THREAD if not present
      tools build: Add -ldl to the disassembler-four-args feature test
      tools arch uapi: Copy missing unistd.h headers for arc, hexagon and riscv
      perf tools: Remove needless asm/unistd.h include fixing build in some places

Bo YU (1):
      perf bpf: Return value with unlocking in perf_env__find_btf()

Jiri Olsa (1):
      perf/x86/intel: Fix race in intel_pmu_disable_event()

Kim Phillips (2):
      perf/x86/amd: Update generic hardware cache events for Family 17h
      MAINTAINERS: Include vendor specific files under arch/*/events/*

Leo Yan (3):
      tools lib traceevent: Change tag string for error
      perf cs-etm: Don't check cs_etm_queue::prev_packet validity
      perf cs-etm: Always allocate memory for cs_etm_queue::prev_packet

Thadeu Lima de Souza Cascardo (1):
      perf annotate: Fix build on 32 bit for BPF annotation

Thomas Richter (1):
      perf report: Report OOM in status line in the GTK UI


 MAINTAINERS                                  |   1 +
 arch/x86/events/amd/core.c                   | 111 ++++++++++++++++++++++++++-
 arch/x86/events/intel/core.c                 |  10 ++-
 arch/x86/events/intel/pt.c                   |   3 +-
 include/linux/perf_event.h                   |   1 -
 kernel/events/ring_buffer.c                  |   3 +-
 tools/arch/arc/include/uapi/asm/unistd.h     |  51 ++++++++++++
 tools/arch/hexagon/include/uapi/asm/unistd.h |  40 ++++++++++
 tools/arch/riscv/include/uapi/asm/unistd.h   |  42 ++++++++++
 tools/arch/x86/include/uapi/asm/vmx.h        |   1 +
 tools/lib/traceevent/parse-utils.c           |   2 +-
 tools/perf/Makefile.config                   |   2 +-
 tools/perf/bench/numa.c                      |   4 +
 tools/perf/util/annotate.c                   |   8 +-
 tools/perf/util/cloexec.c                    |   1 -
 tools/perf/util/cs-etm.c                     |  14 +---
 tools/perf/util/env.c                        |   2 +-
 tools/perf/util/session.c                    |   8 +-
 18 files changed, 272 insertions(+), 32 deletions(-)
 create mode 100644 tools/arch/arc/include/uapi/asm/unistd.h
 create mode 100644 tools/arch/hexagon/include/uapi/asm/unistd.h
 create mode 100644 tools/arch/riscv/include/uapi/asm/unistd.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 5c38f21aee78..3a15b6d7584e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12176,6 +12176,7 @@ F:	arch/*/kernel/*/*/perf_event*.c
 F:	arch/*/include/asm/perf_event.h
 F:	arch/*/kernel/perf_callchain.c
 F:	arch/*/events/*
+F:	arch/*/events/*/*
 F:	tools/perf/
 
 PERSONALITY HANDLING
diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index d45f3fbd232e..f15441b07dad 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -116,6 +116,110 @@ static __initconst const u64 amd_hw_cache_event_ids
  },
 };
 
+static __initconst const u64 amd_hw_cache_event_ids_f17h
+				[PERF_COUNT_HW_CACHE_MAX]
+				[PERF_COUNT_HW_CACHE_OP_MAX]
+				[PERF_COUNT_HW_CACHE_RESULT_MAX] = {
+[C(L1D)] = {
+	[C(OP_READ)] = {
+		[C(RESULT_ACCESS)] = 0x0040, /* Data Cache Accesses */
+		[C(RESULT_MISS)]   = 0xc860, /* L2$ access from DC Miss */
+	},
+	[C(OP_WRITE)] = {
+		[C(RESULT_ACCESS)] = 0,
+		[C(RESULT_MISS)]   = 0,
+	},
+	[C(OP_PREFETCH)] = {
+		[C(RESULT_ACCESS)] = 0xff5a, /* h/w prefetch DC Fills */
+		[C(RESULT_MISS)]   = 0,
+	},
+},
+[C(L1I)] = {
+	[C(OP_READ)] = {
+		[C(RESULT_ACCESS)] = 0x0080, /* Instruction cache fetches  */
+		[C(RESULT_MISS)]   = 0x0081, /* Instruction cache misses   */
+	},
+	[C(OP_WRITE)] = {
+		[C(RESULT_ACCESS)] = -1,
+		[C(RESULT_MISS)]   = -1,
+	},
+	[C(OP_PREFETCH)] = {
+		[C(RESULT_ACCESS)] = 0,
+		[C(RESULT_MISS)]   = 0,
+	},
+},
+[C(LL)] = {
+	[C(OP_READ)] = {
+		[C(RESULT_ACCESS)] = 0,
+		[C(RESULT_MISS)]   = 0,
+	},
+	[C(OP_WRITE)] = {
+		[C(RESULT_ACCESS)] = 0,
+		[C(RESULT_MISS)]   = 0,
+	},
+	[C(OP_PREFETCH)] = {
+		[C(RESULT_ACCESS)] = 0,
+		[C(RESULT_MISS)]   = 0,
+	},
+},
+[C(DTLB)] = {
+	[C(OP_READ)] = {
+		[C(RESULT_ACCESS)] = 0xff45, /* All L2 DTLB accesses */
+		[C(RESULT_MISS)]   = 0xf045, /* L2 DTLB misses (PT walks) */
+	},
+	[C(OP_WRITE)] = {
+		[C(RESULT_ACCESS)] = 0,
+		[C(RESULT_MISS)]   = 0,
+	},
+	[C(OP_PREFETCH)] = {
+		[C(RESULT_ACCESS)] = 0,
+		[C(RESULT_MISS)]   = 0,
+	},
+},
+[C(ITLB)] = {
+	[C(OP_READ)] = {
+		[C(RESULT_ACCESS)] = 0x0084, /* L1 ITLB misses, L2 ITLB hits */
+		[C(RESULT_MISS)]   = 0xff85, /* L1 ITLB misses, L2 misses */
+	},
+	[C(OP_WRITE)] = {
+		[C(RESULT_ACCESS)] = -1,
+		[C(RESULT_MISS)]   = -1,
+	},
+	[C(OP_PREFETCH)] = {
+		[C(RESULT_ACCESS)] = -1,
+		[C(RESULT_MISS)]   = -1,
+	},
+},
+[C(BPU)] = {
+	[C(OP_READ)] = {
+		[C(RESULT_ACCESS)] = 0x00c2, /* Retired Branch Instr.      */
+		[C(RESULT_MISS)]   = 0x00c3, /* Retired Mispredicted BI    */
+	},
+	[C(OP_WRITE)] = {
+		[C(RESULT_ACCESS)] = -1,
+		[C(RESULT_MISS)]   = -1,
+	},
+	[C(OP_PREFETCH)] = {
+		[C(RESULT_ACCESS)] = -1,
+		[C(RESULT_MISS)]   = -1,
+	},
+},
+[C(NODE)] = {
+	[C(OP_READ)] = {
+		[C(RESULT_ACCESS)] = 0,
+		[C(RESULT_MISS)]   = 0,
+	},
+	[C(OP_WRITE)] = {
+		[C(RESULT_ACCESS)] = -1,
+		[C(RESULT_MISS)]   = -1,
+	},
+	[C(OP_PREFETCH)] = {
+		[C(RESULT_ACCESS)] = -1,
+		[C(RESULT_MISS)]   = -1,
+	},
+},
+};
+
 /*
  * AMD Performance Monitor K7 and later, up to and including Family 16h:
  */
@@ -865,9 +969,10 @@ __init int amd_pmu_init(void)
 		x86_pmu.amd_nb_constraints = 0;
 	}
 
-	/* Events are common for all AMDs */
-	memcpy(hw_cache_event_ids, amd_hw_cache_event_ids,
-	       sizeof(hw_cache_event_ids));
+	if (boot_cpu_data.x86 >= 0x17)
+		memcpy(hw_cache_event_ids, amd_hw_cache_event_ids_f17h, sizeof(hw_cache_event_ids));
+	else
+		memcpy(hw_cache_event_ids, amd_hw_cache_event_ids, sizeof(hw_cache_event_ids));
 
 	return 0;
 }
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index f9451566cd9b..d35f4775d5f1 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2091,15 +2091,19 @@ static void intel_pmu_disable_event(struct perf_event *event)
 	cpuc->intel_ctrl_host_mask &= ~(1ull << hwc->idx);
 	cpuc->intel_cp_status &= ~(1ull << hwc->idx);
 
-	if (unlikely(event->attr.precise_ip))
-		intel_pmu_pebs_disable(event);
-
 	if (unlikely(hwc->config_base == MSR_ARCH_PERFMON_FIXED_CTR_CTRL)) {
 		intel_pmu_disable_fixed(hwc);
 		return;
 	}
 
 	x86_pmu_disable_event(event);
+
+	/*
+	 * Needs to be called after x86_pmu_disable_event,
+	 * so we don't trigger the event without PEBS bit set.
+	 */
+	if (unlikely(event->attr.precise_ip))
+		intel_pmu_pebs_disable(event);
 }
 
 static void intel_pmu_del_event(struct perf_event *event)
diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index fb3a2f13fc70..339d7628080c 100644
--- a/arch/x86/events/intel/pt.c
+++ b/arch/x86/events/intel/pt.c
@@ -1525,8 +1525,7 @@ static __init int pt_init(void)
 	}
 
 	if (!intel_pt_validate_hw_cap(PT_CAP_topa_multiple_entries))
-		pt_pmu.pmu.capabilities =
-			PERF_PMU_CAP_AUX_NO_SG | PERF_PMU_CAP_AUX_SW_DOUBLEBUF;
+		pt_pmu.pmu.capabilities = PERF_PMU_CAP_AUX_NO_SG;
 
 	pt_pmu.pmu.capabilities	|= PERF_PMU_CAP_EXCLUSIVE | PERF_PMU_CAP_ITRACE;
 	pt_pmu.pmu.attr_groups		 = pt_attr_groups;
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index e47ef764f613..1f678f023850 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -240,7 +240,6 @@ struct perf_event;
 #define PERF_PMU_CAP_NO_INTERRUPT		0x01
 #define PERF_PMU_CAP_NO_NMI			0x02
 #define PERF_PMU_CAP_AUX_NO_SG			0x04
-#define PERF_PMU_CAP_AUX_SW_DOUBLEBUF		0x08
 #define PERF_PMU_CAP_EXCLUSIVE			0x10
 #define PERF_PMU_CAP_ITRACE			0x20
 #define PERF_PMU_CAP_HETEROGENEOUS_CPUS		0x40
diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index 5eedb49a65ea..674b35383491 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -610,8 +610,7 @@ int rb_alloc_aux(struct ring_buffer *rb, struct perf_event *event,
 	 * PMU requests more than one contiguous chunks of memory
 	 * for SW double buffering
 	 */
-	if ((event->pmu->capabilities & PERF_PMU_CAP_AUX_SW_DOUBLEBUF) &&
-	    !overwrite) {
+	if (!overwrite) {
 		if (!max_order)
 			return -EINVAL;
 
diff --git a/tools/arch/arc/include/uapi/asm/unistd.h b/tools/arch/arc/include/uapi/asm/unistd.h
new file mode 100644
index 000000000000..5eafa1115162
--- /dev/null
+++ b/tools/arch/arc/include/uapi/asm/unistd.h
@@ -0,0 +1,51 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Copyright (C) 2004, 2007-2010, 2011-2012 Synopsys, Inc. (www.synopsys.com)
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+/******** no-legacy-syscalls-ABI *******/
+
+/*
+ * Non-typical guard macro to enable inclusion twice in ARCH sys.c
+ * That is how the Generic syscall wrapper generator works
+ */
+#if !defined(_UAPI_ASM_ARC_UNISTD_H) || defined(__SYSCALL)
+#define _UAPI_ASM_ARC_UNISTD_H
+
+#define __ARCH_WANT_RENAMEAT
+#define __ARCH_WANT_STAT64
+#define __ARCH_WANT_SET_GET_RLIMIT
+#define __ARCH_WANT_SYS_EXECVE
+#define __ARCH_WANT_SYS_CLONE
+#define __ARCH_WANT_SYS_VFORK
+#define __ARCH_WANT_SYS_FORK
+#define __ARCH_WANT_TIME32_SYSCALLS
+
+#define sys_mmap2 sys_mmap_pgoff
+
+#include <asm-generic/unistd.h>
+
+#define NR_syscalls	__NR_syscalls
+
+/* Generic syscall (fs/filesystems.c - lost in asm-generic/unistd.h */
+#define __NR_sysfs		(__NR_arch_specific_syscall + 3)
+
+/* ARC specific syscall */
+#define __NR_cacheflush		(__NR_arch_specific_syscall + 0)
+#define __NR_arc_settls		(__NR_arch_specific_syscall + 1)
+#define __NR_arc_gettls		(__NR_arch_specific_syscall + 2)
+#define __NR_arc_usr_cmpxchg	(__NR_arch_specific_syscall + 4)
+
+__SYSCALL(__NR_cacheflush, sys_cacheflush)
+__SYSCALL(__NR_arc_settls, sys_arc_settls)
+__SYSCALL(__NR_arc_gettls, sys_arc_gettls)
+__SYSCALL(__NR_arc_usr_cmpxchg, sys_arc_usr_cmpxchg)
+__SYSCALL(__NR_sysfs, sys_sysfs)
+
+#undef __SYSCALL
+
+#endif
diff --git a/tools/arch/hexagon/include/uapi/asm/unistd.h b/tools/arch/hexagon/include/uapi/asm/unistd.h
new file mode 100644
index 000000000000..432c4db1b623
--- /dev/null
+++ b/tools/arch/hexagon/include/uapi/asm/unistd.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Syscall support for Hexagon
+ *
+ * Copyright (c) 2010-2011, The Linux Foundation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
+ * 02110-1301, USA.
+ */
+
+/*
+ *  The kernel pulls this unistd.h in three different ways:
+ *  1.  the "normal" way which gets all the __NR defines
+ *  2.  with __SYSCALL defined to produce function declarations
+ *  3.  with __SYSCALL defined to produce syscall table initialization
+ *  See also:  syscalltab.c
+ */
+
+#define sys_mmap2 sys_mmap_pgoff
+#define __ARCH_WANT_RENAMEAT
+#define __ARCH_WANT_STAT64
+#define __ARCH_WANT_SET_GET_RLIMIT
+#define __ARCH_WANT_SYS_EXECVE
+#define __ARCH_WANT_SYS_CLONE
+#define __ARCH_WANT_SYS_VFORK
+#define __ARCH_WANT_SYS_FORK
+#define __ARCH_WANT_TIME32_SYSCALLS
+
+#include <asm-generic/unistd.h>
diff --git a/tools/arch/riscv/include/uapi/asm/unistd.h b/tools/arch/riscv/include/uapi/asm/unistd.h
new file mode 100644
index 000000000000..0e2eeeb1fd27
--- /dev/null
+++ b/tools/arch/riscv/include/uapi/asm/unistd.h
@@ -0,0 +1,42 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Copyright (C) 2018 David Abdurachmanov <david.abdurachmanov@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifdef __LP64__
+#define __ARCH_WANT_NEW_STAT
+#define __ARCH_WANT_SET_GET_RLIMIT
+#endif /* __LP64__ */
+
+#include <asm-generic/unistd.h>
+
+/*
+ * Allows the instruction cache to be flushed from userspace.  Despite RISC-V
+ * having a direct 'fence.i' instruction available to userspace (which we
+ * can't trap!), that's not actually viable when running on Linux because the
+ * kernel might schedule a process on another hart.  There is no way for
+ * userspace to handle this without invoking the kernel (as it doesn't know the
+ * thread->hart mappings), so we've defined a RISC-V specific system call to
+ * flush the instruction cache.
+ *
+ * __NR_riscv_flush_icache is defined to flush the instruction cache over an
+ * address range, with the flush applying to either all threads or just the
+ * caller.  We don't currently do anything with the address range, that's just
+ * in there for forwards compatibility.
+ */
+#ifndef __NR_riscv_flush_icache
+#define __NR_riscv_flush_icache (__NR_arch_specific_syscall + 15)
+#endif
+__SYSCALL(__NR_riscv_flush_icache, sys_riscv_flush_icache)
diff --git a/tools/arch/x86/include/uapi/asm/vmx.h b/tools/arch/x86/include/uapi/asm/vmx.h
index f0b0c90dd398..d213ec5c3766 100644
--- a/tools/arch/x86/include/uapi/asm/vmx.h
+++ b/tools/arch/x86/include/uapi/asm/vmx.h
@@ -146,6 +146,7 @@
 
 #define VMX_ABORT_SAVE_GUEST_MSR_FAIL        1
 #define VMX_ABORT_LOAD_HOST_PDPTE_FAIL       2
+#define VMX_ABORT_VMCS_CORRUPTED             3
 #define VMX_ABORT_LOAD_HOST_MSR_FAIL         4
 
 #endif /* _UAPIVMX_H */
diff --git a/tools/lib/traceevent/parse-utils.c b/tools/lib/traceevent/parse-utils.c
index 77e4ec6402dd..e99867111387 100644
--- a/tools/lib/traceevent/parse-utils.c
+++ b/tools/lib/traceevent/parse-utils.c
@@ -14,7 +14,7 @@
 void __vwarning(const char *fmt, va_list ap)
 {
 	if (errno)
-		perror("trace-cmd");
+		perror("libtraceevent");
 	errno = 0;
 
 	fprintf(stderr, "  ");
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index fe3f97e342fa..6d65874e16c3 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -227,7 +227,7 @@ FEATURE_CHECK_LDFLAGS-libpython-version := $(PYTHON_EMBED_LDOPTS)
 
 FEATURE_CHECK_LDFLAGS-libaio = -lrt
 
-FEATURE_CHECK_LDFLAGS-disassembler-four-args = -lbfd -lopcodes
+FEATURE_CHECK_LDFLAGS-disassembler-four-args = -lbfd -lopcodes -ldl
 
 CFLAGS += -fno-omit-frame-pointer
 CFLAGS += -ggdb3
diff --git a/tools/perf/bench/numa.c b/tools/perf/bench/numa.c
index 98ad783efc69..a7784554a80d 100644
--- a/tools/perf/bench/numa.c
+++ b/tools/perf/bench/numa.c
@@ -39,6 +39,10 @@
 #include <numa.h>
 #include <numaif.h>
 
+#ifndef RUSAGE_THREAD
+# define RUSAGE_THREAD 1
+#endif
+
 /*
  * Regular printout to the terminal, supressed if -q is specified:
  */
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index c8b01176c9e1..09762985c713 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1714,8 +1714,8 @@ static int symbol__disassemble_bpf(struct symbol *sym,
 	if (dso->binary_type != DSO_BINARY_TYPE__BPF_PROG_INFO)
 		return -1;
 
-	pr_debug("%s: handling sym %s addr %lx len %lx\n", __func__,
-		 sym->name, sym->start, sym->end - sym->start);
+	pr_debug("%s: handling sym %s addr %" PRIx64 " len %" PRIx64 "\n", __func__,
+		  sym->name, sym->start, sym->end - sym->start);
 
 	memset(tpath, 0, sizeof(tpath));
 	perf_exe(tpath, sizeof(tpath));
@@ -1740,7 +1740,7 @@ static int symbol__disassemble_bpf(struct symbol *sym,
 	info_linear = info_node->info_linear;
 	sub_id = dso->bpf_prog.sub_id;
 
-	info.buffer = (void *)(info_linear->info.jited_prog_insns);
+	info.buffer = (void *)(uintptr_t)(info_linear->info.jited_prog_insns);
 	info.buffer_length = info_linear->info.jited_prog_len;
 
 	if (info_linear->info.nr_line_info)
@@ -1776,7 +1776,7 @@ static int symbol__disassemble_bpf(struct symbol *sym,
 		const char *srcline;
 		u64 addr;
 
-		addr = pc + ((u64 *)(info_linear->info.jited_ksyms))[sub_id];
+		addr = pc + ((u64 *)(uintptr_t)(info_linear->info.jited_ksyms))[sub_id];
 		count = disassemble(pc, &info);
 
 		if (prog_linfo)
diff --git a/tools/perf/util/cloexec.c b/tools/perf/util/cloexec.c
index ca0fff6272be..06f48312c5ed 100644
--- a/tools/perf/util/cloexec.c
+++ b/tools/perf/util/cloexec.c
@@ -7,7 +7,6 @@
 #include "asm/bug.h"
 #include "debug.h"
 #include <unistd.h>
-#include <asm/unistd.h>
 #include <sys/syscall.h>
 
 static unsigned long flag = PERF_FLAG_FD_CLOEXEC;
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 110804936fc3..de488b43f440 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -422,11 +422,9 @@ static struct cs_etm_queue *cs_etm__alloc_queue(struct cs_etm_auxtrace *etm)
 	if (!etmq->packet)
 		goto out_free;
 
-	if (etm->synth_opts.last_branch || etm->sample_branches) {
-		etmq->prev_packet = zalloc(szp);
-		if (!etmq->prev_packet)
-			goto out_free;
-	}
+	etmq->prev_packet = zalloc(szp);
+	if (!etmq->prev_packet)
+		goto out_free;
 
 	if (etm->synth_opts.last_branch) {
 		size_t sz = sizeof(struct branch_stack);
@@ -981,7 +979,6 @@ static int cs_etm__sample(struct cs_etm_queue *etmq)
 	 * PREV_PACKET is a branch.
 	 */
 	if (etm->synth_opts.last_branch &&
-	    etmq->prev_packet &&
 	    etmq->prev_packet->sample_type == CS_ETM_RANGE &&
 	    etmq->prev_packet->last_instr_taken_branch)
 		cs_etm__update_last_branch_rb(etmq);
@@ -1014,7 +1011,7 @@ static int cs_etm__sample(struct cs_etm_queue *etmq)
 		etmq->period_instructions = instrs_over;
 	}
 
-	if (etm->sample_branches && etmq->prev_packet) {
+	if (etm->sample_branches) {
 		bool generate_sample = false;
 
 		/* Generate sample for tracing on packet */
@@ -1071,9 +1068,6 @@ static int cs_etm__flush(struct cs_etm_queue *etmq)
 	struct cs_etm_auxtrace *etm = etmq->etm;
 	struct cs_etm_packet *tmp;
 
-	if (!etmq->prev_packet)
-		return 0;
-
 	/* Handle start tracing packet */
 	if (etmq->prev_packet->sample_type == CS_ETM_EMPTY)
 		goto swap_packet;
diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index 9494f9dc61ec..6a3eaf7d9353 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -115,8 +115,8 @@ struct btf_node *perf_env__find_btf(struct perf_env *env, __u32 btf_id)
 	}
 	node = NULL;
 
-	up_read(&env->bpf_progs.lock);
 out:
+	up_read(&env->bpf_progs.lock);
 	return node;
 }
 
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index b17f1c9bc965..bad5f87ae001 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1928,12 +1928,14 @@ reader__process_events(struct reader *rd, struct perf_session *session,
 
 	size = event->header.size;
 
+	skip = -EINVAL;
+
 	if (size < sizeof(struct perf_event_header) ||
 	    (skip = rd->process(session, event, file_pos)) < 0) {
-		pr_err("%#" PRIx64 " [%#x]: failed to process type: %d\n",
+		pr_err("%#" PRIx64 " [%#x]: failed to process type: %d [%s]\n",
 		       file_offset + head, event->header.size,
-		       event->header.type);
-		err = -EINVAL;
+		       event->header.type, strerror(-skip));
+		err = skip;
 		goto out;
 	}
 
