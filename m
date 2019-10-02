Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B22C352AA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 00:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1095B2070B
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 00:52:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="KQAO4Jr+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728984AbfJBAws (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 20:52:48 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35649 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726931AbfJBAwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 20:52:47 -0400
Received: by mail-pg1-f195.google.com with SMTP id a24so10937967pgj.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 17:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=70/W9gKzz84ik3OLrErwLcPZqAS4RmoZ1znosTRg9IQ=;
        b=KQAO4Jr+CC0jw28EqURE+RHJZNYabXy19zk4Fcmlv7BerQdYYF06t4yYyNQ7EAsh2l
         8SKvh7VO3v8vXLOkLx4vrY7QWNXmhjUSyqE6c+OplOjyI3F1EtWlJgTcPC6FpAthLGYT
         vGH8NzweqTIdZ57cDvI+FZsC+1b8LrhRSXC5I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=70/W9gKzz84ik3OLrErwLcPZqAS4RmoZ1znosTRg9IQ=;
        b=J9wH/6zFgCQwB6yeZRNyscdx9XUAm+R/KM4UX2H9MfhLOYSKH/HM4peb1hujsbPOun
         IaPUgKVyBvhn34185IYoczTlVT/xY6O/h5hNxgTvwcbYRsvlu2oDpuq7KA3cj0ty+PPw
         T7X4MNZAaxKh8R/30tAqdp47xBfI99vLsd6/wmswKJBEYqOQWKwqoZSL4eIKd9aJCFhm
         +rs33mTMCuNiu3sHwIblHrSR5qmIha1NE3zUP+VPB6upp24HdKePWMchkoNIZMn9D/nO
         chnktFBDb0SvZZ+QbuDk5MSHay9dBmxmjb4mBfmotX0SrwhxbUZ5DUL42oc5Yg2DAbHN
         HIGQ==
X-Gm-Message-State: APjAAAVfsKRvcTI/+u4mcWVCDok9BhyC2dOepTX8gXekd+vRJDY+r04h
        oCLrpG9FWiFZxMzWuBP6GemDzADzPHg=
X-Google-Smtp-Source: APXvYqyZRA1Urt67VdHky+Wtwh0nA9ZGikuPQDHDxs4MKvKdjT6YyMAPBbV7JpGk3IaCCgglcUcI4A==
X-Received: by 2002:a63:e116:: with SMTP id z22mr785072pgh.424.1569977566642;
        Tue, 01 Oct 2019 17:52:46 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id i74sm22467853pfe.28.2019.10.01.17.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 17:52:45 -0700 (PDT)
Date:   Tue, 1 Oct 2019 20:52:44 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Viktor Rosendahl (BMW)" <viktor.rosendahl@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 4/4] ftrace: Add an option for tracing console
 latencies
Message-ID: <20191002005244.GC161396@google.com>
References: <20190920152219.12920-1-viktor.rosendahl@gmail.com>
 <20190920152219.12920-5-viktor.rosendahl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190920152219.12920-5-viktor.rosendahl@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 20, 2019 at 05:22:19PM +0200, Viktor Rosendahl (BMW) wrote:
> This new trace option "console-latency" will enable the latency
> tracers to trace the console latencies. Previously this has always been
> implicitely disabled. I guess this is because they are considered
> to be well known and unavoidable.
> 
> However, for some organizations it may nevertheless be desirable to
> trace them. Basically, we want to be able to tell that there are
> latencies in the system under test because someone has incorrectly
> enabled the serial console.
> 
> Signed-off-by: Viktor Rosendahl (BMW) <viktor.rosendahl@gmail.com>
> ---
>  include/linux/irqflags.h     | 22 ++++++++++++++++++++++
>  kernel/printk/printk.c       |  6 ++++--
>  kernel/trace/trace.h         |  1 +
>  kernel/trace/trace_irqsoff.c | 12 ++++++++++++
>  4 files changed, 39 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/irqflags.h b/include/linux/irqflags.h
> index 21619c92c377..3de891723331 100644
> --- a/include/linux/irqflags.h
> +++ b/include/linux/irqflags.h
> @@ -13,6 +13,7 @@
>  #define _LINUX_TRACE_IRQFLAGS_H
>  
>  #include <linux/typecheck.h>
> +#include <linux/types.h>
>  #include <asm/irqflags.h>
>  
>  /* Currently trace_softirqs_on/off is used only by lockdep */
> @@ -68,9 +69,30 @@ do {						\
>  	defined(CONFIG_PREEMPT_TRACER)
>   extern void stop_critical_timings(void);
>   extern void start_critical_timings(void);
> + extern bool console_tracing_disabled(void);
> +
> +# define console_stop_critical_timings(flag)		\
> +	do {						\
> +		typecheck(bool, flag);			\
> +		flag = console_tracing_disabled();	\
> +		if (flag)				\
> +			stop_critical_timings();	\
> +	} while (0)
> +
> +# define console_start_critical_timings(flag)		 \
> +	do {						 \
> +		typecheck(bool, flag);			 \
> +		if (flag)				 \
> +			start_critical_timings();	 \
> +	} while (0)
> +
>  #else
>  # define stop_critical_timings() do { } while (0)
>  # define start_critical_timings() do { } while (0)
> +# define console_stop_critical_timings(flag)	\
> +	do { typecheck(bool, flag); } while (0)
> +# define console_start_critical_timings(flag)	\
> +	do { typecheck(bool, flag); } while (0)
>  #endif
>  
>  /*
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 1888f6a3b694..036460a7e4cd 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -2359,6 +2359,7 @@ void console_unlock(void)
>  	static char ext_text[CONSOLE_EXT_LOG_MAX];
>  	static char text[LOG_LINE_MAX + PREFIX_MAX];
>  	unsigned long flags;
> +	bool cflag;
>  	bool do_cond_resched, retry;
>  
>  	if (console_suspended) {
> @@ -2459,9 +2460,10 @@ void console_unlock(void)
>  		 */
>  		console_lock_spinning_enable();
>  
> -		stop_critical_timings();	/* don't trace print latency */
> +		/* don't trace print latency if it's disabled */
> +		console_stop_critical_timings(cflag);
>  		call_console_drivers(ext_text, ext_len, text, len);
> -		start_critical_timings();
> +		console_start_critical_timings(cflag);
>  
>  		if (console_lock_spinning_disable_and_check()) {
>  			printk_safe_exit_irqrestore(flags);
> diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
> index 4913ed1138aa..93a8b82c27e4 100644
> --- a/kernel/trace/trace.h
> +++ b/kernel/trace/trace.h
> @@ -1262,6 +1262,7 @@ extern int trace_get_user(struct trace_parser *parser, const char __user *ubuf,
>  		C(PRINTK_MSGONLY,	"printk-msg-only"),	\
>  		C(CONTEXT_INFO,		"context-info"),   /* Print pid/cpu/time */ \
>  		C(LATENCY_FMT,		"latency-format"),	\
> +		C(CONSOLE_LATENCY,	"console-latency"),	\
>  		C(RECORD_CMD,		"record-cmd"),		\
>  		C(RECORD_TGID,		"record-tgid"),		\
>  		C(OVERWRITE,		"overwrite"),		\
> diff --git a/kernel/trace/trace_irqsoff.c b/kernel/trace/trace_irqsoff.c
> index a745b0cee5d3..bc02be207a7a 100644
> --- a/kernel/trace/trace_irqsoff.c
> +++ b/kernel/trace/trace_irqsoff.c
> @@ -456,6 +456,18 @@ void stop_critical_timings(void)
>  EXPORT_SYMBOL_GPL(stop_critical_timings);
>  NOKPROBE_SYMBOL(stop_critical_timings);
>  
> +bool console_tracing_disabled(void)
> +{
> +	struct trace_array *tr = irqsoff_trace;
> +	int pc = preempt_count();
> +
> +	if (!preempt_trace(pc) && !irq_trace())
> +		return false;

Why this condition here? Why not just make the call to
stop_critical_timings() dependent on the new flag you are adding? Please
explain it more and add some comments.

thanks,

 - Joel


> +
> +	return !(tr->trace_flags & TRACE_ITER_CONSOLE_LATENCY);
> +}
> +EXPORT_SYMBOL_GPL(console_tracing_disabled);
> +
>  #ifdef CONFIG_FUNCTION_TRACER
>  static bool function_enabled;
>  
> -- 
> 2.17.1
> 
