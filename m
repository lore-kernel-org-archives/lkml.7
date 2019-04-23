Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A819C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 23:58:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B8BF217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 23:58:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728810AbfDWX6x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 19:58:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:46978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726339AbfDWX6x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 19:58:53 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C722921738;
        Tue, 23 Apr 2019 23:58:51 +0000 (UTC)
Date:   Tue, 23 Apr 2019 19:58:50 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Waiman Long <longman@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        huang ying <huang.ying.caritas@gmail.com>,
        Roman Gushchin <guro@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH] trace: Fix preempt_enable_no_resched() abuse
Message-ID: <20190423195850.6ea5b13e@gandalf.local.home>
In-Reply-To: <20190423200318.GY14281@hirez.programming.kicks-ass.net>
References: <20190419130304.GV14281@hirez.programming.kicks-ass.net>
        <20190419131522.GW14281@hirez.programming.kicks-ass.net>
        <57620139-92a3-4a21-56bd-5d6fff23214f@redhat.com>
        <7b1bfc26-6e90-bd65-ab46-08413acd80e9@redhat.com>
        <20190423141714.GO11158@hirez.programming.kicks-ass.net>
        <CAHk-=whnQJ9YDrkcKteNSACMJxzw1bL0RPfGQsey_9Nm7b8mnw@mail.gmail.com>
        <4f62d7f2-e5f6-500e-3e70-b1d1978f7140@redhat.com>
        <20190423193435.GX4038@hirez.programming.kicks-ass.net>
        <88ba7be0-9ec5-941e-1b3f-80fbe05fe3a0@redhat.com>
        <20190423195559.GY4038@hirez.programming.kicks-ass.net>
        <20190423200318.GY14281@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Apr 2019 22:03:18 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Tue, Apr 23, 2019 at 09:55:59PM +0200, Peter Zijlstra wrote:
> > On Tue, Apr 23, 2019 at 03:41:32PM -0400, Waiman Long wrote:  
> 
> > > I saw a number of instances of
> > > preempt_enable_no_resched() without right next a schedule().  
> > 
> > Look more closely.. and let me know, if true, those are bugs that need
> > fixing.
> > 
> > Argghhh.. BPF...  
> 
> /me shakes head, Steve...

/me points finger to Frederic ;-)


> 
> ---
> Subject: trace: Fix preempt_enable_no_resched() abuse
> 
> Unless the very next line is schedule(), or implies it, one must not use
> preempt_enable_no_resched(). It can cause a preemption to go missing and
> thereby cause arbitrary delays, breaking the PREEMPT=y invariant.
> 
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Fixes: 37886f6a9f62 ("ring-buffer: add api to allow a tracer to change clock source")

That commit just moved the buggy code. That tag should be:

Fixes: 2c2d7329d8af ("tracing/ftrace: use preempt_enable_no_resched_notrace in ring_buffer_time_stamp()")

OK, this isn't quite fair to point all the blame on Frederic, because
it did fix a bug. But the real fix for that bug was your fix here:

499d79559ffe4b ("sched/core: More notrace annotations")

-- Steve


> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  kernel/trace/ring_buffer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 41b6f96e5366..4ee8d8aa3d0f 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -762,7 +762,7 @@ u64 ring_buffer_time_stamp(struct ring_buffer
> *buffer, int cpu) 
>  	preempt_disable_notrace();
>  	time = rb_time_stamp(buffer);
> -	preempt_enable_no_resched_notrace();
> +	preempt_enable_notrace();
>  
>  	return time;
>  }

