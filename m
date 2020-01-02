Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CEF5C2D0DC
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 15:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BE422084D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 15:42:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728766AbgABPmd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 10:42:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:33976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728561AbgABPmd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 10:42:33 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 187862072C;
        Thu,  2 Jan 2020 15:42:32 +0000 (UTC)
Date:   Thu, 2 Jan 2020 10:42:30 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Wen Yang <wenyang@linux.alibaba.com>
Cc:     Ingo Molnar <mingo@redhat.com>, xlpang@linux.alibaba.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ftrace: avoid potential division by zero
Message-ID: <20200102104230.6125d776@gandalf.local.home>
In-Reply-To: <20200101093219.3639-1-wenyang@linux.alibaba.com>
References: <20200101093219.3639-1-wenyang@linux.alibaba.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  1 Jan 2020 17:32:19 +0800
Wen Yang <wenyang@linux.alibaba.com> wrote:

> The ftrace_profile->counter is unsigned long and
> do_div truncates it to 32 bits, which means it can test
> non-zero and be truncated to zero for division.
> Fix this issue by using div64_ul() instead.

Thanks, but since we are using div64_ul() which has different semantics
than do_div() let's clean up the code that was written to deal with the
strange do_div() semantics.

> 
> Signed-off-by: Wen Yang <wenyang@linux.alibaba.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: linux-kernel@vger.kernel.org
> ---
>  kernel/trace/ftrace.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index ac99a35..a490ba5 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -527,7 +527,7 @@ static int function_stat_show(struct seq_file *m, void *v)
>  
>  #ifdef CONFIG_FUNCTION_GRAPH_TRACER
>  	avg = rec->time;
> -	do_div(avg, rec->counter);
> +	avg = div64_ul(avg, rec->counter);

The above should be:

	avg = div64_ul(rec->time, rec->counter);

and get rid of the pre-assigning of avg.


>  	if (tracing_thresh && (avg < tracing_thresh))
>  		goto out;
>  #endif
> @@ -553,7 +553,8 @@ static int function_stat_show(struct seq_file *m, void *v)
>  		 * Divide only 1000 for ns^2 -> us^2 conversion.
>  		 * trace_print_graph_duration will divide 1000 again.
>  		 */
> -		do_div(stddev, rec->counter * (rec->counter - 1) * 1000);
> +		stddev = div64_ul(stddev, 
> +				  rec->counter * (rec->counter - 1) * 1000);

This can stay as is, because of the complex dividend in the equation.

Thanks,

-- Steve


>  	}
>  
>  	trace_seq_init(&s);

