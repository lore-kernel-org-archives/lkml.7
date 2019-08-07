Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79D1EC32751
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 13:03:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BB9F21E6C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 13:03:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388065AbfHGNDc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 09:03:32 -0400
Received: from ozlabs.org ([203.11.71.1]:46493 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727213AbfHGND3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 09:03:29 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 463WsC1bBxz9sBF;
        Wed,  7 Aug 2019 23:03:27 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Jason Yan <yanaijie@huawei.com>, linuxppc-dev@lists.ozlabs.org,
        diana.craciun@nxp.com, christophe.leroy@c-s.fr,
        benh@kernel.crashing.org, paulus@samba.org, npiggin@gmail.com,
        keescook@chromium.org, kernel-hardening@lists.openwall.com
Cc:     linux-kernel@vger.kernel.org, wangkefeng.wang@huawei.com,
        yebin10@huawei.com, thunder.leizhen@huawei.com,
        jingxiangfeng@huawei.com, fanchengyang@huawei.com,
        zhaohongjiang@huawei.com, Jason Yan <yanaijie@huawei.com>
Subject: Re: [PATCH v5 03/10] powerpc: introduce kimage_vaddr to store the kernel base
In-Reply-To: <20190807065706.11411-4-yanaijie@huawei.com>
References: <20190807065706.11411-1-yanaijie@huawei.com> <20190807065706.11411-4-yanaijie@huawei.com>
Date:   Wed, 07 Aug 2019 23:03:23 +1000
Message-ID: <8736idunz8.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jason Yan <yanaijie@huawei.com> writes:
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
> Reviewed-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Reviewed-by: Diana Craciun <diana.craciun@nxp.com>
> Tested-by: Diana Craciun <diana.craciun@nxp.com>
> ---
>  arch/powerpc/include/asm/page.h | 2 ++
>  arch/powerpc/mm/init-common.c   | 2 ++
>  2 files changed, 4 insertions(+)
>
> diff --git a/arch/powerpc/include/asm/page.h b/arch/powerpc/include/asm/page.h
> index 0d52f57fca04..60a68d3a54b1 100644
> --- a/arch/powerpc/include/asm/page.h
> +++ b/arch/powerpc/include/asm/page.h
> @@ -315,6 +315,8 @@ void arch_free_page(struct page *page, int order);
>  
>  struct vm_area_struct;
>  
> +extern unsigned long kimage_vaddr;
> +
>  #include <asm-generic/memory_model.h>
>  #endif /* __ASSEMBLY__ */
>  #include <asm/slice.h>
> diff --git a/arch/powerpc/mm/init-common.c b/arch/powerpc/mm/init-common.c
> index 152ae0d21435..d4801ce48dc5 100644
> --- a/arch/powerpc/mm/init-common.c
> +++ b/arch/powerpc/mm/init-common.c
> @@ -25,6 +25,8 @@ phys_addr_t memstart_addr = (phys_addr_t)~0ull;
>  EXPORT_SYMBOL_GPL(memstart_addr);
>  phys_addr_t kernstart_addr;
>  EXPORT_SYMBOL_GPL(kernstart_addr);
> +unsigned long kimage_vaddr = KERNELBASE;
> +EXPORT_SYMBOL_GPL(kimage_vaddr);

The names of the #defines and variables we use for these values are not
very consistent already, but using kimage_vaddr makes it worse I think.

Isn't this going to have the same value as kernstart_addr, but the
virtual rather than physical address?

If so kernstart_virt_addr would seem better.

cheers
