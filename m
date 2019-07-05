Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55803C5B57D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 23:57:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26CFB20830
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 23:57:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbfGEX5A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 19:57:00 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:54870 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbfGEX5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 19:57:00 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id 16F6D281E7;
        Fri,  5 Jul 2019 19:56:57 -0400 (EDT)
Date:   Sat, 6 Jul 2019 09:56:56 +1000 (AEST)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     Markus Elfring <Markus.Elfring@web.de>
cc:     linux-m68k@lists.linux-m68k.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] m68k: One function call less in cf_tlb_miss()
In-Reply-To: <c5713aa4-d290-0f7d-7de8-82bcdf74ee95@web.de>
Message-ID: <alpine.LNX.2.21.1907060951060.67@nippy.intranet>
References: <c5713aa4-d290-0f7d-7de8-82bcdf74ee95@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 5 Jul 2019, Markus Elfring wrote:

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Fri, 5 Jul 2019 17:11:37 +0200
> 
> Avoid an extra function call 

Not really. You've avoided an extra statement.

> by using a ternary operator instead of a conditional statement for a 
> setting selection.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  arch/m68k/mm/mcfmmu.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/m68k/mm/mcfmmu.c b/arch/m68k/mm/mcfmmu.c
> index 6cb1e41d58d0..02fc0778028e 100644
> --- a/arch/m68k/mm/mcfmmu.c
> +++ b/arch/m68k/mm/mcfmmu.c
> @@ -146,12 +146,10 @@ int cf_tlb_miss(struct pt_regs *regs, int write, int dtlb, int extension_word)
> 
>  	mmu_write(MMUDR, (pte_val(*pte) & PAGE_MASK) |
>  		((pte->pte) & CF_PAGE_MMUDR_MASK) | MMUDR_SZ_8KB | MMUDR_X);
> -
> -	if (dtlb)
> -		mmu_write(MMUOR, MMUOR_ACC | MMUOR_UAA);
> -	else
> -		mmu_write(MMUOR, MMUOR_ITLB | MMUOR_ACC | MMUOR_UAA);
> -
> +	mmu_write(MMUOR,
> +		  dtlb
> +		  ? MMUOR_ACC | MMUOR_UAA
> +		  : MMUOR_ITLB | MMUOR_ACC | MMUOR_UAA);

If you are trying to avoid redundancy, why not finish the job?

+     mmu_write(MMUOR, (dtlb ? 0 : MMUOR_ITLB) | MMUOR_ACC | MMUOR_UAA);

-- 

>  	local_irq_restore(flags);
>  	return 0;
>  }
> --
> 2.22.0
> 
> 
