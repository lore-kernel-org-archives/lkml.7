Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 461FEC3A5A6
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 01:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D950217D6
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 01:20:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394589AbfITBUO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 21:20:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:54802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391546AbfITBUO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 21:20:14 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E5B9D214AF;
        Fri, 20 Sep 2019 01:20:12 +0000 (UTC)
Date:   Thu, 19 Sep 2019 21:20:11 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] tracing: Updates for 5.4
Message-ID: <20190919212011.5afc196d@gandalf.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Tracing updates:

 - Addition of multiprobes to kprobe and uprobe events
   Allows for more than one probe attached to the same location

 - Addition of adding immediates to probe parameters

 - Clean up of the recordmcount.c code. This brings us closer
   to merging recordmcount into objtool, and reuse code.

 - Other small clean ups


Please pull the latest trace-v5.4 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v5.4

Tag SHA1: c7ec8cea00f554d7f234b4e8f4fdc0b0a89b564f
Head SHA1: b78b94b82122208902c0f83805e614e1239f9893


Andy Shevchenko (1):
      tracing: Be more clever when dumping hex in __print_hex()

Changbin Du (1):
      ftrace: Simplify ftrace hash lookup code in clear_func_from_hash()

Masami Hiramatsu (17):
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
      tracing/kprobe: Fix NULL pointer access in trace_porbe_unlink()
      tracing/probe: Fix to allow user to enable events on unloaded modules
      tracing/probe: Reject exactly same probe event
      selftests/ftrace: Update kprobe event error testcase

Matt Helsley (8):
      recordmcount: Remove redundant strcmp
      recordmcount: Remove uread()
      recordmcount: Remove unused fd from uwrite() and ulseek()
      recordmcount: Rewrite error/success handling
      recordmcount: Kernel style function signature formatting
      recordmcount: Kernel style formatting
      recordmcount: Remove redundant cleanup() calls
      recordmcount: Clarify what cleanup() does

Steven Rostedt (VMware) (4):
      tracing/arm64: Have max stack tracer handle the case of return address after data
      tracing: Document the stack trace algorithm in the comments
      tracing: Rename tracing_reset() to tracing_reset_cpu()
      selftests/ftrace: Select an existing function in kprobe_eventname test

Tom Zanussi (1):
      tracing: Make sure variable reference alias has correct var_ref_idx

Zhengjun Xing (1):
      tracing: Add "gfp_t" support in synthetic_events

----
 Documentation/trace/kprobetrace.rst                |   1 +
 Documentation/trace/uprobetracer.rst               |   1 +
 arch/arm64/include/asm/ftrace.h                    |  13 +
 kernel/kprobes.c                                   |  56 +++-
 kernel/trace/ftrace.c                              |   6 +-
 kernel/trace/trace.c                               |  14 +-
 kernel/trace/trace.h                               |   1 -
 kernel/trace/trace_dynevent.c                      |  10 +-
 kernel/trace/trace_dynevent.h                      |   7 +-
 kernel/trace/trace_events_hist.c                   |  25 +-
 kernel/trace/trace_kprobe.c                        | 268 +++++++++++++----
 kernel/trace/trace_output.c                        |   6 +-
 kernel/trace/trace_probe.c                         | 178 ++++++++++--
 kernel/trace/trace_probe.h                         |  68 ++++-
 kernel/trace/trace_stack.c                         | 112 +++++++
 kernel/trace/trace_uprobe.c                        | 299 +++++++++++++++----
 scripts/recordmcount.c                             | 321 ++++++++++-----------
 scripts/recordmcount.h                             | 150 +++++++---
 tools/testing/selftests/ftrace/test.d/functions    |   2 +-
 .../ftrace/test.d/kprobe/kprobe_eventname.tc       |  16 +-
 .../ftrace/test.d/kprobe/kprobe_multiprobe.tc      |  35 +++
 .../ftrace/test.d/kprobe/kprobe_syntax_errors.tc   |  16 +
 22 files changed, 1199 insertions(+), 406 deletions(-)
 create mode 100644 tools/testing/selftests/ftrace/test.d/kprobe/kprobe_multiprobe.tc
---------------------------

