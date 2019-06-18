Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 511F1C31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 12:33:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2649E2084D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 12:33:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="piVITSQZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728890AbfFRMd1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 08:33:27 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37312 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbfFRMd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 08:33:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=PuSthhtBsD3xNWn1JKgPDThsL5pdTkosJjBNbFp/O/I=; b=piVITSQZXA3DRkDf975Sx4/Ki
        9woGPs8Kula9K1X3CjBcmzfF57pm4S4Zt0nEk74LpwZnX18rfV6E0HHr57w9iA6aNUgALZppe0W6n
        s7MKq3rheb93FNVUUd0LqSPi6Kw49BCXkC8pFyG35Sl1aMU2S4jpC4JlEheAZpdgyqWF4J7DZKbID
        0U5JvwQgY+YHIylh7hYkKe1/0Befos38lrx3X9tsQZlB2IEYMvRY6eE3tsA4SPqlERLTu8sTZVLTF
        8nQZTJAwjBwT7blS/HM+LuVrUm/OYkhqpsAOcLO8reqKWz26MxbiCK++kM9m8MHlLEFhRZvezh962
        8KMmlKHyw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hdDIe-0001mw-8r; Tue, 18 Jun 2019 12:33:20 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A227A209C88F8; Tue, 18 Jun 2019 14:33:18 +0200 (CEST)
Date:   Tue, 18 Jun 2019 14:33:18 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Matt Fleming <matt@codeblueprint.co.uk>
Cc:     "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH] sched/topology: Improve load balancing on AMD EPYC
Message-ID: <20190618123318.GG3419@hirez.programming.kicks-ass.net>
References: <20190605155922.17153-1-matt@codeblueprint.co.uk>
 <20190605180035.GA3402@hirez.programming.kicks-ass.net>
 <20190610212620.GA4772@codeblueprint.co.uk>
 <18994abb-a2a8-47f4-9a35-515165c75942@amd.com>
 <20190618104319.GB4772@codeblueprint.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190618104319.GB4772@codeblueprint.co.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 18, 2019 at 11:43:19AM +0100, Matt Fleming wrote:
> This works for me under all my tests. Thoughts?
> 
> --->8---
> 
> diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
> index 80a405c2048a..4db4e9e7654b 100644
> --- a/arch/x86/kernel/cpu/amd.c
> +++ b/arch/x86/kernel/cpu/amd.c
> @@ -8,6 +8,7 @@
>  #include <linux/sched.h>
>  #include <linux/sched/clock.h>
>  #include <linux/random.h>
> +#include <linux/topology.h>
>  #include <asm/processor.h>
>  #include <asm/apic.h>
>  #include <asm/cacheinfo.h>
> @@ -824,6 +825,8 @@ static void init_amd_zn(struct cpuinfo_x86 *c)
>  {
>  	set_cpu_cap(c, X86_FEATURE_ZEN);
>  

I'm thinking this deserves a comment. Traditionally the SLIT table held
relative memory latency. So where the identity is 10, 16 would indicate
1.6 times local latency and 32 would be 3.2 times local.

Now, even very early on BIOS monkeys went about their business and put
in random values in an attempt to 'tune' the system based on how
$random-os behaved, which is all sorts of fu^Wwrong.

Now, I suppose my question is; is that 32 Zen puts in an actual relative
memory latency metric, or a random value we somehow have to deal with.
And can we pretty please describe the whole sordid story behind this
'tunable' somewhere?

> +	node_reclaim_distance = 32;
> +
>  	/* Fix erratum 1076: CPB feature bit not being set in CPUID. */
>  	if (!cpu_has(c, X86_FEATURE_CPB))
>  		set_cpu_cap(c, X86_FEATURE_CPB);
