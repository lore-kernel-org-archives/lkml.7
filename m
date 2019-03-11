Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08593C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 03:40:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C34E620657
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 03:40:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbfCKDk3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 23:40:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:60568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727099AbfCKDk2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 23:40:28 -0400
Received: from oasis.local.home (unknown [12.208.205.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 431DF20657;
        Mon, 11 Mar 2019 03:40:27 +0000 (UTC)
Date:   Sun, 10 Mar 2019 23:40:19 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] tracing: Updates for v5.1
Message-ID: <20190310234019.64da3b0b@oasis.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

The biggest change for this release is in the histogram code.

 - Add "onchange(var)" histogram handler that executes a action when $var
   changes.

 - Add new "snapshot()" action for histogram handlers, that causes a
   snapshot of the ring buffer when triggered.
   ie. onchange(var).snapshot() will trigger a snapshot if var changes.

 - Add alternative for "trace()" action.
   Currently, to trigger a synthetic event, the name of that event is used
   as the handler name, which is inconsistent with the other actions.
   onchange(var).synthetic(param) where it can now be
   onchange(var).trace(synthetic, param). The older method will still be
   allowed, as long as the synthetic events do not overlap with other
   handler names.

 - The histogram documentation at testcases were updated for the new
   changes.

Added a quicker way to enable set_ftrace_filter files, that will make
it much quicker to bisect tracing a function that shouldn't be traced and
crashes the kernel. (You can echo in numbers to set_ftrace_filter, and it
will select the corresponding function that is in
available_filter_functions).

Some better displaying of the tracing data (and more information was added).

The rest are small fixes and more clean ups to the code.


Please pull the latest trace-v5.1 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v5.1

Tag SHA1: 7560451df55a0e5dfacc2e6cf9e3602fbf9e22a9
Head SHA1: 85f726a35e504418607b77c5e7da165dc1ea63ce


Changbin Du (6):
      function_graph: Support displaying relative timestamp
      tracing: Show more info for funcgraph wakeup tracers
      tracing: Put a margin between flags and duration for wakeup tracers
      tracing/doc: Add latency tracer funcgraph example
      tracing: Show stacktrace for wakeup tracers
      tracing: Change the function format to display function names by perf

Colin Ian King (1):
      tracing: Fix spelling mistake: "analagous" -> "analogous"

Elena Reshetova (1):
      uprobes: convert uprobe.ref to refcount_t

Jann Horn (1):
      tracing/perf: Use strndup_user() instead of buggy open-coded version

Mathieu Malaterre (2):
      tracing: Annotate implicit fall through in parse_probe_arg()
      tracing: Annotate implicit fall through in predicate_parse()

Miroslav Benes (1):
      ring-buffer: Remove unused function ring_buffer_page_len()

Srikar Dronamraju (1):
      doc: trace: Fix documentation for uprobe_profile

Steven Rostedt (VMware) (4):
      tracing: Add comment to predicate_parse() about "&&" or "||"
      ftrace: Allow enabling of filters via index of available_filter_functions
      tracing: Comment why cond_snapshot is checked outside of max_lock protection
      x86/ftrace: Fix warning and considate ftrace_jmp_replace() and ftrace_call_replace()

Tom Zanussi (19):
      tracing: Refactor hist trigger action code
      tracing: Make hist trigger Documentation better reflect actions/handlers
      tracing: Split up onmatch action data
      tracing: Generalize hist trigger onmax and save action
      tracing: Add conditional snapshot
      tracing: Add hist trigger snapshot() action
      tracing: Add hist trigger snapshot() action Documentation
      tracing: Add hist trigger onchange() handler
      tracing: Add hist trigger onchange() handler Documentation
      tracing: Add alternative synthetic event trace action syntax
      tracing: Add SPDX license GPL-2.0 license identifier to inter-event testcases
      tracing: Add hist trigger snapshot() action test case
      tracing: Add hist trigger onchange() handler test case
      tracing: Add alternative synthetic event trace action test case
      tracing: Add hist trigger action 'expected fail' test case
      tracing: Use str_has_prefix() in synth_event_create()
      tracing: Use strncpy instead of memcpy for string keys in hist triggers
      tracing: Use strncpy instead of memcpy when copying comm for hist triggers
      tracing: Use strncpy instead of memcpy when copying comm in trace.c

zhangyi (F) (1):
      tracing: Do not free iter->trace in fail path of tracing_open_pipe()

----
 Documentation/trace/ftrace.rst                     |   89 ++
 Documentation/trace/histogram.rst                  |  316 +++++-
 Documentation/trace/uprobetracer.rst               |    7 +-
 arch/x86/kernel/ftrace.c                           |   42 +-
 include/linux/ring_buffer.h                        |    2 -
 kernel/events/uprobes.c                            |    8 +-
 kernel/trace/ftrace.c                              |   30 +
 kernel/trace/ring_buffer.c                         |   14 -
 kernel/trace/trace.c                               |  223 ++++-
 kernel/trace/trace.h                               |   66 +-
 kernel/trace/trace_entries.h                       |   41 +-
 kernel/trace/trace_event_perf.c                    |   16 +-
 kernel/trace/trace_events_filter.c                 |    7 +
 kernel/trace/trace_events_hist.c                   | 1059 ++++++++++++++------
 kernel/trace/trace_functions_graph.c               |   30 +-
 kernel/trace/trace_irqsoff.c                       |    2 +-
 kernel/trace/trace_probe.c                         |    1 +
 kernel/trace/trace_sched_wakeup.c                  |   11 +-
 .../inter-event/trigger-action-hist-xfail.tc       |   30 +
 .../inter-event/trigger-extended-error-support.tc  |    1 +
 .../inter-event/trigger-field-variable-support.tc  |    1 +
 .../trigger-inter-event-combined-hist.tc           |    1 +
 .../inter-event/trigger-multi-actions-accept.tc    |    1 +
 .../inter-event/trigger-onchange-action-hist.tc    |   28 +
 .../inter-event/trigger-onmatch-action-hist.tc     |    1 +
 .../trigger-onmatch-onmax-action-hist.tc           |    1 +
 .../inter-event/trigger-onmax-action-hist.tc       |    1 +
 .../inter-event/trigger-snapshot-action-hist.tc    |   43 +
 .../trigger-synthetic-event-createremove.tc        |    1 +
 .../inter-event/trigger-trace-action-hist.tc       |   42 +
 30 files changed, 1695 insertions(+), 420 deletions(-)
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-action-hist-xfail.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onchange-action-hist.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-snapshot-action-hist.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-trace-action-hist.tc
---------------------------
