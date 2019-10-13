Return-Path: <SRS0=daYT=YG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB898C4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 17:44:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7CB72067B
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 17:44:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728496AbfJMRoU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Oct 2019 13:44:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:36706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726264AbfJMRoT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Oct 2019 13:44:19 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F058E2067B;
        Sun, 13 Oct 2019 17:44:18 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1iJhuk-0001x9-4n; Sun, 13 Oct 2019 13:44:18 -0400
Message-Id: <20191013174342.381019558@goodmis.org>
User-Agent: quilt/0.65
Date:   Sun, 13 Oct 2019 13:43:42 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-linus][PATCH 00/11] tracing: Fixes for v5.4-rc2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Petr Mladek (1):
      tracing: Initialize iter->seq after zeroing in tracing_read_pipe()

Srivatsa S. Bhat (VMware) (2):
      tracing/hwlat: Report total time spent in all NMIs during the sample
      tracing/hwlat: Don't ignore outer-loop duration when calculating max_latency

Steven Rostedt (VMware) (8):
      tracefs: Revert ccbd54ff54e8 ("tracefs: Restrict tracefs when the kernel is locked down")
      ftrace: Get a reference counter for the trace_array on filter files
      tracing: Get trace_array reference for available_tracers files
      tracing: Have trace events system open call tracing_open_generic_tr()
      tracing: Add tracing_check_open_get_tr()
      tracing: Add locked_down checks to the open calls of files created for tracefs
      tracing: Do not create tracefs files if tracefs lockdown is in effect
      recordmcount: Fix nop_mcount() function

----
 fs/tracefs/inode.c                  |  46 ++----------
 kernel/trace/ftrace.c               |  55 ++++++++++----
 kernel/trace/trace.c                | 139 ++++++++++++++++++++++--------------
 kernel/trace/trace.h                |   2 +
 kernel/trace/trace_dynevent.c       |   4 ++
 kernel/trace/trace_events.c         |  35 +++++----
 kernel/trace/trace_events_hist.c    |  13 +++-
 kernel/trace/trace_events_trigger.c |   8 ++-
 kernel/trace/trace_hwlat.c          |   4 +-
 kernel/trace/trace_kprobe.c         |  12 +++-
 kernel/trace/trace_printk.c         |   7 ++
 kernel/trace/trace_stack.c          |   8 +++
 kernel/trace/trace_stat.c           |   6 +-
 kernel/trace/trace_uprobe.c         |  11 +++
 scripts/recordmcount.h              |   5 +-
 15 files changed, 223 insertions(+), 132 deletions(-)
