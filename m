Return-Path: <SRS0=VFBv=UW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70A43C43613
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 14:10:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F14020663
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 14:10:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="XT80z7eL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbfFWOJx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 10:09:53 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:38265 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbfFWOJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 10:09:53 -0400
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id x5NE9iFp021214
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2019 23:09:44 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com x5NE9iFp021214
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1561298985;
        bh=7DrdzqGtK5Y7N0S66FZgjsMEvNefGAC5fLt9hgMKs4M=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XT80z7eLGgOQnrgsK30BjntfvHfVOaknd7EyGUqr6EGIdXf8bWKkk6ZT0juw2Q4cj
         9kR3233maD9iRLPFQ1aaYRFEv1fc03KjZxLQicR4W8WsAf+YtwlBq5HSIWdNJs1wl0
         +5W+O0qseaoSezdRdKbJ2HunH0XqmntmnRjMsHf12tSIRDiVSYgzUOu/BoVcb722rM
         Q2u4JVp5eoPFGaYZxWOo/mjmpe1PMkgtYYzdI2u0GyKp0OqrVSEcigFXg9UfcUCUMn
         EmGQmMSR0zo2sGtpF7wxRW0Pce/PB9x7rnIu9ooVR/+GEpfsRJxLCtqWhDMOKMN8YP
         AN1DMRg4lyrGQ==
X-Nifty-SrcIP: [209.85.222.46]
Received: by mail-ua1-f46.google.com with SMTP id c4so4748026uad.1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2019 07:09:44 -0700 (PDT)
X-Gm-Message-State: APjAAAV7jM7Px1ELRnAxNqo22OqoOg6LToX5Q8zKRfcjlm8ojbeGqsHJ
        NX/mXyUgIfQQb4QxjhUB1cjUA5yREJA8De2YnIQ=
X-Google-Smtp-Source: APXvYqwLqOxLA12mww6wVSFtva4zQ7F/DVpEIq5zBS5i1DRrlXlbYvKX+Wt0iogyjnmX8slY85KwVV+l5bvhf+llGUg=
X-Received: by 2002:a9f:25e9:: with SMTP id 96mr65484522uaf.95.1561298983528;
 Sun, 23 Jun 2019 07:09:43 -0700 (PDT)
MIME-Version: 1.0
References: <1558444404-12254-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1558444404-12254-1-git-send-email-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sun, 23 Jun 2019 23:09:07 +0900
X-Gmail-Original-Message-ID: <CAK7LNARoHtS0aqO9NCvwxAstJQxfeXhaWvh=1MQD3Wje8Pnmtw@mail.gmail.com>
Message-ID: <CAK7LNARoHtS0aqO9NCvwxAstJQxfeXhaWvh=1MQD3Wje8Pnmtw@mail.gmail.com>
Subject: Re: [PATCH v2] powerpc/mm: mark more tlb functions as __always_inline
To:     Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Gibson <david@gibson.dropbear.id.au>,
        Suraj Jitindar Singh <sjitindarsingh@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2019 at 10:19 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> With CONFIG_OPTIMIZE_INLINING enabled, Laura Abbott reported error
> with gcc 9.1.1:
>
>   arch/powerpc/mm/book3s64/radix_tlb.c: In function '_tlbiel_pid':
>   arch/powerpc/mm/book3s64/radix_tlb.c:104:2: warning: asm operand 3 probably doesn't match constraints
>     104 |  asm volatile(PPC_TLBIEL(%0, %4, %3, %2, %1)
>         |  ^~~
>   arch/powerpc/mm/book3s64/radix_tlb.c:104:2: error: impossible constraint in 'asm'
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
> ---

Ping.
This missed the recent PR, but
I believe this should be fixed.

Thanks.

>
> Changes in v2:
>   - Do not split lines
>
>  arch/powerpc/mm/book3s64/hash_native.c |  2 +-
>  arch/powerpc/mm/book3s64/radix_tlb.c   | 32 ++++++++++++++++----------------
>  2 files changed, 17 insertions(+), 17 deletions(-)
>
> diff --git a/arch/powerpc/mm/book3s64/hash_native.c b/arch/powerpc/mm/book3s64/hash_native.c
> index aaa28fd..c854151 100644
> --- a/arch/powerpc/mm/book3s64/hash_native.c
> +++ b/arch/powerpc/mm/book3s64/hash_native.c
> @@ -60,7 +60,7 @@ static inline void tlbiel_hash_set_isa206(unsigned int set, unsigned int is)
>   * tlbiel instruction for hash, set invalidation
>   * i.e., r=1 and is=01 or is=10 or is=11
>   */
> -static inline void tlbiel_hash_set_isa300(unsigned int set, unsigned int is,
> +static __always_inline void tlbiel_hash_set_isa300(unsigned int set, unsigned int is,
>                                         unsigned int pid,
>                                         unsigned int ric, unsigned int prs)
>  {
> diff --git a/arch/powerpc/mm/book3s64/radix_tlb.c b/arch/powerpc/mm/book3s64/radix_tlb.c
> index 4d84136..4d3dc10 100644
> --- a/arch/powerpc/mm/book3s64/radix_tlb.c
> +++ b/arch/powerpc/mm/book3s64/radix_tlb.c
> @@ -29,7 +29,7 @@
>   * tlbiel instruction for radix, set invalidation
>   * i.e., r=1 and is=01 or is=10 or is=11
>   */
> -static inline void tlbiel_radix_set_isa300(unsigned int set, unsigned int is,
> +static __always_inline void tlbiel_radix_set_isa300(unsigned int set, unsigned int is,
>                                         unsigned int pid,
>                                         unsigned int ric, unsigned int prs)
>  {
> @@ -150,8 +150,8 @@ static __always_inline void __tlbie_lpid(unsigned long lpid, unsigned long ric)
>         trace_tlbie(lpid, 0, rb, rs, ric, prs, r);
>  }
>
> -static inline void __tlbiel_lpid_guest(unsigned long lpid, int set,
> -                               unsigned long ric)
> +static __always_inline void __tlbiel_lpid_guest(unsigned long lpid, int set,
> +                                               unsigned long ric)
>  {
>         unsigned long rb,rs,prs,r;
>
> @@ -167,8 +167,8 @@ static inline void __tlbiel_lpid_guest(unsigned long lpid, int set,
>  }
>
>
> -static inline void __tlbiel_va(unsigned long va, unsigned long pid,
> -                              unsigned long ap, unsigned long ric)
> +static __always_inline void __tlbiel_va(unsigned long va, unsigned long pid,
> +                                       unsigned long ap, unsigned long ric)
>  {
>         unsigned long rb,rs,prs,r;
>
> @@ -183,8 +183,8 @@ static inline void __tlbiel_va(unsigned long va, unsigned long pid,
>         trace_tlbie(0, 1, rb, rs, ric, prs, r);
>  }
>
> -static inline void __tlbie_va(unsigned long va, unsigned long pid,
> -                             unsigned long ap, unsigned long ric)
> +static __always_inline void __tlbie_va(unsigned long va, unsigned long pid,
> +                                      unsigned long ap, unsigned long ric)
>  {
>         unsigned long rb,rs,prs,r;
>
> @@ -199,8 +199,8 @@ static inline void __tlbie_va(unsigned long va, unsigned long pid,
>         trace_tlbie(0, 0, rb, rs, ric, prs, r);
>  }
>
> -static inline void __tlbie_lpid_va(unsigned long va, unsigned long lpid,
> -                             unsigned long ap, unsigned long ric)
> +static __always_inline void __tlbie_lpid_va(unsigned long va, unsigned long lpid,
> +                                           unsigned long ap, unsigned long ric)
>  {
>         unsigned long rb,rs,prs,r;
>
> @@ -239,7 +239,7 @@ static inline void fixup_tlbie_lpid(unsigned long lpid)
>  /*
>   * We use 128 set in radix mode and 256 set in hpt mode.
>   */
> -static inline void _tlbiel_pid(unsigned long pid, unsigned long ric)
> +static __always_inline void _tlbiel_pid(unsigned long pid, unsigned long ric)
>  {
>         int set;
>
> @@ -341,7 +341,7 @@ static inline void _tlbie_lpid(unsigned long lpid, unsigned long ric)
>         asm volatile("eieio; tlbsync; ptesync": : :"memory");
>  }
>
> -static inline void _tlbiel_lpid_guest(unsigned long lpid, unsigned long ric)
> +static __always_inline void _tlbiel_lpid_guest(unsigned long lpid, unsigned long ric)
>  {
>         int set;
>
> @@ -381,8 +381,8 @@ static inline void __tlbiel_va_range(unsigned long start, unsigned long end,
>                 __tlbiel_va(addr, pid, ap, RIC_FLUSH_TLB);
>  }
>
> -static inline void _tlbiel_va(unsigned long va, unsigned long pid,
> -                             unsigned long psize, unsigned long ric)
> +static __always_inline void _tlbiel_va(unsigned long va, unsigned long pid,
> +                                      unsigned long psize, unsigned long ric)
>  {
>         unsigned long ap = mmu_get_ap(psize);
>
> @@ -413,8 +413,8 @@ static inline void __tlbie_va_range(unsigned long start, unsigned long end,
>                 __tlbie_va(addr, pid, ap, RIC_FLUSH_TLB);
>  }
>
> -static inline void _tlbie_va(unsigned long va, unsigned long pid,
> -                             unsigned long psize, unsigned long ric)
> +static __always_inline void _tlbie_va(unsigned long va, unsigned long pid,
> +                                     unsigned long psize, unsigned long ric)
>  {
>         unsigned long ap = mmu_get_ap(psize);
>
> @@ -424,7 +424,7 @@ static inline void _tlbie_va(unsigned long va, unsigned long pid,
>         asm volatile("eieio; tlbsync; ptesync": : :"memory");
>  }
>
> -static inline void _tlbie_lpid_va(unsigned long va, unsigned long lpid,
> +static __always_inline void _tlbie_lpid_va(unsigned long va, unsigned long lpid,
>                               unsigned long psize, unsigned long ric)
>  {
>         unsigned long ap = mmu_get_ap(psize);
> --
> 2.7.4
>


-- 
Best Regards
Masahiro Yamada
