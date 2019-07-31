Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 272A0C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 10:58:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0630620651
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 10:58:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728332AbfGaK56 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 06:57:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:58564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726417AbfGaK56 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 06:57:58 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC3C020651;
        Wed, 31 Jul 2019 10:57:56 +0000 (UTC)
Date:   Wed, 31 Jul 2019 06:57:55 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jiping Ma <jiping.ma2@windriver.com>
Cc:     <mingo@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Function stack size and its name mismatch in arm64
Message-ID: <20190731065755.5f5bd8a0@gandalf.local.home>
In-Reply-To: <20190731090437.19867-1-jiping.ma2@windriver.com>
References: <20190731090437.19867-1-jiping.ma2@windriver.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Jul 2019 17:04:37 +0800
Jiping Ma <jiping.ma2@windriver.com> wrote:

Hi Jiping,

Note, the subject is not properly written, as it is missing the
subsystem. In this case, it should start with "tracing: "


> The PC of one the frame is matched to the next frame function, rather
> than the function of his frame.

The above change log doesn't make sense. I have no idea what the actual
problem is here. Why is this different for arm64 and no one else? Seems
the bug is with the stack logic code in arm64 not here.

> 
> Signed-off-by: Jiping Ma <jiping.ma2@windriver.com>
> ---
>  kernel/trace/trace_stack.c | 28 ++++++++++++++++++++++++++--
>  1 file changed, 26 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/trace_stack.c b/kernel/trace/trace_stack.c
> index 5d16f73898db..ed80b95abf06 100644
> --- a/kernel/trace/trace_stack.c
> +++ b/kernel/trace/trace_stack.c
> @@ -40,16 +40,28 @@ static void print_max_stack(void)
>  
>  	pr_emerg("        Depth    Size   Location    (%d entries)\n"
>  			   "        -----    ----   --------\n",
> +#ifdef CONFIG_ARM64

We do not allow arch specific defines in generic code. Otherwise this
would blow up and become unmaintainable. Not to mention it makes the
code ugly and hard to follow.

Please explain the problem better. I'm sure there's much better ways to
solve this than this patch.

Thanks,

-- Steve



> +			   stack_trace_nr_entries - 1);
> +#else
>  			   stack_trace_nr_entries);
> -
> +#endif
> +#ifdef CONFIG_ARM64
> +	for (i = 1; i < stack_trace_nr_entries; i++) {
> +#else
>  	for (i = 0; i < stack_trace_nr_entries; i++) {
> +#endif
>  		if (i + 1 == stack_trace_nr_entries)
>  			size = stack_trace_index[i];
>  		else
>  			size = stack_trace_index[i] - stack_trace_index[i+1];
>  
> +#ifdef CONFIG_ARM64
> +		pr_emerg("%3ld) %8d   %5d   %pS\n", i-1, stack_trace_index[i],
> +				size, (void *)stack_dump_trace[i-1]);
> +#else
>  		pr_emerg("%3ld) %8d   %5d   %pS\n", i, stack_trace_index[i],
>  				size, (void *)stack_dump_trace[i]);
> +#endif
>  	}
>  }
>  
> @@ -324,8 +336,11 @@ static int t_show(struct seq_file *m, void *v)
>  		seq_printf(m, "        Depth    Size   Location"
>  			   "    (%d entries)\n"
>  			   "        -----    ----   --------\n",
> +#ifdef CONFIG_ARM64
> +			   stack_trace_nr_entries - 1);
> +#else
>  			   stack_trace_nr_entries);
> -
> +#endif
>  		if (!stack_tracer_enabled && !stack_trace_max_size)
>  			print_disabled(m);
>  
> @@ -334,6 +349,10 @@ static int t_show(struct seq_file *m, void *v)
>  
>  	i = *(long *)v;
>  
> +#ifdef CONFIG_ARM64
> +	if (i == 0)
> +		return 0;
> +#endif
>  	if (i >= stack_trace_nr_entries)
>  		return 0;
>  
> @@ -342,9 +361,14 @@ static int t_show(struct seq_file *m, void *v)
>  	else
>  		size = stack_trace_index[i] - stack_trace_index[i+1];
>  
> +#ifdef CONFIG_ARM64
> +	seq_printf(m, "%3ld) %8d   %5d   ", i-1, stack_trace_index[i], size);
> +	trace_lookup_stack(m, i-1);
> +#else
>  	seq_printf(m, "%3ld) %8d   %5d   ", i, stack_trace_index[i], size);
>  
>  	trace_lookup_stack(m, i);
> +#endif
>  
>  	return 0;
>  }

