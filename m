Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A667BC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 09:34:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78E9720835
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 09:34:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbfCGJet (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 04:34:49 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:44678 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfCGJes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 04:34:48 -0500
Received: by mail-ua1-f68.google.com with SMTP id r21so9954790uan.11
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 01:34:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6y/aXKVT50hOEVD323phwrocaOqafnx2I23h57AoUjE=;
        b=eFCu5xoxa/+FoAbpSmW6hMjM+FBR72IEqTIzHCuWU17LxID6McfwbjXLbxz/NwbGPD
         BB5X1MTZWwRgqgQcc2A2kSY4dikB7Qy4OTZv+2IvtUMxFmOPo/LKHPFNj6tXInkwy7P9
         La6jWy8KBP77lfKfqp0ftpTIR1ua6XatLlT0PvIwfENQ2xAUym4zCBJhHoKidDm+5Re8
         svSaDApaSEc2ksYul8YeJw7wXdUJ2WGdsxTj0wi5SbX1Mp9xuJMsXgbcGsouFDF86xuW
         lnBHAKr4OzjpMliT5jtLECfaVbqt4X1xlkXIL+Y2tSxAFAxLxDmZQzwnJiZa2KBPKuA6
         SIQw==
X-Gm-Message-State: APjAAAUrd06LmLYgj+yNEMgS4y7Z1aSiAF9p1Ny76NgcMlkBpWfH3kbV
        hAmFFzSuZ8JkPFOOByQi1sOupWQYKwgcE0eEAyo=
X-Google-Smtp-Source: APXvYqzCU1PPtRhyzt+sA/8F5yTtZVvHqvW3tjHs88oUOMdrKFPOvB75FgA/D2/A1VJs7FjjX+hNBhI+P/7Z7FazuSQ=
X-Received: by 2002:ab0:6419:: with SMTP id x25mr6366672uao.20.1551951287634;
 Thu, 07 Mar 2019 01:34:47 -0800 (PST)
MIME-Version: 1.0
References: <20190307085246.1477426-1-arnd@arndb.de> <86b7f396-c525-ae7e-b51c-cb2442d8d507@arm.com>
 <CAK8P3a19dyTxE2o9KAw3G1qH8p4qXO-dhhc885Z2_w9BDSoFHQ@mail.gmail.com>
In-Reply-To: <CAK8P3a19dyTxE2o9KAw3G1qH8p4qXO-dhhc885Z2_w9BDSoFHQ@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 7 Mar 2019 10:34:36 +0100
Message-ID: <CAMuHMdXmd9NURXvjVQeUe06QQP=degkY+VNUAXwO5eHDm3Lh0w@mail.gmail.com>
Subject: Re: [PATCH] [v2] dma-mapping: work around clang bug
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Paul Burton <paul.burton@mips.com>,
        "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 7, 2019 at 10:28 AM Arnd Bergmann <arnd@arndb.de> wrote:
> On Thu, Mar 7, 2019 at 10:17 AM Robin Murphy <robin.murphy@arm.com> wrote:
> > On 2019-03-07 8:52 am, Arnd Bergmann wrote:
> > >
> > > -#define DMA_BIT_MASK(n)      (((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
> > > +/* double shift to work around https://bugs.llvm.org/show_bug.cgi?id=38789 */
> > > +#define DMA_BIT_MASK(n)      (((n) == 64) ? ~0ULL : ((1ULL<<((n)-1))<<1)-1)
> >
> > I think that now makes DMA_BIT_MASK(0) undefined - that shouldn't matter
> > in most cases, but it could potentially happen at runtime where callers
> > use a non-constant argument. However, it also means we don't need to
> > special-case 64 any more (since that's there to avoid the same thing
> > anyway), so we could simply flip that to handle 0 instead.
>
> Yes, good idea.
>
> > FWIW I'd be very tempted to fold in the second shift as "2ULL<<((n)-1)",
> > but that may not be to everyone's taste.
>
> I like that. So shall we do this?
>
> /*
>  * Shifting '2' instead of '1' because of
>  * https://bugs.llvm.org/show_bug.cgi?id=38789
>  */
> #define DMA_BIT_MASK(n)    (((n) == 0) ? 0ULL : ((2ULL<<((n)-1)))-1)

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
