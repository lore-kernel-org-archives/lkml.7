Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01021C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 16:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4D6D206E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 16:15:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730919AbfG3QP3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 12:15:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:43990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729025AbfG3QP3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 12:15:29 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 949F5206A2;
        Tue, 30 Jul 2019 16:15:28 +0000 (UTC)
Date:   Tue, 30 Jul 2019 12:15:27 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fgraph: Remove redundant ftrace_graph_notrace_addr()
 test
Message-ID: <20190730121527.13f600f5@gandalf.local.home>
In-Reply-To: <20190730140850.7927-1-changbin.du@gmail.com>
References: <20190730140850.7927-1-changbin.du@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Jul 2019 22:08:50 +0800
Changbin Du <changbin.du@gmail.com> wrote:

> We already have tested it before. The second one should be removed.
> With this change, the performance should have little improvement.
> 
> Fixes: 9cd2992f2d6c ("fgraph: Have set_graph_notrace only affect function_graph tracer")

Thanks! I think this should even be marked for stable. Not really a bad
bug, but a bug none the less.

-- Steve


> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> ---
>  kernel/trace/trace_functions_graph.c | 17 +++++++----------
>  1 file changed, 7 insertions(+), 10 deletions(-)
> 
> diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
> index 69ebf3c2f1b5..78af97163147 100644
> --- a/kernel/trace/trace_functions_graph.c
> +++ b/kernel/trace/trace_functions_graph.c
> @@ -137,6 +137,13 @@ int trace_graph_entry(struct ftrace_graph_ent *trace)
>  	if (trace_recursion_test(TRACE_GRAPH_NOTRACE_BIT))
>  		return 0;
>  
> +	/*
> +	 * Do not trace a function if it's filtered by set_graph_notrace.
> +	 * Make the index of ret stack negative to indicate that it should
> +	 * ignore further functions.  But it needs its own ret stack entry
> +	 * to recover the original index in order to continue tracing after
> +	 * returning from the function.
> +	 */
>  	if (ftrace_graph_notrace_addr(trace->func)) {
>  		trace_recursion_set(TRACE_GRAPH_NOTRACE_BIT);
>  		/*
> @@ -155,16 +162,6 @@ int trace_graph_entry(struct ftrace_graph_ent *trace)
>  	if (ftrace_graph_ignore_irqs())
>  		return 0;
>  
> -	/*
> -	 * Do not trace a function if it's filtered by set_graph_notrace.
> -	 * Make the index of ret stack negative to indicate that it should
> -	 * ignore further functions.  But it needs its own ret stack entry
> -	 * to recover the original index in order to continue tracing after
> -	 * returning from the function.
> -	 */
> -	if (ftrace_graph_notrace_addr(trace->func))
> -		return 1;
> -
>  	/*
>  	 * Stop here if tracing_threshold is set. We only write function return
>  	 * events to the ring buffer.

