Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C2BC31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 12:37:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37CAE2133D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 12:37:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HiSqWCoF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727802AbfFNMhY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 08:37:24 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46894 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727544AbfFNMhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 08:37:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=X5kiLvzH4A2kXwX2WbAsnS3AXNMt9B2M908qddkdC5A=; b=HiSqWCoFBzQ5GZWrs5tqx2fGG
        8CCEt/bAzBJixXPKI92rUhULmJRitb63MDLddk1imhtq8JE6hywHes/O9NskZZK5Wnoh8SvTh4wh1
        phy4rrG3Y1Zqs5vjw3I8N83nA2PCK+QNiuXc3kx5ZGGY3GqcKUdMhylSM9/vpBzgN3V9qxMhRmVFW
        ak6r0VbljIgr/7di4eUE/B9+MbdajNEpJnfWihMGnp4NRho2de9fOidkZCFx5rxhn6ixH9aoj8Cno
        4EsMiN9CHz/FvruGNDW7DOjn++OI+ebWwVOAIY2ZZmceehn/z2zPMqL/8ciy4jy4lAnIH3UDPai0N
        Sp+TMJGIw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hblSH-0005dC-Sx; Fri, 14 Jun 2019 12:37:18 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C545D2013F720; Fri, 14 Jun 2019 14:37:15 +0200 (CEST)
Date:   Fri, 14 Jun 2019 14:37:15 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        "Liang, Kan" <kan.liang@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCHv2 0/8] perf/x86: Rework msr probe interface
Message-ID: <20190614123715.GN3436@hirez.programming.kicks-ass.net>
References: <20190531120958.29601-1-jolsa@kernel.org>
 <20190614102046.GB4325@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190614102046.GB4325@krava>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2019 at 12:20:46PM +0200, Jiri Olsa wrote:
> On Fri, May 31, 2019 at 02:09:50PM +0200, Jiri Olsa wrote:
> > hi,
> > following up on [1], [2] and [3], this patchset adds update
> > attribute groups to pmu, factors out the MSR probe code and
> > use it in msr,cstate* and rapl PMUs.
> > 
> > The functionality stays the same with one exception:
> > for msr PMU: the event is not exported if the rdmsr return zero
> > on event's msr, cstate* and rapl pmu functionality stays.
> > 
> > And also: ;-)
> > > Somewhere along the line you lost the explanation of _why_ we're doing
> > > this; namely: virt sucks.
> > 
> > Also available in:
> >   git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
> >   perf/msr
> > 
> > Tested on snb and skylake servers.
> > 
> > v2 changes:
> >   - checking zero rdmsr only for msr PMU events,
> >     cstate* and rapl pmu functionality stays unchanged
> 
> ping

I was waiting a new post because you mentioned something about some
people not being happy with this, something about a wonky BIOS failing
this on native.
