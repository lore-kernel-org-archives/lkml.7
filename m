Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCDCEC606CF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 20:19:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 953B0216F4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 20:19:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404923AbfGHUTx convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 16:19:53 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:43830 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731964AbfGHUTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 16:19:53 -0400
Received: by mail-oi1-f194.google.com with SMTP id w79so13639684oif.10
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 13:19:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hyHWt5Z2WzGrJy93vghvC7TDpPpFAel7HkYuBOZA3ig=;
        b=DLZt8KeIgkFuSuGDg+J7r438bb6PFrs2CP25HsxtwP5C4/QsJINSyu78GVwk09+3Dl
         0JY+sLpEvRj7O/f2APR7Ad6pF9z0cPR1H9/k4HImW0OEYR4pVPVFcYWJd8JXn6yB8Ms7
         OhUOPqzUCc+bG1jxRC5PsNn7R13mGKhTUktkz2JLbRHIg26qeC3jTa+9YKWgzuEATW+S
         v5DZeawHQXkSWjEP1m3zB0lQVelSdChzxdqTftdUqy0Wqgp3Slg7rl5Isu6GUmFpBlV0
         +GfOeM/gE7Ny5fdnUWYjy84Np3VxoyQVaIdJQx+5hyeo3pEBdEktRrJL66N95TcCHP3J
         8MWQ==
X-Gm-Message-State: APjAAAVcB6HrTYsgGOD9V4iXqAPJZ/EsSZesr+AFnzLYisB8kIV6QCTs
        sOw1hG8xyiDAcSXhG3W8t2W8Kwh684nPHATYGIoQmBUH
X-Google-Smtp-Source: APXvYqwkW1LLuEPyqhGaq9auGFpVKtqLggGczBxFKLDppMHvXid5BDhJqVwoy+1Rn2yRgt2a4pZ4s500rWsMqPVGORY=
X-Received: by 2002:aca:338a:: with SMTP id z132mr11245655oiz.54.1562617192281;
 Mon, 08 Jul 2019 13:19:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190708170647.GA12313@roeck-us.net> <CAMuHMdUnSqKHA7EN1S8U7eBODs4gi-raw4P3FxnR_afhb2Zd5g@mail.gmail.com>
 <20190708194516.GA18304@roeck-us.net>
In-Reply-To: <20190708194516.GA18304@roeck-us.net>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 8 Jul 2019 22:19:41 +0200
Message-ID: <CAMuHMdVKKkx_S_mXmCzckyiw1fbLQMEZroRT+UchHv+tgF-3RA@mail.gmail.com>
Subject: Re: m68k build failures in -next: undefined reference to `arch_dma_prep_coherent'
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Günter,

CC Greg

On Mon, Jul 8, 2019 at 9:45 PM Guenter Roeck <linux@roeck-us.net> wrote:
> On Mon, Jul 08, 2019 at 09:13:02PM +0200, Geert Uytterhoeven wrote:
> > On Mon, Jul 8, 2019 at 7:06 PM Guenter Roeck <linux@roeck-us.net> wrote:
> > > I see the following build error in -next:
> > >
> > > kernel/dma/direct.o: In function `dma_direct_alloc_pages':
> > > direct.c:(.text+0x4d8): undefined reference to `arch_dma_prep_coherent'
> > >
> > > Example: m68k:allnoconfig.
> > >
> > > Bisect log is ambiguous and points to the merge of m68k/for-next into
> > > -next. Yet, I think the problem is with commit 69878ef47562 ("m68k:
> > > Implement arch_dma_prep_coherent()") which is supposed to introduce
> > > the function. The problem is likely that arch_dma_prep_coherent()
> > > is only declared if CONFIG_MMU is enabled, but it is called from code
> > > outside CONFIG_MMU.
> >
> > Thanks, one more thing to fix in m68k-allnoconfig (did it really build
> > before?)...
> >
> > Given you say "example", does it fail in real configs, too?
>
> Yes, it does. All nommu builds fail. allnoconfig and tinyconfig just
> happen to be among those.
>
> Building m68k:allnoconfig ... failed
> Building m68k:tinyconfig ... failed
> Building m68k:m5272c3_defconfig ... failed
> Building m68k:m5307c3_defconfig ... failed
> Building m68k:m5249evb_defconfig ... failed
> Building m68k:m5407c3_defconfig ... failed
> Building m68k:m5475evb_defconfig ... failed
>
> Error is always the same.

Thanks!

> The error started with next-20190702. Prior to that, builds were fine,
> including m68k:allnoconfig and m68k:tinyconfig.

Yeah, it started when I queued up the DMA rework.
I didn't double-check when Greg said it was OK for him, as it wouldn't affect
Coldfire or mmu. Sorry for that.
And that has just been pulled by Linus... Oops...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
