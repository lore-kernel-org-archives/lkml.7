Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 376D9C5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 06:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0054D218AE
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 06:02:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W0EvcZZS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbfKGGCv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 01:02:51 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:38172 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbfKGGCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 01:02:51 -0500
Received: by mail-ot1-f68.google.com with SMTP id v24so1025152otp.5
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 22:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U0ErkhVGaL41tlGkE5V/KZZ/5b46WzaSkkkhcubMXUk=;
        b=W0EvcZZS99VpCl5NOjb/XyG30Zb5QpgxWFKv42rpG9bcAduwrEGYKLO5+r5GY2/dOZ
         G97YE5sR0CULxvxBnFamCTSaCYU7JHQUhbmFhbbtNx4YJUm87ND2CPPrY2AoJ6SiNZYs
         MHJ0nxy5NJxRp5yJfbeRtCzm/CUSi2nh3Z04J0kFvSeBdzKhYxxe4DITy6OlgYLtpUOe
         rz7C1NAY0aTHsm1HfbRJ8XwwCvvXXL7kueBgctPXfltlBWTX1ZtKZg2W3MTIfkRm52En
         PxQG7Nrp0IVgFl+0C+T6mzLSridXjcgGOK7G7EWbHfkXXNJf1XjTeu57qK+K5PNm0Weq
         l4Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U0ErkhVGaL41tlGkE5V/KZZ/5b46WzaSkkkhcubMXUk=;
        b=WZD0VeKkjf+GAIvduMk/VAq/LT5vy58taie1GdUZVo/pzRFvRLZ16d/a59KYyv1IGC
         p0t6LM1mhZlNApVTbZPMH07lJEk8+XEaXN6Ef7bdCYxx5DMPCyapZoYNJusGLKIBzBxw
         t3KtJq4VHcbKBhT9Jp66/PHQRt2YpC075ru8RiE8kAc2Ay5mwcVbolPYAuQRP7xABQtk
         aw9iK2cmwiGPouJcy1aVWB0O5kN4rq41e6fKxSYyUueI6BBYj5lbikvuGQb8SRD+fhaX
         bTKhZBMuNGk/N8Pt6nViM0gmQElQKXaU5B08MLPWo2G2nCPvAOdixza94eMo1i8fMiz6
         MoFQ==
X-Gm-Message-State: APjAAAW7gXnafP9tlEapQ2YSMnqlCrrPhOHxtaVX9yMEw7uZH96L6Z4J
        6wYu3m1GNKtneCpe/litYeFoOcM+CdYsMrA3oZZG+g==
X-Google-Smtp-Source: APXvYqyYGqVBSufZwYtm7fzA1QXMCLwa5Z15TPe6y5IAP/FlDrRbiXtUN0V/Vm+bKDLaLeTdGr2lHBDrnvVyxg49Vuk=
X-Received: by 2002:a9d:6f15:: with SMTP id n21mr1482035otq.231.1573106570092;
 Wed, 06 Nov 2019 22:02:50 -0800 (PST)
MIME-Version: 1.0
References: <20191030145112.19738-1-will@kernel.org> <6e457227-ca06-2998-4ffa-a58ab171ce32@arm.com>
 <20191030155444.GC19096@willie-the-truck> <CAGETcx9ogWQC1ZtnS_4xC3ShqBpuRSKudWEEWC22UZUEhdEU4A@mail.gmail.com>
 <20191031193758.GA2607492@lophozonia> <CAGETcx-MuMVvj0O-MFdfmLADEq=cQY_=x+irvhgwHhG4VeeSdg@mail.gmail.com>
 <6994ae35-2b89-2feb-2bcb-cffc5a01963c@huawei.com> <CAGETcx-9M8vvHA2Lykcv0hHWoC2OAw5kfBrjcNJN2CYCwR4eWQ@mail.gmail.com>
 <47418554-e7a7-f9f3-8852-60cecef3d5c7@huawei.com>
In-Reply-To: <47418554-e7a7-f9f3-8852-60cecef3d5c7@huawei.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 6 Nov 2019 22:02:14 -0800
Message-ID: <CAGETcx_J=PLVvJm+JCYpS2C+ANa5zojPwu2P5vj4j+O5fEaOAg@mail.gmail.com>
Subject: Re: [PATCH 0/7] iommu: Permit modular builds of ARM SMMU[v3] drivers
To:     John Garry <john.garry@huawei.com>
Cc:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 4, 2019 at 4:16 AM John Garry <john.garry@huawei.com> wrote:
>
> On 01/11/2019 21:13, Saravana Kannan wrote:
> > On Fri, Nov 1, 2019 at 3:28 AM John Garry <john.garry@huawei.com> wrote:
> >>
> >> On 31/10/2019 23:34, Saravana Kannan via iommu wrote:
> >>> I looked into the iommu-map property and it shouldn't be too hard to
> >>> add support for it. Looks like we can simply hold off on probing the
> >>> root bridge device till all the iommus in its iommu-map are probed and
> >>> we should be fine.
> >>>
> >>>> I'm also unsure about distro vendors agreeing to a mandatory kernel
> >>>> parameter (of_devlink). Do you plan to eventually enable it by default?
> >>>>
> >>>>> static const struct supplier_bindings of_supplier_bindings[] = {
> >>>>>           { .parse_prop = parse_clocks, },
> >>>>>           { .parse_prop = parse_interconnects, },
> >>>>>           { .parse_prop = parse_regulators, },
> >>>>> +        { .parse_prop = parse_iommus, },
> >>>>>           {},
> >>>>> };
> >>>>>
> >>>>> I plan to upstream this pretty soon, but I have other patches in
> >>>>> flight that touch the same file and I'm waiting for those to get
> >>>>> accepted. I also want to clean up the code a bit to reduce some
> >>>>> repetition before I add support for more bindings.
> >>>> I'm also wondering about ACPI support.
> >>> I'd love to add ACPI support too, but I have zero knowledge of ACPI.
> >>> I'd be happy to help anyone who wants to add ACPI support that allows
> >>> ACPI to add device links.
> >>
> >> If possible to add, that may be useful for remedying this:
> >>
> >> https://lore.kernel.org/linux-iommu/9625faf4-48ef-2dd3-d82f-931d9cf26976@huawei.com/
> >
> > I'm happy that this change might fix that problem, but isn't the
> > problem reported in that thread more to do with child devices getting
> > added before the parent probes successfully? That doesn't make sense
> > to me.
>
> So the pcieport device and then the child device are added in the PCI
> scan, but only some time later do the device drivers probe for these
> devices; so it's not that the that pcieport driver creates the child device.

My lack of PCI knowledge might be showing, but without the pcieport
device itself being functional (I'm assuming this is the PCIe
controller) how does a PCI scan work? In anyway, I understand that all
devices are added at the same time as of today.

> The problem then occurs in that the ordering the of device driver probe
> is such that we have this: pcieport probe + defer (as no IOMMU group
> registered), SMMU probe (registers the IOMMU group), child device probe,
> pcieport really probe.
>
> Can't the piceport driver not add its child devices before it
> > probes successfully? Or more specifically, who adds the child devices
> > of the pcieport before the pcieport itself probes?
>
> The devices are actually added in order pcieport, child device, but not
> really probed in that same order, as above.

Thanks. Got it.

I guess one nice thing that came out of devicetree world is that the
child devices are never probed without the parent probing first (I'm
ignoring the simple-bus devices). It also kinda makes sense to me --
without a USB port device being added and probed, it doesn't make
sense to add the (keyboard, mouse, USB-HDD, etc) devices connected to
the USB port. But this is an orthogonal debate.

-Saravana
