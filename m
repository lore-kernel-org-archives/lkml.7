Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62844C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 02:06:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77D2B206F4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 02:06:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbfKNCGO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 21:06:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:47500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726335AbfKNCGO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 21:06:14 -0500
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91526206F3;
        Thu, 14 Nov 2019 02:06:13 +0000 (UTC)
Date:   Wed, 13 Nov 2019 21:06:11 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Arnd Bergmann <arnd@arndb.de>, y2038@lists.linaro.org,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH 21/23] y2038: itimer: change implementation to
 timespec64
Message-ID: <20191113210611.515868a4@oasis.local.home>
In-Reply-To: <alpine.DEB.2.21.1911132306070.2507@nanos.tec.linutronix.de>
References: <20191108210236.1296047-1-arnd@arndb.de>
        <20191108211323.1806194-12-arnd@arndb.de>
        <alpine.DEB.2.21.1911132306070.2507@nanos.tec.linutronix.de>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Nov 2019 23:28:47 +0100 (CET)
Thomas Gleixner <tglx@linutronix.de> wrote:

> On Fri, 8 Nov 2019, Arnd Bergmann wrote:
> >  TRACE_EVENT(itimer_state,
> >  
> > -	TP_PROTO(int which, const struct itimerval *const value,
> > +	TP_PROTO(int which, const struct itimerspec64 *const value,
> >  		 unsigned long long expires),
> >  
> >  	TP_ARGS(which, value, expires),
> > @@ -321,12 +321,12 @@ TRACE_EVENT(itimer_state,
> >  		__entry->which		= which;
> >  		__entry->expires	= expires;
> >  		__entry->value_sec	= value->it_value.tv_sec;
> > -		__entry->value_usec	= value->it_value.tv_usec;
> > +		__entry->value_usec	= value->it_value.tv_nsec / NSEC_PER_USEC;
> >  		__entry->interval_sec	= value->it_interval.tv_sec;
> > -		__entry->interval_usec	= value->it_interval.tv_usec;
> > +		__entry->interval_usec	= value->it_interval.tv_nsec / NSEC_PER_USEC;  
> 
> Hmm, having a division in a tracepoint is clearly suboptimal.

Right, we should move the division into the TP_printk()

		__entry->interval_nsec = alue->it_interval.tv_nsec;

> 
> >  	),
> >  
> > -	TP_printk("which=%d expires=%llu it_value=%ld.%ld it_interval=%ld.%ld",
> > +	TP_printk("which=%d expires=%llu it_value=%ld.%06ld it_interval=%ld.%06ld",  
> 
> We print only 6 digits after the . so that would be even correct w/o a
> division. But it probably does not matter much.

Well, we still need the division in the printk, otherwise it will print
more than 6. That's just the minimum and it will print the full number.


		__entry->interval_nsec / NSEC_PER_USEC


-- Steve

> 
> > @@ -197,19 +207,13 @@ static void set_cpu_itimer(struct task_struct *tsk, unsigned int clock_id,
> >  #define timeval_valid(t) \
> >  	(((t)->tv_sec >= 0) && (((unsigned long) (t)->tv_usec) < USEC_PER_SEC))  
> 
> Hrm, why do we have yet another incarnation of timeval_valid()? Can we
> please have only one (the inline version)?
> 
> Thanks,
> 
> 	tglx

