Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09231C7618F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 21:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBA072173E
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 21:43:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729355AbfGQVnx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 17:43:53 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55411 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727205AbfGQVnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 17:43:53 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hnriC-0005hz-EP; Wed, 17 Jul 2019 23:43:44 +0200
Date:   Wed, 17 Jul 2019 23:43:43 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Joerg Roedel <joro@8bytes.org>
cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH 2/3] x86/mm: Sync also unmappings in vmalloc_sync_one()
In-Reply-To: <20190717071439.14261-3-joro@8bytes.org>
Message-ID: <alpine.DEB.2.21.1907172337590.1778@nanos.tec.linutronix.de>
References: <20190717071439.14261-1-joro@8bytes.org> <20190717071439.14261-3-joro@8bytes.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Jul 2019, Joerg Roedel wrote:

> From: Joerg Roedel <jroedel@suse.de>
> 
> With huge-page ioremap areas the unmappings also need to be
> synced between all page-tables. Otherwise it can cause data
> corruption when a region is unmapped and later re-used.
> 
> Make the vmalloc_sync_one() function ready to sync
> unmappings.
> 
> Fixes: 5d72b4fba40ef ('x86, mm: support huge I/O mapping capability I/F')
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>  arch/x86/mm/fault.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> index 4a4049f6d458..d71e167662c3 100644
> --- a/arch/x86/mm/fault.c
> +++ b/arch/x86/mm/fault.c
> @@ -194,11 +194,12 @@ static inline pmd_t *vmalloc_sync_one(pgd_t *pgd, unsigned long address)
>  
>  	pmd = pmd_offset(pud, address);
>  	pmd_k = pmd_offset(pud_k, address);
> -	if (!pmd_present(*pmd_k))
> -		return NULL;
>  
> -	if (!pmd_present(*pmd))
> +	if (pmd_present(*pmd) ^ pmd_present(*pmd_k))
>  		set_pmd(pmd, *pmd_k);
> +
> +	if (!pmd_present(*pmd_k))
> +		return NULL;
>  	else
>  		BUG_ON(pmd_pfn(*pmd) != pmd_pfn(*pmd_k));

So in case of unmap, this updates only the first entry in the pgd_list
because vmalloc_sync_all() will break out of the iteration over pgd_list
when NULL is returned from vmalloc_sync_one().

I'm surely missing something, but how is that supposed to sync _all_ page
tables on unmap as the changelog claims?

Thanks,

	tglx
