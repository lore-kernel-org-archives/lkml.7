Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDB43C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 13:08:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF4E6205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 13:08:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730169AbfGONIZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 09:08:25 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47644 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730019AbfGONIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 09:08:25 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hn0iE-0006Iz-UA; Mon, 15 Jul 2019 15:08:15 +0200
Date:   Mon, 15 Jul 2019 15:08:14 +0200 (CEST)
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
In-Reply-To: <20190715110212.18617-3-joro@8bytes.org>
Message-ID: <alpine.DEB.2.21.1907151504190.1722@nanos.tec.linutronix.de>
References: <20190715110212.18617-1-joro@8bytes.org> <20190715110212.18617-3-joro@8bytes.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Jul 2019, Joerg Roedel wrote:

> From: Joerg Roedel <jroedel@suse.de>
> 
> With huge-page ioremap areas the unmappings also need to be
> synced between all page-tables. Otherwise it can cause data
> corruption when a region is unmapped and later re-used.
> 
> Make the vmalloc_sync_one() function ready to sync
> unmappings.
> 
> Signed-off-by: Joerg Roedel <jroedel@suse.de>

Lacks a Fixes tag methinks.

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

It took me a while to understand what this is doing. Can we please have a
comment here?

> +
> +	if (!pmd_present(*pmd_k))
> +		return NULL;

Thanks,

	tglx
