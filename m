Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91D88C49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 12:03:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EDF820665
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 12:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568635408;
	bh=N+/XAXpUTPYjswxs5Nx6e7Z+8GXhIqwS2t8Qkf8jn1Q=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=xtcI+jsaGJWR/qXQ0uRY8Bcs7wJSwxNgxb6Wb9odirafWyyZCazF7FE0f2eFCGHQh
	 P6OA/lPbBG8iVSR/RzAsVdqpjZ5XeXnhAuAKsFdbZsk/EjCPXqolQ1tKN3hSMt2U6u
	 h5M6LLsl3TlMe9xCCTNuRwguyiCyeuwclBD9TJMw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732359AbfIPMD1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 08:03:27 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35344 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732313AbfIPMD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 08:03:26 -0400
Received: by mail-wr1-f66.google.com with SMTP id v8so3217131wrt.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 05:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=HPVGPhxagzFPPfKCU7+ryA6Ks5tnMAggEMDN7u2Uhpc=;
        b=krK7FQrMq58qOcWC9A+rNahZmD8gZ5BRU2aTxp2F0wESnZgCM0vOX5ACMHXibkOz5T
         bhMxXBdYsFRJTk5Y2o8GXpIiYM4T6qLcFfJrpken3Dk+Qqy3uePSCOfWm3mDZMn3VfVF
         znH06r6TY44pkj3fN8mewpPgOdvkRiZnQ21dJdn31HnfwKm7mt4AjRHSoWq2tM+OEIOS
         dWcNk3fPHbgq5xX69MRlrJPYctbz+yONDJ27eDpOOC5Uvpg7aOoJ0HkMO60crXjhNlaw
         PdAZGJKnW8eNIft6DZd/cUwxXeOtyalebRB9A1jm3XQW6iBgNx212ou+0S5pwTnruwm+
         stvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=HPVGPhxagzFPPfKCU7+ryA6Ks5tnMAggEMDN7u2Uhpc=;
        b=BDeViS5VapbzLOo2ZJq4AsGRqycJQa24We32pQMxv/cz/zbNmUA35esT+G+UpHjAkT
         ckPlSaej8A0vOGt0NXm7p75Sbi5sBPkxn1U/dOXb/Cn6JJSACwS3Yf7aIDe7EGwruo4r
         KphxwUZZvunZ5Wk0qPrps2VSw5tA7NgprS28TU8k2bMXgDK9cQIoc+z3m5QMGwspWwdM
         T24Sggcs/QRij6LkSXhR6ZvuRt/EGH1z2ubnt+wuoNvXub3ofS/NhkfB0TC46B/NvawY
         hBQV5OgHhU66hnLuD10komGT31MFYYBFdJFMywThj5732Swr7pA5VWOjsogyljPcwySq
         CrMA==
X-Gm-Message-State: APjAAAWmc8eKRZ4iFdK82oCeZWzmbb/He0A4jkpA7BCJkVGxBUxXuH4H
        WveDODGKgOtIBbwczZgO1BQ=
X-Google-Smtp-Source: APXvYqyBBsj+SalsT4fadIu11RKn/O0oGdDdGMbxZJKQQF8GYcUtOJk02YBUy3NbPgG8dNocWpRO9g==
X-Received: by 2002:a5d:4744:: with SMTP id o4mr10452030wrs.95.1568635397468;
        Mon, 16 Sep 2019 05:03:17 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id y186sm11595780wmd.26.2019.09.16.05.03.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 05:03:16 -0700 (PDT)
Date:   Mon, 16 Sep 2019 14:03:14 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@infradead.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] perf changes for v5.4
Message-ID: <20190916120314.GA31220@gmail.com>
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

   # HEAD: e336b4027775cb458dc713745e526fa1a1996b2a kprobes: Prohibit probing on BUG() and WARN() address

Kernel side changes:

 - Improved kbprobes robustness

 - Intel PEBS support for PT hardware tracing

 - Other Intel PT improvements: high order pages memory footprint 
   reduction and various related cleanups

 - Misc cleanups

The perf tooling side has been very busy in this cycle, with over 300 
commits. This is an incomplete high-level summary of the many 
improvements done by over 30 developers:

 - Lots of updates to the following tools:

      'perf c2c'
      'perf config'
      'perf record'
      'perf report'
      'perf script'
      'perf test'
      'perf top'
      'perf trace'

 - Updates to libperf and libtraceevent, and a consolidation of the
   proliferation of x86 instruction decoder libraries.

 - Vendor event updates for Intel and PowerPC CPUs,

 - Updates to hardware tracing tooling for ARM and Intel CPUs,

 - ... and lots of other changes and cleanups - see the shortlog and Git 
   log for details.

I'd also like to warn about the cfb104ca8a26affb2 merge commit, which 
accidentally got a bit messier than intended (sorry!) - if it's 
unacceptably ugly we will reconstruct the tree.

 Thanks,

	Ingo

------------------>
Adrian Hunter (6):
      perf tools: Add aux_output attribute flag
      perf tools: Add itrace option 'o' to synthesize aux-output events
      perf intel-pt: Process options for PEBS event synthesis
      perf tools: Add aux-output config term
      perf intel-pt: Add brief documentation for PEBS via Intel PT
      perf evsel: Add comment for 'idx' member in 'struct perf_sample_id

Alexander Shishkin (9):
      perf record: Add an option to take an AUX snapshot on exit
      perf/x86/intel/pt: Clean up ToPA allocation path
      perf/x86/intel/pt: Use helpers to obtain ToPA entry size
      perf/x86/intel/pt: Use pointer arithmetics instead in ToPA entry calculation
      perf/x86/intel/pt: Split ToPA metadata and page layout
      perf/x86/intel/pt: Free up space in a ToPA descriptor
      perf/x86/intel/pt: Get rid of reverse lookup table for ToPA
      perf: Allow normal events to output AUX data
      perf/x86/intel: Support PEBS output to PT

Alexey Budankov (3):
      perf record: Enable LBR callstack capture jointly with thread stack
      perf report: Dump LBR callstack data by -D jointly with thread stack
      perf report: Prefer DWARF callstacks to LBR ones when captured both

Andi Kleen (2):
      perf report: Use timestamp__scnprintf_nsec() for time sort key
      perf report: Fix --ns time sort key output

Andy Shevchenko (1):
      tools: Keep list of tools in alphabetical order

Arnaldo Carvalho de Melo (129):
      perf include bpf: Add bpf_tail_call() prototype
      perf bpf: Do not attach a BPF prog to a tracepoint if its name starts with !
      perf evsel: Store backpointer to attached bpf_object
      perf trace: Add pointer to BPF object containing __augmented_syscalls__
      perf trace: Look up maps just on the __augmented_syscalls__ BPF object
      perf trace: Order -e syscalls table
      perf trace: Add BPF handler for unaugmented syscalls
      perf trace: Allow specifying the bpf prog to augment specific syscalls
      perf trace: Put the per-syscall entry/exit prog_array BPF map infrastructure in place
      perf trace: Handle raw_syscalls:sys_enter just like the BPF_OUTPUT augmented event
      perf augmented_raw_syscalls: Add handler for "openat"
      perf augmented_raw_syscalls: Switch to using BPF_MAP_TYPE_PROG_ARRAY
      perf augmented_raw_syscalls: Support copying two string syscall args
      perf trace: Look for default name for entries in the syscalls prog array
      perf augmented_raw_syscalls: Rename augmented_args_filename to augmented_args_payload
      perf augmented_raw_syscalls: Augment sockaddr arg in 'connect'
      perf trace beauty: Make connect's addrlen be printed as an int, not hex
      perf trace beauty: Disable fd->pathname when close() not enabled
      perf trace beauty: Do not try to use the fd->pathname beautifier for bind/connect fd arg
      perf trace beauty: Beautify 'sendto's sockaddr arg
      perf trace beauty: Beautify bind's sockaddr arg
      perf trace beauty: Add BPF augmenter for the 'rename' syscall
      perf trace: Forward error codes when trying to read syscall info
      perf trace: Mark syscall ids that are not allocated to avoid unnecessary error messages
      perf trace: Preallocate the syscall table
      perf trace: Reuse BPF augmenters from syscalls with similar args signature
      perf trace: Add "sendfile64" alias to the "sendfile" syscall
      perf session: Avoid infinite loop when seeing invalid header.size
      perf config: Honour $PERF_CONFIG env var to specify alternate .perfconfig
      perf config: Document the PERF_CONFIG environment variable
      perf test vfs_getname: Disable ~/.perfconfig to get default output
      perf top: Set display thread COMM to help with debugging
      perf hists: Do not link a pair if already linked
      perf hist: Remove dummy entries when finding real ones.
      perf top: Collapse and resort all evsels in a group
      perf tools: Add NO_LIBCAP=1 to the minimal build test
      perf tools: Add CAP_SYSLOG define for older systems
      perf ftrace: Improve error message about capability to use ftrace
      perf evsel: Provide meaningful warning when trying to use 'aux_output' on older kernels
      perf ui: No need to set ui_browser to 1 twice
      perf script: Allow specifying event to switch on processing of other events
      perf script: Allow showing the --switch-on event
      perf script: Allow specifying event to switch off processing of other events
      perf evswitch: Move struct to a separate header to use in other tools
      perf evswitch: Move switch logic to use in other tools
      perf evswitch: Add the names of on/off events
      perf evswitch: Introduce OPTS_EVSWITCH() for cmd line processing
      perf evswitch: Introduce init() method to set the on/off evsels from the command line
      perf evswitch: Move enoent error message printing to separate function
      perf evswitch: Add hint when not finding specified on/off events
      perf trace: Add --switch-on/--switch-off events
      perf top: Add --switch-on/--switch-off events
      perf report: Add --switch-on/--switch-off events
      tools headers: Add limits.h to access __WORDSIZE
      perf tools: tools/include should come before tools/uapi/include
      tools headers: Grab copy of linux/const.h, needed by linux/bits.h
      tools headers: Synchronize linux/bits.h with the kernel sources
      tools arch x86: Sync asm/cpufeatures.h with the with the kernel
      perf ui: Make 'exit_msg' optional in ui__question_window()
      perf ui: Introduce non-interactive ui__info_window() function
      perf ui browser: Allow specifying message to show when no samples are available to display
      perf top: Show info message while collecting samples
      tools headers: Fixup bitsperlong per arch includes
      perf arm64: Add missing debug.h header
      perf kvm s390: Add missing string.h header
      perf metricgroup: Remove needless includes from metricgroup.h
      perf evsel: Move xyarray.h from evsel.c to evsel.h to reduce include dep tree
      perf counts: Add missing headers needed for types used
      perf bpf: Add missing xyarray.h header
      perf evlist: Add missing xyarray.h header
      perf script: Add missing counts.h
      perf tests: Add missing counts.h
      perf stat: Add missing counts.h
      perf scripting python: Add missing counts.h header
      perf evsel: Add missing perf/evsel.h header in util/evsel.h
      perf evsel: Remove needless counts.h header from util/evsel.h
      perf evsel: Remove needless stddef.h from util/evsel.h
      perf evsel: util/evsel.h needs stdio.h as it uses FILE
      perf x86 kvm-stat: Add missing string.h header
      perf evsel: Switch to libperf's cpumap.h
      perf cpumap: Remove needless includes from cpumap.h
      perf cpumap: No need to include perf.h, ditch it
      perf stat: Remove needless headers from stat.h
      perf record: Move record_opts and other record decls out of perf.h
      perf cacheline: Move cacheline related routines to separate files
      perf srcline: Add missing srcline.h header to files needing its defs
      perf sort: Remove needless headers from sort.h, provide fwd struct decls
      perf augmented_raw_syscalls: Rename augmented_filename to augmented_arg
      perf augmented_raw_syscalls: Postpone tmp map lookup to after pid_filter
      perf augmented_raw_syscalls: Introduce helper to get the scratch space
      perf augmented_raw_syscalls: Reduce perf_event_output() boilerplate
      libperf: Rename the PERF_RECORD_ structs to have a "perf" suffix
      perf tools: Rename perf_event::ksymbol_event to perf_event::ksymbol
      perf tools: Rename perf_event::bpf_event to perf_event::bpf
      perf tool: Rename perf_tool::bpf_event to bpf
      perf evsel: Rename perf_missing_features::bpf_event to ::bpf
      perf tools: Remove needless util.h include from builtin.h
      perf evlist: Remove needless util.h from evlist.h
      perf clang: Delete needless util-cxx.h header
      perf evlist: Use unshare(CLONE_FS) in sb threads to let setns(CLONE_NEWNS) work
      perf tools: Remove needless libtraceevent include directives
      perf header: Move CPUINFO_PROC to the only file where it is used
      perf tools: Move everything related to sys_perf_event_open() to perf-sys.h
      perf time-utils: Adopt rdclock() from perf.h
      perf tools: Remove needless perf.h include directive from headers
      perf tools: Remove perf.h from source files not needing it
      perf tools: Remove debug.h from header files not needing it
      perf debug: Remove needless include directives from debug.h
      perf env: Remove env.h from other headers where just a fwd decl is needed
      perf event: Remove needless include directives from event.h
      perf dso: Adopt DSO related macros from symbol.h
      perf symbol: Move C++ demangle defines to the only file using it
      perf symbols: Add missing linux/refcount.h to symbol.h
      perf symbols: Move symsrc prototypes to a separate header
      perf dsos: Move the dsos struct and its methods to separate source files
      perf hist: Remove needless ui/progress.h from hist.h
      perf tools: Move 'struct events_stats' and prototypes to separate header
      perf tools: Remove needless sort.h include directives
      perf probe: No need for symbol.h, symbol_conf is enough
      perf tools: Remove needless map.h include directives
      perf tools: Remove needless thread.h include directives
      perf tools: Remove needless thread_map.h include directives
      perf tools: Remove needless evlist.h include directives
      perf tools: Remove needless evlist.h include directives
      perf auxtrace: Uninline functions that touch perf_session
      perf symbols: Move mem_info and branch_info out of symbol.h
      perf build: Ignore intentional differences for the x86 insn decoder
      objtool: Update sync-check.sh from perf's check-headers.sh
      objtool: Ignore intentional differences for the x86 insn decoder

Benjamin Peterson (1):
      perf trace beauty ioctl: Fix off-by-one error in cmd->string table

Gerald BAEZA (1):
      libperf: Fix alignment trap with xyarray contents in 'perf stat'

Gustavo A. R. Silva (1):
      perf script: Fix memory leaks in list_scripts()

Haiyan Song (2):
      perf vendor events intel: Add Icelake V1.00 event file
      perf vendor events intel: Add Tremontx event file v1.02

Igor Lubashev (8):
      tools build: Add capability-related feature detection
      perf tools: Add helpers to use capabilities if present
      perf ftrace: Use CAP_SYS_ADMIN instead of euid==0
      perf event: Check ref_reloc_sym before using it
      perf tools: Use CAP_SYS_ADMIN with perf_event_paranoid checks
      perf evsel: Kernel profiling is disallowed only when perf_event_paranoid > 1
      perf symbols: Use CAP_SYSLOG with kptr_restrict checks
      perf tools: Warn that perf_event_paranoid can restrict kernel symbols

James Clark (1):
      perf tests: Fixes hang in zstd compression test by changing the source of random data

Jin Yao (3):
      perf pmu: Change convert_scale from static to global
      perf metricgroup: Scale the metric result
      perf metricgroup: Support multiple events for metricgroup

Jiri Olsa (121):
      perf stat: Move loaded out of struct perf_counts_values
      perf cpu_map: Rename struct cpu_map to struct perf_cpu_map
      perf tools: Rename struct thread_map to struct perf_thread_map
      perf evsel: Rename struct perf_evsel to struct evsel
      perf evlist: Rename struct perf_evlist to struct evlist
      perf evsel: Rename perf_evsel__init() to evsel__init()
      perf evlist: Rename perf_evlist__init() to evlist__init()
      perf evlist: Rename perf_evlist__new() to evlist__new()
      perf evlist: Rename perf_evlist__delete() to evlist__delete()
      perf evsel: Rename perf_evsel__delete() to evsel__delete()
      perf evsel: Rename perf_evsel__new() to evsel__new()
      perf evlist: Rename perf_evlist__add() to evlist__add()
      perf evlist: Rename perf_evlist__remove() to evlist__remove()
      perf evsel: Rename perf_evsel__open() to evsel__open()
      perf evsel: Rename perf_evsel__enable() to evsel__enable()
      perf evsel: Rename perf_evsel__disable() to evsel__disable()
      perf evsel: Rename perf_evsel__apply_filter() to evsel__apply_filter()
      perf evsel: Rename perf_evsel__cpus() to evsel__cpus()
      perf evlist: Rename perf_evlist__open() to evlist__open()
      perf evlist: Rename perf_evlist__close() to evlist__close()
      perf evlist: Rename perf_evlist__enable() to evlist__enable()
      perf evlist: Rename perf_evlist__disable() to evlist__disable()
      libperf: Make libperf.a part of the perf build
      libperf: Add build version support
      libperf: Add libperf to the python.so build
      libperf: Add perf/core.h header
      libperf: Add debug output support
      libperf: Add perf_cpu_map struct
      libperf: Add perf_cpu_map__dummy_new() function
      libperf: Add perf_cpu_map__get()/perf_cpu_map__put()
      libperf: Add perf_thread_map struct
      libperf: Add perf_thread_map__new_dummy() function
      libperf: Add perf_thread_map__get()/perf_thread_map__put()
      libperf: Add perf_evlist and perf_evsel structs
      libperf: Include perf_evsel in evsel object
      libperf: Include perf_evlist in evlist object
      libperf: Add perf_evsel__init function
      libperf: Add perf_evlist__init() function
      libperf: Add perf_evlist__add() function
      libperf: Add perf_evlist__remove() function
      libperf: Add nr_entries to struct perf_evlist
      libperf: Move perf_event_attr field from perf's evsel to libperf's perf_evsel
      libperf: Add perf_cpu_map__new()/perf_cpu_map__read() functions
      libperf: Move zalloc.o into libperf
      libperf: Add perf_evlist__new() function
      libperf: Add perf_evsel__new() function
      libperf: Add perf_evlist__for_each_evsel() iterator
      libperf: Add perf_evlist__delete() function
      libperf: Add perf_evsel__delete() function
      libperf: Add cpus to struct perf_evsel
      libperf: Add own_cpus to struct perf_evsel
      libperf: Add threads to struct perf_evsel
      libperf: Add has_user_cpus to struct perf_evlist
      libperf: Add cpus to struct perf_evlist
      libperf: Add threads to struct perf_evlist
      libperf: Add perf_evlist__set_maps() function
      libperf: Adopt xyarray class from perf
      libperf: Move fd array from perf's evsel to lobperf's perf_evsel class
      libperf: Move nr_members from perf's evsel to libperf's perf_evsel
      libperf: Adopt the readn()/writen() functions from tools/perf
      libperf: Adopt perf_evsel__alloc_fd() function from tools/perf
      libperf: Adopt simplified perf_evsel__open() function from tools/perf
      libperf: Adopt simplified perf_evsel__close() function from tools/perf
      libperf: Adopt perf_evsel__read() function from tools/perf
      libperf: Adopt perf_evsel__enable()/disable()/apply_filter() functions
      libperf: Add perf_cpu_map__for_each_cpu() macro
      libperf: Add perf_evsel__cpus()/threads() functions
      libperf: Adopt simplified perf_evlist__open()/close() functions from tools/perf
      libperf: Adopt perf_evlist__enable()/disable() functions from perf
      libperf: Add perf_evsel__attr() function
      libperf: Add install targets
      libperf: Add tests support
      libperf: Add perf_cpu_map test
      libperf: Add perf_thread_map test
      libperf: Add perf_evlist test
      libperf: Add perf_evsel tests
      libperf: Add perf_evlist__enable/disable test
      libperf: Add perf_evsel__enable/disable test
      libperf: Initial documentation
      libperf: Fix arch include paths
      tools headers: Add missing perf_event.h include
      perf tools: Use perf_cpu_map__nr instead of cpu_map__nr
      libperf: Move perf's cpu_map__empty() to perf_cpu_map__empty()
      libperf: Move perf's cpu_map__idx() to perf_cpu_map__idx()
      libperf: Add perf_thread_map__nr/perf_thread_map__pid functions
      libperf: Add PERF_RECORD_MMAP 'struct mmap_event' to perf/event.h
      libperf: Add PERF_RECORD_MMAP2 'struct mmap2_event' to perf/event.h
      libperf: Add PERF_RECORD_COMM 'struct comm_event' to perf/event.h
      libperf: Add PERF_RECORD_NAMESPACES 'struct namespaces_event' to perf/event.h
      libperf: Add PERF_RECORD_FORK 'struct fork_event' to perf/event.h
      libperf: Add PERF_RECORD_LOST 'struct lost_event' to perf/event.h
      libperf: Add PERF_RECORD_LOST_SAMPLES 'struct lost_samples_event' to perf/event.h
      libperf: Add PERF_RECORD_READ 'struct read_event' to perf/event.h
      libperf: Add PERF_RECORD_THROTTLE 'struct throttle_event' to perf/event.h
      libperf: Add PERF_RECORD_KSYMBOL 'struct ksymbol_event' to perf/event.h
      libperf: Add PERF_RECORD_BPF_EVENT 'struct bpf_event' to perf/event.h
      libperf: Add PERF_RECORD_SAMPLE 'struct sample_event' to perf/event.h
      libperf: Add PERF_RECORD_HEADER_ATTR 'struct attr_event' to perf/event.h
      libperf: Add PERF_RECORD_CPU_MAP 'struct cpu_map_event' to perf/event.h
      libperf: Add PERF_RECORD_EVENT_UPDATE 'struct event_update_event' to perf/event.h
      libperf: Add PERF_RECORD_HEADER_EVENT_TYPE 'struct event_type_event' to perf/event.h
      libperf: Add PERF_RECORD_HEADER_TRACING_DATA 'struct tracing_data_event' to perf/event.h
      libperf: Add PERF_RECORD_HEADER_BUILD_ID 'struct build_id_event' to perf/event.h
      libperf: Add PERF_RECORD_ID_INDEX 'struct id_index_event' to perf/event.h
      libperf: Add PERF_RECORD_AUXTRACE_INFO 'struct auxtrace_info_event' to perf/event.h
      libperf: Add PERF_RECORD_AUXTRACE 'struct auxtrace_event' to perf/event.h
      libperf: Add PERF_RECORD_AUXTRACE_ERROR 'struct auxtrace_error_event' to perf/event.h
      libperf: Add PERF_RECORD_AUX 'struct aux_event' to perf/event.h
      libperf: Add PERF_RECORD_ITRACE_START 'struct itrace_start_event' to perf/event.h
      libperf: Add PERF_RECORD_SWITCH 'struct context_switch_event' to perf/event.h
      libperf: Add PERF_RECORD_THREAD_MAP 'struct thread_map_event' to perf/event.h
      libperf: Add PERF_RECORD_STAT_CONFIG 'struct stat_config_event' to perf/event.h
      libperf: Add PERF_RECORD_STAT 'struct stat_event' to perf/event.h
      libperf: Add PERF_RECORD_STAT_ROUND 'struct stat_round_event' to perf/event.h
      libperf: Add PERF_RECORD_TIME_CONV 'struct time_conv_event' to perf/event.h
      libperf: Add PERF_RECORD_HEADER_FEATURE 'struct feature_event' to perf/event.h
      libperf: Add PERF_RECORD_COMPRESSED 'struct compressed_event' to perf/event.h
      libperf: Add 'union perf_event' to perf/event.h
      libperf: Rename the PERF_RECORD_ structs to have a "perf" prefix
      libperf: Move 'enum perf_user_event_type' to perf/event.h
      perf c2c: Display proper cpu count in nodes column

John Keeping (3):
      perf map: Use zalloc for map_groups
      perf unwind: Fix libunwind when tid != pid
      perf unwind: Remove unnecessary test

Josh Poimboeuf (4):
      objtool: Move x86 insn decoder to a common location
      perf: Update .gitignore file
      perf intel-pt: Remove inat.c from build dependency list
      perf intel-pt: Use shared x86 insn decoder

Kyle Meyer (7):
      perf timechart: Refactor svg_build_topology_map()
      perf svghelper: Replace MAX_NR_CPUS with perf_env::nr_cpus_online
      perf stat: Replace MAX_NR_CPUS with cpu__max_cpu()
      perf session: Replace MAX_NR_CPUS with perf_env::nr_cpus_online
      perf machine: Replace MAX_NR_CPUS with perf_env::nr_cpus_online
      perf header: Replace MAX_NR_CPUS with cpu__max_cpu()
      libperf: Warn when exceeding MAX_NR_CPUS in cpumap

Leo Yan (2):
      perf trace: Fix segmentation fault when access syscall info on arm64
      perf cs-etm: Support sample flags 'insn' and 'insnlen'

Luke Mujica (1):
      perf tools: Fix paths in include statements

Masami Hiramatsu (2):
      x86, perf: Fix the dependency of the x86 insn decoder selftest
      kprobes: Prohibit probing on BUG() and WARN() address

Michael Petlan (1):
      perf vendor events power9: Added missing event descriptions

Namhyung Kim (2):
      perf top: Decay all events in the evlist
      perf top: Fix event group with more than two events

Naveen N. Rao (1):
      perf arch powerpc: Sync powerpc syscall.tbl

Ravi Bangoria (1):
      perf c2c: Fix report with offline cpus

Souptick Joarder (1):
      perf tools: Remove duplicate headers

Steven Rostedt (VMware) (3):
      tools lib traceevent: Fix "robust" test of do_generate_dynamic_list_file
      tools lib traceevent: Do not free tep->cmdlines in add_new_comm() on failure
      tools lib traceevent: Remove unneeded qsort and uses memmove instead

Tan Xiaojun (1):
      perf record: Support aarch64 random socket_id assignment

Tzvetomir Stoyanov (3):
      libtraceevent, perf tools: Changes in tep_print_event_* APIs
      libtraceevent: Remove tep_register_trace_clock()
      libtraceevent: Change users plugin directory

Valdis Kletnieks (1):
      perf/x86: Make more stuff static

Vince Weaver (1):
      perf.data documentation: Clarify HEADER_SAMPLE_TOPOLOGY format


 arch/x86/Kconfig.debug                             |    2 +-
 arch/x86/events/core.c                             |   34 +
 arch/x86/events/intel/core.c                       |   18 +
 arch/x86/events/intel/cstate.c                     |    4 +-
 arch/x86/events/intel/ds.c                         |   51 +-
 arch/x86/events/intel/lbr.c                        |    2 +-
 arch/x86/events/intel/pt.c                         |  330 ++++--
 arch/x86/events/intel/pt.h                         |   12 +-
 arch/x86/events/intel/rapl.c                       |    2 +-
 arch/x86/events/msr.c                              |    2 +-
 arch/x86/events/perf_event.h                       |   17 +
 arch/x86/include/asm/intel_pt.h                    |    2 +
 arch/x86/include/asm/msr-index.h                   |    4 +
 include/linux/bug.h                                |    5 +
 include/linux/perf_event.h                         |   14 +
 include/uapi/linux/perf_event.h                    |    3 +-
 kernel/events/core.c                               |   93 ++
 kernel/kprobes.c                                   |    3 +-
 tools/Makefile                                     |    4 +-
 tools/arch/x86/include/asm/cpufeatures.h           |    3 +
 .../x86/include/asm}/inat.h                        |    0
 .../arch/x86/include/asm/inat_types.h              |    0
 .../x86/include/asm}/insn.h                        |    0
 .../{objtool => }/arch/x86/include/asm/orc_types.h |    0
 tools/{objtool => }/arch/x86/lib/inat.c            |    2 +-
 tools/{objtool => }/arch/x86/lib/insn.c            |    4 +-
 .../{objtool => }/arch/x86/lib/x86-opcode-map.txt  |    0
 .../arch/x86/tools/gen-insn-attr-x86.awk           |    0
 tools/build/Makefile.feature                       |    2 +
 tools/build/feature/Makefile                       |    4 +
 tools/build/feature/test-libcap.c                  |   20 +
 tools/include/linux/bitops.h                       |    1 +
 tools/include/linux/bits.h                         |   17 +-
 tools/include/linux/const.h                        |    9 +
 tools/include/linux/ring_buffer.h                  |    1 +
 tools/include/uapi/asm/bitsperlong.h               |   18 +-
 tools/include/uapi/linux/const.h                   |   31 +
 tools/include/uapi/linux/perf_event.h              |    3 +-
 tools/lib/traceevent/Makefile                      |   10 +-
 tools/lib/traceevent/event-parse-api.c             |   40 -
 tools/lib/traceevent/event-parse-local.h           |    6 -
 tools/lib/traceevent/event-parse.c                 |  391 ++++---
 tools/lib/traceevent/event-parse.h                 |   30 +-
 tools/lib/traceevent/event-plugin.c                |    2 +-
 tools/objtool/Makefile                             |    4 +-
 tools/objtool/arch/x86/Build                       |    4 +-
 tools/objtool/arch/x86/decode.c                    |    4 +-
 tools/objtool/arch/x86/include/asm/inat.h          |  230 ----
 tools/objtool/arch/x86/include/asm/insn.h          |  216 ----
 tools/objtool/sync-check.sh                        |   44 +-
 tools/perf/.gitignore                              |    3 +
 tools/perf/Documentation/intel-pt.txt              |   15 +
 tools/perf/Documentation/itrace.txt                |    2 +
 tools/perf/Documentation/perf-config.txt           |    4 +
 tools/perf/Documentation/perf-record.txt           |   13 +-
 tools/perf/Documentation/perf-report.txt           |   17 +
 tools/perf/Documentation/perf-script.txt           |    9 +
 tools/perf/Documentation/perf-top.txt              |   38 +
 tools/perf/Documentation/perf-trace.txt            |    9 +
 tools/perf/Documentation/perf.data-file-format.txt |   25 +-
 tools/perf/Makefile.config                         |   14 +-
 tools/perf/Makefile.perf                           |   33 +-
 tools/perf/arch/arm/annotate/instructions.c        |    1 +
 tools/perf/arch/arm/util/auxtrace.c                |    9 +-
 tools/perf/arch/arm/util/cs-etm.c                  |  107 +-
 tools/perf/arch/arm64/annotate/instructions.c      |    1 +
 tools/perf/arch/arm64/util/arm-spe.c               |   30 +-
 tools/perf/arch/arm64/util/header.c                |    7 +-
 tools/perf/arch/arm64/util/sym-handling.c          |    8 +-
 tools/perf/arch/common.c                           |    3 +
 tools/perf/arch/common.h                           |    4 +-
 tools/perf/arch/powerpc/entry/syscalls/syscall.tbl |  146 ++-
 tools/perf/arch/powerpc/util/kvm-stat.c            |   12 +-
 tools/perf/arch/powerpc/util/mem-events.c          |    1 +
 tools/perf/arch/powerpc/util/perf_regs.c           |    1 -
 tools/perf/arch/powerpc/util/sym-handling.c        |    1 +
 tools/perf/arch/powerpc/util/unwind-libdw.c        |    1 +
 tools/perf/arch/s390/util/auxtrace.c               |   15 +-
 tools/perf/arch/s390/util/kvm-stat.c               |    9 +-
 tools/perf/arch/x86/tests/bp-modify.c              |    1 +
 tools/perf/arch/x86/tests/insn-x86.c               |    3 +-
 tools/perf/arch/x86/tests/intel-cqm.c              |    9 +-
 tools/perf/arch/x86/tests/perf-time-to-tsc.c       |   34 +-
 tools/perf/arch/x86/tests/rdpmc.c                  |    4 +-
 tools/perf/arch/x86/util/archinsn.c                |    3 +-
 tools/perf/arch/x86/util/auxtrace.c                |   10 +-
 tools/perf/arch/x86/util/header.c                  |    1 +
 tools/perf/arch/x86/util/intel-bts.c               |   49 +-
 tools/perf/arch/x86/util/intel-pt.c                |  123 +-
 tools/perf/arch/x86/util/kvm-stat.c                |   17 +-
 tools/perf/arch/x86/util/perf_regs.c               |    4 +-
 tools/perf/arch/x86/util/tsc.c                     |    8 +-
 tools/perf/bench/epoll-ctl.c                       |    8 +-
 tools/perf/bench/epoll-wait.c                      |    8 +-
 tools/perf/bench/futex-hash.c                      |    5 +-
 tools/perf/bench/futex-lock-pi.c                   |    7 +-
 tools/perf/bench/futex-requeue.c                   |    7 +-
 tools/perf/bench/futex-wake-parallel.c             |    6 +-
 tools/perf/bench/futex-wake.c                      |    7 +-
 tools/perf/bench/mem-functions.c                   |    3 +-
 tools/perf/bench/numa.c                            |    1 -
 tools/perf/bench/sched-messaging.c                 |    1 -
 tools/perf/bench/sched-pipe.c                      |    1 -
 tools/perf/builtin-annotate.c                      |   20 +-
 tools/perf/builtin-bench.c                         |    1 -
 tools/perf/builtin-buildid-cache.c                 |    6 +-
 tools/perf/builtin-buildid-list.c                  |    4 +-
 tools/perf/builtin-c2c.c                           |   22 +-
 tools/perf/builtin-config.c                        |    3 +-
 tools/perf/builtin-data.c                          |    2 +
 tools/perf/builtin-diff.c                          |   24 +-
 tools/perf/builtin-evlist.c                        |    4 +-
 tools/perf/builtin-ftrace.c                        |   35 +-
 tools/perf/builtin-help.c                          |    5 +-
 tools/perf/builtin-inject.c                        |   62 +-
 tools/perf/builtin-kallsyms.c                      |    1 +
 tools/perf/builtin-kmem.c                          |   29 +-
 tools/perf/builtin-kvm.c                           |   51 +-
 tools/perf/builtin-list.c                          |    5 +-
 tools/perf/builtin-lock.c                          |   34 +-
 tools/perf/builtin-mem.c                           |    4 +-
 tools/perf/builtin-probe.c                         |    5 +-
 tools/perf/builtin-record.c                        |   97 +-
 tools/perf/builtin-report.c                        |   55 +-
 tools/perf/builtin-sched.c                         |  101 +-
 tools/perf/builtin-script.c                        |  192 +--
 tools/perf/builtin-stat.c                          |  146 +--
 tools/perf/builtin-timechart.c                     |   56 +-
 tools/perf/builtin-top.c                           |  159 +--
 tools/perf/builtin-trace.c                         |  637 +++++++---
 tools/perf/builtin-version.c                       |    2 +-
 tools/perf/builtin.h                               |    2 -
 tools/perf/check-headers.sh                        |   13 +-
 tools/perf/examples/bpf/augmented_raw_syscalls.c   |  318 ++---
 tools/perf/include/bpf/bpf.h                       |    2 +
 tools/perf/lib/Build                               |   12 +
 tools/perf/lib/Documentation/Makefile              |    7 +
 tools/perf/lib/Documentation/man/libperf.rst       |  100 ++
 tools/perf/lib/Documentation/tutorial/tutorial.rst |  123 ++
 tools/perf/lib/Makefile                            |  158 +++
 tools/perf/lib/core.c                              |   34 +
 tools/perf/lib/cpumap.c                            |  262 +++++
 tools/perf/lib/evlist.c                            |  159 +++
 tools/perf/lib/evsel.c                             |  232 ++++
 tools/perf/lib/include/internal/cpumap.h           |   19 +
 tools/perf/lib/include/internal/evlist.h           |   50 +
 tools/perf/lib/include/internal/evsel.h            |   29 +
 tools/perf/lib/include/internal/lib.h              |   10 +
 tools/perf/lib/include/internal/tests.h            |   19 +
 tools/perf/lib/include/internal/threadmap.h        |   23 +
 .../perf/{util => lib/include/internal}/xyarray.h  |    9 +-
 tools/perf/lib/include/perf/core.h                 |   22 +
 tools/perf/lib/include/perf/cpumap.h               |   25 +
 tools/perf/lib/include/perf/event.h                |  385 ++++++
 tools/perf/lib/include/perf/evlist.h               |   35 +
 tools/perf/lib/include/perf/evsel.h                |   39 +
 tools/perf/lib/include/perf/threadmap.h            |   20 +
 tools/perf/lib/internal.h                          |   18 +
 tools/perf/lib/lib.c                               |   46 +
 tools/perf/lib/libperf.map                         |   43 +
 tools/perf/lib/libperf.pc.template                 |   11 +
 tools/perf/lib/tests/Makefile                      |   38 +
 tools/perf/lib/tests/test-cpumap.c                 |   21 +
 tools/perf/lib/tests/test-evlist.c                 |  186 +++
 tools/perf/lib/tests/test-evsel.c                  |  125 ++
 tools/perf/lib/tests/test-threadmap.c              |   21 +
 tools/perf/lib/threadmap.c                         |   91 ++
 tools/perf/lib/xyarray.c                           |   33 +
 tools/perf/perf-sys.h                              |   51 +-
 tools/perf/perf.c                                  |   11 +-
 tools/perf/perf.h                                  |   82 --
 .../pmu-events/arch/powerpc/power9/memory.json     |    2 +-
 .../perf/pmu-events/arch/powerpc/power9/other.json |    8 +-
 tools/perf/pmu-events/arch/x86/icelake/cache.json  |  552 +++++++++
 .../arch/x86/icelake/floating-point.json           |  102 ++
 .../perf/pmu-events/arch/x86/icelake/frontend.json |  424 +++++++
 tools/perf/pmu-events/arch/x86/icelake/memory.json |  410 +++++++
 tools/perf/pmu-events/arch/x86/icelake/other.json  |  121 ++
 .../perf/pmu-events/arch/x86/icelake/pipeline.json |  892 ++++++++++++++
 .../arch/x86/icelake/virtual-memory.json           |  236 ++++
 tools/perf/pmu-events/arch/x86/mapfile.csv         |    3 +
 tools/perf/pmu-events/arch/x86/tremontx/cache.json |  111 ++
 .../pmu-events/arch/x86/tremontx/frontend.json     |   26 +
 .../perf/pmu-events/arch/x86/tremontx/memory.json  |   26 +
 tools/perf/pmu-events/arch/x86/tremontx/other.json |   26 +
 .../pmu-events/arch/x86/tremontx/pipeline.json     |  111 ++
 .../arch/x86/tremontx/uncore-memory.json           |   73 ++
 .../pmu-events/arch/x86/tremontx/uncore-other.json |  431 +++++++
 .../pmu-events/arch/x86/tremontx/uncore-power.json |   11 +
 .../arch/x86/tremontx/virtual-memory.json          |   86 ++
 tools/perf/scripts/perl/Perf-Trace-Util/Context.c  |    1 -
 .../perf/scripts/python/Perf-Trace-Util/Context.c  |    1 -
 tools/perf/tests/attr.c                            |    3 +-
 tools/perf/tests/backward-ring-buffer.c            |   22 +-
 tools/perf/tests/bitmap.c                          |    5 +-
 tools/perf/tests/bp_account.c                      |    3 +-
 tools/perf/tests/bp_signal.c                       |    3 +-
 tools/perf/tests/bp_signal_overflow.c              |    3 +-
 tools/perf/tests/bpf.c                             |   15 +-
 tools/perf/tests/builtin-test.c                    |    1 +
 tools/perf/tests/code-reading.c                    |   59 +-
 tools/perf/tests/cpumap.c                          |   33 +-
 tools/perf/tests/dso-data.c                        |    1 +
 tools/perf/tests/dwarf-unwind.c                    |    1 +
 tools/perf/tests/event-times.c                     |   83 +-
 tools/perf/tests/event_update.c                    |   32 +-
 tools/perf/tests/evsel-roundtrip-name.c            |   12 +-
 tools/perf/tests/evsel-tp-sched.c                  |    8 +-
 tools/perf/tests/expr.c                            |    1 +
 tools/perf/tests/hists_common.c                    |    3 +-
 tools/perf/tests/hists_cumulate.c                  |   20 +-
 tools/perf/tests/hists_filter.c                    |   12 +-
 tools/perf/tests/hists_link.c                      |   12 +-
 tools/perf/tests/hists_output.c                    |   22 +-
 tools/perf/tests/keep-tracking.c                   |   47 +-
 tools/perf/tests/kmod-path.c                       |    2 +
 tools/perf/tests/llvm.c                            |    2 +-
 tools/perf/tests/make                              |    1 +
 tools/perf/tests/mem.c                             |    1 +
 tools/perf/tests/mem2node.c                        |    8 +-
 tools/perf/tests/mmap-basic.c                      |   31 +-
 tools/perf/tests/mmap-thread-lookup.c              |    4 +-
 tools/perf/tests/openat-syscall-all-cpus.c         |   20 +-
 tools/perf/tests/openat-syscall-tp-fields.c        |   18 +-
 tools/perf/tests/openat-syscall.c                  |   12 +-
 tools/perf/tests/parse-events.c                    | 1221 ++++++++++----------
 tools/perf/tests/parse-no-sample-id-all.c          |   10 +-
 tools/perf/tests/perf-record.c                     |   13 +-
 tools/perf/tests/sample-parsing.c                  |   16 +-
 tools/perf/tests/sdt.c                             |    4 +-
 tools/perf/tests/shell/record+zstd_comp_decomp.sh  |    2 +-
 tools/perf/tests/shell/trace+probe_vfs_getname.sh  |    4 +
 tools/perf/tests/stat.c                            |    8 +-
 tools/perf/tests/sw-clock.c                        |   35 +-
 tools/perf/tests/switch-tracking.c                 |   67 +-
 tools/perf/tests/task-exit.c                       |   38 +-
 tools/perf/tests/thread-map.c                      |   43 +-
 tools/perf/tests/thread-mg-share.c                 |    1 -
 tools/perf/tests/time-utils-test.c                 |    2 +-
 tools/perf/tests/topology.c                        |    9 +-
 tools/perf/tests/unit_number__scnprintf.c          |    1 +
 tools/perf/tests/vmlinux-kallsyms.c                |    1 +
 tools/perf/tests/wp.c                              |    5 +
 tools/perf/trace/beauty/ioctl.c                    |    2 +-
 tools/perf/ui/browser.c                            |    3 +-
 tools/perf/ui/browser.h                            |    1 +
 tools/perf/ui/browsers/annotate.c                  |   18 +-
 tools/perf/ui/browsers/header.c                    |    1 -
 tools/perf/ui/browsers/hists.c                     |   63 +-
 tools/perf/ui/browsers/map.c                       |    1 +
 tools/perf/ui/browsers/res_sample.c                |    9 +-
 tools/perf/ui/browsers/scripts.c                   |   18 +-
 tools/perf/ui/gtk/annotate.c                       |    9 +-
 tools/perf/ui/gtk/browser.c                        |    2 -
 tools/perf/ui/gtk/gtk.h                            |    8 +-
 tools/perf/ui/gtk/helpline.c                       |    1 +
 tools/perf/ui/gtk/hists.c                          |    7 +-
 tools/perf/ui/gtk/setup.c                          |    1 -
 tools/perf/ui/gtk/util.c                           |    1 +
 tools/perf/ui/helpline.c                           |    4 +-
 tools/perf/ui/helpline.h                           |    2 -
 tools/perf/ui/hist.c                               |   20 +-
 tools/perf/ui/progress.c                           |    1 -
 tools/perf/ui/setup.c                              |    5 +-
 tools/perf/ui/stdio/hist.c                         |    2 +
 tools/perf/ui/tui/helpline.c                       |    2 +
 tools/perf/ui/tui/progress.c                       |    1 -
 tools/perf/ui/tui/setup.c                          |    3 +-
 tools/perf/ui/tui/util.c                           |   38 +-
 tools/perf/ui/util.c                               |    4 +-
 tools/perf/ui/util.h                               |    2 +
 tools/perf/util/Build                              |   11 +-
 tools/perf/util/annotate.c                         |   49 +-
 tools/perf/util/annotate.h                         |   28 +-
 tools/perf/util/arm-spe.c                          |   10 +-
 tools/perf/util/auxtrace.c                         |  102 +-
 tools/perf/util/auxtrace.h                         |   89 +-
 tools/perf/util/bpf-event.c                        |   39 +-
 tools/perf/util/bpf-event.h                        |   15 +-
 tools/perf/util/bpf-loader.c                       |   43 +-
 tools/perf/util/bpf-loader.h                       |   30 +-
 tools/perf/util/bpf-prologue.c                     |    2 +-
 tools/perf/util/branch.c                           |    3 +-
 tools/perf/util/branch.h                           |    8 +
 tools/perf/util/build-id.c                         |    5 +-
 tools/perf/util/build-id.h                         |    2 +-
 tools/perf/util/c++/clang-c.h                      |    2 +-
 tools/perf/util/c++/clang-test.cpp                 |    4 +-
 tools/perf/util/cacheline.c                        |   25 +
 tools/perf/util/cacheline.h                        |   21 +
 tools/perf/util/callchain.c                        |    6 +-
 tools/perf/util/callchain.h                        |    3 +-
 tools/perf/util/cap.c                              |   29 +
 tools/perf/util/cap.h                              |   32 +
 tools/perf/util/cgroup.c                           |   25 +-
 tools/perf/util/cgroup.h                           |    6 +-
 tools/perf/util/cloexec.c                          |    4 +-
 tools/perf/util/color.c                            |    3 +-
 tools/perf/util/color_config.c                     |    3 +-
 tools/perf/util/config.c                           |    4 +
 tools/perf/util/counts.c                           |   17 +-
 tools/perf/util/counts.h                           |   38 +-
 tools/perf/util/cpumap.c                           |  285 +----
 tools/perf/util/cpumap.h                           |   63 +-
 tools/perf/util/cputopo.c                          |   15 +-
 tools/perf/util/cputopo.h                          |    1 -
 tools/perf/util/cs-etm.c                           |   73 +-
 tools/perf/util/cs-etm.h                           |    3 +-
 tools/perf/util/data-convert-bt.c                  |   38 +-
 tools/perf/util/data.c                             |    2 +-
 tools/perf/util/db-export.c                        |   11 +-
 tools/perf/util/db-export.h                        |   10 +-
 tools/perf/util/debug.c                            |    6 +-
 tools/perf/util/debug.h                            |    6 +-
 tools/perf/util/dso.c                              |  237 +---
 tools/perf/util/dso.h                              |   28 +-
 tools/perf/util/dsos.c                             |  232 ++++
 tools/perf/util/dsos.h                             |   44 +
 tools/perf/util/dwarf-aux.c                        |    1 +
 tools/perf/util/dwarf-aux.h                        |    2 +
 tools/perf/util/env.c                              |    4 +-
 tools/perf/util/env.h                              |    2 +-
 tools/perf/util/event.c                            |  121 +-
 tools/perf/util/event.h                            |  469 +-------
 tools/perf/util/events_stats.h                     |   51 +
 tools/perf/util/evlist.c                           |  628 +++++-----
 tools/perf/util/evlist.h                           |  219 ++--
 tools/perf/util/evsel.c                            |  539 ++++-----
 tools/perf/util/evsel.h                            |  222 ++--
 tools/perf/util/evsel_fprintf.c                    |   16 +-
 tools/perf/util/evswitch.c                         |   61 +
 tools/perf/util/evswitch.h                         |   31 +
 tools/perf/util/expr.y                             |    2 +
 tools/perf/util/genelf.c                           |    3 +-
 tools/perf/util/genelf_debug.c                     |    1 -
 tools/perf/util/get_current_dir_name.c             |    1 -
 tools/perf/util/header.c                           |  315 ++---
 tools/perf/util/header.h                           |   24 +-
 tools/perf/util/hist.c                             |   63 +-
 tools/perf/util/hist.h                             |   45 +-
 tools/perf/util/intel-bts.c                        |   32 +-
 tools/perf/util/intel-pt-decoder/Build             |   22 +-
 .../util/intel-pt-decoder/gen-insn-attr-x86.awk    |  392 -------
 tools/perf/util/intel-pt-decoder/inat.c            |   82 --
 tools/perf/util/intel-pt-decoder/inat_types.h      |   15 -
 tools/perf/util/intel-pt-decoder/insn.c            |  593 ----------
 .../perf/util/intel-pt-decoder/intel-pt-decoder.c  |    2 +-
 .../util/intel-pt-decoder/intel-pt-insn-decoder.c  |   10 +-
 .../perf/util/intel-pt-decoder/x86-opcode-map.txt  | 1072 -----------------
 tools/perf/util/intel-pt.c                         |  126 +-
 tools/perf/util/jitdump.c                          |    9 +-
 tools/perf/util/kvm-stat.h                         |   24 +-
 tools/perf/util/llvm-utils.c                       |    1 +
 tools/perf/util/llvm-utils.h                       |    2 +-
 tools/perf/util/lzma.c                             |    1 +
 tools/perf/util/machine.c                          |   55 +-
 tools/perf/util/machine.h                          |   12 +-
 tools/perf/util/map.c                              |    8 +-
 tools/perf/util/map.h                              |    2 +-
 tools/perf/util/map_groups.h                       |    4 +
 tools/perf/util/mem-events.c                       |    2 +-
 tools/perf/util/mem-events.h                       |    9 +
 tools/perf/util/mem2node.c                         |    3 +
 tools/perf/util/mem2node.h                         |    3 +-
 tools/perf/util/metricgroup.c                      |  110 +-
 tools/perf/util/metricgroup.h                      |   20 +-
 tools/perf/util/mmap.c                             |   10 +-
 tools/perf/util/mmap.h                             |    1 +
 tools/perf/util/namespaces.c                       |    2 +-
 tools/perf/util/namespaces.h                       |    4 +-
 tools/perf/util/ordered-events.c                   |    1 +
 tools/perf/util/parse-branch-options.c             |    4 +-
 tools/perf/util/parse-events.c                     |  167 +--
 tools/perf/util/parse-events.h                     |    9 +-
 tools/perf/util/parse-events.l                     |    1 +
 tools/perf/util/path.c                             |    3 +-
 tools/perf/util/path.h                             |    3 +
 tools/perf/util/perf-hooks.c                       |    1 +
 tools/perf/util/pmu.c                              |   25 +-
 tools/perf/util/pmu.h                              |    4 +-
 tools/perf/util/probe-event.c                      |    6 +-
 tools/perf/util/probe-file.c                       |    4 +-
 tools/perf/util/probe-finder.c                     |    1 +
 tools/perf/util/pstack.c                           |    1 +
 tools/perf/util/python-ext-sources                 |    3 +-
 tools/perf/util/python.c                           |  139 +--
 tools/perf/util/record.c                           |   78 +-
 tools/perf/util/record.h                           |   74 ++
 tools/perf/util/s390-cpumsf.c                      |   10 +-
 tools/perf/util/s390-sample-raw.c                  |    8 +-
 tools/perf/util/sample-raw.c                       |    2 +-
 tools/perf/util/sample-raw.h                       |    6 +-
 .../perf/util/scripting-engines/trace-event-perl.c |   16 +-
 .../util/scripting-engines/trace-event-python.c    |   46 +-
 tools/perf/util/session.c                          |  178 +--
 tools/perf/util/session.h                          |   14 +-
 tools/perf/util/setup.py                           |    5 +-
 tools/perf/util/sort.c                             |   81 +-
 tools/perf/util/sort.h                             |   34 +-
 tools/perf/util/stat-display.c                     |  115 +-
 tools/perf/util/stat-shadow.c                      |  135 ++-
 tools/perf/util/stat.c                             |   88 +-
 tools/perf/util/stat.h                             |   42 +-
 tools/perf/util/strbuf.c                           |    5 +
 tools/perf/util/svghelper.c                        |   62 +-
 tools/perf/util/svghelper.h                        |    4 +-
 tools/perf/util/symbol-elf.c                       |    7 +
 tools/perf/util/symbol-minimal.c                   |    2 +
 tools/perf/util/symbol.c                           |   20 +-
 tools/perf/util/symbol.h                           |   63 +-
 tools/perf/util/symbol_fprintf.c                   |    1 +
 tools/perf/util/symsrc.h                           |   46 +
 tools/perf/util/syscalltbl.c                       |    1 +
 tools/perf/util/syscalltbl.h                       |    1 +
 tools/perf/util/target.c                           |    3 +
 tools/perf/util/thread-stack.c                     |    1 +
 tools/perf/util/thread.c                           |   13 +-
 tools/perf/util/thread.h                           |    8 +-
 tools/perf/util/thread_map.c                       |  137 +--
 tools/perf/util/thread_map.h                       |   66 +-
 tools/perf/util/time-utils.c                       |    1 -
 tools/perf/util/time-utils.h                       |    9 +
 tools/perf/util/tool.h                             |   10 +-
 tools/perf/util/top.c                              |   13 +-
 tools/perf/util/top.h                              |   12 +-
 tools/perf/util/trace-event-info.c                 |   15 +-
 tools/perf/util/trace-event-parse.c                |    3 +-
 tools/perf/util/trace-event-read.c                 |    1 -
 tools/perf/util/trace-event-scripting.c            |    3 +-
 tools/perf/util/trace-event.h                      |    5 +-
 tools/perf/util/trigger.h                          |    1 -
 tools/perf/util/unwind-libdw.c                     |    1 +
 tools/perf/util/unwind-libunwind-local.c           |   18 +-
 tools/perf/util/unwind-libunwind.c                 |   41 +-
 tools/perf/util/unwind.h                           |   25 +-
 tools/perf/util/util-cxx.h                         |   27 -
 tools/perf/util/util.c                             |   71 +-
 tools/perf/util/util.h                             |    5 +-
 tools/perf/util/values.c                           |    1 +
 tools/perf/util/vdso.c                             |    1 +
 tools/perf/util/zlib.c                             |    1 +
 441 files changed, 13375 insertions(+), 8857 deletions(-)
 rename tools/{perf/util/intel-pt-decoder => arch/x86/include/asm}/inat.h (100%)
 rename tools/{objtool => }/arch/x86/include/asm/inat_types.h (100%)
 rename tools/{perf/util/intel-pt-decoder => arch/x86/include/asm}/insn.h (100%)
 rename tools/{objtool => }/arch/x86/include/asm/orc_types.h (100%)
 rename tools/{objtool => }/arch/x86/lib/inat.c (98%)
 rename tools/{objtool => }/arch/x86/lib/insn.c (99%)
 rename tools/{objtool => }/arch/x86/lib/x86-opcode-map.txt (100%)
 rename tools/{objtool => }/arch/x86/tools/gen-insn-attr-x86.awk (100%)
 create mode 100644 tools/build/feature/test-libcap.c
 create mode 100644 tools/include/linux/const.h
 create mode 100644 tools/include/uapi/linux/const.h
 delete mode 100644 tools/objtool/arch/x86/include/asm/inat.h
 delete mode 100644 tools/objtool/arch/x86/include/asm/insn.h
 create mode 100644 tools/perf/lib/Build
 create mode 100644 tools/perf/lib/Documentation/Makefile
 create mode 100644 tools/perf/lib/Documentation/man/libperf.rst
 create mode 100644 tools/perf/lib/Documentation/tutorial/tutorial.rst
 create mode 100644 tools/perf/lib/Makefile
 create mode 100644 tools/perf/lib/core.c
 create mode 100644 tools/perf/lib/cpumap.c
 create mode 100644 tools/perf/lib/evlist.c
 create mode 100644 tools/perf/lib/evsel.c
 create mode 100644 tools/perf/lib/include/internal/cpumap.h
 create mode 100644 tools/perf/lib/include/internal/evlist.h
 create mode 100644 tools/perf/lib/include/internal/evsel.h
 create mode 100644 tools/perf/lib/include/internal/lib.h
 create mode 100644 tools/perf/lib/include/internal/tests.h
 create mode 100644 tools/perf/lib/include/internal/threadmap.h
 rename tools/perf/{util => lib/include/internal}/xyarray.h (77%)
 create mode 100644 tools/perf/lib/include/perf/core.h
 create mode 100644 tools/perf/lib/include/perf/cpumap.h
 create mode 100644 tools/perf/lib/include/perf/event.h
 create mode 100644 tools/perf/lib/include/perf/evlist.h
 create mode 100644 tools/perf/lib/include/perf/evsel.h
 create mode 100644 tools/perf/lib/include/perf/threadmap.h
 create mode 100644 tools/perf/lib/internal.h
 create mode 100644 tools/perf/lib/lib.c
 create mode 100644 tools/perf/lib/libperf.map
 create mode 100644 tools/perf/lib/libperf.pc.template
 create mode 100644 tools/perf/lib/tests/Makefile
 create mode 100644 tools/perf/lib/tests/test-cpumap.c
 create mode 100644 tools/perf/lib/tests/test-evlist.c
 create mode 100644 tools/perf/lib/tests/test-evsel.c
 create mode 100644 tools/perf/lib/tests/test-threadmap.c
 create mode 100644 tools/perf/lib/threadmap.c
 create mode 100644 tools/perf/lib/xyarray.c
 create mode 100644 tools/perf/pmu-events/arch/x86/icelake/cache.json
 create mode 100644 tools/perf/pmu-events/arch/x86/icelake/floating-point.json
 create mode 100644 tools/perf/pmu-events/arch/x86/icelake/frontend.json
 create mode 100644 tools/perf/pmu-events/arch/x86/icelake/memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/icelake/other.json
 create mode 100644 tools/perf/pmu-events/arch/x86/icelake/pipeline.json
 create mode 100644 tools/perf/pmu-events/arch/x86/icelake/virtual-memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/tremontx/cache.json
 create mode 100644 tools/perf/pmu-events/arch/x86/tremontx/frontend.json
 create mode 100644 tools/perf/pmu-events/arch/x86/tremontx/memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/tremontx/other.json
 create mode 100644 tools/perf/pmu-events/arch/x86/tremontx/pipeline.json
 create mode 100644 tools/perf/pmu-events/arch/x86/tremontx/uncore-memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/tremontx/uncore-other.json
 create mode 100644 tools/perf/pmu-events/arch/x86/tremontx/uncore-power.json
 create mode 100644 tools/perf/pmu-events/arch/x86/tremontx/virtual-memory.json
 create mode 100644 tools/perf/util/cacheline.c
 create mode 100644 tools/perf/util/cacheline.h
 create mode 100644 tools/perf/util/cap.c
 create mode 100644 tools/perf/util/cap.h
 create mode 100644 tools/perf/util/dsos.c
 create mode 100644 tools/perf/util/dsos.h
 create mode 100644 tools/perf/util/events_stats.h
 create mode 100644 tools/perf/util/evswitch.c
 create mode 100644 tools/perf/util/evswitch.h
 delete mode 100644 tools/perf/util/intel-pt-decoder/gen-insn-attr-x86.awk
 delete mode 100644 tools/perf/util/intel-pt-decoder/inat.c
 delete mode 100644 tools/perf/util/intel-pt-decoder/inat_types.h
 delete mode 100644 tools/perf/util/intel-pt-decoder/insn.c
 delete mode 100644 tools/perf/util/intel-pt-decoder/x86-opcode-map.txt
 create mode 100644 tools/perf/util/record.h
 create mode 100644 tools/perf/util/symsrc.h
 delete mode 100644 tools/perf/util/util-cxx.h
