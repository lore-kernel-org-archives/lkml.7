Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B77BC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 14:17:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D579321670
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 14:17:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="f3/uq4qe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394261AbfIFORn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 10:17:43 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42065 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392868AbfIFORm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 10:17:42 -0400
Received: by mail-pf1-f193.google.com with SMTP id w22so4573512pfi.9
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2019 07:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LjB0p82HtxamYr+kjSw4gNDGEZhH+nkuBrY/kAED5y4=;
        b=f3/uq4qecC9tZAlictDuGsE4rzKz1ehb8xd/sYNHBUX8Tle3x0zs95YTnFxIsxKGL7
         e7uJc8cifCMnICIUc1YcDLBSKfN+bqKq+NaH4iN7PE3lrrPin+1w7qi34iGQfXBt7wWw
         9uMj5XUiaCDpbtuCuqYzSLJyHlEp0ZoDP3bbQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LjB0p82HtxamYr+kjSw4gNDGEZhH+nkuBrY/kAED5y4=;
        b=bU3TK5QuqdyREUirjt7FQazhogKQuDdXwfhXMl3fLOBwAbI7rwXPQ/NHsMKg3OL6xB
         P6yiznDJX31FN2SeIUyvcq2QPOCYxRfE/btt3bXXd2Y3LKKeh53vwzcfB2Qrj0rBAwY3
         itMKbHdcWuYcQGzR8LBAJ6HR0QvTyQ8LGT2PISRBLdeXQYKkTFKYSSR9psLrQeyXJxGw
         fvjE5vXFQI+jnbnQguyZIUcCUWYjtYKdVUDni+di8e82fAowIyF4qJWotENftPw1hIRP
         dzW4sx0KwcOJhQca3dzr79juvERSlOgKmt3i+Urt0Q3xhMFPfqH2AnOEctnGcfy4+2kD
         k8tA==
X-Gm-Message-State: APjAAAXx3xVrgr2jzJ0g3Ph0fC5hB9ZRF49Urr1gHN1WWhPo1sHppuba
        IUSPUmZ4+egySyeBl1S9C40Hpg==
X-Google-Smtp-Source: APXvYqz7jpgw7++yJdK3qHKrvdRcw+lqNa1H+NDpXBlPpAR5NBiK0Sd2gUIpinMK0gcjqSddgmGwRA==
X-Received: by 2002:a17:90a:b78c:: with SMTP id m12mr10011522pjr.143.1567779461969;
        Fri, 06 Sep 2019 07:17:41 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id dw14sm8190583pjb.2.2019.09.06.07.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2019 07:17:41 -0700 (PDT)
Date:   Fri, 6 Sep 2019 10:17:40 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Viktor Rosendahl <viktor.rosendahl@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/4] ftrace: Implement fs notification for
 tracing_max_latency
Message-ID: <20190906141740.GA250796@google.com>
References: <20190905132548.5116-1-viktor.rosendahl@gmail.com>
 <20190905132548.5116-2-viktor.rosendahl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190905132548.5116-2-viktor.rosendahl@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 05, 2019 at 03:25:45PM +0200, Viktor Rosendahl wrote:
> This patch implements the feature that the tracing_max_latency file,
> e.g. /sys/kernel/debug/tracing/tracing_max_latency will receive
> notifications through the fsnotify framework when a new latency is
> available.
> 
> One particularly interesting use of this facility is when enabling
> threshold tracing, through /sys/kernel/debug/tracing/tracing_thresh,
> together with the preempt/irqsoff tracers. This makes it possible to
> implement a user space program that can, with equal probability,
> obtain traces of latencies that occur immediately after each other in
> spite of the fact that the preempt/irqsoff tracers operate in overwrite
> mode.
> 
> This facility works with the hwlat, preempt/irqsoff, and wakeup
> tracers.
> 
> The tracers may call the latency_fsnotify() from places such as
> __schedule() or do_idle(); this makes it impossible to call
> queue_work() directly without risking a deadlock. The same would
> happen with a softirq,  kernel thread or tasklet. For this reason we
> use the irq_work mechanism to call queue_work().
> Signed-off-by: Viktor Rosendahl <viktor.rosendahl@gmail.com>

Looks better now, one comment below:

> ---
>  kernel/trace/trace.c       | 75 +++++++++++++++++++++++++++++++++++++-
>  kernel/trace/trace.h       | 18 +++++++++
>  kernel/trace/trace_hwlat.c |  4 +-
>  3 files changed, 94 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 563e80f9006a..72ac20c4aaa1 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -44,6 +44,9 @@
>  #include <linux/trace.h>
>  #include <linux/sched/clock.h>
>  #include <linux/sched/rt.h>
> +#include <linux/fsnotify.h>
> +#include <linux/irq_work.h>
> +#include <linux/workqueue.h>
>  
>  #include "trace.h"
>  #include "trace_output.h"
> @@ -1480,6 +1483,74 @@ static ssize_t trace_seq_to_buffer(struct trace_seq *s, void *buf, size_t cnt)
>  
>  unsigned long __read_mostly	tracing_thresh;
>  
> +#if (defined(CONFIG_TRACER_MAX_TRACE) || defined(CONFIG_HWLAT_TRACER)) && \
> +	defined(CONFIG_FSNOTIFY)
> +
> +static const struct file_operations tracing_max_lat_fops;
> +static struct workqueue_struct *fsnotify_wq;
> +
> +static void latency_fsnotify_workfn(struct work_struct *work)
> +{
> +	struct trace_array *tr = container_of(work, struct trace_array,
> +					      fsnotify_work);
> +	fsnotify(tr->d_max_latency->d_inode, FS_MODIFY,
> +		 tr->d_max_latency->d_inode, FSNOTIFY_EVENT_INODE, NULL, 0);
> +}
> +
> +static void latency_fsnotify_workfn_irq(struct irq_work *iwork)
> +{
> +	struct trace_array *tr = container_of(iwork, struct trace_array,
> +					      fsnotify_irqwork);
> +	queue_work(fsnotify_wq, &tr->fsnotify_work);
> +}
> +
> +static void trace_create_maxlat_file(struct trace_array *tr,
> +				     struct dentry *d_tracer)
> +{
> +	INIT_WORK(&tr->fsnotify_work, latency_fsnotify_workfn);
> +	init_irq_work(&tr->fsnotify_irqwork, latency_fsnotify_workfn_irq);
> +	tr->d_max_latency = trace_create_file("tracing_max_latency", 0644,
> +					      d_tracer, &tr->max_latency,
> +					      &tracing_max_lat_fops);
> +}
> +
> +__init static int latency_fsnotify_init(void)
> +{
> +	fsnotify_wq = alloc_workqueue("tr_max_lat_wq",
> +				      WQ_UNBOUND | WQ_HIGHPRI, 0);
> +	if (!fsnotify_wq) {
> +		pr_err("Unable to allocate tr_max_lat_wq\n");
> +		return -ENOMEM;
> +	}

Why not just use the system workqueue instead of adding another workqueue?

thanks,

 - Joel
 
