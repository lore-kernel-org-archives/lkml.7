Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FB49C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 07:32:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F9792084C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 07:32:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZwkdkEDQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728735AbfDCHcx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 03:32:53 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49490 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbfDCHcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 03:32:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ZM1r19F+2Gl68rJDHCPMoWxjWYK0RX1wlEuEvWRQFvU=; b=ZwkdkEDQ8sW4QacI5Z/BKrixX
        rzC2gajb0j3iBqhplVsHtFuczQ5H2fOJx8+t0yM4ZXxCqBZBbttfB9J7q1zHGoxVWQV2cdqKoZZTe
        ovbO09YlvMRS81KEofN6uKmArUvKXd7tHEEv79b0fxiQ4IWxlaD1xai43pUoHZhEbngu/29d49yRq
        h/YXmv70nbf+KaIL1JuM/9ZZiwRTQx0aRP59GFnZPlVyOlIRaAVwbNunLqHy90CJQFyG2yZrvc0jD
        CoEFtzJNGEv5eEB0wu8NhgeYmrSXfoXM6AGjhmy4JQ/73UHSwUOn16y7eVJzNEfVUW9GHyNwAsbcY
        06Dfa7VYA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hBaO6-0002ca-2e; Wed, 03 Apr 2019 07:32:46 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E28F829A6F670; Wed,  3 Apr 2019 09:32:43 +0200 (CEST)
Date:   Wed, 3 Apr 2019 09:32:43 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Stephane Eranian <eranian@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, tonyj@suse.com,
        nelson.dsouza@intel.com
Subject: Re: [PATCH 1/8] perf/x86/intel: Fix memory corruption
Message-ID: <20190403073243.GA4038@hirez.programming.kicks-ass.net>
References: <20190319110549.GC5996@hirez.programming.kicks-ass.net>
 <CABPqkBQapZFCyJNRjP-GUjfOy62=rJU=Fv=cYPxPTnVFBkqtVA@mail.gmail.com>
 <20190319182041.GO5996@hirez.programming.kicks-ass.net>
 <CABPqkBQgmT+V29+eD6_rABzNBCo-R22N3PvPX4rWxSWEC0wPPg@mail.gmail.com>
 <20190320222220.GA2490@worktop.programming.kicks-ass.net>
 <20190321123849.GN6521@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1903211741120.1784@nanos.tec.linutronix.de>
 <CABPqkBSZbAbU5h=t2f=oMre080ezSq78LaNQO5xEdRV1nczuew@mail.gmail.com>
 <alpine.DEB.2.21.1903211844010.1784@nanos.tec.linutronix.de>
 <CABPqkBQ=hGNY8nd5WTONaMepH1ma=dBN=AdWOyOF_xe1K5JGHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPqkBQ=hGNY8nd5WTONaMepH1ma=dBN=AdWOyOF_xe1K5JGHA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 12:04:55PM -0700, Stephane Eranian wrote:
> On Thu, Mar 21, 2019 at 10:51 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > On Thu, 21 Mar 2019, Stephane Eranian wrote:
> > > On Thu, Mar 21, 2019 at 9:45 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> > > >
> > > > On Thu, 21 Mar 2019, Peter Zijlstra wrote:
> > > > > Subject: perf/x86/intel: Initialize TFA MSR
> > > > >
> > > > > Stephane reported that we don't initialize the TFA MSR, which could lead
> > > > > to trouble if the RESET value is not 0 or on kexec.
> > > >
> > > > That sentence doesn't parse.
> > > >
> > > >   Stephane reported that the TFA MSR is not initialized by the kernel, but
> > > >   the TFA bit could set by firmware or as a leftover from a kexec, which
> > > >   makes the state inconsistent.
> > > >
> > > Correct. This is what I meant.
> > > The issue is what does the kernel guarantee when it boots?
> > >
> > > I see:
> > > static bool allow_tsx_force_abort = true;
> > >
> > > Therefore you must ensure the MSR is set to reflect that state on boot.
> > > So you have to force it to that value to be in sync which is what your
> > > new patch is doing.
> >
> > The initial state should be that the MSR TFA bit is 0. The software state
> > is a different beast.
> >
> > allow_tsx_force_abort
> >
> >   false                 Do not set MSR TFA bit (Make TSX work with PMC3) and
> >                         exclude PMC3 from being used.
> >
> >   true                  Set the MSR TFA bit when PMC3 is used by perf, clear it
> >                         when PMC3 is not longer in use.
> >
> I would expect this description to be included in the source code where the
> allow_tsx_force_abort variable is defined

That part is easy I suppose.

> and somewhere in the kernel Documentation because it is not trivial to
> understand what the control actually does and the guarantees you have
> when you toggle it.

But here we seem to be sorely lacking, that is, there is no sysfs/perf
documentation at all.

In any case, feel free to send a patch :-)

