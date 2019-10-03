Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB2F0C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 13:48:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C33F2133F
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 13:48:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="WbANo6ZY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728988AbfJCNsN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 09:48:13 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37951 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbfJCNsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 09:48:12 -0400
Received: by mail-pf1-f196.google.com with SMTP id h195so1826433pfe.5
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 06:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GNoSIzQCd89aPjGgTt/pnt9YU+gi2oysFDVT+SmjaWA=;
        b=WbANo6ZYadgAvEs0CQuEMKxhEWhvTlUqadyrt++xDLqN9HGcxEMCb78zRv670gwZMN
         m6ui6hbtuHesHM1eLLJbUw7gP9ET74PNt2DNluBHvTGuk6lzRblHZRj0fIw81eKUMAiN
         M1RfuziG/UrCi4olDPUdaiCcgE8SPw892AcTw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GNoSIzQCd89aPjGgTt/pnt9YU+gi2oysFDVT+SmjaWA=;
        b=U4VDIU4ufLiRc3OvWflmSvVcnl6xSDsnqqXLOq0ky5dMCPnRcAfLb9qU8f+bxq2HO2
         12xR061lq/XskjYkbVVFo3M4Wpk6WM9VIOk1OHlSXh7jvZ/pg//rnP4+T3ObClpKbsAR
         fCUuUUoVzWR86jsFVD5saIJWH1OyaCVFMSaFfkEg5XR2/7ks2s+KSd8lPNZ+4+Uru9Gn
         WixciWlN3GFZCor2QFV4TqNZg08Cxq0b5W4iuxqY+i3pQBJtQBr2VZRS/SShur3ed4bO
         2OsrhsCCLMa/1vwP9dTRbJ79Qj4nAh9qM2WhchMjYv4lF8j+f4DkS07wg0TaLgAmTKp6
         laUw==
X-Gm-Message-State: APjAAAWYx9+t/doywezlTj6cBkMofc3QMdhg0XzHyGrULUFfUlbLGosF
        elGICAxBX2ufh0Orde/zCBhS3A==
X-Google-Smtp-Source: APXvYqzwolyKTHBPksf8r29Fk2tN+6KkbWLBW7aQLh67khyAp/4BNNiNMzI09mx7q/rAOLMaqRiymQ==
X-Received: by 2002:aa7:9358:: with SMTP id 24mr10769056pfn.241.1570110491578;
        Thu, 03 Oct 2019 06:48:11 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id e184sm3872593pfa.87.2019.10.03.06.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2019 06:48:10 -0700 (PDT)
Date:   Thu, 3 Oct 2019 09:48:09 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Viktor Rosendahl <viktor.rosendahl@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 4/4] ftrace: Add an option for tracing console
 latencies
Message-ID: <20191003134809.GD254942@google.com>
References: <20190920152219.12920-1-viktor.rosendahl@gmail.com>
 <20190920152219.12920-5-viktor.rosendahl@gmail.com>
 <20191002005244.GC161396@google.com>
 <c34eb6e7-18c4-84b5-1fe5-74320dc36a25@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c34eb6e7-18c4-84b5-1fe5-74320dc36a25@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2019 at 12:44:09AM +0200, Viktor Rosendahl wrote:
> On 10/2/19 2:52 AM, Joel Fernandes wrote:
> > On Fri, Sep 20, 2019 at 05:22:19PM +0200, Viktor Rosendahl (BMW) wrote:
> > > This new trace option "console-latency" will enable the latency
> > > tracers to trace the console latencies. Previously this has always been
> > > implicitely disabled. I guess this is because they are considered
> > > to be well known and unavoidable.
> > > 
> > > However, for some organizations it may nevertheless be desirable to
> > > trace them. Basically, we want to be able to tell that there are
> > > latencies in the system under test because someone has incorrectly
> > > enabled the serial console.
> > > 
> > > Signed-off-by: Viktor Rosendahl (BMW) <viktor.rosendahl@gmail.com>
> > > ---
> > >   include/linux/irqflags.h     | 22 ++++++++++++++++++++++
> > >   kernel/printk/printk.c       |  6 ++++--
> > >   kernel/trace/trace.h         |  1 +
> > >   kernel/trace/trace_irqsoff.c | 12 ++++++++++++
> > >   4 files changed, 39 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/include/linux/irqflags.h b/include/linux/irqflags.h
> > > index 21619c92c377..3de891723331 100644
> > > --- a/include/linux/irqflags.h
> > > +++ b/include/linux/irqflags.h
> > > @@ -13,6 +13,7 @@
> > >   #define _LINUX_TRACE_IRQFLAGS_H
> > >   #include <linux/typecheck.h>
> > > +#include <linux/types.h>
> > >   #include <asm/irqflags.h>
> > >   /* Currently trace_softirqs_on/off is used only by lockdep */
> > > @@ -68,9 +69,30 @@ do {						\
> > >   	defined(CONFIG_PREEMPT_TRACER)
> > >    extern void stop_critical_timings(void);
> > >    extern void start_critical_timings(void);
> > > + extern bool console_tracing_disabled(void);
> > > +
> > > +# define console_stop_critical_timings(flag)		\
> > > +	do {						\
> > > +		typecheck(bool, flag);			\
> > > +		flag = console_tracing_disabled();	\
> > > +		if (flag)				\
> > > +			stop_critical_timings();	\
> > > +	} while (0)
> > > +
> > > +# define console_start_critical_timings(flag)		 \
> > > +	do {						 \
> > > +		typecheck(bool, flag);			 \
> > > +		if (flag)				 \
> > > +			start_critical_timings();	 \
> > > +	} while (0)
> > > +
> > >   #else
> > >   # define stop_critical_timings() do { } while (0)
> > >   # define start_critical_timings() do { } while (0)
> > > +# define console_stop_critical_timings(flag)	\
> > > +	do { typecheck(bool, flag); } while (0)
> > > +# define console_start_critical_timings(flag)	\
> > > +	do { typecheck(bool, flag); } while (0)
> > >   #endif
> > >   /*
> > > diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> > > index 1888f6a3b694..036460a7e4cd 100644
> > > --- a/kernel/printk/printk.c
> > > +++ b/kernel/printk/printk.c
> > > @@ -2359,6 +2359,7 @@ void console_unlock(void)
> > >   	static char ext_text[CONSOLE_EXT_LOG_MAX];
> > >   	static char text[LOG_LINE_MAX + PREFIX_MAX];
> > >   	unsigned long flags;
> > > +	bool cflag;
> > >   	bool do_cond_resched, retry;
> > >   	if (console_suspended) {
> > > @@ -2459,9 +2460,10 @@ void console_unlock(void)
> > >   		 */
> > >   		console_lock_spinning_enable();
> > > -		stop_critical_timings();	/* don't trace print latency */
> > > +		/* don't trace print latency if it's disabled */
> > > +		console_stop_critical_timings(cflag);
> > >   		call_console_drivers(ext_text, ext_len, text, len);
> > > -		start_critical_timings();
> > > +		console_start_critical_timings(cflag);
> > >   		if (console_lock_spinning_disable_and_check()) {
> > >   			printk_safe_exit_irqrestore(flags);
> > > diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
> > > index 4913ed1138aa..93a8b82c27e4 100644
> > > --- a/kernel/trace/trace.h
> > > +++ b/kernel/trace/trace.h
> > > @@ -1262,6 +1262,7 @@ extern int trace_get_user(struct trace_parser *parser, const char __user *ubuf,
> > >   		C(PRINTK_MSGONLY,	"printk-msg-only"),	\
> > >   		C(CONTEXT_INFO,		"context-info"),   /* Print pid/cpu/time */ \
> > >   		C(LATENCY_FMT,		"latency-format"),	\
> > > +		C(CONSOLE_LATENCY,	"console-latency"),	\
> > >   		C(RECORD_CMD,		"record-cmd"),		\
> > >   		C(RECORD_TGID,		"record-tgid"),		\
> > >   		C(OVERWRITE,		"overwrite"),		\
> > > diff --git a/kernel/trace/trace_irqsoff.c b/kernel/trace/trace_irqsoff.c
> > > index a745b0cee5d3..bc02be207a7a 100644
> > > --- a/kernel/trace/trace_irqsoff.c
> > > +++ b/kernel/trace/trace_irqsoff.c
> > > @@ -456,6 +456,18 @@ void stop_critical_timings(void)
> > >   EXPORT_SYMBOL_GPL(stop_critical_timings);
> > >   NOKPROBE_SYMBOL(stop_critical_timings);
> > > +bool console_tracing_disabled(void)
> > > +{
> > > +	struct trace_array *tr = irqsoff_trace;
> > > +	int pc = preempt_count();
> > > +
> > > +	if (!preempt_trace(pc) && !irq_trace())
> > > +		return false;
> > 
> > Why this condition here? Why not just make the call to
> > stop_critical_timings() dependent on the new flag you are adding? Please
> > explain it more and add some comments.
> > 
> 
> It is a kind of optimization for the common case, i.e. that the tracer
> is not enabled.
> 
> The idea is that if the preemptirqsoff tracing is disabled, then the
> question of whether or not to trace console latencies is moot and by
> telling the caller that it is not disabled, we will prevent the caller
> from making the calls to stop_critical_timings() and
> start_critical_timings(). These calls would only return without doing
> anything if the condition "!preempt_trace(pc) && !irq_trace()" is true,
> since they use the inverse condition "preempt_trace(pc) || irq_trace()"
> to test whether or not they should do anything.
> 
> I have to admit that this may be a useless micro optimization that
> makes the code harder to understand and maintain for a benefit that
> is so small that it would be hard to measure.
> 
> I feel a bit unsure whether I should try to improve it by adding a
> comment, and perhaps putting the condition into a macro that
> could then also be used by the start/stop_critical_timings() functions,
> or if I should just get rid of the optimization. I guess this console
> code is not a particularly hot code path anyway.
> 
> Please let me know what you think.

Oh, I see what you are doing now. I think you can just add a comment on top
of the if block explaining this.

But IIRC the printk code is being rewritten to not have real-time latency
issues, so may be this patch will become obsolete pretty soon?

Unless you really need this patch for your series, I would should just drop it.

thanks,

 - Joel




> best regards,
> 
> Viktor
> 
> > thanks,
> > 
> >   - Joel
> > 
> > 
> > > +
> > > +	return !(tr->trace_flags & TRACE_ITER_CONSOLE_LATENCY);
> > > +}
> > > +EXPORT_SYMBOL_GPL(console_tracing_disabled);
> > > +
> > >   #ifdef CONFIG_FUNCTION_TRACER
> > >   static bool function_enabled;
> > > -- 
> > > 2.17.1
> > > 
> 
