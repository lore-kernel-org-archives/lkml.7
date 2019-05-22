Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1571DC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 14:20:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D99C52173E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 14:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558534803;
	bh=Q9hCv/1n7q7OlMdRONYGNTpGAXY/dQS9JMtc4v/142I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=IZ8ImNJEzy1IfBCx/MTmvxytB2Bzw47VrmJCaJl/8og5hkMSuAlLGdMN2sLdC3MCI
	 4dMVYaG+mNa/SoJsI7fMii9u+8zMiy6FkKWzR6ppBVknRb/Hw6PuVD2nzyWrgNhAYH
	 5kU/zKJfvLUXCH+IudLVqa17YZWWLMNyXUl0VQ8c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729126AbfEVOUD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 10:20:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:59182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727975AbfEVOUC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 10:20:02 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB50420879;
        Wed, 22 May 2019 14:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558534801;
        bh=Q9hCv/1n7q7OlMdRONYGNTpGAXY/dQS9JMtc4v/142I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bPi7nJ//eDKAymNRvLx6Tl8gz2xCFUQDeBR0hNE6k3X+BtvixWaAOyBsoUt9Q78Fm
         r5GpkHkpNs+60CVXLce/fn6NxeA7IWWa2U4b0EZ4GeXGe+PvJcvobdFmwlK0j6CouB
         GbeOG6eskfZCuRk7q8YANT5i+sKyohKFYE4MKinc=
Date:   Wed, 22 May 2019 23:19:55 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
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
Subject: Re: [RFC][PATCH 00/14 v2] function_graph: Rewrite to allow multiple
 users
Message-Id: <20190522231955.72899b0d606adb919e8716ff@kernel.org>
In-Reply-To: <20190520142001.270067280@goodmis.org>
References: <20190520142001.270067280@goodmis.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 May 2019 10:20:01 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> 
> The background for this is explained in the V1 version found here:
> 
>  http://lkml.kernel.org/r/20181122012708.491151844@goodmis.org
> 
> The TL;DR; is this:
> 
>  The function graph tracer required a rewrite, mainly because it
>  can only allow one callback registered at a time. The main motivation
>  for this change is to allow kretprobes to use the code of function
>  graph tracer, which should allow all archs that have function graph
>  tracing to also have kretprobes with no extra work.
> 
> Masami told me that one requirement was to allow the function entry
> callback to store data on the shadow stack that can be retrieved by
> the the function return callback. I added this, as well as a per-task
> variable (used by one of the function graph users).
> 
> The two functions to allow the storing of data on the stack and
> retrieval of it are:
> 
>  void *fgraph_reserve_data(int size_in_bytes)
> 
>     Allows the entry function to reserve up to 4 words of data on
>     the shadow stack. On success, a pointer to the contents is returned.
>     This may be only called once per entry function.
> 
>  void *fgraph_retrieve_data(void)
> 
>     Allows the return function to retrieve the reserved data that was
>     allocated by the entry function.

Nice! this seems good for kretprobe too. I'll review and try to port
kretprobe on this framework.

Thank you!

> 
> Note, this code has passed my full test suite.
> 
> Changes since v1:
> 
>   - Well, the first part of that series was already merged.
>     But that was just the preparation for this part.
> 
>   - Allocate a page for the shadow stack split it up that way.
>     When the stack is full, we stop allowing more to be added (stop tracing).
> 
>   - Added the reserve and retrieve of private data on the shadow stack
>     for individual entry/return callbacks to pass data to each other.
> 
>   - Added a "per task" data that can be used by a fgraph_ops for all
>     function callbacks for a specific task.
> 
> Steven Rostedt (VMware) (14):
>       function_graph: Convert ret_stack to a series of longs
>       function_graph: Add an array structure that will allow multiple callbacks
>       function_graph: Allow multiple users to attach to function graph
>       function_graph: Remove logic around ftrace_graph_entry and return
>       ftrace/function_graph: Pass fgraph_ops to function graph callbacks
>       ftrace: Allow function_graph tracer to be enabled in instances
>       ftrace: Allow ftrace startup flags exist without dynamic ftrace
>       function_graph: Have the instances use their own ftrace_ops for filtering
>       function_graph: Add "task variables" per task for fgraph_ops
>       function_graph: Move set_graph_function tests to shadow stack global var
>       function_graph: Move graph depth stored data to shadow stack global var
>       function_graph: Move graph notrace bit to shadow stack global var
>       function_graph: Implement fgraph_reserve_data() and fgraph_retrieve_data()
>       function_graph: Add selftest for passing local variables
> 
> ----
>  include/linux/ftrace.h               |  37 +-
>  include/linux/sched.h                |   2 +-
>  kernel/trace/fgraph.c                | 862 ++++++++++++++++++++++++++++-------
>  kernel/trace/ftrace.c                |  13 +-
>  kernel/trace/ftrace_internal.h       |   2 -
>  kernel/trace/trace.h                 | 132 +++---
>  kernel/trace/trace_functions.c       |   7 +
>  kernel/trace/trace_functions_graph.c |  96 ++--
>  kernel/trace/trace_irqsoff.c         |  10 +-
>  kernel/trace/trace_sched_wakeup.c    |  10 +-
>  kernel/trace/trace_selftest.c        | 168 ++++++-
>  11 files changed, 1048 insertions(+), 291 deletions(-)


-- 
Masami Hiramatsu <mhiramat@kernel.org>
