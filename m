Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E342C3A5A0
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 07:29:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7403B2332A
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 07:29:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kK904OuK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728263AbfHUH3s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 03:29:48 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33079 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728235AbfHUH3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 03:29:48 -0400
Received: by mail-wm1-f66.google.com with SMTP id p77so4112488wme.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 00:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nKOeCy3Qcia3Pbgp+4T8KWWXoItnNEc3EaF4utxPSx4=;
        b=kK904OuKS3Z8eMv0x8Na8g7IPPgNprXCORczmb6V/kXExPgWnxBAxCQbxF+TAphd8J
         nwjdYXpn0F7I+V4GIiKpnFEVTDThLbQ+OBnq3QrtTlGHq273IzR3HTTp2aO9cNm4qn4E
         Vx6HjcgcZj3/l9DKUp7U69jiCwDJQ5J8Cq2gY/u+HwExBsYQx9jmguM8rg+5fMMRa58C
         SGWtuI44qH0puyTaWmBrYyzulee73OvRhuNGjLxSZ/cxc1NO56LLMhvIPCdhr2Ba3aBT
         J8aytWr9dUsMKirAYbKOBij174iq/ssCpyrAybzZGPiB7Gps00VjkACWNSO2a6jE4iUe
         pfFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nKOeCy3Qcia3Pbgp+4T8KWWXoItnNEc3EaF4utxPSx4=;
        b=rnQF+pSox7caIY2oQvrreMjJ/wJ9PiCIgmTa9FSzvGKPeHpSqUKH31cbR0Gs0fAIkP
         b9QKIvhl0NFCj6Ihg7sEtYema8OChdIYbcmQ72Cjb6gcadq58PI6W6mUL214IwAY+D6n
         AQkZ32I2/NBceJCs7d7hfQyoU4Ax74ud/Y7pzsnn8I0n5xZyBA37DjoTfrDPkdye6LTa
         uGTruyEae36gvZ38HqgCTZifpy/OoJTxmCkUR2xk8dSTaGSOdwI6tfIUOmzOi0E7n6D6
         Ixq2l5JpB6Cme8+AO4D+8Xbn7PSB6ZyrJE0X+hdsJU8n9fSqrEjGz28ZXYEW9PuL7wng
         Femg==
X-Gm-Message-State: APjAAAWAAw//GCN/W72zeAxudZHcq5Q68B05YwSOwWIN52s0iBly3U3o
        o9D/fNKH/93cP4dVzj7DGdbWJpsosgvFhJgLLbC20g==
X-Google-Smtp-Source: APXvYqwr0nEjmLtPxp9jPzcCElAX7fest218vtFNqRK9Hh8HPkq4tF2BdQkHv6NmMu6fNQdhJczPGiJW0nzPMwhbGtg=
X-Received: by 2002:a05:600c:231a:: with SMTP id 26mr4057110wmo.136.1566372585757;
 Wed, 21 Aug 2019 00:29:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190802053744.5519-1-clin@suse.com> <20190820115645.GP13294@shell.armlinux.org.uk>
 <CAKv+Gu_0wFw5Mjpdw7BEY7ewgetNgU=Ff1uvAsn0iHmJouyKqw@mail.gmail.com>
 <20190821061027.GA2828@linux-8mug> <CAKv+Gu8Yny8cVPck3rPwCPvJBvcZKMHti_9bkCTM4H4cZ_43fg@mail.gmail.com>
 <20190821071100.GA26713@rapoport-lnx>
In-Reply-To: <20190821071100.GA26713@rapoport-lnx>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 21 Aug 2019 10:29:37 +0300
Message-ID: <CAKv+Gu99z3V1B68CU8qhNwwffqDxNBOM6t3Q8-V7qpbDkf-Cwg@mail.gmail.com>
Subject: Re: [PATCH] efi/arm: fix allocation failure when reserving the kernel base
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Chester Lin <clin@suse.com>, Juergen Gross <JGross@suse.com>,
        Joey Lee <JLee@suse.com>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "guillaume.gardet@arm.com" <guillaume.gardet@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        "geert@linux-m68k.org" <geert@linux-m68k.org>,
        "ren_guo@c-sky.com" <ren_guo@c-sky.com>, Gary Lin <GLin@suse.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Aug 2019 at 10:11, Mike Rapoport <rppt@linux.ibm.com> wrote:
>
> On Wed, Aug 21, 2019 at 09:35:16AM +0300, Ard Biesheuvel wrote:
> > On Wed, 21 Aug 2019 at 09:11, Chester Lin <clin@suse.com> wrote:
> > >
> > > On Tue, Aug 20, 2019 at 03:28:25PM +0300, Ard Biesheuvel wrote:
> > > > On Tue, 20 Aug 2019 at 14:56, Russell King - ARM Linux admin
> > > > <linux@armlinux.org.uk> wrote:
> > > > >
> > > > > On Fri, Aug 02, 2019 at 05:38:54AM +0000, Chester Lin wrote:
> > > > > > diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
> > > > > > index f3ce34113f89..909b11ba48d8 100644
> > > > > > --- a/arch/arm/mm/mmu.c
> > > > > > +++ b/arch/arm/mm/mmu.c
> > > > > > @@ -1184,6 +1184,9 @@ void __init adjust_lowmem_bounds(void)
> > > > > >               phys_addr_t block_start = reg->base;
> > > > > >               phys_addr_t block_end = reg->base + reg->size;
> > > > > >
> > > > > > +             if (memblock_is_nomap(reg))
> > > > > > +                     continue;
> > > > > > +
> > > > > >               if (reg->base < vmalloc_limit) {
> > > > > >                       if (block_end > lowmem_limit)
> > > > > >                               /*
> > > > >
> > > > > I think this hunk is sane - if the memory is marked nomap, then it isn't
> > > > > available for the kernel's use, so as far as calculating where the
> > > > > lowmem/highmem boundary is, it effectively doesn't exist and should be
> > > > > skipped.
> > > > >
> > > >
> > > > I agree.
> > > >
> > > > Chester, could you explain what you need beyond this change (and my
> > > > EFI stub change involving TEXT_OFFSET) to make things work on the
> > > > RPi2?
> > > >
> > >
> > > Hi Ard,
> > >
> > > In fact I am working with Guillaume to try booting zImage kernel and openSUSE
> > > from grub2.04 + arm32-efistub so that's why we get this issue on RPi2, which is
> > > one of the test machines we have. However we want a better solution for all
> > > cases but not just RPi2 since we don't want to affect other platforms as well.
> > >
> >
> > Thanks Chester, but that doesn't answer my question.
> >
> > Your fix is a single patch that changes various things that are only
> > vaguely related. We have already identified that we need to take
> > TEXT_OFFSET (minus some space used by the swapper page tables) into
> > account into the EFI stub if we want to ensure compatibility with many
> > different platforms, and as it turns out, this applies not only to
> > RPi2 but to other platforms as well, most notably the ones that
> > require a TEXT_OFFSET of 0x208000, since they also have reserved
> > regions at the base of RAM.
> >
> > My question was what else we need beyond:
> > - the EFI stub TEXT_OFFSET fix [0]
> > - the change to disregard NOMAP memblocks in adjust_lowmem_bounds()
> > - what else???
>
> I think the only missing part here is to ensure that non-reserved memory in
> bank 0 starts from a PMD-aligned address. I believe this could be done if
> EFI stub, but I'm not really familiar with it so this just a semi-educated
> guess :)
>

Given that it is the ARM arch code that imposes this requirement, how
about adding something like this to adjust_lowmem_bounds():

if (memblock_start_of_DRAM() % PMD_SIZE)
    memblock_mark_nomap(memblock_start_of_DRAM(),
        PMD_SIZE - (memblock_start_of_DRAM() % PMD_SIZE));

(and introduce the nomap check into the loop)
