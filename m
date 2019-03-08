Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 025C1C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 07:08:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C45E520811
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 07:08:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="UEM2Ogm5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbfCHHIM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 02:08:12 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:4175 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726039AbfCHHIL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 02:08:11 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 44Fz9P0Pldz9tySV;
        Fri,  8 Mar 2019 08:08:09 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=UEM2Ogm5; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 0JZfNYCKXX_Z; Fri,  8 Mar 2019 08:08:08 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 44Fz9N6NdYz9tyST;
        Fri,  8 Mar 2019 08:08:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1552028888; bh=ten8fE656Farr7S7zs5HusBTJmYFNYsvq6ZguXQ3SX8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=UEM2Ogm58C18/mMhMEsuCwC/DE6jfm44+GLqnvrSJvr9i2WEGKCaZR6wwmXGOdjUc
         eb2mUeuDMZrYxhlHNzX4nI5Uu3nWxU2khjvjiQa+MD2KLz6wMp/2D0QGeiDpaN+CvI
         AbJKgiAybs1ILipAta+CDtpGBWtzkuxyYxNBQMYI=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C56788BF5C;
        Fri,  8 Mar 2019 08:08:09 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id OGpU6J3v8nYj; Fri,  8 Mar 2019 08:08:09 +0100 (CET)
Received: from PO15451 (po15451.idsi0.si.c-s.fr [172.25.231.2])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 9E86C8B75A;
        Fri,  8 Mar 2019 08:08:09 +0100 (CET)
Subject: Re: [PATCH v2] powerpc: silence unused-but-set-variable warnings
To:     Qian Cai <cai@lca.pw>, benh@kernel.crashing.org, paulus@samba.org,
        mpe@ellerman.id.au
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20190307144031.52494-1-cai@lca.pw>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <a89e6a07-da3b-e352-018a-ccfd917eaf74@c-s.fr>
Date:   Fri, 8 Mar 2019 08:08:09 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190307144031.52494-1-cai@lca.pw>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 07/03/2019 à 15:40, Qian Cai a écrit :
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

Reviewed-by: Christophe Leroy <christophe.leroy@c-s.fr>

> ---
> 
> v2: make it a static inline function.
> 
>   arch/powerpc/include/asm/book3s/64/pgtable.h | 3 ++-
>   arch/powerpc/include/asm/nohash/64/pgtable.h | 3 ++-
>   2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
> index 868fcaf56f6b..d798e33a0c86 100644
> --- a/arch/powerpc/include/asm/book3s/64/pgtable.h
> +++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
> @@ -1006,7 +1006,8 @@ extern struct page *pgd_page(pgd_t pgd);
>   	(((pte_t *) pmd_page_vaddr(*(dir))) + pte_index(addr))
>   
>   #define pte_offset_map(dir,addr)	pte_offset_kernel((dir), (addr))
> -#define pte_unmap(pte)			do { } while(0)
> +
> +static inline void pte_unmap(pte_t *pte) { }
>   
>   /* to find an entry in a kernel page-table-directory */
>   /* This now only contains the vmalloc pages */
> diff --git a/arch/powerpc/include/asm/nohash/64/pgtable.h b/arch/powerpc/include/asm/nohash/64/pgtable.h
> index e77ed9761632..0384a3302fb6 100644
> --- a/arch/powerpc/include/asm/nohash/64/pgtable.h
> +++ b/arch/powerpc/include/asm/nohash/64/pgtable.h
> @@ -205,7 +205,8 @@ static inline void pgd_set(pgd_t *pgdp, unsigned long val)
>     (((pte_t *) pmd_page_vaddr(*(dir))) + (((addr) >> PAGE_SHIFT) & (PTRS_PER_PTE - 1)))
>   
>   #define pte_offset_map(dir,addr)	pte_offset_kernel((dir), (addr))
> -#define pte_unmap(pte)			do { } while(0)
> +
> +static inline void pte_unmap(pte_t *pte) { }
>   
>   /* to find an entry in a kernel page-table-directory */
>   /* This now only contains the vmalloc pages */
> 
