Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01EF1C606D2
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 20:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF6872171F
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 20:40:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405149AbfGHUko (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 16:40:44 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:40716 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405138AbfGHUkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 16:40:41 -0400
Received: by mail-oi1-f194.google.com with SMTP id w196so13659865oie.7
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 13:40:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8xO6oXPlkmx2OM1yxQZEmmw9lww0cn55YC7R5SBknwI=;
        b=rupx7ZMNfUke5WQrqfsZZjlhjhSd3a/+9VCcf8K/oQq5XqoojXK0uxO1Mw+DjPdc7C
         IvmCos7P2o2Z0G1NoMwZ8w+m0ihWpgnhhMfWKQsPUNTGcZJ83C2GljwTfYTDYnPKxvOq
         XaN1EO+D3+UTNNLPvXkDsk1tzhYaSy+OayM8N9a3hxNBGC40fGn1NSaaeA+e+UxUaML0
         pWyldKviYIbmKWby2yhMV7SB11UwJmlzZ92kWV6pdwrZx8RDcY9W5mW+wV3waHeETmtS
         SgAUDINatYBzLEJLWyVQvOz7KL4fXYK5KvqnKXA9ZwbRt/E/ssJnE6p5+P1TLLmeXmRK
         IlUQ==
X-Gm-Message-State: APjAAAUrbpE0vIV8azw83GEGxOa+KUc9YRD4VkDcr8ptVhrhQxO73LBs
        hiBr3o9FtRW5KnDlG6ExwRwQ8s0066iVBMlu7RU=
X-Google-Smtp-Source: APXvYqzbKcHGXLTLKJxe6e46SY+CdPPc/e//L/mI0ZukTpyNzIx1QZ+obPeNNZqJ1dS2rg6aUT3dbqR6vQfse+QelHU=
X-Received: by 2002:aca:338a:: with SMTP id z132mr11298979oiz.54.1562618440650;
 Mon, 08 Jul 2019 13:40:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190708170647.GA12313@roeck-us.net> <CAMuHMdUnSqKHA7EN1S8U7eBODs4gi-raw4P3FxnR_afhb2Zd5g@mail.gmail.com>
 <20190708194516.GA18304@roeck-us.net> <CAMuHMdVKKkx_S_mXmCzckyiw1fbLQMEZroRT+UchHv+tgF-3RA@mail.gmail.com>
 <20190708202226.GA15167@lst.de> <CAMuHMdUUpyiRp3LdfE0M96dM6kAzse+gfXWqEQWe9ScwT9GX4A@mail.gmail.com>
 <20190708203733.GA15607@lst.de> <20190708203837.GA15713@lst.de>
In-Reply-To: <20190708203837.GA15713@lst.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 8 Jul 2019 22:40:29 +0200
Message-ID: <CAMuHMdUQ1jciVUEnQc+ezh-w5jNaff3PgUyJXmOxihsYQ-3D5Q@mail.gmail.com>
Subject: Re: m68k build failures in -next: undefined reference to `arch_dma_prep_coherent'
To:     Christoph Hellwig <hch@lst.de>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On Mon, Jul 8, 2019 at 10:38 PM Christoph Hellwig <hch@lst.de> wrote:
> On Mon, Jul 08, 2019 at 10:37:33PM +0200, Christoph Hellwig wrote:
> > On Mon, Jul 08, 2019 at 10:36:05PM +0200, Geert Uytterhoeven wrote:
> > > Note that the build failure is more subtle: both m5307c3_defconfig and
> > > m5475evb_defconfig build fine in m68k/for-linus, but fail in
> > > next-20190708.  So it fails when combined with other changes, going
> > > in through a different tree (the DMA tree?).
> >
> > Yes, the dma tree adds the stub for the symbol and adds code relying
> > on that.
>
> If you give me an ack I can add the fix to the dma-mapping pull request.

Thanks, done.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
