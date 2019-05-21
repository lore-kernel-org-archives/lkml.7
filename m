Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AFD8C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 07:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A4EE208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 07:28:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="QHRkxn0F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbfEUH2l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 03:28:41 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:24169 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbfEUH2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 03:28:41 -0400
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id x4L7SZOc014671
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 16:28:36 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com x4L7SZOc014671
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1558423716;
        bh=0IneFBogau5aTVTnVikpfnfxhfGGg+m93gGHEDBBT2M=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QHRkxn0FpgpJZytlIwzPKDd3Ewp7E96EMiaXKx04L5m20+rs2i+/xzPh9P4Bn3AGP
         dSAH2Tp/Y0B5hFIftuFoSYre1GsGB+N02T2RlttHQjOfgVts9R3tRy7I9CnIebiN6r
         d2Y7jufk26xmCn9rAW1di/3tO5jVXS61BrO8xrCpXS0txhn4+g6PNHUFEwi4oGaBTW
         6a5mO8qI7MlnjDOhC1XaXJEn22JFnIZprf4eGjbDI3iWMTAf4E4fQS5D/x4AxhkfP1
         nsveLUyoPyTqHlgLtgb+LOx+dRwKwVtCmewTYD/yfeUtRAmK/AH7TpfrEMk02KS7jS
         50hvs4K3ITXaA==
X-Nifty-SrcIP: [209.85.222.43]
Received: by mail-ua1-f43.google.com with SMTP id 7so875002uah.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 00:28:35 -0700 (PDT)
X-Gm-Message-State: APjAAAUk9AS9LqpADk537INXRaACtBaOO5Q7x4YbwtMZyRFRbuzuXl7n
        rjRN1Ix9lYymsMp37X7rnK/9Fqedb38ehz7njzc=
X-Google-Smtp-Source: APXvYqznP8e8GHshxPJUqQetjFmjBhvHA7Y6dMmw1D+/xm5qDgis9mpan+zseql9QUlQ9+O+cjn+NxLo59SYDBiSIYI=
X-Received: by 2002:a9f:24a3:: with SMTP id 32mr15884042uar.109.1558423714533;
 Tue, 21 May 2019 00:28:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190521061659.6073-1-yamada.masahiro@socionext.com> <16d967dd-9f8f-4e9e-97fd-3f9761e5d97c@c-s.fr>
In-Reply-To: <16d967dd-9f8f-4e9e-97fd-3f9761e5d97c@c-s.fr>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 21 May 2019 16:27:58 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQNp+wsvNK84oYcGwR24=Kf=_N8WJdyZ2aUL9T3qDsVsA@mail.gmail.com>
Message-ID: <CAK7LNAQNp+wsvNK84oYcGwR24=Kf=_N8WJdyZ2aUL9T3qDsVsA@mail.gmail.com>
Subject: Re: [PATCH] powerpc/mm: mark more tlb functions as __always_inline
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2019 at 3:54 PM Christophe Leroy
<christophe.leroy@c-s.fr> wrote:
>
>
>
> Le 21/05/2019 =C3=A0 08:16, Masahiro Yamada a =C3=A9crit :
> > With CONFIG_OPTIMIZE_INLINING enabled, Laura Abbott reported error
> > with gcc 9.1.1:
> >
> >    arch/powerpc/mm/book3s64/radix_tlb.c: In function '_tlbiel_pid':
> >    arch/powerpc/mm/book3s64/radix_tlb.c:104:2: warning: asm operand 3 p=
robably doesn't match constraints
> >      104 |  asm volatile(PPC_TLBIEL(%0, %4, %3, %2, %1)
> >          |  ^~~
> >    arch/powerpc/mm/book3s64/radix_tlb.c:104:2: error: impossible constr=
aint in 'asm'
> >
> > Fixing _tlbiel_pid() is enough to address the warning above, but I
> > inlined more functions to fix all potential issues.
> >
> > To meet the 'i' (immediate) constraint for the asm operands, functions
> > propagating propagated 'ric' must be always inlined.
> >
> > Fixes: 9012d011660e ("compiler: allow all arches to enable CONFIG_OPTIM=
IZE_INLINING")
> > Reported-by: Laura Abbott <labbott@redhat.com>
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > ---
> >
> >   arch/powerpc/mm/book3s64/hash_native.c |  8 +++--
> >   arch/powerpc/mm/book3s64/radix_tlb.c   | 44 +++++++++++++++----------=
-
> >   2 files changed, 30 insertions(+), 22 deletions(-)
> >
> > diff --git a/arch/powerpc/mm/book3s64/hash_native.c b/arch/powerpc/mm/b=
ook3s64/hash_native.c
> > index aaa28fd918fe..bc2c35c0d2b1 100644
> > --- a/arch/powerpc/mm/book3s64/hash_native.c
> > +++ b/arch/powerpc/mm/book3s64/hash_native.c
> > @@ -60,9 +60,11 @@ static inline void tlbiel_hash_set_isa206(unsigned i=
nt set, unsigned int is)
> >    * tlbiel instruction for hash, set invalidation
> >    * i.e., r=3D1 and is=3D01 or is=3D10 or is=3D11
> >    */
> > -static inline void tlbiel_hash_set_isa300(unsigned int set, unsigned i=
nt is,
> > -                                     unsigned int pid,
> > -                                     unsigned int ric, unsigned int pr=
s)
> > +static __always_inline void tlbiel_hash_set_isa300(unsigned int set,
> > +                                                unsigned int is,
> > +                                                unsigned int pid,
> > +                                                unsigned int ric,
> > +                                                unsigned int prs)
>
> Please don't split the line more than it is.
>
> powerpc accepts lines up to 90 chars, see arch/powerpc/tools/checkpatch.p=
l

Ugh, I did not know this. Horrible.

The Linux coding style should be global in the kernel tree.
No subsystem should adopts its own coding style.


--=20
Best Regards
Masahiro Yamada
