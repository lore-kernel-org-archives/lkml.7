Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 318D3C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 10:59:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C613E2070D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 10:59:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="Z7KOP+q9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387512AbfG2K7C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 06:59:02 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:20465 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387424AbfG2K7C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 06:59:02 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 45xxWg4mFmz9v9MP;
        Mon, 29 Jul 2019 12:58:55 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=Z7KOP+q9; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id m1vNkj6CGk8W; Mon, 29 Jul 2019 12:58:55 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 45xxWg3ZpVz9v9M5;
        Mon, 29 Jul 2019 12:58:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1564397935; bh=VxSKkHaFNdhmlWwNqqJwQwOE2mQ2WhfF8ueMIIf3F34=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Z7KOP+q9C3qceGHfw6ZeieAEjypdB1+Dkd+P+cMakb/+BsuwphM7JqYj93yE4KHS0
         ailFGX6Tzv1R5Yn1Wg1WclPtJ+xN54IxByFDadhndcGJ27eXhoj9At/rNwTvcaaw61
         bvk5zCMdSO9rZUN03xgStmlD/qCIyPrZcFJ3yBRI=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 567A48B7CB;
        Mon, 29 Jul 2019 12:59:00 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id bO3NIiryu1lR; Mon, 29 Jul 2019 12:59:00 +0200 (CEST)
Received: from [172.25.230.101] (po15451.idsi0.si.c-s.fr [172.25.230.101])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 0FEA98B7B3;
        Mon, 29 Jul 2019 12:59:00 +0200 (CEST)
Subject: Re: [RFC PATCH 01/10] powerpc: unify definition of M_IF_NEEDED
To:     Jason Yan <yanaijie@huawei.com>, mpe@ellerman.id.au,
        linuxppc-dev@lists.ozlabs.org, diana.craciun@nxp.com,
        benh@kernel.crashing.org, paulus@samba.org, npiggin@gmail.com,
        keescook@chromium.org, kernel-hardening@lists.openwall.com
Cc:     linux-kernel@vger.kernel.org, wangkefeng.wang@huawei.com,
        yebin10@huawei.com, thunder.leizhen@huawei.com,
        jingxiangfeng@huawei.com, fanchengyang@huawei.com
References: <20190717080621.40424-1-yanaijie@huawei.com>
 <20190717080621.40424-2-yanaijie@huawei.com>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <e9f2a7fc-ea70-e018-24b2-76cde6705780@c-s.fr>
Date:   Mon, 29 Jul 2019 12:59:00 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190717080621.40424-2-yanaijie@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 17/07/2019 à 10:06, Jason Yan a écrit :
> M_IF_NEEDED is defined too many times. Move it to a common place.
> 
> Signed-off-by: Jason Yan <yanaijie@huawei.com>
> Cc: Diana Craciun <diana.craciun@nxp.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Christophe Leroy <christophe.leroy@c-s.fr>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Kees Cook <keescook@chromium.org>

Reviewed-by: Christophe Leroy <christophe.leroy@c-s.fr>

> ---
>   arch/powerpc/include/asm/nohash/mmu-book3e.h  | 10 ++++++++++
>   arch/powerpc/kernel/exceptions-64e.S          | 10 ----------
>   arch/powerpc/kernel/fsl_booke_entry_mapping.S | 10 ----------
>   arch/powerpc/kernel/misc_64.S                 |  5 -----
>   4 files changed, 10 insertions(+), 25 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/nohash/mmu-book3e.h b/arch/powerpc/include/asm/nohash/mmu-book3e.h
> index 4c9777d256fb..0877362e48fa 100644
> --- a/arch/powerpc/include/asm/nohash/mmu-book3e.h
> +++ b/arch/powerpc/include/asm/nohash/mmu-book3e.h
> @@ -221,6 +221,16 @@
>   #define TLBILX_T_CLASS2			6
>   #define TLBILX_T_CLASS3			7
>   
> +/*
> + * The mapping only needs to be cache-coherent on SMP, except on
> + * Freescale e500mc derivatives where it's also needed for coherent DMA.
> + */
> +#if defined(CONFIG_SMP) || defined(CONFIG_PPC_E500MC)
> +#define M_IF_NEEDED	MAS2_M
> +#else
> +#define M_IF_NEEDED	0
> +#endif
> +
>   #ifndef __ASSEMBLY__
>   #include <asm/bug.h>
>   
> diff --git a/arch/powerpc/kernel/exceptions-64e.S b/arch/powerpc/kernel/exceptions-64e.S
> index 1cfb3da4a84a..fd49ec07ce4a 100644
> --- a/arch/powerpc/kernel/exceptions-64e.S
> +++ b/arch/powerpc/kernel/exceptions-64e.S
> @@ -1342,16 +1342,6 @@ skpinv:	addi	r6,r6,1				/* Increment */
>   	sync
>   	isync
>   
> -/*
> - * The mapping only needs to be cache-coherent on SMP, except on
> - * Freescale e500mc derivatives where it's also needed for coherent DMA.
> - */
> -#if defined(CONFIG_SMP) || defined(CONFIG_PPC_E500MC)
> -#define M_IF_NEEDED	MAS2_M
> -#else
> -#define M_IF_NEEDED	0
> -#endif
> -
>   /* 6. Setup KERNELBASE mapping in TLB[0]
>    *
>    * r3 = MAS0 w/TLBSEL & ESEL for the entry we started in
> diff --git a/arch/powerpc/kernel/fsl_booke_entry_mapping.S b/arch/powerpc/kernel/fsl_booke_entry_mapping.S
> index ea065282b303..de0980945510 100644
> --- a/arch/powerpc/kernel/fsl_booke_entry_mapping.S
> +++ b/arch/powerpc/kernel/fsl_booke_entry_mapping.S
> @@ -153,16 +153,6 @@ skpinv:	addi	r6,r6,1				/* Increment */
>   	tlbivax 0,r9
>   	TLBSYNC
>   
> -/*
> - * The mapping only needs to be cache-coherent on SMP, except on
> - * Freescale e500mc derivatives where it's also needed for coherent DMA.
> - */
> -#if defined(CONFIG_SMP) || defined(CONFIG_PPC_E500MC)
> -#define M_IF_NEEDED	MAS2_M
> -#else
> -#define M_IF_NEEDED	0
> -#endif
> -
>   #if defined(ENTRY_MAPPING_BOOT_SETUP)
>   
>   /* 6. Setup KERNELBASE mapping in TLB1[0] */
> diff --git a/arch/powerpc/kernel/misc_64.S b/arch/powerpc/kernel/misc_64.S
> index b55a7b4cb543..26074f92d4bc 100644
> --- a/arch/powerpc/kernel/misc_64.S
> +++ b/arch/powerpc/kernel/misc_64.S
> @@ -432,11 +432,6 @@ kexec_create_tlb:
>   	rlwimi	r9,r10,16,4,15		/* Setup MAS0 = TLBSEL | ESEL(r9) */
>   
>   /* Set up a temp identity mapping v:0 to p:0 and return to it. */
> -#if defined(CONFIG_SMP) || defined(CONFIG_PPC_E500MC)
> -#define M_IF_NEEDED	MAS2_M
> -#else
> -#define M_IF_NEEDED	0
> -#endif
>   	mtspr	SPRN_MAS0,r9
>   
>   	lis	r9,(MAS1_VALID|MAS1_IPROT)@h
> 
