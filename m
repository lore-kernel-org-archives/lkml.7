Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9B7FC43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 19:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 789F82087B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 19:47:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RDkJwLgM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbfD3Trw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 15:47:52 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37863 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbfD3Trv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 15:47:51 -0400
Received: by mail-pg1-f193.google.com with SMTP id e6so7327888pgc.4
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2019 12:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=86GCSVrH9zo4gh156Oo5t8O2oP844A9QOA6J/OXOUxA=;
        b=RDkJwLgMXXBm7lJVQVTDnpEtriShEMPyVioxbhNW+zutYavuTMg0jbA7KIZU4ozWRa
         8IKC2EuvJi2rhxPjTUZf1t+gqmpJmc0a2yR3dcSEgC3NkAxERDqQkgahjcwvC4xbE/s/
         fkqW1OL++MlrDw6zQJ/HjWBnDv+IepQfzMfnf4gVq8buMVXCo0K6M29JIcQnC7woKwCD
         JlWH0/et3lm4jQE3SZXbnI2Oo5K+IbpTg3UuIYzsNpp7j2R16SRawvjYXnsLMOP+lM27
         rM0z3Ay7JsxNp4jcVY93LELKhAPfTqirUOfIR5/m9hA83EmsvwL4OoWKuXyfmjOIJ6oM
         SaxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=86GCSVrH9zo4gh156Oo5t8O2oP844A9QOA6J/OXOUxA=;
        b=a7xjgfeS+3mvov3fKaIumINPaVkGtoFhYQlTpf6heBgwyF2ub0UF6ObvMM2afgUhKR
         ztU4IPE7X86htxqRHBaa5JGpgtDTSh6qoPUctPZtHcxXs61UMgeo4oXPlHbExT8379U1
         4N1gzLB7ZfITSG/pEAybn5PQngRdZgDZ4smvIAVKGxVZQ03pdzXefLw/VODWvViK0cM+
         U/cGFZkZwqgRMqbfzAHB6da5ETwjTce9IHQ36M1kWHlLphltb74mTetOtr55JNylhsZo
         yqriK8/N6cRxx5W63BjyMZkJPwbB8PSOpPEmBTQ2CvnM4zIUOAf8oMbLINph8GWpwXbe
         6U+g==
X-Gm-Message-State: APjAAAWYyEYqmf/jKQ5p1dR+pVBvkjztO0pbee50Vyrz8S3qfEfmFq4G
        TEZ5N+gED1+ZZH4+4QsQvS4=
X-Google-Smtp-Source: APXvYqzFBvVULwHUiGXsDPHzgJbD3J/zaoDiLOXodZvC2mcsihPg9PVzKdT/PfoC4gUpNKvmhCjzaA==
X-Received: by 2002:a63:3fc1:: with SMTP id m184mr34699554pga.222.1556653670976;
        Tue, 30 Apr 2019 12:47:50 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id g24sm5419285pfi.126.2019.04.30.12.47.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Apr 2019 12:47:50 -0700 (PDT)
Date:   Tue, 30 Apr 2019 12:46:13 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
Cc:     m.szyprowski@samsung.com, vdumpa@nvidia.com, linux@armlinux.org.uk,
        catalin.marinas@arm.com, will.deacon@arm.com, chris@zankel.net,
        jcmvbkbc@gmail.com, joro@8bytes.org, dwmw2@infradead.org,
        tony@atomide.com, akpm@linux-foundation.org, sfr@canb.auug.org.au,
        treding@nvidia.com, keescook@chromium.org, iamjoonsoo.kim@lge.com,
        wsa+renesas@sang-engineering.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, iommu@lists.linux-foundation.org
Subject: Re: [RFC/RFT PATCH 1/2] dma-contiguous: Simplify
 dma_*_from_contiguous() function calls
Message-ID: <20190430194612.GA31543@Asurada-Nvidia.nvidia.com>
References: <20190430015521.27734-1-nicoleotsuka@gmail.com>
 <20190430015521.27734-2-nicoleotsuka@gmail.com>
 <20190430105640.GA20021@lst.de>
 <0e3e6d8b-de44-d23e-a039-8d11b578ec5c@arm.com>
 <20190430151833.GB25447@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190430151833.GB25447@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 30, 2019 at 05:18:33PM +0200, Christoph Hellwig wrote:
> On Tue, Apr 30, 2019 at 01:37:54PM +0100, Robin Murphy wrote:
> > On 30/04/2019 11:56, Christoph Hellwig wrote:
> >> So while I really, really like this cleanup it turns out it isn't
> >> actually safe for arm :(  arm remaps the CMA allocation in place
> >> instead of using a new mapping, which can be done because they don't
> >> share PMDs with the kernel.
> >>
> >> So we'll probably need a __dma_alloc_from_contiguous version with
> >> an additional bool fallback argument - everyone but arms uses
> >> dma_alloc_from_contiguous as in your patch, just arm will get the
> >> non-fallback one.
> >
> > Or we even just implement dma_{alloc,free}_contiguous() as a wrapper around 
> > the existing APIs so that users can be thoroughly checked and converted 
> > one-by-one.
> 
> Yeah.  Actually given all the contention I wonder if the easiest solution
> for now is to just open code the cma_alloc/cma_free calls in dma-direct
> and dma-iommu, with the hopes that everyone is going to migrate to those
> implementations in the mid-term anyway and dma_alloc_from_contiguous /
> dma_release_from_contiguous just go away..

Thanks for the comments.

Listing all the solutions as a summary:
A) Add "bool fallback" to dma_{alloc,free}_contiguous, and let
   ARM use fallback=false.
B) Continue replacing "_from" with dma_{alloc,free}_contiguous
   but let callers like ARM use cma_alloc/free() directly.
C) Have both new dma_{alloc,free}_contiguous and "_from" funcs.
   Implement the new one to dma-direct only as an initial step
   and change others one-by-one in the future.

Combining the comments at alloc_pages_node(), I guess that the
Solution C would be a better (cleaner) one?

List of to-change callers for Solution C:
 kernel/dma/direct.c

List of to-exclude-for-now callers for Solution C:
 arch/arm64/mm/dma-mapping.c
 drivers/iommu/amd_iommu.c
 drivers/iommu/intel-iommu.c
 arch/arm/mm/dma-mapping.c
 arch/xtensa/kernel/pci-dma.c
 kernel/dma/remap.c
