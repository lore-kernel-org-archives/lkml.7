Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 684B0C48BE7
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 11:38:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DD0C214AF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 11:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562672310;
	bh=N4S240jBrx5EZrqxy37ci2rDx+qFqqEHcC0lYPe8Rko=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=aYK1E3//AMM6/LUE9B8aYSYB265UFPiWUxzRUEabFWzuL2OEWIKf5ulAb5Auq8aqm
	 ibS278TlHUhzBsrwUUZSfK1wwQsnMpAE6YgujEOn/H93qAEB4o9/IZDxf/CtZBW0q8
	 uBRJbewnO4UbJuGrua4Pn4HLMB/qgLxAN1lCnkck=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726241AbfGILi2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 07:38:28 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36314 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbfGILi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 07:38:28 -0400
Received: by mail-wm1-f68.google.com with SMTP id g67so2880601wme.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2019 04:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=9decHLA+XC3QLq75p9VFautiR9+1GqeQ/d2ft1Rll5g=;
        b=F7AE97Cc0AvqB+swy9Luucyg7wKoxkya7nzXfXorGqicbrltZtXMFJkPwfF5+TZmeU
         FwufzA++b90d7wyqQIwuXVwdQrO6BkKLgOmoVxFmbMu/Ht6iPWWm9s0oXscO9aqAqKTg
         7MRCUvmjrlV/Kvcj03y6lIUeWcIYbiP9BJTRgetoltI0qvAir7H6XdjiOutPpaXX/KxB
         2yh57TrblEUoYLnlvXogH6EHlC025v8GlynZs2lp6nooZbV0wsJPd1zVQ+Ojaz9OocoF
         h7ztr5AteNCf1obhhuGJbtJlxZhMnN+UAw0UhsdOwsgxBQc3A6H0abOYImYkb8hLzXfy
         Nz/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=9decHLA+XC3QLq75p9VFautiR9+1GqeQ/d2ft1Rll5g=;
        b=DhkiuayH52pJkOyJyW6CC4lecjjY5Q2XZP9fMncFE3s/wGKlndI+y3aZVZ2iEMt8ZR
         w8bRM1A4iYfU7aKmrmFO4vvvWavGdA3Al4DI8ZyPegYZCXUiDQWPAPV10OHYqL68buSj
         9qDaooyaRRdq3z6cfhcCrX1nmMY5OGHO7Vu94NDre61gRqUVFpnoXbXMi3pWdRzSOlbw
         E1c+8XpWXlobaNcqooahQqntWDewWC4iOlNT+gJ0dNVTNvDy09a4aWQR04lQfBLldtIo
         1RR2a8f+4yIwLi/bPsD7rdpHL0XgXyNp3QFprfXd+gmWbSAgVI1pvnHzdOQvWsdMS7RP
         XAeQ==
X-Gm-Message-State: APjAAAXtikOBFhvI4OTAt766UJolAtt2K1YpIFdiIGXRSqimnraB/Drk
        P+woi2D24g/6ZhQTlnqv6R8=
X-Google-Smtp-Source: APXvYqw7cIXoZ+P/Pwn5GPhG5B/BjStfl7P0oHdtGkW8tzPM1N3T7IxHNqe9wZot1Vi+gfeueG+dBQ==
X-Received: by 2002:a1c:7606:: with SMTP id r6mr21043728wmc.118.1562672302262;
        Tue, 09 Jul 2019 04:38:22 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id a2sm3199058wmj.9.2019.07.09.04.38.21
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 09 Jul 2019 04:38:21 -0700 (PDT)
Date:   Tue, 9 Jul 2019 13:38:19 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] perf changes for v5.3
Message-ID: <20190709113819.GA97140@gmail.com>
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

   # HEAD: d1d59b817939821bee149e870ce7723f61ffb512 Merge tag 'perf-urgent-for-mingo-5.3-20190708-2' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/core

The main changes in this cycle on the kernel side were:

 - CPU PMU and uncore driver updates to Intel Snow Ridge, IceLake, 
   KabyLake, AmberLake and WhiskeyLake CPUs.

 - Rework the MSR probing infrastructure to make it more robust, make it 
   work better on virtualized systems and to better expose it on sysfs.

 - Rework PMU attributes group support based on the feedback from Greg - 
   the core sysfs patch that adds sysfs_update_groups() was acked by 
   Greg.

There's a lot of perf tooling changes as well, all around the place:

 - vendor updates to Intel, cs-etm (ARM), ARM64, s390, 

 - various enhancements to Intel PT tooling support:
      - Improve CBR (Core to Bus Ratio) packets support.
      - Export power and ptwrite events to sqlite and postgresql.
      - Add support for decoding PEBS via PT packets.
      - Add support for samples to contain IPC ratio, collecting cycles
        information from CYC packets, showing the IPC info periodically
      - Allow using time ranges

 - lots of updates to perf pmu, perf stat, perf trace, eBPF support,
   perf record, perf diff, etc. - please see the shortlog and Git log for 
   details.

 Thanks,

	Ingo

------------------>
Adrian Hunter (69):
      perf-with-kcore.sh: Always allow fix_buildid_cache_permissions
      perf intel-pt: Fix itrace defaults for perf script
      perf auxtrace: Fix itrace defaults for perf script
      perf intel-pt: Fix itrace defaults for perf script intel-pt documentation
      perf scripts python: exported-sql-viewer.py: Change python2 to python
      perf scripts python: exported-sql-viewer.py: Use argparse module for argument parsing
      perf scripts python: exported-sql-viewer.py: Add support for pyside2
      perf scripts python: export-to-sqlite.py: Add support for pyside2
      perf scripts python: export-to-postgresql.py: Add support for pyside2
      perf intel-pt: Improve sync_switch by processing PERF_RECORD_SWITCH* in events
      perf intel-pt: Rationalize intel_pt_sync_switch()'s use of next_tid
      perf intel-pt: Factor out intel_pt_update_sample_time
      perf intel-pt: Accumulate cycle count from CYC packets
      perf tools: Add IPC information to perf_sample
      perf intel-pt: Add support for samples to contain IPC ratio
      perf script: Add output of IPC ratio
      perf intel-pt: Record when decoding PSB+ packets
      perf intel-pt: Re-factor TIP cases in intel_pt_walk_to_ip
      perf intel-pt: Accumulate cycle count from TSC/TMA/MTC packets
      perf intel-pt: Document IPC usage
      perf thread-stack: Accumulate IPC information
      perf db-export: Add brief documentation
      perf db-export: Export IPC information
      perf scripts python: export-to-sqlite.py: Export IPC information
      perf scripts python: export-to-postgresql.py: Export IPC information
      perf scripts python: exported-sql-viewer.py: Add IPC information to the Branch reports
      perf scripts python: exported-sql-viewer.py: Add CallGraphModelParams
      perf scripts python: exported-sql-viewer.py: Add IPC information to Call Graph Graph
      perf scripts python: exported-sql-viewer.py: Add IPC information to Call Tree
      perf scripts python: exported-sql-viewer.py: Select find text when find bar is activated
      perf auxtrace: Add perf time interval to itrace_synth_ops
      perf script: Set perf time interval in itrace_synth_ops
      perf report: Set perf time interval in itrace_synth_ops
      perf intel-pt: Add lookahead callback
      perf intel-pt: Factor out intel_pt_8b_tsc()
      perf intel-pt: Factor out intel_pt_reposition()
      perf intel-pt: Add reposition parameter to intel_pt_get_data()
      perf intel-pt: Add intel_pt_fast_forward()
      perf intel-pt: Factor out intel_pt_get_buffer()
      perf intel-pt: Add support for lookahead
      perf intel-pt: Add support for efficient time interval filtering
      perf time-utils: Treat time ranges consistently
      perf time-utils: Factor out set_percent_time()
      perf time-utils: Prevent percentage time range overlap
      perf time-utils: Fix --time documentation
      perf time-utils: Simplify perf_time__parse_for_ranges() error paths slightly
      perf time-utils: Make perf_time__parse_for_ranges() more logical
      perf tests: Add a test for time-utils
      perf time-utils: Add support for multiple explicit time intervals
      perf intel-pt: Add new packets for PEBS via PT
      perf intel-pt: Add Intel PT packet decoder test
      perf intel-pt: Add decoder support for PEBS via PT
      perf intel-pt: Prepare to synthesize PEBS samples
      perf intel-pt: Factor out common sample preparation for re-use
      perf intel-pt: Synthesize PEBS sample basic information
      perf intel-pt: Add gp registers to synthesized PEBS sample
      perf intel-pt: Add XMM registers to synthesized PEBS sample
      perf intel-pt: Add LBR information to synthesized PEBS sample
      perf intel-pt: Add memory information to synthesized PEBS sample
      perf intel-pt: Add callchain to synthesized PEBS sample
      perf thread-stack: Fix thread stack return from kernel for kernel-only case
      perf thread-stack: Eliminate code duplicating thread_stack__pop_ks()
      perf intel-pt: Decoder to output CBR changes immediately
      perf intel-pt: Cater for CBR change in PSB+
      perf intel-pt: Add CBR value to decoder state
      perf intel-pt: Synthesize CBR events when last seen value changes
      perf db-export: Export synth events
      perf scripts python: export-to-sqlite.py: Export Intel PT power and ptwrite events
      perf scripts python: export-to-postgresql.py: Export Intel PT power and ptwrite events

Alexey Budankov (1):
      perf record: Allow mixing --user-regs with --call-graph=dwarf

Andi Kleen (8):
      perf stat: Make metric event lookup more robust
      perf stat: Don't merge events in the same PMU
      perf stat: Fix group lookup for metric group
      perf stat: Fix metrics with --no-merge
      perf tools: Fix typos / broken sentences
      perf vendor events intel: Metric fixes for SKX/CLX
      perf list: Avoid extra : for --raw metrics
      perf tools metric: Don't include duration_time in group

Arnaldo Carvalho de Melo (74):
      perf augmented_raw_syscalls: Fix up comment
      perf beauty: Add generator for 'move_mount' flags argument
      perf trace: Beautify 'move_mount' arguments
      perf beauty: Add generator for fspick's 'flags' arg values
      perf trace: Beautify 'fspick' arguments
      perf beauty: Add generator for fsconfig's 'cmd' arg values
      perf trace: Beautify 'fsconfig' arguments
      perf beauty: Add generator for fsmount's 'attr_flags' arg values
      perf trace: Introduce syscall_arg__scnprintf_strarray_flags
      perf trace: Beautify 'fsmount' arguments
      perf trace beauty clone: Handle CLONE_PIDFD
      perf beauty: Add generator for sync_file_range's 'flags' arg values
      perf trace: Beautify 'sync_file_range' arguments
      perf version: Append 12 git SHA chars to the version string
      perf annotate TUI browser: Do not use member from variable within its own initialization
      perf python: Remove -fstack-protector-strong if clang doesn't have it
      perf top: Lower message level for failure on synthesizing events for pre-existing BPF programs
      perf data: Document memory topology header: HEADER_MEM_TOPOLOGY
      perf data: Document clockid header: HEADER_CLOCKID
      perf data: Document directory format header: HEADER_DIR_FORMAT
      perf augmented_raw_syscalls: Tell which args are filenames and how many bytes to copy
      perf augmented_raw_syscalls: Move the probe_read_str to a separate function
      perf augmented_raw_syscalls: Change helper to consider just the augmented_filename part
      perf augmented_raw_syscalls: Move reading filename to the loop
      perf trace: Consume the augmented_raw_syscalls payload
      perf trace: Associate more argument names with the filename beautifier
      perf config: Bail out when a handler returns failure for a key-value pair
      perf data: Fix perf.data documentation for HEADER_CPU_TOPOLOGY
      perf cs-etm: Remove duplicate GENMASK() define, use linux/bits.h instead
      perf trace: Skip unknown syscalls when expanding strace like syscall groups
      tools build: Check if gettid() is available before providing helper
      perf trace: Fix exclusion of not available syscall names from selector list
      perf trace: Streamline validation of select syscall names list
      tools build feature tests: Add missing SPDX headers
      perf tests: Add missing SPDX headers
      perf trace: Fixup pointer arithmetic when consuming augmented syscall args
      perf evsel: Make perf_evsel__name() accept a NULL argument
      tools build: Add test to check if slang.h is in /usr/include/slang/
      perf build: Handle slang being in /usr/include and in /usr/include/slang/
      tools build: Fix the zstd test in the test-all.c common case feature test
      perf ctype: Remove unused 'graph_line' variable
      perf ui stdio: No need to use 'spaces' to left align
      perf ctype: Remove now unused 'spaces' variable
      perf string: Move 'dots' and 'graph_dotted_line' out of sane_ctype.h
      tools x86 machine: Add missing util.h to pick up 'page_size'
      perf kallsyms: Adopt hex2u64 from tools/perf/util/util.h
      perf symbols: We need util.h in symbol-elf.c for zfree()
      perf tools: Remove old baggage that is util/include/linux/ctype.h
      perf tools: Add missing util.h to pick up 'page_size' variable
      tools perf: Move from sane_ctype.h obtained from git to the Linux's original
      perf tools: Use linux/ctype.h in more places
      tools lib: Adopt skip_spaces() from the kernel sources
      perf stat: Use recently introduced skip_spaces()
      perf header: Use skip_spaces() in __write_cpudesc()
      perf time-utils: Use skip_spaces()
      perf probe: Use skip_spaces() for argv handling
      perf strfilter: Use skip_spaces()
      perf metricgroup: Use strsep()
      perf report: Use skip_spaces()
      perf tools: Ditch rtrim(), use skip_spaces() to get closer to the kernel
      tools lib: Adopt strim() from the kernel
      perf tools: Remove trim() implementation, use tools/lib's strim()
      perf tools: Ditch rtrim(), use strim() from tools/lib
      tools lib: Adopt strreplace() from the kernel
      perf tools: Drop strxfrchar(), use strreplace() equivalent from kernel
      tools lib: Move argv_{split,free} from tools/perf/util/
      perf script: Allow specifying the files to process guest samples
      tools arch kvm: Sync kvm headers with the kernel sources
      perf thread: Allow references to thread objects after machine__exit()
      perf annotate TUI browser: Do not use member from variable within its own initialization
      perf python: Remove -fstack-protector-strong if clang doesn't have it
      tools build: Check if gettid() is available before providing helper
      Merge remote-tracking branch 'tip/perf/core' into perf/urgent
      tools arch x86: Sync asm/cpufeatures.h with the with the kernel

Donald Yandt (1):
      perf machine: Return NULL instead of null-terminating /proc/version array

Florian Fainelli (1):
      perf tools: Don't hardcode host include path for libslang

Gayatri Kammela (2):
      perf/x86/intel/uncore: Add tabs to Uncore IMC PCI IDs
      perf/x86/intel/uncore: Add new IMC PCI IDs for KabyLake, AmberLake and WhiskeyLake CPUs

Ian Rogers (1):
      perf/cgroups: Don't rotate events for cgroups unnecessarily

Ingo Molnar (13):
      Merge tag 'perf-core-for-mingo-5.3-20190529' of git://git.kernel.org/.../acme/linux into perf/core
      Merge tag 'v5.2-rc3' into perf/core, to pick up fixes
      Merge branch 'x86/topology' into perf/core, to prepare for new patches
      Merge branch 'x86/cpu' into perf/core, to pick up dependent changes
      Merge tag 'perf-core-for-mingo-5.3-20190611' of git://git.kernel.org/.../acme/linux into perf/core
      Merge tag 'perf-core-for-mingo-5.3-20190621' of git://git.kernel.org/.../acme/linux into perf/core
      Merge tag 'v5.2-rc6' into perf/core, to refresh branch
      Merge branch 'x86/cpu' into perf/core, to pick up dependent patches
      Merge tag 'perf-core-for-mingo-5.3-20190701' of git://git.kernel.org/.../acme/linux into perf/core
      Merge tag 'perf-core-for-mingo-5.3-20190703' of git://git.kernel.org/.../acme/linux into perf/core
      Merge branch 'x86/cpu' into perf/core, to pick up revert
      Merge tag 'v5.2' into perf/core, to pick up fixes
      Merge tag 'perf-urgent-for-mingo-5.3-20190708-2' of git://git.kernel.org/.../acme/linux into perf/core

Jin Yao (7):
      perf symbol: Create block_info structure
      perf hists: Add block_info in hist_entry
      perf diff: Check if all data files with branch stacks
      perf diff: Use hists to manage basic blocks per symbol
      perf diff: Link same basic blocks among different data
      perf diff: Print the basic block cycles diff
      perf diff: Documentation -c cycles option

Jiri Olsa (34):
      perf machine: Keep zero in pgoff BPF map
      perf tools: Preserve eBPF maps when loading kcore
      perf dso: Separate generic code in dso__data_file_size()
      perf dso: Separate generic code in dso_cache__read
      perf dso: Simplify dso_cache__read function
      perf dso: Add BPF DSO read and size hooks
      perf script: Pad DSO name for --call-trace
      perf tests: Add map_groups__merge_in test
      perf script: Add --show-bpf-events to show eBPF related events
      perf script: Remove superfluous BPF event titles
      sysfs: Add sysfs_update_groups function
      perf/core: Add attr_groups_update into struct pmu
      perf/x86: Get rid of x86_pmu::event_attrs
      perf/x86: Use the new pmu::update_attrs attribute group
      perf/x86: Add is_visible attribute_group callback for base events
      perf/x86: Use update attribute groups for caps
      perf/x86: Use update attribute groups for extra format
      perf/x86/intel: Use update attributes for skylake format
      perf/x86: Use update attribute groups for default attributes
      perf jvmti: Address gcc string overflow warning for strncpy()
      perf evsel: Remove superfluous nthreads system_wide setup in alloc_fd()
      perf/x86/intel: Use ->is_visible callback for default group
      perf/x86/intel: Disable check_msr for real HW
      perf/x86: Add MSR probe interface
      perf/x86/msr: Use new probe function
      perf/x86/cstate: Use new probe function
      perf/x86/rapl: Use new MSR detection interface
      perf/x86/rapl: Get rapl_cntr_mask from new probe framework
      perf/x86/rapl: Get MSR values from new probe framework
      perf/x86/rapl: Get attributes from new probe framework
      perf/x86/rapl: Get quirk state from new probe framework
      objtool: Fix build by linking against tools/lib/ctype.o sources
      perf evsel: Do not rely on errno values for precise_ip fallback
      perf jvmti: Address gcc string overflow warning for strncpy()

John Garry (5):
      perf pmu: Fix uncore PMU alias list for ARM64
      perf pmu: Support more complex PMU event aliasing
      perf jevents: Add support for Hisi hip08 DDRC PMU aliasing
      perf jevents: Add support for Hisi hip08 HHA PMU aliasing
      perf jevents: Add support for Hisi hip08 L3C PMU aliasing

Kan Liang (13):
      perf cpumap: Retrieve die id information
      perf header: Add die information in CPU topology
      perf stat: Support per-die aggregation
      perf header: Rename "sibling cores" to "sibling sockets"
      perf tools: Apply new CPU topology sysfs attributes
      perf/x86/intel: Add Icelake desktop CPUID
      perf/x86/intel: Add more Icelake CPUIDs
      perf/x86/intel/uncore: Handle invalid event coding for free-running counter
      perf/x86/intel/uncore: Add uncore support for Snow Ridge server
      perf/x86/intel/uncore: Factor out box ref/unref functions
      perf/x86/intel/uncore: Support MMIO type uncore blocks
      perf/x86/intel/uncore: Clean up client IMC
      perf/x86/intel/uncore: Add IMC uncore support for Snow Ridge

Kyle Meyer (1):
      perf tools: Increase MAX_NR_CPUS and MAX_CACHES

Leo Yan (3):
      perf symbols: Remove unused variable 'err'
      perf trace: Exit when failing to build eBPF program
      perf config: Update default value for llvm.clang-bpf-cmd-template

Luke Mujica (1):
      perf jevents: Use nonlocal include statements in pmu-events.c

Mao Han (1):
      perf annotate: Add csky support

Mathieu Poirier (19):
      perf cs-etm: Configure contextID tracing in CPU-wide mode
      perf cs-etm: Configure timestamp generation in CPU-wide mode
      perf cs-etm: Configure SWITCH_EVENTS in CPU-wide mode
      perf cs-etm: Add handling of itrace start events
      perf cs-etm: Add handling of switch-CPU-wide events
      perf cs-etm: Refactor error path in cs_etm_decoder__new()
      perf cs-etm: Move packet queue out of decoder structure
      perf cs-etm: Fix indentation in function cs_etm__process_decoder_queue()
      perf cs-etm: Introduce the concept of trace ID queues
      perf cs-etm: Get rid of unused cpu in struct cs_etm_queue
      perf cs-etm: Move thread to traceid_queue
      perf cs-etm: Move tid/pid to traceid_queue
      perf cs-etm: Use traceID aware memory callback API
      perf cs-etm: Add support for multiple traceID queues
      perf cs-etm: Linking PE contextID with perf thread mechanic
      perf cs-etm: Add notion of time to decoding code
      perf cs-etm: Add support for CPU-wide trace scenarios
      perf cs-etm: Properly set the value of 'old' and 'head' in snapshot mode
      perf: cs-etm: Optimize option setup for CPU-wide sessions

Namhyung Kim (2):
      perf top: Add --namespaces option
      perf tools: Remove const from thread read accessors

Numfor Mbiziwo-Tiapo (1):
      perf tools: Fix cache.h include directive

Raphael Gault (1):
      perf tests arm64: Compile tests unconditionally

Seeteena Thoufeek (1):
      perf tests: Fix record+probe_libc_inet_pton.sh for powerpc64

Song Liu (3):
      perf/core: Allow non-privileged uprobe for user processes
      perf data: Add description of header HEADER_BPF_PROG_INFO and HEADER_BPF_BTF
      perf header: Assign proper ff->ph in perf_event__synthesize_features()

Thomas Richter (3):
      perf test 6: Fix missing kvm module load for s390
      perf report: Fix OOM error in TUI mode on s390
      perf report: Support s390 diag event display on x86

yuzhoujian (1):
      perf record: Add support to collect callchains from kernel or user space only


 arch/x86/events/Makefile                           |    2 +-
 arch/x86/events/core.c                             |  106 +-
 arch/x86/events/intel/core.c                       |  185 ++--
 arch/x86/events/intel/cstate.c                     |  153 +--
 arch/x86/events/intel/rapl.c                       |  379 ++++----
 arch/x86/events/intel/uncore.c                     |  122 ++-
 arch/x86/events/intel/uncore.h                     |   41 +-
 arch/x86/events/intel/uncore_snb.c                 |  101 +-
 arch/x86/events/intel/uncore_snbep.c               |  601 ++++++++++++
 arch/x86/events/msr.c                              |  110 ++-
 arch/x86/events/perf_event.h                       |    7 +-
 arch/x86/events/probe.c                            |   45 +
 arch/x86/events/probe.h                            |   29 +
 fs/sysfs/group.c                                   |   54 +-
 include/linux/perf_event.h                         |    6 +
 include/linux/sysfs.h                              |    8 +
 kernel/events/core.c                               |   52 +-
 kernel/trace/trace_uprobe.c                        |    2 +-
 tools/arch/arm64/include/uapi/asm/kvm.h            |    7 +
 tools/arch/x86/include/asm/cpufeatures.h           |   21 +-
 tools/arch/x86/include/uapi/asm/kvm.h              |   31 +-
 tools/build/Makefile.feature                       |    3 +-
 tools/build/feature/Makefile                       |   10 +-
 tools/build/feature/test-all.c                     |    7 +-
 tools/build/feature/test-fortify-source.c          |    1 +
 tools/build/feature/test-gettid.c                  |   11 +
 tools/build/feature/test-hello.c                   |    1 +
 tools/build/feature/test-libslang-include-subdir.c |    7 +
 tools/build/feature/test-setns.c                   |    1 +
 tools/include/linux/ctype.h                        |   75 ++
 tools/include/linux/kernel.h                       |    1 +
 tools/include/linux/string.h                       |   11 +-
 tools/lib/argv_split.c                             |  100 ++
 tools/lib/ctype.c                                  |   35 +
 tools/lib/string.c                                 |   55 ++
 tools/lib/symbol/kallsyms.c                        |   14 +-
 tools/lib/symbol/kallsyms.h                        |    2 +
 tools/lib/vsprintf.c                               |   19 +
 tools/objtool/Build                                |    5 +
 tools/perf/Documentation/db-export.txt             |   41 +
 tools/perf/Documentation/intel-pt.txt              |   40 +-
 tools/perf/Documentation/perf-config.txt           |    9 +-
 tools/perf/Documentation/perf-diff.txt             |   31 +-
 tools/perf/Documentation/perf-record.txt           |   11 +
 tools/perf/Documentation/perf-report.txt           |   11 +-
 tools/perf/Documentation/perf-script.txt           |   17 +-
 tools/perf/Documentation/perf-stat.txt             |   10 +
 tools/perf/Documentation/perf-top.txt              |    5 +
 tools/perf/Documentation/perf.data-file-format.txt |   97 +-
 tools/perf/Documentation/tips.txt                  |    2 +-
 tools/perf/MANIFEST                                |    2 +
 tools/perf/Makefile.config                         |   19 +-
 tools/perf/Makefile.perf                           |   44 +-
 tools/perf/arch/arm/util/cs-etm.c                  |  310 +++++-
 tools/perf/arch/arm64/Build                        |    2 +-
 tools/perf/arch/arm64/tests/Build                  |    2 +-
 tools/perf/arch/csky/annotate/instructions.c       |   48 +
 tools/perf/arch/s390/util/header.c                 |    2 +-
 tools/perf/arch/x86/include/arch-tests.h           |    1 +
 tools/perf/arch/x86/tests/Build                    |    2 +-
 tools/perf/arch/x86/tests/arch-tests.c             |    4 +
 tools/perf/arch/x86/tests/intel-cqm.c              |    1 +
 .../arch/x86/tests/intel-pt-pkt-decoder-test.c     |  304 ++++++
 tools/perf/arch/x86/util/intel-pt.c                |    1 +
 tools/perf/arch/x86/util/machine.c                 |    3 +-
 tools/perf/builtin-diff.c                          |  382 +++++++-
 tools/perf/builtin-kmem.c                          |    3 +-
 tools/perf/builtin-record.c                        |    4 +
 tools/perf/builtin-report.c                        |   13 +-
 tools/perf/builtin-sched.c                         |    3 +-
 tools/perf/builtin-script.c                        |  107 +-
 tools/perf/builtin-stat.c                          |   89 +-
 tools/perf/builtin-top.c                           |   10 +-
 tools/perf/builtin-trace.c                         |  139 ++-
 tools/perf/check-headers.sh                        |    2 +
 tools/perf/examples/bpf/augmented_raw_syscalls.c   |  268 ++---
 tools/perf/jvmti/jvmti_agent.c                     |    2 +
 tools/perf/jvmti/libjvmti.c                        |    4 +-
 tools/perf/perf-with-kcore.sh                      |    5 -
 tools/perf/perf.c                                  |    1 +
 tools/perf/perf.h                                  |    4 +-
 .../arch/arm64/hisilicon/hip08/uncore-ddrc.json    |   44 +
 .../arch/arm64/hisilicon/hip08/uncore-hha.json     |   51 +
 .../arch/arm64/hisilicon/hip08/uncore-l3c.json     |   37 +
 .../arch/x86/cascadelakex/clx-metrics.json         |    4 +-
 .../pmu-events/arch/x86/skylakex/skx-metrics.json  |   22 +-
 tools/perf/pmu-events/jevents.c                    |    7 +-
 tools/perf/scripts/python/export-to-postgresql.py  |  330 ++++++-
 tools/perf/scripts/python/export-to-sqlite.py      |  319 +++++-
 tools/perf/scripts/python/exported-sql-viewer.py   |  345 +++++--
 tools/perf/tests/Build                             |    4 +
 tools/perf/tests/bp_account.c                      |    1 +
 tools/perf/tests/bpf-script-example.c              |    1 +
 tools/perf/tests/bpf-script-test-kbuild.c          |    1 +
 tools/perf/tests/bpf-script-test-prologue.c        |    1 +
 tools/perf/tests/bpf-script-test-relocation.c      |    1 +
 tools/perf/tests/bpf.c                             |    1 +
 tools/perf/tests/builtin-test.c                    |   11 +-
 tools/perf/tests/code-reading.c                    |    2 +-
 tools/perf/tests/map_groups.c                      |  121 +++
 tools/perf/tests/mem.c                             |    1 +
 tools/perf/tests/mem2node.c                        |    1 +
 tools/perf/tests/parse-events.c                    |   27 +
 tools/perf/tests/shell/lib/probe.sh                |    1 +
 tools/perf/tests/shell/probe_vfs_getname.sh        |    3 +-
 .../tests/shell/record+probe_libc_inet_pton.sh     |    3 +-
 .../tests/shell/record+script_probe_vfs_getname.sh |    1 +
 tools/perf/tests/shell/record+zstd_comp_decomp.sh  |    2 +
 tools/perf/tests/shell/trace+probe_vfs_getname.sh  |    1 +
 tools/perf/tests/tests.h                           |    2 +
 tools/perf/tests/time-utils-test.c                 |  251 +++++
 tools/perf/trace/beauty/Build                      |    4 +
 tools/perf/trace/beauty/beauty.h                   |   15 +
 tools/perf/trace/beauty/clone.c                    |    1 +
 tools/perf/trace/beauty/fsconfig.sh                |   17 +
 tools/perf/trace/beauty/fsmount.c                  |   34 +
 tools/perf/trace/beauty/fsmount.sh                 |   22 +
 tools/perf/trace/beauty/fspick.c                   |   24 +
 tools/perf/trace/beauty/fspick.sh                  |   17 +
 tools/perf/trace/beauty/move_mount.c               |   24 +
 tools/perf/trace/beauty/move_mount_flags.sh        |   17 +
 tools/perf/trace/beauty/sync_file_range.c          |   31 +
 tools/perf/trace/beauty/sync_file_range.sh         |   17 +
 tools/perf/ui/browser.c                            |    4 +-
 tools/perf/ui/browsers/annotate.c                  |    5 +-
 tools/perf/ui/browsers/hists.c                     |   10 +-
 tools/perf/ui/browsers/map.c                       |    2 +-
 tools/perf/ui/gtk/hists.c                          |    5 +-
 tools/perf/ui/libslang.h                           |    5 +
 tools/perf/ui/progress.c                           |    2 +-
 tools/perf/ui/stdio/hist.c                         |   43 +-
 tools/perf/util/Build                              |    9 +
 tools/perf/util/PERF-VERSION-GEN                   |    2 +-
 tools/perf/util/annotate.c                         |   25 +-
 tools/perf/util/auxtrace.c                         |    5 +-
 tools/perf/util/auxtrace.h                         |   34 +
 tools/perf/util/build-id.c                         |    2 +-
 tools/perf/util/config.c                           |   10 +-
 tools/perf/util/cpumap.c                           |   66 +-
 tools/perf/util/cpumap.h                           |   10 +-
 tools/perf/util/cputopo.c                          |   84 +-
 tools/perf/util/cputopo.h                          |    2 +
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c    |  268 +++--
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.h    |   39 +-
 tools/perf/util/cs-etm.c                           | 1026 +++++++++++++++-----
 tools/perf/util/cs-etm.h                           |   94 ++
 tools/perf/util/ctype.c                            |   49 -
 tools/perf/util/data-convert-bt.c                  |    2 +-
 tools/perf/util/debug.c                            |    2 +-
 tools/perf/util/demangle-java.c                    |    2 +-
 tools/perf/util/dso.c                              |  128 ++-
 tools/perf/util/env.c                              |    3 +-
 tools/perf/util/env.h                              |    3 +
 tools/perf/util/event.c                            |   10 +-
 tools/perf/util/event.h                            |    2 +
 tools/perf/util/evsel.c                            |   37 +-
 tools/perf/util/header.c                           |  112 ++-
 tools/perf/util/hist.c                             |   43 +-
 tools/perf/util/hist.h                             |    8 +
 tools/perf/util/include/linux/ctype.h              |    1 -
 .../perf/util/intel-pt-decoder/intel-pt-decoder.c  |  467 +++++++--
 .../perf/util/intel-pt-decoder/intel-pt-decoder.h  |  144 +++
 .../util/intel-pt-decoder/intel-pt-pkt-decoder.c   |  140 ++-
 .../util/intel-pt-decoder/intel-pt-pkt-decoder.h   |   21 +-
 tools/perf/util/intel-pt.c                         |  762 +++++++++++++--
 tools/perf/util/jitdump.c                          |    2 +-
 tools/perf/util/machine.c                          |   36 +-
 tools/perf/util/map.c                              |    6 +
 tools/perf/util/map_groups.h                       |    2 +
 tools/perf/util/metricgroup.c                      |   73 +-
 tools/perf/util/perf_regs.h                        |    4 +
 tools/perf/util/pmu.c                              |   69 +-
 tools/perf/util/print_binary.c                     |    2 +-
 tools/perf/util/probe-event.c                      |    2 +-
 tools/perf/util/probe-finder.h                     |    2 +-
 tools/perf/util/python-ext-sources                 |    3 +-
 tools/perf/util/python.c                           |    1 +
 tools/perf/util/s390-cpumsf.c                      |   96 +-
 tools/perf/util/sane_ctype.h                       |   52 -
 .../util/scripting-engines/trace-event-python.c    |   54 +-
 tools/perf/util/setup.py                           |    2 +
 tools/perf/util/smt.c                              |    8 +-
 tools/perf/util/sort.h                             |   13 +
 tools/perf/util/srcline.c                          |    7 +-
 tools/perf/util/stat-display.c                     |   43 +-
 tools/perf/util/stat-shadow.c                      |   24 +-
 tools/perf/util/stat.c                             |    1 +
 tools/perf/util/stat.h                             |    1 +
 tools/perf/util/strfilter.c                        |    6 +-
 tools/perf/util/string.c                           |  169 +---
 tools/perf/util/string2.h                          |   15 +-
 tools/perf/util/symbol-elf.c                       |    6 +-
 tools/perf/util/symbol.c                           |  121 ++-
 tools/perf/util/symbol.h                           |   23 +
 tools/perf/util/symbol_conf.h                      |    5 +-
 tools/perf/util/thread-stack.c                     |   62 +-
 tools/perf/util/thread-stack.h                     |    4 +
 tools/perf/util/thread.c                           |   35 +-
 tools/perf/util/thread.h                           |    4 +-
 tools/perf/util/thread_map.c                       |    3 +-
 tools/perf/util/time-utils.c                       |  130 ++-
 tools/perf/util/trace-event-parse.c                |    2 +-
 tools/perf/util/util.c                             |   13 -
 tools/perf/util/util.h                             |    1 -
 204 files changed, 8977 insertions(+), 2107 deletions(-)
