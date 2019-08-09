Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99D87C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 07:21:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7930E2173E
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 07:21:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405775AbfHIHVl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 03:21:41 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:46586 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405701AbfHIHVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 03:21:40 -0400
Received: by mail-ot1-f68.google.com with SMTP id z17so10595949otk.13;
        Fri, 09 Aug 2019 00:21:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A7mCF4lTq2gFXOvcmY2h+y2/MZQDfsM2+XB9S0QJ6k4=;
        b=Yq/lZ82TgclMTYySws9jxx3lmQUskkUTnEY9kSysVlelH0jt+6mVkzvVk6zo/HvC5H
         0Ycj3+nqrpwVw/xxaOyEZm2bs1TSxraY8+OpQhrjW0Cs8kg4jRnQzC44f2vtqKGJPhbX
         4OUr7kkbMPHSmD6rFDqGZnpylXj0fK+0OpKRl1kQU5uLnZlc6567k0/8/K2FCd6BnTGU
         2RUwfTM04tj7iG3SGB6fTkIwS/yhHofva9gY+ey67NjIDYK4IwVA79h6VCycbj2EOznY
         0RD8xpi+kfGVC3Aqw65FKhR1plD+RGHi4moZJNIMnk5ldNljscZawjSAxXgxXgZsh6b3
         fPpw==
X-Gm-Message-State: APjAAAVD/yZKoa7JrOvu4j09XLaSf/14kav8vi6CRBlQPoeYr4JHwd38
        jR427iRv9vQbqfIAF8xvdnaU9JE2h12Sx+dhUl4=
X-Google-Smtp-Source: APXvYqyBXPOK98jaQhUmqtFlEEGP/W76NVu4RQ2ZHS+SsKdevOL3KYGUiRHhF15E80P339HCx6FddAsKPmlukbGoIK8=
X-Received: by 2002:a9d:7a90:: with SMTP id l16mr17247630otn.297.1565335299510;
 Fri, 09 Aug 2019 00:21:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190808160005.10325-1-hch@lst.de> <20190808160005.10325-9-hch@lst.de>
In-Reply-To: <20190808160005.10325-9-hch@lst.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 9 Aug 2019 09:21:28 +0200
Message-ID: <CAMuHMdV0JfZ_K2V7W0FQkobE_zLwe4Uez-EWzMMdTfVffpAWtA@mail.gmail.com>
Subject: Re: [PATCH 8/8] dma-mapping: remove CONFIG_ARCH_NO_COHERENT_DMA_MMAP
To:     Christoph Hellwig <hch@lst.de>
Cc:     Linux IOMMU <iommu@lists.linux-foundation.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Takashi Iwai <tiwai@suse.de>, Helge Deller <deller@gmx.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Michal Simek <monstr@monstr.eu>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        linux-xtensa@linux-xtensa.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On Thu, Aug 8, 2019 at 6:01 PM Christoph Hellwig <hch@lst.de> wrote:
> CONFIG_ARCH_NO_COHERENT_DMA_MMAP is now functionally identical to
> !CONFIG_MMU, so remove the separate symbol.  The only difference is that
> arm did not set it for !CONFIG_MMU, but arm uses a separate dma mapping
> implementation including its own mmap method, which is handled by moving
> the CONFIG_MMU check in dma_can_mmap so that is only applies to the
> dma-direct case, just as the other ifdefs for it.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

>  arch/m68k/Kconfig       |  1 -

For m68k:
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
