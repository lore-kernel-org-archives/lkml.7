Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F286C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 09:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 021AA20679
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 09:25:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="TZx1YxNl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730219AbfG3JZT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 05:25:19 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:6815 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728874AbfG3JZT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 05:25:19 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 45yWP822ftz9v4h5;
        Tue, 30 Jul 2019 11:25:16 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=TZx1YxNl; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 2dAfY6oCGoGF; Tue, 30 Jul 2019 11:25:16 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 45yWP80hbTz9v4gw;
        Tue, 30 Jul 2019 11:25:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1564478716; bh=zrJuLYMZl8yMmLQ5arOArSoM6UnoE7nwuZhDCSwICX0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=TZx1YxNl+aHzIHCeqfmgQSCd37IikeHQti8c8Fz4QiJ6R+8tmJ1SHzF52QfxLtJ7a
         Jc9Jgy6ywynV3j+rHAxx2wHaH7ltod/8M33uPbFB23wrwhmxyKJSSr58SR2MpAC9jj
         CNopfNTl5IWzOVK1RX/lo3kMNNv/gA904RkCznsI=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 34B238B800;
        Tue, 30 Jul 2019 11:25:17 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id OL1JeO5h3g0d; Tue, 30 Jul 2019 11:25:17 +0200 (CEST)
Received: from [172.25.230.101] (po15451.idsi0.si.c-s.fr [172.25.230.101])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id F2E5F8B74F;
        Tue, 30 Jul 2019 11:25:16 +0200 (CEST)
Subject: Re: [PATCH v2 02/10] powerpc: move memstart_addr and kernstart_addr
 to init-common.c
To:     Jason Yan <yanaijie@huawei.com>, mpe@ellerman.id.au,
        linuxppc-dev@lists.ozlabs.org, diana.craciun@nxp.com,
        benh@kernel.crashing.org, paulus@samba.org, npiggin@gmail.com,
        keescook@chromium.org, kernel-hardening@lists.openwall.com
Cc:     linux-kernel@vger.kernel.org, wangkefeng.wang@huawei.com,
        yebin10@huawei.com, thunder.leizhen@huawei.com,
        jingxiangfeng@huawei.com, fanchengyang@huawei.com,
        zhaohongjiang@huawei.com
References: <20190730074225.39544-1-yanaijie@huawei.com>
 <20190730074225.39544-3-yanaijie@huawei.com>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <98a0a18c-0a77-1ab1-d40a-f7de0b9c9009@c-s.fr>
Date:   Tue, 30 Jul 2019 11:25:16 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190730074225.39544-3-yanaijie@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 30/07/2019 à 09:42, Jason Yan a écrit :
> These two variables are both defined in init_32.c and init_64.c. Move
> them to init-common.c.
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
>   arch/powerpc/mm/init-common.c | 5 +++++
>   arch/powerpc/mm/init_32.c     | 5 -----
>   arch/powerpc/mm/init_64.c     | 5 -----
>   3 files changed, 5 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/powerpc/mm/init-common.c b/arch/powerpc/mm/init-common.c
> index a84da92920f7..152ae0d21435 100644
> --- a/arch/powerpc/mm/init-common.c
> +++ b/arch/powerpc/mm/init-common.c
> @@ -21,6 +21,11 @@
>   #include <asm/pgtable.h>
>   #include <asm/kup.h>
>   
> +phys_addr_t memstart_addr = (phys_addr_t)~0ull;
> +EXPORT_SYMBOL_GPL(memstart_addr);
> +phys_addr_t kernstart_addr;
> +EXPORT_SYMBOL_GPL(kernstart_addr);
> +
>   static bool disable_kuep = !IS_ENABLED(CONFIG_PPC_KUEP);
>   static bool disable_kuap = !IS_ENABLED(CONFIG_PPC_KUAP);
>   
> diff --git a/arch/powerpc/mm/init_32.c b/arch/powerpc/mm/init_32.c
> index b04896a88d79..872df48ae41b 100644
> --- a/arch/powerpc/mm/init_32.c
> +++ b/arch/powerpc/mm/init_32.c
> @@ -56,11 +56,6 @@
>   phys_addr_t total_memory;
>   phys_addr_t total_lowmem;
>   
> -phys_addr_t memstart_addr = (phys_addr_t)~0ull;
> -EXPORT_SYMBOL(memstart_addr);
> -phys_addr_t kernstart_addr;
> -EXPORT_SYMBOL(kernstart_addr);
> -
>   #ifdef CONFIG_RELOCATABLE
>   /* Used in __va()/__pa() */
>   long long virt_phys_offset;
> diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
> index a44f6281ca3a..c836f1269ee7 100644
> --- a/arch/powerpc/mm/init_64.c
> +++ b/arch/powerpc/mm/init_64.c
> @@ -63,11 +63,6 @@
>   
>   #include <mm/mmu_decl.h>
>   
> -phys_addr_t memstart_addr = ~0;
> -EXPORT_SYMBOL_GPL(memstart_addr);
> -phys_addr_t kernstart_addr;
> -EXPORT_SYMBOL_GPL(kernstart_addr);
> -
>   #ifdef CONFIG_SPARSEMEM_VMEMMAP
>   /*
>    * Given an address within the vmemmap, determine the pfn of the page that
> 
