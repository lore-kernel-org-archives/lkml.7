Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA60FC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 12:32:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86E6C2082F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 12:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574685143;
	bh=uuMrwUODXBf4Wkch7dXcKNgZxdrzDn6+Nf63+8Ci80g=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=npDkx9ZkMsEDh2zOf39VPatzwvAIldvyrU/aVEVIVmFHkpcCSudXNClGN8WoI21Gv
	 ul6qpLeLQJ4TT5StSCnIlk28z4VlneTOsAGLN4JkidUWZ1zEzDFI1vClJySNoYrP5c
	 TFw2f7N26uIouCt/I2+oLYkz20QpSRWvPJR1VvL0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727688AbfKYMcW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 07:32:22 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46920 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727568AbfKYMcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 07:32:22 -0500
Received: by mail-wr1-f65.google.com with SMTP id z7so14364980wrl.13
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 04:32:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=NoYV2Of4NSJfcj9q1Nxp5ePGHzzlFFM4jIlBmd33trs=;
        b=nQBcg4hd3daOrPcTYuNl0bDoomMvR7pX3eF4LtxIzmxmKD26eTpE4HxilAbQPkfFbQ
         3/ayPrPh4b5pktvypPDy8By2r/F9cCTPeC2boorctcRFOOS0XM5k16ImEp2Dmkq7rLTg
         c1olMohw5eupQ6L26NuDf5G32EcJa8ydBbDzlkSOqj+X0dDLeqeb2UzkWpF8Loe//A2t
         tbgJAs23fM6BQpKLouvBoXjFcFlsetFLk7FVJyE/IVSzE5KuXcPwdHqJQbEmcQFcp8wI
         KrjtZpvsKSCKXDsxyD5HQiDIkzVfcm7lhPcl6Wwn2cmsowHL3XmvnuDnMM6aPglQ8tlN
         wCow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:content-transfer-encoding
         :user-agent;
        bh=NoYV2Of4NSJfcj9q1Nxp5ePGHzzlFFM4jIlBmd33trs=;
        b=lyABa4gIh1eHf79MfNHOpZTokWJwHKEz3GBpUBUr18bUyTkZgVlRMFYrv3AyZCIDQo
         VCTeEuM6+ITFPzk76yP/lf8hDXI9/ab1ChZo2886GJo+3jIt9HyFjJs6Aq/7sTiJ2Nit
         EPokkLHG0tlfK3ReiGahrNA+XavTLmBCZ5SzHIiZby4GltSbw0R6kftFywtaFAoipuBY
         AngvAvWh/Oy7hLHtbGJ0kGMHiiFdSOGmXAAJqmt6/dgPA/pNo4MBPRZexplkRfCmN6Vh
         ul8NtDA54+uR1e0iHfh6tfkCbw/1+sadBgj0ejGy2qAETWwon81S4Fl5+c5rDZgz6+0j
         WFCg==
X-Gm-Message-State: APjAAAWULhoo1xnBXFM/2rJP2jPEC+JoVcBoWqFifsnPBIgnyLZGCv+G
        LnxnsNSGpBT5b8zLTL3GkAA=
X-Google-Smtp-Source: APXvYqxB/enn142Kcr/WGOIiAfD7/I7FyT/QZPDO9bqz+gogOnBl90zD9pPSlJijEESZVMUl+h2L1g==
X-Received: by 2002:a5d:51c9:: with SMTP id n9mr33239332wrv.6.1574685137768;
        Mon, 25 Nov 2019 04:32:17 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id p25sm8090733wma.20.2019.11.25.04.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 04:32:17 -0800 (PST)
Date:   Mon, 25 Nov 2019 13:32:15 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] perf events updates for v5.5
Message-ID: <20191125123215.GA41816@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest perf-core-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-core-for-linus

   # HEAD: ceb9e77324fa661b1001a0ae66f061b5fcb4e4e6 Merge branch 'x86/core' into perf/core, to resolve conflicts and to pick up completed topic tree

The main kernel side changes in this cycle were:

 - Various Intel-PT updates and optimizations (Alexander Shishkin)

 - Prohibit kprobes on Xen/KVM emulate prefixes (Masami Hiramatsu)

 - Add support for LSM and SELinux checks to control access to the perf 
   syscall (Joel Fernandes)

 - Misc other changes, optimizations, fixes and cleanups - see the 
   shortlog for details.

There were numerous tooling changes as well - 254 non-merge commits. Here 
are the main changes - too many to list in detail:

 - Enhancements to core tooling infrastructure, perf.data, libperf, 
   libtraceevent, event parsing, vendor events, Intel PT, callchains, BPF 
   support and instruction decoding.

 - There were updates to the following tools:

    perf annotate
    perf diff
    perf inject
    perf kvm
    perf list
    perf maps
    perf parse
    perf probe
    perf record
    perf report
    perf script
    perf stat
    perf test
    perf trace

 - And a lot of other changes: please see the shortlog and Git log for 
   more details.

 Thanks,

	Ingo

------------------>
Adrian Hunter (33):
      perf scripts python: exported-sql-viewer.py: Add LookupModel()
      perf scripts python: exported-sql-viewer.py: Add HBoxLayout and VBoxLayout
      perf scripts python: exported-sql-viewer.py: Add global time range calculations
      perf scripts python: exported-sql-viewer.py: Tidy up Call tree call_time
      perf scripts python: exported-sql-viewer.py: Add ability for Call tree to open at a specified task and time
      perf scripts python: exported-sql-viewer.py: Add Time chart by CPU
      perf data: Correctly identify directory data files
      perf data: Move perf_dir_version into data.h
      perf data: Rename directory "header" file to "data"
      perf data: Support single perf.data file directory
      perf record: Put a copy of kcore into the perf.data directory
      perf auxtrace: Add auxtrace_cache__remove()
      perf dso: Refactor dso_cache__read()
      perf dso: Add dso__data_write_cache_addr()
      perf inject: Make --strip keep evsels
      perf scripts python: exported-sql-viewer.py: Fix use of TRUE with SQLite
      perf callchain: Fix segfault in thread__resolve_callchain_sample()
      x86/insn: perf tools: Add some instructions to the new instructions test
      x86/insn: Add some Intel instructions to the opcode map
      perf tools: Add kernel AUX area sampling definitions
      perf record: Add a function to test for kernel support for AUX area sampling
      perf auxtrace: Move perf_evsel__find_pmu()
      perf auxtrace: Add support for AUX area sample recording
      perf record: Add support for AUX area sampling
      perf record: Add aux-sample-size config term
      perf inject: Cut AUX area samples
      perf auxtrace: Add support for dumping AUX area samples
      perf session: Add facility to peek at all events
      perf auxtrace: Add support for queuing AUX area samples
      perf pmu: When using default config, record which bits of config were changed by the user
      perf intel-pt: Add support for recording AUX area samples
      perf intel-pt: Add support for decoding AUX area samples
      perf intel-bts: Does not support AUX area sampling

Alexander Shishkin (7):
      perf/aux: Allow using AUX data in perf samples
      perf/x86/intel/pt: Factor out pt_config_start()
      perf/x86/intel/pt: Add sampling support
      perf/x86/intel/pt: Opportunistically use single range output mode
      perf/x86/intel/pt: Prevent redundant WRMSRs
      perf/core: Fix the mlock accounting, again
      perf/core: Make the mlock accounting simple again

Alexey Budankov (5):
      perf/core, perf/x86: Introduce swap_task_ctx() method at 'struct pmu'
      perf/x86: Install platform specific ->swap_task_ctx() adapter
      perf/x86/intel: Implement LBR callstack context synchronization
      perf/x86: Synchronize PMU task contexts on optimized context switches
      perf session: Fix decompression of PERF_RECORD_COMPRESSED records

Andi Kleen (5):
      perf script: Allow --time with --reltime
      perf script: Fix --reltime with --time
      perf evlist: Fix fix for freed id arrays
      perf evsel: Always preserve errno while cleaning up perf_event_open failures
      perf evsel: Avoid close(-1)

Arnaldo Carvalho de Melo (89):
      perf env: Add routine to read the env->cpuid from the running machine
      perf top: Initialize perf_env->cpuid, needed by the per arch annotation init routine
      perf evlist: Adopt __set_tracepoint_handlers method from perf_session
      perf trace: Make evlist__set_evsel_handler() affect just entries without a handler
      perf trace: Separate 'struct syscall_fmt' definition from syscall_fmts variable
      perf trace: Generalize the syscall_fmt find routines
      perf trace: Postpone parsing .perfconfig trace.add_events to after --verbose is processed
      perf trace augmented_syscalls: Do not show syscalls when none was asked for
      perf trace: Factor out the initialization of syscal_arg_fmt->scnprintf
      perf trace: Allocate an array of beautifiers for tracepoint args
      perf trace: Move some scnprintf methods from syscall to syscall_arg_fmt
      perf trace: Add the syscall_arg_fmt pointer to syscall_arg
      perf trace: Add array of chars scnprintf beautifier
      perf trace: Enclose all events argument lists with ()
      perf trace: Allow choosing how to augment the tracepoint arguments
      tools arch x86: Grab a copy of the file containing the MSR numbers
      perf beauty: Make strarray's offset be u64
      perf trace beauty: Add a x86 MSR cmd id->str table generator
      perf beauty: Hook up the x86 MSR table generator
      perf trace: Allow associating scnprintf routines with well known arg names
      perf trace beauty: Add the glue for the autogenerated MSR arrays
      perf trace: Associate the "msr" tracepoint arg name with x86_MSR__scnprintf()
      perf evlist: Factor out asprintf routine to build a tracepoint pid filter
      perf evlist: Introduce append_tp_filter() method
      perf evlist: Introduce append_tp_filter_pid() and append_tp_filter_pids()
      perf trace: Introduce --filter for tracepoint events
      perf trace: Add a strtoul() method to 'struct syscall_arg_fmt'
      perf trace: Introduce a strtoul() method for 'struct strarrays'
      perf trace: Expand strings in filters to integers
      perf beauty: Introduce strtoul() for x86 MSRs
      perf trace: Add syscall failure stats to -s/--summary and -S/--with-summary
      perf trace: Introduce --errno-summary
      perf string: Export asprintf__tp_filter_pids()
      perf trace: Filter own pid to avoid a feedback look in 'perf trace record -a'
      perf trace: Support tracepoint dynamic char arrays
      tools arch x86: Grab a copy of the file containing the IRQ vector defines
      libbeauty: Add a generator for x86's IRQ vectors -> strings
      libbeauty: Hook up the x86 irq_vectors table generator
      libbeauty: Add a strarray__scnprintf_suffix() method
      perf trace beauty: Add the glue for the autogenerated x86 IRQ vector array
      perf trace: Hook the 'vec' tracepoint argument with the x86 IRQ vectors scnprintf/strtoul
      perf trace: Show error message when not finding a field used in a filter expression
      perf trace: Introduce accessors to trace specific evsel->priv
      perf trace: Hide evsel->access further, simplify code
      perf trace: Introduce 'struct evsel__trace' for evsel->priv needs
      perf trace: Initialize evsel_trace->fmt for syscalls:sys_enter_* tracepoints
      libbeauty: Introduce syscall_arg__strtoul_strarray()
      perf trace: Honour --max-events in processing syscalls:sys_enter_*
      perf trace: Pass a syscall_arg to syscall_arg_fmt->strtoul()
      libbeauty: Introduce syscall_arg__strtoul_strarrays()
      perf trace: Use strtoul for the fcntl 'cmd' argument
      libbeauty: Make the mmap_flags strarray visible outside of its beautifier
      libbeauty: Introduce strarray__strtoul_flags()
      perf trace: Wire up strarray__strtoul_flags()
      perf trace: Use STUL_STRARRAY_FLAGS with mmap
      perf llvm: Make .o saving a debug message, not an info one
      perf map: Check if the map still has some refcounts on exit
      perf map: Allow map__next() to receive a NULL arg
      perf maps: Add for_each_entry()/_safe() iterators
      perf map_groups: Introduce for_each_entry() and for_each_entry_safe() iterators
      perf symbols: Remove needless checks for map->groups->machine
      perf machine: Add kernel_dso() method
      perf map: Use map->dso->kernel + map__kmaps() in map__kmaps()
      perf symbols: Stop using map->groups, we can use kmaps instead
      perf map_groups: Pass the object to map_groups__find_ams()
      perf tools: Add map_groups to 'struct addr_location'
      perf annotate: Pass a 'map_symbol' in places receiving a pair of 'map' and 'symbol' pointers
      perf unwind: Use 'struct map_symbol' in 'struct unwind_entry'
      perf callchain: Use 'struct map_symbol' in 'struct callchain_cursor_node'
      pref tools: Make 'struct addr_map_symbol' contain 'struct map_symbol'
      perf symbols: Use kmaps(map)->machine when we know its a kernel map
      perf tools: Add a 'struct map_groups' pointer to 'struct map_symbol'
      perf annotate: Stop using map->groups, use map_symbol->mg instead
      perf map: Combine maps__fixup_overlappings with its only use
      perf map: Remove ->groups from 'struct map'
      perf maps: Purge the entries from maps->names in __maps__purge()
      perf maps: Do not use an rbtree to sort by map name
      perf map_groups: Add a front end cache for map lookups by name
      perf map: No need to adjust the long name of modules
      perf record: No need to process the synthesized MMAP events twice
      perf machine: No need to check if kernel module maps pre-exist
      perf map_groups: Auto sort maps by name, if needed
      perf map: Use bitmap for booleans
      perf map: Move seldom used ->flags field to second cacheline
      perf map: Move maj/min/ino/ino_generation to separate struct
      perf map: Pass a dso_id to map__new()
      perf map: Move comparision of map's dso_id to a separate function
      perf dsos: Remove unused dsos__find() method
      perf dso: Move dso_id from 'struct map' to 'struct dso'

Björn Töpel (2):
      perf tools: Make usage of test_attr__* optional for perf-sys.h
      samples/bpf: fix build by setting HAVE_ATTR_TEST to zero

Colin Ian King (1):
      perf probe: Fix spelling mistake "addrees" -> "address"

Haiyan Song (2):
      perf vendor events intel: Update CascadelakeX events to v1.05
      perf vendor events intel: Update all the Intel JSON metrics from TMAM 3.6.

Hewenliang (1):
      libtraceevent: Fix memory leakage in copy_filter_type

Ian Rogers (19):
      perf tools: Avoid 'sample_reg_masks' being const + weak
      perf annotate: Avoid reallocation in objdump parsing
      perf annotate: Use libsubcmd's run-command.h to fork objdump
      perf annotate: Don't pipe objdump output through 'grep' command
      perf annotate: Don't pipe objdump output through 'expand' command
      perf annotate: Fix objdump --no-show-raw-insn flag
      perf tools: Move ALLOC_LIST into a function
      perf tools: Avoid a malloc() for array events
      perf tools: Splice events onto evlist even on error
      perf parse: Add parse events handle error
      perf parse: Ensure config and str in terms are unique
      perf parse: Add destructors for parse event terms
      perf parse: Before yyabort-ing free components
      perf parse: If pmu configuration fails free terms
      perf parse: Add a deep delete for parse event terms
      perf annotate: Fix heap overflow
      perf parse: Use YYABORT to clear stack after failure, plugging leaks
      perf parse: Report initial event parsing error
      perf parse: Fix potential memory leak when handling tracepoint errors

Igor Lubashev (1):
      perf kvm: Use evlist layer api when possible

Ingo Molnar (1):
      perf/core: Fix !CONFIG_PERF_EVENTS build warnings and failures

James Clark (5):
      libsubcmd: Move EXTRA_FLAGS to the end to allow overriding existing flags
      libsubcmd: Use -O0 with DEBUG=1
      perf vendor events arm64: Fix commas so PMU event files are valid JSON
      perf vendor events power8: Fix commas so PMU event files are valid JSON
      perf vendor events power9: Fix commas so PMU event files are valid JSON

Jin Yao (13):
      perf diff: Report noisy for cycles diff
      perf report: Add warning when libunwind not compiled in
      perf stat: Support --all-kernel/--all-user
      perf list: Hide deprecated events by default
      perf diff: Don't use hack to skip column length calculation
      perf block: Cleanup and refactor block info functions
      perf hist: Count the total cycles of all samples
      perf hist: Support block formats with compare/sort/display
      perf report: Sort by sampled cycles percent per block for stdio
      perf report: Support --percent-limit for --total-cycles
      perf report: Sort by sampled cycles percent per block for tui
      perf util: Move block TUI function to ui browsers
      perf report: Jump to symbol source view from total cycles view

Jiri Olsa (40):
      libperf: Add perf_mmap__init() function
      libperf: Add 'struct perf_mmap_param'
      libperf: Adopt perf_mmap__mmap_len() function from tools/perf
      libperf: Adopt perf_mmap__mmap() function from tools/perf
      libperf: Adopt perf_mmap__get() function from tools/perf
      libperf: Adopt perf_mmap__unmap() function from tools/perf
      libperf: Adopt perf_mmap__put() function from tools/perf
      perf tools: Use perf_mmap way to detect aux mmap
      libperf: Adopt perf_mmap__consume() function from tools/perf
      libperf: Adopt perf_mmap__read_init() from tools/perf
      libperf: Adopt perf_mmap__read_done() from tools/perf
      libperf: Adopt perf_mmap__read_event() from tools/perf
      libperf: Adopt perf_evlist__mmap()/munmap() from tools/perf
      libperf: Introduce perf_evlist__mmap_ops()
      libperf: Introduce perf_evlist_mmap_ops::idx callback
      libperf: Add perf_evlist_mmap_ops::get callback
      libperf: Introduce perf_evlist_mmap_ops::mmap callback
      perf tools: Introduce perf_evlist__mmap_cb_idx()
      perf evlist: Introduce perf_evlist__mmap_cb_get()
      perf evlist: Introduce perf_evlist__mmap_cb_mmap()
      perf evlist: Switch to libperf's mmap interface
      libperf: Centralize map refcnt setting
      libperf: Move the pollfd allocation from tools/perf to libperf
      libperf: Introduce perf_evlist__exit()
      libperf: Introduce perf_evlist__purge()
      libperf: Adopt perf_evlist__filter_pollfd() from tools/perf
      perf tools: Propagate CFLAGS to libperf
      perf tools: Allow to build with -ltcmalloc
      libperf: Introduce perf_evlist__for_each_mmap()
      libperf: Move mmap allocation to perf_evlist__mmap_ops::get
      libperf: Move mask setup to perf_evlist__mmap_ops()
      libperf: Link static tests with libapi.a
      libperf: Add tests_mmap_thread test
      libperf: Add tests_mmap_cpus test
      libperf: Keep count of failed tests
      libperf: Do not export perf_evsel__init()/perf_evlist__init()
      libperf: Add pr_err() macro
      perf session: Fix indent in perf_session__new()"
      perf env: Add perf_env__numa_node()
      perf stat: Add --per-node agregation support

Jiwei Sun (1):
      perf record: Add support for limit perf output file size

Joel Fernandes (Google) (1):
      perf_event: Add support for LSM and SELinux checks

John Garry (6):
      MAINTAINERS: Add entry for perf tool arm64 pmu-events files
      perf vendor events arm64: Fix Hisi hip08 DDRC PMU eventname
      perf vendor events arm64: Add some missing events for Hisi hip08 DDRC PMU
      perf vendor events arm64: Add some missing events for Hisi hip08 L3C PMU
      perf vendor events arm64: Add some missing events for Hisi hip08 HHA PMU
      perf tools: Fix cross compile for ARM64

Konstantin Khlebnikov (1):
      libtraceevent: Fix parsing of event %o and %X argument types

Leo Yan (8):
      perf test: Report failure for mmap events
      perf test: Avoid infinite loop for task exit case
      perf tests: Remove needless headers for bp_account
      perf tests bp_account: Add dedicated checking helper is_supported()
      perf tests: Disable bp_signal testing for arm64
      perf cs-etm: Fix definition of macro TO_CS_QUEUE_NR
      perf tests: Fix a typo
      perf tests: Fix out of bounds memory access

Liang, Kan (1):
      perf/core: Optimize perf_init_event() for TYPE_SOFTWARE

Masami Hiramatsu (25):
      x86/asm: Allow to pass macros to __ASM_FORM()
      x86: xen: kvm: Gather the definition of emulate prefixes
      x86: xen: insn: Decode Xen and KVM emulate-prefix signature
      x86: kprobes: Prohibit probing on instruction which has emulate prefix
      perf probe: Fix to find range-only function instance
      perf probe: Walk function lines in lexical blocks
      perf probe: Fix to show function entry line as probe-able
      perf probe: Fix wrong address verification
      perf probe: Fix to probe a function which has no entry pc
      perf probe: Fix to probe an inline function which has no entry pc
      perf probe: Fix to list probe event with correct line number
      perf probe: Fix to show inlined function callsite without entry_pc
      perf probe: Fix to show ranges of variables in functions without entry_pc
      perf probe: Return a better scope DIE if there is no best scope
      perf probe: Skip end-of-sequence and non statement lines
      perf probe: Filter out instances except for inlined subroutine and subprogram
      perf probe: Fix to show calling lines of inlined functions
      perf probe: Skip overlapped location on searching variables
      perf probe: Show correct statement line number by perf probe -l
      perf probe: Verify given line is a representive line
      perf probe: Do not show non representive lines by perf-probe -L
      perf probe: Generate event name with line number
      perf probe: Support multiprobe event
      perf probe: Support DW_AT_const_value constant value
      perf probe: Trace a magic number if variable is not found

Peter Zijlstra (2):
      perf/core: Optimize perf_install_in_event()
      perf/core: Optimize perf_init_event()

Qian Cai (1):
      perf/core: Fix unlock balance in perf_init_event()

Ravi Bangoria (1):
      perf tool: Provide an option to print perf_event_open args and return value

Steven Rostedt (VMware) (2):
      perf scripting engines: Iterate on tep event arrays directly
      perf tools: Remove unused trace_find_next_event()

Sudip Mukherjee (1):
      libtraceevent: Fix header installation

Thomas Richter (1):
      perf jvmti: Link against tools/lib/ctype.h to have weak strlcpy()

Yunfeng Ye (3):
      perf/ring_buffer: Modify the parameter type of perf_mmap_free_page()
      perf/ring_buffer: Matching the memory allocate and free, in rb_alloc()
      perf jevents: Fix resource leak in process_mapfile() and main()

Zheng Yongjun (1):
      perf/x86/amd: Remove set but not used variable 'active'


 MAINTAINERS                                        |     7 +
 arch/powerpc/perf/core-book3s.c                    |    18 +-
 arch/x86/events/amd/core.c                         |    13 +-
 arch/x86/events/core.c                             |     8 +
 arch/x86/events/intel/bts.c                        |     8 +-
 arch/x86/events/intel/core.c                       |    12 +-
 arch/x86/events/intel/lbr.c                        |    23 +
 arch/x86/events/intel/p4.c                         |     5 +-
 arch/x86/events/intel/pt.c                         |   203 +-
 arch/x86/events/intel/pt.h                         |    12 +-
 arch/x86/events/perf_event.h                       |    11 +
 arch/x86/include/asm/asm.h                         |     8 +-
 arch/x86/include/asm/emulate_prefix.h              |    14 +
 arch/x86/include/asm/insn.h                        |     6 +
 arch/x86/include/asm/xen/interface.h               |    11 +-
 arch/x86/kernel/kprobes/core.c                     |     4 +
 arch/x86/kvm/x86.c                                 |     4 +-
 arch/x86/lib/insn.c                                |    34 +
 arch/x86/lib/x86-opcode-map.txt                    |    18 +-
 include/linux/lsm_hooks.h                          |    15 +
 include/linux/perf_event.h                         |    64 +-
 include/linux/security.h                           |    39 +-
 include/uapi/linux/perf_event.h                    |    10 +-
 kernel/events/core.c                               |   328 +-
 kernel/events/internal.h                           |     1 +
 kernel/events/ring_buffer.c                        |    60 +-
 kernel/trace/trace_event_perf.c                    |    15 +-
 security/security.c                                |    27 +
 security/selinux/hooks.c                           |    69 +
 security/selinux/include/classmap.h                |     2 +
 security/selinux/include/objsec.h                  |     6 +-
 tools/arch/x86/include/asm/emulate_prefix.h        |    14 +
 tools/arch/x86/include/asm/insn.h                  |     6 +
 tools/arch/x86/include/asm/irq_vectors.h           |   146 +
 tools/arch/x86/include/asm/msr-index.h             |   857 ++
 tools/arch/x86/lib/insn.c                          |    34 +
 tools/arch/x86/lib/x86-opcode-map.txt              |    18 +-
 tools/include/uapi/linux/perf_event.h              |    10 +-
 tools/lib/subcmd/Makefile                          |     9 +-
 tools/lib/traceevent/Makefile                      |     8 +-
 tools/lib/traceevent/event-parse.c                 |     7 +-
 tools/lib/traceevent/parse-filter.c                |     9 +-
 tools/objtool/sync-check.sh                        |     3 +-
 tools/perf/Documentation/intel-pt.txt              |    59 +-
 tools/perf/Documentation/perf-config.txt           |     5 +
 tools/perf/Documentation/perf-diff.txt             |     5 +
 tools/perf/Documentation/perf-list.txt             |     3 +
 tools/perf/Documentation/perf-record.txt           |    16 +
 tools/perf/Documentation/perf-report.txt           |    11 +
 tools/perf/Documentation/perf-stat.txt             |    11 +
 tools/perf/Documentation/perf-trace.txt            |    14 +
 .../Documentation/perf.data-directory-format.txt   |    63 +
 tools/perf/Documentation/perf.txt                  |     2 +
 tools/perf/Makefile.config                         |    33 +-
 tools/perf/Makefile.perf                           |    21 +-
 tools/perf/arch/arm/util/Build                     |     2 +
 tools/perf/arch/arm/util/perf_regs.c               |     6 +
 tools/perf/arch/arm64/util/Build                   |     1 +
 tools/perf/arch/arm64/util/perf_regs.c             |     6 +
 tools/perf/arch/arm64/util/sym-handling.c          |     3 +-
 tools/perf/arch/csky/util/Build                    |     2 +
 tools/perf/arch/csky/util/perf_regs.c              |     6 +
 tools/perf/arch/powerpc/util/kvm-stat.c            |     4 +-
 tools/perf/arch/riscv/util/Build                   |     2 +
 tools/perf/arch/riscv/util/perf_regs.c             |     6 +
 tools/perf/arch/s390/annotate/instructions.c       |     8 +-
 tools/perf/arch/s390/util/Build                    |     1 +
 tools/perf/arch/s390/util/perf_regs.c              |     6 +
 tools/perf/arch/x86/tests/insn-x86-dat-32.c        |    52 +
 tools/perf/arch/x86/tests/insn-x86-dat-64.c        |    62 +
 tools/perf/arch/x86/tests/insn-x86-dat-src.c       |   109 +
 tools/perf/arch/x86/tests/perf-time-to-tsc.c       |     9 +-
 tools/perf/arch/x86/util/auxtrace.c                |     4 +
 tools/perf/arch/x86/util/event.c                   |     2 +-
 tools/perf/arch/x86/util/intel-bts.c               |     5 +
 tools/perf/arch/x86/util/intel-pt.c                |    81 +-
 tools/perf/builtin-annotate.c                      |     8 +-
 tools/perf/builtin-diff.c                          |   258 +-
 tools/perf/builtin-inject.c                        |    83 +-
 tools/perf/builtin-kmem.c                          |     4 +-
 tools/perf/builtin-kvm.c                           |    13 +-
 tools/perf/builtin-list.c                          |    14 +-
 tools/perf/builtin-record.c                        |   160 +-
 tools/perf/builtin-report.c                        |    81 +-
 tools/perf/builtin-sched.c                         |     2 +-
 tools/perf/builtin-script.c                        |    10 +-
 tools/perf/builtin-stat.c                          |    60 +
 tools/perf/builtin-top.c                           |    29 +-
 tools/perf/builtin-trace.c                         |   993 +-
 tools/perf/check-headers.sh                        |     5 +-
 tools/perf/lib/Build                               |     1 +
 tools/perf/lib/Makefile                            |     6 +-
 tools/perf/lib/core.c                              |     3 +-
 tools/perf/lib/evlist.c                            |   357 +
 tools/perf/lib/evsel.c                             |     3 +-
 tools/perf/lib/include/internal/evlist.h           |    43 +
 tools/perf/lib/include/internal/evsel.h            |     1 +
 tools/perf/lib/include/internal/mmap.h             |    45 +-
 tools/perf/lib/include/internal/tests.h            |    20 +-
 tools/perf/lib/include/perf/core.h                 |     3 +
 tools/perf/lib/include/perf/evlist.h               |    15 +-
 tools/perf/lib/include/perf/evsel.h                |     2 -
 tools/perf/lib/include/perf/mmap.h                 |    15 +
 tools/perf/lib/internal.h                          |     5 +
 tools/perf/lib/libperf.map                         |    10 +-
 tools/perf/lib/mmap.c                              |   275 +
 tools/perf/lib/tests/Makefile                      |     6 +-
 tools/perf/lib/tests/test-cpumap.c                 |     2 +-
 tools/perf/lib/tests/test-evlist.c                 |   219 +-
 tools/perf/lib/tests/test-evsel.c                  |     2 +-
 tools/perf/lib/tests/test-threadmap.c              |     2 +-
 .../pmu-events/arch/arm64/ampere/emag/branch.json  |     8 +-
 .../pmu-events/arch/arm64/ampere/emag/bus.json     |    14 +-
 .../pmu-events/arch/arm64/ampere/emag/cache.json   |    28 +-
 .../pmu-events/arch/arm64/ampere/emag/clock.json   |     2 +-
 .../arch/arm64/ampere/emag/exception.json          |    26 +-
 .../arch/arm64/ampere/emag/instruction.json        |    28 +-
 .../arch/arm64/ampere/emag/intrinsic.json          |    10 +-
 .../pmu-events/arch/arm64/ampere/emag/memory.json  |    12 +-
 .../arch/arm64/ampere/emag/pipeline.json           |     2 +-
 .../arch/arm64/arm/cortex-a53/branch.json          |     2 +-
 .../pmu-events/arch/arm64/arm/cortex-a53/bus.json  |     4 +-
 .../arch/arm64/arm/cortex-a53/other.json           |     4 +-
 .../arm64/arm/cortex-a57-a72/core-imp-def.json     |   120 +-
 .../pmu-events/arch/arm64/armv8-recommended.json   |   158 +-
 .../arch/arm64/cavium/thunderx2/core-imp-def.json  |    74 +-
 .../arch/arm64/hisilicon/hip08/core-imp-def.json   |    60 +-
 .../arch/arm64/hisilicon/hip08/uncore-ddrc.json    |    30 +-
 .../arch/arm64/hisilicon/hip08/uncore-hha.json     |    37 +-
 .../arch/arm64/hisilicon/hip08/uncore-l3c.json     |    66 +-
 .../perf/pmu-events/arch/powerpc/power8/cache.json |    60 +-
 .../arch/powerpc/power8/floating-point.json        |     6 +-
 .../pmu-events/arch/powerpc/power8/frontend.json   |   158 +-
 .../pmu-events/arch/powerpc/power8/marked.json     |   266 +-
 .../pmu-events/arch/powerpc/power8/memory.json     |    72 +-
 .../perf/pmu-events/arch/powerpc/power8/other.json |  1150 +-
 .../pmu-events/arch/powerpc/power8/pipeline.json   |   118 +-
 tools/perf/pmu-events/arch/powerpc/power8/pmc.json |    48 +-
 .../arch/powerpc/power8/translation.json           |    60 +-
 .../perf/pmu-events/arch/powerpc/power9/cache.json |    44 +-
 .../arch/powerpc/power9/floating-point.json        |    14 +-
 .../pmu-events/arch/powerpc/power9/frontend.json   |   142 +-
 .../pmu-events/arch/powerpc/power9/marked.json     |   250 +-
 .../pmu-events/arch/powerpc/power9/memory.json     |    52 +-
 .../perf/pmu-events/arch/powerpc/power9/other.json |   934 +-
 .../pmu-events/arch/powerpc/power9/pipeline.json   |   212 +-
 tools/perf/pmu-events/arch/powerpc/power9/pmc.json |    48 +-
 .../arch/powerpc/power9/translation.json           |    92 +-
 .../pmu-events/arch/x86/broadwell/bdw-metrics.json |   178 +-
 .../arch/x86/broadwellx/bdx-metrics.json           |   184 +-
 .../pmu-events/arch/x86/cascadelakex/cache.json    | 12068 +++++++++----------
 .../arch/x86/cascadelakex/clx-metrics.json         |   210 +-
 .../arch/x86/cascadelakex/floating-point.json      |    92 +-
 .../pmu-events/arch/x86/cascadelakex/frontend.json |   656 +-
 .../pmu-events/arch/x86/cascadelakex/memory.json   | 11408 +++++++++---------
 .../pmu-events/arch/x86/cascadelakex/other.json    |  9620 +++++++--------
 .../pmu-events/arch/x86/cascadelakex/pipeline.json |  1234 +-
 .../arch/x86/cascadelakex/uncore-memory.json       |   191 +
 .../arch/x86/cascadelakex/uncore-other.json        |  1585 ++-
 .../arch/x86/cascadelakex/virtual-memory.json      |   339 +-
 .../pmu-events/arch/x86/haswell/hsw-metrics.json   |   164 +-
 .../pmu-events/arch/x86/haswellx/hsx-metrics.json  |   170 +-
 .../pmu-events/arch/x86/ivybridge/ivb-metrics.json |   170 +-
 .../pmu-events/arch/x86/ivytown/ivt-metrics.json   |   172 +-
 .../pmu-events/arch/x86/jaketown/jkt-metrics.json  |   114 +-
 .../arch/x86/sandybridge/snb-metrics.json          |   112 +-
 .../pmu-events/arch/x86/skylake/skl-metrics.json   |   188 +-
 .../pmu-events/arch/x86/skylakex/skx-metrics.json  |   204 +-
 tools/perf/pmu-events/jevents.c                    |    39 +-
 tools/perf/pmu-events/jevents.h                    |     3 +-
 tools/perf/pmu-events/pmu-events.h                 |     1 +
 tools/perf/scripts/python/exported-sql-viewer.py   |  1565 ++-
 tools/perf/tests/attr/base-record                  |     2 +-
 tools/perf/tests/attr/base-stat                    |     2 +-
 tools/perf/tests/backward-ring-buffer.c            |    16 +-
 tools/perf/tests/bp_account.c                      |    20 +-
 tools/perf/tests/bp_signal.c                       |    15 +-
 tools/perf/tests/bpf.c                             |     7 +-
 tools/perf/tests/builtin-test.c                    |     2 +-
 tools/perf/tests/code-reading.c                    |     9 +-
 tools/perf/tests/dwarf-unwind.c                    |     2 +-
 tools/perf/tests/keep-tracking.c                   |     9 +-
 tools/perf/tests/map_groups.c                      |    11 +-
 tools/perf/tests/mmap-basic.c                      |     9 +-
 tools/perf/tests/openat-syscall-tp-fields.c        |     9 +-
 tools/perf/tests/parse-events.c                    |     3 +-
 tools/perf/tests/perf-record.c                     |     9 +-
 tools/perf/tests/sample-parsing.c                  |    16 +-
 tools/perf/tests/sw-clock.c                        |     9 +-
 tools/perf/tests/switch-tracking.c                 |     9 +-
 tools/perf/tests/task-exit.c                       |    18 +-
 tools/perf/tests/tests.h                           |     1 +
 tools/perf/tests/vmlinux-kallsyms.c                |     6 +-
 tools/perf/trace/beauty/Build                      |     1 +
 tools/perf/trace/beauty/beauty.h                   |    35 +-
 tools/perf/trace/beauty/mmap.c                     |     4 +-
 tools/perf/trace/beauty/tracepoints/Build          |     2 +
 .../trace/beauty/tracepoints/x86_irq_vectors.c     |    29 +
 .../trace/beauty/tracepoints/x86_irq_vectors.sh    |    27 +
 tools/perf/trace/beauty/tracepoints/x86_msr.c      |    39 +
 tools/perf/trace/beauty/tracepoints/x86_msr.sh     |    40 +
 tools/perf/ui/browsers/annotate.c                  |    25 +-
 tools/perf/ui/browsers/hists.c                     |   105 +-
 tools/perf/ui/browsers/hists.h                     |     2 +
 tools/perf/ui/gtk/annotate.c                       |    27 +-
 tools/perf/ui/stdio/hist.c                         |    29 +-
 tools/perf/util/Build                              |     2 +
 tools/perf/util/annotate.c                         |   305 +-
 tools/perf/util/annotate.h                         |    24 +-
 tools/perf/util/auxtrace.c                         |   350 +-
 tools/perf/util/auxtrace.h                         |    44 +
 tools/perf/util/block-info.c                       |   477 +
 tools/perf/util/block-info.h                       |    79 +
 tools/perf/util/callchain.c                        |    40 +-
 tools/perf/util/callchain.h                        |     5 +-
 tools/perf/util/cpumap.c                           |    18 +
 tools/perf/util/cpumap.h                           |     3 +
 tools/perf/util/cs-etm.c                           |     4 +-
 tools/perf/util/data.c                             |    46 +-
 tools/perf/util/data.h                             |    12 +
 tools/perf/util/db-export.c                        |    16 +-
 tools/perf/util/debug.c                            |     2 +
 tools/perf/util/debug.h                            |     9 +
 tools/perf/util/dso.c                              |   159 +-
 tools/perf/util/dso.h                              |    20 +
 tools/perf/util/dsos.c                             |    97 +-
 tools/perf/util/dsos.h                             |    14 +-
 tools/perf/util/dwarf-aux.c                        |   142 +-
 tools/perf/util/dwarf-aux.h                        |     3 +
 tools/perf/util/env.c                              |    56 +
 tools/perf/util/env.h                              |     7 +
 tools/perf/util/event.c                            |     6 +-
 tools/perf/util/event.h                            |     6 +
 tools/perf/util/evlist.c                           |   334 +-
 tools/perf/util/evlist.h                           |    13 +
 tools/perf/util/evsel.c                            |    76 +-
 tools/perf/util/evsel_config.h                     |    13 +
 tools/perf/util/evsel_fprintf.c                    |    29 +-
 tools/perf/util/header.h                           |     4 -
 tools/perf/util/hist.c                             |    71 +-
 tools/perf/util/hist.h                             |    18 +-
 tools/perf/util/intel-pt.c                         |   109 +-
 tools/perf/util/llvm-utils.c                       |     5 +-
 tools/perf/util/machine.c                          |   125 +-
 tools/perf/util/machine.h                          |     4 +-
 tools/perf/util/map.c                              |   178 +-
 tools/perf/util/map.h                              |    17 +-
 tools/perf/util/map_groups.h                       |    31 +-
 tools/perf/util/map_symbol.h                       |     5 +-
 tools/perf/util/mem-events.c                       |     2 +-
 tools/perf/util/metricgroup.c                      |     2 +-
 tools/perf/util/mmap.c                             |   260 +-
 tools/perf/util/mmap.h                             |    28 +-
 tools/perf/util/parse-events.c                     |   308 +-
 tools/perf/util/parse-events.h                     |    10 +-
 tools/perf/util/parse-events.l                     |     1 +
 tools/perf/util/parse-events.y                     |   391 +-
 tools/perf/util/parse-regs-options.c               |     8 +-
 tools/perf/util/perf_event_attr_fprintf.c          |     3 +-
 tools/perf/util/perf_regs.c                        |     4 -
 tools/perf/util/perf_regs.h                        |     4 +-
 tools/perf/util/pmu.c                              |    59 +-
 tools/perf/util/pmu.h                              |     6 +-
 tools/perf/util/probe-event.c                      |    21 +-
 tools/perf/util/probe-event.h                      |     3 +
 tools/perf/util/probe-file.c                       |    14 +
 tools/perf/util/probe-file.h                       |     2 +
 tools/perf/util/probe-finder.c                     |   193 +-
 tools/perf/util/probe-finder.h                     |     1 +
 tools/perf/util/python.c                           |     8 +-
 tools/perf/util/record.c                           |    31 +
 tools/perf/util/record.h                           |     3 +
 .../perf/util/scripting-engines/trace-event-perl.c |    16 +-
 .../util/scripting-engines/trace-event-python.c    |    18 +-
 tools/perf/util/session.c                          |   119 +-
 tools/perf/util/session.h                          |    11 +-
 tools/perf/util/sort.c                             |   113 +-
 tools/perf/util/sort.h                             |     4 +
 tools/perf/util/spark.c                            |    34 +
 tools/perf/util/spark.h                            |     8 +
 tools/perf/util/stat-display.c                     |    15 +
 tools/perf/util/stat.c                             |    11 +
 tools/perf/util/stat.h                             |     3 +
 tools/perf/util/string2.h                          |     3 +
 tools/perf/util/symbol-elf.c                       |     2 +-
 tools/perf/util/symbol.c                           |   160 +-
 tools/perf/util/symbol.h                           |    26 +-
 tools/perf/util/symbol_conf.h                      |     1 +
 tools/perf/util/synthetic-events.c                 |    14 +-
 tools/perf/util/thread.c                           |     2 +-
 tools/perf/util/time-utils.c                       |    27 +-
 tools/perf/util/time-utils.h                       |     5 +
 tools/perf/util/unwind-libdw.c                     |     7 +-
 tools/perf/util/unwind-libunwind-local.c           |     7 +-
 tools/perf/util/unwind.h                           |     8 +-
 tools/perf/util/util.c                             |    19 +-
 tools/perf/util/vdso.c                             |     4 +-
 297 files changed, 32874 insertions(+), 23281 deletions(-)
 create mode 100644 arch/x86/include/asm/emulate_prefix.h
 create mode 100644 tools/arch/x86/include/asm/emulate_prefix.h
 create mode 100644 tools/arch/x86/include/asm/irq_vectors.h
 create mode 100644 tools/arch/x86/include/asm/msr-index.h
 create mode 100644 tools/perf/Documentation/perf.data-directory-format.txt
 create mode 100644 tools/perf/arch/arm/util/perf_regs.c
 create mode 100644 tools/perf/arch/arm64/util/perf_regs.c
 create mode 100644 tools/perf/arch/csky/util/perf_regs.c
 create mode 100644 tools/perf/arch/riscv/util/perf_regs.c
 create mode 100644 tools/perf/arch/s390/util/perf_regs.c
 create mode 100644 tools/perf/lib/include/perf/mmap.h
 create mode 100644 tools/perf/lib/mmap.c
 create mode 100644 tools/perf/trace/beauty/tracepoints/Build
 create mode 100644 tools/perf/trace/beauty/tracepoints/x86_irq_vectors.c
 create mode 100755 tools/perf/trace/beauty/tracepoints/x86_irq_vectors.sh
 create mode 100644 tools/perf/trace/beauty/tracepoints/x86_msr.c
 create mode 100755 tools/perf/trace/beauty/tracepoints/x86_msr.sh
 create mode 100644 tools/perf/util/block-info.c
 create mode 100644 tools/perf/util/block-info.h
 create mode 100644 tools/perf/util/spark.c
 create mode 100644 tools/perf/util/spark.h

