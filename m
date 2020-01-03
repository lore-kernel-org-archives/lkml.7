Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98E08C2D0C2
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 16:40:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7742E206E6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 16:40:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728062AbgACQkE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 11:40:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:46176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727859AbgACQkD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 11:40:03 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A2E07206DB;
        Fri,  3 Jan 2020 16:40:02 +0000 (UTC)
Date:   Fri, 3 Jan 2020 11:40:01 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Frank A. Cancio Bello" <frank@generalsoftwareinc.com>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        joel@joelfernandes.org, saiprakash.ranjan@codeaurora.org,
        nachukannan@gmail.com
Subject: Re: [PATCH] tracing: Resets the trace buffer after a snapshot
Message-ID: <20200103114001.2c118ab1@gandalf.local.home>
In-Reply-To: <20191231085822.yxhph6wcguejb7al@frank-laptop>
References: <20191231085822.yxhph6wcguejb7al@frank-laptop>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Dec 2019 03:58:22 -0500
"Frank A. Cancio Bello" <frank@generalsoftwareinc.com> wrote:

> Currently, when a snapshot is taken the trace_buffer and the
> max_buffer are swapped. After this swap, the "new" trace_buffer is
> not reset. This produces an odd behavior: after a snapshot is taken
> the previous snapshot entries become available to the next reader of
> the trace_buffer as far as the reading occurs before the buffer is
> refilled with new entries by a writer.

I consider this a feature not a bug ;-)

Anyway, this behavior should be determined by an option. Care to create
one? (reset_on_snapshot?) I would keep the default behavior the same,
but document this a bit better.

Thanks!

-- Steve

> 
> This patch resets the trace buffer after a snapshot is taken.
> 
> Signed-off-by: Frank A. Cancio Bello <frank@generalsoftwareinc.com>
> ---
> 
> The following commands illustrate this odd behavior:
> 
> # cd /sys/kernel/debug/tracing
> # echo nop > current_tracer
> # echo 1 > tracing_on
> # echo m1 > trace_marker
> # echo 1 > snapshot
> # echo m2 > trace_marker
> # echo 1 > snapshot
> # cat trace
> # tracer: nop
> #
> # entries-in-buffer/entries-written: 1/1   #P:2
> #
> #                              _-----=> irqs-off
> #                             / _----=> need-resched
> #                            | / _---=> hardirq/softirq
> #                            || / _--=> preempt-depth
> #                            ||| /     delay
> #           TASK-PID   CPU#  ||||    TIMESTAMP  FUNCTION
> #              | |       |   ||||       |         |
>             bash-550   [000] ....    50.479755: tracing_mark_write: m1
> 
> 
>  kernel/trace/trace.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index ddb7e7f5fe8d..58373b5ae0cf 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -6867,10 +6867,13 @@ tracing_snapshot_write(struct file *filp, const char __user *ubuf, size_t cnt,
>  			break;
>  		local_irq_disable();
>  		/* Now, we're going to swap */
> -		if (iter->cpu_file == RING_BUFFER_ALL_CPUS)
> +		if (iter->cpu_file == RING_BUFFER_ALL_CPUS) {
>  			update_max_tr(tr, current, smp_processor_id(), NULL);
> -		else
> +			tracing_reset_online_cpus(&tr->trace_buffer);
> +		} else {
>  			update_max_tr_single(tr, current, iter->cpu_file);
> +			tracing_reset_cpu(&tr->trace_buffer, iter->cpu_file);
> +		}
>  		local_irq_enable();
>  		break;
>  	default:

