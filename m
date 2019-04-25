Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E08FAC4321A
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 20:48:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E320420717
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 20:48:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="i7Hq0H2F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387921AbfDYUsa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 16:48:30 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41932 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387656AbfDYUsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 16:48:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=FitD4X1vPtPf9AaJyZflnefh5ZXat3I/abaTtFAMS7o=; b=i7Hq0H2F0STZhj0SbYPU9kQNf
        yXzbfggcqkI1DmqjyE4zkvAQBey/AeHaQSKy5gSbwKkLTwv/FT04TvnIrvxoYqSNGJVJJWdMtTTQQ
        ZcfCSB6ucpcUXEcRxhfmRXEXntN3RoWa5wUxEQv1+JmF9Qy8PHR9FBVHKLLhTrA5p3yZQtkolmkVW
        ZIlhF1hrp9QUzLO1OIox4w7fuAzYgpy60cawbqqe9L3Dq3cQeVsABBJkHqSY1z8O86LBog6oknxGO
        JsbvmCIIwxF8uUxIR5t3ckfNmiE6XKhttFT2UJgruUV9acrrrYFEm3mAYeaPIBKlCrhCvxF5bTduV
        Ne8RFT5Tg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hJlI6-0001R8-2x; Thu, 25 Apr 2019 20:48:22 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6AB02203C0A58; Thu, 25 Apr 2019 22:48:20 +0200 (CEST)
Date:   Thu, 25 Apr 2019 22:48:20 +0200
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
Message-ID: <20190425204820.GB12232@hirez.programming.kicks-ass.net>
References: <20190422185805.1169-1-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190422185805.1169-1-rick.p.edgecombe@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 22, 2019 at 11:57:42AM -0700, Rick Edgecombe wrote:
> Andy Lutomirski (1):
>   x86/mm: Introduce temporary mm structs
> 
> Nadav Amit (15):
>   Fix "x86/alternatives: Lockdep-enforce text_mutex in text_poke*()"
>   x86/jump_label: Use text_poke_early() during early init
>   x86/mm: Save DRs when loading a temporary mm
>   fork: Provide a function for copying init_mm
>   x86/alternative: Initialize temporary mm for patching
>   x86/alternative: Use temporary mm for text poking
>   x86/kgdb: Avoid redundant comparison of patched code
>   x86/ftrace: Set trampoline pages as executable
>   x86/kprobes: Set instruction page as executable
>   x86/module: Avoid breaking W^X while loading modules
>   x86/jump-label: Remove support for custom poker
>   x86/alternative: Remove the return value of text_poke_*()
>   x86/alternative: Comment about module removal races
>   tlb: provide default nmi_uaccess_okay()
>   bpf: Fail bpf_probe_write_user() while mm is switched
> 
> Rick Edgecombe (7):
>   x86/mm/cpa: Add set_direct_map_ functions
>   mm: Make hibernate handle unmapped pages
>   vmalloc: Add flag for free of special permsissions
>   modules: Use vmalloc special flag
>   bpf: Use vmalloc special flag
>   x86/ftrace: Use vmalloc special flag
>   x86/kprobes: Use vmalloc special flag

This all looks good to me, I'll queue them tomorrow when I'm awake
again. I'll move the last two patches to early in the series, since it
appears to me they're fixes and should be in place before we make the
situation worse with the temporary mm swizzling for text_poke.

If you want to post a new version of patch 4 before then, that'd be
awesome, otherwise I'll see if I can do those few edits myself.
