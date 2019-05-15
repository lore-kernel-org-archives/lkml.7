Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0959C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 17:36:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B20C82087E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 17:36:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727052AbfEORgQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 13:36:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:47966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725974AbfEORgQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 13:36:16 -0400
Received: from oasis.local.home (50-204-120-225-static.hfc.comcastbusiness.net [50.204.120.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 73FEB20815;
        Wed, 15 May 2019 17:36:14 +0000 (UTC)
Date:   Wed, 15 May 2019 13:36:14 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] tracing: Updates for 5.2
Message-ID: <20190515133614.31dcbbe0@oasis.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

The major changes in this tracing update includes:

 - Removing of non-DYNAMIC_FTRACE from 32bit x86

 - Removing of mcount support from x86

 - Emulating a call from int3 on x86_64, fixes live kernel patching

 - Consolidated Tracing Error logs file

Minor updates:

 - Removal of klp_check_compiler_support()

 - kdb ftrace dumping output changes

 - Accessing and creating ftrace instances from inside the kernel

 - Clean up of #define if macro

 - Introduction of TRACE_EVENT_NOP() to disable trace events based on config
   options

And other minor fixes and clean ups

 *** NOTE *** This has conflicts with your tree, with the following files:

     Conflicts:
            arch/x86/entry/entry_64.S
            include/linux/compiler.h

I did a merge against the commit d7a02fa0a8f9ec in your tree, and put
my conflict resolution at my branch in the same tree as this pull request:

  ftrace/conflicts


Please pull the latest trace-v5.2 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v5.2

Tag SHA1: 666ff819de73a218eae4b7850ce9112942b40d4e
Head SHA1: 693713cbdb3a4bda5a8a678c31f06560bbb14657

Anders Roxell (1):
      tracing: Allow RCU to run between postponed startup tests

Colin Ian King (1):
      tracing: Fix white space issues in parse_pred() function

Divya Indi (1):
      tracing: Kernel access to Ftrace instances

Douglas Anderson (3):
      tracing: kdb: The skip_lines parameter should have been skip_entries
      tracing: Add trace_total_entries() / trace_total_entries_cpu()
      tracing: kdb: Allow ftdump to skip all but the last few entries

Elazar Leibovich (1):
      tracing: Fix partial reading of trace event's id file

Gustavo A. R. Silva (1):
      tracing: Replace kzalloc with kcalloc

Jiri Kosina (1):
      livepatch: Remove klp_check_compiler_support()

Josh Poimboeuf (1):
      x86_64: Add gap to int3 to allow for call emulation

Linus Torvalds (1):
      tracing: Simplify "if" macro code

Masami Hiramatsu (5):
      tracing: Use tracing error_log with probe events
      selftests/ftrace: Add error_log testcase for probe errors
      tracing: uprobes: Re-enable $comm support for uprobe events
      tracing: probeevent: Do not accumulate on ret variable
      tracing: probeevent: Fix to make the type of $comm string

Peter Zijlstra (2):
      x86_64: Allow breakpoints to emulate call instructions
      ftrace/x86_64: Emulate call function while updating in breakpoint handler

Rasmus Villemoes (1):
      tracing: Eliminate const char[] auto variables

Srivatsa S. Bhat (VMware) (1):
      tracing: Fix documentation about disabling options using trace_options

Steven Rostedt (VMware) (10):
      tracing: Add trace_array parameter to create_event_filter()
      tracing: Have histogram code pass around trace_array for error handling
      tracing: Have the error logs show up in the proper instances
      ftrace: Remove ASSIGN_OPS_HASH() macro from ftrace.c
      ftrace: Do not process STUB functions in ftrace_ops_list_func()
      function_graph: Have selftest also emulate tr->reset() as it did with tr->init()
      function_graph: Place ftrace_graph_entry_stub() prototype in include/linux/ftrace.h
      ftrace/x86_32: Remove support for non DYNAMIC_FTRACE
      ftrace/x86: Remove mcount support
      x86: Hide the int3_emulate_call/jmp functions from UML

Tom Zanussi (9):
      tracing: Add tracing error log
      tracing: Save the last hist command's associated event name
      tracing: Use tracing error_log with hist triggers
      tracing: Use tracing error_log with trace event filters
      selftests/ftrace: Move kprobe/uprobe check_error() to test.d/functions
      selftests/ftrace: Remove trigger-extended-error-support testcase
      selftests/ftrace: Add tracing/error_log testcase
      tracing: Add tracing/error_log Documentation
      tracing: Add error_log to README

Yafang Shao (3):
      tracing: introduce TRACE_EVENT_NOP()
      sched/fair: do not expose some tracepoints to user if CONFIG_SCHEDSTATS is not set
      rcu: validate arguments for rcu tracepoints

Yangtao Li (1):
      ring-buffer: Fix mispelling of Calculate

YueHaibing (1):
      ring-buffer: Fix ring buffer size in rb_write_something()

----
Documentation/trace/ftrace.rst                     |  31 ++
 Documentation/trace/histogram.rst                  |  16 +-
 arch/nds32/kernel/ftrace.c                         |   1 -
 arch/parisc/kernel/ftrace.c                        |   1 -
 arch/powerpc/include/asm/livepatch.h               |   5 -
 arch/s390/include/asm/livepatch.h                  |   5 -
 arch/x86/Kconfig                                   |  11 +
 arch/x86/entry/entry_64.S                          |  18 +-
 arch/x86/include/asm/ftrace.h                      |   8 +-
 arch/x86/include/asm/livepatch.h                   |   8 -
 arch/x86/include/asm/text-patching.h               |  30 ++
 arch/x86/kernel/ftrace.c                           |  32 +-
 arch/x86/kernel/ftrace_32.S                        |  75 +---
 arch/x86/kernel/ftrace_64.S                        |  28 +-
 include/linux/compiler.h                           |  35 +-
 include/linux/ftrace.h                             |   2 +
 include/linux/tracepoint.h                         |  15 +
 include/trace/define_trace.h                       |   8 +
 include/trace/events/rcu.h                         |  81 ++--
 include/trace/events/sched.h                       |  21 +-
 kernel/livepatch/core.c                            |   8 -
 kernel/rcu/rcu.h                                   |   9 +-
 kernel/rcu/tree.c                                  |   8 +-
 kernel/trace/ftrace.c                              |   9 +-
 kernel/trace/ring_buffer.c                         |   2 +-
 kernel/trace/ring_buffer_benchmark.c               |   2 +-
 kernel/trace/trace.c                               | 417 ++++++++++++++++++---
 kernel/trace/trace.h                               |  13 +-
 kernel/trace/trace_events.c                        |   4 +-
 kernel/trace/trace_events_filter.c                 |  84 +++--
 kernel/trace/trace_events_hist.c                   | 268 +++++++------
 kernel/trace/trace_events_trigger.c                |   3 +-
 kernel/trace/trace_kdb.c                           |  61 +--
 kernel/trace/trace_kprobe.c                        |  77 ++--
 kernel/trace/trace_probe.c                         | 291 +++++++++-----
 kernel/trace/trace_probe.h                         |  78 +++-
 kernel/trace/trace_probe_tmpl.h                    |   2 +-
 kernel/trace/trace_selftest.c                      |   5 +-
 kernel/trace/trace_uprobe.c                        |  57 ++-
 .../ftrace/test.d/ftrace/tracing-error-log.tc      |  19 +
 tools/testing/selftests/ftrace/test.d/functions    |  12 +
 .../ftrace/test.d/kprobe/kprobe_syntax_errors.tc   |  85 +++++
 .../ftrace/test.d/kprobe/uprobe_syntax_errors.tc   |  23 ++
 .../inter-event/trigger-extended-error-support.tc  |  28 --
 44 files changed, 1345 insertions(+), 651 deletions(-)
create mode 100644 tools/testing/selftests/ftrace/test.d/ftrace/tracing-error-log.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/kprobe/uprobe_syntax_errors.tc
 delete mode 100644 tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-extended-error-support.tc
---------------------------
