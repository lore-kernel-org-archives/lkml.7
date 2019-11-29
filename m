Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF751C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 07:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B035E215F1
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 07:46:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="caBsoJj7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbfK2Hqd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 02:46:33 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:56838 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726702AbfK2Hqd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 02:46:33 -0500
Received: from localhost (mailhub1-ext [192.168.12.233])
        by localhost (Postfix) with ESMTP id 47PRQt54WWzB09Zf;
        Fri, 29 Nov 2019 08:46:30 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=caBsoJj7; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 6_y2XW50Lxqz; Fri, 29 Nov 2019 08:46:30 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 47PRQt40Y3zB09ZW;
        Fri, 29 Nov 2019 08:46:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1575013590; bh=fYa7j359Su0pGAnv+CbdjxZQ5rsbSzAAB7apROvBEh8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=caBsoJj7Yj/0uck9C1WHWsyz5/+OQQkVvKLl94a2RPVzGOU3RjUu8haPPtTWnal/8
         cwt7+cCTd0aC23AD1CZwQCRQekEkSRcOL6DY+RRXh1I66D0W9jxsckCUPoufs37GEB
         xvPpGr0ICm4PNuwJKKmD339x1qpolB8py9m0F198=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 654768B8B0;
        Fri, 29 Nov 2019 08:46:31 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id Y8xEISFy4gDS; Fri, 29 Nov 2019 08:46:31 +0100 (CET)
Received: from [172.25.230.103] (po15451.idsi0.si.c-s.fr [172.25.230.103])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 406918B755;
        Fri, 29 Nov 2019 08:46:31 +0100 (CET)
Subject: Re: [PATCH] powerpc/kasan: KASAN is not supported on RELOCATABLE &&
 FSL_BOOKE
To:     Lexi Shao <shaolexi@huawei.com>, benh@kernel.crashing.org,
        paulus@samba.org, mpe@ellerman.id.au
Cc:     liucheng32@huawei.com, yi.zhang@huawei.com,
        wangkefeng.wang@huawei.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
References: <20191129070455.62084-1-shaolexi@huawei.com>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <fc48b5bc-45c1-e4e0-7b56-a23cc045ee0e@c-s.fr>
Date:   Fri, 29 Nov 2019 08:46:31 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191129070455.62084-1-shaolexi@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 29/11/2019 à 08:04, Lexi Shao a écrit :
> CONFIG_RELOCATABLE and CONFIG_KASAN cannot be enabled at the same time
> on ppce500 fsl_booke. All functions called before kasan_early_init()
> should be disabled with kasan check. When CONFIG_RELOCATABLE is enabled
> on ppce500 fsl_booke, relocate_init() is called before kasan_early_init()
> which triggers kasan check and results in boot failure.
> Call trace and functions which triggers kasan check(*):
>    - _start
>     - set_ivor
>      - relocate_init(*)
>       - early_get_first_memblock_info(*)
>        - of_scan_flat_dt(*)
> 	...
>      - kasan_early_init
> 
> Potential solutions could be 1. implement relocate_init and all its children
> function in a seperate file or 2. introduce a global vairable in KASAN, only
> enable KASAN check when init is done.

Solution 1 seems uneasy. of_scan_flat_dt() and children are general 
functions that can't be set aside.
Solution 2 would destroy performance, and would anyway not work with 
inline instrumentation.

Have you tried moving the call to kasan_early_init() before the call of 
relocate_init() ?
On other PPC32, kasan_early_init() is the first thing done after 
activating the MMU. But AFAIU, MMU is always active on BOOKE though.

Christophe

> 
> Disable KASAN when RELOCATABLE is selected on fsl_booke for now until
> it is supported.
> 
> Signed-off-by: Lexi Shao <shaolexi@huawei.com>
> ---
>   arch/powerpc/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 3e56c9c2f16e..14f3da63c088 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -171,7 +171,7 @@ config PPC
>   	select HAVE_ARCH_AUDITSYSCALL
>   	select HAVE_ARCH_HUGE_VMAP		if PPC_BOOK3S_64 && PPC_RADIX_MMU
>   	select HAVE_ARCH_JUMP_LABEL
> -	select HAVE_ARCH_KASAN			if PPC32
> +	select HAVE_ARCH_KASAN			if PPC32 && !(RELOCATABLE && FSL_BOOKE)
>   	select HAVE_ARCH_KGDB
>   	select HAVE_ARCH_MMAP_RND_BITS
>   	select HAVE_ARCH_MMAP_RND_COMPAT_BITS	if COMPAT
> 
