Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 487DEC31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 18:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F30D62084D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 18:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560797346;
	bh=slHJtbXoSpsdQFQCRZwP9pcfEV4oTNLjIW2ZcbLxiOs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=f/OptRw7TzcSOFsEfEodBJ/cbssy7jtr/kmlFR1RvqKFhd7qajEd/8/ww+AALGcrC
	 dX2O0anFXGBdBUYM1btoaOQDJzJwK9BQnWygAYPu+3ol6eBlw5ytGC4739yjfA3wqB
	 U2WPO2fR0EVtAfx3YNClBoNgqnZbxTn74+9Y5h1A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbfFQStE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 14:49:04 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45006 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbfFQStE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 14:49:04 -0400
Received: by mail-wr1-f65.google.com with SMTP id r16so11118394wrl.11;
        Mon, 17 Jun 2019 11:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yz43Dh2etdDTmtFHPWEOd/hXbirb+fd3e+eS3AkP88M=;
        b=uxSi72cK90COf5iHz8q7HKvI6WN7nXoYzvpYf/PsaLBsCG+WzeiqhOZZ1aPB1Ce5wz
         R2Xd3XAVqmuiFQeHF+joMV4mEe+2vdLpTLkWeM+T/86LpvY28Y7YKq5wjnLy0eBKUtdh
         Jmzv3alopz5SxSXW7cD0QkYMFMjj3Esv62VYzMAzn+fpg6MbSlo5WZN/SNpTbbZCxvIl
         XjlVdHl7ehz8pY/h4cnIHuLmm9yP4y2WOmlP1KlXOT6m/j7ZBnS1sAlfA2iDBK1PTT0Y
         Oag8OgrHq+OxxmPkRrbQ80nWU5IR0ZscwUCCZOrRdqNNDljllkZUFzcqaBRi7A8HAIOQ
         DTeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=yz43Dh2etdDTmtFHPWEOd/hXbirb+fd3e+eS3AkP88M=;
        b=tBFYC0agtFCrJ0mkyqt1zJhL0HAmzqzlgc2xGeKGPfr1V9r7fucu1hkwCriBP0sqah
         3cyzzMKqmykU4ZOr2FKaaHNgdaT18O3hen//bGa5t23aBXMEwj4BnVOwgRPtpq+z6MVS
         WeJ/sO/SSWNpjNe2nBcc3UMGJWt7PzvgpzYYFc+a+Vt86yTX0y7PSVaiuezek7JfkthT
         MsqAb/rbVk8fo3MdH8nNdZoCqJgwshYL8YaM7jJjqXvUf+MPV5cJyxLJc3vF7Hp4NCNU
         XtttyZ1Qwh4xRwlKImL+NUeEOgNwouCWf8noV3RFEsSbXM8rFH+HkedQLKpLA6kP77+J
         dOEQ==
X-Gm-Message-State: APjAAAWNrmubP9FzRb3+0FQFVar8ZKQwTZaUTU9dzsaS/gXHcZF/HnI5
        spyIixwOOXhBWFoEUIpVed0=
X-Google-Smtp-Source: APXvYqxnLKdyb6GtbkJP/eGOgPDkoHFFnTgdM49pzTjRvjSvOaO1CC9lFgAqx08xXAw0PGKSBRcopg==
X-Received: by 2002:a5d:4286:: with SMTP id k6mr16070970wrq.151.1560797339582;
        Mon, 17 Jun 2019 11:48:59 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id l1sm15288897wrf.46.2019.06.17.11.48.57
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 17 Jun 2019 11:48:58 -0700 (PDT)
Date:   Mon, 17 Jun 2019 20:48:56 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Song Liu <songliubraving@fb.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        yuzhoujian <yuzhoujian@didichuxing.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [GIT PULL] perf/core improvements and fixes
Message-ID: <20190617184856.GA37768@gmail.com>
References: <20190611185911.11645-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190611185911.11645-1-acme@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Hi Ingo,
> 
> 	Please consider pulling,
> 
> Best regards,
> 
> Test results at the end of this message, as usual.
> 
> - Arnaldo
> 
> The following changes since commit 3384c78631dd722c2cdc5c57fbdd39fc1b5a9f2d:
> 
>   Merge branch 'x86/topology' into perf/core, to prepare for new patches (2019-06-03 11:58:45 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-5.3-20190611
> 
> for you to fetch changes up to 04c41bcb862bbec1fb225243ecf07a3219593f81:
> 
>   perf trace: Skip unknown syscalls when expanding strace like syscall groups (2019-06-10 17:50:04 -0300)
> 
> ----------------------------------------------------------------
> perf/core improvements and fixes:
> 
> perf record:
> 
>   Alexey Budankov:
> 
>   - Allow mixing --user-regs with --call-graph=dwarf, making sure that
>     the minimal set of registers for DWARF unwinding is present in the
>     set of user registers requested to be present in each sample, while
>     warning the user that this may make callchains unreliable if more
>     that the minimal set of registers is needed to unwind.
> 
>   yuzhoujian:
> 
>   - Add support to collect callchains from kernel or user space only,
>     IOW allow setting the perf_event_attr.exclude_callchain_{kernel,user}
>     bits from the command line.
> 
> perf trace:
> 
>   Arnaldo Carvalho de Melo:
> 
>   - Remove x86_64 specific syscall numbers from the augmented_raw_syscalls
>     BPF in-kernel collector of augmented raw_syscalls:sys_{enter,exit}
>     payloads, use instead the syscall numbers obtainer either by the
>     arch specific syscalltbl generators or from audit-libs.
> 
>   - Allow 'perf trace' to ask for the number of bytes to collect for
>     string arguments, for now ask for PATH_MAX, i.e. the whole
>     pathnames, which ends up being just a way to speficy which syscall
>     args are pathnames and thus should be read using bpf_probe_read_str().
> 
>   - Skip unknown syscalls when expanding strace like syscall groups.
>     This helps using the 'string' group of syscalls to work in arm64,
>     where some of the syscalls present in x86_64 that deal with
>     strings, for instance 'access', are deprecated and this should not
>     be asked for tracing.
> 
>   Leo Yan:
> 
>   - Exit when failing to build eBPF program.
> 
> perf config:
> 
>   Arnaldo Carvalho de Melo:
> 
>   - Bail out when a handler returns failure for a key-value pair. This
>     helps with cases where processing a key-value pair is not just a
>     matter of setting some tool specific knob, involving, for instance
>     building a BPF program to then attach to the list of events 'perf
>     trace' will use, e.g. augmented_raw_syscalls.c.
> 
> perf.data:
> 
>   Kan Liang:
> 
>   - Read and store die ID information available in new Intel processors
>     in CPUID.1F in the CPU topology written in the perf.data header.
> 
> perf stat:
> 
>   Kan Liang:
> 
>   - Support per-die aggregation.
> 
> Documentation:
> 
>   Arnaldo Carvalho de Melo:
> 
>   - Update perf.data documentation about the CPU_TOPOLOGY, MEM_TOPOLOGY,
>     CLOCKID and DIR_FORMAT headers.
> 
>   Song Liu:
> 
>   - Add description of headers HEADER_BPF_PROG_INFO and HEADER_BPF_BTF.
> 
>   Leo Yan:
> 
>   - Update default value for llvm.clang-bpf-cmd-template in 'man perf-config'.
> 
> JVMTI:
> 
>   Jiri Olsa:
> 
>   - Address gcc string overflow warning for strncpy()
> 
> core:
> 
>   - Remove superfluous nthreads system_wide setup in perf_evsel__alloc_fd().
> 
> Intel PT:
> 
>   Adrian Hunter:
> 
>   - Add support for samples to contain IPC ratio, collecting cycles
>     information from CYC packets, showing the IPC info periodically, because
>     Intel PT does not update the cycle count on every branch or instruction,
>     the incremental values will often be zero.  When there are values, they
>     will be the number of instructions and number of cycles since the last
>     update, and thus represent the average IPC since the last IPC value.
> 
>     E.g.:
> 
>     # perf record --cpu 1 -m200000 -a -e intel_pt/cyc/u sleep 0.0001
>     rounding mmap pages size to 1024M (262144 pages)
>     [ perf record: Woken up 0 times to write data ]
>     [ perf record: Captured and wrote 2.208 MB perf.data ]
>     # perf script --insn-trace --xed -F+ipc,-dso,-cpu,-tid
>     #
>     <SNIP + add line numbering to make sense of IPC counts e.g.: (18/3)>
>     1   cc1 63501.650479626: 7f5219ac27bf _int_free+0x3f   jnz 0x7f5219ac2af0       IPC: 0.81 (36/44)
>     2   cc1 63501.650479626: 7f5219ac27c5 _int_free+0x45   cmp $0x1f, %rbp
>     3   cc1 63501.650479626: 7f5219ac27c9 _int_free+0x49   jbe 0x7f5219ac2b00
>     4   cc1 63501.650479626: 7f5219ac27cf _int_free+0x4f   test $0x8, %al
>     5   cc1 63501.650479626: 7f5219ac27d1 _int_free+0x51   jnz 0x7f5219ac2b00
>     6   cc1 63501.650479626: 7f5219ac27d7 _int_free+0x57   movq  0x13c58a(%rip), %rcx
>     7   cc1 63501.650479626: 7f5219ac27de _int_free+0x5e   mov %rdi, %r12
>     8   cc1 63501.650479626: 7f5219ac27e1 _int_free+0x61   movq  %fs:(%rcx), %rax
>     9   cc1 63501.650479626: 7f5219ac27e5 _int_free+0x65   test %rax, %rax
>    10   cc1 63501.650479626: 7f5219ac27e8 _int_free+0x68   jz 0x7f5219ac2821
>    11   cc1 63501.650479626: 7f5219ac27ea _int_free+0x6a   leaq  -0x11(%rbp), %rdi
>    12   cc1 63501.650479626: 7f5219ac27ee _int_free+0x6e   mov %rdi, %rsi
>    13   cc1 63501.650479626: 7f5219ac27f1 _int_free+0x71   shr $0x4, %rsi
>    14   cc1 63501.650479626: 7f5219ac27f5 _int_free+0x75   cmpq  %rsi, 0x13caf4(%rip)
>    15   cc1 63501.650479626: 7f5219ac27fc _int_free+0x7c   jbe 0x7f5219ac2821
>    16   cc1 63501.650479626: 7f5219ac2821 _int_free+0xa1   cmpq  0x13f138(%rip), %rbp
>    17   cc1 63501.650479626: 7f5219ac2828 _int_free+0xa8   jnbe 0x7f5219ac28d8
>    18   cc1 63501.650479626: 7f5219ac28d8 _int_free+0x158  testb  $0x2, 0x8(%rbx)
>    19   cc1 63501.650479628: 7f5219ac28dc _int_free+0x15c  jnz 0x7f5219ac2ab0       IPC: 6.00 (18/3)
>     <SNIP>
> 
>   - Allow using time ranges with Intel PT, i.e. these features, already
>     present but not optimially usable with Intel PT, should be now:
> 
>         Select the second 10% time slice:
> 
>         $ perf script --time 10%/2
> 
>         Select from 0% to 10% time slice:
> 
>         $ perf script --time 0%-10%
> 
>         Select the first and second 10% time slices:
> 
>         $ perf script --time 10%/1,10%/2
> 
>         Select from 0% to 10% and 30% to 40% slices:
> 
>         $ perf script --time 0%-10%,30%-40%
> 
> cs-etm (ARM):
> 
>   Mathieu Poirier:
> 
>   - Add support for CPU-wide trace scenarios.
> 
> s390:
> 
>   Thomas Richter:
> 
>   - Fix missing kvm module load for s390.
> 
>   - Fix OOM error in TUI mode on s390
> 
>   - Support s390 diag event display when doing analysis on !s390
>     architectures.
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Adrian Hunter (38):
>       perf intel-pt: Factor out intel_pt_update_sample_time
>       perf intel-pt: Accumulate cycle count from CYC packets
>       perf tools: Add IPC information to perf_sample
>       perf intel-pt: Add support for samples to contain IPC ratio
>       perf script: Add output of IPC ratio
>       perf intel-pt: Record when decoding PSB+ packets
>       perf intel-pt: Re-factor TIP cases in intel_pt_walk_to_ip
>       perf intel-pt: Accumulate cycle count from TSC/TMA/MTC packets
>       perf intel-pt: Document IPC usage
>       perf thread-stack: Accumulate IPC information
>       perf db-export: Add brief documentation
>       perf db-export: Export IPC information
>       perf scripts python: export-to-sqlite.py: Export IPC information
>       perf scripts python: export-to-postgresql.py: Export IPC information
>       perf scripts python: exported-sql-viewer.py: Add IPC information to the Branch reports
>       perf scripts python: exported-sql-viewer.py: Add CallGraphModelParams
>       perf scripts python: exported-sql-viewer.py: Add IPC information to Call Graph Graph
>       perf scripts python: exported-sql-viewer.py: Add IPC information to Call Tree
>       perf scripts python: exported-sql-viewer.py: Select find text when find bar is activated
>       perf auxtrace: Add perf time interval to itrace_synth_ops
>       perf script: Set perf time interval in itrace_synth_ops
>       perf report: Set perf time interval in itrace_synth_ops
>       perf intel-pt: Add lookahead callback
>       perf intel-pt: Factor out intel_pt_8b_tsc()
>       perf intel-pt: Factor out intel_pt_reposition()
>       perf intel-pt: Add reposition parameter to intel_pt_get_data()
>       perf intel-pt: Add intel_pt_fast_forward()
>       perf intel-pt: Factor out intel_pt_get_buffer()
>       perf intel-pt: Add support for lookahead
>       perf intel-pt: Add support for efficient time interval filtering
>       perf time-utils: Treat time ranges consistently
>       perf time-utils: Factor out set_percent_time()
>       perf time-utils: Prevent percentage time range overlap
>       perf time-utils: Fix --time documentation
>       perf time-utils: Simplify perf_time__parse_for_ranges() error paths slightly
>       perf time-utils: Make perf_time__parse_for_ranges() more logical
>       perf tests: Add a test for time-utils
>       perf time-utils: Add support for multiple explicit time intervals
> 
> Alexey Budankov (1):
>       perf record: Allow mixing --user-regs with --call-graph=dwarf
> 
> Arnaldo Carvalho de Melo (13):
>       perf data: Document memory topology header: HEADER_MEM_TOPOLOGY
>       perf data: Document clockid header: HEADER_CLOCKID
>       perf data: Document directory format header: HEADER_DIR_FORMAT
>       perf augmented_raw_syscalls: Tell which args are filenames and how many bytes to copy
>       perf augmented_raw_syscalls: Move the probe_read_str to a separate function
>       perf augmented_raw_syscalls: Change helper to consider just the augmented_filename part
>       perf augmented_raw_syscalls: Move reading filename to the loop
>       perf trace: Consume the augmented_raw_syscalls payload
>       perf trace: Associate more argument names with the filename beautifier
>       perf config: Bail out when a handler returns failure for a key-value pair
>       perf data: Fix perf.data documentation for HEADER_CPU_TOPOLOGY
>       perf cs-etm: Remove duplicate GENMASK() define, use linux/bits.h instead
>       perf trace: Skip unknown syscalls when expanding strace like syscall groups
> 
> Jiri Olsa (2):
>       perf jvmti: Address gcc string overflow warning for strncpy()
>       perf evsel: Remove superfluous nthreads system_wide setup in alloc_fd()
> 
> Kan Liang (5):
>       perf cpumap: Retrieve die id information
>       perf header: Add die information in CPU topology
>       perf stat: Support per-die aggregation
>       perf header: Rename "sibling cores" to "sibling sockets"
>       perf tools: Apply new CPU topology sysfs attributes
> 
> Leo Yan (3):
>       perf symbols: Remove unused variable 'err'
>       perf trace: Exit when failing to build eBPF program
>       perf config: Update default value for llvm.clang-bpf-cmd-template
> 
> Mathieu Poirier (18):
>       perf cs-etm: Configure contextID tracing in CPU-wide mode
>       perf cs-etm: Configure timestamp generation in CPU-wide mode
>       perf cs-etm: Configure SWITCH_EVENTS in CPU-wide mode
>       perf cs-etm: Add handling of itrace start events
>       perf cs-etm: Add handling of switch-CPU-wide events
>       perf cs-etm: Refactor error path in cs_etm_decoder__new()
>       perf cs-etm: Move packet queue out of decoder structure
>       perf cs-etm: Fix indentation in function cs_etm__process_decoder_queue()
>       perf cs-etm: Introduce the concept of trace ID queues
>       perf cs-etm: Get rid of unused cpu in struct cs_etm_queue
>       perf cs-etm: Move thread to traceid_queue
>       perf cs-etm: Move tid/pid to traceid_queue
>       perf cs-etm: Use traceID aware memory callback API
>       perf cs-etm: Add support for multiple traceID queues
>       perf cs-etm: Linking PE contextID with perf thread mechanic
>       perf cs-etm: Add notion of time to decoding code
>       perf cs-etm: Add support for CPU-wide trace scenarios
>       perf cs-etm: Properly set the value of 'old' and 'head' in snapshot mode
> 
> Song Liu (1):
>       perf data: Add description of header HEADER_BPF_PROG_INFO and HEADER_BPF_BTF
> 
> Thomas Richter (3):
>       perf test 6: Fix missing kvm module load for s390
>       perf report: Fix OOM error in TUI mode on s390
>       perf report: Support s390 diag event display on x86
> 
> yuzhoujian (1):
>       perf record: Add support to collect callchains from kernel or user space only
> 
>  tools/perf/Documentation/db-export.txt             |   41 +
>  tools/perf/Documentation/intel-pt.txt              |   30 +
>  tools/perf/Documentation/perf-config.txt           |    9 +-
>  tools/perf/Documentation/perf-diff.txt             |   14 +-
>  tools/perf/Documentation/perf-record.txt           |   11 +
>  tools/perf/Documentation/perf-report.txt           |    9 +-
>  tools/perf/Documentation/perf-script.txt           |   14 +-
>  tools/perf/Documentation/perf-stat.txt             |   10 +
>  tools/perf/Documentation/perf.data-file-format.txt |   97 +-
>  tools/perf/Makefile.config                         |    3 +
>  tools/perf/arch/arm/util/cs-etm.c                  |  313 +++++-
>  tools/perf/builtin-record.c                        |    4 +
>  tools/perf/builtin-report.c                        |    8 +-
>  tools/perf/builtin-script.c                        |   31 +-
>  tools/perf/builtin-stat.c                          |   87 +-
>  tools/perf/builtin-trace.c                         |   84 +-
>  tools/perf/examples/bpf/augmented_raw_syscalls.c   |  281 ++----
>  tools/perf/jvmti/libjvmti.c                        |    4 +-
>  tools/perf/perf.h                                  |    2 +
>  tools/perf/scripts/python/export-to-postgresql.py  |   36 +-
>  tools/perf/scripts/python/export-to-sqlite.py      |   36 +-
>  tools/perf/scripts/python/exported-sql-viewer.py   |  294 ++++--
>  tools/perf/tests/Build                             |    1 +
>  tools/perf/tests/builtin-test.c                    |    4 +
>  tools/perf/tests/parse-events.c                    |   27 +
>  tools/perf/tests/tests.h                           |    1 +
>  tools/perf/tests/time-utils-test.c                 |  251 +++++
>  tools/perf/util/annotate.c                         |    5 +-
>  tools/perf/util/auxtrace.h                         |   34 +
>  tools/perf/util/config.c                           |    8 +-
>  tools/perf/util/cpumap.c                           |   64 +-
>  tools/perf/util/cpumap.h                           |   10 +-
>  tools/perf/util/cputopo.c                          |   84 +-
>  tools/perf/util/cputopo.h                          |    2 +
>  tools/perf/util/cs-etm-decoder/cs-etm-decoder.c    |  268 +++--
>  tools/perf/util/cs-etm-decoder/cs-etm-decoder.h    |   39 +-
>  tools/perf/util/cs-etm.c                           | 1026 +++++++++++++++-----
>  tools/perf/util/cs-etm.h                           |   94 ++
>  tools/perf/util/env.c                              |    1 +
>  tools/perf/util/env.h                              |    3 +
>  tools/perf/util/event.h                            |    2 +
>  tools/perf/util/evsel.c                            |   16 +-
>  tools/perf/util/header.c                           |   96 +-
>  .../perf/util/intel-pt-decoder/intel-pt-decoder.c  |  329 ++++++-
>  .../perf/util/intel-pt-decoder/intel-pt-decoder.h  |    6 +
>  tools/perf/util/intel-pt.c                         |  354 ++++++-
>  tools/perf/util/perf_regs.h                        |    4 +
>  tools/perf/util/s390-cpumsf.c                      |   96 +-
>  .../util/scripting-engines/trace-event-python.c    |    8 +-
>  tools/perf/util/smt.c                              |    8 +-
>  tools/perf/util/stat-display.c                     |   29 +-
>  tools/perf/util/stat-shadow.c                      |    1 +
>  tools/perf/util/stat.c                             |    1 +
>  tools/perf/util/stat.h                             |    1 +
>  tools/perf/util/symbol-elf.c                       |    3 +-
>  tools/perf/util/thread-stack.c                     |   14 +
>  tools/perf/util/thread-stack.h                     |    4 +
>  tools/perf/util/time-utils.c                       |  132 ++-
>  58 files changed, 3581 insertions(+), 863 deletions(-)
>  create mode 100644 tools/perf/Documentation/db-export.txt
>  create mode 100644 tools/perf/tests/time-utils-test.c

Pulled, thanks a lot Arnaldo!

	Ingo
