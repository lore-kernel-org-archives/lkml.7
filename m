Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 363CEC7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 15:21:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10A1C216C8
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 15:21:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728756AbfG2PVa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 11:21:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:38196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728023AbfG2PV3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 11:21:29 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B6052064A;
        Mon, 29 Jul 2019 15:21:27 +0000 (UTC)
Date:   Mon, 29 Jul 2019 11:21:26 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Eiichi Tsukata <devel@etsukata.com>
Cc:     joel@joelfernandes.org, paulmck@linux.vnet.ibm.com,
        tglx@linutronix.de, peterz@infradead.org, mingo@redhat.com,
        fweisbec@gmail.com, luto@amacapital.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: Prevent RCU EQS breakage in preemptirq events
Message-ID: <20190729112126.6554b141@gandalf.local.home>
In-Reply-To: <20190729010734.3352-1-devel@etsukata.com>
References: <20190729010734.3352-1-devel@etsukata.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Jul 2019 10:07:34 +0900
Eiichi Tsukata <devel@etsukata.com> wrote:

> If context tracking is enabled, causing page fault in preemptirq
> irq_enable or irq_disable events triggers the following RCU EQS warning.
> 
> Reproducer:
> 
>   // CONFIG_PREEMPTIRQ_EVENTS=y
>   // CONFIG_CONTEXT_TRACKING=y
>   // CONFIG_RCU_EQS_DEBUG=y
>   # echo 1 > events/preemptirq/irq_disable/enable
>   # echo 1 > options/userstacktrace

So the problem is only with userstacktrace enabled?


>  }
> diff --git a/kernel/trace/trace_preemptirq.c b/kernel/trace/trace_preemptirq.c
> index 4d8e99fdbbbe..031b51cb94d0 100644
> --- a/kernel/trace/trace_preemptirq.c
> +++ b/kernel/trace/trace_preemptirq.c
> @@ -10,6 +10,7 @@
>  #include <linux/module.h>
>  #include <linux/ftrace.h>
>  #include <linux/kprobes.h>
> +#include <linux/context_tracking.h>
>  #include "trace.h"
>  
>  #define CREATE_TRACE_POINTS
> @@ -49,9 +50,14 @@ NOKPROBE_SYMBOL(trace_hardirqs_off);
>  
>  __visible void trace_hardirqs_on_caller(unsigned long caller_addr)
>  {
> +	enum ctx_state prev_state;
> +
>  	if (this_cpu_read(tracing_irq_cpu)) {
> -		if (!in_nmi())
> +		if (!in_nmi()) {

This is a very high fast path (for tracing irqs off and such). Instead
of adding a check here for a case that is seldom used (userstacktrace
and tracing irqs on/off). Move this to surround the userstack trace
code.

-- Steve


> +			prev_state = exception_enter();
>  			trace_irq_enable_rcuidle(CALLER_ADDR0, caller_addr);
> +			exception_exit(prev_state);
> +		}
>  		tracer_hardirqs_on(CALLER_ADDR0, caller_addr);
>  		this_cpu_write(tracing_irq_cpu, 0);
>  	}
> @@ -63,11 +69,16 @@ NOKPROBE_SYMBOL(trace_hardirqs_on_caller);
>  
>  __visible void trace_hardirqs_off_caller(unsigned long caller_addr)
>  {
> +	enum ctx_state prev_state;
> +
>  	if (!this_cpu_read(tracing_irq_cpu)) {
>  		this_cpu_write(tracing_irq_cpu, 1);
>  		tracer_hardirqs_off(CALLER_ADDR0, caller_addr);
> -		if (!in_nmi())
> +		if (!in_nmi()) {
> +			prev_state = exception_enter();
>  			trace_irq_disable_rcuidle(CALLER_ADDR0, caller_addr);
> +			exception_exit(prev_state);
> +		}
>  	}
>  
>  	lockdep_hardirqs_off(CALLER_ADDR0);

