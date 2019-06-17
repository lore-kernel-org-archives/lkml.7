Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2185FC31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 23:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F22C6208C0
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 23:34:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729128AbfFQXeR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 19:34:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:37808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727821AbfFQXeR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 19:34:17 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2788208C0;
        Mon, 17 Jun 2019 23:34:15 +0000 (UTC)
Date:   Mon, 17 Jun 2019 19:34:14 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Divya Indi <divya.indi@oracle.com>
Cc:     linux-kernel@vger.kernel.org,
        Srinivas Eeda <srinivas.eeda@oracle.com>,
        Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
Subject: Re: [PATCH 1/3] tracing: Relevant changes for kernel access to
 Ftrace instances.
Message-ID: <20190617193414.6bc6d5e4@gandalf.local.home>
In-Reply-To: <1560357259-3497-2-git-send-email-divya.indi@oracle.com>
References: <1560357259-3497-1-git-send-email-divya.indi@oracle.com>
        <1560357259-3497-2-git-send-email-divya.indi@oracle.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jun 2019 09:34:17 -0700
Divya Indi <divya.indi@oracle.com> wrote:

Hi Divya,

First, make sure the patches are all replied to the cover patch [0/3].
That is, patch 1, 2 and 3 should all be in reply to [0/3] to see a all
the patches at the same level, and that makes replies easy to stand out.

Having patch 2 a reply to patch 1 and patch 3 a reply to patch 2, makes
it hard to see what comments are for what patches.

> For commit f45d1225adb0 ("tracing: Kernel access to Ftrace instances")
> Adding the following changes to ensure other kernel components can
> use these functions -
> 1) Remove static keyword for newly exported fn - ftrace_set_clr_event.
> 2) Add the req functions to header file include/linux/trace_events.h.

The above change log is hard to parse. The "Adding" looks to be a start
of a new sentence, and what changes and what components can use these
functions?

Also avoid shorten words ("fn", "req") that just makes trying to figure
out what is being said that more confusing.

> 
> Signed-off-by: Divya Indi <divya.indi@oracle.com>
> ---
>  include/linux/trace_events.h | 6 ++++++
>  kernel/trace/trace_events.c  | 2 +-
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
> index 8a62731..d7b7d85 100644
> --- a/include/linux/trace_events.h
> +++ b/include/linux/trace_events.h
> @@ -539,6 +539,12 @@ extern int trace_define_field(struct trace_event_call *call, const char *type,
>  
>  #define is_signed_type(type)	(((type)(-1)) < (type)1)
>  
> +void trace_printk_init_buffers(void);
> +int trace_array_printk(struct trace_array *tr, unsigned long ip,
> +		const char *fmt, ...);
> +struct trace_array *trace_array_create(const char *name);
> +int trace_array_destroy(struct trace_array *tr);
> +int ftrace_set_clr_event(struct trace_array *tr, char *buf, int set);

These function are declared elsewhere. If we are adding them here, then
they should be removed from the other places.

But trace_events.h is not the proper place to put these. The
trace_events.h file is only for code used in the TRACE_EVENT() macros.

The proper file is include/linux/trace.h

-- Steve

>  int trace_set_clr_event(const char *system, const char *event, int set);
>  
>  /*
> diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
> index 0ce3db6..b6b4618 100644
> --- a/kernel/trace/trace_events.c
> +++ b/kernel/trace/trace_events.c
> @@ -795,7 +795,7 @@ static int __ftrace_set_clr_event(struct trace_array *tr, const char *match,
>  	return ret;
>  }
>  
> -static int ftrace_set_clr_event(struct trace_array *tr, char *buf, int set)
> +int ftrace_set_clr_event(struct trace_array *tr, char *buf, int set)
>  {
>  	char *event = NULL, *sub = NULL, *match;
>  	int ret;

