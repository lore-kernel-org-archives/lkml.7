Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8442C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 13:35:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A581D217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 13:35:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="X8JFkZaR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728604AbfEUNfb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 09:35:31 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:15825 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728053AbfEUNfa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 09:35:30 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 457cG727tyz9v1nk;
        Tue, 21 May 2019 15:35:27 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=X8JFkZaR; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id iOHAg-09oyuN; Tue, 21 May 2019 15:35:27 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 457cG70sqtz9v1nh;
        Tue, 21 May 2019 15:35:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1558445727; bh=XoYcNDgG9thqPcHt2Ww/YmYYOWyHSVGlf0rWpnQtXlk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=X8JFkZaRfoTRqwcGstExSi/f4XIJsRo1gjLSMDLaKlpnYhLctLd7eC1E8iaJ9Ef1h
         VLpXMypqCGU0HnsrKqsyPsZ0+XqIKa4/6VWSMHBtjayXJAq994TZNDggdaw9yhjTAb
         2e1M1c7I4L8KFWQL3k/CqhbwpfcZuljv2ZbwWSnQ=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 42C398B80C;
        Tue, 21 May 2019 15:35:28 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id LYbLXYWi8WHJ; Tue, 21 May 2019 15:35:28 +0200 (CEST)
Received: from PO15451 (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 4D61B8B803;
        Tue, 21 May 2019 15:35:27 +0200 (CEST)
Subject: Re: [PATCH v2] powerpc/mm: mark more tlb functions as __always_inline
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Gibson <david@gibson.dropbear.id.au>,
        Suraj Jitindar Singh <sjitindarsingh@gmail.com>,
        linux-kernel@vger.kernel.org
References: <1558444404-12254-1-git-send-email-yamada.masahiro@socionext.com>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <f49c9bce-c77d-709d-8920-e16c64963ad1@c-s.fr>
Date:   Tue, 21 May 2019 15:35:26 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1558444404-12254-1-git-send-email-yamada.masahiro@socionext.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 21/05/2019 à 15:13, Masahiro Yamada a écrit :
> With CONFIG_OPTIMIZE_INLINING enabled, Laura Abbott reported error
> with gcc 9.1.1:
> 
>    arch/powerpc/mm/book3s64/radix_tlb.c: In function '_tlbiel_pid':
>    arch/powerpc/mm/book3s64/radix_tlb.c:104:2: warning: asm operand 3 probably doesn't match constraints
>      104 |  asm volatile(PPC_TLBIEL(%0, %4, %3, %2, %1)
>          |  ^~~
>    arch/powerpc/mm/book3s64/radix_tlb.c:104:2: error: impossible constraint in 'asm'
> 
> Fixing _tlbiel_pid() is enough to address the warning above, but I
> inlined more functions to fix all potential issues.
> 
> To meet the "i" (immediate) constraint for the asm operands, functions
> propagating "ric" must be always inlined.
> 
> Fixes: 9012d011660e ("compiler: allow all arches to enable CONFIG_OPTIMIZE_INLINING")
> Reported-by: Laura Abbott <labbott@redhat.com>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Reviewed-by: Christophe Leroy <christophe.leroy@c-s.fr>

> ---
> 
> Changes in v2:
>    - Do not split lines
> 
>   arch/powerpc/mm/book3s64/hash_native.c |  2 +-
>   arch/powerpc/mm/book3s64/radix_tlb.c   | 32 ++++++++++++++++----------------
>   2 files changed, 17 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/powerpc/mm/book3s64/hash_native.c b/arch/powerpc/mm/book3s64/hash_native.c
> index aaa28fd..c854151 100644
> --- a/arch/powerpc/mm/book3s64/hash_native.c
> +++ b/arch/powerpc/mm/book3s64/hash_native.c
> @@ -60,7 +60,7 @@ static inline void tlbiel_hash_set_isa206(unsigned int set, unsigned int is)
>    * tlbiel instruction for hash, set invalidation
>    * i.e., r=1 and is=01 or is=10 or is=11
>    */
> -static inline void tlbiel_hash_set_isa300(unsigned int set, unsigned int is,
> +static __always_inline void tlbiel_hash_set_isa300(unsigned int set, unsigned int is,
>   					unsigned int pid,
>   					unsigned int ric, unsigned int prs)
>   {
> diff --git a/arch/powerpc/mm/book3s64/radix_tlb.c b/arch/powerpc/mm/book3s64/radix_tlb.c
> index 4d84136..4d3dc10 100644
> --- a/arch/powerpc/mm/book3s64/radix_tlb.c
> +++ b/arch/powerpc/mm/book3s64/radix_tlb.c
> @@ -29,7 +29,7 @@
>    * tlbiel instruction for radix, set invalidation
>    * i.e., r=1 and is=01 or is=10 or is=11
>    */
> -static inline void tlbiel_radix_set_isa300(unsigned int set, unsigned int is,
> +static __always_inline void tlbiel_radix_set_isa300(unsigned int set, unsigned int is,
>   					unsigned int pid,
>   					unsigned int ric, unsigned int prs)
>   {
> @@ -150,8 +150,8 @@ static __always_inline void __tlbie_lpid(unsigned long lpid, unsigned long ric)
>   	trace_tlbie(lpid, 0, rb, rs, ric, prs, r);
>   }
>   
> -static inline void __tlbiel_lpid_guest(unsigned long lpid, int set,
> -				unsigned long ric)
> +static __always_inline void __tlbiel_lpid_guest(unsigned long lpid, int set,
> +						unsigned long ric)
>   {
>   	unsigned long rb,rs,prs,r;
>   
> @@ -167,8 +167,8 @@ static inline void __tlbiel_lpid_guest(unsigned long lpid, int set,
>   }
>   
>   
> -static inline void __tlbiel_va(unsigned long va, unsigned long pid,
> -			       unsigned long ap, unsigned long ric)
> +static __always_inline void __tlbiel_va(unsigned long va, unsigned long pid,
> +					unsigned long ap, unsigned long ric)
>   {
>   	unsigned long rb,rs,prs,r;
>   
> @@ -183,8 +183,8 @@ static inline void __tlbiel_va(unsigned long va, unsigned long pid,
>   	trace_tlbie(0, 1, rb, rs, ric, prs, r);
>   }
>   
> -static inline void __tlbie_va(unsigned long va, unsigned long pid,
> -			      unsigned long ap, unsigned long ric)
> +static __always_inline void __tlbie_va(unsigned long va, unsigned long pid,
> +				       unsigned long ap, unsigned long ric)
>   {
>   	unsigned long rb,rs,prs,r;
>   
> @@ -199,8 +199,8 @@ static inline void __tlbie_va(unsigned long va, unsigned long pid,
>   	trace_tlbie(0, 0, rb, rs, ric, prs, r);
>   }
>   
> -static inline void __tlbie_lpid_va(unsigned long va, unsigned long lpid,
> -			      unsigned long ap, unsigned long ric)
> +static __always_inline void __tlbie_lpid_va(unsigned long va, unsigned long lpid,
> +					    unsigned long ap, unsigned long ric)
>   {
>   	unsigned long rb,rs,prs,r;
>   
> @@ -239,7 +239,7 @@ static inline void fixup_tlbie_lpid(unsigned long lpid)
>   /*
>    * We use 128 set in radix mode and 256 set in hpt mode.
>    */
> -static inline void _tlbiel_pid(unsigned long pid, unsigned long ric)
> +static __always_inline void _tlbiel_pid(unsigned long pid, unsigned long ric)
>   {
>   	int set;
>   
> @@ -341,7 +341,7 @@ static inline void _tlbie_lpid(unsigned long lpid, unsigned long ric)
>   	asm volatile("eieio; tlbsync; ptesync": : :"memory");
>   }
>   
> -static inline void _tlbiel_lpid_guest(unsigned long lpid, unsigned long ric)
> +static __always_inline void _tlbiel_lpid_guest(unsigned long lpid, unsigned long ric)
>   {
>   	int set;
>   
> @@ -381,8 +381,8 @@ static inline void __tlbiel_va_range(unsigned long start, unsigned long end,
>   		__tlbiel_va(addr, pid, ap, RIC_FLUSH_TLB);
>   }
>   
> -static inline void _tlbiel_va(unsigned long va, unsigned long pid,
> -			      unsigned long psize, unsigned long ric)
> +static __always_inline void _tlbiel_va(unsigned long va, unsigned long pid,
> +				       unsigned long psize, unsigned long ric)
>   {
>   	unsigned long ap = mmu_get_ap(psize);
>   
> @@ -413,8 +413,8 @@ static inline void __tlbie_va_range(unsigned long start, unsigned long end,
>   		__tlbie_va(addr, pid, ap, RIC_FLUSH_TLB);
>   }
>   
> -static inline void _tlbie_va(unsigned long va, unsigned long pid,
> -			      unsigned long psize, unsigned long ric)
> +static __always_inline void _tlbie_va(unsigned long va, unsigned long pid,
> +				      unsigned long psize, unsigned long ric)
>   {
>   	unsigned long ap = mmu_get_ap(psize);
>   
> @@ -424,7 +424,7 @@ static inline void _tlbie_va(unsigned long va, unsigned long pid,
>   	asm volatile("eieio; tlbsync; ptesync": : :"memory");
>   }
>   
> -static inline void _tlbie_lpid_va(unsigned long va, unsigned long lpid,
> +static __always_inline void _tlbie_lpid_va(unsigned long va, unsigned long lpid,
>   			      unsigned long psize, unsigned long ric)
>   {
>   	unsigned long ap = mmu_get_ap(psize);
> 
