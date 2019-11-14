Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97E35C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 18:20:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75EF220727
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 18:20:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727912AbfKNSUf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 13:20:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:35600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727442AbfKNSS0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 13:18:26 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9972A2072E;
        Thu, 14 Nov 2019 18:18:24 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1iVJhH-0000xn-GG; Thu, 14 Nov 2019 13:18:23 -0500
Message-Id: <20191114181734.067922168@goodmis.org>
User-Agent: quilt/0.65
Date:   Thu, 14 Nov 2019 13:17:34 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 00/33] tracing: Updates for 5.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
for-next

Head SHA1: 9b4712044d059e7842aaeeafd7c7a7ee88c589db


Andy Shevchenko (3):
      lib/sort: Move swap, cmp and cmp_r function types for wider use
      lib/bsearch: Use generic type for comparator function
      tracing: Use generic type for comparator function

Ben Dooks (1):
      tracing: Make internal ftrace events static

Borislav Petkov (1):
      tracing: Remove stray tab in TRACE_EVAL_MAP_FILE's help text

Divya Indi (3):
      tracing: Declare newly exported APIs in include/linux/trace.h
      tracing: Verify if trace array exists before destroying it.
      tracing: Adding NULL checks for trace_array descriptor pointer

Joe Lawrence (2):
      selftests/livepatch: Make dynamic debug setup and restore generic
      selftests/livepatch: Test interaction with ftrace_enabled

Josh Poimboeuf (1):
      ftrace/x86: Tell objtool to ignore nondeterministic ftrace stack layout

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

Steven Rostedt (VMware) (13):
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

Viktor Rosendahl (BMW) (2):
      ftrace: Implement fs notification for tracing_max_latency
      preemptirq_delay_test: Add the burst feature and a sysfs trigger

Yuming Han (1):
      tracing: use kvcalloc for tgid_map array allocation

----
 Documentation/trace/ftrace-uses.rst                |  10 +-
 Documentation/trace/ftrace.rst                     |   4 +-
 arch/sh/boot/compressed/misc.c                     |   5 +
 arch/x86/Kconfig                                   |   1 +
 arch/x86/include/asm/ftrace.h                      |  13 +
 arch/x86/include/asm/unwind_hints.h                |   8 +
 arch/x86/kernel/ftrace.c                           |  14 +
 arch/x86/kernel/ftrace_64.S                        |  42 +-
 include/asm-generic/vmlinux.lds.h                  |  17 +-
 include/linux/bsearch.h                            |   2 +-
 include/linux/ftrace.h                             |  53 ++-
 include/linux/seq_buf.h                            |   3 +
 include/linux/sort.h                               |   8 +-
 include/linux/trace.h                              |   7 +
 include/linux/trace_events.h                       |   5 +
 include/linux/trace_seq.h                          |   4 +
 include/linux/types.h                              |   5 +
 include/trace/trace_events.h                       |   6 +
 kernel/livepatch/patch.c                           |   3 +-
 kernel/module.c                                    |   6 +-
 kernel/trace/Kconfig                               |  18 +-
 kernel/trace/fgraph.c                              |  11 +-
 kernel/trace/ftrace.c                              | 466 +++++++++++++++++++--
 kernel/trace/preemptirq_delay_test.c               | 144 ++++++-
 kernel/trace/trace.c                               | 118 +++++-
 kernel/trace/trace.h                               |  24 +-
 kernel/trace/trace_branch.c                        |   8 +-
 kernel/trace/trace_events.c                        |   2 +
 kernel/trace/trace_export.c                        |   4 +-
 kernel/trace/trace_hwlat.c                         |  15 +-
 kernel/trace/trace_kprobe.c                        |  27 +-
 kernel/trace/trace_output.c                        |  15 +
 kernel/trace/trace_seq.c                           |  30 ++
 kernel/trace/trace_stat.c                          |   6 +-
 kernel/trace/trace_stat.h                          |   2 +-
 lib/bsearch.c                                      |   2 +-
 lib/seq_buf.c                                      |  62 +++
 lib/sort.c                                         |  15 +-
 samples/Kconfig                                    |   8 +
 samples/Makefile                                   |   1 +
 samples/ftrace/Makefile                            |   4 +
 samples/ftrace/ftrace-direct-too.c                 |  51 +++
 samples/ftrace/ftrace-direct.c                     |  45 ++
 tools/testing/selftests/ftrace/settings            |   1 +
 .../ftrace/test.d/direct/ftrace-direct.tc          |  69 +++
 .../ftrace/test.d/direct/kprobe-direct.tc          |  84 ++++
 tools/testing/selftests/livepatch/Makefile         |   3 +-
 tools/testing/selftests/livepatch/functions.sh     |  34 +-
 .../testing/selftests/livepatch/test-callbacks.sh  |   2 +-
 tools/testing/selftests/livepatch/test-ftrace.sh   |  65 +++
 .../testing/selftests/livepatch/test-livepatch.sh  |   2 +-
 .../selftests/livepatch/test-shadow-vars.sh        |   2 +-
 52 files changed, 1410 insertions(+), 146 deletions(-)
 create mode 100644 samples/ftrace/Makefile
 create mode 100644 samples/ftrace/ftrace-direct-too.c
 create mode 100644 samples/ftrace/ftrace-direct.c
 create mode 100644 tools/testing/selftests/ftrace/settings
 create mode 100644 tools/testing/selftests/ftrace/test.d/direct/ftrace-direct.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/direct/kprobe-direct.tc
 create mode 100755 tools/testing/selftests/livepatch/test-ftrace.sh

