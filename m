Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6712C04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 11:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95BBA208CA
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 11:08:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbfE0LI2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 07:08:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:55352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725814AbfE0LI2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 07:08:28 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97D5120883;
        Mon, 27 May 2019 11:08:26 +0000 (UTC)
Date:   Mon, 27 May 2019 07:08:25 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Andy Lutomirski <luto@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "Frank Ch. Eigler" <fche@redhat.com>
Subject: Re: [RFC][PATCH 03/14 v2] function_graph: Allow multiple users to
 attach to function graph
Message-ID: <20190527070825.0aa31964@gandalf.local.home>
In-Reply-To: <20190527101004.GW2623@hirez.programming.kicks-ass.net>
References: <20190520142001.270067280@goodmis.org>
        <20190520142156.992391836@goodmis.org>
        <20190524112608.GJ2589@hirez.programming.kicks-ass.net>
        <20190524081219.25de03f6@gandalf.local.home>
        <20190524122724.GO2623@hirez.programming.kicks-ass.net>
        <20190524085744.71557f32@gandalf.local.home>
        <20190527101004.GW2623@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 May 2019 12:10:04 +0200
Peter Zijlstra <peterz@infradead.org> wrote:


> > rcu_tasks doesn't cross voluntary sleeps, which this does.  
> 
> Sure, but we can 'fix' that, surely.

Well, that's the point of the rcu_tasks. To let us know when a task has
voluntarily slept. I don't think we want to "fix" that.

> Alternatively we use SRCU, or
> something else, a blend between SRCU and percpu-rwsem for example, SRCU
> has that annoying smp_mb() on the read side, where percpu-rwsem doesn't
> have that.
> 
> > > And delay the unreg until all active users are gone -- who gives a crap
> > > that can take a while.  
> > 
> > It could literally be forever (well, until the machine reboots). And
> > something that could appear to be a memory leak, although a very slow
> > one. But probably be hard to have more than the number of tasks on the
> > system.  
> 
> Again, who cares.. ? How often do you have return trace functions that
> dissapear, afaict that only happens with modules, and neither
> function_graph_trace nor kprobes are modules.
> 
> It'll just mean the module unload will be stuck, possibly forever.
> That's not something I care about. Also, if we _really_ care, we can
> mandate that module users use some sort of ugly trampoline that covers
> their asses at the cost of some performance.
> 
> Getting rid of that array makes this code far saner (and I suspect
> faster too).

The array is not the complex part of this. It was probably the easiest
part of this patch series. It just shows up a lot in the beginning
because I needed it to work before doing anything else. The more
difficult parts came with the passing of data from entry to exit.

I plan on keeping the array for now, as it is just an internal
implementation detail, that gives us only a limitation of the array
size that is noticed outside of the function graph code. If we find
some kind of RCU alternative, then we can switch to that in the
future and remove the array limitation.

-- Steve
