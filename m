Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01FF4C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 08:28:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE6E020840
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 08:28:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbfCGI2p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 03:28:45 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:44822 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726249AbfCGI2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 03:28:45 -0500
Received: by mail-vs1-f65.google.com with SMTP id r201so3957419vsc.11
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 00:28:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yv2fC5EdpB5TlFtEwAwcenIgzdWDlFra+VmrHtwV3Dw=;
        b=kqWJyqvBlwtLTXZKMq3Deo/Etg9oHXAvkfT/0bgU86KjCTllQA2pcLUjx59eTBNXHb
         EiOCmxKAI7FcvNJLUx/g1R57FVBLIB8p3gdtjN0CqHRsl24S5D5co1J3hTrnaoIXij9k
         mqaqdUH8ozKEg7EneOihVUEmZ9OwAt74hJ+CqSMWHgKCuLXy0qZtMvMher1f9UjcdN2S
         9K6C2cgi8r7urruLK9tsTbMzR3DyC/nWKtpLYr+Y0Ad5o3ftDQOtOhmYhaW0ESu7EHKq
         3GICoDQcY1fo+P3SKF1ncvf88hFaMM9QDstkvX/YC0Cb8yUItfXCgzTFnRGiWeh6Uq0L
         XdLQ==
X-Gm-Message-State: APjAAAUyFbkR8F5NbzmrxXd+gT2MJMju4j3Vn/6S7r/x9HCtq/cajaKa
        DjHhmvANGcDaCYALl+3PyryyxU7RbXN2Ssm3qg8=
X-Google-Smtp-Source: APXvYqz8nPU60BFZLRPqpWA4miVrMw6tIhObp1hAwE3cNYYMZqhWOIqmDFO6gJKk2yvb6Fl++uYcjB7SC+GJLG63QRE=
X-Received: by 2002:a67:78ce:: with SMTP id t197mr6211443vsc.152.1551947323997;
 Thu, 07 Mar 2019 00:28:43 -0800 (PST)
MIME-Version: 1.0
References: <20190307080038.3727426-1-arnd@arndb.de>
In-Reply-To: <20190307080038.3727426-1-arnd@arndb.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 7 Mar 2019 09:28:32 +0100
Message-ID: <CAMuHMdVBBaV8UPqUZUZXy3c9E3zUmVUEZyEEbDs4LaJ9OHncDA@mail.gmail.com>
Subject: Re: [PATCH] dma-mapping: work around clang bug
To:     Arnd Bergmann <arnd@arndb.de>
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

Hi Arnd,

On Thu, Mar 7, 2019 at 9:01 AM Arnd Bergmann <arnd@arndb.de> wrote:
> Clang has a rather annoying behavior of checking for integer
> arithmetic problems in code paths that are discarded by gcc
> before that perfoms the same checks.
>
> For DMA_BIT_MASK(64), this leads to a warning despite the
> result of the macro being completely sensible:
>
> arch/arm/plat-iop/adma.c:146:24: error: shift count >= width of type [-Werror,-Wshift-count-overflow]
>                 .coherent_dma_mask = DMA_BIT_MASK(64),
>
> The best workaround I could come up with is to shift the
> value twice, which makes the macro way less readable but
> always has the same result.
>
> Link: https://bugs.llvm.org/show_bug.cgi?id=38789
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  include/linux/dma-mapping.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index 75e60be91e5f..380d3a95d02e 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -138,7 +138,8 @@ struct dma_map_ops {
>  extern const struct dma_map_ops dma_virt_ops;
>  extern const struct dma_map_ops dma_dummy_ops;
>
> -#define DMA_BIT_MASK(n)        (((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
> +/* double shift to work around https://bugs.llvm.org/show_bug.cgi?id=38789 */
> +#define DMA_BIT_MASK(n)        (((n) == 64) ? ~0ULL : (((1ULL<<((n)-1))-1) << 1))

The second "-1" should be done on the final result, not on the
intermediate value.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
