Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD0E0C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 07:26:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D9CE218B0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 07:26:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="S9ZpJG/+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729925AbfDXH0U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 03:26:20 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48080 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727137AbfDXH0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 03:26:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=PtDwWHsjJ3ge8kJU+gtqE0dCaufHmcByGNhRyTv1JPk=; b=S9ZpJG/+IgDjcybA2XKz87J3F
        bFGNihDxmRCDoFiuIJJxMSbeQAKve29TfJWFlCXTWyiA9jzjPzImWa3cON/y7PSGuWusxr0Xr6ZfN
        zoof4fgKh1/Jcn0nxKo507JwKk+1f8jc1VBBcn2i61B0cY4O6P0xg094dRndzAI6LPIRdUJ6qKs6J
        u2mOaH8YVFnz2bpq0S0lZ+KKtJBjxHV8bHEMNqAZ5sTb2sYDSVC+Z3ZdHVaseej9YSPGyqlSPqJE4
        lSHFtmHwKpoJVSjZuMgTlKbS0bNFrQPvPPI0DpjPUnyLo6jR1ZOiN90YZ3JShs04kQGrZ2MYR9+wX
        mpW+wG+XA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hJCIG-0002Ol-3F; Wed, 24 Apr 2019 07:26:12 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 86A1029B5ADF1; Wed, 24 Apr 2019 09:26:10 +0200 (CEST)
Date:   Wed, 24 Apr 2019 09:26:10 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Joerg Roedel <jroedel@suse.de>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Nicolai Stange <nstange@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/mm: Remove in_nmi() warning from 64bit
 implementation of vmalloc_fault()
Message-ID: <20190424072610.GF4038@hirez.programming.kicks-ass.net>
References: <nycvar.YFH.7.76.1904240902280.9803@cbobk.fhfr.pm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.YFH.7.76.1904240902280.9803@cbobk.fhfr.pm>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 09:04:57AM +0200, Jiri Kosina wrote:
> From: Jiri Kosina <jkosina@suse.cz>
> 
> In-NMI warnings have been added to vmalloc_fault() via ebc8827f75 ("x86: 
> Barf when vmalloc and kmemcheck faults happen in NMI") back in the time 
> when our NMI entry code could not cope with nested NMIs.
> 
> These days, it's perfectly fine to take a fault in NMI context and we 
> don't have to care about the fact that IRET from the fault handler might 
> cause NMI nesting.
> 
> This warning has already been removed from 32bit implementation of 
> vmalloc_fault() in 6863ea0cda8 ("x86/mm: Remove in_nmi() warning from 
> vmalloc_fault()"), but 64bit version was omitted.
> 
> Remove the bogus warning also from 64bit implementation of vmalloc_fault().

Cute; did you actually trigger this?

> Fixes: 6863ea0cda8 ("x86/mm: Remove in_nmi() warning from vmalloc_fault()")
> Reported-by: Nicolai Stange <nstange@suse.de>
> Signed-off-by: Jiri Kosina <jkosina@suse.cz>

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

> ---
>  arch/x86/mm/fault.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> index 667f1da36208..5eaf67e8314f 100644
> --- a/arch/x86/mm/fault.c
> +++ b/arch/x86/mm/fault.c
> @@ -359,8 +359,6 @@ static noinline int vmalloc_fault(unsigned long address)
>  	if (!(address >= VMALLOC_START && address < VMALLOC_END))
>  		return -1;
>  
> -	WARN_ON_ONCE(in_nmi());
> -
>  	/*
>  	 * Copy kernel mappings over when needed. This can also
>  	 * happen within a race in page table update. In the later
> 
> -- 
> Jiri Kosina
> SUSE Labs
> 
