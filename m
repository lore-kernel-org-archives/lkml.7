Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67B41C31E44
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 22:02:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37352205ED
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 22:02:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pzewXKZ6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392073AbfFKWCz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 18:02:55 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:37768 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388229AbfFKWCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 18:02:55 -0400
Received: by mail-qt1-f195.google.com with SMTP id y57so16521437qtk.4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 15:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=R9swLzsJtifGzX/KGk8yeNVFbi1iTRDL+GJQQbSCuHo=;
        b=pzewXKZ6WLt/gjWkMo/+YcX2d1aUC7pklyoJxUu8q3zKqxx1flMzy8jeb/7oZw//7e
         n4tY5sJXhu7TuLgALjdbbafHpSOA+A2sioMhaWtNvsh4EllR9PPctlua829MgJu9hRG+
         alLFj8zcOmCiLtrOZkf7HOrUmXYe99B8EN4AoGBwkI7swdcDtQmv3Hw6yPI2GlEZ5DXv
         W8M6/qoZDCVWs/U+iZHan2LOUDYydc/m2Okkbn2NUW4J5DktIG7knHhnnED+j7UDZ9Os
         buQJJZE5zjwDnO98adcxLv7JHOfwUgkcyajfv6gvSwEvnBHwx/UWYt6EKRhhTkyPdozS
         qcnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=R9swLzsJtifGzX/KGk8yeNVFbi1iTRDL+GJQQbSCuHo=;
        b=hbypklSqYpWWQ7yPYTCTCRS8cAm1ErSWwYv5CRn9rRV0qalzWYfgXomx0utc7G3ZZF
         4HvguYEb6FEFlPjwvWdV36PDYJ6mh2S3uIKqNcU9y/TqOVG5K0SX76C1SOkGrKF5GWxC
         bgatmJJpJaoJx1Y9C98CdhCJ08Om8uXHIx9AcDlGaBWXdocZ65M/e9M3JTjxWwBl1JVI
         TXB/TnV3sv6LomCUhDHwlfSItUWSo8Yszpxr49S7u5iGUdGuI0EakSCNHylRdNnqO7CM
         kY1YtIQmSjlX8AYUBJIq2kpR3XovIyvFUCJljXu43ep6mzdcn0Sta/c4o9wMmFUGYqhN
         6HjQ==
X-Gm-Message-State: APjAAAWnPufH14jXlXjVhdolWsdM09iOHfSyKZo1JUYlrngqrjz3c+eu
        VL8Z0dW0Met3WXevsaYJu/SvNTY=
X-Google-Smtp-Source: APXvYqwOQtjfyFgAZmlFDKa9/7lOxef59kekI0Pll+EBAT2I25+2U68GqYPKoe6lJWSSeIJgeExygQ==
X-Received: by 2002:ac8:1829:: with SMTP id q38mr48707241qtj.252.1560290574364;
        Tue, 11 Jun 2019 15:02:54 -0700 (PDT)
Received: from gabell (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id x10sm6172576qtc.34.2019.06.11.15.02.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Jun 2019 15:02:53 -0700 (PDT)
Date:   Tue, 11 Jun 2019 18:02:47 -0400
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-kernel@vger.kernel.org,
        Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>,
        Zhang Lei <zhang.lei@jp.fujitsu.com>,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 1/2] arm64/mm: check cpu cache line size with
 non-coherent device
Message-ID: <20190611220246.lyhcqahsxyxuhqjk@gabell>
References: <20190611151731.6135-1-msys.mizuma@gmail.com>
 <20190611151731.6135-2-msys.mizuma@gmail.com>
 <20190611180007.him7md7gdcjs5cg6@mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190611180007.him7md7gdcjs5cg6@mbp>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 07:00:07PM +0100, Catalin Marinas wrote:
> On Tue, Jun 11, 2019 at 11:17:30AM -0400, Masayoshi Mizuma wrote:
> > --- a/arch/arm64/mm/dma-mapping.c
> > +++ b/arch/arm64/mm/dma-mapping.c
> > @@ -91,10 +91,6 @@ static int __swiotlb_mmap_pfn(struct vm_area_struct *vma,
> >  
> >  static int __init arm64_dma_init(void)
> >  {
> > -	WARN_TAINT(ARCH_DMA_MINALIGN < cache_line_size(),
> > -		   TAINT_CPU_OUT_OF_SPEC,
> > -		   "ARCH_DMA_MINALIGN smaller than CTR_EL0.CWG (%d < %d)",
> > -		   ARCH_DMA_MINALIGN, cache_line_size());
> >  	return dma_atomic_pool_init(GFP_DMA32, __pgprot(PROT_NORMAL_NC));
> >  }
> >  arch_initcall(arm64_dma_init);
> > @@ -473,6 +469,11 @@ void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
> >  			const struct iommu_ops *iommu, bool coherent)
> >  {
> >  	dev->dma_coherent = coherent;
> > +
> > +	if (!coherent && (cache_line_size() > ARCH_DMA_MINALIGN))
> > +		dev_WARN(dev, "ARCH_DMA_MINALIGN smaller than CTR_EL0.CWG (%d < %d)",
> > +				ARCH_DMA_MINALIGN, cache_line_size());
> 
> I'm ok in principle with this patch, with the minor issue that since
> commit 7b8c87b297a7 ("arm64: cacheinfo: Update cache_line_size detected
> from DT or PPTT") queued for 5.3 cache_line_size() gets the information
> from DT or ACPI. The reason for this change is that the information is
> used for performance tuning rather than DMA coherency.
> 
> You can go for a direct cache_type_cwg() check in here, unless Robin
> (cc'ed) has a better idea.

Got it, thanks.
I believe coherency_max_size is zero in case of coherent is false,
so I'll modify the patch as following. Does it make sense?

@@ -57,6 +53,11 @@ void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
                        const struct iommu_ops *iommu, bool coherent)
 {
        dev->dma_coherent = coherent;
+
+       if (!coherent && (cache_line_size() > ARCH_DMA_MINALIGN))
+               dev_WARN(dev, "ARCH_DMA_MINALIGN smaller than CTR_EL0.CWG (%d < %d)",
+                               ARCH_DMA_MINALIGN, (4 << cache_type_cwg()));
+
        if (iommu)
                iommu_setup_dma_ops(dev, dma_base, size);

Thanks,
Masa
