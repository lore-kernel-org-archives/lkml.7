Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C3E8C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 11:01:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B50220879
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 11:01:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="epck0kG/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbfCRLBM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 07:01:12 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52634 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726623AbfCRLBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 07:01:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=I2jZQE4p0ocZ8Gt1+1FMX/1VX471V6PZLd8l2yOC92M=; b=epck0kG/FC/lkfgyHthFmNoWc
        cRQE95sp4clUyx2+/xxS0dZuuPDQViLieKmFTpKmuhp13InkhdFYwGkVHrM+HZuxI4Sgm0w/sjAAu
        NdqH4r7hBpkAqbsMuar+iRfv4UbEHgnJYbe6KXpzlFWlojckiyQpyoQWYvLYIHW7j4ouJfwR7naM8
        sSrzpn5K0hHsoL1q8e10Hh38teDmb9XyjHL849+8NaHG+dnfgmOJtwu380RjbEjwhUo2VaYvaOLlP
        Q52+3UjqsiQfNAGW6C/i8TUTuK4pb/sppq5+nK/xCbeorHjLVwlwkAJu8LHncpxh4E9wXGovoACUg
        jJU4FQovA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h5q0s-0000c1-Rz; Mon, 18 Mar 2019 11:01:03 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D191120A0FF8A; Mon, 18 Mar 2019 12:01:00 +0100 (CET)
Date:   Mon, 18 Mar 2019 12:01:00 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        sparclinux@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH V2] cpufreq: Call transition notifier only once for each
 policy
Message-ID: <20190318110100.GN6058@hirez.programming.kicks-ass.net>
References: <e2b56be446eeb67f1905d2ac6f8d82dd4389d0c5.1552640968.git.viresh.kumar@linaro.org>
 <20190315122952.GF6058@hirez.programming.kicks-ass.net>
 <CAJZ5v0g=VYSKAHuncceD-8a1AY+isR7-TMX2dbdMzpZgVkRfBg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0g=VYSKAHuncceD-8a1AY+isR7-TMX2dbdMzpZgVkRfBg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 11:45:00AM +0100, Rafael J. Wysocki wrote:
> On Fri, Mar 15, 2019 at 1:30 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > On Fri, Mar 15, 2019 at 02:43:07PM +0530, Viresh Kumar wrote:

> > > +             for_each_cpu(cpu, cpus)
> > > +                     set_cyc2ns_scale(tsc_khz, cpu, rdtsc());
> >
> > This code doesn't make sense, the rdtsc() _must_ be called on the CPU in
> > question.
> 
> Well, strictly speaking the TSC value here comes from the CPU running the code.
> 
> The original code has this problem too, though (as Viresh said), so
> the patch really doesn't make it worse in that respect. :-)
> 
> I'm not going to defend the original code (I ldidn't invent it
> anyway), but it clearly assumes that different CPUs cannot run at
> different frequencies and that kind of explains what happens in it.

The assumption was always that if CPUs ran at different frequencies, the
notifier would run on the affected CPU. After all, only that CPU would
know its frequency changed.

> > That's part of the whole problem here, TSC isn't sync'ed when
> > it's subject to CPUFREQ.
> 
> So what would you recommend us to do here?
> 
> Obviously, this won't run on any new hardware.  Frankly, I'm not even
> sure what the most recent HW where this hack would make a difference
> is (the comment talking about Opterons suggests early 2000s), so this
> clearly falls into the "legacy" bucket to me.
> 
> Does it make sense to try to preserve it, or can we simply make
> cpufreq init fail on the systems where the TSC rate depends on the
> frequency?

I'm all for deleting this and basically dropping support for anything
that needs this, but I suspect some people digging their legacy systems
(*cough* Pavel *cough*) might object to that.

Heck, I'm even ok with just calling panic() when TSC goes wobbly :-) I'm
fed up with all that broken crap. And yes, I know, that's systems sold
today :-(
