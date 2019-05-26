Return-Path: <SRS0=Y9JJ=T2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B031C282E5
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 19:18:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DCFB217D8
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 19:18:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbfEZTSv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 May 2019 15:18:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:58684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726163AbfEZTSs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 May 2019 15:18:48 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 519AF2075E;
        Sun, 26 May 2019 19:18:47 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1hUyfO-0004X7-EM; Sun, 26 May 2019 15:18:46 -0400
Message-Id: <20190526191828.466305460@goodmis.org>
User-Agent: quilt/0.65
Date:   Sun, 26 May 2019 15:18:28 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 00/16] tracing: Updates for the next merge window
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
for-next

Head SHA1: a124692b698b00026a58d89831ceda2331b2e1d0


Cheng Jian (1):
      ftrace: Enable trampoline when rec count returns back to one

Masami Hiramatsu (10):
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

Matthias Kaehlcke (1):
      tracing: Use correct function name in trace_filter_add_remove_task() comment

Steven Rostedt (VMware) (4):
      ftrace: Make enable and update parameters bool when applicable
      x86/ftrace: Make enable parameter bool where applicable
      tracing: Make a separate config for trace event self tests
      tracing/kprobe: Do not run kprobe boot tests if kprobe_event is on cmdline

----
 Documentation/admin-guide/kernel-parameters.txt    |  13 +++
 Documentation/trace/kprobetrace.rst                |  42 ++++++-
 Documentation/trace/uprobetracer.rst               |  10 +-
 arch/x86/include/asm/uaccess.h                     |   4 +-
 arch/x86/kernel/ftrace.c                           |   6 +-
 include/linux/ftrace.h                             |   4 +-
 include/linux/uaccess.h                            |  20 +++-
 kernel/kprobes.c                                   |   3 +-
 kernel/trace/Kconfig                               |  12 +-
 kernel/trace/ftrace.c                              |  48 ++++----
 kernel/trace/trace.c                               |   9 +-
 kernel/trace/trace_events.c                        |   2 +-
 kernel/trace/trace_kprobe.c                        | 112 ++++++++++++++++++-
 kernel/trace/trace_probe.c                         |  37 +++++--
 kernel/trace/trace_probe.h                         |   3 +
 kernel/trace/trace_probe_tmpl.h                    |  36 +++++-
 kernel/trace/trace_uprobe.c                        |  19 ++++
 mm/maccess.c                                       | 122 ++++++++++++++++++++-
 tools/perf/Documentation/perf-probe.txt            |   3 +-
 tools/perf/util/probe-event.c                      |  11 ++
 tools/perf/util/probe-event.h                      |   2 +
 tools/perf/util/probe-file.c                       |   7 ++
 tools/perf/util/probe-file.h                       |   1 +
 tools/perf/util/probe-finder.c                     |  19 ++--
 .../ftrace/test.d/kprobe/kprobe_args_user.tc       |  32 ++++++
 25 files changed, 500 insertions(+), 77 deletions(-)
 create mode 100644 tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_user.tc
