Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A75B0C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 15:11:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 691B1206B8
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 15:11:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732366AbfHAPLJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 11:11:09 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36404 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728691AbfHAPLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 11:11:08 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1htCjH-0001o1-6x; Thu, 01 Aug 2019 17:10:55 +0200
Date:   Thu, 1 Aug 2019 17:10:54 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Julia Cartwright <julia@ni.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        John Stultz <john.stultz@linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Oleg Nesterov <oleg@redhat.com>, kvm@vger.kernel.org,
        Radim Krcmar <rkrcmar@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [patch 4/5] posix-cpu-timers: Defer timer handling to
 task_work
In-Reply-To: <20190801145116.GD31398@hirez.programming.kicks-ass.net>
Message-ID: <alpine.DEB.2.21.1908011710380.1725@nanos.tec.linutronix.de>
References: <20190801143250.370326052@linutronix.de> <20190801143658.074833024@linutronix.de> <20190801145116.GD31398@hirez.programming.kicks-ass.net>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Aug 2019, Peter Zijlstra wrote:
> On Thu, Aug 01, 2019 at 04:32:54PM +0200, Thomas Gleixner wrote:
> > --- a/kernel/time/Kconfig
> > +++ b/kernel/time/Kconfig
> > @@ -52,6 +52,11 @@ config GENERIC_CLOCKEVENTS_MIN_ADJUST
> >  config GENERIC_CMOS_UPDATE
> >  	bool
> >  
> > +# Select to handle posix CPU timers from task_work
> > +# and not from the timer interrupt context
> > +config POSIX_CPU_TIMERS_TASK_WORK
> > +	bool
> > +
> >  if GENERIC_CLOCKEVENTS
> >  menu "Timers subsystem"
> >  
> 
> 
> diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
> index deff97217496..76e37ad5bc31 100644
> --- a/kernel/Kconfig.preempt
> +++ b/kernel/Kconfig.preempt
> @@ -58,6 +58,7 @@ config PREEMPT
>  config PREEMPT_RT
>  	bool "Fully Preemptible Kernel (Real-Time)"
>  	depends on EXPERT && ARCH_SUPPORTS_RT
> +	depends on POSIX_CPU_TIMERS_TASK_WORK

Indeed.
