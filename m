Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39354C10F14
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 15:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01046206BB
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 15:47:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iwpyDM1S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727931AbfJHPrf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 11:47:35 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:34247 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbfJHPrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 11:47:35 -0400
Received: by mail-qt1-f196.google.com with SMTP id 3so26001811qta.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 08:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lz6wmZrqYKR6xj2r+ZitJK/1SyqN3aeT6P1m1kpBh3w=;
        b=iwpyDM1Sd3bbh/guuUlVHqoo17U3qxH9BGb1CGMde5VOfq+EVnWmEQsj/BOnrJuSNE
         RVExOp1nKwv7yEIsND7GQacXLYn8HD8pbXnzq/r3+/KrQ+zC/590nURB/nVfudBE5tlj
         I1iB9gxC+7YMExzfvxTyb4WasAapiDI6Dyby7boAEseygQrerq86Gt68hOtF9VK5o4/R
         xrsN7aBCzs4+NfMu2BVpBmNI4N3XywyaDzgORG3MfuAwD2eT7bh11SlRoV6ONFarDWd5
         bfHgmM3H9BlvDYi342aMLaT5HYrM4PCi11f5RQMKddsCTYU13vv4zI9tEVNCuMRUwn1l
         BK+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=lz6wmZrqYKR6xj2r+ZitJK/1SyqN3aeT6P1m1kpBh3w=;
        b=RgiEb9Gk+fEHAZm6MZ/c/Au+JSSfjkgSACEbfdk3gYmZXjsmt9OR+cGigD4W6E4YIZ
         L6LkCcGMwdhtBOHeAEhU/cbgdVxP59CRwAedUnM9EfXAri/mNzpoPoJ+59mEA8jCu8u9
         e56Ci6wfJPR70jV76/A47qOE/lrIswOjgYCceX4ydSqMRq0VCLrdwYgRRns5e6KklxHt
         VbKZQV6NRUfJW1HG7KpzyE+qekocgToagQTygfOqPiF1qoXWbMZz0oF+qDsHP4q5eubl
         v9ByN5ZJtl/lTxvvKdCq6WgLdAGf3MJ5024YuPlZd2D9vVdoebAVaXfFaNLGue8bW8qk
         9YEA==
X-Gm-Message-State: APjAAAUq9tqwulcJgOM9R/P2VAJ2P6PVrFikGOielMA1McECxVdo0diz
        8m1KEhgJIlsQVc18NLYC8kM=
X-Google-Smtp-Source: APXvYqz3+7xIEfcUaODN8NM7OqxpNEMj0r/sYaJigJF6ux8+xVXjXHqlWaQvVK/Tmrm9AXIrakSOrQ==
X-Received: by 2002:aed:3e8d:: with SMTP id n13mr9909071qtf.116.1570549653627;
        Tue, 08 Oct 2019 08:47:33 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id n17sm10053315qke.103.2019.10.08.08.47.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Oct 2019 08:47:33 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Tue, 8 Oct 2019 11:47:31 -0400
To:     Christoph Hellwig <hch@lst.de>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: ehci-pci breakage with dma-mapping changes in 5.4-rc2
Message-ID: <20191008154731.GA616259@rani.riverdale.lan>
References: <20191007175430.GA32537@rani.riverdale.lan>
 <20191007175528.GA21857@lst.de>
 <20191007175630.GA28861@infradead.org>
 <20191007175856.GA42018@rani.riverdale.lan>
 <20191007183206.GA13589@rani.riverdale.lan>
 <20191007184754.GB31345@lst.de>
 <20191007221054.GA409402@rani.riverdale.lan>
 <20191007235401.GA608824@rani.riverdale.lan>
 <20191008073210.GB9452@lst.de>
 <20191008115103.GA463127@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191008115103.GA463127@rani.riverdale.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 08, 2019 at 07:51:03AM -0400, Arvind Sankar wrote:
> On Tue, Oct 08, 2019 at 09:32:10AM +0200, Christoph Hellwig wrote:
> > On Mon, Oct 07, 2019 at 07:54:02PM -0400, Arvind Sankar wrote:
> > > > Do you want me to resend the patch as its own mail, or do you just take
> > > > it with a Tested-by: from me? If the former, I assume you're ok with me
> > > > adding your Signed-off-by?
> > > > 
> > > > Thanks
> > > 
> > > A question on the original change though -- what happens if a single
> > > device (or a single IOMMU domain really) does want >4G DMA address
> > > space? Was that not previously allowed either?
> > 
> > Your EHCI device actually supports the larger addressing.  Without an
> > IOMMU (or with accidentally enabled passthrough mode as in your report)
> > that will use bounce buffers for physical address that are too large.
> > With an iommu we can just remap, and by default those remap addresses
> > are under 32-bit just to make everyones life easier.
> > 
> > The dma_get_required_mask function is misnamed unfortunately, what it
> > really means is the optimal mask, that is one that avoids bounce
> > buffering or other complications.
> 
> I understand that my EHCI device, even though it only supports 32-bit
> adddressing, will be able to DMA into anywhere in physical RAM, whether
> below 4G or not, via the IOMMU or bounce buffering.
> 
> What I mean is, do there exist devices (which would necessarily support
> 64-bit DMA) that want to DMA using bigger than 4Gb buffers. Eg a GPU
> accelerator card with 16Gb of RAM on-board that wants to map 6Gb for DMA
> in one go, or 5 accelerator cards that are in one IOMMU domain and want
> to simultaneously map 1Gb each.

Ok, I see that almost nothing actually uses dma_get_required_mask. So if
something did need >4Gb space, the IOMMU would allocate it anyway
regardless of dma_get_required_mask.

I'm thinking this means that we actually only needed to change
dma_get_required_mask to dma_direct_get_required_mask in
iommu_need_mapping, and the rest of the change is unnecessary?

Below is list of stuff calling dma_get_required_mask currently:

/usr/src/git/linux # find . -type f -name \*.[ch] | xargs grep -w dma_get_required_mask

./drivers/mmc/host/sdhci-of-dwcmshc.c:  extra = DIV_ROUND_UP_ULL(dma_get_required_mask(&pdev->dev), SZ_128M);
./drivers/pci/controller/vmd.c: return dma_get_required_mask(to_vmd_dev(dev));
./drivers/gpu/drm/etnaviv/etnaviv_gpu.c:                u32 dma_mask = (u32)dma_get_required_mask(gpu->dev);
./drivers/message/fusion/mptbase.c:             const uint64_t required_mask = dma_get_required_mask
./drivers/scsi/dpt_i2o.c:           dma_get_required_mask(&pDev->dev) > DMA_BIT_MASK(32) &&
./drivers/scsi/aic7xxx/aic79xx_osm_pci.c:               const u64 required_mask = dma_get_required_mask(dev);
./drivers/scsi/aic7xxx/aic7xxx_osm_pci.c:           && dma_get_required_mask(dev) > DMA_BIT_MASK(32)) {
./drivers/scsi/mpt3sas/mpt3sas_base.c:  required_mask = dma_get_required_mask(&pdev->dev);
./drivers/scsi/qla2xxx/qla_os.c:                if (MSD(dma_get_required_mask(&ha->pdev->dev)) &&
./drivers/scsi/aacraid/aachba.c:        if (dma_get_required_mask(&dev->pdev->dev) > DMA_BIT_MASK(32))
./drivers/scsi/aacraid/comminit.c:                              dma_get_required_mask(&dev->pdev->dev) >> 12;
./drivers/scsi/esas2r/esas2r_init.c:        dma_get_required_mask(&pcid->dev) > DMA_BIT_MASK(32) &&
./drivers/infiniband/sw/rxe/rxe_verbs.c:                                     dma_get_required_mask(&dev->dev));
./include/linux/dma-mapping.h:u64 dma_get_required_mask(struct device *dev);
./include/linux/dma-mapping.h:static inline u64 dma_get_required_mask(struct device *dev)
./include/linux/dma-mapping.h:                      dma_get_required_mask(dev);
./kernel/dma/mapping.c:u64 dma_get_required_mask(struct device *dev)
./kernel/dma/mapping.c:EXPORT_SYMBOL_GPL(dma_get_required_mask);

For the drivers that do currently use dma_get_required_mask, I believe
we will need to replace most of them with dma_direct_get_required_mask
as well to maintain passthrough functionality -- the fusion, scsi, and
infinband drivers all seem to be using this call to determine whether to
expose the device's 64-bit DMA capability or not. With the change they
will think they only need 32-bit DMA, which in turn will disable
passthrough on them.

The etnaviv driver is doing something funky that I'm not sure about, but
I *think* that one might want the real physical range as well. The mmc
driver I think might be ok with the 32-bit range.

The vmd controller one not sure about.

In dma-mapping.h, the function is used in dma_addressing_limited, which
in turn is used in a couple of amd drm drivers, again not sure about
these.
