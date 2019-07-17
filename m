Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C1CBC7618F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 15:29:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74B3D2173B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 15:29:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbfGQP3V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 11:29:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:57308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725993AbfGQP3V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 11:29:21 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E2852173B;
        Wed, 17 Jul 2019 15:29:19 +0000 (UTC)
Date:   Wed, 17 Jul 2019 11:29:18 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] tracing: Changes for 5.3
Message-ID: <20190717112918.06d934dd@gandalf.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

The main changes in this release include:

 - Add user space specific memory reading for kprobes
 - Allow kprobes to be executed earlier in boot

The rest are mostly just various clean ups and small fixes.


Please pull the latest trace-v5.3 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v5.3

Tag SHA1: 93f8024308e2b5e3df59cd89ab776e3236cb69e5
Head SHA1: 0aeb1def44169cbe7119f26cf10b974a2046142e


Cheng Jian (1):
      ftrace: Enable trampoline when rec count returns back to one

Cong Wang (3):
      tracing: Pass type into tracing_generic_entry_update()
      tracing: Let filter_assign_type() detect FILTER_PTR_STRING
      tracing: Make trace_get_fields() global

Gustavo A. R. Silva (1):
      tracepoint: Use struct_size() in kmalloc()

Masami Hiramatsu (20):
      x86/uaccess: Allow access_ok() in irq context if pagefault_disabled
      uaccess: Add non-pagefault user-space read functions
      tracing/probe: Add ustring type for user-space string
      tracing/probe: Support user-space dereference
      selftests/ftrace: Add user-memory access syntax testcase
      perf-probe: Add user memory access attribute support
      uaccess: Add a prototype of non-static __probe_user_read()
      tracing/kprobe: Cast user-space address correctly
      kprobes: Initialize kprobes at postcore_initcall
      tracing/kprobe: Add kprobe_event= boot parameter
      kprobes: Fix to init kprobes in subsys_initcall
      tracing/kprobe: Set print format right after parsed command
      tracing/uprobe: Set print format when parsing command
      tracing/probe: Add trace_probe init and free functions
      tracing/probe: Add trace_event_call register API for trace_probe
      tracing/probe: Add trace_event_file access APIs for trace_probe
      tracing/probe: Add trace flag access APIs for trace_probe
      tracing/probe: Add probe event name and group name accesses APIs
      tracing/probe: Add trace_event_call accesses APIs
      tracing/kprobe: Check registered state using kprobe

Matthias Kaehlcke (1):
      tracing: Use correct function name in trace_filter_add_remove_task() comment

Steven Rostedt (VMware) (7):
      ftrace: Make enable and update parameters bool when applicable
      x86/ftrace: Make enable parameter bool where applicable
      tracing: Make a separate config for trace event self tests
      tracing/kprobe: Do not run kprobe boot tests if kprobe_event is on cmdline
      ring-buffer: Remove HAVE_64BIT_ALIGNED_ACCESS
      ftrace/selftests: Return the skip code when tracing directory not configured in kernel
      ftrace/selftest: Test if set_event/ftrace_pid exists before writing

----
 Documentation/admin-guide/kernel-parameters.txt    |  13 +
 Documentation/trace/kprobetrace.rst                |  42 ++-
 Documentation/trace/uprobetracer.rst               |  10 +-
 arch/Kconfig                                       |  16 -
 arch/x86/include/asm/uaccess.h                     |   4 +-
 arch/x86/kernel/ftrace.c                           |   6 +-
 include/linux/ftrace.h                             |   4 +-
 include/linux/trace_events.h                       |   9 +
 include/linux/uaccess.h                            |  20 +-
 kernel/kprobes.c                                   |   3 +-
 kernel/trace/Kconfig                               |  12 +-
 kernel/trace/ftrace.c                              |  48 +--
 kernel/trace/ring_buffer.c                         |  17 +-
 kernel/trace/trace.c                               |  17 +-
 kernel/trace/trace_event_perf.c                    |   3 +-
 kernel/trace/trace_events.c                        |  10 +-
 kernel/trace/trace_events_filter.c                 |   3 +
 kernel/trace/trace_kprobe.c                        | 357 ++++++++++++---------
 kernel/trace/trace_probe.c                         | 142 +++++++-
 kernel/trace/trace_probe.h                         |  77 ++++-
 kernel/trace/trace_probe_tmpl.h                    |  36 ++-
 kernel/trace/trace_uprobe.c                        | 180 ++++-------
 kernel/tracepoint.c                                |   4 +-
 mm/maccess.c                                       | 122 ++++++-
 tools/perf/Documentation/perf-probe.txt            |   3 +-
 tools/perf/util/probe-event.c                      |  11 +
 tools/perf/util/probe-event.h                      |   2 +
 tools/perf/util/probe-file.c                       |   7 +
 tools/perf/util/probe-file.h                       |   1 +
 tools/perf/util/probe-finder.c                     |  19 +-
 tools/testing/selftests/ftrace/ftracetest          |  38 ++-
 tools/testing/selftests/ftrace/test.d/functions    |   4 +-
 .../ftrace/test.d/kprobe/kprobe_args_user.tc       |  32 ++
 33 files changed, 861 insertions(+), 411 deletions(-)
 create mode 100644 tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_user.tc
---------------------------
