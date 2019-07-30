Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1216CC0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 09:47:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8F9020651
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 09:47:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="D9yvfTFg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732072AbfG3Jrt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 05:47:49 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:62192 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731948AbfG3Jrk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 05:47:40 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 45yWtx4J8rz9vBLV;
        Tue, 30 Jul 2019 11:47:37 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=D9yvfTFg; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 8iuiIZs2SoI6; Tue, 30 Jul 2019 11:47:37 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 45yWtx37D2z9vBLN;
        Tue, 30 Jul 2019 11:47:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1564480057; bh=8Elcq5DvNm2PwJ3AEzgoFiT2sWRlD923ZYF11Klazfg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=D9yvfTFgfaMwYumReHctJgExqulPG0Dwg03sF4s8sufaJg+yAduTAZt8K7iWVJrl2
         1RU9GUaDh63kKxC4/iTS8RBVoJChSQZQ1fBCeojBQmDX2cuhNVezgHvf7hh5oBBG3q
         axwEZCdn7ECTc4gNLkJxCGYcyi4XWH1xQQ5cH48g=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B83938B801;
        Tue, 30 Jul 2019 11:47:37 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id qh6NCYNUGaNl; Tue, 30 Jul 2019 11:47:37 +0200 (CEST)
Received: from [172.25.230.101] (po15451.idsi0.si.c-s.fr [172.25.230.101])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id EF2458B805;
        Tue, 30 Jul 2019 11:47:34 +0200 (CEST)
Subject: Re: [PATCH v2 08/10] powerpc/fsl_booke/kaslr: clear the original
 kernel if randomized
To:     Jason Yan <yanaijie@huawei.com>, mpe@ellerman.id.au,
        linuxppc-dev@lists.ozlabs.org, diana.craciun@nxp.com,
        benh@kernel.crashing.org, paulus@samba.org, npiggin@gmail.com,
        keescook@chromium.org, kernel-hardening@lists.openwall.com
Cc:     linux-kernel@vger.kernel.org, wangkefeng.wang@huawei.com,
        yebin10@huawei.com, thunder.leizhen@huawei.com,
        jingxiangfeng@huawei.com, fanchengyang@huawei.com,
        zhaohongjiang@huawei.com
References: <20190730074225.39544-1-yanaijie@huawei.com>
 <20190730074225.39544-9-yanaijie@huawei.com>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <fc1bf072-8256-f944-cc60-f0da50d319ff@c-s.fr>
Date:   Tue, 30 Jul 2019 11:47:34 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190730074225.39544-9-yanaijie@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 30/07/2019 à 09:42, Jason Yan a écrit :
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

Reviewed-by: Christophe Leroy <christophe.leroy@c-s.fr>

Is kaslr_second_init() the best name ?
What about kaslr_late_init() or kaslr_clear_early_kernel() or ... ?

Christophe

> ---
>   arch/powerpc/kernel/kaslr_booke.c  | 11 +++++++++++
>   arch/powerpc/mm/mmu_decl.h         |  2 ++
>   arch/powerpc/mm/nohash/fsl_booke.c |  1 +
>   3 files changed, 14 insertions(+)
> 
> diff --git a/arch/powerpc/kernel/kaslr_booke.c b/arch/powerpc/kernel/kaslr_booke.c
> index 0bb02e45b928..f032ac119457 100644
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
> +		memzero_explicit((void *)KERNELBASE, kernel_sz);
> +	}
> +}
> diff --git a/arch/powerpc/mm/mmu_decl.h b/arch/powerpc/mm/mmu_decl.h
> index 9332772c8a66..550c8d742f88 100644
> --- a/arch/powerpc/mm/mmu_decl.h
> +++ b/arch/powerpc/mm/mmu_decl.h
> @@ -150,8 +150,10 @@ extern void loadcam_multi(int first_idx, int num, int tmp_idx);
>   
>   #ifdef CONFIG_RANDOMIZE_BASE
>   void kaslr_early_init(void *dt_ptr, phys_addr_t size);
> +void kaslr_second_init(void);
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
