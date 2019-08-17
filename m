Return-Path: <SRS0=F9vw=WN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 428E5C3A59B
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 20:25:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 150AD21019
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 20:25:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726257AbfHQUWD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Aug 2019 16:22:03 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44213 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbfHQUWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Aug 2019 16:22:03 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hz5Cv-0007vq-1S; Sat, 17 Aug 2019 22:21:49 +0200
Date:   Sat, 17 Aug 2019 22:21:48 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Guenter Roeck <linux@roeck-us.net>
cc:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Borislav Petkov <bp@alien8.de>
Subject: Re: sched: Unexpected reschedule of offline CPU#2!
In-Reply-To: <20190816193208.GA29478@roeck-us.net>
Message-ID: <alpine.DEB.2.21.1908172219470.1923@nanos.tec.linutronix.de>
References: <20190727164450.GA11726@roeck-us.net> <20190729093545.GV31381@hirez.programming.kicks-ass.net> <alpine.DEB.2.21.1907291156170.1791@nanos.tec.linutronix.de> <20190729101349.GX31381@hirez.programming.kicks-ass.net> <alpine.DEB.2.21.1907291235580.1791@nanos.tec.linutronix.de>
 <20190729104745.GA31398@hirez.programming.kicks-ass.net> <20190729205059.GA1127@roeck-us.net> <alpine.DEB.2.21.1908161217380.1873@nanos.tec.linutronix.de> <20190816193208.GA29478@roeck-us.net>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Aug 2019, Guenter Roeck wrote:
> On Fri, Aug 16, 2019 at 12:22:22PM +0200, Thomas Gleixner wrote:
> > diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
> > index 75fea0d48c0e..625627b1457c 100644
> > --- a/arch/x86/kernel/process.c
> > +++ b/arch/x86/kernel/process.c
> > @@ -601,6 +601,7 @@ void stop_this_cpu(void *dummy)
> >  	/*
> >  	 * Remove this CPU:
> >  	 */
> > +	set_cpu_active(smp_processor_id(), false);
> >  	set_cpu_online(smp_processor_id(), false);
> >  	disable_local_APIC();
> >  	mcheck_cpu_clear(this_cpu_ptr(&cpu_info));
> > 
> No luck. The problem is still seen with this patch applied on top of
> the mainline kernel (commit a69e90512d9def6).

Yeah, was a bit too naive ....

We actually need to do the full cpuhotplug dance for a regular reboot. In
the panic case, there is nothing we can do about. I'll have a look tomorrow.

Thanks,

	tglx
