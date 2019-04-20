Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3552C282E1
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 02:37:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A88E21479
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 02:37:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727608AbfDTChV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 22:37:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:49478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725858AbfDTChV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 22:37:21 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5AC2E21479;
        Sat, 20 Apr 2019 02:37:20 +0000 (UTC)
Date:   Fri, 19 Apr 2019 22:37:18 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Wenwen Wang <wang6495@umn.edu>
Cc:     Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH] tracing: Fix a memory leak bug
Message-ID: <20190419223718.17fa8246@oasis.local.home>
In-Reply-To: <1555726979-15633-1-git-send-email-wang6495@umn.edu>
References: <1555726979-15633-1-git-send-email-wang6495@umn.edu>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Apr 2019 21:22:59 -0500
Wenwen Wang <wang6495@umn.edu> wrote:

> In trace_pid_write(), the buffer for trace parser is allocated through
> kmalloc() in trace_parser_get_init(). Later on, after the buffer is used,
> it is then freed through kfree() in trace_parser_put(). However, it is
> possible that trace_pid_write() is terminated due to unexpected errors,
> e.g., ENOMEM. In that case, the allocated buffer will not be freed, which
> is a memory leak bug.
> 
> To fix this issue, free the allocated buffer when an error is encountered.

Thanks for the patch. Did you find this through manual inspection,
running KASAN or via one of the static analyzers?

-- Steve

> 
> Signed-off-by: Wenwen Wang <wang6495@umn.edu>
> ---
>  kernel/trace/trace.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 6c24755..fd12c9c 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -496,8 +496,10 @@ int trace_pid_write(struct trace_pid_list
> *filtered_pids,
>  	 * not modified.
>  	 */
>  	pid_list = kmalloc(sizeof(*pid_list), GFP_KERNEL);
> -	if (!pid_list)
> +	if (!pid_list) {
> +		trace_parser_put(&parser);
>  		return -ENOMEM;
> +	}
>  
>  	pid_list->pid_max = READ_ONCE(pid_max);
>  
> @@ -507,6 +509,7 @@ int trace_pid_write(struct trace_pid_list
> *filtered_pids, 
>  	pid_list->pids = vzalloc((pid_list->pid_max + 7) >> 3);
>  	if (!pid_list->pids) {
> +		trace_parser_put(&parser);
>  		kfree(pid_list);
>  		return -ENOMEM;
>  	}

