Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5285AC76191
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 07:02:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2194720C01
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 07:02:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eyDaA6O8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729213AbfGOHCs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 03:02:48 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:35019 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbfGOHCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 03:02:48 -0400
Received: by mail-io1-f68.google.com with SMTP id m24so32495633ioo.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 00:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BpoaOxGfNMV1uUxQQh5QntULfOBecgOiJBIXLSXdHB0=;
        b=eyDaA6O8qdMDP464A/UrDozJRid/hMgeGOKKhxC6blrPxvq2YvWfY0MHrhncdpA5Wh
         hMm4Pwi4t9FO/WttA4o1Grk33gdprdYCz5IRHc/NxkUiltA+NSE0FxNXUX4attutHOnS
         iADtb1q/8QCnSM8TBdF7877NYvUVGpc64wUnhsFRieiT4gCtHTWRbhkmMFGcP8rEie/D
         Qq37Nz6o1PgHIQK2Wg3W0DifDP4QKKnGo0Ngqc5vtyXmjF1FLouyK9GoQQbx3o7LhklB
         S2DhX6repo0k9Nk8wDEEgjdYkQscp3LFG4b/n/6ojL7Wi4ClqzEFFaZwqPN419cxkNRy
         n0PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BpoaOxGfNMV1uUxQQh5QntULfOBecgOiJBIXLSXdHB0=;
        b=EzbZCvdMsgPF4xutR5Y7D4vJyYzc6cxcM16eLXC2yPoFJDO6mfQk7SrwRsiNh16gcg
         5JQedtgE8qAhEUL4f4Cau3DLXe+TfLnAMP9ADoIsjStk0BDIgRyui+BR58Dv7rCvTEVg
         cDs/Sg8uYT2YGZ2WI6h2WEK8Q79JEawbSeNshaBdHMoWjcMfCyY9JJQScOxuwt94IaTs
         wJoD9HXKEkfMkYbe/Vzmu2ga/G1w9166+goDuA8gUegZ/OrHaJnDYyHsxLa17ylViTRY
         2/BC/WI7Ig++TX9Kly4Jb6j+LxNhhoCdrSbmS+YyIRMb6MC95mI9rg9Q0yox27PBX1Vx
         P3ug==
X-Gm-Message-State: APjAAAWgj0plGWUMJD+nLPwCZayAU4fhXVgJZ3kzsLrHFvccJLsvRRFA
        XCuX+CzdQF58gAzcW7DOu4ZA8JYzf5HGO1/o/fg=
X-Google-Smtp-Source: APXvYqxtnasiTMyw0hV+yn8WYNlN6QA7cPFjX+XfXquyUtlzHBKVUop1Sxshn9HafcgOaycIi4fbD+6sk9S5r4g3Zs0=
X-Received: by 2002:a5d:8404:: with SMTP id i4mr19926458ion.146.1563174167458;
 Mon, 15 Jul 2019 00:02:47 -0700 (PDT)
MIME-Version: 1.0
References: <239d1c8f15b8bedc161a234f9f1a22a07160dbdf.1557824379.git.christophe.leroy@c-s.fr>
 <0e779b35cf66fd4aa5ec0ec09fb7820f6c518cb3.1557824379.git.christophe.leroy@c-s.fr>
 <87y30z94hp.fsf@concordia.ellerman.id.au>
In-Reply-To: <87y30z94hp.fsf@concordia.ellerman.id.au>
From:   "Oliver O'Halloran" <oohall@gmail.com>
Date:   Mon, 15 Jul 2019 17:02:36 +1000
Message-ID: <CAOSf1CGB0k6qTN_uFtSoNBTs5Vt89n0_vLoRFLytq8OSfy7w6A@mail.gmail.com>
Subject: Re: [PATCH 2/4] powerpc/32: activate ARCH_HAS_PMEM_API and ARCH_HAS_UACCESS_FLUSHCACHE
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 15, 2019 at 4:49 PM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> Christophe Leroy <christophe.leroy@c-s.fr> writes:
> > PPC32 also have flush_dcache_range() so it can also support
> > ARCH_HAS_PMEM_API and ARCH_HAS_UACCESS_FLUSHCACHE without changes.
> >
> > Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> > ---
> >  arch/powerpc/Kconfig | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> > index d7996cfaceca..cf6e30f637be 100644
> > --- a/arch/powerpc/Kconfig
> > +++ b/arch/powerpc/Kconfig
> > @@ -127,13 +127,13 @@ config PPC
> >       select ARCH_HAS_KCOV
> >       select ARCH_HAS_MMIOWB                  if PPC64
> >       select ARCH_HAS_PHYS_TO_DMA
> > -     select ARCH_HAS_PMEM_API                if PPC64
> > +     select ARCH_HAS_PMEM_API
> >       select ARCH_HAS_PTE_SPECIAL
> >       select ARCH_HAS_MEMBARRIER_CALLBACKS
> >       select ARCH_HAS_SCALED_CPUTIME          if VIRT_CPU_ACCOUNTING_NATIVE && PPC64
> >       select ARCH_HAS_STRICT_KERNEL_RWX       if ((PPC_BOOK3S_64 || PPC32) && !RELOCATABLE && !HIBERNATION)
> >       select ARCH_HAS_TICK_BROADCAST          if GENERIC_CLOCKEVENTS_BROADCAST
> > -     select ARCH_HAS_UACCESS_FLUSHCACHE      if PPC64
> > +     select ARCH_HAS_UACCESS_FLUSHCACHE
> >       select ARCH_HAS_UBSAN_SANITIZE_ALL
> >       select ARCH_HAS_ZONE_DEVICE             if PPC_BOOK3S_64
> >       select ARCH_HAVE_NMI_SAFE_CMPXCHG
>
> This didn't build for me, probably due to something that's changed in
> the long period between you posting it and me applying it?
>
> corenet32_smp_defconfig:
>
>   powerpc64-unknown-linux-gnu-ld: lib/iov_iter.o: in function `_copy_from_iter_flushcache':
>   powerpc64-unknown-linux-gnu-ld: /scratch/michael/build/maint/build~/../lib/iov_iter.c:825: undefined reference to `memcpy_page_flushcache'
>   powerpc64-unknown-linux-gnu-ld: /scratch/michael/build/maint/build~/../lib/iov_iter.c:825: undefined reference to `memcpy_flushcache'
>   powerpc64-unknown-linux-gnu-ld: /scratch/michael/build/maint/build~/../lib/iov_iter.c:825: undefined reference to `__copy_from_user_flushcache'
>   powerpc64-unknown-linux-gnu-ld: /scratch/michael/build/maint/build~/../lib/iov_iter.c:825: undefined reference to `memcpy_flushcache'

I think lib/pmem.c just needs to be moved out of obj64-y.

>
> cheers
