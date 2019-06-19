Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0995C43613
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 21:34:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93A24208CB
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 21:34:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=codeblueprint-co-uk.20150623.gappssmtp.com header.i=@codeblueprint-co-uk.20150623.gappssmtp.com header.b="bi0a8D3x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730624AbfFSVeo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 17:34:44 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37781 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbfFSVen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 17:34:43 -0400
Received: by mail-pg1-f194.google.com with SMTP id 145so373073pgh.4
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 14:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codeblueprint-co-uk.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4YTe0mi4ZxYNQPShR/fx2ImvNIhyeL2zs0OLpOYBsos=;
        b=bi0a8D3x1KgFO63QC0XpxHJIQkVcye5xXvU3rqa8RRDg9t8A70k+pnRA8FS/QqzAL6
         qJXHfM42VK1PvSYQonU8I1zwSmAWKY9M07YBfd8vcohLbG8RpkORCL7itDWqxv0+Droc
         sJO/UBTeDjuagFCmSHTp0ZuVjhTIB/2PrfY0ECtGJC5rxtXiTPkHTvDEPseYrYuZr8co
         ENTlFqtXbT4gd2kbq/6j6KJNgFV24NPkXwRO4ern0Ge+wgX+USFxewDblaNWpJ57pcVG
         TYlchEzPjorf+uB1nKgO8L1OU0amFk/iO9kTwTn+oCJYaPuzrPJDZ2/zqXn4Yg5VfktI
         RmTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4YTe0mi4ZxYNQPShR/fx2ImvNIhyeL2zs0OLpOYBsos=;
        b=KfUl0zXrCrYF689IcNO2Pz5PKOZj1i0TZIkKjQ+TnVXhE3tmP2ks1Qn7jv6xOZdTtM
         87bgiV5zkBMzEwFxW3/KeqwW27A4cMk+dilVPoXpQL2MsCXLRAUJT4KjTnyRiw3KtKzl
         PFzNd8VUW2FwyweE0cZUhyugu+ld0YapT1wBlmDOEbGFb/tquWgCv07ojSZOBBv8biw0
         tP6QLTjKrzLbCQWSvh2m8sFZjmLkgb/Mp1HLNPcwW9zNdBOGyXmc+dMNpP0SZlspIPp8
         U3RpYeyFwdEsbUNYL3P673KcL+KywQQhWWxIOnBFwYfPhOL0trUdrwr9aIU/9+zCv/5K
         3cIg==
X-Gm-Message-State: APjAAAXh/hV8LagNlJnxrpYic01KSO23s+BFFaj5OHE7nxkxaa9vvLNB
        V9ivv3OEYSS95IEY2ayfC2ecqhbPULo=
X-Google-Smtp-Source: APXvYqwDomnTeh/DjS3/X4tZNcPxna4L10NikMMfe+t5tbCRfyzEJALEjeyIVM0tz+Rx5AKIG9nBFA==
X-Received: by 2002:a63:a1a:: with SMTP id 26mr9500823pgk.265.1560980082749;
        Wed, 19 Jun 2019 14:34:42 -0700 (PDT)
Received: from localhost ([94.1.151.203])
        by smtp.gmail.com with ESMTPSA id q63sm14018422pfb.81.2019.06.19.14.34.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jun 2019 14:34:42 -0700 (PDT)
Date:   Wed, 19 Jun 2019 22:34:37 +0100
From:   Matt Fleming <matt@codeblueprint.co.uk>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH] sched/topology: Improve load balancing on AMD EPYC
Message-ID: <20190619213437.GA6909@codeblueprint.co.uk>
References: <20190605155922.17153-1-matt@codeblueprint.co.uk>
 <20190605180035.GA3402@hirez.programming.kicks-ass.net>
 <20190610212620.GA4772@codeblueprint.co.uk>
 <18994abb-a2a8-47f4-9a35-515165c75942@amd.com>
 <20190618104319.GB4772@codeblueprint.co.uk>
 <20190618123318.GG3419@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190618123318.GG3419@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jun, at 02:33:18PM, Peter Zijlstra wrote:
> On Tue, Jun 18, 2019 at 11:43:19AM +0100, Matt Fleming wrote:
> > This works for me under all my tests. Thoughts?
> > 
> > --->8---
> > 
> > diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
> > index 80a405c2048a..4db4e9e7654b 100644
> > --- a/arch/x86/kernel/cpu/amd.c
> > +++ b/arch/x86/kernel/cpu/amd.c
> > @@ -8,6 +8,7 @@
> >  #include <linux/sched.h>
> >  #include <linux/sched/clock.h>
> >  #include <linux/random.h>
> > +#include <linux/topology.h>
> >  #include <asm/processor.h>
> >  #include <asm/apic.h>
> >  #include <asm/cacheinfo.h>
> > @@ -824,6 +825,8 @@ static void init_amd_zn(struct cpuinfo_x86 *c)
> >  {
> >  	set_cpu_cap(c, X86_FEATURE_ZEN);
> >  
> 
> I'm thinking this deserves a comment. Traditionally the SLIT table held
> relative memory latency. So where the identity is 10, 16 would indicate
> 1.6 times local latency and 32 would be 3.2 times local.
> 
> Now, even very early on BIOS monkeys went about their business and put
> in random values in an attempt to 'tune' the system based on how
> $random-os behaved, which is all sorts of fu^Wwrong.
> 
> Now, I suppose my question is; is that 32 Zen puts in an actual relative
> memory latency metric, or a random value we somehow have to deal with.
> And can we pretty please describe the whole sordid story behind this
> 'tunable' somewhere?

This is one for the AMD folks. I don't know if the memory latency
really is 3.2 times or not, only that that's the value in all the Zen
machines I have access to. Even this 2-socket one:

node distances:
node   0   1 
  0:  10  32 
  1:  32  10 

Tom, Suravee?
