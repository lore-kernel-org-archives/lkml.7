Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35368C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 15:21:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDA5320848
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 15:21:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NN9un9tz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728715AbfCEPVm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 10:21:42 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:57878 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727726AbfCEPVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 10:21:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=IW/MFqNmMOpjtrIeswXa7KjxSyC87aDyEneaZ4voho8=; b=NN9un9tzjNMHwTYjbn9TB4q0v
        6dJwDD97doQCkEwCF8WtHXr75+QCGjPViO/zpcjiAr7QI5XpOTir8TyKixznjv5qQWnJs9eaoe3Et
        Q0+bytXdeWsDy3hYCmLDsYaJjwcQbgJEQL8B9QLJsxhHKmVxUHEVAqiGqmkWxc2qh2SmlylpcWMGs
        DZV+m0nZ+/TBVILIKRQ0V/YL3N0mGJRA9ZzTlEc61YUhnWU+fRkQF5Dbl/5dg8Yt9ANPvxJaOjv+f
        utNrS5FhZdsJhPC8O9LSEmkA5X2tRB9eOr5trarY8BvdkIwB5BYc87fZaVIrXSvVyfdTW2NkDV/91
        BTdlDTDFA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h1Bst-0003nJ-KW; Tue, 05 Mar 2019 15:21:35 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 04D1D202C2DAE; Tue,  5 Mar 2019 16:21:34 +0100 (CET)
Date:   Tue, 5 Mar 2019 16:21:33 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kairui Song <kasong@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Dave Young <dyoung@redhat.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        devel@linuxdriverproject.org
Subject: Re: [PATCH v2] x86, hyperv: fix kernel panic when kexec on HyperV
Message-ID: <20190305152133.GM32477@hirez.programming.kicks-ass.net>
References: <20190305121703.29769-1-kasong@redhat.com>
 <20190305123329.GK32477@hirez.programming.kicks-ass.net>
 <CACPcB9c=M26J8V7S_SzuccCTcPkr1DOUqK6w01esieJYYeBpEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACPcB9c=M26J8V7S_SzuccCTcPkr1DOUqK6w01esieJYYeBpEA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 05, 2019 at 09:34:13PM +0800, Kairui Song wrote:
> On Tue, Mar 5, 2019 at 8:33 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Tue, Mar 05, 2019 at 08:17:03PM +0800, Kairui Song wrote:
> > > diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> > > index 7abb09e2eeb8..34aa1e953dfc 100644
> > > --- a/arch/x86/hyperv/hv_init.c
> > > +++ b/arch/x86/hyperv/hv_init.c
> > > @@ -406,6 +406,12 @@ void hyperv_cleanup(void)
> > >       /* Reset our OS id */
> > >       wrmsrl(HV_X64_MSR_GUEST_OS_ID, 0);
> > >
> > > +     /* Cleanup hypercall page reference before reset the page */
> > > +     hv_hypercall_pg = NULL;
> > > +
> > > +     /* Make sure page reference is cleared before wrmsr */
> >
> > This comment forgets to tell us who cares about this. And why the wrmsr
> > itself isn't serializing enough.
> >
> > > +     wmb();
> > > +
> > >       /* Reset the hypercall page */
> > >       hypercall_msr.as_uint64 = 0;
> > >       wrmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
> >
> > That looks like a fake MSR; and you're telling me that VMEXIT doesn't
> > serialize?
> 
> Thanks for the review, seem I being a bit paranoid on this. Will drop
> it and send a v3 if no one has any other complaint.

Also; our wrmsr implementation has a "memory" clobber on, which means
you don't even need a compiler barrier to force emit that store before
the wrmsr.

You might want to retain the comment that explains this ordering though.

	hv_hypercall_pg = NULL;
	/*
	 * text that explains why hv_hypercall_pg must be set NULL
	 * before the wrmsr
	 */
	wrmsrl(...);

