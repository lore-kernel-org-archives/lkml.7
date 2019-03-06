Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F610C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 07:28:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FDE620661
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 07:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551857304;
	bh=RKIBxL7Ap3s1vMs2kl/VW9fbDvZjXBsDN0P8mW4+2AI=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=DFB40RJnyl7C7NP9yAuTSKItYWJp4Q3qLAJC2tk98EP15WDtXcU7NgoscXon1vANC
	 HinAFB+C0FxJR8Oa9fUm5C0eF1WtjWPhVE1RlsnILCzLmHR5+QRbcBj5JMQxOViBnO
	 YBx1N2Wz5nzfcoPDfiPc2M6rUw5PEjaQZl4yTe44=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729321AbfCFH2X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 02:28:23 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45866 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729123AbfCFH2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 02:28:22 -0500
Received: by mail-wr1-f67.google.com with SMTP id w17so12134339wrn.12
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2019 23:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=8tyKFu4e+ADlhwKNWdudJYplxNuAunjsr8nlWQiEn8I=;
        b=TYYVfEnT6PgU2WfryASSGxq4S/AzYpGeQg4ila8gDSpwTLZMUQjtOqKeM3pxdqmecT
         f11DJtNNI0RjfSP5VLpK40dRkeVKWdBwpG8SpNPKTkKuhKoIq1SVSnWQpkVQp5qVcY8j
         4ZQeGXG4U1dFUBIO6KzNoW05I8fyLOj5TUh+VxzZhMrLQ7XZetpyA87qP892dUeyMP20
         dGXpOoKfvgEMmBzM0cfioWmdUa/SMJg+OzjSESOgZQIubSdve/WiGKteLVD7VuSsBbKa
         Rplc7rdy/QOa6CfRq/0RFW0GCcaxOKY+h/bAg8zk9QO6n9KxpbhvylZAiZo9ZYDa+Abd
         hD/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=8tyKFu4e+ADlhwKNWdudJYplxNuAunjsr8nlWQiEn8I=;
        b=o/o9ZQl46p5ASuQrhzg4SsjXWhOc/dVmmVe67ggIRR1HNG8AVV0ahtcxhJ0W4pDeTi
         vkG0AebH19ydghgBj2GV6/RyvO8JXqJobk8Np/kBE6XzZ7mrW9MaCA2w4BbFdzTjJvTy
         lOrvqmEpajbbsryF/0UcY95QNEVGgLjrxJ62m1y9Jh1HyZCeFzwpiHQp721GzTylNErl
         M8xzGBQ2lDWV3EZB5m55mUbqTZaqGvwplw8r4DZoUfETBV4wMgLJL3WWVHdvNyvPE42I
         AwU+nYKd6kfXVVwlydez2ut9oZ2b8A6stot7fUJM8ETQczxusV5BwG7nxIgCmGYhPkeZ
         OpPQ==
X-Gm-Message-State: APjAAAWdRTv7T9kHrpmNIhTHLWu1v1EeEG+H5dDw6kRKPOmI9msQ3ot5
        KXVzp2vQDKJh14OzT5P32Gk=
X-Google-Smtp-Source: APXvYqw6/JggkahX6n9639SyLXBuI5vhimCjvw/1LpigAktdVz8K6YO+qhdeZGytbzxweZOwmp9rfw==
X-Received: by 2002:adf:ce90:: with SMTP id r16mr1822037wrn.64.1551857297723;
        Tue, 05 Mar 2019 23:28:17 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id 65sm1554826wrb.62.2019.03.05.23.28.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Mar 2019 23:28:17 -0800 (PST)
Date:   Wed, 6 Mar 2019 08:28:14 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@infradead.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] perf changes for v5.1
Message-ID: <20190306072814.GB111385@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest perf-core-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-core-for-linus

   # HEAD: c978b9460fe1d4a1e1effa0abd6bd69b18a098a8 Merge tag 'perf-core-for-mingo-5.1-20190225' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/core

Lots of tooling updates - too many to list, here's a few highlights:

 - Various subcommand updates to 'perf trace', 'perf report',
   'perf record', 'perf annotate', 'perf script', 'perf test', etc.

 - CPU and NUMA topology and affinity handling improvements,

 - HW tracing and HW support updates:
   - Intel PT updates
   - ARM CoreSight updates
   - vendor HW event updates

 - BPF updates

 - Tons of infrastructure updates, both on the build system and the 
   library support side

 - Documentation updates.

 - ... and lots of other changes, see the changelog for details.

Kernel side updates:

 - Tighten up kprobes blacklist handling, reduce the number of places 
   where developers can install a kprobe and hang/crash the system.

 - Fix/enhance vma address filter handling.

 - Various PMU driver updates, small fixes and additions.

 - refcount_t conversions

 - BPF updates

 - error code propagation enhancements

 - misc other changes.

NOTE: I'm really sorry about 306563985819 which got a weird title early 
in the cycle and I'd have to rebase much of the tree to get rid of it. 
Will rebase if it's unacceptable. :-/

 Thanks,

	Ingo

------------------>
Adrian Hunter (22):
      perf tools: Fix split_kallsyms_for_kcore() for trampoline symbols
      perf thread-stack: Tidy thread_stack__push_cp() usage
      perf thread-stack: Tidy thread_stack__no_call_return() by adding more local variables
      perf thread-stack: Represent jmps to the start of a different symbol
      perf auxtrace: Define auxtrace record alignment
      perf intel-pt: Fix overlap calculation for padding
      perf intel-pt: Fix CYC timestamp calculation after OVF
      perf intel-pt: Packet splitting can happen only on 32-bit
      perf auxtrace: Add timestamp to auxtrace errors
      perf thread-stack: Improve thread_stack__no_call_return()
      perf thread-stack: Hide x86 retpolines
      perf scripts python: exported-sql-viewer.py: Fix missing shebang
      perf scripts python: exported-sql-viewer.py: Remove leftover debugging prints
      perf scripts python: exported-sql-viewer.py: Hide Call Graph option if no calls table
      perf scripts python: exported-sql-viewer.py: Move column headers
      perf scripts python: exported-sql-viewer.py: Factor out ReportDialogBase
      perf scripts python: exported-sql-viewer.py: Factor out ReportVars
      perf scripts python: exported-sql-viewer.py: Move report name into ReportVars
      perf scripts python: exported-sql-viewer.py: Create new dialog data item classes
      perf scripts python: exported-sql-viewer.py: Remove SQLTableDialogDataItem
      perf scripts python: exported-sql-viewer.py: Remove no selection error
      perf scripts python: exported-sql-viewer.py: Add top calls report

Alexander Shishkin (2):
      perf: Copy parent's address filter offsets on clone
      perf, pt, coresight: Fix address filters for vmas with non-zero offset

Alexey Budankov (4):
      perf record: Allocate affinity masks
      perf record: Bind the AIO user space buffers to nodes
      perf record: Apply affinity masks when reading mmap buffers
      perf record: Implement --affinity=node|cpu option

Andi Kleen (3):
      perf/x86/kvm: Avoid unnecessary work in guest filtering
      perf script: Handle missing fields with -F +..
      perf tools: Add perf_exe() helper to find perf binary

Andrea Righi (1):
      kprobes: Prohibit probing on bsearch()

Andrew Murray (12):
      perf/doc: Update design.txt for exclude_{host|guest} flags
      perf/core: Add function to test for event exclusion flags
      perf/core: Add PERF_PMU_CAP_NO_EXCLUDE for exclusion incapable PMUs
      perf/core, arch/alpha: Strengthen exclusion checks with PERF_PMU_CAP_NO_EXCLUDE
      perf/core, arch/arm: Use PERF_PMU_CAP_NO_EXCLUDE conditionally
      perf/core, arch/arm: Use PERF_PMU_CAP_NO_EXCLUDE for exclusion incapable PMUs
      For drivers that do not support context exclusion let's advertise the PERF_PMU_CAP_NO_EXCLUDE capability. This ensures that perf will prevent us from handling events where any exclusion flags are set. Let's also remove the now unnecessary check for exclusion flags.
      perf/drivers: Strengthen exclusion checks with PERF_PMU_CAP_NO_EXCLUDE
      perf/core, arch/powerpc: use PERF_PMU_CAP_NO_EXCLUDE for exclusion incapable PMUs
      perf/core, arch/x86: Use PERF_PMU_CAP_NO_EXCLUDE for exclusion incapable PMUs
      perf/core, arch/x86: Strengthen exclusion checks with PERF_PMU_CAP_NO_EXCLUDE
      perf/core: Remove unused perf_flags

Arnaldo Carvalho de Melo (54):
      perf: Make perf_event_output() propagate the output() return
      perf top: Synthesize BPF events for pre-existing loaded BPF programs
      perf python: Remove -fstack-clash-protection when building with some clang versions
      perf utils: Move perf_config using routines from color.c to separate object
      perf color: Add missing stdarg.g to color.h
      perf symbols: Move symbol_conf to separate file
      perf annotate: Remove lots of headers from annotate.h
      perf tools: Move branch structs to branch.h
      perf block-range: Add missing headers
      perf symbols: Remove include map.h from dso.h
      perf symbols: Remove some unnecessary includes from symbol.h
      perf namespaces: Remove namespaces.h from .h headers
      perf comm: Remove needless headers from comm.h
      perf callchain: No need to include perf.h
      perf bpf: Add bpf_map() helper
      perf bpf: Convert pid_map() to bpf_map()
      perf augmented_raw_syscalls: Use bpf_map()
      perf trace: Fixup etcsnoop example
      perf bpf examples: Convert etcsnoop to use bpf_map()
      perf augmented_syscalls: Convert to bpf_map()
      perf powerpc: Add missing headers to skip-callchain-idx.c
      perf arm pmu: Add missing linux/string.h header
      perf srccode: Move struct definition from map.h to srccode.h
      perf callchain: Uninline callchain_cursor_reset() to remove map.h dependency
      perf symbols: Introduce map_symbol.h
      pref tools: Add missing map.h includes
      perf map: Move structs and prototypes for map groups to a separate header
      perf tests: Add missing headers so far obtained indirectly
      perf hist: Remove symbol.h from hist.h, just fwd decls are needed
      perf tools: Add missing include for symbols.h
      perf evsel: No need to include symbol.h in evsel.h, symbol_conf.h is enough
      perf thread: Don't include symbol.h, symbol_conf.h is enough
      perf tools: Add missing include <callchain.h> in various places
      perf hist: Remove the needless callchain.h include from hist.h
      perf tests pmu: Add missing headers
      perf pmu: Remove needless evsel.h include, only needs one fwd decl
      perf kvm stat: Replace kvm-stat.h includes with forward declarations
      perf powerpc kvm-stat: Add missing evlist.h header
      perf bpf-loader: Remove unecessary includes from bpf-loader.h
      perf tools: Add fallback versions for CPU_{OR,EQUAL}()
      perf clang: Do not use 'return std::move(something)'
      tools feature: Undef _GNU_SOURCE at the end of feature tests
      perf beauty ioctl cmd: The 'fd' arg is signed
      perf trace: Check if the 'fd' is negative when mapping it to pathname
      perf beauty waitid options: Fix up prefix showing logic
      tools build: Add -lrt to FEATURE_CHECK_LDFLAGS-libaio
      perf trace: Filter out gnome-terminal* parent
      perf coresight: Do not test for libopencsd by default
      perf unwind: Do not put libunwind-{x86,aarch64} in FEATURE_TESTS_BASIC
      tools build: Add test-reallocarray.c to test-all.c to fix the build
      perf build: Add missing FEATURE_CHECK_LDFLAGS-libcrypto
      tools build feature sched_getcpu: Undef _GNU_SOURCE at the end
      perf bpf: Add bpf_map dumper
      perf trace: Allow dumping a BPF map after setting up BPF events

Brajeswar Ghosh (1):
      perf tools: Remove duplicate headers

Changbin Du (1):
      perf tools: Add documentation for BPF event selection

Davidlohr Bueso (7):
      tools: Update rbtree implementation
      perf machine: Use cached rbtrees
      perf callchain: Use cached rbtrees
      perf util: Use cached rbtree for rblists
      perf symbols: Use cached rbtrees
      perf hist: Use cached rbtrees
      perf sched: Use cached rbtrees

Elena Reshetova (3):
      perf: Convert perf_event_context.refcount to refcount_t
      perf/ring_buffer: Convert ring_buffer.refcount to refcount_t
      perf/ring_buffer: Convert ring_buffer.aux_refcount to refcount_t

He Kuang (1):
      perf report: Don't shadow inlined symbol with different addr range

Jiaxun Yang (1):
      x86/CPU/AMD: Set the CPB bit unconditionally on F17h

Jiri Olsa (35):
      perf session: Rearrange perf_session__process_events function
      perf session: Get rid of file_size variable
      perf session: Add reader object
      perf session: Add 'data_size' member to reader object
      perf session: Add 'data_offset' member to reader object
      perf session: Add reader__process_events function
      perf hists: Add argument to hists__resort_cb_t callback
      perf evsel: Add output_resort_cb method
      perf report: Move symbol annotation to the resort phase
      perf tools: Compile perf with libperf-in.o instead of libperf.a
      perf tools: Rename LIB_FILE to LIBPERF_A
      perf tools: Rename build libperf to perf
      perf tools: Fix legacy events symbol separator parsing
      perf list: Display metric expressions for --details option
      perf header: Get rid of write_it label
      perf header: Remove unused 'cpu_nr' field  from 'struct cpu_topo'
      perf header: Fix wrong node write in NUMA_TOPOLOGY feature
      perf tools: Add cpu_topology object
      perf tools: Add numa_topology object
      perf tools: Use sysfs__mountpoint() when reading cpu topology
      perf session: Don't report zero period samples for slave events
      perf evsel: Force sample_type for slave events
      perf script: Allow +- operator for type specific fields option
      perf bpf-event: Add missing new line into pr_debug call
      perf cpumap: Increase debug level for cpu_map__snprint verbose output
      perf tools: Make rm_rf() remove single file
      perf data: Move size to struct perf_data_file
      perf data: Add global path holder
      perf tools: Add depth checking to rm_rf
      perf tools: Add pattern name checking to rm_rf
      perf tools: Add rm_rf_perf_data function
      perf data: Make check_backup work over directories
      perf data: Fail check_backup in case of error
      perf data: Add perf_data__(create_dir|close_dir) functions
      perf data: Add perf_data__open_dir_data function

Jonas Rabenstein (2):
      perf doc: Fix HEADER_CMDLINE description in perf.data documentation
      perf doc: Fix documentation of the Flags section in perf.data

Kan Liang (4):
      x86/cpufeature: Add facility to check for min microcode revisions
      perf/x86/intel: Clean up SNB PEBS quirk
      perf/x86/intel: Clean up counter freezing quirk
      perf/x86/intel: Add counter freezing quirk for Goldmont

Leo Yan (8):
      perf cs-etm: Add last instruction information in packet
      perf cs-etm: Set sample flags for instruction range packet
      perf cs-etm: Set sample flags for trace discontinuity
      perf cs-etm: Add exception number in exception packet
      perf cs-etm: Change tuple from traceID-CPU# to traceID-metadata
      perf cs-etm: Add traceID in packet
      perf cs-etm: Set sample flags for exception packet
      perf cs-etm: Set sample flags for exception return packet

Masami Hiramatsu (9):
      x86/kprobes: Prohibit probing on optprobe template code
      x86/kprobes: Move trampoline code into RODATA
      x86/kprobes: Prohibit probing on functions before kprobe_int3_handler()
      x86/kprobes: Prohibit probing on IRQ handlers directly
      kprobes: Search non-suffixed symbol in blacklist
      kprobes: Prohibit probing on hardirq tracers
      kprobes: Prohibit probing on preemption checking debug functions
      kprobes: Prohibit probing on RCU debug routine
      kprobes: Prohibit probing on lockdep functions

Mathieu Poirier (21):
      perf/aux: Make perf_event accessible to setup_aux()
      coresight: perf: Add "sinks" group to PMU directory
      coresight: Use event attributes for sink selection
      perf pmu: Move EVENT_SOURCE_DEVICE_PATH to PMU header file
      perf arm cs-etm: Use event attributes to send sink information to kernel
      perf coresight: Remove set_drv_config() API
      perf pmu: Remove set_drv_config API
      perf cs-etm: Add proper header file for symbols
      perf cs-etm: Remove unused structure field "state"
      perf cs-etm: Remove unused structure field "time" and "timestamp"
      perf cs-etm: Fix wrong return values in error path
      perf cs-etm: Introducing function cs_etm_decoder__init_dparams()
      perf cs-etm: Fix memory leak in error path
      perf cs-etm: Introducing function cs_etm__init_trace_params()
      perf cs-etm: Fix erroneous comment
      perf cs-etm: Cleaning up function cs_etm__alloc_queue()
      perf cs-etm: Rethink kernel address initialisation
      perf cs-etm: Make cs_etm__run_decoder() queue independent
      perf cs-etm: Modularize main decoder function
      perf cs-etm: Modularize main packet processing loop
      perf cs-etm: Modularize auxtrace_buffer fetch function

Paul Clarke (8):
      perf vendor events power8: Cpi_breakdown & estimated_dcache_miss_cpi metrics
      perf vendor events power8: Dl1_reload, instruction_misses, l2_stats, lsu_rejects, memory & pteg_reloads metrics
      perf vendor events power8: Branch_prediction, latency, bus_stats, instruction_mix & instruction_stats metrics
      perf vendor events power8: Translaton & general metrics
      perf vendor events power9: Cpi_breakdown & estimated_dcache_miss_cpi metrics
      perf vendor events power9: Dl1_reloads, instruction_misses, l[23]_stats & pteg_reloads metrics
      perf vendor events power9: Branch_prediction, instruction_stats, latency, lsu_rejects, memory, prefetch & translation metrics
      perf vendor events power9: General metrics

Rasmus Villemoes (1):
      perf tools: Replace automatic const char[] variables by statics

Song Liu (10):
      perf, bpf: Introduce PERF_RECORD_KSYMBOL
      tools headers uapi: Sync tools/include/uapi/linux/perf_event.h
      perf, bpf: Introduce PERF_RECORD_BPF_EVENT
      tools headers uapi: Sync tools/include/uapi/linux/perf_event.h
      perf tools: Handle PERF_RECORD_KSYMBOL
      perf tools: Handle PERF_RECORD_BPF_EVENT
      perf tools: Synthesize PERF_RECORD_* for loaded BPF programs
      bpf: Add module name [bpf] to ksymbols for bpf programs
      perf bpf: Fix synthesized PERF_RECORD_KSYMBOL/BPF_EVENT
      perf utils: Silence "Couldn't synthesize bpf events" warning for EPERM

Thomas Gleixner (3):
      perf/core: Convert to SPDX license identifiers
      perf/hw_breakpoints: Convert to SPDX license identifier
      perf/uprobes: Convert to SPDX license identifier

Thomas Richter (5):
      perf report: Display arch specific diagnostic counter sets, starting with s390
      perf report: Display names in s390 diagnostic counter sets
      perf report: Dump s390 counter set data to file
      perf report: Add s390 diagnosic sampling descriptor size
      perf test: Fix failure of 'evsel-tp-sched' test on s390

Tommi Rantala (1):
      perf tests shell: Skip trace+probe_vfs_getname.sh if built without trace support

Tony Jones (16):
      perf script python: Add trace_context extension module to sys.modules
      perf script python: Use PyBytes for attr in trace-event-python
      perf script python: Remove explicit shebang from setup.py
      perf script python: Remove explicit shebang from tests/attr.c
      perf script python: Remove explicit shebang from Python scripts
      perf script python: Add Python3 support to tests/attr.py
      perf script python: Add Python3 support to netdev-times.py
      perf script python: Add Python3 support to failed-syscalls-by-pid.py
      perf script python: Add Python3 support to mem-phys-addr.py
      perf script python: Add Python3 support to net_dropmonitor.py
      perf script python: Add Python3 support to powerpc-hcalls.py
      perf script python: Add Python3 support to sctop.py
      perf script python: Add Python3 support to stackcollapse.py
      perf script python: Add Python3 support to stat-cpi.py
      perf script python: Add Python3 support to syscall-counts.py
      perf script python: Add Python3 support to syscall-counts-by-pid.py

Wei Li (1):
      perf annotate: Fix getting source line failure

William Cohen (1):
      perf vendor events intel: Fix Load_Miss_Real_Latency on CLX

YueHaibing (1):
      perf: Remove duplicated workqueue.h include from perf_event.h


 arch/alpha/kernel/perf_event.c                     |    7 +-
 arch/arm/mach-imx/mmdc.c                           |    9 +-
 arch/arm/mm/cache-l2x0-pmu.c                       |    9 +-
 arch/powerpc/perf/hv-24x7.c                        |   10 +-
 arch/powerpc/perf/hv-gpci.c                        |   10 +-
 arch/powerpc/perf/imc-pmu.c                        |   19 +-
 arch/s390/kernel/perf_cpum_sf.c                    |    6 +-
 arch/x86/events/amd/ibs.c                          |   13 +-
 arch/x86/events/amd/iommu.c                        |    6 +-
 arch/x86/events/amd/power.c                        |   10 +-
 arch/x86/events/amd/uncore.c                       |    7 +-
 arch/x86/events/intel/bts.c                        |    4 +-
 arch/x86/events/intel/core.c                       |  135 +-
 arch/x86/events/intel/cstate.c                     |   12 +-
 arch/x86/events/intel/ds.c                         |    2 +
 arch/x86/events/intel/pt.c                         |   14 +-
 arch/x86/events/intel/rapl.c                       |    9 +-
 arch/x86/events/intel/uncore.c                     |    9 +-
 arch/x86/events/intel/uncore_snb.c                 |    9 +-
 arch/x86/events/msr.c                              |   10 +-
 arch/x86/events/perf_event.h                       |   15 +-
 arch/x86/include/asm/cpu_device_id.h               |   28 +
 arch/x86/kernel/alternative.c                      |    3 +-
 arch/x86/kernel/cpu/amd.c                          |    8 +-
 arch/x86/kernel/cpu/match.c                        |   31 +
 arch/x86/kernel/ftrace.c                           |    3 +-
 arch/x86/kernel/kprobes/core.c                     |    7 +
 arch/x86/kernel/kprobes/opt.c                      |    4 +-
 arch/x86/kernel/traps.c                            |    1 +
 drivers/hwtracing/coresight/coresight-etm-perf.c   |  119 +-
 drivers/hwtracing/coresight/coresight-etm-perf.h   |    6 +-
 drivers/hwtracing/coresight/coresight-priv.h       |    1 +
 drivers/hwtracing/coresight/coresight.c            |   60 +
 drivers/perf/arm-cci.c                             |   10 +-
 drivers/perf/arm-ccn.c                             |    6 +-
 drivers/perf/arm_dsu_pmu.c                         |    9 +-
 drivers/perf/arm_pmu.c                             |   15 +-
 drivers/perf/arm_spe_pmu.c                         |    6 +-
 drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c      |    1 +
 drivers/perf/hisilicon/hisi_uncore_hha_pmu.c       |    1 +
 drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c       |    1 +
 drivers/perf/hisilicon/hisi_uncore_pmu.c           |    9 -
 drivers/perf/qcom_l2_pmu.c                         |    9 +-
 drivers/perf/qcom_l3_pmu.c                         |    8 +-
 drivers/perf/thunderx2_pmu.c                       |   10 +-
 drivers/perf/xgene_pmu.c                           |    6 +-
 include/linux/coresight.h                          |    7 +-
 include/linux/filter.h                             |    7 +
 include/linux/perf_event.h                         |   43 +-
 include/uapi/linux/perf_event.h                    |   55 +-
 kernel/bpf/core.c                                  |    2 +-
 kernel/bpf/syscall.c                               |    2 +
 kernel/events/callchain.c                          |    3 +-
 kernel/events/core.c                               |  344 ++-
 kernel/events/hw_breakpoint.c                      |   15 +-
 kernel/events/internal.h                           |    5 +-
 kernel/events/ring_buffer.c                        |   13 +-
 kernel/events/uprobes.c                            |   15 +-
 kernel/kallsyms.c                                  |    2 +-
 kernel/kprobes.c                                   |   21 +-
 kernel/locking/lockdep.c                           |    7 +-
 kernel/rcu/tree.c                                  |    2 +
 kernel/rcu/update.c                                |    2 +
 kernel/trace/bpf_trace.c                           |    3 +-
 kernel/trace/trace_irqsoff.c                       |    9 +-
 kernel/trace/trace_preemptirq.c                    |    5 +
 lib/bsearch.c                                      |    2 +
 lib/smp_processor_id.c                             |    7 +-
 tools/build/Makefile.feature                       |   10 +-
 tools/build/feature/test-all.c                     |   10 +-
 tools/build/feature/test-get_current_dir_name.c    |    1 +
 tools/build/feature/test-libpython.c               |    1 +
 tools/build/feature/test-reallocarray.c            |    2 +
 tools/build/feature/test-sched_getcpu.c            |    2 +
 tools/build/feature/test-setns.c                   |    1 +
 tools/include/linux/rbtree.h                       |   52 +-
 tools/include/linux/rbtree_augmented.h             |   60 +-
 tools/include/uapi/linux/perf_event.h              |   55 +-
 tools/lib/rbtree.c                                 |  178 +-
 tools/perf/Build                                   |   10 +-
 tools/perf/Documentation/perf-config.txt           |   31 +
 tools/perf/Documentation/perf-record.txt           |   19 +
 tools/perf/Documentation/perf-script.txt           |    6 +
 tools/perf/Documentation/perf-trace.txt            |    8 +
 tools/perf/Documentation/perf.data-file-format.txt |   11 +-
 tools/perf/Makefile.config                         |   14 +-
 tools/perf/Makefile.perf                           |   28 +-
 tools/perf/arch/Build                              |    4 +-
 tools/perf/arch/arm/Build                          |    4 +-
 tools/perf/arch/arm/tests/Build                    |    8 +-
 tools/perf/arch/arm/tests/dwarf-unwind.c           |    1 +
 tools/perf/arch/arm/util/Build                     |    8 +-
 tools/perf/arch/arm/util/cs-etm.c                  |   98 +-
 tools/perf/arch/arm/util/cs-etm.h                  |    3 -
 tools/perf/arch/arm/util/pmu.c                     |    3 +-
 tools/perf/arch/arm64/Build                        |    4 +-
 tools/perf/arch/arm64/tests/Build                  |    6 +-
 tools/perf/arch/arm64/tests/dwarf-unwind.c         |    1 +
 tools/perf/arch/arm64/util/Build                   |   12 +-
 tools/perf/arch/nds32/Build                        |    2 +-
 tools/perf/arch/nds32/util/Build                   |    2 +-
 tools/perf/arch/powerpc/Build                      |    4 +-
 tools/perf/arch/powerpc/tests/Build                |    6 +-
 tools/perf/arch/powerpc/tests/dwarf-unwind.c       |    1 +
 tools/perf/arch/powerpc/util/Build                 |   18 +-
 tools/perf/arch/powerpc/util/kvm-stat.c            |    2 +
 tools/perf/arch/powerpc/util/skip-callchain-idx.c  |    3 +
 tools/perf/arch/s390/Build                         |    2 +-
 tools/perf/arch/s390/util/Build                    |   12 +-
 tools/perf/arch/s390/util/kvm-stat.c               |    1 +
 tools/perf/arch/sh/Build                           |    2 +-
 tools/perf/arch/sh/util/Build                      |    2 +-
 tools/perf/arch/sparc/Build                        |    2 +-
 tools/perf/arch/sparc/util/Build                   |    2 +-
 tools/perf/arch/x86/Build                          |    4 +-
 tools/perf/arch/x86/tests/Build                    |   14 +-
 tools/perf/arch/x86/tests/dwarf-unwind.c           |    1 +
 tools/perf/arch/x86/util/Build                     |   30 +-
 tools/perf/arch/x86/util/kvm-stat.c                |    1 +
 tools/perf/arch/xtensa/Build                       |    2 +-
 tools/perf/arch/xtensa/util/Build                  |    2 +-
 tools/perf/builtin-annotate.c                      |    9 +-
 tools/perf/builtin-buildid-cache.c                 |    4 +-
 tools/perf/builtin-buildid-list.c                  |    8 +-
 tools/perf/builtin-c2c.c                           |   23 +-
 tools/perf/builtin-diff.c                          |   22 +-
 tools/perf/builtin-evlist.c                        |    4 +-
 tools/perf/builtin-inject.c                        |   12 +-
 tools/perf/builtin-kallsyms.c                      |    1 +
 tools/perf/builtin-kmem.c                          |    7 +-
 tools/perf/builtin-kvm.c                           |    8 +-
 tools/perf/builtin-list.c                          |    8 +-
 tools/perf/builtin-lock.c                          |    8 +-
 tools/perf/builtin-mem.c                           |    9 +-
 tools/perf/builtin-probe.c                         |    1 +
 tools/perf/builtin-record.c                        |   74 +-
 tools/perf/builtin-report.c                        |   37 +-
 tools/perf/builtin-sched.c                         |   63 +-
 tools/perf/builtin-script.c                        |   31 +-
 tools/perf/builtin-stat.c                          |   16 +-
 tools/perf/builtin-timechart.c                     |    8 +-
 tools/perf/builtin-top.c                           |   23 +-
 tools/perf/builtin-trace.c                         |   38 +-
 tools/perf/design.txt                              |    4 +
 tools/perf/examples/bpf/augmented_raw_syscalls.c   |   18 +-
 tools/perf/examples/bpf/augmented_syscalls.c       |   22 +-
 tools/perf/examples/bpf/etcsnoop.c                 |   18 +-
 tools/perf/include/bpf/bpf.h                       |   16 +-
 tools/perf/perf.h                                  |    9 +
 .../pmu-events/arch/powerpc/power8/metrics.json    | 2245 ++++++++++++++++++++
 .../pmu-events/arch/powerpc/power9/metrics.json    | 1982 +++++++++++++++++
 .../arch/x86/cascadelakex/clx-metrics.json         |    2 +-
 tools/perf/scripts/Build                           |    4 +-
 tools/perf/scripts/perl/Perf-Trace-Util/Build      |    2 +-
 tools/perf/scripts/python/Perf-Trace-Util/Build    |    2 +-
 tools/perf/scripts/python/export-to-postgresql.py  |    2 +-
 tools/perf/scripts/python/export-to-sqlite.py      |    2 +-
 tools/perf/scripts/python/exported-sql-viewer.py   |  511 +++--
 .../perf/scripts/python/failed-syscalls-by-pid.py  |   21 +-
 tools/perf/scripts/python/mem-phys-addr.py         |   24 +-
 tools/perf/scripts/python/net_dropmonitor.py       |   10 +-
 tools/perf/scripts/python/netdev-times.py          |   82 +-
 tools/perf/scripts/python/powerpc-hcalls.py        |   18 +-
 tools/perf/scripts/python/sched-migration.py       |    2 -
 tools/perf/scripts/python/sctop.py                 |   24 +-
 tools/perf/scripts/python/stackcollapse.py         |    7 +-
 tools/perf/scripts/python/stat-cpi.py              |   11 +-
 tools/perf/scripts/python/syscall-counts-by-pid.py |   22 +-
 tools/perf/scripts/python/syscall-counts.py        |   18 +-
 tools/perf/tests/attr.py                           |    1 -
 tools/perf/tests/bp_account.c                      |    1 -
 tools/perf/tests/code-reading.c                    |    2 +
 tools/perf/tests/dwarf-unwind.c                    |    1 +
 tools/perf/tests/evsel-tp-sched.c                  |    6 +-
 tools/perf/tests/hists_common.c                    |    9 +-
 tools/perf/tests/hists_cumulate.c                  |   15 +-
 tools/perf/tests/hists_filter.c                    |    1 +
 tools/perf/tests/hists_link.c                      |    8 +-
 tools/perf/tests/hists_output.c                    |   33 +-
 tools/perf/tests/mmap-thread-lookup.c              |    1 +
 tools/perf/tests/parse-events.c                    |   30 +
 tools/perf/tests/pmu.c                             |    2 +
 tools/perf/tests/sample-parsing.c                  |    2 +
 tools/perf/tests/sdt.c                             |    1 +
 tools/perf/tests/shell/lib/probe.sh                |    5 +
 tools/perf/tests/shell/trace+probe_vfs_getname.sh  |    1 +
 tools/perf/trace/beauty/Build                      |   26 +-
 tools/perf/trace/beauty/ioctl.c                    |    2 +-
 tools/perf/trace/beauty/waitid_options.c           |    2 +-
 tools/perf/ui/Build                                |   18 +-
 tools/perf/ui/browsers/Build                       |   10 +-
 tools/perf/ui/browsers/annotate.c                  |    1 +
 tools/perf/ui/browsers/header.c                    |    2 +-
 tools/perf/ui/browsers/hists.c                     |   23 +-
 tools/perf/ui/browsers/map.c                       |    1 +
 tools/perf/ui/gtk/annotate.c                       |    3 +
 tools/perf/ui/gtk/hists.c                          |    7 +-
 tools/perf/ui/hist.c                               |    1 +
 tools/perf/ui/stdio/hist.c                         |    7 +-
 tools/perf/ui/tui/Build                            |    8 +-
 tools/perf/util/Build                              |  276 +--
 tools/perf/util/annotate.c                         |    6 +-
 tools/perf/util/annotate.h                         |   14 +-
 tools/perf/util/auxtrace.c                         |   27 +-
 tools/perf/util/auxtrace.h                         |    5 +-
 tools/perf/util/block-range.c                      |    2 +
 tools/perf/util/block-range.h                      |    6 +-
 tools/perf/util/bpf-event.c                        |  263 +++
 tools/perf/util/bpf-event.h                        |   38 +
 tools/perf/util/bpf-loader.c                       |    1 +
 tools/perf/util/bpf-loader.h                       |    7 +-
 tools/perf/util/bpf_map.c                          |   72 +
 tools/perf/util/bpf_map.h                          |   22 +
 tools/perf/util/branch.h                           |   27 +-
 tools/perf/util/build-id.c                         |   14 +-
 tools/perf/util/build-id.h                         |    3 +-
 tools/perf/util/c++/Build                          |    4 +-
 tools/perf/util/callchain.c                        |   17 +
 tools/perf/util/callchain.h                        |   21 +-
 tools/perf/util/color.c                            |   39 -
 tools/perf/util/color.h                            |    1 +
 tools/perf/util/color_config.c                     |   47 +
 tools/perf/util/comm.c                             |    1 +
 tools/perf/util/comm.h                             |    4 +-
 tools/perf/util/config.c                           |    1 +
 tools/perf/util/cpu-set-sched.h                    |   50 +
 tools/perf/util/cpumap.c                           |   12 +-
 tools/perf/util/cpumap.h                           |    1 +
 tools/perf/util/cputopo.c                          |  277 +++
 tools/perf/util/cputopo.h                          |   33 +
 tools/perf/util/cs-etm-decoder/Build               |    2 +-
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c    |   41 +-
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.h    |   16 +-
 tools/perf/util/cs-etm.c                           |  832 ++++++--
 tools/perf/util/cs-etm.h                           |   57 +-
 tools/perf/util/data-convert-bt.c                  |    4 +-
 tools/perf/util/data.c                             |  175 +-
 tools/perf/util/data.h                             |   16 +-
 tools/perf/util/db-export.c                        |    1 +
 tools/perf/util/drv_configs.c                      |   78 -
 tools/perf/util/drv_configs.h                      |   26 -
 tools/perf/util/dso.c                              |   11 +-
 tools/perf/util/dso.h                              |   17 +-
 tools/perf/util/event.c                            |   43 +
 tools/perf/util/event.h                            |   60 +-
 tools/perf/util/evlist.c                           |    6 +-
 tools/perf/util/evlist.h                           |    6 +-
 tools/perf/util/evsel.c                            |   27 +-
 tools/perf/util/evsel.h                            |    4 +-
 tools/perf/util/header.c                           |  289 +--
 tools/perf/util/hist.c                             |  220 +-
 tools/perf/util/hist.h                             |   19 +-
 tools/perf/util/intel-bts.c                        |    6 +-
 tools/perf/util/intel-pt-decoder/Build             |    2 +-
 .../perf/util/intel-pt-decoder/intel-pt-decoder.c  |   39 +-
 tools/perf/util/intel-pt.c                         |   23 +-
 tools/perf/util/intlist.h                          |    2 +-
 tools/perf/util/jitdump.c                          |    1 +
 tools/perf/util/kvm-stat.h                         |    7 +-
 tools/perf/util/machine.c                          |  112 +-
 tools/perf/util/machine.h                          |   17 +-
 tools/perf/util/map.c                              |   14 +-
 tools/perf/util/map.h                              |  100 +-
 tools/perf/util/map_groups.h                       |   91 +
 tools/perf/util/map_symbol.h                       |   22 +
 tools/perf/util/metricgroup.c                      |   10 +-
 tools/perf/util/metricgroup.h                      |    3 +-
 tools/perf/util/mmap.c                             |  105 +-
 tools/perf/util/mmap.h                             |    3 +-
 tools/perf/util/parse-events.c                     |    2 +-
 tools/perf/util/parse-events.y                     |    4 +-
 tools/perf/util/pmu.c                              |    2 -
 tools/perf/util/pmu.h                              |    5 +-
 tools/perf/util/probe-event.c                      |    6 +-
 tools/perf/util/probe-event.h                      |    5 +-
 tools/perf/util/probe-file.c                       |    1 +
 tools/perf/util/rb_resort.h                        |    8 +-
 tools/perf/util/rblist.c                           |   28 +-
 tools/perf/util/rblist.h                           |    2 +-
 tools/perf/util/s390-cpumcf-kernel.h               |   62 +
 tools/perf/util/s390-cpumsf.c                      |   89 +-
 tools/perf/util/s390-sample-raw.c                  |  222 ++
 tools/perf/util/sample-raw.c                       |   18 +
 tools/perf/util/sample-raw.h                       |   14 +
 tools/perf/util/scripting-engines/Build            |    4 +-
 .../perf/util/scripting-engines/trace-event-perl.c |    2 +
 .../util/scripting-engines/trace-event-python.c    |   17 +-
 tools/perf/util/session.c                          |  110 +-
 tools/perf/util/setup.py                           |    7 +-
 tools/perf/util/sort.c                             |   18 +-
 tools/perf/util/sort.h                             |    7 +-
 tools/perf/util/srccode.h                          |   13 +
 tools/perf/util/srcline.c                          |   45 +-
 tools/perf/util/srcline.h                          |   13 +-
 tools/perf/util/stat-display.c                     |    1 +
 tools/perf/util/stat-shadow.c                      |    2 +-
 tools/perf/util/strlist.h                          |    2 +-
 tools/perf/util/symbol-elf.c                       |    2 +
 tools/perf/util/symbol-minimal.c                   |    1 +
 tools/perf/util/symbol.c                           |   90 +-
 tools/perf/util/symbol.h                           |  102 +-
 tools/perf/util/symbol_conf.h                      |   73 +
 tools/perf/util/symbol_fprintf.c                   |    3 +-
 tools/perf/util/thread-stack.c                     |  235 +-
 tools/perf/util/thread-stack.h                     |    3 +
 tools/perf/util/thread.c                           |    1 +
 tools/perf/util/thread.h                           |    8 +-
 tools/perf/util/tool.h                             |    5 +-
 tools/perf/util/unwind-libdw.c                     |    2 +
 tools/perf/util/unwind-libunwind-local.c           |    1 +
 tools/perf/util/unwind-libunwind.c                 |    1 +
 tools/perf/util/util.c                             |   82 +-
 tools/perf/util/util.h                             |    3 +
 tools/perf/util/vdso.c                             |    1 +
 tools/perf/util/zlib.c                             |    1 -
 315 files changed, 10259 insertions(+), 2608 deletions(-)
 create mode 100644 tools/perf/pmu-events/arch/powerpc/power8/metrics.json
 create mode 100644 tools/perf/pmu-events/arch/powerpc/power9/metrics.json
 create mode 100644 tools/perf/util/bpf-event.c
 create mode 100644 tools/perf/util/bpf-event.h
 create mode 100644 tools/perf/util/bpf_map.c
 create mode 100644 tools/perf/util/bpf_map.h
 create mode 100644 tools/perf/util/color_config.c
 create mode 100644 tools/perf/util/cpu-set-sched.h
 create mode 100644 tools/perf/util/cputopo.c
 create mode 100644 tools/perf/util/cputopo.h
 delete mode 100644 tools/perf/util/drv_configs.c
 delete mode 100644 tools/perf/util/drv_configs.h
 create mode 100644 tools/perf/util/map_groups.h
 create mode 100644 tools/perf/util/map_symbol.h
 create mode 100644 tools/perf/util/s390-cpumcf-kernel.h
 create mode 100644 tools/perf/util/s390-sample-raw.c
 create mode 100644 tools/perf/util/sample-raw.c
 create mode 100644 tools/perf/util/sample-raw.h
 create mode 100644 tools/perf/util/symbol_conf.h
