Return-Path: <SRS0=6aFo=TE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BACAC43219
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 16:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28A43205C9
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 16:47:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="k7XBhL8c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbfEDQrN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 May 2019 12:47:13 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33282 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726217AbfEDQrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 May 2019 12:47:13 -0400
Received: by mail-pg1-f193.google.com with SMTP id k19so4291137pgh.0
        for <linux-kernel@vger.kernel.org>; Sat, 04 May 2019 09:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iOjZV9PSSRl0bVJzHlyqakIGIVKpkRTY5TVtwEOyWCc=;
        b=k7XBhL8cal8SNiBFGLQcBDHBWmyyz0mWap57Z5Io442A5Y9lU3//9law5zcEBNIzn9
         KqLNRToBRRfN33RkUvdf99BUb/8sbTZrdDpEEuqha7b6dCAevwqKbIk0Oxd2B/D30R4J
         lNhlmS/+L+BtSAvqQ49vjhLP+x8D79Vgndu3Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iOjZV9PSSRl0bVJzHlyqakIGIVKpkRTY5TVtwEOyWCc=;
        b=PjZhozBReY2cuLD3V8xRHjdDrQeICjdMNrlq46L0gNzve7j76/sMQ8lt6tp0muSHQy
         L+HryaIdLsYs1FYSA5BxTFMnTE/PJD/F1SLOM5JYGYN2/hTj1E4A0TyKqJOPiISZsbPb
         0BPYRL0zZHa4IQj8upa7vvsghzv0v9pXqLkas2F/zLUjnuQX6n5Jt3KE8Am0pFIqqbF+
         e/8kHWw/0EWHt1/7E7TkWswxG5SnmVFkdxuMSAw+PvS+7ZUvylL8Vql9Wde/N+apEwj+
         4GanfM4FsdkBCDi6yiHRJdr+SN0DP79gzlktBCiPpZ8+IDRyeh7Zr+NzBKcrmOqruCeV
         NDug==
X-Gm-Message-State: APjAAAWQqWP9ouvpvln4G8nQl2Ig0V2d+V/mj53cvizdnvl71SHjtUth
        FU3556s/nR7sofE671UOwv493Q==
X-Google-Smtp-Source: APXvYqxibvNPdEYbBr/wruIghmHZuNCeeZKEnb6Y+cS+NwZAvG9iyOMTgd2FhORTypQX4UarjvXRpQ==
X-Received: by 2002:a63:ee15:: with SMTP id e21mr19977248pgi.180.1556988432727;
        Sat, 04 May 2019 09:47:12 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id c17sm7026957pfn.173.2019.05.04.09.47.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 04 May 2019 09:47:11 -0700 (PDT)
Date:   Sat, 4 May 2019 12:47:10 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Viktor Rosendahl <viktor.rosendahl@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] ftrace: Implement fs notification for
 preempt/irqsoff tracers
Message-ID: <20190504164710.GA55790@google.com>
References: <20190501203650.29548-1-viktor.rosendahl@gmail.com>
 <20190501203650.29548-2-viktor.rosendahl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190501203650.29548-2-viktor.rosendahl@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 01, 2019 at 10:36:47PM +0200, Viktor Rosendahl wrote:
> This patch implements the feature that the trace file, e.g.
> /sys/kernel/debug/tracing/trace will receive notifications through
> the fsnotify framework when a new trace is available.
> 
> This makes it possible to implement a user space program that can,
> with equal probability, obtain traces of latencies that occur
> immediately after each other in spite of the fact that the
> preempt/irqsoff tracers operate in overwrite mode.
> 
> Signed-off-by: Viktor Rosendahl <viktor.rosendahl@gmail.com>

I agree with the general idea, but I don't really like how it is done in the
patch.

We do have a notification mechanism already in the form of trace_pipe. Can we
not improve that in some way to be notified of a new trace data? In theory,
the trace_pipe does fit into the description in the documentation: "Reads
from this file will block until new data is retrieved"

More comment below:

> ---
>  kernel/trace/Kconfig         | 10 ++++++++++
>  kernel/trace/trace.c         | 31 +++++++++++++++++++++++++++++--
>  kernel/trace/trace.h         |  5 +++++
>  kernel/trace/trace_irqsoff.c | 35 +++++++++++++++++++++++++++++++++++
>  4 files changed, 79 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
> index 8bd1d6d001d7..35e5fd3224f6 100644
> --- a/kernel/trace/Kconfig
> +++ b/kernel/trace/Kconfig
> @@ -234,6 +234,16 @@ config PREEMPT_TRACER
>  	  enabled. This option and the irqs-off timing option can be
>  	  used together or separately.)
>  
> +	config PREEMPTIRQ_FSNOTIFY
> +	bool "Generate fsnotify events for the latency tracers"
> +	default n
> +	depends on (IRQSOFF_TRACER || PREEMPT_TRACER) && FSNOTIFY
> +	help
> +	  This option will enable the generation of fsnotify events for the
> +	  trace file. This makes it possible for userspace to be notified about
> +	  modification of /sys/kernel/debug/tracing/trace through the inotify
> +	  interface.

Does this have to be a CONFIG option? If prefer if the code automatically
does the notification and it is always enabled. I don't see any drawbacks of
that.

> +
>  config SCHED_TRACER
>  	bool "Scheduling Latency Tracer"
>  	select GENERIC_TRACER
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index ca1ee656d6d8..ebefb8d4e072 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -44,6 +44,8 @@
>  #include <linux/trace.h>
>  #include <linux/sched/clock.h>
>  #include <linux/sched/rt.h>
> +#include <linux/fsnotify.h>
> +#include <linux/workqueue.h>
>  
>  #include "trace.h"
>  #include "trace_output.h"
> @@ -8191,6 +8193,32 @@ static __init void create_trace_instances(struct dentry *d_tracer)
>  		return;
>  }
>  
> +#ifdef CONFIG_PREEMPTIRQ_FSNOTIFY
> +
> +static void trace_notify_workfn(struct work_struct *work)
[snip]

I prefer if this facility is available to other tracers as well such as
the wakeup tracer which is similar in output (check
Documentation/trace/ftrace.txt). I believe this should be a generic trace
facility, and not tracer specific.

thanks,

 - Joel

