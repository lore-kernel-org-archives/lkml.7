Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AF48C3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 23:15:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 696462083B
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 23:15:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VcM21+nd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387696AbfHOXPr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 19:15:47 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46223 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731810AbfHOXPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 19:15:47 -0400
Received: by mail-pg1-f194.google.com with SMTP id m3so1369065pgv.13;
        Thu, 15 Aug 2019 16:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/v9tU0xIroUvQiZHpPeVNbxV4bXo+Z66N2xiweMuj/s=;
        b=VcM21+ndRnd7xqqraDhvB2sUdKKltZlEjINKqEkAQcOsXcdRlHbAkzF51Pq/xUdJKK
         b8Me9cBOz0egqX90akXWczasU1W6RKKB6zojJDlFba4E4PpsiSxLWwe0Ogf7Ufpgc6Hy
         wXk+WLqnbTM57rPHgNgtQg71IJLoEx8s9duD5UHqdNZlMQJ0DdM3XOE85pC8eorWYxgP
         siQhhFTpEKj6StQ698eF9ZzOKu4w1K3iSOMQyyNnrKEH8gfJsZYF561ay0as6ARoUWiO
         llky3FpYFpJs0iSG/2COrfIlaH2B03OCMnmHQKuT27gH09GwMK8/GXFfiNsPtDrqe2wD
         pjkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/v9tU0xIroUvQiZHpPeVNbxV4bXo+Z66N2xiweMuj/s=;
        b=fWTKm4SZkumSwzLFEx2WwDdlPj/RQit7E6q20nRjoqL1ghGL+XJ+qR5JJyDk+DJHen
         +K+Wc7/25ZDwI8qmGBkKRYorZHeVHhad7uvrPrIwXbr0+VwsDDGbjXNLSCTNj2+YagNi
         K0ON9j8Z3gnStqQ0yBnDJJ+x0uQCe5Ix00mG5a9kTpYjlluBn0Hiqi8+Gwzc7K+jXeHy
         nWqQlu36wNm2B8ORKkg6BslrVTDkzR4pX2UlfdojYbAipHxHWsE3fPeN0XtxIkgw/qr7
         zaHpr9aHg9Sl+QS6/+u3I/fv0J0Z2QvnQb2Vq+iyIDeKDzFdi+Liy8cNEid853i7kLhv
         mRXA==
X-Gm-Message-State: APjAAAUPAZB/UHV9xKT/ApdYgqYt/G/Vce5xgG65VFgPlqE08PIc5wZa
        jXYCkaOjxabUH89/ZchjSfk=
X-Google-Smtp-Source: APXvYqw1CMLHSWPhw3uHn0rGZ1z9tJxtVCD6aWzr7lg0zLhlZ0iQ6M67a9GlhiqTPqnx6jojQT3SsQ==
X-Received: by 2002:a63:9245:: with SMTP id s5mr5420191pgn.123.1565910945942;
        Thu, 15 Aug 2019 16:15:45 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id c35sm2912426pgl.72.2019.08.15.16.15.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 15 Aug 2019 16:15:45 -0700 (PDT)
Date:   Thu, 15 Aug 2019 16:16:46 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     ulf.hansson@linaro.org, thierry.reding@gmail.com,
        jonathanh@nvidia.com, linux-mmc@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        vdumpa@nvidia.com
Subject: Re: [PATCH v2] mmc: tegra: Implement enable_dma() to set dma_mask
Message-ID: <20190815231646.GA15635@Asurada-Nvidia.nvidia.com>
References: <20190814005741.13331-1-nicoleotsuka@gmail.com>
 <09d9ba41-f4cd-e515-cd2d-0b4134648059@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09d9ba41-f4cd-e515-cd2d-0b4134648059@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 15, 2019 at 02:48:20PM +0300, Adrian Hunter wrote:
> On 14/08/19 3:57 AM, Nicolin Chen wrote:
> > [ Integrated the change and commit message made by Thierry Reding ]
> > 
> > The SDHCI controller found in early Tegra SoCs (from Tegra20 through
> > Tegra114) used an AHB interface to the memory controller, which allowed
> > only 32 bits of memory to be addressed.
> > 
> > Starting with Tegra124, this limitation was removed by making the SDHCI
> > controllers native MCCIF clients, which means that they got increased
> > bandwidth and better arbitration to the memory controller as well as an
> > address range extended to 40 bits, out of which only 34 were actually
> > used (bits 34-39 are tied to 0 in the controller).
> > 
> > For Tegra186, all of the 40 bits can be used; For Tegra194, 39-bit can
> > be used.
> > 
> > So far, sdhci-tegra driver has been relying on sdhci core to configure
> > the DMA_BIT_MASK between 32-bit or 64-bit, using one of quirks2 flags:
> > SDHCI_QUIRK2_BROKEN_64_BIT_DMA. However, there is a common way, being
> > mentioned in sdhci.c file, to set dma_mask via enable_dma() callback in
> > the device driver directly.
> > 
> > So this patch implements an enable_dma() callback in the sdhci-tegra,
> > in order to set an accurate DMA_BIT_MASK, other than just 32/64 bits.
> 
> Is there a reason this cannot be done at probe time?

It's supposed to be done at probe() time. But sdhci_setup_host()
does both 32-bit/64-bit dma_mask setting and dma_alloc(), so if
the dma_mask isn't correctly set inside sdhci_setup_host(), the
allocation would fall to a 64-bit IOVA range that hardware does
not support -- smmu error would happen and crash the system. On
the other hand, ->enable_dma() is called in that function right
after 32-bit/64-bit dma_mask setting. Or is there any other way
of adding to probe() that I am missing here?

Thanks
Nicolin
