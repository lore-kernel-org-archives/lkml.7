Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53082C4321A
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 20:49:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 579CE20717
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 20:49:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gAtb+sR0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387941AbfDYUtc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 16:49:32 -0400
Received: from merlin.infradead.org ([205.233.59.134]:56182 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387666AbfDYUtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 16:49:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7ir/Ob87pQ0rs2vZCr2bgKUMytG2Q+GSHuslKkHCMww=; b=gAtb+sR0GhWoVlxbYWUeTHc6P
        PZONDwqR012yGTlh8Mhqn2o10SWwc7aCnIRJ/3ftTZWky3667hbF61V/qSaBrU9zPS2FdqCw7ED3G
        yZbDZCXvT5gCjxUbyp3kfz8SSvYWU82KeGi91/FMDL9+7N1ASruM6DZPOPzHjfrfM+GmkmKYnMeRP
        GP8hZmrio3SQ9OFSzdgJwB7u2uHE0RtIbeALfrvi92udEQWTK7o7jOgWDIeTZVsu1lOoud17c6mu1
        M6EKPSqM9iEKQWZDGvoX7mbxMPxPNGSbP19n6VM9r9k66hVrmCX5/PEkuDxo5eE/IQQ+VRYsPMlIs
        AAcWKtCrw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hJlIp-0002iZ-2Z; Thu, 25 Apr 2019 20:49:07 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 466D8203C0A58; Thu, 25 Apr 2019 22:49:04 +0200 (CEST)
Date:   Thu, 25 Apr 2019 22:49:04 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, hpa@zytor.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Nadav Amit <nadav.amit@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux_dti@icloud.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, akpm@linux-foundation.org,
        kernel-hardening@lists.openwall.com, linux-mm@kvack.org,
        will.deacon@arm.com, ard.biesheuvel@linaro.org,
        kristen@linux.intel.com, deneen.t.dock@intel.com
Subject: Re: [PATCH v4 00/23] Merge text_poke fixes and executable lockdowns
Message-ID: <20190425204904.GE14281@hirez.programming.kicks-ass.net>
References: <20190422185805.1169-1-rick.p.edgecombe@intel.com>
 <20190425204820.GB12232@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190425204820.GB12232@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 10:48:20PM +0200, Peter Zijlstra wrote:
> On Mon, Apr 22, 2019 at 11:57:42AM -0700, Rick Edgecombe wrote:
> > Andy Lutomirski (1):
> >   x86/mm: Introduce temporary mm structs
> > 
> > Nadav Amit (15):
> >   Fix "x86/alternatives: Lockdep-enforce text_mutex in text_poke*()"
> >   x86/jump_label: Use text_poke_early() during early init
> >   x86/mm: Save DRs when loading a temporary mm
> >   fork: Provide a function for copying init_mm
> >   x86/alternative: Initialize temporary mm for patching
> >   x86/alternative: Use temporary mm for text poking
> >   x86/kgdb: Avoid redundant comparison of patched code
> >   x86/ftrace: Set trampoline pages as executable
> >   x86/kprobes: Set instruction page as executable
> >   x86/module: Avoid breaking W^X while loading modules
> >   x86/jump-label: Remove support for custom poker
> >   x86/alternative: Remove the return value of text_poke_*()
> >   x86/alternative: Comment about module removal races
> >   tlb: provide default nmi_uaccess_okay()
> >   bpf: Fail bpf_probe_write_user() while mm is switched
> > 
> > Rick Edgecombe (7):
> >   x86/mm/cpa: Add set_direct_map_ functions
> >   mm: Make hibernate handle unmapped pages
> >   vmalloc: Add flag for free of special permsissions
> >   modules: Use vmalloc special flag
> >   bpf: Use vmalloc special flag
> >   x86/ftrace: Use vmalloc special flag
> >   x86/kprobes: Use vmalloc special flag
> 
> This all looks good to me, I'll queue them tomorrow when I'm awake
> again. I'll move the last two patches to early in the series, since it
> appears to me they're fixes and should be in place before we make the
> situation worse with the temporary mm swizzling for text_poke.
> 
> If you want to post a new version of patch 4 before then, that'd be
> awesome, otherwise I'll see if I can do those few edits myself.

Patch 3 that was, see, I can't even count straight atm :-)
