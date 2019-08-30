Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1607C3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 21:04:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A376823697
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 21:04:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728474AbfH3VE1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 17:04:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:58488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728176AbfH3VE1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 17:04:27 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4037C23439;
        Fri, 30 Aug 2019 21:04:26 +0000 (UTC)
Date:   Fri, 30 Aug 2019 17:04:24 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Divya Indi <divya.indi@oracle.com>
Subject: Re: [PATCH v1] tracing: Drop static keyword for exported
 ftrace_set_clr_event()
Message-ID: <20190830170424.40c4188a@gandalf.local.home>
In-Reply-To: <20190830193228.65446-1-andriy.shevchenko@linux.intel.com>
References: <20190830193228.65446-1-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Aug 2019 22:32:28 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> When we export something, it shan't be static.

I'm finally getting around to my patch queue (it's unfortunately much
bigger than I should be). But my punishment is duplicate patches.

Someone beat you to it...

 http://lkml.kernel.org/r/20190704172110.27041-1-efremov@linux.com

-- Steve

> 
> Fixes: f45d1225adb0 ("tracing: Kernel access to Ftrace instances")
> Cc: Divya Indi <divya.indi@oracle.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  include/linux/trace_events.h | 1 +
>  kernel/trace/trace_events.c  | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
> index 5150436783e8..30a8cdcfd4a4 100644
> --- a/include/linux/trace_events.h
> +++ b/include/linux/trace_events.h
> @@ -548,6 +548,7 @@ extern int trace_event_get_offsets(struct trace_event_call *call);
>  
>  #define is_signed_type(type)	(((type)(-1)) < (type)1)
>  
> +int ftrace_set_clr_event(struct trace_array *tr, char *buf, int set);
>  int trace_set_clr_event(const char *system, const char *event, int set);
>  
>  /*
> diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
> index 5a189fb8ec23..b89cdfe20bc1 100644
> --- a/kernel/trace/trace_events.c
> +++ b/kernel/trace/trace_events.c
> @@ -787,7 +787,7 @@ static int __ftrace_set_clr_event(struct trace_array *tr, const char *match,
>  	return ret;
>  }
>  
> -static int ftrace_set_clr_event(struct trace_array *tr, char *buf, int set)
> +int ftrace_set_clr_event(struct trace_array *tr, char *buf, int set)
>  {
>  	char *event = NULL, *sub = NULL, *match;
>  	int ret;

