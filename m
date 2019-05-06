Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5BF0C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 16:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98F4A20B7C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 16:01:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbfEFQBW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 12:01:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:33080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725994AbfEFQBW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 12:01:22 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D0E2620578;
        Mon,  6 May 2019 16:01:20 +0000 (UTC)
Date:   Mon, 6 May 2019 12:01:19 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Pavankumar Kondeti <pkondeti@codeaurora.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Uwe Kleine-Konig <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 4/7] sched: Add sched_load_rq tracepoint
Message-ID: <20190506120119.12d98042@gandalf.local.home>
In-Reply-To: <20190506153317.fv73wpdwsn7xcyc4@e107158-lin.cambridge.arm.com>
References: <20190505115732.9844-1-qais.yousef@arm.com>
        <20190505115732.9844-5-qais.yousef@arm.com>
        <20190506090859.GK2606@hirez.programming.kicks-ass.net>
        <20190506095239.08577b3e@gandalf.local.home>
        <20190506144200.z4s63nm7untol2tr@e107158-lin.cambridge.arm.com>
        <20190506104618.2fa49e13@gandalf.local.home>
        <20190506153317.fv73wpdwsn7xcyc4@e107158-lin.cambridge.arm.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 May 2019 16:33:17 +0100
Qais Yousef <qais.yousef@arm.com> wrote:

> On 05/06/19 10:46, Steven Rostedt wrote:
> > On Mon, 6 May 2019 15:42:00 +0100
> > Qais Yousef <qais.yousef@arm.com> wrote:
> >   
> > > I can control that for the wrappers I'm introducing. But the actual tracepoint
> > > get the 'trace_' part prepended automatically by the macros.
> > > 
> > > ie DECLARE_TRACE(pelt_rq, ...) will automatically generate a function called
> > > trace_pelt_se(...)
> > > 
> > > Or am I missing something?  
> > 
> > No trace comes from the trace points.  

Re-reading that line, I see I totally didn't express what I meant :-p

> 
> If you want I can do something like below to help create a distinction. It is
> none enforcing though.
> 
> diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
> index 9c3186578ce0..f654ced20045 100644
> --- a/include/linux/tracepoint.h
> +++ b/include/linux/tracepoint.h
> @@ -232,6 +232,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
>   */
>  #define __DECLARE_TRACE(name, proto, args, cond, data_proto, data_args) \
>         extern struct tracepoint __tracepoint_##name;                   \
> +       static inline void tp_##name(proto) __alias(trace_##name);      \
>         static inline void trace_##name(proto)                          \
>         {                                                               \
>                 if (static_key_false(&__tracepoint_##name.key))         \
> 
> 
> Another option is to extend DECLARE_TRACE() to take a new argument IS_TP and
> based on that select the function name. This will be enforcing but I will have
> to go fixup many places.
> 
> Of course 'TP' can be replaced with anything more appealing.

No no no, I meant to say...

 "No that's OK. The "trace_" *is* from the trace points, and trace
 events build on top of them."

-- Steve

