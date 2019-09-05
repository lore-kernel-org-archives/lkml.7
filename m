Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9963C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 15:45:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A80E206BB
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 15:45:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390778AbfIEPpM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 11:45:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:35426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388553AbfIEPnl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 11:43:41 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A3BE2082E;
        Thu,  5 Sep 2019 15:43:41 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1i5tv9-0007S8-C8; Thu, 05 Sep 2019 11:43:39 -0400
Message-Id: <20190905154258.573706229@goodmis.org>
User-Agent: quilt/0.65
Date:   Thu, 05 Sep 2019 11:42:58 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 00/25] tracing: Updates for 5.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
for-next

Head SHA1: ac68154626ab7fe4ce5f424937c34f42a3e20c5b


Masami Hiramatsu (13):
      kprobes: Allow kprobes coexist with livepatch
      tracing/probe: Split trace_event related data from trace_probe
      tracing/dynevent: Delete all matched events
      tracing/dynevent: Pass extra arguments to match operation
      tracing/kprobe: Add multi-probe per event support
      tracing/uprobe: Add multi-probe per uprobe event support
      tracing/kprobe: Add per-probe delete from event
      tracing/uprobe: Add per-probe delete from event
      tracing/probe: Add immediate parameter support
      tracing/probe: Add immediate string parameter support
      selftests/ftrace: Add a testcase for kprobe multiprobe event
      selftests/ftrace: Add syntax error test for immediates
      selftests/ftrace: Add syntax error test for multiprobe

Matt Helsley (8):
      recordmcount: Remove redundant strcmp
      recordmcount: Remove uread()
      recordmcount: Remove unused fd from uwrite() and ulseek()
      recordmcount: Rewrite error/success handling
      recordmcount: Kernel style function signature formatting
      recordmcount: Kernel style formatting
      recordmcount: Remove redundant cleanup() calls
      recordmcount: Clarify what cleanup() does

Steven Rostedt (VMware) (3):
      tracing/arm64: Have max stack tracer handle the case of return address after data
      tracing: Document the stack trace algorithm in the comments
      tracing: Rename tracing_reset() to tracing_reset_cpu()

Zhengjun Xing (1):
      tracing: Add "gfp_t" support in synthetic_events

----
 Documentation/trace/kprobetrace.rst                |   1 +
 Documentation/trace/uprobetracer.rst               |   1 +
 arch/arm64/include/asm/ftrace.h                    |  13 +
 kernel/kprobes.c                                   |  56 +++-
 kernel/trace/trace.c                               |  14 +-
 kernel/trace/trace.h                               |   1 -
 kernel/trace/trace_dynevent.c                      |  10 +-
 kernel/trace/trace_dynevent.h                      |   7 +-
 kernel/trace/trace_events_hist.c                   |  23 +-
 kernel/trace/trace_kprobe.c                        | 241 ++++++++++++----
 kernel/trace/trace_probe.c                         | 177 ++++++++++--
 kernel/trace/trace_probe.h                         |  67 ++++-
 kernel/trace/trace_stack.c                         | 112 +++++++
 kernel/trace/trace_uprobe.c                        | 263 +++++++++++++----
 scripts/recordmcount.c                             | 321 ++++++++++-----------
 scripts/recordmcount.h                             | 150 +++++++---
 tools/testing/selftests/ftrace/test.d/functions    |   2 +-
 .../ftrace/test.d/kprobe/kprobe_multiprobe.tc      |  35 +++
 .../ftrace/test.d/kprobe/kprobe_syntax_errors.tc   |  15 +
 19 files changed, 1111 insertions(+), 398 deletions(-)
 create mode 100644 tools/testing/selftests/ftrace/test.d/kprobe/kprobe_multiprobe.tc
