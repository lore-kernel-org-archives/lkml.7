Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05F01C31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 14:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD58A2166E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 14:29:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730010AbfFSO3B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 10:29:01 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45755 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbfFSO3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 10:29:00 -0400
Received: by mail-ot1-f68.google.com with SMTP id x21so19443255otq.12
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 07:28:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vKuhhu0U9b6dOInq0htudLnaWCBwc1Az//oZC0564RE=;
        b=dTVmFjvePHgkeL5ZLO6pDNrGkdcBpzJRipQ3OiRrB2TLMCiMLqA1XQYYstp4VCMTe6
         Plm2Vdzki1FhROdtL+EnIIKmU8/7gnMjAqemaUZfNPkXbZca5WMo0IY7kWyLg9gZm7Mh
         b5vlhbT3x7Egf3XlmKsNeoeIlFIhKIHWG39gmLmG9/S2qqQRG9raaVJ3A1uWhRQ6Qklz
         T4raXJeTmGK8/tA/66BRLKG/AKZRUbIgoJjkK1VdtiIvJ1JEjvTmQma1xzD0F3aeKdN2
         ts5Rg1Xyh1UiQ0pQNnyoqGF3uTegHijRxm8M3JpwLqgs/jdG4QjL8LAuPb/gwPMBwyJ5
         kBZA==
X-Gm-Message-State: APjAAAWgX1TCk7bA/0wgf5ZiHhzKCk0Ol/vUAI68m5xSdujFs/VUgm3l
        P6YRLCzpp0AlP+yTV8szJ9QWhDl5/Fq0cj744s8=
X-Google-Smtp-Source: APXvYqz0b/GK3kxwkGdOpEl7OTKj5RNpjvAo6j4fakCjJeVEWxAUbeK/4qjQ7RP8NLHM83NlVM5LrM7/PeKDXBLQV9E=
X-Received: by 2002:a9d:3b76:: with SMTP id z109mr66900579otb.335.1560954539353;
 Wed, 19 Jun 2019 07:28:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190613082446.18685-1-hch@lst.de> <20190619105039.GA10118@lst.de>
 <87tvcldacn.fsf@concordia.ellerman.id.au> <a5fc355e44fb5edea41274329f7c5d04a8dff6fc.camel@kernel.crashing.org>
In-Reply-To: <a5fc355e44fb5edea41274329f7c5d04a8dff6fc.camel@kernel.crashing.org>
From:   Mathieu Malaterre <malat@debian.org>
Date:   Wed, 19 Jun 2019 16:28:47 +0200
Message-ID: <CA+7wUsy78oRKsNBJqM494MZynC+aZd27D1ZcvMCCQmF2wu5-gw@mail.gmail.com>
Subject: Re: [PATCH] powerpc: enable a 30-bit ZONE_DMA for 32-bit pmac
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Christoph Hellwig <hch@lst.de>,
        Paul Mackerras <paulus@samba.org>, aaro.koskinen@iki.fi,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Larry Finger <Larry.Finger@lwfinger.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 19, 2019 at 4:18 PM Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
>
> On Wed, 2019-06-19 at 22:32 +1000, Michael Ellerman wrote:
> > Christoph Hellwig <hch@lst.de> writes:
> > > Any chance this could get picked up to fix the regression?
> >
> > Was hoping Ben would Ack it. He's still powermac maintainer :)
> >
> > I guess he OK'ed it in the other thread, will add it to my queue.
>
> Yeah ack. If I had written it myself, I would have made the DMA bits a
> variable and only set it down to 30 if I see that device in the DT
> early on, but I can't be bothered now, if it works, ship it :-)
>
> Note: The patch affects all ppc32, though I don't think it will cause
> any significant issue on those who don't need it.

Thanks, that answer my earlier question.

> Cheers,
> Ben.
>
> > cheers
> >
> > > On Thu, Jun 13, 2019 at 10:24:46AM +0200, Christoph Hellwig wrote:
> > > > With the strict dma mask checking introduced with the switch to
> > > > the generic DMA direct code common wifi chips on 32-bit
> > > > powerbooks
> > > > stopped working.  Add a 30-bit ZONE_DMA to the 32-bit pmac builds
> > > > to allow them to reliably allocate dma coherent memory.
> > > >
> > > > Fixes: 65a21b71f948 ("powerpc/dma: remove
> > > > dma_nommu_dma_supported")
> > > > Reported-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> > > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > > > ---
> > > >  arch/powerpc/include/asm/page.h         | 7 +++++++
> > > >  arch/powerpc/mm/mem.c                   | 3 ++-
> > > >  arch/powerpc/platforms/powermac/Kconfig | 1 +
> > > >  3 files changed, 10 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/arch/powerpc/include/asm/page.h
> > > > b/arch/powerpc/include/asm/page.h
> > > > index b8286a2013b4..0d52f57fca04 100644
> > > > --- a/arch/powerpc/include/asm/page.h
> > > > +++ b/arch/powerpc/include/asm/page.h
> > > > @@ -319,6 +319,13 @@ struct vm_area_struct;
> > > >  #endif /* __ASSEMBLY__ */
> > > >  #include <asm/slice.h>
> > > >
> > > > +/*
> > > > + * Allow 30-bit DMA for very limited Broadcom wifi chips on many
> > > > powerbooks.
> > > > + */
> > > > +#ifdef CONFIG_PPC32
> > > > +#define ARCH_ZONE_DMA_BITS 30
> > > > +#else
> > > >  #define ARCH_ZONE_DMA_BITS 31
> > > > +#endif
> > > >
> > > >  #endif /* _ASM_POWERPC_PAGE_H */
> > > > diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
> > > > index cba29131bccc..2540d3b2588c 100644
> > > > --- a/arch/powerpc/mm/mem.c
> > > > +++ b/arch/powerpc/mm/mem.c
> > > > @@ -248,7 +248,8 @@ void __init paging_init(void)
> > > >          (long int)((top_of_ram - total_ram) >> 20));
> > > >
> > > >  #ifdef CONFIG_ZONE_DMA
> > > > - max_zone_pfns[ZONE_DMA] = min(max_low_pfn, 0x7fffffffUL
> > > > >> PAGE_SHIFT);
> > > > + max_zone_pfns[ZONE_DMA] = min(max_low_pfn,
> > > > +                 ((1UL << ARCH_ZONE_DMA_BITS) - 1) >>
> > > > PAGE_SHIFT);
> > > >  #endif
> > > >   max_zone_pfns[ZONE_NORMAL] = max_low_pfn;
> > > >  #ifdef CONFIG_HIGHMEM
> > > > diff --git a/arch/powerpc/platforms/powermac/Kconfig
> > > > b/arch/powerpc/platforms/powermac/Kconfig
> > > > index f834a19ed772..c02d8c503b29 100644
> > > > --- a/arch/powerpc/platforms/powermac/Kconfig
> > > > +++ b/arch/powerpc/platforms/powermac/Kconfig
> > > > @@ -7,6 +7,7 @@ config PPC_PMAC
> > > >   select PPC_INDIRECT_PCI if PPC32
> > > >   select PPC_MPC106 if PPC32
> > > >   select PPC_NATIVE
> > > > + select ZONE_DMA if PPC32
> > > >   default y
> > > >
> > > >  config PPC_PMAC64
> > > > --
> > > > 2.20.1
> > >
> > > ---end quoted text---
>
