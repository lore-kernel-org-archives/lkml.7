Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B853ECE58D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 13:48:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CFB421835
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 13:48:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X8Seepnv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731420AbfJINsM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 09:48:12 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:37634 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731254AbfJINsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 09:48:11 -0400
Received: by mail-qk1-f195.google.com with SMTP id u184so2271096qkd.4
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 06:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mESqt/CcfPjIOLtTAJm1X7rA5CiQI3dlP7XMSoawWCU=;
        b=X8SeepnvI8a/4+b3k0oX2sVEs4DLFuNjcVCmLUoyLwmaq4xfnf99emNKyMRmxVD+5y
         MA+WUG+RH+AkyFE8ETYwDk9gHsGNXC/T/dxEay1Verdo9zKWbo4fyITqZGSm1mck2nRp
         oQmTiAcrIMkr+EDtuvmaVherYhUk9/aH9TINyPmmJB0xtHCQYtoVP9ekeeDgprTHe2pN
         kWlskZ2V9cZxsfxLYUQuESd3vxNcXs9+ldHMZTJ1hfDubYe5uHMx1psxViP2TaZAyz0W
         hwA2yIlr+veenOhU3EP1zBt12CCZy1nMiO6FBguWGkhocBWd2i+uqYvyyKV9yMXvLIta
         2yyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=mESqt/CcfPjIOLtTAJm1X7rA5CiQI3dlP7XMSoawWCU=;
        b=VK04YQjNH0M5eoNek8S+lG825Xu7D+8jAut6GGGVpNmTtqsRCxTEHtvUeuiksoxM3C
         XF9oOLwPMIMMZHLJwyfnLBEujd7gKbisQNGp75t9W5/XPDDw+i3z+Vom09J7+3Ke9KJo
         e77upLo7ydh2iVOVRUOZf8l56wpox9LQd1Ddk0dskYRx4R89bLVetlzXIBEliHFLm7Ll
         LJW6wjMbrRYAzsNZjeW5y9bjfBq/A4P+DrGV+4c3IkH4MElj6z1R22v0GDhrKRAj2D0I
         VQPZ51Yr/f4DqCl139UwbDM2+F8tUAYCWrr2OXg22oasSPB5D6Yq6lBo/OKLimWhBCoP
         H3sw==
X-Gm-Message-State: APjAAAUENHtVmHWiloycHyW6p4AjG1+1fCgiFnqyT38bHaIYWx3ITIfm
        bK9KAyJt3fvN9a8XP9Nvv+eqFhGi9j0=
X-Google-Smtp-Source: APXvYqzvbtRnuvJaUDbwEZjYx3LQVRjq09cBMt+S3BGtXyy0Y9iKGCpQbNcs+e2qYDmrFsla0DXDHQ==
X-Received: by 2002:a05:620a:896:: with SMTP id b22mr3695929qka.216.1570628889709;
        Wed, 09 Oct 2019 06:48:09 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id 54sm1332668qts.75.2019.10.09.06.48.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Oct 2019 06:48:09 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Wed, 9 Oct 2019 09:48:07 -0400
To:     Christoph Hellwig <hch@lst.de>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: ehci-pci breakage with dma-mapping changes in 5.4-rc2
Message-ID: <20191009134807.GA2091030@rani.riverdale.lan>
References: <20191007175630.GA28861@infradead.org>
 <20191007175856.GA42018@rani.riverdale.lan>
 <20191007183206.GA13589@rani.riverdale.lan>
 <20191007184754.GB31345@lst.de>
 <20191007221054.GA409402@rani.riverdale.lan>
 <20191007235401.GA608824@rani.riverdale.lan>
 <20191008073210.GB9452@lst.de>
 <20191008115103.GA463127@rani.riverdale.lan>
 <20191008154731.GA616259@rani.riverdale.lan>
 <20191009065043.GA30157@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191009065043.GA30157@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 09, 2019 at 08:50:43AM +0200, Christoph Hellwig wrote:
> On Tue, Oct 08, 2019 at 11:47:31AM -0400, Arvind Sankar wrote:
> > Ok, I see that almost nothing actually uses dma_get_required_mask. So if
> > something did need >4Gb space, the IOMMU would allocate it anyway
> > regardless of dma_get_required_mask.
> 
> Yes.  And with the direct mapping it also isn't an issue.
> 
> > I'm thinking this means that we actually only needed to change
> > dma_get_required_mask to dma_direct_get_required_mask in
> > iommu_need_mapping, and the rest of the change is unnecessary?
> > 
> > Below is list of stuff calling dma_get_required_mask currently:
> 
> I guess that would actually work ok, but I prefer the more verbose
> version as it explain what is going on, and will lead people to do
> the right thing if we split the iommu vs passthrough case into
> different ops (we already had a patch for that out on the list).
> 
> > For the drivers that do currently use dma_get_required_mask, I believe
> > we will need to replace most of them with dma_direct_get_required_mask
> > as well to maintain passthrough functionality -- the fusion, scsi, and
> > infinband drivers all seem to be using this call to determine whether to
> > expose the device's 64-bit DMA capability or not. With the change they
> > will think they only need 32-bit DMA, which in turn will disable
> > passthrough on them.
> 
> At least for some of the legacy SCSI drivers that is intentional, and
> the reason why dma_get_required_mask was originally added.  On actual
> PCI (and PCI-X, but not PCIe which everyone uses now) the 64-bit
> addressing even if supported is not very efficient as it needs two
> bus cycles.  So we prefer to just use the iommu.
> 
> > The etnaviv driver is doing something funky that I'm not sure about, but
> > I *think* that one might want the real physical range as well. The mmc
> > driver I think might be ok with the 32-bit range.
> 
> etnaviv is never used on systems with the intel iommu anyway.
> 
> > The vmd controller one not sure about.
> 
> That just passes through the dma ops to work around really stupid
> intel chipsets.
> 
> > In dma-mapping.h, the function is used in dma_addressing_limited, which
> > in turn is used in a couple of amd drm drivers, again not sure about
> > these.
> ---end quoted text---

Thanks for the detailed explanation!

That means your changes actually improve the situation for those scsi
drivers -- previously they would have been using 64-bit addressing if
physical RAM needed it, regardless of IOMMU availability/use, right?
