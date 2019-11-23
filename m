Return-Path: <SRS0=E2Zf=ZP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 032CFC432C0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 18:12:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBD1D2071B
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 18:12:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbfKWSMn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Nov 2019 13:12:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:40092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726524AbfKWSMm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Nov 2019 13:12:42 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CAAA72067D;
        Sat, 23 Nov 2019 18:12:41 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92.3)
        (envelope-from <rostedt@goodmis.org>)
        id 1iYZtg-000Ewq-Ph; Sat, 23 Nov 2019 13:12:40 -0500
Message-Id: <20191123181157.851427201@goodmis.org>
User-Agent: quilt/0.65
Date:   Sat, 23 Nov 2019 13:11:57 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 00/10] tracing: More updates for 5.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
for-next

Head SHA1: 16c0f03f629a89e6a1249497202b2c154ff46206


Alexei Starovoitov (1):
      ftrace: Return ENOTSUPP when DYNAMIC_FTRACE_WITH_DIRECT_CALLS is not configured

Divya Indi (2):
      tracing: Adding new functions for kernel access to Ftrace instances
      tracing: Sample module to demonstrate kernel access to Ftrace instances.

Enrico Weigelt, metux IT consult (1):
      ftrace: Use BIT() macro

Hassan Naveed (2):
      tracing: Use xarray for syscall trace events
      tracing: Enable syscall optimization for MIPS

Krzysztof Kozlowski (1):
      tracing: Fix Kconfig indentation

Steven Rostedt (VMware) (2):
      ftrace: Add a helper function to modify_ftrace_direct() to allow arch optimization
      ftrace: Rename ftrace_graph_stub to ftrace_stub_graph

Xianting Tian (1):
      ring-buffer: Fix typos in function ring_buffer_producer

----
 arch/Kconfig                         |   8 +++
 arch/mips/Kconfig                    |   1 +
 include/asm-generic/vmlinux.lds.h    |   8 +--
 include/linux/ftrace.h               |  63 +++++++++++------
 include/linux/trace.h                |   3 +-
 include/linux/trace_events.h         |   3 +-
 kernel/trace/Kconfig                 |   8 +--
 kernel/trace/fgraph.c                |   6 +-
 kernel/trace/ftrace.c                | 120 +++++++++++++++++++++++---------
 kernel/trace/ring_buffer_benchmark.c |   4 +-
 kernel/trace/trace.c                 |  96 +++++++++++++++++++------
 kernel/trace/trace.h                 |   1 -
 kernel/trace/trace_events.c          |  27 +++++++-
 kernel/trace/trace_syscalls.c        |  32 +++++++--
 samples/Kconfig                      |   7 ++
 samples/Makefile                     |   1 +
 samples/ftrace/Makefile              |   3 +
 samples/ftrace/sample-trace-array.c  | 131 +++++++++++++++++++++++++++++++++++
 samples/ftrace/sample-trace-array.h  |  84 ++++++++++++++++++++++
 19 files changed, 507 insertions(+), 99 deletions(-)
 create mode 100644 samples/ftrace/sample-trace-array.c
 create mode 100644 samples/ftrace/sample-trace-array.h
