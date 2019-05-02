Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8A63C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 01:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B9E22085A
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 01:39:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbfEBBjC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 21:39:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:46654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726139AbfEBBjC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 21:39:02 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 532BC2085A;
        Thu,  2 May 2019 01:39:00 +0000 (UTC)
Date:   Wed, 1 May 2019 21:38:57 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Viktor Rosendahl <viktor.rosendahl@gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH v2 4/4] ftrace: Add an option for tracing console
 latencies
Message-ID: <20190501213857.157e3741@oasis.local.home>
In-Reply-To: <20190501203650.29548-5-viktor.rosendahl@gmail.com>
References: <20190501203650.29548-1-viktor.rosendahl@gmail.com>
        <20190501203650.29548-5-viktor.rosendahl@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  1 May 2019 22:36:50 +0200
Viktor Rosendahl <viktor.rosendahl@gmail.com> wrote:

> This new option CONFIG_TRACE_CONSOLE_LATENCY will enable the latency
> tracers to trace the console latencies. Previously this has always been
> implicitely disabled. I guess this is because they are considered
> to be well known and unavoidable.
> 
> However, for some organizations it may nevertheless be desirable to
> trace them. Basically, we want to be able to tell that there are
> latencies in the system under test because someone has incorrectly
> enabled the serial console.
> 

I'd rather have this be a tracing option than a config one.

> Signed-off-by: Viktor Rosendahl <viktor.rosendahl@gmail.com>
> ---
>  include/linux/irqflags.h | 13 +++++++++++++
>  kernel/printk/printk.c   |  5 +++--
>  kernel/trace/Kconfig     | 11 +++++++++++
>  3 files changed, 27 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/irqflags.h b/include/linux/irqflags.h
> index 21619c92c377..791bee718448 100644
> --- a/include/linux/irqflags.h
> +++ b/include/linux/irqflags.h
> @@ -73,6 +73,19 @@ do {						\
>  # define start_critical_timings() do { } while (0)
>  #endif
>  
> +#ifdef CONFIG_TRACE_CONSOLE_LATENCY
> +
> +#define console_stop_critical_timings()  do {} while (0)
> +#define console_start_critical_timings() do {} while (0)
> +
> +#else /* !CONFIG_TRACE_CONSOLE_LATENCY */
> +
> +/* don't trace print latency */
> +#define console_stop_critical_timings()  stop_critical_timings()
> +#define console_start_critical_timings() start_critical_timings()

Instead of this being turned into a nop, don't have a kconfig option
but instead have this call into the trace_irqsoff.c code, and depending
on what the options are, it should stop it. Of course, this would need
to be smart enough to pair it. Perhaps return the result of
console_stop_critical_timings() and have that passed to
console_start_critical_timings(), and only have start do something if
stop did something. This way the option only needs to disable the stop
part.

-- Steve

> +
> +#endif /* !CONFIG_TRACE_CONSOLE_LATENCY */
> +
>  /*
>   * Wrap the arch provided IRQ routines to provide appropriate checks.
>   */
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 02ca827b8fac..710e87f61158 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -2448,9 +2448,10 @@ void console_unlock(void)
>  		 */
>  		console_lock_spinning_enable();
>  
> -		stop_critical_timings();	/* don't trace print
> latency */
> +		/* don't trace print latency if it's disabled */
> +		console_stop_critical_timings();
>  		call_console_drivers(ext_text, ext_len, text, len);
> -		start_critical_timings();
> +		console_start_critical_timings();
>  
>  		if (console_lock_spinning_disable_and_check()) {
>  			printk_safe_exit_irqrestore(flags);
> diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
> index e5e8f2a0199e..f168d100d4fb 100644
> --- a/kernel/trace/Kconfig
> +++ b/kernel/trace/Kconfig
> @@ -244,6 +244,17 @@ config PREEMPT_TRACER
>  	  modification of /sys/kernel/debug/tracing/trace through
> the inotify interface.
>  
> +	config TRACE_CONSOLE_LATENCY
> +	bool "Do not turn off latency tracing for the console"
> +	default n
> +	depends on IRQSOFF_TRACER || PREEMPT_TRACER
> +	help
> +	  Some of the console drivers will cause long unavoidable
> +	  latencies because they are slow and need to print
> immediately
> +	  in a serialized manner. Because of this their latencies
> are not
> +	  traced by default. This option will change behavior so that
> +	  they are traced.
> +
>  config SCHED_TRACER
>  	bool "Scheduling Latency Tracer"
>  	select GENERIC_TRACER

