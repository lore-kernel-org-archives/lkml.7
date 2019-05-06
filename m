Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20E12C04AAD
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 06:37:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E88412082F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 06:37:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="INfFhdA7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbfEFGh5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 02:37:57 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:8034 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725773AbfEFGh5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 02:37:57 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 44yCjC05gSz9tyfp;
        Mon,  6 May 2019 08:37:51 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=INfFhdA7; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id swq0gQX0qCwx; Mon,  6 May 2019 08:37:50 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 44yCjB60m9z9tyfj;
        Mon,  6 May 2019 08:37:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1557124670; bh=Fb/CfyK7JfRp2sW54fTJ+6Rf6oUelXmcXkT+5h/45/c=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
        b=INfFhdA7tRmt1FVI8j3SqxuQQESHAfTtVhUtlil3cPOHCm6ZeNyBUx2GTo9b8jjLM
         CEih9FbiXBnscjZCTE5xN3imiIYeWdQiTJI8c+bamoU0Cz40CVGCf1UnGqMrKYYsrq
         K23LjJnza09GwLEh1xFaG9ksN2/rzstiozYsWndE=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 57DD78B812;
        Mon,  6 May 2019 08:37:55 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id V_RXAT8fPJk7; Mon,  6 May 2019 08:37:55 +0200 (CEST)
Received: from PO15451 (po15451.idsi0.si.c-s.fr [172.25.231.6])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 2FA788B74F;
        Mon,  6 May 2019 08:37:55 +0200 (CEST)
Subject: Re: [PATCH v2 03/15] powerpc/mm: convert Book3E 64 to pte_fragment
From:   Christophe Leroy <christophe.leroy@c-s.fr>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        aneesh.kumar@linux.ibm.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <cover.1556293738.git.christophe.leroy@c-s.fr>
 <c440b242da6de3823c4ef51f35f38405bbd51430.1556293738.git.christophe.leroy@c-s.fr>
Message-ID: <0076ad26-9d0e-e408-3521-b8e17669bb04@c-s.fr>
Date:   Mon, 6 May 2019 08:37:55 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <c440b242da6de3823c4ef51f35f38405bbd51430.1556293738.git.christophe.leroy@c-s.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 26/04/2019 à 17:58, Christophe Leroy a écrit :
> Book3E 64 is the only subarch not using pte_fragment. In order
> to allow refactorisation, this patch converts it to pte_fragment.
> 
> Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>   arch/powerpc/include/asm/mmu_context.h       |  6 -----
>   arch/powerpc/include/asm/nohash/64/mmu.h     |  4 +++-
>   arch/powerpc/include/asm/nohash/64/pgalloc.h | 33 ++++++++++------------------
>   arch/powerpc/mm/Makefile                     |  4 ++--
>   arch/powerpc/mm/mmu_context.c                |  2 +-
>   5 files changed, 18 insertions(+), 31 deletions(-)
> 
[...]

> diff --git a/arch/powerpc/mm/Makefile b/arch/powerpc/mm/Makefile
> index 3c1bd9fa23cd..138c772d58d1 100644
> --- a/arch/powerpc/mm/Makefile
> +++ b/arch/powerpc/mm/Makefile
> @@ -9,6 +9,7 @@ CFLAGS_REMOVE_slb.o = $(CC_FLAGS_FTRACE)
>   
>   obj-y				:= fault.o mem.o pgtable.o mmap.o \
>   				   init_$(BITS).o pgtable_$(BITS).o \
> +				   pgtable-frag.o \
>   				   init-common.o mmu_context.o drmem.o
>   obj-$(CONFIG_PPC_MMU_NOHASH)	+= mmu_context_nohash.o tlb_nohash.o \
>   				   tlb_nohash_low.o
> @@ -17,8 +18,7 @@ hash64-$(CONFIG_PPC_NATIVE)	:= hash_native_64.o
>   obj-$(CONFIG_PPC_BOOK3E_64)   += pgtable-book3e.o
>   obj-$(CONFIG_PPC_BOOK3S_64)	+= pgtable-hash64.o hash_utils_64.o slb.o \
>   				   $(hash64-y) mmu_context_book3s64.o \
> -				   pgtable-book3s64.o pgtable-frag.o
> -obj-$(CONFIG_PPC32)		+= pgtable-frag.o
> +				   pgtable-book3s64.o

Looks like the removal of pgtable-frag.o for CONFIG_PPC_BOOK3S_64 didn't 
survive the merge.

Will send a patch to fix that.

Christophe

>   obj-$(CONFIG_PPC_RADIX_MMU)	+= pgtable-radix.o tlb-radix.o
>   obj-$(CONFIG_PPC_BOOK3S_32)	+= ppc_mmu_32.o hash_low_32.o mmu_context_hash32.o
>   obj-$(CONFIG_PPC_BOOK3S)	+= tlb_hash$(BITS).o
