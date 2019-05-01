Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99088C43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 19:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AF962177B
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 19:16:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726209AbfEATQ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 15:16:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:40448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726096AbfEATQ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 15:16:57 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C9A4C2081C;
        Wed,  1 May 2019 19:16:56 +0000 (UTC)
Date:   Wed, 1 May 2019 15:16:55 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, andrea.parri@amarulasolutions.com
Subject: Re: Question about sched_setaffinity()
Message-ID: <20190501151655.51469a4c@gandalf.local.home>
In-Reply-To: <20190501191213.GX3923@linux.ibm.com>
References: <20190427180246.GA15502@linux.ibm.com>
        <20190430100318.GP2623@hirez.programming.kicks-ass.net>
        <20190430105129.GA3923@linux.ibm.com>
        <20190430115551.GT2623@hirez.programming.kicks-ass.net>
        <20190501191213.GX3923@linux.ibm.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 May 2019 12:12:13 -0700
"Paul E. McKenney" <paulmck@linux.ibm.com> wrote:


> OK, what I did was to apply the patch at the end of this email to -rcu
> branch dev, then run rcutorture as follows:
> 
> nohup tools/testing/selftests/rcutorture/bin/kvm.sh --cpus 8 --duration 2 --configs "TRIVIAL" --bootargs "trace_event=sched:sched_switch,sched:sched_wakeup ftrace=function_graph ftrace_graph_filter=sched_setaffinity,migration_cpu_stop"
> 
> This resulted in the console output that I placed here:
> 
> http://www2.rdrop.com/~paulmck/submission/console.log.gz
> 
> But I don't see calls to sched_setaffinity() or migration_cpu_stop().
> Steve, is something else needed on the kernel command line in addition to
> the following?
> 
> ftrace=function_graph ftrace_graph_filter=sched_setaffinity,migration_cpu_stop

Do you have function graph enabled in the config?

[    2.098303] ftrace bootup tracer 'function_graph' not registered.


-- Steve
