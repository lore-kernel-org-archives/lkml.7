Return-Path: <SRS0=A1VX=SJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4308C282DA
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 01:33:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99DFA2171F
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 01:33:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="nDzOMH9P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbfDGBdn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 21:33:43 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:41145 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbfDGBdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 21:33:42 -0400
Received: by mail-qt1-f195.google.com with SMTP id w30so11635102qta.8
        for <linux-kernel@vger.kernel.org>; Sat, 06 Apr 2019 18:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Fi356eH+q127lLencdKNQdR5QyRqbuh3N7FTciKvLiw=;
        b=nDzOMH9P7cuNlPh+9hFeb4vYXTETfEp6qOsWVmqAxXuoj9mD4QXCeDbdaG/xZrtf69
         PBNcUPCn0Q8wGk1PP71FrTBjfgYkwunbZBVcukYBdwwKogOXxknCSdqC1KDyCj7cK0Hg
         E8qt9qFE7874i7FzSXQQX4Q7bw/ioeBNMhKD3YUW7W0jt4JY9tWbFWyOVkKqTjOvaHSy
         8vWnYTEwsh0seJxJLIigJ4u4UdNoMI9DmIZ3kRUERf4WGiKTQdr4YHCbomQEe9HjkeID
         iV4yqdpcDDRsDKM4t5DFCdErEUNZKatJWwaTopq6gOLfRLdvwNjSi7tkZWQv6Tq6WVC7
         FlOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Fi356eH+q127lLencdKNQdR5QyRqbuh3N7FTciKvLiw=;
        b=BsCFo489Ao48Wy4XzrHJVZL1axastL1ysEv2fLRvBE5iQqVT5xOpUWu3wohd0XcDRT
         T6FQjeLrlVsPmXAqAuuSPaRTiasKp1pmUqwu0vHXEA0fNUYm5ZU/xJiaOqlYrryGwgt8
         1lUwnu5kM8XUm7JOzcpiL1Ab0vmJN3Fkj2b36+cZhuWvX0QarKc72u+RA2w9bPk2oRhQ
         tyEUoE6sLV+hNWBki4jNK6Hsj2EkK0nEi6llBogtPCd0Q42AZMLx3FRdJBns0NCBiOUB
         qtDTfESNka77wmAGUDIzwK9vcUti9FghNGjSx0+nqndoFeL5WMHgpKXHhK7JoibtpFqD
         CirQ==
X-Gm-Message-State: APjAAAVjLdbRWgI/P6QimFCk2gCeAyS4JOFmEdNSQ472shiDCa0vJnzU
        OtD633PRTgtnZCoEEwe/V845cxWkNy4=
X-Google-Smtp-Source: APXvYqz+s+zSDC3WkXOR5/Wrb4QxhNvjPWYAjxAZKT7Y4rnzoOPSOd8pMo8+h5UOTD8iDVFpdIP1Fg==
X-Received: by 2002:aed:3e94:: with SMTP id n20mr18758602qtf.268.1554600821785;
        Sat, 06 Apr 2019 18:33:41 -0700 (PDT)
Received: from ovpn-120-94.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id g12sm16086539qki.76.2019.04.06.18.33.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Apr 2019 18:33:41 -0700 (PDT)
Subject: Re: [PATCH v2] powerpc: silence unused-but-set-variable warnings
To:     benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc:     christophe.leroy@c-s.fr, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <20190307144031.52494-1-cai@lca.pw>
From:   Qian Cai <cai@lca.pw>
Message-ID: <0987de8e-4549-4392-ee27-8cdcc3f5026a@lca.pw>
Date:   Sat, 6 Apr 2019 21:33:38 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20190307144031.52494-1-cai@lca.pw>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping. The patchwork status is still New after a month.

On 3/7/19 9:40 AM, Qian Cai wrote:
> pte_unmap() compiles away on some powerpc platforms, so silence the
> warnings below by making it a static inline function.
> 
> mm/memory.c: In function 'copy_pte_range':
> mm/memory.c:820:24: warning: variable 'orig_dst_pte' set but not used
> [-Wunused-but-set-variable]
> mm/memory.c:820:9: warning: variable 'orig_src_pte' set but not used
> [-Wunused-but-set-variable]
> mm/madvise.c: In function 'madvise_free_pte_range':
> mm/madvise.c:318:9: warning: variable 'orig_pte' set but not used
> [-Wunused-but-set-variable]
> mm/swap_state.c: In function 'swap_ra_info':
> mm/swap_state.c:634:15: warning: variable 'orig_pte' set but not used
> [-Wunused-but-set-variable]
> 
> Suggested-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
> 
> v2: make it a static inline function.
> 
>  arch/powerpc/include/asm/book3s/64/pgtable.h | 3 ++-
>  arch/powerpc/include/asm/nohash/64/pgtable.h | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
> index 868fcaf56f6b..d798e33a0c86 100644
> --- a/arch/powerpc/include/asm/book3s/64/pgtable.h
> +++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
> @@ -1006,7 +1006,8 @@ extern struct page *pgd_page(pgd_t pgd);
>  	(((pte_t *) pmd_page_vaddr(*(dir))) + pte_index(addr))
>  
>  #define pte_offset_map(dir,addr)	pte_offset_kernel((dir), (addr))
> -#define pte_unmap(pte)			do { } while(0)
> +
> +static inline void pte_unmap(pte_t *pte) { }
>  
>  /* to find an entry in a kernel page-table-directory */
>  /* This now only contains the vmalloc pages */
> diff --git a/arch/powerpc/include/asm/nohash/64/pgtable.h b/arch/powerpc/include/asm/nohash/64/pgtable.h
> index e77ed9761632..0384a3302fb6 100644
> --- a/arch/powerpc/include/asm/nohash/64/pgtable.h
> +++ b/arch/powerpc/include/asm/nohash/64/pgtable.h
> @@ -205,7 +205,8 @@ static inline void pgd_set(pgd_t *pgdp, unsigned long val)
>    (((pte_t *) pmd_page_vaddr(*(dir))) + (((addr) >> PAGE_SHIFT) & (PTRS_PER_PTE - 1)))
>  
>  #define pte_offset_map(dir,addr)	pte_offset_kernel((dir), (addr))
> -#define pte_unmap(pte)			do { } while(0)
> +
> +static inline void pte_unmap(pte_t *pte) { }
>  
>  /* to find an entry in a kernel page-table-directory */
>  /* This now only contains the vmalloc pages */
> 
