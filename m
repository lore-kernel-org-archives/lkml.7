Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFAA8C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 17:17:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A15821900
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 17:17:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728659AbfCURRL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 13:17:11 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:38885 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727198AbfCURRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 13:17:09 -0400
Received: from p5492e2fc.dip0.t-ipconnect.de ([84.146.226.252] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1h71JN-00024V-Sf; Thu, 21 Mar 2019 18:17:02 +0100
Date:   Thu, 21 Mar 2019 18:17:01 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     Stephane Eranian <eranian@google.com>,
        Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, tonyj@suse.com,
        nelson.dsouza@intel.com
Subject: Re: [PATCH 1/8] perf/x86/intel: Fix memory corruption
In-Reply-To: <20190321171047.GR5996@hirez.programming.kicks-ass.net>
Message-ID: <alpine.DEB.2.21.1903211815300.1784@nanos.tec.linutronix.de>
References: <20190314130113.919278615@infradead.org> <20190314130705.441549378@infradead.org> <CABPqkBT9=XRLinbhA0T5iztM6NGd5fO39-kQoB5j3Evfvfh2yA@mail.gmail.com> <20190319110549.GC5996@hirez.programming.kicks-ass.net> <CABPqkBQapZFCyJNRjP-GUjfOy62=rJU=Fv=cYPxPTnVFBkqtVA@mail.gmail.com>
 <20190319182041.GO5996@hirez.programming.kicks-ass.net> <CABPqkBQgmT+V29+eD6_rABzNBCo-R22N3PvPX4rWxSWEC0wPPg@mail.gmail.com> <20190320222220.GA2490@worktop.programming.kicks-ass.net> <20190321123849.GN6521@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1903211741120.1784@nanos.tec.linutronix.de> <20190321171047.GR5996@hirez.programming.kicks-ass.net>
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

On Thu, 21 Mar 2019, Peter Zijlstra wrote:
> On Thu, Mar 21, 2019 at 05:45:41PM +0100, Thomas Gleixner wrote:
> > On Thu, 21 Mar 2019, Peter Zijlstra wrote:
> > > Subject: perf/x86/intel: Initialize TFA MSR
> > > 
> > > Stephane reported that we don't initialize the TFA MSR, which could lead
> > > to trouble if the RESET value is not 0 or on kexec.
> > 
> > That sentence doesn't parse.
> > 
> >   Stephane reported that the TFA MSR is not initialized by the kernel, but
> >   the TFA bit could set by firmware or as a leftover from a kexec, which
> >   makes the state inconsistent.
> > 
> > > Reported-by: Stephane Eranian <eranian@google.com>
> > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > ---
> > >  arch/x86/events/intel/core.c | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > > 
> > > diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> > > index 8baa441d8000..2d3caf2d1384 100644
> > > --- a/arch/x86/events/intel/core.c
> > > +++ b/arch/x86/events/intel/core.c
> > > @@ -3575,6 +3575,12 @@ static void intel_pmu_cpu_starting(int cpu)
> > >  
> > >  	cpuc->lbr_sel = NULL;
> > >  
> > > +	if (x86_pmu.flags & PMU_FL_TFA) {
> > > +		WARN_ON_ONCE(cpuc->tfa_shadow);
> > 
> > Hmm. I wouldn't warn here as this is a legit state for kexec/kdump and I
> > don't think we can figure out whether this comes directly from the
> > firmware.
> 
> Even on kexec, the cpuc will be freshly allocated and zerod I think. We
> only inherit hardware state, not software state.

Ouch, misread the patch of course ... What about cpu hotplug? Does that
free/alloc or reuse?

Thanks,

	tglx

