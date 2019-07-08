Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D71CEC606AF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 11:56:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD51F20665
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 11:56:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rm7uAMB7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730666AbfGHL4a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 07:56:30 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:39267 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730649AbfGHL42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 07:56:28 -0400
Received: by mail-vs1-f68.google.com with SMTP id u3so7985760vsh.6
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 04:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HBytyteQEqE0MSe1IOfYnAnkrJNKH8hCeBxnrS0M68E=;
        b=Rm7uAMB7M5Qn0X6mOV3Iz8dOnLsIQ9eGsDcwh4z92MopdN7KKiq31AboQlypIo9V9v
         ue9bef6yCpVOq2onDY/zQSjkhhKHmc+cbTLwy6OlgG0Lcy3AwSUbpz29HJdKqTZdjodu
         FOu1QU4FrfCCQ1PSZLHjJ1nnN1sfcEYlYy1FvzGRBwpgHIN6h3mwMUDQ1P2H8Tc3oKv7
         oZ+QkHk+nRGF5xp1DGXIjCku+ZIdHyeJCvc/Tsm/3sQbRgU0UlPbI2wofVSyQNLdHlAO
         Tg+EJOx0U9geRwo4Pu/oWUFHPGyernGW0Sp6KVrxuMab2/nNUIIQi9O9nfwGze9pk7AV
         w6xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HBytyteQEqE0MSe1IOfYnAnkrJNKH8hCeBxnrS0M68E=;
        b=PHnGV7K00L5ue4PJgVbLRBhveFeQtCZNm303RG0+iUht5hHXd7aWx6ofUsiH/nNXql
         6YyNGw6V9z4owFyE/DldBwzTNtFvW9MnqYh1oWmDoNDp/gDMpADvnV3DiEMTGblmNBCv
         S4dEMa6D0vz3qcEm3lIf6QZjNObe8VsblmPczFzEFOVFumNXm2/dO94ai7BQIHVXSSLt
         jDBBbi6JTuwTIAASU5qKf6JjGUC+wtJ13aPD4cL86M3ztJoKbtLa18wOHjV8j/N/m/qx
         vVZaIuh6NovPFpY7HrL4X4qeraqcQlciJ7r3mKkN2Gx05OiX3oypa/jL4UHdJS4Bmc+W
         bTJA==
X-Gm-Message-State: APjAAAWAWdKfalCjC3tS2aEliwNRWoO44SO7T5c8Q+SC0silqUF9fAzu
        Rz6JV5ej6wRG07XCH1BVScbQEIeKhw+G1xw2LmP45Q==
X-Google-Smtp-Source: APXvYqzg4E2v4x7VsWLV3ufXyfYMYcZpu74cfh+llLws+qIdafA82e7IbF0d3dN/j1DEFitRvg4vHdb6lzOYvkL7RiA=
X-Received: by 2002:a67:7a90:: with SMTP id v138mr9705298vsc.200.1562586987921;
 Mon, 08 Jul 2019 04:56:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190625092042.19320-1-hch@lst.de> <20190625092042.19320-3-hch@lst.de>
In-Reply-To: <20190625092042.19320-3-hch@lst.de>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 8 Jul 2019 13:55:52 +0200
Message-ID: <CAPDyKFr=skv_109JfYQgZrzrEox_CdSmpO_9iU10OC+sGTz1wQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] dma-mapping: remove dma_max_pfn
To:     Christoph Hellwig <hch@lst.de>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     Russell King <linux@armlinux.org.uk>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jun 2019 at 11:21, Christoph Hellwig <hch@lst.de> wrote:
>
> These days the DMA mapping code must bounce buffer for any not supported
> address, and if they driver needs to optimize for natively supported
> ranged it should use dma_get_required_mask.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Applied for next, by amending the changelog according to suggestions
from Marc, thanks!

I also decided to consider to the reply from Marc (with the changes
made) as an ack, so added a tag for that.

If there are any objections, from anyone, please tell now.

Kind regards
Uffe


> ---
>  arch/arm/include/asm/dma-mapping.h | 7 -------
>  include/linux/dma-mapping.h        | 7 -------
>  2 files changed, 14 deletions(-)
>
> diff --git a/arch/arm/include/asm/dma-mapping.h b/arch/arm/include/asm/dma-mapping.h
> index 03ba90ffc0f8..7e0486ad1318 100644
> --- a/arch/arm/include/asm/dma-mapping.h
> +++ b/arch/arm/include/asm/dma-mapping.h
> @@ -89,13 +89,6 @@ static inline dma_addr_t virt_to_dma(struct device *dev, void *addr)
>  }
>  #endif
>
> -/* The ARM override for dma_max_pfn() */
> -static inline unsigned long dma_max_pfn(struct device *dev)
> -{
> -       return dma_to_pfn(dev, *dev->dma_mask);
> -}
> -#define dma_max_pfn(dev) dma_max_pfn(dev)
> -
>  /* do not use this function in a driver */
>  static inline bool is_device_dma_coherent(struct device *dev)
>  {
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index 6309a721394b..8d13e28a8e07 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -729,13 +729,6 @@ static inline int dma_set_seg_boundary(struct device *dev, unsigned long mask)
>         return -EIO;
>  }
>
> -#ifndef dma_max_pfn
> -static inline unsigned long dma_max_pfn(struct device *dev)
> -{
> -       return (*dev->dma_mask >> PAGE_SHIFT) + dev->dma_pfn_offset;
> -}
> -#endif
> -
>  static inline int dma_get_cache_alignment(void)
>  {
>  #ifdef ARCH_DMA_MINALIGN
> --
> 2.20.1
>
