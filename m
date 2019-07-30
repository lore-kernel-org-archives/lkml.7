Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F27ECC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 09:25:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA16A208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 09:25:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="MwaqkRm4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731275AbfG3JZ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 05:25:58 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:49751 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728824AbfG3JZz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 05:25:55 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 45yWPr5TVtz9v6rL;
        Tue, 30 Jul 2019 11:25:52 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=MwaqkRm4; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 7KFNCyn7xq7n; Tue, 30 Jul 2019 11:25:52 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 45yWPr4N12z9v6rD;
        Tue, 30 Jul 2019 11:25:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1564478752; bh=pX9B5rT8fdYyTjZx+y7CWb+oTWSJ3t8UtVUS0M54TGU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=MwaqkRm4vHR8/sYmxLpOgTAQa18mHrb0VUqrjcNqC1Aaq+35egfN8JkhKEZ3se6ea
         z03O0PuzFXxwU4G53xz6iNsa6xCJOFcZKbwn3CqgeJI43bVNH3jjSV87cZTbKM9r0o
         Q8OXsbj1nwj/LypjTYleCuGgV3570gHdIuTUlVUU=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B081D8B801;
        Tue, 30 Jul 2019 11:25:53 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id iChTdP8KxfiN; Tue, 30 Jul 2019 11:25:53 +0200 (CEST)
Received: from [172.25.230.101] (po15451.idsi0.si.c-s.fr [172.25.230.101])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 7ABBB8B74F;
        Tue, 30 Jul 2019 11:25:53 +0200 (CEST)
Subject: Re: [PATCH v2 03/10] powerpc: introduce kimage_vaddr to store the
 kernel base
To:     Jason Yan <yanaijie@huawei.com>, mpe@ellerman.id.au,
        linuxppc-dev@lists.ozlabs.org, diana.craciun@nxp.com,
        benh@kernel.crashing.org, paulus@samba.org, npiggin@gmail.com,
        keescook@chromium.org, kernel-hardening@lists.openwall.com
Cc:     linux-kernel@vger.kernel.org, wangkefeng.wang@huawei.com,
        yebin10@huawei.com, thunder.leizhen@huawei.com,
        jingxiangfeng@huawei.com, fanchengyang@huawei.com,
        zhaohongjiang@huawei.com
References: <20190730074225.39544-1-yanaijie@huawei.com>
 <20190730074225.39544-4-yanaijie@huawei.com>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <8a0c469d-3c69-393b-54ce-a75b8719ca65@c-s.fr>
Date:   Tue, 30 Jul 2019 11:25:53 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190730074225.39544-4-yanaijie@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 30/07/2019 à 09:42, Jason Yan a écrit :
> Now the kernel base is a fixed value - KERNELBASE. To support KASLR, we
> need a variable to store the kernel base.
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
>   arch/powerpc/include/asm/page.h | 2 ++
>   arch/powerpc/mm/init-common.c   | 2 ++
>   2 files changed, 4 insertions(+)
> 
> diff --git a/arch/powerpc/include/asm/page.h b/arch/powerpc/include/asm/page.h
> index 0d52f57fca04..60a68d3a54b1 100644
> --- a/arch/powerpc/include/asm/page.h
> +++ b/arch/powerpc/include/asm/page.h
> @@ -315,6 +315,8 @@ void arch_free_page(struct page *page, int order);
>   
>   struct vm_area_struct;
>   
> +extern unsigned long kimage_vaddr;
> +
>   #include <asm-generic/memory_model.h>
>   #endif /* __ASSEMBLY__ */
>   #include <asm/slice.h>
> diff --git a/arch/powerpc/mm/init-common.c b/arch/powerpc/mm/init-common.c
> index 152ae0d21435..d4801ce48dc5 100644
> --- a/arch/powerpc/mm/init-common.c
> +++ b/arch/powerpc/mm/init-common.c
> @@ -25,6 +25,8 @@ phys_addr_t memstart_addr = (phys_addr_t)~0ull;
>   EXPORT_SYMBOL_GPL(memstart_addr);
>   phys_addr_t kernstart_addr;
>   EXPORT_SYMBOL_GPL(kernstart_addr);
> +unsigned long kimage_vaddr = KERNELBASE;
> +EXPORT_SYMBOL_GPL(kimage_vaddr);
>   
>   static bool disable_kuep = !IS_ENABLED(CONFIG_PPC_KUEP);
>   static bool disable_kuap = !IS_ENABLED(CONFIG_PPC_KUAP);
> 
