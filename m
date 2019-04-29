Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7064C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 13:31:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B90372084B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 13:31:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728321AbfD2NbV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 09:31:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:35648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726321AbfD2NbV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 09:31:21 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 004C520652;
        Mon, 29 Apr 2019 13:31:18 +0000 (UTC)
Date:   Mon, 29 Apr 2019 09:31:17 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     tip-bot for Peter Zijlstra <tipbot@zytor.com>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org, guro@fb.com,
        peterz@infradead.org, hpa@zytor.com, dave@stgolabs.net,
        tim.c.chen@linux.intel.com, rostedt@goodmis.org, ast@kernel.org,
        torvalds@linux-foundation.org, longman@redhat.com,
        will.deacon@arm.com, huang.ying.caritas@gmail.com,
        daniel@iogearbox.net, tglx@linutronix.de,
        linux-tip-commits@vger.kernel.org
Subject: Re: [tip:sched/core] trace: Fix preempt_enable_no_resched() abuse
Message-ID: <20190429093117.23760399@gandalf.local.home>
In-Reply-To: <tip-e8bd5814989b994cf1b0cb179e1c777e40c0f02c@git.kernel.org>
References: <20190423200318.GY14281@hirez.programming.kicks-ass.net>
        <tip-e8bd5814989b994cf1b0cb179e1c777e40c0f02c@git.kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 Apr 2019 23:39:03 -0700
tip-bot for Peter Zijlstra <tipbot@zytor.com> wrote:

> Commit-ID:  e8bd5814989b994cf1b0cb179e1c777e40c0f02c
> Gitweb:     https://git.kernel.org/tip/e8bd5814989b994cf1b0cb179e1c777e40c0f02c
> Author:     Peter Zijlstra <peterz@infradead.org>
> AuthorDate: Tue, 23 Apr 2019 22:03:18 +0200
> Committer:  Ingo Molnar <mingo@kernel.org>
> CommitDate: Mon, 29 Apr 2019 08:27:09 +0200
> 
> trace: Fix preempt_enable_no_resched() abuse

Hi Ingo,

I already sent this fix to Linus, and it's been pulled in to his tree.

Commit: d6097c9e4454adf1f8f2c9547c2fa6060d55d952

-- Steve

> 
> Unless there is a call into schedule() in the immediate
> (deterministic) future, one must not use preempt_enable_no_resched().
> It can cause a preemption to go missing and thereby cause arbitrary
> delays, breaking the PREEMPT=y invariant.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Roman Gushchin <guro@fb.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Tim Chen <tim.c.chen@linux.intel.com>
> Cc: Waiman Long <longman@redhat.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: huang ying <huang.ying.caritas@gmail.com>
> Fixes: 2c2d7329d8af ("tracing/ftrace: use preempt_enable_no_resched_notrace in ring_buffer_time_stamp()")
> Link: https://lkml.kernel.org/r/20190423200318.GY14281@hirez.programming.kicks-ass.net
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> ---
>  kernel/trace/ring_buffer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 41b6f96e5366..4ee8d8aa3d0f 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -762,7 +762,7 @@ u64 ring_buffer_time_stamp(struct ring_buffer *buffer, int cpu)
>  
>  	preempt_disable_notrace();
>  	time = rb_time_stamp(buffer);
> -	preempt_enable_no_resched_notrace();
> +	preempt_enable_notrace();
>  
>  	return time;
>  }

