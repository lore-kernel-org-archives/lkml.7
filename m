Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00F37C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 20:03:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C834421851
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 20:03:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391834AbfEXUDm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 16:03:42 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:57465 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391612AbfEXUDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 16:03:41 -0400
Received: from mail-ot1-f71.google.com ([209.85.210.71])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <dann.frazier@canonical.com>)
        id 1hUGPi-0007wv-F1
        for linux-kernel@vger.kernel.org; Fri, 24 May 2019 20:03:38 +0000
Received: by mail-ot1-f71.google.com with SMTP id 73so4999384oty.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 13:03:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MdZgSrzvQrNvArhhMwV6uq98L6kGwXydzTCUTc3ed/4=;
        b=nyzkxWlpmuQTSM7FL8BbV7PvXVB4xXH0cSeWffJLbTSbrj03V2WDPh/ZdXcfNG3yoU
         L5L3u0ZVoTo5fNICoeiL4xhZ37bRhduTSFxjcIguZHKDIsrpOwBWAkH7Y+Qv8HL/WQIJ
         CHdznPhvV09D9nadnKXRj32wT69+Jdat8PR3XnLTq72BBEIwifNChCvYE8pw0ZTp9CL1
         VeMCAgB+ZtMfOkDKIzcdMSjEooTtGLCQ2FEXopxVBicVlCC/I20dyWOkzSX8ENynQ87o
         Q/hIfZdtEsxJRFume/r5VOAIAhbe2CQB4Iy8aNbNF8F0TN0/Z01pg9Qvl9Tr1paVa+tf
         IhiA==
X-Gm-Message-State: APjAAAVXvzfQlU1yYLQnFZS1RxCxaUn3Ii9vsEsPn3CgdClOwEj88jSJ
        4oPkAEfpvq14fovKp9dRbq6OhhU9MJZ/SyCuOnwnUMlhziM0zBE9di7fLNtcAqFDcpbgaQ4hvE7
        Qk+y4KggDeVYroRKISGYaIzQbp085xwifvJe3rdsDQfsg0tDsGyA4VYTvhg==
X-Received: by 2002:a05:6830:164d:: with SMTP id h13mr31758686otr.99.1558728217210;
        Fri, 24 May 2019 13:03:37 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxoya9uYRsSIEv51UV91v8Z+LxDz8k4gGrzqqMySgCjbel8axNiXlhuqaT0Un+V+0ZUNeHLZgzLuTVB5rKzbzc=
X-Received: by 2002:a05:6830:164d:: with SMTP id h13mr31758663otr.99.1558728216929;
 Fri, 24 May 2019 13:03:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190524040633.16854-1-nicoleotsuka@gmail.com>
In-Reply-To: <20190524040633.16854-1-nicoleotsuka@gmail.com>
From:   dann frazier <dann.frazier@canonical.com>
Date:   Fri, 24 May 2019 14:03:25 -0600
Message-ID: <CALdTtnu=WdYbqyq57EkB-=rsyz72SW-J8oyD7f6Xm-da2OgRgQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] Optimize dma_*_from_contiguous calls
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>, vdumpa@nvidia.com,
        linux@armlinux.org.uk, Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, chris@zankel.net,
        jcmvbkbc@gmail.com, joro@8bytes.org, dwmw2@infradead.org,
        tony@atomide.com, akpm@linux-foundation.org, sfr@canb.auug.org.au,
        treding@nvidia.com, keescook@chromium.org, iamjoonsoo.kim@lge.com,
        wsa+renesas@sang-engineering.com,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        iommu@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2019 at 10:08 PM Nicolin Chen <nicoleotsuka@gmail.com> wrote:
>
> [ Per discussion at v1, we decide to add two new functions and start
>   replacing callers one by one. For this series, it only touches the
>   dma-direct part. And instead of merging two PATCHes, I still keep
>   them separate so that we may easily revert PATCH-2 if anything bad
>   happens as last time -- PATCH-1 is supposed to be a safe cleanup. ]
>
> This series of patches try to optimize dma_*_from_contiguous calls:
> PATCH-1 abstracts two new functions and applies to dma-direct.c file.
> PATCH-2 saves single pages and reduce fragmentations from CMA area.
>
> Please check their commit messages for detail changelog.
>
> Nicolin Chen (2):
>   dma-contiguous: Abstract dma_{alloc,free}_contiguous()
>   dma-contiguous: Use fallback alloc_pages for single pages
>
>  include/linux/dma-contiguous.h | 11 +++++++
>  kernel/dma/contiguous.c        | 57 ++++++++++++++++++++++++++++++++++
>  kernel/dma/direct.c            | 24 +++-----------
>  3 files changed, 72 insertions(+), 20 deletions(-)

Thanks Nicolin. Tested on a HiSilicon D06 system.

Tested-by: dann frazier <dann.frazier@canonical.com>
