Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6D9FC5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 06:17:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E3B621D79
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 06:17:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fT+bnEt+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbfKGGRS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 01:17:18 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34967 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbfKGGRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 01:17:17 -0500
Received: by mail-ot1-f68.google.com with SMTP id z6so1062186otb.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 22:17:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0adq3VsWHIu/rncfodFFEkNMnfieV/vfE3F2paMIBL8=;
        b=fT+bnEt+40WN2y423AvRis/djiprLbX9Fj4L0pz8YCFpInBk6OhHJODAseWN0+lRNI
         gLPom3wNE27xYHIL4GPNr33clKTlZ2xiCfuGZNQjm8qKG8oZhrDfdexhTCYbnMkgwJye
         +ewgwtLNAVeStD4500bqVJM8HGwQjZ2nzHZa2lrotFN7ECMYzXDjTqpLgFoRCx02saYU
         TLZXWMkaLmIoQnjE/OkgO+xur4LupGcp0bpRGYgk6Fgn86ChH7nNNZ4rtTlx18b+K9we
         ZVFLsX/Y6ju+ljNnIyf0sdS81lFxqJEE7c9kgih+VxqoNd9aCrZBLQvpttUiSVIBUQq2
         mgnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0adq3VsWHIu/rncfodFFEkNMnfieV/vfE3F2paMIBL8=;
        b=pHDLZ7VnPEeKdRhc3+2I4PXwOYAuxNKGuIeu66NeDGWLiaNCAKGMci401QtUdrRVhT
         ZmJ/IP341FNtJQDPIwQg4paQ8ok/0amwPsuntXy1YsN19N04prZKs1m1Wl25gbx/UtGT
         pZyWxsIQKJpO58g16slaWHBBQYB/oE1d73ri1KD+pJOg0vfmoaDGQSzTcSLlj1cQytIh
         NNxfKU6us/gHnOheZCvgtXuFFmBsn8yxjKSkRqln4o4/AA2//O7B0eb2cQYps3uu2nve
         EBb5SsxGBKvQIo1L6bWhe8/K8tKmR9nW+LgWZi1reJ2gcy/tycEi04wgQ8KpRyb80B2p
         2mdg==
X-Gm-Message-State: APjAAAXvSb3Qe6qe2tNQEMz4ecsUXG+YUY2UZKfeXHoxPNfHD1x9MhAs
        GvCeBl6o/iWLqUBN1mzO/xbB0LbcPVVJOg/p3gctvw==
X-Google-Smtp-Source: APXvYqxIKiJCRgw+tF8epMGZgRHwiw0mYTvdcIGp0CKeC2Wq9xeUK5GRNSRpXbR3aK/o0MFPo6mn8PDy6M1ya/2hTZM=
X-Received: by 2002:a9d:7ac2:: with SMTP id m2mr1443221otn.225.1573107436285;
 Wed, 06 Nov 2019 22:17:16 -0800 (PST)
MIME-Version: 1.0
References: <20191030145112.19738-1-will@kernel.org> <6e457227-ca06-2998-4ffa-a58ab171ce32@arm.com>
 <20191030155444.GC19096@willie-the-truck> <CAGETcx9ogWQC1ZtnS_4xC3ShqBpuRSKudWEEWC22UZUEhdEU4A@mail.gmail.com>
In-Reply-To: <CAGETcx9ogWQC1ZtnS_4xC3ShqBpuRSKudWEEWC22UZUEhdEU4A@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 6 Nov 2019 22:16:40 -0800
Message-ID: <CAGETcx8Y6-RGNWZ2qjC7-9UbfUZmQA2JYXDAJSsjpqw01qK_ug@mail.gmail.com>
Subject: Re: [PATCH 0/7] iommu: Permit modular builds of ARM SMMU[v3] drivers
To:     Will Deacon <will@kernel.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 30, 2019 at 5:57 PM Saravana Kannan <saravanak@google.com> wrote:
>
> On Wed, Oct 30, 2019 at 8:54 AM Will Deacon <will@kernel.org> wrote:
> >
> > Hi Robin,
> >
> > On Wed, Oct 30, 2019 at 03:35:55PM +0000, Robin Murphy wrote:
> > > On 30/10/2019 14:51, Will Deacon wrote:
> > > > As part of the work to enable a "Generic Kernel Image" across multiple
> > > > Android devices, there is a need to seperate shared, core kernel code
> > > > from modular driver code that may not be needed by all SoCs. This means
> > > > building IOMMU drivers as modules.
> > > >
> > > > It turns out that most of the groundwork has already been done to enable
> > > > the ARM SMMU drivers to be 'tristate' options in drivers/iommu/Kconfig;
> > > > with a few symbols exported from the IOMMU/PCI core, everything builds
> > > > nicely out of the box. The one exception is support for the legacy SMMU
> > > > DT binding, which is not in widespread use and has never worked with
> > > > modules, so we can simply remove that when building as a module rather
> > > > than try to paper over it with even more hacks.
> > > >
> > > > Obviously you need to be careful about using IOMMU drivers as modules,
> > > > since late loading of the driver for an IOMMU serving active DMA masters
> > > > is going to end badly in many cases. On Android, we're using device links
> > > > to ensure that the IOMMU probes first.
> > >
> > > Out of curiosity, which device links are those? Clearly not the RPM links
> > > created by the IOMMU drivers themselves... Is this some special Android
> > > magic, or is there actually a chance of replacing all the
> > > of_iommu_configure() machinery with something more generic?
> >
> > I'll admit that I haven't used them personally yet, but I'm referring to
> > this series from Saravana [CC'd]:
> >
> > https://lore.kernel.org/linux-acpi/20190904211126.47518-1-saravanak@google.com/
> >
> > which is currently sitting in linux-next now that we're upstreaming the
> > "special Android magic" ;)
>
> Hi Robin,
>
> Actually, none of this is special Android magic. Will is talking about
> the of_devlink feature that's been merged into driver-core-next.
>
> A one line summary of of_devlink: the driver core + firmware (DT in
> this case) automatically add the device links during device addition
> based on the firmware properties of each device. The link that Will
> gave has more details.
>
> Wrt IOMMUs, the only missing piece in upstream is a trivial change
> that does something like this in drivers/of/property.c
>
> +static struct device_node *parse_iommus(struct device_node *np,
> +                                        const char *prop_name, int index)
> +{
> +        return parse_prop_cells(np, prop_name, index, "iommus",
> +                                "#iommu-cells");
> +}
>
> static const struct supplier_bindings of_supplier_bindings[] = {
>         { .parse_prop = parse_clocks, },
>         { .parse_prop = parse_interconnects, },
>         { .parse_prop = parse_regulators, },
> +        { .parse_prop = parse_iommus, },
>         {},
> };
>
> I plan to upstream this pretty soon, but I have other patches in
> flight that touch the same file and I'm waiting for those to get
> accepted. I also want to clean up the code a bit to reduce some
> repetition before I add support for more bindings.

As promised:
https://lore.kernel.org/lkml/20191105065000.50407-1-saravanak@google.com/

-Saravana
