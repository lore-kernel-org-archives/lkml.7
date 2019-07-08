Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35A31C606CF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 20:40:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0816621707
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 20:40:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405109AbfGHUkB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 16:40:01 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:33709 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732003AbfGHUkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 16:40:00 -0400
Received: by mail-ot1-f65.google.com with SMTP id q20so17619556otl.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 13:40:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=onvwnS5gjBHoF9rdE0gG38KKlQEhhWJR79obwao8mVg=;
        b=plsBGjxUJ2jmv3vLlNzWtxmRsRug7cHSgEfV9gfIV2iRRw8RUTXRq5ISby546NsZHL
         jqmKgf/dovS4m0suaSvXCA+hPM4wlVp5Fi7MArLDll2doeO/Wuh37v1y4YKk2NkmM1jK
         0mQ9LL/pZkToWNC+bvw4ijkZ51FBElcmROz2Qj7mOxmlXRYqRRcWAYgK2Yhn9NOIeQim
         khqDKd8W78jtbCER177rGNNrDQuVJccoj4GwxIX9kHcEkObC4fnfJCsie/6385xkn/iw
         XMr+cy/AVtC9+BoPpEPxFGuNXG210QjoWaW/OhE5XNGDzyLJvR/1d1b/wxOJ6YRrioit
         pOSA==
X-Gm-Message-State: APjAAAVyJEYfMV2K1yNWKDBTVwTpraHrvm2TlLIVMUxgneoA41DOUGZU
        jefP2vHjM+c7he7ab5Y11Bar1c9Vmx+wM4bOW1o=
X-Google-Smtp-Source: APXvYqxEEee9nNr+XuV9YsEG2Wdt0zLmowIgYkkeLu1vfIdc0/382PdopHQ3HgegIGxBVnXIgaIuLSarwEiMBn+ZjGE=
X-Received: by 2002:a9d:5c11:: with SMTP id o17mr1413175otk.107.1562618399916;
 Mon, 08 Jul 2019 13:39:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190708175101.19990-1-hch@lst.de>
In-Reply-To: <20190708175101.19990-1-hch@lst.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 8 Jul 2019 22:39:48 +0200
Message-ID: <CAMuHMdVrAVYWvQCh7AF1O7SRbuZb9fQp9fi0yQyZMeaOpfHyEw@mail.gmail.com>
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

On Mon, Jul 8, 2019 at 7:51 PM Christoph Hellwig <hch@lst.de> wrote:
>
> m68k only provides the dma_prep_coherent symbol when an mmu is enabled

arch_dma_prep_coherent

> and not on the coldfire platform.  Fix the Kconfig symbol selection
> up to match this.
>
> Fixes: 69878ef47562 ("m68k: Implement arch_dma_prep_coherent()")

Do you know the SHA1 for the other commit, that causes the issue when
combined with the above?

> Reported-by: Guenter Roeck <linux@roeck-us.net>

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

> --- a/arch/m68k/Kconfig
> +++ b/arch/m68k/Kconfig
> @@ -5,7 +5,7 @@ config M68K
>         select ARCH_32BIT_OFF_T
>         select ARCH_HAS_BINFMT_FLAT
>         select ARCH_HAS_DMA_MMAP_PGPROT if MMU && !COLDFIRE
> -       select ARCH_HAS_DMA_PREP_COHERENT
> +       select ARCH_HAS_DMA_PREP_COHERENT if HAS_DMA && MMU && !COLDFIRE
>         select ARCH_HAS_SYNC_DMA_FOR_DEVICE if HAS_DMA
>         select ARCH_MIGHT_HAVE_PC_PARPORT if ISA
>         select ARCH_NO_COHERENT_DMA_MMAP if !MMU

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
