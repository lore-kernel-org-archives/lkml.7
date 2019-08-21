Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61444C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 16:34:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 364702339E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 16:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566405273;
	bh=5Wgi6CnBitr8ACVrtl4JVmT0TPh0c47DtZIL3lbp9vU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UEoWfsLs1SLJdpks2ytN1+WX6DvxEAjsT/ApYweNQlA0pOYcsALR9Ouucg/EGRRVE
	 ks3bN9T+Opy3AODWnwz4znUqvOGanwqOelMMi+apWAmR1rMVyFco6prs3/LjOsQwAu
	 3OxVoX14hgMpt/lQzPKBUB7WamkbPwAvK0Owa4/Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729400AbfHUQec (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 12:34:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:55114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727222AbfHUQeb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 12:34:31 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 341A4216F4;
        Wed, 21 Aug 2019 16:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566405270;
        bh=5Wgi6CnBitr8ACVrtl4JVmT0TPh0c47DtZIL3lbp9vU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PrkJUu0etYaUGZS+v8/uAltPsgcPd9gxnCWBiNdyLS5S1qhXPBBVz3rpEtQM+aBsC
         Vi8RarU3iehaMSrpbMB4Bhl9++Ge014SO+azWllZkJaMBTpMG62XQp2xWyZbjNL4LX
         DLh5DKpl+roNAw2AHV6bYv4FTlRnhyu1T9ymt9+k=
Date:   Wed, 21 Aug 2019 17:34:26 +0100
From:   Will Deacon <will@kernel.org>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: consolidate pgtable_cache_init() and pgd_cache_init()
Message-ID: <20190821163425.6jwxbvspjzqxysxc@willie-the-truck>
References: <1566400018-15607-1-git-send-email-rppt@linux.ibm.com>
 <20190821154942.js4u466rolnekwmq@willie-the-truck>
 <20190821160159.GG26713@rapoport-lnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821160159.GG26713@rapoport-lnx>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 07:01:59PM +0300, Mike Rapoport wrote:
> On Wed, Aug 21, 2019 at 04:49:42PM +0100, Will Deacon wrote:
> > On Wed, Aug 21, 2019 at 06:06:58PM +0300, Mike Rapoport wrote:
> > > diff --git a/init/main.c b/init/main.c
> > > index b90cb5f..2fa8038 100644
> > > --- a/init/main.c
> > > +++ b/init/main.c
> > > @@ -507,7 +507,7 @@ void __init __weak mem_encrypt_init(void) { }
> > >  
> > >  void __init __weak poking_init(void) { }
> > >  
> > > -void __init __weak pgd_cache_init(void) { }
> > > +void __init __weak pgtable_cache_init(void) { }
> > >  
> > >  bool initcall_debug;
> > >  core_param(initcall_debug, initcall_debug, bool, 0644);
> > > @@ -565,7 +565,6 @@ static void __init mm_init(void)
> > >  	init_espfix_bsp();
> > >  	/* Should be run after espfix64 is set up. */
> > >  	pti_init();
> > > -	pgd_cache_init();
> > >  }
> > 
> > AFAICT, this change means we now initialise our pgd cache before
> > debug_objects_mem_init() has run.
> 
> Right.
> 
> > Is that going to cause fireworks with CONFIG_DEBUG_OBJECTS when we later
> > free a pgd?
> 
> We don't allocate a pgd at that time, we only create the kmem cache for the
> future allocations. And that cache is never destroyed anyway.

Thanks for the explanation. In which case, for arm64:

Acked-by: Will Deacon <will@kernel.org>

Will
