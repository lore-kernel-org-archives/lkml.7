Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A57EAC04AAA
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 09:03:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68F1B20830
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 09:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557133398;
	bh=XE9G54BRVqRzykvekWmbd+bpIIDipqXWSl4Mory21vg=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=V7YYDiJ95Eg3KTIz1bSMhxTGOGbdwfBzARZ9pqfq5Vl/SbmoAzPrmxOmXYznnTfXm
	 VP+Fz1MuDuxXwiWrbTdrNeijThiEfBTH7yWawMjVArGBu7S6NC3jIichRLJ7mWX4nR
	 bVpBGXbKIeTXIv+0jzzbItOBZ3zrEOWjrQ3dnFaU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbfEFJDR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 05:03:17 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38875 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbfEFJDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 05:03:16 -0400
Received: by mail-wr1-f66.google.com with SMTP id k16so16232439wrn.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 02:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=7P169NjqaLSfeQ2srHWpfFVtSpKty08z0+NJmkabOZQ=;
        b=FRkQcWAJp/J3+F5yYuBocQKO1obktFMKSIhulvybYdI/B+5c7hPJCNMmXTk9pDkT6P
         V8o9KKo5CsjP0v4JWiMo4p2BuRl4EY+iIji9KsmebTQcmwOyCJ0uXhVJZmPeXJJfXiLn
         23MztQ7bFSmgpFYljRcQjMwdZ/t6FipkJBp3qPoFVTJ/Ig6G99Yuv70bsBHS+tGMm0NA
         o4ltbh8IVM1wCPcpa+kx2vkBkLv7MJMuWs/XOgToTdttASlqSD4Gd37JNxju4VcbGXfF
         3mKb883kax91Lf6zWHe5wXLMh9+h8nLJ6DV8SlfFRr54DaMovluFPaQC8nZgIIvOVcb2
         QAgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=7P169NjqaLSfeQ2srHWpfFVtSpKty08z0+NJmkabOZQ=;
        b=H9eEcsULNAjfdLfnbKoPZ2B7yiqnd7DSGPkoGfGZT8iowrSgrXQ2esm4JJ+wi4yJNe
         BN4AermEALyE9sG2ToK1wwvpTnt2SitpCwHHdjXKXM9phGXlx+wVM2Tx77ZTPxErJfLR
         1uiTZzb2OZflRisfc7CQOGF/fbxOgwkxiXFjBMkBZjSLAOcumks6PQ97Mti7YA91we4D
         OSt3saZbMD/nw66nC/o3n+zSUxXiaEdF+lX3e1PqbRsnhDpANraAJqjfjWRp0GJrRb9x
         ItvAbvjP2upO5MGNNZ7XjmzBdYwq4nqvivYiVLLvcDeJ5nLkScstjvyWc9//rzem3QzD
         iEYA==
X-Gm-Message-State: APjAAAVa2g/j4Xkc+88gcgX6PzisTaUKKBFhRIdTiZAOkREddyPOTXjT
        N382Yk9Xbi1vIJ/XpFpovaI=
X-Google-Smtp-Source: APXvYqzJC2zF+in1up+o9vg9lXut9LNpSohaOKlT/wHXy+L3LOxM0CUHYDuydCbu6JMl5/TQpFhf9Q==
X-Received: by 2002:adf:dd8e:: with SMTP id x14mr16313653wrl.252.1557133394215;
        Mon, 06 May 2019 02:03:14 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id x17sm8078495wru.27.2019.05.06.02.03.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 May 2019 02:03:13 -0700 (PDT)
Date:   Mon, 6 May 2019 11:03:11 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@infradead.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] perf updates for v5.2
Message-ID: <20190506090311.GA80882@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest perf-core-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-core-for-linus

   # HEAD: d15d356887e770c5f2dcf963b52c7cb510c9e42d perf/x86: Make perf callchains work without CONFIG_FRAME_POINTER

The main kernel changes were:

 - Add support for Intel's "adaptive PEBS v4" - which embedds LBS data in 
   PEBS records and can thus batch up and reduce the IRQ (NMI) rate 
   significantly - reducing overhead and making call-graph profiling less 
   intrusive.

 - Add Intel CPU core and uncore support updates for Tremont, Icelake,

 - Extend the x86 PMU constraints scheduler with 'constraint ranges' to 
   better support Icelake hw constraints,

 - Make x86 call-chain support work better with CONFIG_FRAME_POINTER=y

 - misc other changes.

Tooling changes:

 - Updates to the main tools: 'perf record', 'perf trace', 'perf stat',

 - Updated Intel and S/390 vendor events,

 - libtraceevent updates,

 - misc other updates and fixes.

 Thanks,

	Ingo

------------------>
Alexey Budankov (2):
      tools build: Implement libzstd feature check, LIBZSTD_DIR and NO_LIBZSTD defines
      perf record: Implement --mmap-flush=<number> option

Andi Kleen (23):
      perf stat: Revert checks for duration_time
      perf stat: Implement duration_time as a proper event
      perf evsel: Support printing evsel name for 'duration_time'
      perf list: Output tool events
      perf vendor events intel: Update metrics from TMAM 3.5
      perf vendor events intel: Update Broadwell events to v23
      perf vendor events intel: Update Broadwell-DE events to v7
      perf vendor events intel: Update Skylake events to v42
      perf vendor events intel: Update SkylakeX events to v1.12
      perf vendor events intel: Update BroadwellX events to v14
      perf vendor events intel: Update HaswellX events to v20
      perf vendor events intel: Update IvyTown events to v20
      perf vendor events intel: Update JakeTown events to v20
      perf vendor events intel: Update SandyBridge events to v16
      perf vendor events intel: Update IvyBridge events to v21
      perf vendor events intel: Update Haswell events to v28
      perf vendor events intel: Update KnightsLanding events to v9
      perf vendor events intel: Update Bonnell to V4
      perf vendor events intel: Update Goldmont to v13
      perf vendor events intel: Update GoldmontPlus to v1.01
      perf vendor events intel: Update Silvermont to v14
      perf/x86/intel: Extract memory code PEBS parser for reuse
      perf/x86/lbr: Avoid reading the LBRs when adaptive PEBS handles them

Arash Fotouhi (1):
      watchdog: Fix typo in comment

Arnaldo Carvalho de Melo (5):
      perf trace: Add 'string' event alias to select syscalls with string args
      perf augmented_raw_syscalls: Copy strings from all syscalls with 1st or 2nd string arg
      perf augmented_raw_syscalls: Use a PERCPU_ARRAY map to copy more string bytes
      perf trace beauty renameat: No need to include linux/fs.h
      perf tools: Add header defining used namespace struct to event.h

Kairui Song (1):
      perf/x86: Make perf callchains work without CONFIG_FRAME_POINTER

Kan Liang (9):
      perf/x86: Support outputting XMM registers
      perf/x86/intel/ds: Extract code of event update in short period
      perf/x86/intel: Support adaptive PEBS v4
      perf/x86/intel: Add Icelake support
      perf/x86/intel/cstate: Add Icelake support
      perf/x86/intel/rapl: Add Icelake support
      perf/x86/msr: Add Icelake support
      perf/x86/intel/uncore: Add Intel Icelake uncore support
      perf/x86/intel: Add Tremont core PMU support

Peter Zijlstra (8):
      perf/x86/intel: Simplify intel_tfa_commit_scheduling()
      perf/x86: Simplify x86_pmu.get_constraints() interface
      perf/x86: Remove PERF_X86_EVENT_COMMITTED
      perf/x86/intel: Optimize intel_get_excl_constraints()
      perf/x86: Clear ->event_constraint[] on put
      perf/x86: Optimize x86_schedule_events()
      perf/x86: Add sanity checks to x86_schedule_events()
      perf/x86: Support constraint ranges

Shaokun Zhang (1):
      perf/headers: Fix stale comment for struct perf_addr_filter

Stephane Eranian (2):
      perf/core: Add perf_pmu_resched() as global function
      perf/x86/intel: Force resched when TFA sysctl is modified

Steven Rostedt (Red Hat) (1):
      tools lib traceevent: Add more debugging to see various internal ring buffer entries

Steven Rostedt (VMware) (3):
      tools lib traceevent: Handle trace_printk() "%px"
      tools lib traceevent: Add mono clocks to be parsed in seconds
      tools lib traceevent: Removed unneeded !! and return parenthesis

Thomas Richter (1):
      perf list: Fix s390 counter long description for L1D_RO_EXCL_WRITES

Tzvetomir Stoyanov (11):
      tools lib traceevent: Implement a new API, tep_list_events_copy()
      tools lib traceevent: Change description of few APIs
      tools lib traceevent: Coding style fixes
      tools lib traceevent: Implement new traceevent APIs for accessing struct tep_handler fields
      tools lib traceevent: Remove tep filter trivial APIs
      tools lib traceevent: Remove call to exit() from tep_filter_add_filter_str()
      tools tools, tools lib traceevent: Make traceevent APIs more consistent
      tools lib traceevent: Rename input arguments of libtraceevent APIs from pevent to tep
      perf tools, tools lib traceevent: Rename "pevent" member of struct tep_event to "tep"
      perf tools, tools lib traceevent: Rename "pevent" member of struct tep_event_filter to "tep"
      tools lib traceevent: Rename input arguments and local variables of libtraceevent from pevent to tep

Valdis Kletnieks (1):
      perf/core: Make perf_swevent_init_cpu() static


 arch/x86/events/core.c                             |   95 +-
 arch/x86/events/intel/core.c                       |  296 ++-
 arch/x86/events/intel/cstate.c                     |    2 +
 arch/x86/events/intel/ds.c                         |  505 ++++-
 arch/x86/events/intel/lbr.c                        |   35 +-
 arch/x86/events/intel/rapl.c                       |    2 +
 arch/x86/events/intel/uncore.c                     |    6 +
 arch/x86/events/intel/uncore.h                     |    1 +
 arch/x86/events/intel/uncore_snb.c                 |   91 +
 arch/x86/events/msr.c                              |    1 +
 arch/x86/events/perf_event.h                       |   98 +-
 arch/x86/include/asm/intel_ds.h                    |    2 +-
 arch/x86/include/asm/msr-index.h                   |    1 +
 arch/x86/include/asm/perf_event.h                  |   57 +-
 arch/x86/include/asm/stacktrace.h                  |   13 -
 arch/x86/include/uapi/asm/perf_regs.h              |   23 +-
 arch/x86/kernel/perf_regs.c                        |   27 +-
 include/linux/perf_event.h                         |   19 +-
 kernel/events/core.c                               |   12 +-
 kernel/watchdog.c                                  |    2 +-
 tools/build/Makefile.feature                       |    2 +
 tools/build/feature/Makefile                       |    6 +-
 tools/build/feature/test-all.c                     |    5 +
 tools/build/feature/test-libzstd.c                 |   12 +
 tools/lib/traceevent/event-parse-api.c             |  278 ++-
 tools/lib/traceevent/event-parse-local.h           |    6 +-
 tools/lib/traceevent/event-parse.c                 |  909 ++++----
 tools/lib/traceevent/event-parse.h                 |  154 +-
 tools/lib/traceevent/event-plugin.c                |   32 +-
 tools/lib/traceevent/kbuffer-parse.c               |   49 +
 tools/lib/traceevent/kbuffer.h                     |   13 +
 tools/lib/traceevent/parse-filter.c                |  216 +-
 tools/lib/traceevent/plugin_cfg80211.c             |    8 +-
 tools/lib/traceevent/plugin_function.c             |   14 +-
 tools/lib/traceevent/plugin_hrtimer.c              |   12 +-
 tools/lib/traceevent/plugin_jbd2.c                 |   12 +-
 tools/lib/traceevent/plugin_kmem.c                 |   32 +-
 tools/lib/traceevent/plugin_kvm.c                  |   48 +-
 tools/lib/traceevent/plugin_mac80211.c             |    8 +-
 tools/lib/traceevent/plugin_sched_switch.c         |   18 +-
 tools/lib/traceevent/plugin_scsi.c                 |    8 +-
 tools/lib/traceevent/plugin_xen.c                  |    8 +-
 tools/perf/Documentation/perf-record.txt           |   19 +
 tools/perf/Makefile.config                         |   20 +
 tools/perf/Makefile.perf                           |    3 +
 tools/perf/builtin-kmem.c                          |    2 +-
 tools/perf/builtin-list.c                          |    6 +-
 tools/perf/builtin-record.c                        |   65 +-
 tools/perf/builtin-stat.c                          |   28 +-
 tools/perf/builtin-version.c                       |    2 +
 tools/perf/examples/bpf/augmented_raw_syscalls.c   |  196 +-
 tools/perf/perf.h                                  |    1 +
 .../perf/pmu-events/arch/s390/cf_z14/extended.json |    2 +-
 .../perf/pmu-events/arch/x86/bonnell/frontend.json |    2 +-
 .../perf/pmu-events/arch/x86/bonnell/pipeline.json |    2 +-
 .../pmu-events/arch/x86/broadwell/bdw-metrics.json |  260 ++-
 .../perf/pmu-events/arch/x86/broadwell/cache.json  | 1630 +++++++--------
 .../arch/x86/broadwell/floating-point.json         |   51 +-
 .../pmu-events/arch/x86/broadwell/frontend.json    |    4 +-
 .../perf/pmu-events/arch/x86/broadwell/memory.json | 1640 +++++++--------
 .../pmu-events/arch/x86/broadwell/pipeline.json    |   36 +-
 .../pmu-events/arch/x86/broadwellde/cache.json     |    4 +-
 .../pmu-events/arch/x86/broadwellde/pipeline.json  |    6 +-
 .../arch/x86/broadwellx/bdx-metrics.json           |  278 ++-
 .../perf/pmu-events/arch/x86/broadwellx/cache.json |  161 +-
 .../arch/x86/broadwellx/floating-point.json        |   16 +-
 .../pmu-events/arch/x86/broadwellx/memory.json     |  148 +-
 .../pmu-events/arch/x86/broadwellx/pipeline.json   |   50 +-
 .../arch/x86/cascadelakex/clx-metrics.json         |  304 ++-
 tools/perf/pmu-events/arch/x86/goldmont/cache.json | 1244 +++--------
 .../perf/pmu-events/arch/x86/goldmont/memory.json  |  260 ---
 .../pmu-events/arch/x86/goldmont/pipeline.json     |    5 +-
 .../arch/x86/goldmont/virtual-memory.json          |    9 +-
 .../pmu-events/arch/x86/goldmontplus/cache.json    |   74 +-
 .../pmu-events/arch/x86/goldmontplus/pipeline.json |    5 +-
 .../arch/x86/goldmontplus/virtual-memory.json      |    9 +-
 tools/perf/pmu-events/arch/x86/haswell/cache.json  |  175 +-
 .../arch/x86/haswell/floating-point.json           |   33 +-
 .../pmu-events/arch/x86/haswell/hsw-metrics.json   |  234 ++-
 tools/perf/pmu-events/arch/x86/haswell/memory.json |  172 +-
 .../perf/pmu-events/arch/x86/haswell/pipeline.json |   33 +-
 tools/perf/pmu-events/arch/x86/haswellx/cache.json |  173 +-
 .../pmu-events/arch/x86/haswellx/hsx-metrics.json  |  252 ++-
 .../perf/pmu-events/arch/x86/haswellx/memory.json  |  172 +-
 .../pmu-events/arch/x86/haswellx/pipeline.json     |   10 +-
 .../perf/pmu-events/arch/x86/ivybridge/cache.json  |   10 +-
 .../pmu-events/arch/x86/ivybridge/ivb-metrics.json |  250 ++-
 .../pmu-events/arch/x86/ivybridge/pipeline.json    |    4 -
 .../pmu-events/arch/x86/ivytown/ivt-metrics.json   |  256 ++-
 .../perf/pmu-events/arch/x86/ivytown/pipeline.json |    4 -
 tools/perf/pmu-events/arch/x86/jaketown/cache.json |    6 +-
 .../pmu-events/arch/x86/jaketown/jkt-metrics.json  |  150 +-
 .../pmu-events/arch/x86/jaketown/pipeline.json     |   12 +-
 .../pmu-events/arch/x86/knightslanding/cache.json  |  666 +++---
 .../pmu-events/arch/x86/knightslanding/memory.json |  268 +--
 .../arch/x86/knightslanding/pipeline.json          |   15 +-
 .../arch/x86/knightslanding/virtual-memory.json    |    2 +-
 .../pmu-events/arch/x86/sandybridge/cache.json     |  680 +++---
 .../arch/x86/sandybridge/floating-point.json       |  126 +-
 .../pmu-events/arch/x86/sandybridge/frontend.json  |  268 +--
 .../pmu-events/arch/x86/sandybridge/memory.json    |   68 +-
 .../pmu-events/arch/x86/sandybridge/other.json     |   18 +-
 .../pmu-events/arch/x86/sandybridge/pipeline.json  | 1338 ++++++------
 .../arch/x86/sandybridge/snb-metrics.json          |  144 +-
 .../arch/x86/sandybridge/virtual-memory.json       |  108 +-
 .../perf/pmu-events/arch/x86/silvermont/cache.json |    2 +-
 .../perf/pmu-events/arch/x86/silvermont/other.json |   20 +
 .../pmu-events/arch/x86/silvermont/pipeline.json   |    5 +-
 tools/perf/pmu-events/arch/x86/skylake/cache.json  | 2193 +++++++++++++++++++-
 .../perf/pmu-events/arch/x86/skylake/frontend.json |   14 +-
 tools/perf/pmu-events/arch/x86/skylake/memory.json | 1121 +++++++++-
 .../perf/pmu-events/arch/x86/skylake/pipeline.json |   39 +-
 .../pmu-events/arch/x86/skylake/skl-metrics.json   |  274 ++-
 tools/perf/pmu-events/arch/x86/skylakex/cache.json |  786 ++++---
 .../arch/x86/skylakex/floating-point.json          |    2 -
 .../pmu-events/arch/x86/skylakex/frontend.json     |  234 +--
 .../perf/pmu-events/arch/x86/skylakex/memory.json  |  751 +++----
 .../pmu-events/arch/x86/skylakex/pipeline.json     |  173 +-
 .../pmu-events/arch/x86/skylakex/skx-metrics.json  |  304 ++-
 tools/perf/trace/beauty/renameat.c                 |    1 -
 tools/perf/trace/strace/groups/string              |   65 +
 tools/perf/util/data-convert-bt.c                  |    4 +-
 tools/perf/util/event.h                            |    1 +
 tools/perf/util/evlist.c                           |    6 +-
 tools/perf/util/evlist.h                           |    3 +-
 tools/perf/util/evsel.c                            |   11 +-
 tools/perf/util/evsel.h                            |    6 +
 tools/perf/util/mmap.c                             |    4 +-
 tools/perf/util/mmap.h                             |    3 +-
 tools/perf/util/parse-events.c                     |   58 +-
 tools/perf/util/parse-events.h                     |    5 +
 tools/perf/util/parse-events.l                     |   11 +-
 tools/perf/util/parse-events.y                     |   12 +
 tools/perf/util/python.c                           |    2 +-
 .../perf/util/scripting-engines/trace-event-perl.c |    2 +-
 .../util/scripting-engines/trace-event-python.c    |    2 +-
 tools/perf/util/stat-display.c                     |   18 -
 tools/perf/util/trace-event-parse.c                |    2 +-
 tools/perf/util/trace-event-read.c                 |    2 +-
 tools/perf/util/trace-event.c                      |    4 +-
 140 files changed, 13358 insertions(+), 8109 deletions(-)
 create mode 100644 tools/build/feature/test-libzstd.c
 create mode 100644 tools/perf/pmu-events/arch/x86/silvermont/other.json
 create mode 100644 tools/perf/trace/strace/groups/string

