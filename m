Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4C2CC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 01:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCF50206B6
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 01:39:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728442AbfDDBjN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 21:39:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:35924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726167AbfDDBho (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 21:37:44 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0FD562133D;
        Thu,  4 Apr 2019 01:37:44 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1hBrK3-0004wM-5D; Wed, 03 Apr 2019 21:37:43 -0400
Message-Id: <20190404013721.023858792@goodmis.org>
User-Agent: quilt/0.65
Date:   Wed, 03 Apr 2019 21:37:21 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 00/19] tracing: Updates for 5.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
for-next

Head SHA1: c8faaa4c594f55ddf903d61180029a3ea1da5286


Divya Indi (1):
      tracing: Kernel access to Ftrace instances

Masami Hiramatsu (2):
      tracing: Use tracing error_log with probe events
      selftests/ftrace: Add error_log testcase for probe errors

Steven Rostedt (VMware) (3):
      tracing: Add trace_array parameter to create_event_filter()
      tracing: Have histogram code pass around trace_array for error handling
      tracing: Have the error logs show up in the proper instances

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

YueHaibing (1):
      ring-buffer: Fix ring buffer size in rb_write_something()

----
 Documentation/trace/ftrace.rst                     |  31 ++
 Documentation/trace/histogram.rst                  |  16 +-
 include/linux/tracepoint.h                         |  15 +
 include/trace/define_trace.h                       |   8 +
 include/trace/events/rcu.h                         |  81 ++----
 include/trace/events/sched.h                       |  21 +-
 kernel/rcu/rcu.h                                   |   9 +-
 kernel/rcu/tree.c                                  |   8 +-
 kernel/trace/ring_buffer.c                         |   2 +-
 kernel/trace/trace.c                               | 312 +++++++++++++++++++--
 kernel/trace/trace.h                               |  10 +-
 kernel/trace/trace_events.c                        |   1 +
 kernel/trace/trace_events_filter.c                 |  36 ++-
 kernel/trace/trace_events_hist.c                   | 268 ++++++++++--------
 kernel/trace/trace_events_trigger.c                |   3 +-
 kernel/trace/trace_kprobe.c                        |  77 +++--
 kernel/trace/trace_probe.c                         | 274 ++++++++++++------
 kernel/trace/trace_probe.h                         |  77 ++++-
 kernel/trace/trace_uprobe.c                        |  44 ++-
 .../ftrace/test.d/ftrace/tracing-error-log.tc      |  19 ++
 tools/testing/selftests/ftrace/test.d/functions    |  12 +
 .../ftrace/test.d/kprobe/kprobe_syntax_errors.tc   |  85 ++++++
 .../ftrace/test.d/kprobe/uprobe_syntax_errors.tc   |  23 ++
 .../inter-event/trigger-extended-error-support.tc  |  28 --
 24 files changed, 1067 insertions(+), 393 deletions(-)
 create mode 100644 tools/testing/selftests/ftrace/test.d/ftrace/tracing-error-log.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/kprobe/uprobe_syntax_errors.tc
 delete mode 100644 tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-extended-error-support.tc
