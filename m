Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFA86CA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 11:41:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BCC72086D
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 11:41:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tOyEr/By"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730233AbfKALly (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 07:41:54 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40280 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbfKALly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 07:41:54 -0400
Received: by mail-wr1-f65.google.com with SMTP id o28so9369025wro.7
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 04:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cgAvbaSbgc9PxmLx4qWyKX6RNTVeHFcJplgmwl+3SqM=;
        b=tOyEr/ByZUcAZ2uwZ1wlBKHmoLhamVBhf+3jsqtDRLcu5NWvK80/g8UsB0+M4mjZT1
         DllwdRA8BlEurUxVPOFgORa/g+069CHRMOqzrkjmthLlKrT/lz46U8/qPSxYBzGLkpP6
         KLlSEe1kn3cq6b6QWPEGIIlIAkqRavTSdZPPJwRVkd7fyvBNPyLfNtx35wyH4+G4H6Pb
         QHD2UD5pDuiMw0RmNxYv3kYvZ57PNdTlHNN2p8f1SRV0qMESrLMOOY/Jgp7XozYGXyBe
         IC6JrCllnl/3ArtvHQe34JhDJ3Gi5Cprzl1JrI8vyVmGPO/1A5bYC8963OidOLPwuFIS
         khdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cgAvbaSbgc9PxmLx4qWyKX6RNTVeHFcJplgmwl+3SqM=;
        b=euN20PBVnf/OmRkiH1XdDdVuT4iGuY2Jhu28EVcsnyBxduq05FAmtVUj7JZKqUmFNI
         RN9RFE7basZN7RV2mxjSBBV1GU2NgtqPlCT/DLGy4uaUM/YPkhT4TpxmODfvBUSKvwLL
         WhBE1ex6f6k75UaiJCeRBDwx8Te3DoUasdF+/jPCfwjkX+rM9FiLtUE4aS+Woya1AAOZ
         Bxxvbd7tod74m2Luk1G7XhaVdTV5tzoT/YoUHwaHJVMT+BhIDVqkURd6IkZzdf26uwTU
         2LpJ2nPjMPxmkfJv5hckabUlfzmUr1n1D35kzAgFEcGSgLA+DA4nSWKSzsJaaLC4c5x5
         Z1yQ==
X-Gm-Message-State: APjAAAWHF5R/CVnhCqj3Kzquh3O2wZZrAQAYkylBLEvId++zesCGVQ6m
        etvjd0oXKZFXuCgAYjwZzGG4pA==
X-Google-Smtp-Source: APXvYqxZP6VatLZnsDWxGPO7ueqgK7Q94K+GtMENoPqh73bjgQjbL3R3dkqg3K0UC6x7bY8y33DTFg==
X-Received: by 2002:a5d:5591:: with SMTP id i17mr9841016wrv.151.1572608510800;
        Fri, 01 Nov 2019 04:41:50 -0700 (PDT)
Received: from lophozonia ([91.217.168.176])
        by smtp.gmail.com with ESMTPSA id 36sm14681588wrj.42.2019.11.01.04.41.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 04:41:49 -0700 (PDT)
Date:   Fri, 1 Nov 2019 12:41:48 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Will Deacon <will@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        iommu@lists.linux-foundation.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 0/7] iommu: Permit modular builds of ARM SMMU[v3] drivers
Message-ID: <20191101114148.GA2694906@lophozonia>
References: <20191030145112.19738-1-will@kernel.org>
 <6e457227-ca06-2998-4ffa-a58ab171ce32@arm.com>
 <20191030155444.GC19096@willie-the-truck>
 <CAGETcx9ogWQC1ZtnS_4xC3ShqBpuRSKudWEEWC22UZUEhdEU4A@mail.gmail.com>
 <20191031193758.GA2607492@lophozonia>
 <CAGETcx-MuMVvj0O-MFdfmLADEq=cQY_=x+irvhgwHhG4VeeSdg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGETcx-MuMVvj0O-MFdfmLADEq=cQY_=x+irvhgwHhG4VeeSdg@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2019 at 04:34:14PM -0700, Saravana Kannan wrote:
> > Neat, I'm trying to do the same for virtio-iommu. It needs to be modular
> > because it depends on the virtio transport, which distributions usually
> > build as a module. So far I've been managing the device links in
> > virtio-iommu's add_device() and remove_device() callbacks [1]. Since it
> > relies on the existing probe deferral, I had to make a special case for
> > virtio-iommu to avoid giving up after initcalls_done [2].
> >
> > Currently buggy, it explodes on the second modprobe.
> >
> > [1] http://jpbrucker.net/git/linux/commit/?h=virtio-iommu/module-2019-10-31&id=f72978be18cb52eaa2d46dc762711bacbfab5039
> > [2] http://jpbrucker.net/git/linux/commit/?h=virtio-iommu/module-2019-10-31&id=f5fe188bb7fde33422ef08b9aad956dc3c77ec39
> >
> > [...]
> > > Wrt IOMMUs, the only missing piece in upstream is a trivial change
> > > that does something like this in drivers/of/property.c
> > >
> > > +static struct device_node *parse_iommus(struct device_node *np,
> > > +                                        const char *prop_name, int index)
> > > +{
> > > +        return parse_prop_cells(np, prop_name, index, "iommus",
> > > +                                "#iommu-cells");
> > > +}
> >
> > The 'iommus' property only applies to platform devices,
> 
> An early version of this patch series was limited to platform device,
> but that's not true with the version that Will pointed to and was
> merged into driver-core-next. The iommu parsing and creating device
> links applies to all devices that use DT. That's why this code is in
> of/property.c opposed to of/platform.c.
> 
> > do you have any
> > plan for PCI?  PCI devices generally don't have a DT node. Only their root
> > bridge has a node, with an 'iommu-map' property instead of 'iommus', so
> > I don't think add_links() would get called for them.
> 
> I looked into the iommu-map property and it shouldn't be too hard to
> add support for it. Looks like we can simply hold off on probing the
> root bridge device till all the iommus in its iommu-map are probed and
> we should be fine.

Virtio-iommu can use the PCI transport [3], in which case you need a
finer-grained approach. In some implementations you'll have the IOMMU
interface and endpoints managed by that IOMMU under the same RC. I'm not
proud of it.

[3] 6c9e92ef8bdd ("dt-bindings: virtio: Add virtio-pci-iommu node")

> > I'm also unsure about distro vendors agreeing to a mandatory kernel
> > parameter (of_devlink). Do you plan to eventually enable it by default?
> >
> > > static const struct supplier_bindings of_supplier_bindings[] = {
> > >         { .parse_prop = parse_clocks, },
> > >         { .parse_prop = parse_interconnects, },
> > >         { .parse_prop = parse_regulators, },
> > > +        { .parse_prop = parse_iommus, },
> > >         {},
> > > };
> > >
> > > I plan to upstream this pretty soon, but I have other patches in
> > > flight that touch the same file and I'm waiting for those to get
> > > accepted. I also want to clean up the code a bit to reduce some
> > > repetition before I add support for more bindings.
> >
> > I'm also wondering about ACPI support.
> 
> I'd love to add ACPI support too, but I have zero knowledge of ACPI.
> I'd be happy to help anyone who wants to add ACPI support that allows
> ACPI to add device links.

It's not as generic as device-tree, each vendor has their own table to
describe the IOMMU topology. I don't see a nice way to transpose the
add_links() callback there. Links need to be created either in a common
path (iommu_probe_device()) or in the APCI IORT driver.

> > IOMMU already has a sort of
> > canonical code path that links endpoints to their IOMMU
> > (iommu_probe_device()), after the firmware descriptions have been parsed.
> > So if we created the device links in the iommu core, for example
> > iommu_bus_notifier(), we would support all firmware interface flavors.
> > Otherwise we'll have to create those device links in the IORT driver as
> > well (plus DMAR and IVRS if they want it).
> 
> IOMMU driver/framework or whoever else can create device links as
> necessary. That's not mutually exclusive to the firmware adding device
> links (the device links APIs handle this nicely).

Oh right, device_link_add() would reuse an existing link. It even seems to
work for IOMMU drivers that want to manage PM links themselves
(DL_FLAG_STATELESS).

> While device probe
> ordering is one benefit of my patch series, that's not all of it
> though. It also deals with making sure suppliers known when they can
> clean up the boot state of their device even when the drivers for all
> their consumers are loaded as modules (so late initcall won't work). I
> can go into more details on this if needed, but that latter part is
> not very relevant in this context and you can find most of the details
> in my patch series/documentation I added.

Yes I admit I only glanced over it, but it seems like a nice solution. At
the moment of_iommu_xlate() handles the dependency itself. It currently
give up after initcalls but than can be tweaked to wait indefinitely (my
patch [2]). If of_devlink was enabled by default and handled iommu-map it
could probably replace the of_iommu probe deferral. For now it might be
best to manage device links somewhere in the IOMMU core, so ACPI
implementations (which do probe deferral their own way) can benefit from
it as well.

Thanks,
Jean
