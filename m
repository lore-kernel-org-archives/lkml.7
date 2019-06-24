Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6383AC48BE9
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 14:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43E8D208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 14:24:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728415AbfFXOYZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 10:24:25 -0400
Received: from outbound-smtp15.blacknight.com ([46.22.139.232]:50426 "EHLO
        outbound-smtp15.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726263AbfFXOYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 10:24:25 -0400
Received: from mail.blacknight.com (unknown [81.17.254.17])
        by outbound-smtp15.blacknight.com (Postfix) with ESMTPS id 5FDCF1C26F2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 15:24:22 +0100 (IST)
Received: (qmail 26894 invoked from network); 24 Jun 2019 14:24:22 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.21.36])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 24 Jun 2019 14:24:22 -0000
Date:   Mon, 24 Jun 2019 15:24:20 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Matt Fleming <matt@codeblueprint.co.uk>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH] sched/topology: Improve load balancing on AMD EPYC
Message-ID: <20190624142420.GC2978@techsingularity.net>
References: <20190605155922.17153-1-matt@codeblueprint.co.uk>
 <20190605180035.GA3402@hirez.programming.kicks-ass.net>
 <20190610212620.GA4772@codeblueprint.co.uk>
 <18994abb-a2a8-47f4-9a35-515165c75942@amd.com>
 <20190618104319.GB4772@codeblueprint.co.uk>
 <20190618123318.GG3419@hirez.programming.kicks-ass.net>
 <20190619213437.GA6909@codeblueprint.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20190619213437.GA6909@codeblueprint.co.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 19, 2019 at 10:34:37PM +0100, Matt Fleming wrote:
> On Tue, 18 Jun, at 02:33:18PM, Peter Zijlstra wrote:
> > On Tue, Jun 18, 2019 at 11:43:19AM +0100, Matt Fleming wrote:
> > > This works for me under all my tests. Thoughts?
> > > 
> > > --->8---
> > > 
> > > diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
> > > index 80a405c2048a..4db4e9e7654b 100644
> > > --- a/arch/x86/kernel/cpu/amd.c
> > > +++ b/arch/x86/kernel/cpu/amd.c
> > > @@ -8,6 +8,7 @@
> > >  #include <linux/sched.h>
> > >  #include <linux/sched/clock.h>
> > >  #include <linux/random.h>
> > > +#include <linux/topology.h>
> > >  #include <asm/processor.h>
> > >  #include <asm/apic.h>
> > >  #include <asm/cacheinfo.h>
> > > @@ -824,6 +825,8 @@ static void init_amd_zn(struct cpuinfo_x86 *c)
> > >  {
> > >  	set_cpu_cap(c, X86_FEATURE_ZEN);
> > >  
> > 
> > I'm thinking this deserves a comment. Traditionally the SLIT table held
> > relative memory latency. So where the identity is 10, 16 would indicate
> > 1.6 times local latency and 32 would be 3.2 times local.
> > 
> > Now, even very early on BIOS monkeys went about their business and put
> > in random values in an attempt to 'tune' the system based on how
> > $random-os behaved, which is all sorts of fu^Wwrong.
> > 
> > Now, I suppose my question is; is that 32 Zen puts in an actual relative
> > memory latency metric, or a random value we somehow have to deal with.
> > And can we pretty please describe the whole sordid story behind this
> > 'tunable' somewhere?
> 
> This is one for the AMD folks. I don't know if the memory latency
> really is 3.2 times or not, only that that's the value in all the Zen
> machines I have access to. Even this 2-socket one:
> 
> node distances:
> node   0   1 
>   0:  10  32 
>   1:  32  10 
> 
> Tom, Suravee?

Do not consider this an authorative response but based on what I know
of the physical topology, it is not unreasonable to use 32 in the SLIT
table. There is a small latency when accessing another die on the same
socket (details are generation specific). It's not quite a local access
but it's not as much as a traditional remote access either (hence 16 being
the base unit for another die to hint that it's not quite local but not
quite remote either). 32 is based on accessing a die on a remote socket
based on the expected performance and latency of the interconnect.

To the best of my knowledge, the magic numbers are reflective of the real
topology and not just a gamification of the numbers for a random OS. If
anything, the fact that there is a load balancing issue on Linux would
indicate that they were not picking random numbers for Linux at least :P

-- 
Mel Gorman
SUSE Labs
