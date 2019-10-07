Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD4FFECE58E
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 16:10:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A434E205C9
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 16:10:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="MXPbONKY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728885AbfJGQKx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 12:10:53 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37122 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727801AbfJGQKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 12:10:53 -0400
Received: by mail-qt1-f194.google.com with SMTP id e15so5090870qtr.4
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 09:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ukciw0hdK3K4XMNiPAWm/fQxAF5nCtm7qVJXBq6lLa8=;
        b=MXPbONKY6jnTaS7ac+01oeoHwclD3WoKLLJfhGNS6cGNYTaYU6LYmJ59DCtAuHDQlB
         3P3pe07vx6M4s8kx3bzHBZcX7CpbtOBrElbQtbxicb36GXu2HWWz4VDxhQEQ9nfQN2oP
         ZVxeXRcnwBYg1dpZTyqsp938PupqYsEwW9WProq8d+ciajqd+hVLMRdi5Q1s+X5/ETmA
         mhKxJOvdeXUkWjxVyaaACq7j+ye99Z2qPGXeJA1TJT1Sj0yFVKncVDLj6ywNLlvlkU5/
         OtflbGX+4jDi8efoXKszldER9N+ZRLoLD7//ooFC+fJ6C4zbbuWX50M2nvkCeBtufULl
         OyZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ukciw0hdK3K4XMNiPAWm/fQxAF5nCtm7qVJXBq6lLa8=;
        b=FJPOJjqV2Dfx9QAzk9i4Otq8ncyQbbm0O02jwO8ofg+g0yB78UX5y/p9bd7fuGT1cR
         t2bC4lNfiMJAFUk3SV0i+j+7TzDUmiZsJdextVwB27s6gG+EwEx1Fqf9eqR/OEPrn+8v
         8Z9aY8KhwtlTOG40fe8Z/WufZGMVn0yWzJN5m1Tl0sPwo7xlYnoaiunYHKduk09iu44U
         NrZ+tDxYlmkDlc/QWAqbR00NkyFmQLQRzRkBeYvm2G9l/OUqi3GcCzNjKfg/l+9n5I9E
         hO2vxSRvASIowSBod+OgBGzkfrWZ593aVehKwy1CHZqDOwXkQSL3Qam6tzsJ+Gev5GZI
         YNaQ==
X-Gm-Message-State: APjAAAWzxNQPVhkU1N+kxRZC+5+dPcTo0IKao37hrqUe3eeWCPrCwBsh
        OsOdRxLCBT3NFZJi23Civ+oMmw==
X-Google-Smtp-Source: APXvYqy1twfj5uRk3c5GJEpRMAFqpvKXRhFiC5medntRLKOOCku5d98/bLKsSctOhzMzIhghjWqHkw==
X-Received: by 2002:ac8:1302:: with SMTP id e2mr30156919qtj.326.1570464650651;
        Mon, 07 Oct 2019 09:10:50 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id q5sm10273119qte.38.2019.10.07.09.10.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 Oct 2019 09:10:49 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iHVaz-0006jz-5t; Mon, 07 Oct 2019 13:10:49 -0300
Date:   Mon, 7 Oct 2019 13:10:49 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Steven Price <steven.price@arm.com>
Cc:     linux-mm@kvack.org, Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        James Morse <james.morse@arm.com>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Rutland <Mark.Rutland@arm.com>,
        "Liang, Kan" <kan.liang@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v11 14/22] mm: pagewalk: Add 'depth' parameter to pte_hole
Message-ID: <20191007161049.GA13229@ziepe.ca>
References: <20191007153822.16518-1-steven.price@arm.com>
 <20191007153822.16518-15-steven.price@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191007153822.16518-15-steven.price@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 07, 2019 at 04:38:14PM +0100, Steven Price wrote:
> diff --git a/mm/hmm.c b/mm/hmm.c
> index 902f5fa6bf93..34fe904dd417 100644
> +++ b/mm/hmm.c
> @@ -376,7 +376,7 @@ static void hmm_range_need_fault(const struct hmm_vma_walk *hmm_vma_walk,
>  }
>  
>  static int hmm_vma_walk_hole(unsigned long addr, unsigned long end,
> -			     struct mm_walk *walk)
> +			     __always_unused int depth, struct mm_walk *walk)

It this __always_unused on function arguments something we are doing
now?

Can we have negative depth? Should it be unsigned?

>  {
>  	struct hmm_vma_walk *hmm_vma_walk = walk->private;
>  	struct hmm_range *range = hmm_vma_walk->range;
> @@ -564,7 +564,7 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
>  again:
>  	pmd = READ_ONCE(*pmdp);
>  	if (pmd_none(pmd))
> -		return hmm_vma_walk_hole(start, end, walk);
> +		return hmm_vma_walk_hole(start, end, 0, walk);
>  
>  	if (thp_migration_supported() && is_pmd_migration_entry(pmd)) {
>  		bool fault, write_fault;
> @@ -666,7 +666,7 @@ static int hmm_vma_walk_pud(pud_t *pudp, unsigned long start, unsigned long end,
>  again:
>  	pud = READ_ONCE(*pudp);
>  	if (pud_none(pud))
> -		return hmm_vma_walk_hole(start, end, walk);
> +		return hmm_vma_walk_hole(start, end, 0, walk);
>  
>  	if (pud_huge(pud) && pud_devmap(pud)) {
>  		unsigned long i, npages, pfn;
> @@ -674,7 +674,7 @@ static int hmm_vma_walk_pud(pud_t *pudp, unsigned long start, unsigned long end,
>  		bool fault, write_fault;
>  
>  		if (!pud_present(pud))
> -			return hmm_vma_walk_hole(start, end, walk);
> +			return hmm_vma_walk_hole(start, end, 0, walk);
>  
>  		i = (addr - range->start) >> PAGE_SHIFT;
>  		npages = (end - addr) >> PAGE_SHIFT;

Otherwise this mechanical change to hmm.c looks OK to me

Jason
