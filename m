Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA2E3CA9EC7
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 00:58:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A51DE20856
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 00:58:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TwUbDG8Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbfJaA6W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 20:58:22 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:38437 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbfJaA6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 20:58:22 -0400
Received: by mail-oi1-f194.google.com with SMTP id v186so3723310oie.5
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 17:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xn3wt7zeh/3rppc1L7rcKeyTmnM/BkitWprTiAV8aM0=;
        b=TwUbDG8ZLm0XuCmFc8MZZqCK1HSOzTjZb8ntC7xShYO4+vlf0NZbb5PJUr5erdY437
         JcHz5XuJdjqeX1NWvpVl3OB2hiTB4Ihb/9O9Df6eHcyThVYIKhMeT+lV2wKraHQN6CRr
         V0MR+vrcfEFpOpfbcCQoKxGW4l7sFi4t+/n+9XOnaOeBoGEHrveANLMUs+OyEq3Zss2j
         yJ6tZ3rHNAHu4nn/JH9wOv5mQ35JO0xFNSzAH5XezYeJbk6tcoO7Q2jo7vRlFRnSMgOh
         2XWjUa++ghTYFNT4lv/XrIlwZxw+vzT5ZCKiPU1IxCINH9Vci2BL64XJ+DK9JHK254Yf
         HdJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xn3wt7zeh/3rppc1L7rcKeyTmnM/BkitWprTiAV8aM0=;
        b=VH0CdO70aNBUREirRvjFfyWXNpD471w7/gH73eJtP8m33B9QB4HtJ5xtk6+3i3L3fy
         YYmD6GA6KOfvc1NerhBT03RbFRwwYAyz55z7cmo4MD4tILBp3YIZ7CIo80msnQWlNp8N
         CKyKP+fLeMPKNiYyqQ6u6QLo5lq3ZbJ65zScXY4o7YFQsppJJDeVO1N9nKOP1XKNIINr
         P9b0fGUPNkjUG6HG71hQDNqRQ2kydhk/GoiDa5D2JstDTbRyBLFYiJFqG7kswvpI6S8N
         q4Ho5gWZgldFxOHIYMKnJA/Wsah2rvdkASbiFLG+bJJbrOU+vyMCoTRsC5H8CB52HlO+
         u3bw==
X-Gm-Message-State: APjAAAWQjNz0xlRtLo7MDHOxnJy0JpvJheX5+OXrR67ewIKmbwEvL8SH
        2iXaViWFwhfl77gqFtlkogCM0cqo4DLCuWL4ri/5JDOz
X-Google-Smtp-Source: APXvYqyS3DMBg65Ye7nRPk060y0yAja9lSunJOF6IVSILt7xyfNn2SuwgHfDwTh0DfUd3/Vl5/aYmUSjopcaf8cfyqE=
X-Received: by 2002:aca:b03:: with SMTP id 3mr1750453oil.24.1572483500865;
 Wed, 30 Oct 2019 17:58:20 -0700 (PDT)
MIME-Version: 1.0
References: <20191030145112.19738-1-will@kernel.org> <6e457227-ca06-2998-4ffa-a58ab171ce32@arm.com>
 <20191030155444.GC19096@willie-the-truck>
In-Reply-To: <20191030155444.GC19096@willie-the-truck>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 30 Oct 2019 17:57:44 -0700
Message-ID: <CAGETcx9ogWQC1ZtnS_4xC3ShqBpuRSKudWEEWC22UZUEhdEU4A@mail.gmail.com>
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

On Wed, Oct 30, 2019 at 8:54 AM Will Deacon <will@kernel.org> wrote:
>
> Hi Robin,
>
> On Wed, Oct 30, 2019 at 03:35:55PM +0000, Robin Murphy wrote:
> > On 30/10/2019 14:51, Will Deacon wrote:
> > > As part of the work to enable a "Generic Kernel Image" across multiple
> > > Android devices, there is a need to seperate shared, core kernel code
> > > from modular driver code that may not be needed by all SoCs. This means
> > > building IOMMU drivers as modules.
> > >
> > > It turns out that most of the groundwork has already been done to enable
> > > the ARM SMMU drivers to be 'tristate' options in drivers/iommu/Kconfig;
> > > with a few symbols exported from the IOMMU/PCI core, everything builds
> > > nicely out of the box. The one exception is support for the legacy SMMU
> > > DT binding, which is not in widespread use and has never worked with
> > > modules, so we can simply remove that when building as a module rather
> > > than try to paper over it with even more hacks.
> > >
> > > Obviously you need to be careful about using IOMMU drivers as modules,
> > > since late loading of the driver for an IOMMU serving active DMA masters
> > > is going to end badly in many cases. On Android, we're using device links
> > > to ensure that the IOMMU probes first.
> >
> > Out of curiosity, which device links are those? Clearly not the RPM links
> > created by the IOMMU drivers themselves... Is this some special Android
> > magic, or is there actually a chance of replacing all the
> > of_iommu_configure() machinery with something more generic?
>
> I'll admit that I haven't used them personally yet, but I'm referring to
> this series from Saravana [CC'd]:
>
> https://lore.kernel.org/linux-acpi/20190904211126.47518-1-saravanak@google.com/
>
> which is currently sitting in linux-next now that we're upstreaming the
> "special Android magic" ;)

Hi Robin,

Actually, none of this is special Android magic. Will is talking about
the of_devlink feature that's been merged into driver-core-next.

A one line summary of of_devlink: the driver core + firmware (DT in
this case) automatically add the device links during device addition
based on the firmware properties of each device. The link that Will
gave has more details.

Wrt IOMMUs, the only missing piece in upstream is a trivial change
that does something like this in drivers/of/property.c

+static struct device_node *parse_iommus(struct device_node *np,
+                                        const char *prop_name, int index)
+{
+        return parse_prop_cells(np, prop_name, index, "iommus",
+                                "#iommu-cells");
+}

static const struct supplier_bindings of_supplier_bindings[] = {
        { .parse_prop = parse_clocks, },
        { .parse_prop = parse_interconnects, },
        { .parse_prop = parse_regulators, },
+        { .parse_prop = parse_iommus, },
        {},
};

I plan to upstream this pretty soon, but I have other patches in
flight that touch the same file and I'm waiting for those to get
accepted. I also want to clean up the code a bit to reduce some
repetition before I add support for more bindings.

Thanks,
Saravana
