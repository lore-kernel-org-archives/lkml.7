Return-Path: <SRS0=SHWF=W4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NUMERIC_HTTP_ADDR,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E8AC3A5A8
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 12:23:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3007823711
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 12:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567340624;
	bh=ab1LZyRNL2edOBaBykT5wNQtefE8BaYf7+gY19tU+eY=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=r73Vk+V+vA25duEZ06CvnoTgrvvIqtEjgwniophOr9NdQqdTb09kIBeYDGGfknUNZ
	 k3zsBhAZYC6rye61Xkks0c/6QFxjsWdh/I4zKl3pRsRLIIi2Gq6GynoXjpMxuyohpE
	 37W/vlwX7/dMVluBZTeuqDmhHXUd7NENuacPNhyA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728775AbfIAMXj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Sep 2019 08:23:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:40056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726000AbfIAMXj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Sep 2019 08:23:39 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 421EB21897;
        Sun,  1 Sep 2019 12:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567340614;
        bh=ab1LZyRNL2edOBaBykT5wNQtefE8BaYf7+gY19tU+eY=;
        h=From:To:Cc:Subject:Date:From;
        b=FikZ7RL5zpJEBdlzJc4DoJRFZEe1yvj5MExRHME1HgcW/f9OzNmNCcAfknzaJxSx8
         7LY3urFf0pI8YAYyHyf221YTHkHmbj4XZpcP4X/IrWHWSHlx6Mmnn0U8sfgpFZ9aKt
         QEQl0hnUe1U68ivXp0uC8wIXd+d3pwgFcf6ldstg=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        Joe Mario <jmario@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Kyle Meyer <kyle.meyer@hpe.com>,
        Patrick McLean <chutzpah@gentoo.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tzvetomir Stoyanov <tstoyanov@vmware.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [GIT PULL] perf/core improvements and fixes
Date:   Sun,  1 Sep 2019 09:22:39 -0300
Message-Id: <20190901122326.5793-1-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo/Thomas,

	Please consider pulling,

Best regards,

- Arnaldo

Test results at the end of this message, as usual.

The following changes since commit 39c2ca43465e0f52ebba3ee96fd03436367c1880:

  Merge tag 'perf-core-for-mingo-5.4-20190829' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/core (2019-08-29 20:56:32 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-5.4-20190901

for you to fetch changes up to ae31a514a134d9e4ca1d7b0f0a19b5934747d79f:

  objtool: Ignore intentional differences for the x86 insn decoder (2019-08-31 22:27:52 -0300)

----------------------------------------------------------------
perf/core improvements and fixes:

objtool:

  Josh Poimboeuf:

  - Move x86 insn decoder to a common location.

  Arnaldo Carvalho de Melo:

  - Ignore intentional differences for the x86 insn decoder.

build:

  Arnaldo Carvalho de Melo:

  - Ignore intentional differences for the x86 insn decoder.

Intel PT:

  Josh Poimboeuf:

  - Use shared x86 insn decoder.

metric groups:

  Jin Yao:

  - Scale the metric result.

  - Support multiple events.

perf c2c:

  Jiri Olsa:

  - Display proper cpu count in nodes column.

Miscellaneous:

  Kyle Meyer:

  - Replace MAX_NR_CPUS with perf_env::nr_cpus_online, i.e. with
    the number of online CPUs as detected at tool start and/or
    recorded in the perf.data file.

libtraceevent:

  Tzvetomir Stoyanov:

  - Simplify the tep_print_event_* APIs.

  - Remove tep_register_trace_clock().

  - Change users plugin directory.

Cleanups:

  Arnaldo Carvalho de Melo:

  - Continue taming the includes hell: remove needless include directives, fix
    the fallout, rinse, repeat.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Arnaldo Carvalho de Melo (29):
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

Jin Yao (3):
      perf pmu: Change convert_scale from static to global
      perf metricgroup: Scale the metric result
      perf metricgroup: Support multiple events for metricgroup

Jiri Olsa (1):
      perf c2c: Display proper cpu count in nodes column

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

Tzvetomir Stoyanov (3):
      libtraceevent, perf tools: Changes in tep_print_event_* APIs
      libtraceevent: Remove tep_register_trace_clock()
      libtraceevent: Change users plugin directory

 .../x86/include/asm}/inat.h                        |    0
 .../arch/x86/include/asm/inat_types.h              |    0
 .../x86/include/asm}/insn.h                        |    0
 .../{objtool => }/arch/x86/include/asm/orc_types.h |    0
 tools/{objtool => }/arch/x86/lib/inat.c            |    2 +-
 tools/{objtool => }/arch/x86/lib/insn.c            |    4 +-
 .../{objtool => }/arch/x86/lib/x86-opcode-map.txt  |    0
 .../arch/x86/tools/gen-insn-attr-x86.awk           |    0
 tools/lib/traceevent/Makefile                      |    6 +-
 tools/lib/traceevent/event-parse-api.c             |   40 -
 tools/lib/traceevent/event-parse-local.h           |    6 -
 tools/lib/traceevent/event-parse.c                 |  333 +++---
 tools/lib/traceevent/event-parse.h                 |   30 +-
 tools/lib/traceevent/event-plugin.c                |    2 +-
 tools/objtool/Makefile                             |    4 +-
 tools/objtool/arch/x86/Build                       |    4 +-
 tools/objtool/arch/x86/decode.c                    |    4 +-
 tools/objtool/arch/x86/include/asm/inat.h          |  230 -----
 tools/objtool/arch/x86/include/asm/insn.h          |  216 ----
 tools/objtool/sync-check.sh                        |   44 +-
 tools/perf/.gitignore                              |    3 +
 tools/perf/arch/arm/annotate/instructions.c        |    1 +
 tools/perf/arch/arm/util/auxtrace.c                |    1 +
 tools/perf/arch/arm/util/cs-etm.c                  |    4 +-
 tools/perf/arch/arm64/annotate/instructions.c      |    1 +
 tools/perf/arch/arm64/util/sym-handling.c          |    8 +-
 tools/perf/arch/common.c                           |    3 +
 tools/perf/arch/common.h                           |    4 +-
 tools/perf/arch/powerpc/util/mem-events.c          |    1 +
 tools/perf/arch/powerpc/util/perf_regs.c           |    1 -
 tools/perf/arch/powerpc/util/sym-handling.c        |    1 +
 tools/perf/arch/powerpc/util/unwind-libdw.c        |    1 +
 tools/perf/arch/x86/tests/bp-modify.c              |    1 +
 tools/perf/arch/x86/tests/insn-x86.c               |    3 +-
 tools/perf/arch/x86/tests/intel-cqm.c              |    1 -
 tools/perf/arch/x86/tests/perf-time-to-tsc.c       |    2 +
 tools/perf/arch/x86/tests/rdpmc.c                  |    4 +-
 tools/perf/arch/x86/util/archinsn.c                |    3 +-
 tools/perf/arch/x86/util/perf_regs.c               |    4 +-
 tools/perf/arch/x86/util/tsc.c                     |    2 +-
 tools/perf/bench/epoll-ctl.c                       |    1 +
 tools/perf/bench/epoll-wait.c                      |    1 +
 tools/perf/bench/mem-functions.c                   |    3 +-
 tools/perf/bench/numa.c                            |    1 -
 tools/perf/bench/sched-messaging.c                 |    1 -
 tools/perf/bench/sched-pipe.c                      |    1 -
 tools/perf/builtin-annotate.c                      |    4 +-
 tools/perf/builtin-bench.c                         |    1 -
 tools/perf/builtin-buildid-cache.c                 |    5 +-
 tools/perf/builtin-buildid-list.c                  |    4 +-
 tools/perf/builtin-c2c.c                           |    7 +-
 tools/perf/builtin-config.c                        |    3 +-
 tools/perf/builtin-data.c                          |    2 +
 tools/perf/builtin-diff.c                          |    2 +
 tools/perf/builtin-ftrace.c                        |    5 +-
 tools/perf/builtin-help.c                          |    5 +-
 tools/perf/builtin-inject.c                        |    2 +-
 tools/perf/builtin-kallsyms.c                      |    1 +
 tools/perf/builtin-kmem.c                          |    5 +-
 tools/perf/builtin-kvm.c                           |    5 +-
 tools/perf/builtin-list.c                          |    5 +-
 tools/perf/builtin-lock.c                          |    4 +-
 tools/perf/builtin-mem.c                           |    2 +
 tools/perf/builtin-probe.c                         |    5 +-
 tools/perf/builtin-record.c                        |    2 +
 tools/perf/builtin-report.c                        |    7 +
 tools/perf/builtin-sched.c                         |    3 +-
 tools/perf/builtin-script.c                        |    4 +-
 tools/perf/builtin-stat.c                          |    3 +-
 tools/perf/builtin-timechart.c                     |   10 +-
 tools/perf/builtin-top.c                           |    5 +-
 tools/perf/builtin-trace.c                         |    4 +
 tools/perf/builtin-version.c                       |    2 +-
 tools/perf/check-headers.sh                        |   11 +-
 tools/perf/lib/cpumap.c                            |    6 +
 tools/perf/perf-sys.h                              |   51 +-
 tools/perf/perf.c                                  |    7 +-
 tools/perf/perf.h                                  |   21 -
 tools/perf/scripts/perl/Perf-Trace-Util/Context.c  |    1 -
 .../perf/scripts/python/Perf-Trace-Util/Context.c  |    1 -
 tools/perf/tests/attr.c                            |    3 +-
 tools/perf/tests/backward-ring-buffer.c            |    2 +
 tools/perf/tests/bp_account.c                      |    3 +-
 tools/perf/tests/bp_signal.c                       |    3 +-
 tools/perf/tests/bp_signal_overflow.c              |    3 +-
 tools/perf/tests/bpf.c                             |    2 +
 tools/perf/tests/builtin-test.c                    |    1 +
 tools/perf/tests/code-reading.c                    |    8 +
 tools/perf/tests/dso-data.c                        |    1 +
 tools/perf/tests/dwarf-unwind.c                    |    1 +
 tools/perf/tests/event-times.c                     |    2 +
 tools/perf/tests/event_update.c                    |    3 +
 tools/perf/tests/expr.c                            |    1 +
 tools/perf/tests/hists_common.c                    |    3 +-
 tools/perf/tests/hists_cumulate.c                  |    2 +-
 tools/perf/tests/hists_filter.c                    |    2 -
 tools/perf/tests/hists_link.c                      |    2 -
 tools/perf/tests/hists_output.c                    |    2 +-
 tools/perf/tests/keep-tracking.c                   |    2 +
 tools/perf/tests/kmod-path.c                       |    2 +
 tools/perf/tests/llvm.c                            |    2 +-
 tools/perf/tests/mem.c                             |    1 +
 tools/perf/tests/mem2node.c                        |    2 +
 tools/perf/tests/mmap-basic.c                      |    3 +
 tools/perf/tests/openat-syscall-all-cpus.c         |    1 +
 tools/perf/tests/openat-syscall-tp-fields.c        |    1 +
 tools/perf/tests/openat-syscall.c                  |    1 +
 tools/perf/tests/parse-events.c                    |    1 +
 tools/perf/tests/perf-record.c                     |    1 +
 tools/perf/tests/sample-parsing.c                  |    2 +
 tools/perf/tests/sdt.c                             |    3 +-
 tools/perf/tests/sw-clock.c                        |    2 +
 tools/perf/tests/switch-tracking.c                 |    2 +
 tools/perf/tests/task-exit.c                       |    2 +
 tools/perf/tests/thread-map.c                      |    7 +
 tools/perf/tests/thread-mg-share.c                 |    1 -
 tools/perf/tests/unit_number__scnprintf.c          |    1 +
 tools/perf/tests/vmlinux-kallsyms.c                |    1 +
 tools/perf/tests/wp.c                              |    5 +
 tools/perf/ui/browser.c                            |    1 -
 tools/perf/ui/browsers/annotate.c                  |    2 +
 tools/perf/ui/browsers/header.c                    |    1 -
 tools/perf/ui/browsers/hists.c                     |    6 +
 tools/perf/ui/browsers/map.c                       |    1 +
 tools/perf/ui/browsers/res_sample.c                |    3 +
 tools/perf/ui/browsers/scripts.c                   |    4 +-
 tools/perf/ui/gtk/annotate.c                       |    1 +
 tools/perf/ui/gtk/browser.c                        |    2 -
 tools/perf/ui/gtk/helpline.c                       |    1 +
 tools/perf/ui/gtk/hists.c                          |    1 -
 tools/perf/ui/gtk/setup.c                          |    1 -
 tools/perf/ui/gtk/util.c                           |    1 +
 tools/perf/ui/helpline.h                           |    2 -
 tools/perf/ui/hist.c                               |    4 +
 tools/perf/ui/progress.c                           |    1 -
 tools/perf/ui/setup.c                              |    3 +-
 tools/perf/ui/stdio/hist.c                         |    1 +
 tools/perf/ui/tui/helpline.c                       |    2 +
 tools/perf/ui/tui/progress.c                       |    1 -
 tools/perf/ui/tui/setup.c                          |    3 +-
 tools/perf/ui/tui/util.c                           |    1 -
 tools/perf/ui/util.c                               |    2 +-
 tools/perf/util/Build                              |    1 +
 tools/perf/util/annotate.c                         |    5 +-
 tools/perf/util/arm-spe.c                          |    4 +-
 tools/perf/util/auxtrace.c                         |   33 +
 tools/perf/util/auxtrace.h                         |   52 +-
 tools/perf/util/bpf-event.c                        |    1 +
 tools/perf/util/bpf-event.h                        |    1 +
 tools/perf/util/bpf-loader.c                       |    2 +-
 tools/perf/util/bpf-prologue.c                     |    2 +-
 tools/perf/util/branch.c                           |    3 +-
 tools/perf/util/branch.h                           |    8 +
 tools/perf/util/build-id.c                         |    1 +
 tools/perf/util/cacheline.c                        |    1 -
 tools/perf/util/callchain.c                        |    3 +
 tools/perf/util/callchain.h                        |    1 +
 tools/perf/util/cgroup.c                           |    3 +-
 tools/perf/util/cloexec.c                          |    4 +-
 tools/perf/util/color.c                            |    3 +-
 tools/perf/util/color_config.c                     |    3 +-
 tools/perf/util/config.c                           |    4 +
 tools/perf/util/cpumap.c                           |    1 -
 tools/perf/util/cputopo.h                          |    1 -
 tools/perf/util/cs-etm.c                           |    6 +-
 tools/perf/util/cs-etm.h                           |    3 +-
 tools/perf/util/data.c                             |    1 +
 tools/perf/util/db-export.c                        |    1 +
 tools/perf/util/debug.c                            |    6 +-
 tools/perf/util/debug.h                            |    6 +-
 tools/perf/util/dso.c                              |  237 +----
 tools/perf/util/dso.h                              |   28 +-
 tools/perf/util/dsos.c                             |  232 +++++
 tools/perf/util/dsos.h                             |   44 +
 tools/perf/util/dwarf-aux.c                        |    1 +
 tools/perf/util/dwarf-aux.h                        |    2 +
 tools/perf/util/env.c                              |    1 +
 tools/perf/util/event.c                            |    5 +-
 tools/perf/util/event.h                            |   61 +-
 tools/perf/util/events_stats.h                     |   51 +
 tools/perf/util/evlist.c                           |    3 +
 tools/perf/util/evlist.h                           |    3 +-
 tools/perf/util/evsel.c                            |    2 +
 tools/perf/util/evsel.h                            |    1 +
 tools/perf/util/expr.y                             |    2 +
 tools/perf/util/genelf.c                           |    3 +-
 tools/perf/util/genelf_debug.c                     |    1 -
 tools/perf/util/header.c                           |   27 +-
 tools/perf/util/hist.c                             |    7 +
 tools/perf/util/hist.h                             |    6 +-
 tools/perf/util/intel-bts.c                        |    2 +-
 tools/perf/util/intel-pt-decoder/Build             |   22 +-
 .../util/intel-pt-decoder/gen-insn-attr-x86.awk    |  392 -------
 tools/perf/util/intel-pt-decoder/inat.c            |   82 --
 tools/perf/util/intel-pt-decoder/inat_types.h      |   15 -
 tools/perf/util/intel-pt-decoder/insn.c            |  593 -----------
 .../perf/util/intel-pt-decoder/intel-pt-decoder.c  |    2 +-
 .../util/intel-pt-decoder/intel-pt-insn-decoder.c  |   10 +-
 .../perf/util/intel-pt-decoder/x86-opcode-map.txt  | 1072 --------------------
 tools/perf/util/intel-pt.c                         |    2 +-
 tools/perf/util/jitdump.c                          |    1 +
 tools/perf/util/llvm-utils.c                       |    1 +
 tools/perf/util/llvm-utils.h                       |    2 +-
 tools/perf/util/lzma.c                             |    1 +
 tools/perf/util/machine.c                          |   18 +-
 tools/perf/util/machine.h                          |    3 +-
 tools/perf/util/map.c                              |    3 +
 tools/perf/util/mem-events.c                       |    2 +-
 tools/perf/util/mem-events.h                       |    9 +
 tools/perf/util/mem2node.c                         |    2 +
 tools/perf/util/mem2node.h                         |    3 +-
 tools/perf/util/metricgroup.c                      |   89 +-
 tools/perf/util/metricgroup.h                      |    1 +
 tools/perf/util/mmap.c                             |    4 +
 tools/perf/util/mmap.h                             |    1 +
 tools/perf/util/ordered-events.c                   |    1 +
 tools/perf/util/parse-branch-options.c             |    3 +-
 tools/perf/util/parse-events.c                     |    4 +-
 tools/perf/util/path.c                             |    3 +-
 tools/perf/util/path.h                             |    3 +
 tools/perf/util/perf-hooks.c                       |    1 +
 tools/perf/util/pmu.c                              |    9 +-
 tools/perf/util/pmu.h                              |    2 +
 tools/perf/util/probe-event.c                      |    6 +-
 tools/perf/util/probe-file.c                       |    4 +-
 tools/perf/util/probe-finder.c                     |    1 +
 tools/perf/util/pstack.c                           |    1 +
 tools/perf/util/python.c                           |    4 +
 tools/perf/util/record.c                           |    4 +
 tools/perf/util/s390-cpumsf.c                      |    2 +-
 tools/perf/util/s390-sample-raw.c                  |    2 -
 .../perf/util/scripting-engines/trace-event-perl.c |    2 +-
 .../util/scripting-engines/trace-event-python.c    |    3 +-
 tools/perf/util/session.c                          |   10 +-
 tools/perf/util/sort.c                             |    9 +-
 tools/perf/util/sort.h                             |    1 -
 tools/perf/util/stat-display.c                     |    1 +
 tools/perf/util/stat-shadow.c                      |   65 +-
 tools/perf/util/stat.c                             |    8 +-
 tools/perf/util/strbuf.c                           |    5 +
 tools/perf/util/svghelper.c                        |   54 +-
 tools/perf/util/svghelper.h                        |    4 +-
 tools/perf/util/symbol-elf.c                       |    7 +
 tools/perf/util/symbol-minimal.c                   |    2 +
 tools/perf/util/symbol.c                           |    5 +
 tools/perf/util/symbol.h                           |   63 +-
 tools/perf/util/symbol_fprintf.c                   |    1 +
 tools/perf/util/symsrc.h                           |   46 +
 tools/perf/util/target.c                           |    3 +
 tools/perf/util/thread-stack.c                     |    1 +
 tools/perf/util/thread.c                           |    2 +-
 tools/perf/util/time-utils.c                       |    1 -
 tools/perf/util/time-utils.h                       |    9 +
 tools/perf/util/top.c                              |    1 +
 tools/perf/util/top.h                              |    1 +
 tools/perf/util/trace-event-info.c                 |    1 -
 tools/perf/util/trace-event-parse.c                |    3 +-
 tools/perf/util/trace-event-read.c                 |    1 -
 tools/perf/util/trace-event-scripting.c            |    1 -
 tools/perf/util/trace-event.h                      |    1 -
 tools/perf/util/trigger.h                          |    1 -
 tools/perf/util/unwind-libdw.c                     |    1 +
 tools/perf/util/unwind-libunwind.c                 |    1 +
 tools/perf/util/util.c                             |    2 +-
 tools/perf/util/values.c                           |    1 +
 tools/perf/util/vdso.c                             |    1 +
 tools/perf/util/zlib.c                             |    1 +
 267 files changed, 1319 insertions(+), 3578 deletions(-)
 rename tools/{perf/util/intel-pt-decoder => arch/x86/include/asm}/inat.h (100%)
 rename tools/{objtool => }/arch/x86/include/asm/inat_types.h (100%)
 rename tools/{perf/util/intel-pt-decoder => arch/x86/include/asm}/insn.h (100%)
 rename tools/{objtool => }/arch/x86/include/asm/orc_types.h (100%)
 rename tools/{objtool => }/arch/x86/lib/inat.c (98%)
 rename tools/{objtool => }/arch/x86/lib/insn.c (99%)
 rename tools/{objtool => }/arch/x86/lib/x86-opcode-map.txt (100%)
 rename tools/{objtool => }/arch/x86/tools/gen-insn-attr-x86.awk (100%)
 delete mode 100644 tools/objtool/arch/x86/include/asm/inat.h
 delete mode 100644 tools/objtool/arch/x86/include/asm/insn.h
 create mode 100644 tools/perf/util/dsos.c
 create mode 100644 tools/perf/util/dsos.h
 create mode 100644 tools/perf/util/events_stats.h
 delete mode 100644 tools/perf/util/intel-pt-decoder/gen-insn-attr-x86.awk
 delete mode 100644 tools/perf/util/intel-pt-decoder/inat.c
 delete mode 100644 tools/perf/util/intel-pt-decoder/inat_types.h
 delete mode 100644 tools/perf/util/intel-pt-decoder/insn.c
 delete mode 100644 tools/perf/util/intel-pt-decoder/x86-opcode-map.txt
 create mode 100644 tools/perf/util/symsrc.h

Test results:

The first ones are container based builds of tools/perf with and without libelf
support.  Where clang is available, it is also used to build perf with/without
libelf, and building with LIBCLANGLLVM=1 (built-in clang) with gcc and clang
when clang and its devel libraries are installed.

The objtool and samples/bpf/ builds are disabled now that I'm switching from
using the sources in a local volume to fetching them from a http server to
build it inside the container, to make it easier to build in a container cluster.
Those will come back later.

Several are cross builds, the ones with -x-ARCH and the android one, and those
may not have all the features built, due to lack of multi-arch devel packages,
available and being used so far on just a few, like
debian:experimental-x-{arm64,mipsel}.

The 'perf test' one will perform a variety of tests exercising
tools/perf/util/, tools/lib/{bpf,traceevent,etc}, as well as run perf commands
with a variety of command line event specifications to then intercept the
sys_perf_event syscall to check that the perf_event_attr fields are set up as
expected, among a variety of other unit tests.

Then there is the 'make -C tools/perf build-test' ones, that build tools/perf/
with a variety of feature sets, exercising the build with an incomplete set of
features as well as with a complete one. It is planned to have it run on each
of the containers mentioned above, using some container orchestration
infrastructure. Get in contact if interested in helping having this in place.

Clearlinux is failing when building with libpython, but that is not a perf
regression, will try to remove one compiler warning that is causing the problem
when building some of the glue code files in the python files, outside perf.

  # export PERF_TARBALL=http://192.168.124.1/perf/perf-5.3.0-rc6.tar.xz
  # dm
   1 alpine:3.4                    : Ok   gcc (Alpine 5.3.0) 5.3.0, clang version 3.8.0 (tags/RELEASE_380/final)
   2 alpine:3.5                    : Ok   gcc (Alpine 6.2.1) 6.2.1 20160822, clang version 3.8.1 (tags/RELEASE_381/final)
   3 alpine:3.6                    : Ok   gcc (Alpine 6.3.0) 6.3.0, clang version 4.0.0 (tags/RELEASE_400/final)
   4 alpine:3.7                    : Ok   gcc (Alpine 6.4.0) 6.4.0, Alpine clang version 5.0.0 (tags/RELEASE_500/final) (based on LLVM 5.0.0)
   5 alpine:3.8                    : Ok   gcc (Alpine 6.4.0) 6.4.0, Alpine clang version 5.0.1 (tags/RELEASE_501/final) (based on LLVM 5.0.1)
   6 alpine:3.9                    : Ok   gcc (Alpine 8.3.0) 8.3.0, Alpine clang version 5.0.1 (tags/RELEASE_502/final) (based on LLVM 5.0.1)
   7 alpine:3.10                   : Ok   gcc (Alpine 8.3.0) 8.3.0, Alpine clang version 8.0.0 (tags/RELEASE_800/final) (based on LLVM 8.0.0)
   8 alpine:edge                   : Ok   gcc (Alpine 8.3.0) 8.3.0, Alpine clang version 8.0.1 (tags/RELEASE_801/final) (based on LLVM 8.0.1)
   9 amazonlinux:1                 : Ok   gcc (GCC) 7.2.1 20170915 (Red Hat 7.2.1-2), clang version 3.6.2 (tags/RELEASE_362/final)
  10 amazonlinux:2                 : Ok   gcc (GCC) 7.3.1 20180303 (Red Hat 7.3.1-5), clang version 7.0.1 (Amazon Linux 2 7.0.1-1.amzn2.0.2)
  11 android-ndk:r12b-arm          : Ok   arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
  12 android-ndk:r15c-arm          : Ok   arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
  13 centos:5                      : Ok   gcc (GCC) 4.1.2 20080704 (Red Hat 4.1.2-55)
  14 centos:6                      : Ok   gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-23)
  15 centos:7                      : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-36), clang version 3.4.2 (tags/RELEASE_34/dot2-final)
  16 clearlinux:latest             : Ok   gcc (Clear Linux OS for Intel Architecture) 9.2.1 20190816 gcc-9-branch@274554, clang version 8.0.0 (tags/RELEASE_800/final)
  17 debian:8                      : Ok   gcc (Debian 4.9.2-10+deb8u2) 4.9.2, Debian clang version 3.5.0-10 (tags/RELEASE_350/final) (based on LLVM 3.5.0)
  18 debian:9                      : Ok   gcc (Debian 6.3.0-18+deb9u1) 6.3.0 20170516, clang version 3.8.1-24 (tags/RELEASE_381/final)
  19 debian:10                     : Ok   gcc (Debian 8.3.0-6) 8.3.0, clang version 7.0.1-8 (tags/RELEASE_701/final)
  20 debian:experimental           : Ok   gcc (Debian 9.2.1-4) 9.2.1 20190821, clang version 7.0.1-9+b1 (tags/RELEASE_701/final)
  21 debian:experimental-x-arm64   : Ok   aarch64-linux-gnu-gcc (Debian 8.3.0-19) 8.3.0
  22 debian:experimental-x-mips    : Ok   mips-linux-gnu-gcc (Debian 8.3.0-19) 8.3.0
  23 debian:experimental-x-mips64  : Ok   mips64-linux-gnuabi64-gcc (Debian 8.3.0-7) 8.3.0
  24 debian:experimental-x-mipsel  : Ok   mipsel-linux-gnu-gcc (Debian 8.3.0-19) 8.3.0
  25 fedora:20                     : Ok   gcc (GCC) 4.8.3 20140911 (Red Hat 4.8.3-7), clang version 3.4.2 (tags/RELEASE_34/dot2-final)
  26 fedora:22                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6), clang version 3.5.0 (tags/RELEASE_350/final)
  27 fedora:23                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6), clang version 3.7.0 (tags/RELEASE_370/final)
  28 fedora:24                     : Ok   gcc (GCC) 6.3.1 20161221 (Red Hat 6.3.1-1), clang version 3.8.1 (tags/RELEASE_381/final)
  29 fedora:24-x-ARC-uClibc        : Ok   arc-linux-gcc (ARCompact ISA Linux uClibc toolchain 2017.09-rc2) 7.1.1 20170710
  30 fedora:25                     : Ok   gcc (GCC) 6.4.1 20170727 (Red Hat 6.4.1-1), clang version 3.9.1 (tags/RELEASE_391/final)
  31 fedora:26                     : Ok   gcc (GCC) 7.3.1 20180130 (Red Hat 7.3.1-2), clang version 4.0.1 (tags/RELEASE_401/final)
  32 fedora:27                     : Ok   gcc (GCC) 7.3.1 20180712 (Red Hat 7.3.1-6), clang version 5.0.2 (tags/RELEASE_502/final)
  33 fedora:28                     : Ok   gcc (GCC) 8.3.1 20190223 (Red Hat 8.3.1-2), clang version 6.0.1 (tags/RELEASE_601/final)
  34 fedora:29                     : Ok   gcc (GCC) 8.3.1 20190223 (Red Hat 8.3.1-2), clang version 7.0.1 (Fedora 7.0.1-6.fc29)
  35 fedora:30                     : Ok   gcc (GCC) 9.1.1 20190503 (Red Hat 9.1.1-1), clang version 8.0.0 (Fedora 8.0.0-1.fc30)
  36 fedora:30-x-ARC-glibc         : Ok   arc-linux-gcc (ARC HS GNU/Linux glibc toolchain 2019.03-rc1) 8.3.1 20190225
  37 fedora:30-x-ARC-uClibc        : Ok   arc-linux-gcc (ARCv2 ISA Linux uClibc toolchain 2019.03-rc1) 8.3.1 20190225
  38 fedora:31                     : Ok   gcc (GCC) 9.1.1 20190605 (Red Hat 9.1.1-2), clang version 8.0.0 (Fedora 8.0.0-3.fc31.1)
  39 fedora:rawhide                : Ok   gcc (GCC) 9.1.1 20190605 (Red Hat 9.1.1-2), clang version 8.0.0 (Fedora 8.0.0-3.fc31.1)
  40 gentoo-stage3-amd64:latest    : Ok   gcc (Gentoo 8.3.0-r1 p1.1) 8.3.0
  41 mageia:5                      : Ok   gcc (GCC) 4.9.2, clang version 3.5.2 (tags/RELEASE_352/final)
  42 mageia:6                      : Ok   gcc (Mageia 5.5.0-1.mga6) 5.5.0, clang version 3.9.1 (tags/RELEASE_391/final)
  43 mageia:7                      : Ok   gcc (Mageia 8.3.1-0.20190524.1.mga7) 8.3.1 20190524, clang version 8.0.0 (Mageia 8.0.0-1.mga7)
  44 manjaro:latest                : Ok   gcc (GCC) 9.1.0, clang version 8.0.1 (tags/RELEASE_801/final)
  45 opensuse:15.0                 : Ok   gcc (SUSE Linux) 7.4.1 20190424 [gcc-7-branch revision 270538], clang version 5.0.1 (tags/RELEASE_501/final 312548)
  46 opensuse:15.1                 : Ok   gcc (SUSE Linux) 7.4.1 20190424 [gcc-7-branch revision 270538], clang version 7.0.1 (tags/RELEASE_701/final 349238)
  47 opensuse:42.3                 : Ok   gcc (SUSE Linux) 4.8.5, clang version 3.8.0 (tags/RELEASE_380/final 262553)
  48 opensuse:tumbleweed           : Ok   gcc (SUSE Linux) 9.2.1 20190820 [gcc-9-branch revision 274748], clang version 8.0.1 (tags/RELEASE_801/final 366581)
  49 oraclelinux:6                 : Ok   gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-23.0.1)
  50 oraclelinux:7                 : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-39.0.1), clang version 3.4.2 (tags/RELEASE_34/dot2-final)
  51 oraclelinux:8                 : Ok   gcc (GCC) 8.2.1 20180905 (Red Hat 8.2.1-3.0.1), clang version 7.0.1 (tags/RELEASE_701/final)
  52 ubuntu:12.04                  : Ok   gcc (Ubuntu/Linaro 4.6.3-1ubuntu5) 4.6.3, Ubuntu clang version 3.0-6ubuntu3 (tags/RELEASE_30/final) (based on LLVM 3.0)
  53 ubuntu:14.04                  : Ok   gcc (Ubuntu 4.8.4-2ubuntu1~14.04.4) 4.8.4, Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)
  54 ubuntu:16.04                  : Ok   gcc (Ubuntu 5.4.0-6ubuntu1~16.04.11) 5.4.0 20160609, clang version 3.8.0-2ubuntu4 (tags/RELEASE_380/final)
  55 ubuntu:16.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  56 ubuntu:16.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  57 ubuntu:16.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  58 ubuntu:16.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  59 ubuntu:16.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  60 ubuntu:16.04-x-s390           : Ok   s390x-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  61 ubuntu:18.04                  : Ok   gcc (Ubuntu 7.4.0-1ubuntu1~18.04.1) 7.4.0, clang version 6.0.0-1ubuntu2 (tags/RELEASE_600/final)
  62 ubuntu:18.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 7.4.0-1ubuntu1~18.04.1) 7.4.0
  63 ubuntu:18.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 7.4.0-1ubuntu1~18.04.1) 7.4.0
  64 ubuntu:18.04-x-m68k           : Ok   m68k-linux-gnu-gcc (Ubuntu 7.4.0-1ubuntu1~18.04.1) 7.4.0
  65 ubuntu:18.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc (Ubuntu 7.4.0-1ubuntu1~18.04.1) 7.4.0
  66 ubuntu:18.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu 7.4.0-1ubuntu1~18.04.1) 7.4.0
  67 ubuntu:18.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu 7.4.0-1ubuntu1~18.04.1) 7.4.0
  68 ubuntu:18.04-x-riscv64        : Ok   riscv64-linux-gnu-gcc (Ubuntu 7.4.0-1ubuntu1~18.04.1) 7.4.0
  69 ubuntu:18.04-x-s390           : Ok   s390x-linux-gnu-gcc (Ubuntu 7.4.0-1ubuntu1~18.04.1) 7.4.0
  70 ubuntu:18.04-x-sh4            : Ok   sh4-linux-gnu-gcc (Ubuntu 7.4.0-1ubuntu1~18.04.1) 7.4.0
  71 ubuntu:18.04-x-sparc64        : Ok   sparc64-linux-gnu-gcc (Ubuntu 7.4.0-1ubuntu1~18.04.1) 7.4.0
  72 ubuntu:18.10                  : Ok   gcc (Ubuntu 8.3.0-6ubuntu1~18.10.1) 8.3.0, clang version 7.0.0-3 (tags/RELEASE_700/final)
  73 ubuntu:19.04                  : Ok   gcc (Ubuntu 8.3.0-6ubuntu1) 8.3.0, clang version 8.0.0-3 (tags/RELEASE_800/final)
  74 ubuntu:19.04-x-alpha          : Ok   alpha-linux-gnu-gcc (Ubuntu 8.3.0-6ubuntu1) 8.3.0
  75 ubuntu:19.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 8.3.0-6ubuntu1) 8.3.0
  76 ubuntu:19.04-x-hppa           : Ok   hppa-linux-gnu-gcc (Ubuntu 8.3.0-6ubuntu1) 8.3.0
  77 ubuntu:19.10                  : Ok   gcc (Ubuntu 9.2.1-4ubuntu1) 9.2.1 20190821, clang version 9.0.0-+rc2-1~exp1 (tags/RELEASE_900/rc2)
  #

  # uname -a
  Linux quaco 5.2.6-200.fc30.x86_64 #1 SMP Mon Aug 5 13:20:47 UTC 2019 x86_64 x86_64 x86_64 GNU/Linux
  # git log --oneline -1
  ae31a514a134 objtool: Ignore intentional differences for the x86 insn decoder
  # perf version --build-options
  perf version 5.3.rc6.gae31a514a134
                   dwarf: [ on  ]  # HAVE_DWARF_SUPPORT
      dwarf_getlocations: [ on  ]  # HAVE_DWARF_GETLOCATIONS_SUPPORT
                   glibc: [ on  ]  # HAVE_GLIBC_SUPPORT
                    gtk2: [ on  ]  # HAVE_GTK2_SUPPORT
           syscall_table: [ on  ]  # HAVE_SYSCALL_TABLE_SUPPORT
                  libbfd: [ on  ]  # HAVE_LIBBFD_SUPPORT
                  libelf: [ on  ]  # HAVE_LIBELF_SUPPORT
                 libnuma: [ on  ]  # HAVE_LIBNUMA_SUPPORT
  numa_num_possible_cpus: [ on  ]  # HAVE_LIBNUMA_SUPPORT
                 libperl: [ on  ]  # HAVE_LIBPERL_SUPPORT
               libpython: [ on  ]  # HAVE_LIBPYTHON_SUPPORT
                libslang: [ on  ]  # HAVE_SLANG_SUPPORT
               libcrypto: [ on  ]  # HAVE_LIBCRYPTO_SUPPORT
               libunwind: [ on  ]  # HAVE_LIBUNWIND_SUPPORT
      libdw-dwarf-unwind: [ on  ]  # HAVE_DWARF_SUPPORT
                    zlib: [ on  ]  # HAVE_ZLIB_SUPPORT
                    lzma: [ on  ]  # HAVE_LZMA_SUPPORT
               get_cpuid: [ on  ]  # HAVE_AUXTRACE_SUPPORT
                     bpf: [ on  ]  # HAVE_LIBBPF_SUPPORT
                     aio: [ on  ]  # HAVE_AIO_SUPPORT
                    zstd: [ on  ]  # HAVE_ZSTD_SUPPORT
  # perf test
   1: vmlinux symtab matches kallsyms                       : Ok
   2: Detect openat syscall event                           : Ok
   3: Detect openat syscall event on all cpus               : Ok
   4: Read samples using the mmap interface                 : Ok
   5: Test data source output                               : Ok
   6: Parse event definition strings                        : Ok
   7: Simple expression parser                              : Ok
   8: PERF_RECORD_* events & perf_sample fields             : Ok
   9: Parse perf pmu format                                 : Ok
  10: DSO data read                                         : Ok
  11: DSO data cache                                        : Ok
  12: DSO data reopen                                       : Ok
  13: Roundtrip evsel->name                                 : Ok
  14: Parse sched tracepoints fields                        : Ok
  15: syscalls:sys_enter_openat event fields                : Ok
  16: Setup struct perf_event_attr                          : Ok
  17: Match and link multiple hists                         : Ok
  18: 'import perf' in python                               : Ok
  19: Breakpoint overflow signal handler                    : Ok
  20: Breakpoint overflow sampling                          : Ok
  21: Breakpoint accounting                                 : Ok
  22: Watchpoint                                            :
  22.1: Read Only Watchpoint                                : Skip
  22.2: Write Only Watchpoint                               : Ok
  22.3: Read / Write Watchpoint                             : Ok
  22.4: Modify Watchpoint                                   : Ok
  23: Number of exit events of a simple workload            : Ok
  24: Software clock events period values                   : Ok
  25: Object code reading                                   : Ok
  26: Sample parsing                                        : Ok
  27: Use a dummy software event to keep tracking           : Ok
  28: Parse with no sample_id_all bit set                   : Ok
  29: Filter hist entries                                   : Ok
  30: Lookup mmap thread                                    : Ok
  31: Share thread mg                                       : Ok
  32: Sort output of hist entries                           : Ok
  33: Cumulate child hist entries                           : Ok
  34: Track with sched_switch                               : Ok
  35: Filter fds with revents mask in a fdarray             : Ok
  36: Add fd to a fdarray, making it autogrow               : Ok
  37: kmod_path__parse                                      : Ok
  38: Thread map                                            : Ok
  39: LLVM search and compile                               :
  39.1: Basic BPF llvm compile                              : Ok
  39.2: kbuild searching                                    : Ok
  39.3: Compile source for BPF prologue generation          : Ok
  39.4: Compile source for BPF relocation                   : Ok
  40: Session topology                                      : Ok
  41: BPF filter                                            :
  41.1: Basic BPF filtering                                 : Ok
  41.2: BPF pinning                                         : Ok
  41.3: BPF prologue generation                             : Ok
  41.4: BPF relocation checker                              : Ok
  42: Synthesize thread map                                 : Ok
  43: Remove thread map                                     : Ok
  44: Synthesize cpu map                                    : Ok
  45: Synthesize stat config                                : Ok
  46: Synthesize stat                                       : Ok
  47: Synthesize stat round                                 : Ok
  48: Synthesize attr update                                : Ok
  49: Event times                                           : Ok
  50: Read backward ring buffer                             : Ok
  51: Print cpu map                                         : Ok
  52: Probe SDT events                                      : Ok
  53: is_printable_array                                    : Ok
  54: Print bitmap                                          : Ok
  55: perf hooks                                            : Ok
  56: builtin clang support                                 : Skip (not compiled in)
  57: unit_number__scnprintf                                : Ok
  58: mem2node                                              : Ok
  59: time utils                                            : Ok
  60: map_groups__merge_in                                  : Ok
  61: x86 rdpmc                                             : Ok
  62: Convert perf time to TSC                              : Ok
  63: DWARF unwind                                          : Ok
  64: x86 instruction decoder - new instructions            : Ok
  65: Intel PT packet decoder                               : Ok
  66: x86 bp modify                                         : Ok
  67: probe libc's inet_pton & backtrace it with ping       : Ok
  68: Use vfs_getname probe to get syscall args filenames   : Ok
  69: Add vfs_getname probe to get syscall args filenames   : Ok
  70: Check open filename arg using perf trace + vfs_getname: Ok
  71: Zstd perf.data compression/decompression              : Ok
  #

  $ make -C tools/perf build-test
  make: Entering directory '/home/acme/git/perf/tools/perf'
  - tarpkg: ./tests/perf-targz-src-pkg .
  - /home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP: make FEATURE_DUMP_COPY=/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP  feature-dump
  make FEATURE_DUMP_COPY=/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP feature-dump
           make_no_libunwind_O: make NO_LIBUNWIND=1
             make_no_scripts_O: make NO_LIBPYTHON=1 NO_LIBPERL=1
             make_util_map_o_O: make util/map.o
  make_no_libdw_dwarf_unwind_O: make NO_LIBDW_DWARF_UNWIND=1
   make_install_prefix_slash_O: make install prefix=/tmp/krava/
               make_no_slang_O: make NO_SLANG=1
                make_install_O: make install
                make_minimal_O: make NO_LIBPERL=1 NO_LIBPYTHON=1 NO_NEWT=1 NO_GTK2=1 NO_DEMANGLE=1 NO_LIBELF=1 NO_LIBUNWIND=1 NO_BACKTRACE=1 NO_LIBNUMA=1 NO_LIBAUDIT=1 NO_LIBBIONIC=1 NO_LIBDW_DWARF_UNWIND=1 NO_AUXTRACE=1 NO_LIBBPF=1 NO_LIBCRYPTO=1 NO_SDT=1 NO_JVMTI=1 NO_LIBZSTD=1 NO_LIBCAP=1
            make_no_libaudit_O: make NO_LIBAUDIT=1
       make_util_pmu_bison_o_O: make util/pmu-bison.o
              make_clean_all_O: make clean all
                make_no_gtk2_O: make NO_GTK2=1
                   make_pure_O: make
              make_no_libelf_O: make NO_LIBELF=1
                  make_debug_O: make DEBUG=1
                make_no_newt_O: make NO_NEWT=1
           make_no_backtrace_O: make NO_BACKTRACE=1
             make_no_libperl_O: make NO_LIBPERL=1
                   make_help_O: make help
             make_no_libnuma_O: make NO_LIBNUMA=1
            make_no_demangle_O: make NO_DEMANGLE=1
                   make_tags_O: make tags
                  make_no_ui_O: make NO_NEWT=1 NO_SLANG=1 NO_GTK2=1
           make_no_libbionic_O: make NO_LIBBIONIC=1
           make_no_libpython_O: make NO_LIBPYTHON=1
  - /home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP_STATIC: make FEATURE_DUMP_COPY=/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP_STATIC  LDFLAGS='-static' feature-dump
  make FEATURE_DUMP_COPY=/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP_STATIC LDFLAGS='-static' feature-dump
                 make_static_O: make LDFLAGS=-static
         make_with_clangllvm_O: make LIBCLANGLLVM=1
            make_install_bin_O: make install-bin
                 make_cscope_O: make cscope
                 make_perf_o_O: make perf.o
                    make_doc_O: make doc
              make_no_libbpf_O: make NO_LIBBPF=1
            make_no_auxtrace_O: make NO_AUXTRACE=1
         make_install_prefix_O: make install prefix=/tmp/krava
        make_with_babeltrace_O: make LIBBABELTRACE=1
  OK
  make: Leaving directory '/home/acme/git/perf/tools/perf'
  $
