Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42446C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 12:28:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B2C920842
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 12:28:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cPHp3dPE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728158AbfCEM2e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 07:28:34 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:37992 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728085AbfCEM2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 07:28:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Dfo+YBvmhGNA0Vn/iIr+M+O2pxNRsMjh1OVoXQ8GwjY=; b=cPHp3dPEP8manSvpW3rGZl2RZ
        hiJZInS4AcPTKa7Sv77QQaysXfXgXoE1VWdDhIFs0J46OVIaFRnkbpkuY/GvHJaOXuJgO25q4BiNL
        b3agOxXjyX+ais+b/48c2JE2E0dOiSBW898hZQURg+Y0bbOiWJrrwP2hlgwTjlQ4DHTIAfLGrzdhG
        XrPpkLslB9voI4k6HzaESzRLlNS7iI/LGJDyFznwaMvQybtik+YeJvPbhinxhUtHBCzfVTPLhKwez
        b/LwujeCFozdNcsOxDbHFrk54f4LWaS1xOesGRaLq12oCSZee4TIXo4ioh44tpIXd/6jO8bW95sbt
        glWh5GMoQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h19BM-0001TX-TF; Tue, 05 Mar 2019 12:28:29 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 475CF29B18E38; Tue,  5 Mar 2019 13:28:27 +0100 (CET)
Date:   Tue, 5 Mar 2019 13:28:27 +0100
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
Subject: Re: [RFC PATCH] x86, hyperv: fix kernel panic when kexec on HyperV VM
Message-ID: <20190305122827.GJ32477@hirez.programming.kicks-ass.net>
References: <20190226155615.16724-1-kasong@redhat.com>
 <20190227120141.GN32494@hirez.programming.kicks-ass.net>
 <CACPcB9c86eT=kXcXkBkUjZnifk5bZ71SogfW2tyNudrVmWbnDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACPcB9c86eT=kXcXkBkUjZnifk5bZ71SogfW2tyNudrVmWbnDQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2019 at 10:55:46PM +0800, Kairui Song wrote:
> On Wed, Feb 27, 2019 at 8:02 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Tue, Feb 26, 2019 at 11:56:15PM +0800, Kairui Song wrote:
> > >  arch/x86/hyperv/hv_init.c | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > >
> > > diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> > > index 7abb09e2eeb8..92291c18d716 100644
> > > --- a/arch/x86/hyperv/hv_init.c
> > > +++ b/arch/x86/hyperv/hv_init.c
> > > @@ -406,6 +406,10 @@ void hyperv_cleanup(void)
> > >       /* Reset our OS id */
> > >       wrmsrl(HV_X64_MSR_GUEST_OS_ID, 0);
> > >
> > > +     /* Cleanup page reference before reset the page */
> > > +     hv_hypercall_pg = NULL;
> > > +     wmb();
> >
> > What do we need that SFENCE for? Any why does it lack a comment?
> 
> Hi, that's for ensuring the hv_hypercall_pg is reset to NULL before
> the following wrmsr call. The wrmsr call will make the pointer address
> invalid.

WRMSR is a serializing instruction (except for TSC_DEADLINE and the
X2APIC).

> I can add some comment in V2 if this is OK.

Barriers must always have a comment.

