Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11126C5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 06:12:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBBFD218AE
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 06:12:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e+dBQ6C4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbfKGGMd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 01:12:33 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:44699 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbfKGGMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 01:12:33 -0500
Received: by mail-ot1-f67.google.com with SMTP id c19so1005181otr.11
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 22:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wxgrq9s3ghC5A6WC6p6clH9tBiJhkp6+TNKHK4QLLHY=;
        b=e+dBQ6C4ix+BTTNhqo+tLHnyci+m1UPStSy7INaJroD2T55ii/Uzk1drz9MtYdqH+Z
         TN8JnIG2q9xtt+HnvQWf6/Itxfl7WVpgnKJ5qEWppqgeWzMPQpB99llfUEUdN7dM2sCc
         0UHm8YFIIp+BpVIrty6HYJHhisRCmnRXMkqTvYi4+48X6UIDvSBmS+ZieSxCa4xxEPRZ
         J7DQoyFDIsfKURj8V9vXWjYFTBWZwq2M06OhbeSu8q46U6/2LnXOk8yZtFg9srRxg6wm
         aTjIuX+yZGTBGU8/U/dgVAPP64p1DagRdBmKmuf0OKdQ8X7mml0eEFVwJ6HbflQsHzeD
         RGHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wxgrq9s3ghC5A6WC6p6clH9tBiJhkp6+TNKHK4QLLHY=;
        b=dEix4t87c1wh+UAtAepHHFFMzEaFLoUcmqtc16m0h+Y2VNF/hmX9NgMt5SOxykTgaP
         0dcSsHdeBJHRsUamcu7fAPl5woriaEBQou1J5iD5ArIcz160w2ildb8tm9huOs5YpnmY
         CddBIZMzEtIac4TG4Zi79pRmfJ0Yu6dRFQUW4QDfKL6t92ySLrDSJ+T3YTs4fKltkRH3
         Y0Bb9e0GBIZIlzr5YVu18RXGHvW+Wv1AkveSIqLQ1/td8A5JL0qlM/UAfdt4iYyGatTV
         szxbbXdltIEzdwd7MqYFCNhXMhbTdZEqqQG1sp0dOtg8pIxyQ50vdJTS71aRjYP7YU6v
         zvbw==
X-Gm-Message-State: APjAAAXwYpP5ic0QJzt6PpJs21eOAKeQXIHajRt3eyhyQaaFIHvhq93N
        SiD+vFeHNC110jmnVG2dNgoO8PUmgz3m25AuaHTJgg==
X-Google-Smtp-Source: APXvYqw5f32J/+2TKWy/1OIKDZl59KnLT7B0KOuaBdK9/MHs3hPr4NP61f3gzZiGyGTI66S83gA+NjtVIReAV3X7e78=
X-Received: by 2002:a05:6830:1d71:: with SMTP id l17mr1410310oti.236.1573107151683;
 Wed, 06 Nov 2019 22:12:31 -0800 (PST)
MIME-Version: 1.0
References: <20191030145112.19738-1-will@kernel.org> <6e457227-ca06-2998-4ffa-a58ab171ce32@arm.com>
 <20191030155444.GC19096@willie-the-truck> <CAGETcx9ogWQC1ZtnS_4xC3ShqBpuRSKudWEEWC22UZUEhdEU4A@mail.gmail.com>
 <20191031193758.GA2607492@lophozonia> <CAGETcx-MuMVvj0O-MFdfmLADEq=cQY_=x+irvhgwHhG4VeeSdg@mail.gmail.com>
 <6994ae35-2b89-2feb-2bcb-cffc5a01963c@huawei.com> <CAGETcx-9M8vvHA2Lykcv0hHWoC2OAw5kfBrjcNJN2CYCwR4eWQ@mail.gmail.com>
 <47418554-e7a7-f9f3-8852-60cecef3d5c7@huawei.com> <7e2429ed-6b25-a452-5e4d-51a5195b872f@arm.com>
In-Reply-To: <7e2429ed-6b25-a452-5e4d-51a5195b872f@arm.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 6 Nov 2019 22:11:55 -0800
Message-ID: <CAGETcx8QYBfGOBNtUTR+Lq_g+bmBxMOe0q=3U5UxvVqi+640Xw@mail.gmail.com>
Subject: Re: [PATCH 0/7] iommu: Permit modular builds of ARM SMMU[v3] drivers
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     John Garry <john.garry@huawei.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 4, 2019 at 5:29 AM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 04/11/2019 12:16, John Garry wrote:
> > On 01/11/2019 21:13, Saravana Kannan wrote:
> >> On Fri, Nov 1, 2019 at 3:28 AM John Garry <john.garry@huawei.com> wrote:
> >>>
> >>> On 31/10/2019 23:34, Saravana Kannan via iommu wrote:
> >>>> I looked into the iommu-map property and it shouldn't be too hard to
> >>>> add support for it. Looks like we can simply hold off on probing the
> >>>> root bridge device till all the iommus in its iommu-map are probed and
> >>>> we should be fine.
> >>>>
> >>>>> I'm also unsure about distro vendors agreeing to a mandatory kernel
> >>>>> parameter (of_devlink). Do you plan to eventually enable it by
> >>>>> default?
> >>>>>
> >>>>>> static const struct supplier_bindings of_supplier_bindings[] = {
> >>>>>>           { .parse_prop = parse_clocks, },
> >>>>>>           { .parse_prop = parse_interconnects, },
> >>>>>>           { .parse_prop = parse_regulators, },
> >>>>>> +        { .parse_prop = parse_iommus, },
> >>>>>>           {},
> >>>>>> };
> >>>>>>
> >>>>>> I plan to upstream this pretty soon, but I have other patches in
> >>>>>> flight that touch the same file and I'm waiting for those to get
> >>>>>> accepted. I also want to clean up the code a bit to reduce some
> >>>>>> repetition before I add support for more bindings.
> >>>>> I'm also wondering about ACPI support.
> >>>> I'd love to add ACPI support too, but I have zero knowledge of ACPI.
> >>>> I'd be happy to help anyone who wants to add ACPI support that allows
> >>>> ACPI to add device links.
> >>>
> >>> If possible to add, that may be useful for remedying this:
> >>>
> >>> https://lore.kernel.org/linux-iommu/9625faf4-48ef-2dd3-d82f-931d9cf26976@huawei.com/
> >>>
> >>
> >> I'm happy that this change might fix that problem, but isn't the
> >> problem reported in that thread more to do with child devices getting
> >> added before the parent probes successfully? That doesn't make sense
> >> to me.
> >
> > So the pcieport device and then the child device are added in the PCI
> > scan, but only some time later do the device drivers probe for these
> > devices; so it's not that the that pcieport driver creates the child
> > device.
> >
> > The problem then occurs in that the ordering the of device driver probe
> > is such that we have this: pcieport probe + defer (as no IOMMU group
> > registered), SMMU probe (registers the IOMMU group), child device probe,
> > pcieport really probe.
> >
> > Can't the piceport driver not add its child devices before it
> >> probes successfully? Or more specifically, who adds the child devices
> >> of the pcieport before the pcieport itself probes?
> >
> > The devices are actually added in order pcieport, child device, but not
> > really probed in that same order, as above.
>
> Right, in short the fundamental problem is that of_iommu_configure() now
> does the wrong thing. Deferring probe of the entire host bridge/root
> complex based on "iommu-map" would indeed happen to solve the problem by
> brute force, I think, but could lead to a dependency cycle for PCI-based
> IOMMUs as Jean points out.

Sorry for the late reply. Got caught up on other work.

I didn't think the SMMU itself was PCI based in the example Jean gave.
I thought it just happened to be the case where the SMMU probes after
the pcieport but before the other children. If the SMMU itself is a
child of the pcieport, how can it be required for the parent to
function? How will suspend/resume even work?! I feel like I'm missing
some context wrt to PCI that everyone else seems to know (which isn't
surprising).

> I hope to have time this week to work a bit
> more on pulling of_iommu_configure() apart to fix it properly, after
> which of_devlink *should* only have to worry about the child devices
> themselves...

Worry about child devices in what sense? From a non-iommu perspective?

-Saravana
