Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1EBDC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 11:19:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96C382070D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 11:19:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="TuKAFDEk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387663AbfG2LTo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 07:19:44 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:45517 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387554AbfG2LTo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 07:19:44 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 45xxzY2pwCz9txkm;
        Mon, 29 Jul 2019 13:19:37 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=TuKAFDEk; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id GAawApQoOfH4; Mon, 29 Jul 2019 13:19:37 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 45xxzY1jWwz9txkl;
        Mon, 29 Jul 2019 13:19:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1564399177; bh=QYn92bFk6L4jrJrPT8nEs5INqQRWowzslhlMsgOiPSA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=TuKAFDEk1hkgNToNlN1eyQg4AAiN/y1nVzlhzB0UZjlCHyoJfk1bRt9tsfHx07rru
         Ye3bk/tGrBW405QYUU/vw3jlDklTgk6hMg3OYxx4FDU1BAagcqk91VnBNBE4wkesOj
         FIemEP+b6tkJ5Jx0o4UzuS769fA7CLCTTSDaerQM=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 1EDB98B7CE;
        Mon, 29 Jul 2019 13:19:42 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id oGhuO4e1JRma; Mon, 29 Jul 2019 13:19:42 +0200 (CEST)
Received: from [172.25.230.101] (po15451.idsi0.si.c-s.fr [172.25.230.101])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id D966D8B7B3;
        Mon, 29 Jul 2019 13:19:41 +0200 (CEST)
Subject: Re: [RFC PATCH 08/10] powerpc/fsl_booke/kaslr: clear the original
 kernel if randomized
To:     Jason Yan <yanaijie@huawei.com>, mpe@ellerman.id.au,
        linuxppc-dev@lists.ozlabs.org, diana.craciun@nxp.com,
        benh@kernel.crashing.org, paulus@samba.org, npiggin@gmail.com,
        keescook@chromium.org, kernel-hardening@lists.openwall.com
Cc:     linux-kernel@vger.kernel.org, wangkefeng.wang@huawei.com,
        yebin10@huawei.com, thunder.leizhen@huawei.com,
        jingxiangfeng@huawei.com, fanchengyang@huawei.com
References: <20190717080621.40424-1-yanaijie@huawei.com>
 <20190717080621.40424-9-yanaijie@huawei.com>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <a09b4f53-2ccd-e675-4385-b53fd91fbafc@c-s.fr>
Date:   Mon, 29 Jul 2019 13:19:41 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190717080621.40424-9-yanaijie@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 17/07/2019 à 10:06, Jason Yan a écrit :
> The original kernel still exists in the memory, clear it now.
> 
> Signed-off-by: Jason Yan <yanaijie@huawei.com>
> Cc: Diana Craciun <diana.craciun@nxp.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Christophe Leroy <christophe.leroy@c-s.fr>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Kees Cook <keescook@chromium.org>
> ---
>   arch/powerpc/kernel/kaslr_booke.c  | 11 +++++++++++
>   arch/powerpc/mm/mmu_decl.h         |  2 ++
>   arch/powerpc/mm/nohash/fsl_booke.c |  1 +
>   3 files changed, 14 insertions(+)
> 
> diff --git a/arch/powerpc/kernel/kaslr_booke.c b/arch/powerpc/kernel/kaslr_booke.c
> index 90357f4bd313..00339c05879f 100644
> --- a/arch/powerpc/kernel/kaslr_booke.c
> +++ b/arch/powerpc/kernel/kaslr_booke.c
> @@ -412,3 +412,14 @@ notrace void __init kaslr_early_init(void *dt_ptr, phys_addr_t size)
>   
>   	reloc_kernel_entry(dt_ptr, kimage_vaddr);
>   }
> +
> +void __init kaslr_second_init(void)
> +{
> +	/* If randomized, clear the original kernel */
> +	if (kimage_vaddr != KERNELBASE) {
> +		unsigned long kernel_sz;
> +
> +		kernel_sz = (unsigned long)_end - kimage_vaddr;
> +		memset((void *)KERNELBASE, 0, kernel_sz);

Why are we clearing ? Is that just to tidy up or is it of security 
importance ?

If so, maybe memzero_explicit() should be used instead ?

> +	}
> +}
> diff --git a/arch/powerpc/mm/mmu_decl.h b/arch/powerpc/mm/mmu_decl.h
> index 754ae1e69f92..9912ee598f9b 100644
> --- a/arch/powerpc/mm/mmu_decl.h
> +++ b/arch/powerpc/mm/mmu_decl.h
> @@ -150,8 +150,10 @@ extern void loadcam_multi(int first_idx, int num, int tmp_idx);
>   
>   #ifdef CONFIG_RANDOMIZE_BASE
>   extern void kaslr_early_init(void *dt_ptr, phys_addr_t size);
> +extern void kaslr_second_init(void);

No new 'extern' please.

>   #else
>   static inline void kaslr_early_init(void *dt_ptr, phys_addr_t size) {}
> +static inline void kaslr_second_init(void) {}
>   #endif
>   
>   struct tlbcam {
> diff --git a/arch/powerpc/mm/nohash/fsl_booke.c b/arch/powerpc/mm/nohash/fsl_booke.c
> index 8d25a8dc965f..fa5a87f5c08e 100644
> --- a/arch/powerpc/mm/nohash/fsl_booke.c
> +++ b/arch/powerpc/mm/nohash/fsl_booke.c
> @@ -269,6 +269,7 @@ notrace void __init relocate_init(u64 dt_ptr, phys_addr_t start)
>   	kernstart_addr = start;
>   	if (is_second_reloc) {
>   		virt_phys_offset = PAGE_OFFSET - memstart_addr;
> +		kaslr_second_init();
>   		return;
>   	}
>   
> 

Christophe
