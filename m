Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3D72C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 07:38:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B82E1205F4
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 07:38:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="g6fjTQ0J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbfECHiK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 03:38:10 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:53716 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725809AbfECHiK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 03:38:10 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 44wPB63Wcfz9vFVp;
        Fri,  3 May 2019 09:38:06 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=g6fjTQ0J; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id Q6TCMmlYgt_T; Fri,  3 May 2019 09:38:06 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 44wPB62PVJz9vFVk;
        Fri,  3 May 2019 09:38:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1556869086; bh=22Xq3HEvd6Yru88xMDUMXzEqbO1waVFeR8bEmAMWSqI=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
        b=g6fjTQ0JL6fwAUUHq8KpW3v/DHKD9rNsQD9jXKP6PVsqfF71wJQKid60dMBEjOjo/
         CoL7j3j9LGBMaJdHGjv1jKHgt9s8cdw2G2D4RCHc+zjKGifCuOHw1si6VIDL07vOJg
         jd6jSKg4onNj6/g1KOMELNwy1JLElux28bsad5iw=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 556958B888;
        Fri,  3 May 2019 09:38:07 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id ppmZKOEr5jsr; Fri,  3 May 2019 09:38:07 +0200 (CEST)
Received: from PO15451 (po15451.idsi0.si.c-s.fr [172.25.231.6])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 0CA268B853;
        Fri,  3 May 2019 09:38:07 +0200 (CEST)
Subject: Re: [PATCH v11 09/13] powerpc: disable KASAN instrumentation on
 early/critical files.
From:   Christophe Leroy <christophe.leroy@c-s.fr>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Daniel Axtens <dja@axtens.net>
Cc:     linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com
References: <cover.1556295459.git.christophe.leroy@c-s.fr>
 <867c149e77f80e855a9310a490fb15ca03ffd63d.1556295461.git.christophe.leroy@c-s.fr>
Message-ID: <5cff9551-e0ce-a2a4-989c-6b55825fa171@c-s.fr>
Date:   Fri, 3 May 2019 09:38:06 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <867c149e77f80e855a9310a490fb15ca03ffd63d.1556295461.git.christophe.leroy@c-s.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 26/04/2019 à 18:23, Christophe Leroy a écrit :
> All files containing functions run before kasan_early_init() is called
> must have KASAN instrumentation disabled.
> 
> For those file, branch profiling also have to be disabled otherwise
> each if () generates a call to ftrace_likely_update().
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>   arch/powerpc/kernel/Makefile             | 12 ++++++++++++
>   arch/powerpc/lib/Makefile                |  8 ++++++++
>   arch/powerpc/mm/Makefile                 |  6 ++++++
>   arch/powerpc/platforms/powermac/Makefile |  6 ++++++
>   arch/powerpc/purgatory/Makefile          |  3 +++
>   arch/powerpc/xmon/Makefile               |  1 +
>   6 files changed, 36 insertions(+)
> 

[...]

> diff --git a/arch/powerpc/mm/Makefile b/arch/powerpc/mm/Makefile
> index 3c1bd9fa23cd..dd945ca869b2 100644
> --- a/arch/powerpc/mm/Makefile
> +++ b/arch/powerpc/mm/Makefile
> @@ -7,6 +7,12 @@ ccflags-$(CONFIG_PPC64)	:= $(NO_MINIMAL_TOC)
>   
>   CFLAGS_REMOVE_slb.o = $(CC_FLAGS_FTRACE)
>   
> +KASAN_SANITIZE_ppc_mmu_32.o := n
> +
> +ifdef CONFIG_KASAN
> +CFLAGS_ppc_mmu_32.o  		+= -DDISABLE_BRANCH_PROFILING
> +endif
> +

The above is missing in powerpc/next (should now be in 
arch/powerpc/mm/book3s32/Makefile )

Christophe
