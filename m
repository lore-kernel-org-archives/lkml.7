Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96363C3A5A8
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 06:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E1C1215EA
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 06:21:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="h45CkPWo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727255AbfICGV5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 02:21:57 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:62070 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725919AbfICGV5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 02:21:57 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 46MxgQ3B6xzB09ZG;
        Tue,  3 Sep 2019 08:21:54 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=h45CkPWo; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id PtKxy15SB0Br; Tue,  3 Sep 2019 08:21:54 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 46MxgQ1prczB09ZC;
        Tue,  3 Sep 2019 08:21:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1567491714; bh=h5hnU1hsq4biEly8U4JQAFzas83dMfNa9k2nCVtK7tY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=h45CkPWoTzyoKFVn9Nc2M8HOq5pLKsqSVRdHx2mrovdONdgHRr0tMeGiyQLfJagB6
         w5OqF7hKXVCWMK3h+NHD+9raP2qPJa31UY1nZcI0+gjCvdXJFMDNlwmvQadEj/sd9r
         bG/ibTuw/ulnmma6iBpuJZaUUl8VLO6PKHwxViiU=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 234418B7A3;
        Tue,  3 Sep 2019 08:21:55 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id GESt_EghkgFG; Tue,  3 Sep 2019 08:21:55 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id EDD568B761;
        Tue,  3 Sep 2019 08:21:53 +0200 (CEST)
Subject: Re: [PATCH v2 5/6] powerpc: Remove 'extern' from func prototypes in
 cache headers
To:     Alastair D'Silva <alastair@au1.ibm.com>, alastair@d-silva.org
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>, Qian Cai <cai@lca.pw>,
        Nicholas Piggin <npiggin@gmail.com>,
        Allison Randal <allison@lohutok.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20190903052407.16638-1-alastair@au1.ibm.com>
 <20190903052407.16638-6-alastair@au1.ibm.com>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <1a59f400-7e04-ef34-9b9e-eb5143fe261c@c-s.fr>
Date:   Tue, 3 Sep 2019 08:21:53 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190903052407.16638-6-alastair@au1.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 03/09/2019 à 07:23, Alastair D'Silva a écrit :
> From: Alastair D'Silva <alastair@d-silva.org>
> 
> The 'extern' keyword does not value-add for function prototypes.

Is it worth it ? That kind of change is nice cleanup but the drawback is 
to kill automatic backports of fixes.

> 
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> ---
>   arch/powerpc/include/asm/cache.h      | 8 ++++----
>   arch/powerpc/include/asm/cacheflush.h | 6 +++---
>   2 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/cache.h b/arch/powerpc/include/asm/cache.h
> index 91c808c6738b..54fffdf5a6ec 100644
> --- a/arch/powerpc/include/asm/cache.h
> +++ b/arch/powerpc/include/asm/cache.h
> @@ -102,10 +102,10 @@ static inline u32 l1_icache_bytes(void)
>   #define __read_mostly __attribute__((__section__(".data..read_mostly")))
>   
>   #ifdef CONFIG_PPC_BOOK3S_32
> -extern long _get_L2CR(void);
> -extern long _get_L3CR(void);
> -extern void _set_L2CR(unsigned long);
> -extern void _set_L3CR(unsigned long);
> +long _get_L2CR(void);
> +long _get_L3CR(void);
> +void _set_L2CR(unsigned long val);
> +void _set_L3CR(unsigned long val);
>   #else
>   #define _get_L2CR()	0L
>   #define _get_L3CR()	0L
> diff --git a/arch/powerpc/include/asm/cacheflush.h b/arch/powerpc/include/asm/cacheflush.h
> index 4a1c9f0200e1..fa10dc19206c 100644
> --- a/arch/powerpc/include/asm/cacheflush.h
> +++ b/arch/powerpc/include/asm/cacheflush.h
> @@ -38,15 +38,15 @@ static inline void flush_cache_vmap(unsigned long start, unsigned long end) { }
>   #endif
>   
>   #define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 1
> -extern void flush_dcache_page(struct page *page);
> +void flush_dcache_page(struct page *page);
>   #define flush_dcache_mmap_lock(mapping)		do { } while (0)
>   #define flush_dcache_mmap_unlock(mapping)	do { } while (0)
>   
>   void flush_icache_range(unsigned long start, unsigned long stop);
> -extern void flush_icache_user_range(struct vm_area_struct *vma,
> +void flush_icache_user_range(struct vm_area_struct *vma,
>   				    struct page *page, unsigned long addr,
>   				    int len);

You have to re-align the other parameters to the ( of the first line.

> -extern void flush_dcache_icache_page(struct page *page);
> +void flush_dcache_icache_page(struct page *page);
>   void __flush_dcache_icache(void *page);
>   
>   /**
> 

Christophe
