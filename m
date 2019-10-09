Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3246BC47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 14:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBF7721848
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 14:11:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="VD4XjLev"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731158AbfJIOLR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 10:11:17 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37408 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728019AbfJIOLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 10:11:17 -0400
Received: by mail-pg1-f194.google.com with SMTP id p1so1498543pgi.4
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 07:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+mFbWcHOtLkcPIpKjDWssxMGrTFkKewgx7PhF9+Sg58=;
        b=VD4XjLevQ4JC+RcPKoUOu8mWdiKJFyeRQJxdx6eRXsI3eVnU8qo17NfexPPIf9BGnv
         i9PGTrvTsAHBagABhxlJjEOJeGurIVgjJl8bLBZwHCga6Qk2n9JX6t912hLGeIlX3zqx
         8WlDrndE6qX8GpESc1FpJMAHwC9LkDUuqctmk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+mFbWcHOtLkcPIpKjDWssxMGrTFkKewgx7PhF9+Sg58=;
        b=fRbALOPbVDCrharCznO0ZDqUBFLNeK4vYtgQse4jBe+3ivzwPazqziAKD5sdd06vfX
         AzDHNQZn0OEX53XjE8ZJUZbezzfRALqUrXCvQo9l2loQ2dgvh3pGUoxBOnZOri8DXtxk
         93qcm8gCeud+aMQWtn3vrwY8L9ojo3RpyoQjXF8bLEPuQ3TQPZ8GBqowtzd2cc5JzWbF
         c1g7K9sDtFm5ky55nqzXQ/wXs+9qtnup86mQZ/AlzCK/H794ZiXIrgoPwalqdhSE9L7/
         ShvXbDz5gYKlvTY0HaADe94bW93ug5kxhhlvpvvm+4q/tnokO9BFRpz4Ou9awES81cwZ
         mARw==
X-Gm-Message-State: APjAAAUop9d5KpO0xuJE3Xs2xrnPXZPTmElNjiEvngB8IJ0/Gl53R2PW
        cggoPCP+FjKbkngJMTxsQsyzhQ==
X-Google-Smtp-Source: APXvYqzr1Fxvy4Pq2oGVPPMnE1qU4y1401AWwowkxcxe79xzuV3hRcjLKtFAUILVC9XDDF9tbhoPdA==
X-Received: by 2002:a17:90a:e001:: with SMTP id u1mr4440003pjy.102.1570630275885;
        Wed, 09 Oct 2019 07:11:15 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id 1sm3549964pff.39.2019.10.09.07.11.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 07:11:15 -0700 (PDT)
Date:   Wed, 9 Oct 2019 10:11:14 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Viktor Rosendahl (BMW)" <viktor.rosendahl@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 4/4] ftrace: Add an option for tracing console
 latencies
Message-ID: <20191009141114.GC143258@google.com>
References: <20191008220824.7911-1-viktor.rosendahl@gmail.com>
 <20191008220824.7911-5-viktor.rosendahl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191008220824.7911-5-viktor.rosendahl@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 09, 2019 at 12:08:24AM +0200, Viktor Rosendahl (BMW) wrote:
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
>  kernel/trace/trace_irqsoff.c | 18 ++++++++++++++++++
>  4 files changed, 45 insertions(+), 2 deletions(-)
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
> index ca65327a6de8..f27e96273453 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -2369,6 +2369,7 @@ void console_unlock(void)
>  	static char ext_text[CONSOLE_EXT_LOG_MAX];
>  	static char text[LOG_LINE_MAX + PREFIX_MAX];
>  	unsigned long flags;
> +	bool cflag;
>  	bool do_cond_resched, retry;
>  
>  	if (console_suspended) {
> @@ -2469,9 +2470,10 @@ void console_unlock(void)
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
> index 591c7a873235..10d12c8f7f77 100644
> --- a/kernel/trace/trace.h
> +++ b/kernel/trace/trace.h
> @@ -1261,6 +1261,7 @@ extern int trace_get_user(struct trace_parser *parser, const char __user *ubuf,
>  		C(PRINTK_MSGONLY,	"printk-msg-only"),	\
>  		C(CONTEXT_INFO,		"context-info"),   /* Print pid/cpu/time */ \
>  		C(LATENCY_FMT,		"latency-format"),	\
> +		C(CONSOLE_LATENCY,	"console-latency"),	\
>  		C(RECORD_CMD,		"record-cmd"),		\
>  		C(RECORD_TGID,		"record-tgid"),		\
>  		C(OVERWRITE,		"overwrite"),		\
> diff --git a/kernel/trace/trace_irqsoff.c b/kernel/trace/trace_irqsoff.c
> index a745b0cee5d3..576e2162114e 100644
> --- a/kernel/trace/trace_irqsoff.c
> +++ b/kernel/trace/trace_irqsoff.c
> @@ -456,6 +456,24 @@ void stop_critical_timings(void)
>  EXPORT_SYMBOL_GPL(stop_critical_timings);
>  NOKPROBE_SYMBOL(stop_critical_timings);
>  
> +bool console_tracing_disabled(void)
> +{
> +	struct trace_array *tr = irqsoff_trace;
> +	int pc = preempt_count();
> +
> +	/*
> +	 * If tracing is disabled, then the question of whether to trace console
> +	 * latencies is moot. By always returning false here we save the caller
> +	 * the calls to start/stop_critical_timings(). These calls would not do
> +	 * anything anyway.
> +	 */

I thought you were going to drop this patch, or at least I had suggested so
but did not hear a reply from you: https://lkml.org/lkml/2019/10/3/464

Thanks for adding the comments though.

Steve, what do you think about this patch? I am worried the extra flag may go
obsolete at some point if the console latencies are fixed and we have yet
another knob.

thanks,

 - Joel

> +	if (!preempt_trace(pc) && !irq_trace())
> +		return false;
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
