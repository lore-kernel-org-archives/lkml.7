Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98242C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 17:10:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6756721902
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 17:10:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Mr0gAm2R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728615AbfCURKz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 13:10:55 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42848 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728396AbfCURKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 13:10:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=xNyOZXrWAtPZ1Pw6VvzcHPhU01Cq5JVMiHnSKeEqNzk=; b=Mr0gAm2Ry5c1fjgPSFiZaMvBb
        i63YW6CLS6mGk11+HM0FDO6xUIlCA/zvwyMPVlDfCqhvMfMjidq/0+4vqLIe0yBGDI9MVVERW1DgR
        f/39TCb7hCQnWSXV7OktmC7gUYimEC79/XEj6gTmjZc303iRBkevoFGHXkGIt/7lcefGnp/I7xwWN
        ze6uWIbHq4WrypvpnNQNBAjMhTIsqafLuhdm95lV3hJp2YnJDRkWq879Y872mhQ0CMGT0/cDsE7xD
        P/8/3ELj3BnV/y0sj/TSBAJJ71vc5ausCZtjyEQlPLbOVsQlNAtyUZbJhNm5SlysHJLxUEUpl32Hy
        PfzPMht+w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h71DO-0003SG-I8; Thu, 21 Mar 2019 17:10:50 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B07D2286836CF; Thu, 21 Mar 2019 18:10:47 +0100 (CET)
Date:   Thu, 21 Mar 2019 18:10:47 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Stephane Eranian <eranian@google.com>,
        Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, tonyj@suse.com,
        nelson.dsouza@intel.com
Subject: Re: [PATCH 1/8] perf/x86/intel: Fix memory corruption
Message-ID: <20190321171047.GR5996@hirez.programming.kicks-ass.net>
References: <20190314130113.919278615@infradead.org>
 <20190314130705.441549378@infradead.org>
 <CABPqkBT9=XRLinbhA0T5iztM6NGd5fO39-kQoB5j3Evfvfh2yA@mail.gmail.com>
 <20190319110549.GC5996@hirez.programming.kicks-ass.net>
 <CABPqkBQapZFCyJNRjP-GUjfOy62=rJU=Fv=cYPxPTnVFBkqtVA@mail.gmail.com>
 <20190319182041.GO5996@hirez.programming.kicks-ass.net>
 <CABPqkBQgmT+V29+eD6_rABzNBCo-R22N3PvPX4rWxSWEC0wPPg@mail.gmail.com>
 <20190320222220.GA2490@worktop.programming.kicks-ass.net>
 <20190321123849.GN6521@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1903211741120.1784@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1903211741120.1784@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 05:45:41PM +0100, Thomas Gleixner wrote:
> On Thu, 21 Mar 2019, Peter Zijlstra wrote:
> > Subject: perf/x86/intel: Initialize TFA MSR
> > 
> > Stephane reported that we don't initialize the TFA MSR, which could lead
> > to trouble if the RESET value is not 0 or on kexec.
> 
> That sentence doesn't parse.
> 
>   Stephane reported that the TFA MSR is not initialized by the kernel, but
>   the TFA bit could set by firmware or as a leftover from a kexec, which
>   makes the state inconsistent.
> 
> > Reported-by: Stephane Eranian <eranian@google.com>
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > ---
> >  arch/x86/events/intel/core.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> > index 8baa441d8000..2d3caf2d1384 100644
> > --- a/arch/x86/events/intel/core.c
> > +++ b/arch/x86/events/intel/core.c
> > @@ -3575,6 +3575,12 @@ static void intel_pmu_cpu_starting(int cpu)
> >  
> >  	cpuc->lbr_sel = NULL;
> >  
> > +	if (x86_pmu.flags & PMU_FL_TFA) {
> > +		WARN_ON_ONCE(cpuc->tfa_shadow);
> 
> Hmm. I wouldn't warn here as this is a legit state for kexec/kdump and I
> don't think we can figure out whether this comes directly from the
> firmware.

Even on kexec, the cpuc will be freshly allocated and zerod I think. We
only inherit hardware state, not software state.
