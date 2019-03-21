Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3865C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 18:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C685321874
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 18:20:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VFLv5OxY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728728AbfCUSUT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 14:20:19 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35464 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728439AbfCUSUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 14:20:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2Dq+aEiq3y83GeScl43j8vQc0O8xl6udcje1rD+sKWs=; b=VFLv5OxY5CJt6JK7/913rkVwX
        Kf1teyefXWaR5Zzx486MHBKpalwPKZLddWaHwWclkeQa4XfQua5Tf39LUwwjCUbMxDqiNCeprL2i5
        6WD5d9Cf/4+Oz+XvmtC/apMxvMYZQINt6cnVeDvvHXCcsPvEEgOwVekq9dLKI4ma/wPOqvHhEiSV1
        fYgtvl+4dwWmVtWUAEdHFmhTE3hrtvr1J6pGSrJyQlCXvHAkWybuXTwiRTRIsKKiG7iqxpDiDxQ2O
        MKrBpoLqz2mpT8S2t+A4RoDJLcBhZ7Q7Y1WCBK0Qd2N+Uq9c/Al8itxM5L+7rT0O5x40qqouN0Hyb
        3U04l4ldw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h72IX-0000Tg-9w; Thu, 21 Mar 2019 18:20:13 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4288F203CBE13; Thu, 21 Mar 2019 19:20:11 +0100 (CET)
Date:   Thu, 21 Mar 2019 19:20:11 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Stephane Eranian <eranian@google.com>,
        Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, tonyj@suse.com,
        nelson.dsouza@intel.com
Subject: Re: [PATCH 1/8] perf/x86/intel: Fix memory corruption
Message-ID: <20190321182011.GT5996@hirez.programming.kicks-ass.net>
References: <CABPqkBT9=XRLinbhA0T5iztM6NGd5fO39-kQoB5j3Evfvfh2yA@mail.gmail.com>
 <20190319110549.GC5996@hirez.programming.kicks-ass.net>
 <CABPqkBQapZFCyJNRjP-GUjfOy62=rJU=Fv=cYPxPTnVFBkqtVA@mail.gmail.com>
 <20190319182041.GO5996@hirez.programming.kicks-ass.net>
 <CABPqkBQgmT+V29+eD6_rABzNBCo-R22N3PvPX4rWxSWEC0wPPg@mail.gmail.com>
 <20190320222220.GA2490@worktop.programming.kicks-ass.net>
 <20190321123849.GN6521@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1903211741120.1784@nanos.tec.linutronix.de>
 <20190321171047.GR5996@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1903211815300.1784@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1903211815300.1784@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 06:17:01PM +0100, Thomas Gleixner wrote:
> On Thu, 21 Mar 2019, Peter Zijlstra wrote:
> > On Thu, Mar 21, 2019 at 05:45:41PM +0100, Thomas Gleixner wrote:
> > > On Thu, 21 Mar 2019, Peter Zijlstra wrote:
> > > > Subject: perf/x86/intel: Initialize TFA MSR
> > > > 
> > > > Stephane reported that we don't initialize the TFA MSR, which could lead
> > > > to trouble if the RESET value is not 0 or on kexec.
> > > 
> > > That sentence doesn't parse.
> > > 
> > >   Stephane reported that the TFA MSR is not initialized by the kernel, but
> > >   the TFA bit could set by firmware or as a leftover from a kexec, which
> > >   makes the state inconsistent.
> > > 
> > > > Reported-by: Stephane Eranian <eranian@google.com>
> > > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > > ---
> > > >  arch/x86/events/intel/core.c | 6 ++++++
> > > >  1 file changed, 6 insertions(+)
> > > > 
> > > > diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> > > > index 8baa441d8000..2d3caf2d1384 100644
> > > > --- a/arch/x86/events/intel/core.c
> > > > +++ b/arch/x86/events/intel/core.c
> > > > @@ -3575,6 +3575,12 @@ static void intel_pmu_cpu_starting(int cpu)
> > > >  
> > > >  	cpuc->lbr_sel = NULL;
> > > >  
> > > > +	if (x86_pmu.flags & PMU_FL_TFA) {
> > > > +		WARN_ON_ONCE(cpuc->tfa_shadow);
> > > 
> > > Hmm. I wouldn't warn here as this is a legit state for kexec/kdump and I
> > > don't think we can figure out whether this comes directly from the
> > > firmware.
> > 
> > Even on kexec, the cpuc will be freshly allocated and zerod I think. We
> > only inherit hardware state, not software state.
> 
> Ouch, misread the patch of course ... What about cpu hotplug? Does that
> free/alloc or reuse?

re-use I think, but since we kill all events before taking the CPU down,
it _should_ have cleared the MSR while doing that.

Might be best to have someone test this.. someone with ucode and a
machine etc.. :-)
