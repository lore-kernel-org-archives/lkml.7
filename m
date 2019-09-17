Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CBE6C4CEC9
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 17:59:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED9392171F
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 17:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568743197;
	bh=hcrS5sWx7CpJDrlf9K3i36bzcfPumr+4M831UKbPHLE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EMZ/2AcInQwJkfL9w0A8U6FgQr3FJ2QoLsBCnWE0zKTTIdT+B+CjzO+Edff3+duty
	 i8yUupgv/w94yAfU5z5rhj3fTFtVj4yMvLKtn+k1UFjNvZN6Ahk8M16pUK/yqsZ+Gr
	 HRxs48K3yyKwVPBTJ2DHzzqBuAjEndpgaTFbKwmQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbfIQR74 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 13:59:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:37410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726118AbfIQR74 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 13:59:56 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 955BB20678;
        Tue, 17 Sep 2019 17:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568743195;
        bh=hcrS5sWx7CpJDrlf9K3i36bzcfPumr+4M831UKbPHLE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bFP+NyjSQAsNpicI1ptV1P/vs72FENrY36GYDEUn4aCZnZuekPLMsVkPM5KM7HNzq
         h51bLuQlx6vgTs4lo4bJiaLBBrsM1YElK4CYbmgWcSyFMCtx+ax0fHOjbHSv7S96na
         1ZnvvGM5k6i7ZtN/IVat9CQ3rMtol5MyEPyHrETw=
Date:   Tue, 17 Sep 2019 18:59:50 +0100
From:   Will Deacon <will@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iommu: dma: Use of_iommu_get_resv_regions()
Message-ID: <20190917175950.wrwiqnh5bp62uy3c@willie-the-truck>
References: <20190829111407.17191-1-thierry.reding@gmail.com>
 <20190829111407.17191-3-thierry.reding@gmail.com>
 <1caeaaa0-c5aa-b630-6d42-055b26764f40@arm.com>
 <20190902145245.GC1445@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190902145245.GC1445@ulmo>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 02, 2019 at 04:52:45PM +0200, Thierry Reding wrote:
> On Mon, Sep 02, 2019 at 03:22:35PM +0100, Robin Murphy wrote:
> > On 29/08/2019 12:14, Thierry Reding wrote:
> > > From: Thierry Reding <treding@nvidia.com>
> > > 
> > > For device tree nodes, use the standard of_iommu_get_resv_regions()
> > > implementation to obtain the reserved memory regions associated with a
> > > device.
> > 
> > This covers the window between iommu_probe_device() setting up a default
> > domain and the device's driver finally probing and taking control, but
> > iommu_probe_device() represents the point that the IOMMU driver first knows
> > about this device - there's still a window from whenever the IOMMU driver
> > itself probed up to here where the "unidentified" traffic may have already
> > been disrupted. Some IOMMU drivers have no option but to make the necessary
> > configuration during their own probe routine, at which point a struct device
> > for the display/etc. endpoint may not even exist yet.
> 
> Yeah, I think I'm actually running into this issue with the ARM SMMU
> driver. The above works fine with the Tegra SMMU driver, though, because
> it doesn't touch the SMMU configuration until a device is attached to a
> domain.
> 
> For anything earlier than iommu_probe_device(), I don't see a way of
> doing this generically. I've been working on a prototype to make these
> reserved memory regions early on for ARM SMMU but I've been failing so
> far. I think it would possibly work if we just switched the default for
> stream IDs to be "bypass" if they have any devices that have reserved
> memory regions, but again, this isn't quite working (yet).

I think we should avoid the use of "bypass" outside of the IOMMU probe()
routine if at all possible, since it leaves the thing wide open if we don't
subsequently probe the master.

Why can't we initialise a page-table early for StreamIDs with these
reserved regions, and then join that up later on if we see a device with
one of those StreamIDs attaching to a DMA domain? I suppose the nasty
case would be attaching to a domain that already has other masters
attached to it. Can we forbid that somehow for these devices? Otherwise,
I think we'd have to transiently switch to bypass whilst switching page
table.

What problems did you run into trying to implement this?

Will
