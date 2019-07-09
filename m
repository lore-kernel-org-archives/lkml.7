Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1745AC606B0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 07:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBE1620665
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 07:08:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726032AbfGIHIO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 03:08:14 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:39975 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbfGIHIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 03:08:14 -0400
Received: by mail-ot1-f66.google.com with SMTP id e8so18874240otl.7
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2019 00:08:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O19F1XdbORvvsa9/iz6Bm4Omhn64/xhWxSpwGFNbhbw=;
        b=sijRVUdzmJMLMoB0GqU4aajr65RgT4FNyZJ8G8YA7Vd6IBkK3Nv2cOwVrbFF3AMuZZ
         6gBiqrNDZTvcLQiyimfpZQMzXgRM1gAlqNcil3p3NKwybtFCIb7dVLvmwUKp/FZRndj3
         HuX0ka+G6Nu6WJ/5zAZrJAiNlluj2gdMNq0UZIlQZD5I8+4GhihDGubbVDuRI8gGkCyY
         w7BUW5UOlAjiE21XrZBjLLaTZbEB6a7XlV8fXv7dBOOYMBHbNcmC7YnZMy0wZoI4p/xv
         UQlh8xKipnHxaQQinJDHyBoXHHhKr9BRcb/wHugBHOzgUQbMsMUhZ+3RI7aL0pMXnXxc
         8P8Q==
X-Gm-Message-State: APjAAAUxOTg4THsJEUyIqzQR1/vMi89aqHtLBg4jD/Z0mGBv//4Bfe5H
        xJ9HGXExEl/QSOZ2w944RXBmb/LV7VA89rBjPhluaQ==
X-Google-Smtp-Source: APXvYqweOPA8E1biO6mxO0Vz38DTDQedjM6a8vQAaat/XSjQGEMmEj4p57tMYFKSRGTdGyTJK1f8taIOB8P16I00A68=
X-Received: by 2002:a9d:5c11:: with SMTP id o17mr3291785otk.107.1562656093641;
 Tue, 09 Jul 2019 00:08:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190708175101.19990-1-hch@lst.de> <CAMuHMdVrAVYWvQCh7AF1O7SRbuZb9fQp9fi0yQyZMeaOpfHyEw@mail.gmail.com>
 <20190708212325.GA17641@lst.de>
In-Reply-To: <20190708212325.GA17641@lst.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 9 Jul 2019 09:08:02 +0200
Message-ID: <CAMuHMdVqCOwxG1ru-wvgDmtNfezgR92qBOVhtEJjaLrXAjaE+A@mail.gmail.com>
Subject: Re: [PATCH] m68k: don't select ARCH_HAS_DMA_PREP_COHERENT for nommu
 or coldfire
To:     Christoph Hellwig <hch@lst.de>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Ungerer <gerg@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On Mon, Jul 8, 2019 at 11:23 PM Christoph Hellwig <hch@lst.de> wrote:
> On Mon, Jul 08, 2019 at 10:39:48PM +0200, Geert Uytterhoeven wrote:
> > On Mon, Jul 8, 2019 at 7:51 PM Christoph Hellwig <hch@lst.de> wrote:
> > >
> > > m68k only provides the dma_prep_coherent symbol when an mmu is enabled
> >
> > arch_dma_prep_coherent
> >
> > > and not on the coldfire platform.  Fix the Kconfig symbol selection
> > > up to match this.
> > >
> > > Fixes: 69878ef47562 ("m68k: Implement arch_dma_prep_coherent()")
> >
> > Do you know the SHA1 for the other commit, that causes the issue when
> > combined with the above?
>
> I think the culprit is:
>
> commit c30700db9eaabb35e0b123301df35a6846e6b6b4
> Author: Christoph Hellwig <hch@lst.de>
> Date:   Mon Jun 3 08:43:51 2019 +0200
>
>     dma-direct: provide generic support for uncached kernel segments
>
>
> Ad it turns out I can't just apply this fix to the dma-mapping tree
> because it doesn't have the m68k changes.  So either you'll have to
> queue it up, or I'll have to do secondary pull request to fix up
> the first one.  Maybe it is eiter if you just send it to Linus
> before I send the dma-mapping PR?

OK, will do, after a cycle in next.

I assume you just forgot to add your SoB, and I can add it?

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
