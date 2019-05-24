Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 357B2C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 12:57:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EE5120879
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 12:57:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391516AbfEXM5s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 08:57:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:55138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391124AbfEXM5s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 08:57:48 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8CCDD20665;
        Fri, 24 May 2019 12:57:46 +0000 (UTC)
Date:   Fri, 24 May 2019 08:57:44 -0400
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
Message-ID: <20190524085744.71557f32@gandalf.local.home>
In-Reply-To: <20190524122724.GO2623@hirez.programming.kicks-ass.net>
References: <20190520142001.270067280@goodmis.org>
        <20190520142156.992391836@goodmis.org>
        <20190524112608.GJ2589@hirez.programming.kicks-ass.net>
        <20190524081219.25de03f6@gandalf.local.home>
        <20190524122724.GO2623@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 May 2019 14:27:24 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> > Believe me, I rather not have that array, but I couldn't come up with a
> > better solution to handle freeing of fgraph_ops.  
> 
> The trivial answer would be to refcount the thing, but can't we make
> rcu_tasks do this?

But wouldn't refcounts require atomic operations, something that would
be excruciatingly slow for something that runs on all functions.

rcu_tasks doesn't cross voluntary sleeps, which this does.

> 
> And delay the unreg until all active users are gone -- who gives a crap
> that can take a while.

It could literally be forever (well, until the machine reboots). And
something that could appear to be a memory leak, although a very slow
one. But probably be hard to have more than the number of tasks on the
system.

-- Steve

