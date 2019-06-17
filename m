Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04B22C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 23:37:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDDF4208C0
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 23:37:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728722AbfFQXhC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 19:37:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:39184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726808AbfFQXhC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 19:37:02 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D7454208C0;
        Mon, 17 Jun 2019 23:37:00 +0000 (UTC)
Date:   Mon, 17 Jun 2019 19:36:59 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Divya Indi <divya.indi@oracle.com>
Cc:     linux-kernel@vger.kernel.org,
        Srinivas Eeda <srinivas.eeda@oracle.com>,
        Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
Subject: Re: [PATCH 2/3] tracing: Adding additional NULL checks.
Message-ID: <20190617193659.59b28700@gandalf.local.home>
In-Reply-To: <1560357259-3497-3-git-send-email-divya.indi@oracle.com>
References: <1560357259-3497-1-git-send-email-divya.indi@oracle.com>
        <1560357259-3497-2-git-send-email-divya.indi@oracle.com>
        <1560357259-3497-3-git-send-email-divya.indi@oracle.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jun 2019 09:34:18 -0700
Divya Indi <divya.indi@oracle.com> wrote:

> commit f45d1225adb0 ("tracing: Kernel access to Ftrace instances")
> exported certain functions providing access to Ftrace instances from
> other kernel components.

I'm fine with the patch, the above statement is hard to understand.

-- Steve

> Adding some additional NULL checks to ensure safe usage by the users.
> 
> Signed-off-by: Divya Indi <divya.indi@oracle.com>
> ---
>  kernel/trace/trace.c        | 3 +++
>  kernel/trace/trace_events.c | 2 ++
>  2 files changed, 5 insertions(+)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 1c80521..a60dc13 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -3205,6 +3205,9 @@ int trace_array_printk(struct trace_array *tr,
>  	if (!(global_trace.trace_flags & TRACE_ITER_PRINTK))
>  		return 0;
>  
> +	if (!tr)
> +		return -EINVAL;
> +
>  	va_start(ap, fmt);
>  	ret = trace_array_vprintk(tr, ip, fmt, ap);
>  	va_end(ap);
> diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
> index b6b4618..445b059 100644
> --- a/kernel/trace/trace_events.c
> +++ b/kernel/trace/trace_events.c
> @@ -800,6 +800,8 @@ int ftrace_set_clr_event(struct trace_array *tr, char *buf, int set)
>  	char *event = NULL, *sub = NULL, *match;
>  	int ret;
>  
> +	if (!tr)
> +		return -ENODEV;
>  	/*
>  	 * The buf format can be <subsystem>:<event-name>
>  	 *  *:<event-name> means any event by that name.

