Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAF42C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 16:49:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B237321743
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 16:49:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728816AbfD2Qtc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 12:49:32 -0400
Received: from foss.arm.com ([217.140.101.70]:33752 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728621AbfD2Qtb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 12:49:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1F89C80D;
        Mon, 29 Apr 2019 09:49:29 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2938F3F5AF;
        Mon, 29 Apr 2019 09:49:28 -0700 (PDT)
Date:   Mon, 29 Apr 2019 17:49:23 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Qian Cai <cai@lca.pw>
Cc:     catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: fix pte_unmap() -Wunused-but-set-variable
Message-ID: <20190429164923.GA26912@fuggles.cambridge.arm.com>
References: <20190427012842.93737-1-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190427012842.93737-1-cai@lca.pw>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2019 at 09:28:42PM -0400, Qian Cai wrote:
> Many compilation warnings due to pte_unmap() compiles away. Fixed it by
> making it an static inline function.
> 
> mm/gup.c: In function 'gup_pte_range':
> mm/gup.c:1727:16: warning: variable 'ptem' set but not used
> [-Wunused-but-set-variable]
> mm/gup.c: At top level:
> mm/memory.c: In function 'copy_pte_range':
> mm/memory.c:821:24: warning: variable 'orig_dst_pte' set but not used
> [-Wunused-but-set-variable]
> mm/memory.c:821:9: warning: variable 'orig_src_pte' set but not used
> [-Wunused-but-set-variable]
> mm/swap_state.c: In function 'swap_ra_info':
> mm/swap_state.c:641:15: warning: variable 'orig_pte' set but not used
> [-Wunused-but-set-variable]
> mm/madvise.c: In function 'madvise_free_pte_range':
> mm/madvise.c:318:9: warning: variable 'orig_pte' set but not used
> [-Wunused-but-set-variable]
> 
> Also, remove pte_unmap_nested() as nobody uses it anymore since the
> commit ece0e2b6406a ("mm: remove pte_*map_nested()").

Can you post that as a separate patch which also removes
pte_offset_map_nested(), please?

> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
>  arch/arm64/include/asm/pgtable.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index de70c1eabf33..7543e345e078 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -478,6 +478,8 @@ static inline phys_addr_t pmd_page_paddr(pmd_t pmd)
>  	return __pmd_to_phys(pmd);
>  }
>  
> +static inline void pte_unmap(pte_t *pte) { }

Hmm, is this guaranteed to stop the compiler from warning? Assuming the
pte_unmap() call is inlined, I'd expect it to keep complaining. What
compiler are you using?

Also, there are a bunch of other architectures that I would expect to have
this same issue because they defined pte_unmap() exactly the same way.

Will
