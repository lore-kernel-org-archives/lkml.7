Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05C95C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 14:22:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA527216FD
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 14:22:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388966AbfETOWB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 10:22:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:48590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730819AbfETOV6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 10:21:58 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B45352171F;
        Mon, 20 May 2019 14:21:57 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1hSjAq-0003Nr-KU; Mon, 20 May 2019 10:21:56 -0400
Message-Id: <20190520142001.270067280@goodmis.org>
User-Agent: quilt/0.65
Date:   Mon, 20 May 2019 10:20:01 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Andy Lutomirski <luto@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "Frank Ch. Eigler" <fche@redhat.com>
Subject: [RFC][PATCH 00/14 v2] function_graph: Rewrite to allow multiple users
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


The background for this is explained in the V1 version found here:

 http://lkml.kernel.org/r/20181122012708.491151844@goodmis.org

The TL;DR; is this:

 The function graph tracer required a rewrite, mainly because it
 can only allow one callback registered at a time. The main motivation
 for this change is to allow kretprobes to use the code of function
 graph tracer, which should allow all archs that have function graph
 tracing to also have kretprobes with no extra work.

Masami told me that one requirement was to allow the function entry
callback to store data on the shadow stack that can be retrieved by
the the function return callback. I added this, as well as a per-task
variable (used by one of the function graph users).

The two functions to allow the storing of data on the stack and
retrieval of it are:

 void *fgraph_reserve_data(int size_in_bytes)

    Allows the entry function to reserve up to 4 words of data on
    the shadow stack. On success, a pointer to the contents is returned.
    This may be only called once per entry function.

 void *fgraph_retrieve_data(void)

    Allows the return function to retrieve the reserved data that was
    allocated by the entry function.

Note, this code has passed my full test suite.

Changes since v1:

  - Well, the first part of that series was already merged.
    But that was just the preparation for this part.

  - Allocate a page for the shadow stack split it up that way.
    When the stack is full, we stop allowing more to be added (stop tracing).

  - Added the reserve and retrieve of private data on the shadow stack
    for individual entry/return callbacks to pass data to each other.

  - Added a "per task" data that can be used by a fgraph_ops for all
    function callbacks for a specific task.

Steven Rostedt (VMware) (14):
      function_graph: Convert ret_stack to a series of longs
      function_graph: Add an array structure that will allow multiple callbacks
      function_graph: Allow multiple users to attach to function graph
      function_graph: Remove logic around ftrace_graph_entry and return
      ftrace/function_graph: Pass fgraph_ops to function graph callbacks
      ftrace: Allow function_graph tracer to be enabled in instances
      ftrace: Allow ftrace startup flags exist without dynamic ftrace
      function_graph: Have the instances use their own ftrace_ops for filtering
      function_graph: Add "task variables" per task for fgraph_ops
      function_graph: Move set_graph_function tests to shadow stack global var
      function_graph: Move graph depth stored data to shadow stack global var
      function_graph: Move graph notrace bit to shadow stack global var
      function_graph: Implement fgraph_reserve_data() and fgraph_retrieve_data()
      function_graph: Add selftest for passing local variables

----
 include/linux/ftrace.h               |  37 +-
 include/linux/sched.h                |   2 +-
 kernel/trace/fgraph.c                | 862 ++++++++++++++++++++++++++++-------
 kernel/trace/ftrace.c                |  13 +-
 kernel/trace/ftrace_internal.h       |   2 -
 kernel/trace/trace.h                 | 132 +++---
 kernel/trace/trace_functions.c       |   7 +
 kernel/trace/trace_functions_graph.c |  96 ++--
 kernel/trace/trace_irqsoff.c         |  10 +-
 kernel/trace/trace_sched_wakeup.c    |  10 +-
 kernel/trace/trace_selftest.c        | 168 ++++++-
 11 files changed, 1048 insertions(+), 291 deletions(-)
