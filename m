Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DFC7C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 08:50:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E24B20840
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 08:50:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726159AbfCGIur (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 03:50:47 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:43659 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbfCGIur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 03:50:47 -0500
Received: by mail-qk1-f193.google.com with SMTP id s26so434942qkm.10
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 00:50:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=urcJFk8ZuCSmkhZrzOPjOQGMsa2POIYMVOC3WFVE1S0=;
        b=U+fsGA2uXlbCeC3hvAxIRd+TH1S7daEMIJmw8U6XsTHTaFMtTLUqd+GE1ALzdjLYp6
         Y4ECTzWoph3pHsIkH06zXe9gc9G6+L858gAC6NuZ/iwWxWmT6JhHUki+BnFA1SLaPTER
         MKNZ1Ig0Hkesc4sk+KSe+0vRFfb9obnVRI0qNFu4xsIMx0TMXT+KvKLsZiAoonoGFe8U
         s6kKhiRA1LB3WR21EM+TpU0TO4hd45ENQ3m+jbDIowS1XOdM5ZVH5C4ujpF2YJi3t3MA
         BtrHuMMn6x09COZTaMf8DLp8UoxMLpbj78bMIPYEPvtcx3T7KT39GKRL1mQjPTvxY1y7
         kPSQ==
X-Gm-Message-State: APjAAAUej2rFWqZKYc5eyTeO9gvEqXnd0YpdLkxy8MbYlJvrMyIPLo4Y
        dxMDr4OADS1CtsfzxX84Cf+S7NzaMHoKEXJqPGj0+Q==
X-Google-Smtp-Source: APXvYqxk7w1iLDQSm7dCJpitMpfZ+SxpmyJu+kfEYy3NpO7Z+wQwt+ZsB9+WOVe5hLyPaiPa14tyQjO0+Wkp2e6MsOA=
X-Received: by 2002:a37:8dc5:: with SMTP id p188mr8833527qkd.330.1551948646215;
 Thu, 07 Mar 2019 00:50:46 -0800 (PST)
MIME-Version: 1.0
References: <20190307080038.3727426-1-arnd@arndb.de> <CAMuHMdVBBaV8UPqUZUZXy3c9E3zUmVUEZyEEbDs4LaJ9OHncDA@mail.gmail.com>
In-Reply-To: <CAMuHMdVBBaV8UPqUZUZXy3c9E3zUmVUEZyEEbDs4LaJ9OHncDA@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 7 Mar 2019 09:50:27 +0100
Message-ID: <CAK8P3a3=GcE1bN1HNwoMVG5heKfAipFP7+a4pRgnF=QbfiBBGA@mail.gmail.com>
Subject: Re: [PATCH] dma-mapping: work around clang bug
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Paul Burton <paul.burton@mips.com>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 7, 2019 at 9:28 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Thu, Mar 7, 2019 at 9:01 AM Arnd Bergmann <arnd@arndb.de> wrote:
> > Clang has a rather annoying behavior of checking for integer
> > arithmetic problems in code paths that are discarded by gcc
> > before that perfoms the same checks.
> >
> > For DMA_BIT_MASK(64), this leads to a warning despite the
> > result of the macro being completely sensible:
> >
> > arch/arm/plat-iop/adma.c:146:24: error: shift count >= width of type [-Werror,-Wshift-count-overflow]
> >                 .coherent_dma_mask = DMA_BIT_MASK(64),
> >
> > The best workaround I could come up with is to shift the
> > value twice, which makes the macro way less readable but
> > always has the same result.
> >
> > Link: https://bugs.llvm.org/show_bug.cgi?id=38789
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  include/linux/dma-mapping.h | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> > index 75e60be91e5f..380d3a95d02e 100644
> > --- a/include/linux/dma-mapping.h
> > +++ b/include/linux/dma-mapping.h
> > @@ -138,7 +138,8 @@ struct dma_map_ops {
> >  extern const struct dma_map_ops dma_virt_ops;
> >  extern const struct dma_map_ops dma_dummy_ops;
> >
> > -#define DMA_BIT_MASK(n)        (((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
> > +/* double shift to work around https://bugs.llvm.org/show_bug.cgi?id=38789 */
> > +#define DMA_BIT_MASK(n)        (((n) == 64) ? ~0ULL : (((1ULL<<((n)-1))-1) << 1))
>
> The second "-1" should be done on the final result, not on the
> intermediate value.

Ah, of course. I'll send an update patch in a bit, sorry about this.

      Arnd
