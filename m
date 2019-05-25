Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C124C282E1
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 03:18:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BA0121773
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 03:18:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbfEYDRs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 23:17:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:60784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726483AbfEYDRr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 23:17:47 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 133332175B;
        Sat, 25 May 2019 03:17:46 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1hUNBp-0001hD-5R; Fri, 24 May 2019 23:17:45 -0400
Message-Id: <20190525031633.811342628@goodmis.org>
User-Agent: quilt/0.65
Date:   Fri, 24 May 2019 23:16:33 -0400
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
Subject: [PATCH 00/16 v3] function_graph: Rewrite to allow multiple users
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

Changes since v2:

  http://lkml.kernel.org/r/20190520142001.270067280@goodmis.org

 As a request from Peter Zijlstra, I changed the direction of
 the stack from growing up, to growing down. It passes some smoke
 tests, but I will need to run a lot more tests on it. But I decide
 to post this series anyway.

 Also changed, was using BULID_BUG_ON() instead of the align tricks,
 And also used round_up() to remove another align trick.

 I found a bug it patch 4 that was fixed in patch 5, but I fixed
 it in patch 4 to keep it bisectable.

 Added a few more comments, and also added more boot up self tests to
 test more of the passing of data around.

The git repo can be found here:

  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
ftrace/fgraph-multi-stackdown

Head SHA1: 7e25deae405b75aaaa7d5d98fcafdd79c34f87cb


Steven Rostedt (VMware) (16):
      function_graph: Convert ret_stack to a series of longs
      fgraph: Use BUILD_BUG_ON() to make sure we have structures divisible by long
      fgraph: Have the current->ret_stack go down not up
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
 kernel/trace/fgraph.c                | 870 ++++++++++++++++++++++++++++-------
 kernel/trace/ftrace.c                |  13 +-
 kernel/trace/ftrace_internal.h       |   2 -
 kernel/trace/trace.h                 | 132 +++---
 kernel/trace/trace_functions.c       |   7 +
 kernel/trace/trace_functions_graph.c |  96 ++--
 kernel/trace/trace_irqsoff.c         |  10 +-
 kernel/trace/trace_sched_wakeup.c    |  10 +-
 kernel/trace/trace_selftest.c        | 317 ++++++++++++-
 11 files changed, 1205 insertions(+), 291 deletions(-)
