Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9BFBC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 19:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A89852082F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 19:53:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbfKYTxe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 14:53:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:54026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725946AbfKYTxe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 14:53:34 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96B9D207FD;
        Mon, 25 Nov 2019 19:53:32 +0000 (UTC)
Date:   Mon, 25 Nov 2019 14:53:30 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] tracing: Updates for 5.5
Message-ID: <20191125145330.1fc13984@gandalf.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

A couple of known conflicts with linux-next:

 One with arch64 that both updated vmlinux.lds.h and the conflict
 resolution is here:

   git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git ftrace/aarch64-conflict

And the other is a trivial conflict with livepatching in the
selftest Makefile. I think Stephen reported some other minor ones too.

New tracing features:

 - PERAMAENT flag to ftrace_ops when attaching a callback to a function
   As /proc/sys/kernel/ftrace_enabled when set to zero will disable all
   attached callbacks in ftrace, this has a detrimental impact on live
   kernel tracing, as it disables all that it patched. If a ftrace_ops
   is registered to ftrace with the PERMANENT flag set, it will prevent
   ftrace_enabled from being disabled, and if ftrace_enabled is already
   disabled, it will prevent a ftrace_ops with PREMANENT flag set from
   being registered.

 - New register_ftrace_direct(). As eBPF would like to register its own
   trampolines to be called by the ftrace nop locations directly,
   without going through the ftrace trampoline, this function has been
   added. This allows for eBPF trampolines to live along side of
   ftrace, perf, kprobe and live patching. It also utilizes the ftrace
   enabled_functions file that keeps track of functions that have been
   modified in the kernel, to allow for security auditing.

 - Allow for kernel internal use of ftrace instances. Subsystems in
   the kernel can now create and destroy their own tracing instances
   which allows them to have their own tracing buffer, and be able
   to record events without worrying about other users from writing over
   their data.

 - New seq_buf_hex_dump() that lets users use the hex_dump() in their
   seq_buf usage.

 - Notifications now added to tracing_max_latency to allow user space
   to know when a new max latency is hit by one of the latency tracers.

 - Wider spread use of generic compare operations for use of bsearch and
   friends.

 - More synthetic event fields may be defined (32 up from 16)

 - Use of xarray for architectures with sparse system calls, for the
   system call trace events.

This along with small clean ups and fixes.

Please pull the latest trace-v5.5 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v5.5

Tag SHA1: e1b5446490496ec6b12aa207c5aaa83f94f6f44a
Head SHA1: 16c0f03f629a89e6a1249497202b2c154ff46206


Alexei Starovoitov (1):
      ftrace: Return ENOTSUPP when DYNAMIC_FTRACE_WITH_DIRECT_CALLS is not configured

Andy Shevchenko (3):
      lib/sort: Move swap, cmp and cmp_r function types for wider use
      lib/bsearch: Use generic type for comparator function
      tracing: Use generic type for comparator function

Artem Bityutskiy (1):
      tracing: Increase SYNTH_FIELDS_MAX for synthetic_events

Ben Dooks (1):
      tracing: Make internal ftrace events static

Borislav Petkov (1):
      tracing: Remove stray tab in TRACE_EVAL_MAP_FILE's help text

Colin Ian King (1):
      ftrace/selftests: Fix spelling mistake "wakeing" -> "waking"

Divya Indi (5):
      tracing: Declare newly exported APIs in include/linux/trace.h
      tracing: Verify if trace array exists before destroying it.
      tracing: Adding NULL checks for trace_array descriptor pointer
      tracing: Adding new functions for kernel access to Ftrace instances
      tracing: Sample module to demonstrate kernel access to Ftrace instances.

Enrico Weigelt, metux IT consult (1):
      ftrace: Use BIT() macro

Hassan Naveed (2):
      tracing: Use xarray for syscall trace events
      tracing: Enable syscall optimization for MIPS

Joe Lawrence (2):
      selftests/livepatch: Make dynamic debug setup and restore generic
      selftests/livepatch: Test interaction with ftrace_enabled

Josh Poimboeuf (1):
      ftrace/x86: Tell objtool to ignore nondeterministic ftrace stack layout

Krzysztof Kozlowski (1):
      tracing: Fix Kconfig indentation

Masami Hiramatsu (1):
      tracing/kprobe: Check whether the non-suffixed symbol is notrace

Miroslav Benes (1):
      ftrace: Introduce PERMANENT ftrace_ops flag

Piotr Maziarz (2):
      seq_buf: Add printing formatted hex dumps
      tracing: Use seq_buf_hex_dump() to dump buffers

Sebastian Andrzej Siewior (1):
      tracing: Use CONFIG_PREEMPTION

Srivatsa S. Bhat (VMware) (1):
      tracing/hwlat: Fix a few trivial nits

Steven Rostedt (VMware) (21):
      ftrace: Separate out the copying of a ftrace_hash from __ftrace_hash_move()
      ftrace: Separate out functionality from ftrace_location_range()
      ftrace: Add register_ftrace_direct()
      ftrace: Add ftrace_find_direct_func()
      ftrace: Add sample module that uses register_ftrace_direct()
      ftrace/selftest: Add tests to test register_ftrace_direct()
      ftrace: Add another example of register_ftrace_direct() use case
      ftrace/selftests: Update the direct call selftests to test two direct calls
      ftrace/x86: Add register_ftrace_direct() for custom trampolines
      ftrace/x86: Add a counter to test function_graph with direct
      ftrace: Add information on number of page groups allocated
      fgraph: Fix function type mismatches of ftrace_graph_return using ftrace_stub
      tracing/selftests: Turn off timeout setting
      tracing: Add missing "inline" in stub function of latency_fsnotify()
      ftrace: Add modify_ftrace_direct()
      ftrace/samples: Add a sample module that implements modify_ftrace_direct()
      ftrace: Fix accounting bug with direct->count in register_ftrace_direct()
      ftrace: Add another check for match in register_ftrace_direct()
      ftrace: Add helper find_direct_entry() to consolidate code
      ftrace: Add a helper function to modify_ftrace_direct() to allow arch optimization
      ftrace: Rename ftrace_graph_stub to ftrace_stub_graph

Viktor Rosendahl (BMW) (2):
      ftrace: Implement fs notification for tracing_max_latency
      preemptirq_delay_test: Add the burst feature and a sysfs trigger

Xianting Tian (1):
      ring-buffer: Fix typos in function ring_buffer_producer

Yuming Han (1):
      tracing: use kvcalloc for tgid_map array allocation

----
 Documentation/trace/ftrace-uses.rst                |  10 +-
 Documentation/trace/ftrace.rst                     |   4 +-
 arch/Kconfig                                       |   8 +
 arch/mips/Kconfig                                  |   1 +
 arch/sh/boot/compressed/misc.c                     |   5 +
 arch/x86/Kconfig                                   |   1 +
 arch/x86/include/asm/ftrace.h                      |  13 +
 arch/x86/include/asm/unwind_hints.h                |   8 +
 arch/x86/kernel/ftrace.c                           |  14 +
 arch/x86/kernel/ftrace_64.S                        |  42 +-
 include/asm-generic/vmlinux.lds.h                  |  17 +-
 include/linux/bsearch.h                            |   2 +-
 include/linux/ftrace.h                             | 112 +++-
 include/linux/seq_buf.h                            |   3 +
 include/linux/sort.h                               |   8 +-
 include/linux/trace.h                              |   8 +
 include/linux/trace_events.h                       |   8 +-
 include/linux/trace_seq.h                          |   4 +
 include/linux/types.h                              |   5 +
 include/trace/trace_events.h                       |   6 +
 kernel/livepatch/patch.c                           |   3 +-
 kernel/module.c                                    |   6 +-
 kernel/trace/Kconfig                               |  26 +-
 kernel/trace/fgraph.c                              |  11 +-
 kernel/trace/ftrace.c                              | 613 +++++++++++++++++++--
 kernel/trace/preemptirq_delay_test.c               | 144 ++++-
 kernel/trace/ring_buffer_benchmark.c               |   4 +-
 kernel/trace/trace.c                               | 214 +++++--
 kernel/trace/trace.h                               |  25 +-
 kernel/trace/trace_branch.c                        |   8 +-
 kernel/trace/trace_events.c                        |  29 +-
 kernel/trace/trace_events_hist.c                   |   2 +-
 kernel/trace/trace_export.c                        |   4 +-
 kernel/trace/trace_hwlat.c                         |  15 +-
 kernel/trace/trace_kprobe.c                        |  27 +-
 kernel/trace/trace_output.c                        |  15 +
 kernel/trace/trace_seq.c                           |  30 +
 kernel/trace/trace_stat.c                          |   6 +-
 kernel/trace/trace_stat.h                          |   2 +-
 kernel/trace/trace_syscalls.c                      |  32 +-
 lib/bsearch.c                                      |   2 +-
 lib/seq_buf.c                                      |  62 +++
 lib/sort.c                                         |  15 +-
 samples/Kconfig                                    |  15 +
 samples/Makefile                                   |   2 +
 samples/ftrace/Makefile                            |   8 +
 samples/ftrace/ftrace-direct-modify.c              |  88 +++
 samples/ftrace/ftrace-direct-too.c                 |  51 ++
 samples/ftrace/ftrace-direct.c                     |  45 ++
 samples/ftrace/sample-trace-array.c                | 131 +++++
 samples/ftrace/sample-trace-array.h                |  84 +++
 tools/testing/selftests/ftrace/settings            |   1 +
 .../ftrace/test.d/direct/ftrace-direct.tc          |  69 +++
 .../ftrace/test.d/direct/kprobe-direct.tc          |  84 +++
 tools/testing/selftests/livepatch/Makefile         |   3 +-
 tools/testing/selftests/livepatch/functions.sh     |  34 +-
 .../testing/selftests/livepatch/test-callbacks.sh  |   2 +-
 tools/testing/selftests/livepatch/test-ftrace.sh   |  65 +++
 .../testing/selftests/livepatch/test-livepatch.sh  |   2 +-
 .../selftests/livepatch/test-shadow-vars.sh        |   2 +-
 60 files changed, 2054 insertions(+), 206 deletions(-)
 create mode 100644 samples/ftrace/Makefile
 create mode 100644 samples/ftrace/ftrace-direct-modify.c
 create mode 100644 samples/ftrace/ftrace-direct-too.c
 create mode 100644 samples/ftrace/ftrace-direct.c
 create mode 100644 samples/ftrace/sample-trace-array.c
 create mode 100644 samples/ftrace/sample-trace-array.h
 create mode 100644 tools/testing/selftests/ftrace/settings
 create mode 100644 tools/testing/selftests/ftrace/test.d/direct/ftrace-direct.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/direct/kprobe-direct.tc
 create mode 100755 tools/testing/selftests/livepatch/test-ftrace.sh
---------------------------
