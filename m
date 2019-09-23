Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBD20C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 11:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CB402089F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 11:27:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="xtYBlPSR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439437AbfIWL14 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 07:27:56 -0400
Received: from merlin.infradead.org ([205.233.59.134]:41452 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387638AbfIWL14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 07:27:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=jGtmV7J2VQdWNOuqa92uJyY42H1eJhkgoKrHeO3gxk4=; b=xtYBlPSRePRz4Pfgeq2ITdpvg
        rGTNufhkdlz1IARYlPBgw2Bgcmfn25nm+n3sAkbufQpG1vX2FenxoMkVoumGN/dBdbEv6Qw4HXJOQ
        jl4EfyBFK1JVAQ4UBuFPIeqnh2bjsqMzNlhFVB/o/uCJJg2j0D81y9b9LJ5CmVVRZXO3Y/LbRtsIc
        npyiz28+XYgtXdD8/r34mrXY5vurWoOAxhv5idxyJa8VHwpsBL/767TyVld5oxUS5zeu6boexizf1
        zOdJ4qO1uqLTR+tfYp5RT+PmYygmG9TtOnCKtDGcljXIzI8RjYfvs/D9uC7mYNee2JKNu7Mgg+lwb
        BaP5YH83A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iCMVP-0002gO-8L; Mon, 23 Sep 2019 11:27:47 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 59CCF303DFD;
        Mon, 23 Sep 2019 13:26:59 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7796420D81384; Mon, 23 Sep 2019 13:27:44 +0200 (CEST)
Date:   Mon, 23 Sep 2019 13:27:44 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] x86/mm/pti: Handle unaligned addr to PMD-mapped page in
 pti_clone_pgtable
Message-ID: <20190923112744.GK2349@hirez.programming.kicks-ass.net>
References: <20190919055312.3020652-1-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190919055312.3020652-1-songliubraving@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 18, 2019 at 10:53:12PM -0700, Song Liu wrote:
> To clone page table of PMD-mapped pages, pti_clone_pgtable() requires PMD
> aligned start address. [1] adds warning for unaligned addresses. However,
> there is still no warning for unaligned address to valid huge pmd [2].
> 
> Add alignment check in valid pmd_large() case. If the address is
> unaligned, round it down to the nearest PMD aligned address and show
> warning.
> 
> [1] commit 825d0b73cd75 ("x86/mm/pti: Handle unaligned address gracefully
>                           in pti_clone_pagetable()")
> [2] https://lore.kernel.org/lkml/156864062019.3407.14798418565580024723.tglx@nanos.tec.linutronix.de/
> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Song Liu <songliubraving@fb.com>
> ---
>  arch/x86/mm/pti.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
> index 7f2140414440..d224115c350d 100644
> --- a/arch/x86/mm/pti.c
> +++ b/arch/x86/mm/pti.c
> @@ -343,6 +343,10 @@ pti_clone_pgtable(unsigned long start, unsigned long end,
>  		}
>  
>  		if (pmd_large(*pmd) || level == PTI_CLONE_PMD) {
> +			/* warn and round_down() unaligned addr */
> +			if (WARN_ON_ONCE(addr & ~PMD_MASK))
> +				addr &= PMD_MASK;
> +
>  			target_pmd = pti_user_pagetable_walk_pmd(addr);
>  			if (WARN_ON(!target_pmd))
>  				return;

I'm conflicted on this one... the only use of addr here is
pti_user_pagetable_walk_pmd() and that already masks things, so the
fixup is 'pointless'.

Also the location is weird; we'd want to do alignment enforcement before
we commence the for-loop, methinks.
