Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84284C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 17:21:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56D1121773
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 17:21:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="EIUgStH2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404642AbfHBRVL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 13:21:11 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34846 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404609AbfHBRVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 13:21:09 -0400
Received: by mail-wr1-f68.google.com with SMTP id y4so77956677wrm.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2019 10:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=k7XXhuFhbeAXylvqHKe+SPxiEDLJJ/8J0ggCvzHZXcU=;
        b=EIUgStH2DoDr21rshDUNKpj6TBTjmp8CsMm0kFgYgmAY9rTMLbaBKjMgj/hwK8uKqb
         s8xhNITkdqAJluVpwDKBl0sJVtXBH6mf/DTp8MHACchcX6p5GyqtUGJ1WSLKBDuos+7G
         0WBDCUcMuJdJ4JPrLSVKK+SQS8SSJl+Y8cMZP7FW2RfjOmMXHY65RPgmP/d2g3HcwQ8O
         aaMvnmVsE/Q6G7yH1QTqamGp7fCbLfqHcI9h84ac1LlfXx38KJb62Gkw9RXLUyb3cxXt
         UrHR5oZOQa42ryZLxbdXufbPgGnOGgohozxHXR5vm3d6ehe6E2EcG7wt7am2xaoaxOdy
         dgKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=k7XXhuFhbeAXylvqHKe+SPxiEDLJJ/8J0ggCvzHZXcU=;
        b=fPOAMIzwuCJHBVr/aj3ragdobTaywfVrNYaf3/1Uelu+OeVEv317YX8/v443vvaRon
         w1gyQkWMfFfBhkIhRLDO9ETsc/d/QQePQfaHPYmy0+eSsze1O5lVunCGrHTpHPUBweMg
         kkjyx2wb8EFC3xNKdMx5YfpX1K867ycI+F/Mjx7ZKCtOscDXMKnr4LJvhE6ROx4YrBEN
         fzodYg+sMbDzmPPrpZw/j1sxJVkAyjhDr5mxn3atNy7YAZ0HUXJeibI3Kwy77LzbXDfc
         JYiOsJKKcwXwPnaqyYqIYn14ZRznYEmFdSW2hSPHjJfxdS+Y/o2NC/ck1GdaWEgEt4AH
         XtJA==
X-Gm-Message-State: APjAAAU6JHhVO+wBPl5le1uxy9PKkhrbesUM3u7r4ZskPHDyaq3sICES
        FF+lMAEvu1PtF31H/kvpSGs=
X-Google-Smtp-Source: APXvYqzDP0EVG14dI+O6+H/eHBOJ6k1rlj1OHd5KX1DVwLlMZZW1ahk3gfVCGe+g53WZGSAhCo2WTQ==
X-Received: by 2002:adf:e843:: with SMTP id d3mr2906477wrn.249.1564766466906;
        Fri, 02 Aug 2019 10:21:06 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:210:e751:37a0:1e95:e65d])
        by smtp.gmail.com with ESMTPSA id f70sm104873631wme.22.2019.08.02.10.21.05
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 02 Aug 2019 10:21:06 -0700 (PDT)
Date:   Fri, 2 Aug 2019 18:21:04 +0100
From:   Alessio Balsini <balsini@android.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, juri.lelli@redhat.com,
        linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        luca.abeni@santannapisa.it, bristot@redhat.com, dvyukov@google.com,
        tglx@linutronix.de, vpillai@digitalocean.com, rostedt@goodmis.org
Subject: Re: [RFC][PATCH 01/13] sched/deadline: Impose global limits on
 sched_attr::sched_period
Message-ID: <20190802172104.GA134279@google.com>
References: <20190726145409.947503076@infradead.org>
 <20190726161357.397880775@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190726161357.397880775@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

This is indeed an important missing piece.

I think it would be worth having some simple checks, e.g.:
- period_min <= period_max;
- period_min >= (1ULL << DL_SCALE).

To be even more picky, I'm wondering if it would be a good practice to
fail the write operation if there are already dl-tasks in the system
that violate the new constraint.  I'm afraid there is no cheap way of
achieving such check, so, I think we can skip this last tricky thing for
now.

Thanks,
Alessio

On Fri, Jul 26, 2019 at 04:54:10PM +0200, Peter Zijlstra wrote:
> 
> Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
> Cc: Luca Abeni <luca.abeni@santannapisa.it>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  include/linux/sched/sysctl.h |    3 +++
>  kernel/sched/deadline.c      |   23 +++++++++++++++++++++--
>  kernel/sysctl.c              |   14 ++++++++++++++
>  3 files changed, 38 insertions(+), 2 deletions(-)
> 
> --- a/include/linux/sched/sysctl.h
> +++ b/include/linux/sched/sysctl.h
> @@ -56,6 +56,9 @@ int sched_proc_update_handler(struct ctl
>  extern unsigned int sysctl_sched_rt_period;
>  extern int sysctl_sched_rt_runtime;
>  
> +extern unsigned int sysctl_sched_dl_period_max;
> +extern unsigned int sysctl_sched_dl_period_min;
> +
>  #ifdef CONFIG_UCLAMP_TASK
>  extern unsigned int sysctl_sched_uclamp_util_min;
>  extern unsigned int sysctl_sched_uclamp_util_max;
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -2597,6 +2597,14 @@ void __getparam_dl(struct task_struct *p
>  }
>  
>  /*
> + * Default limits for DL period; on the top end we guard against small util
> + * tasks still getting rediculous long effective runtimes, on the bottom end we
> + * guard against timer DoS.
> + */
> +unsigned int sysctl_sched_dl_period_max = 1 << 22; /* ~4 seconds */
> +unsigned int sysctl_sched_dl_period_min = 100;     /* 100 us */
> +
> +/*
>   * This function validates the new parameters of a -deadline task.
>   * We ask for the deadline not being zero, and greater or equal
>   * than the runtime, as well as the period of being zero or
> @@ -2608,6 +2616,8 @@ void __getparam_dl(struct task_struct *p
>   */
>  bool __checkparam_dl(const struct sched_attr *attr)
>  {
> +	u64 period, max, min;
> +
>  	/* special dl tasks don't actually use any parameter */
>  	if (attr->sched_flags & SCHED_FLAG_SUGOV)
>  		return true;
> @@ -2631,12 +2641,21 @@ bool __checkparam_dl(const struct sched_
>  	    attr->sched_period & (1ULL << 63))
>  		return false;
>  
> +	period = attr->sched_period;
> +	if (!period)
> +		period = attr->sched_deadline;
> +
>  	/* runtime <= deadline <= period (if period != 0) */
> -	if ((attr->sched_period != 0 &&
> -	     attr->sched_period < attr->sched_deadline) ||
> +	if (period < attr->sched_deadline ||
>  	    attr->sched_deadline < attr->sched_runtime)
>  		return false;
>  
> +	max = (u64)READ_ONCE(sysctl_sched_dl_period_max) * NSEC_PER_USEC;
> +	min = (u64)READ_ONCE(sysctl_sched_dl_period_min) * NSEC_PER_USEC;
> +
> +	if (period < min || period > max)
> +		return false;
> +
>  	return true;
>  }
>  
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -443,6 +443,20 @@ static struct ctl_table kern_table[] = {
>  		.proc_handler	= sched_rt_handler,
>  	},
>  	{
> +		.procname	= "sched_deadline_period_max_us",
> +		.data		= &sysctl_sched_dl_period_max,
> +		.maxlen		= sizeof(unsigned int),
> +		.mode		= 0644,
> +		.proc_handler	= proc_dointvec,
> +	},
> +	{
> +		.procname	= "sched_deadline_period_min_us",
> +		.data		= &sysctl_sched_dl_period_min,
> +		.maxlen		= sizeof(unsigned int),
> +		.mode		= 0644,
> +		.proc_handler	= proc_dointvec,
> +	},
> +	{
>  		.procname	= "sched_rr_timeslice_ms",
>  		.data		= &sysctl_sched_rr_timeslice,
>  		.maxlen		= sizeof(int),
> 
> 
