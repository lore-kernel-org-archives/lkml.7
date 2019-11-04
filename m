Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D16A6CA9EA0
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 11:43:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A77502184C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 11:43:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728506AbfKDLnb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 06:43:31 -0500
Received: from foss.arm.com ([217.140.110.172]:40634 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726441AbfKDLnb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 06:43:31 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C685D1FB;
        Mon,  4 Nov 2019 03:43:29 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (unknown [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BF4C03F71A;
        Mon,  4 Nov 2019 03:43:28 -0800 (PST)
Date:   Mon, 4 Nov 2019 11:43:19 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Will Deacon <will@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        iommu@lists.linux-foundation.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 0/7] iommu: Permit modular builds of ARM SMMU[v3] drivers
Message-ID: <20191104114312.GA15105@e121166-lin.cambridge.arm.com>
References: <20191030145112.19738-1-will@kernel.org>
 <6e457227-ca06-2998-4ffa-a58ab171ce32@arm.com>
 <20191030155444.GC19096@willie-the-truck>
 <CAGETcx9ogWQC1ZtnS_4xC3ShqBpuRSKudWEEWC22UZUEhdEU4A@mail.gmail.com>
 <20191031193758.GA2607492@lophozonia>
 <CAGETcx-MuMVvj0O-MFdfmLADEq=cQY_=x+irvhgwHhG4VeeSdg@mail.gmail.com>
 <20191101114148.GA2694906@lophozonia>
 <20191101122825.GA318@e121166-lin.cambridge.arm.com>
 <CAGETcx_U1huHHT=_xo6ArTWpmKMkr=rAy4ceoVUQv6XZGEDA_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGETcx_U1huHHT=_xo6ArTWpmKMkr=rAy4ceoVUQv6XZGEDA_w@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 01, 2019 at 02:26:05PM -0700, Saravana Kannan wrote:
> On Fri, Nov 1, 2019 at 5:28 AM Lorenzo Pieralisi
> <lorenzo.pieralisi@arm.com> wrote:
> >
> > On Fri, Nov 01, 2019 at 12:41:48PM +0100, Jean-Philippe Brucker wrote:
> >
> > [...]
> >
> > > > > I'm also wondering about ACPI support.
> > > >
> > > > I'd love to add ACPI support too, but I have zero knowledge of ACPI.
> > > > I'd be happy to help anyone who wants to add ACPI support that allows
> > > > ACPI to add device links.
> > >
> > > It's not as generic as device-tree, each vendor has their own table to
> > > describe the IOMMU topology. I don't see a nice way to transpose the
> > > add_links() callback there. Links need to be created either in a common
> > > path (iommu_probe_device()) or in the APCI IORT driver.
> >
> > We can create a generic stub that calls into respective firmware
> > handling paths (eg iort_dma_setup() in acpi_dma_configure()).
> >
> > There are three arches booting with ACPI so stubbing it out in
> > specific firmware handlers is not such a big deal, less generic
> > sure, but not catastrophically bad.
> 
> Ok, good to know.
> 
> > Obviously this works for IOMMU masters links
> 
> It's unclear to me what you are referring to here and it's throwing me
> off on the rest of the email.
> 
> Did you mean to say "IOMMU master's links"? As in the bus masters
> whose accesses go through IOMMUs? And "links" as in device links?
> 
> OR
> 
> Do you mean device links from bus master devices to IOMMUs here?

I meant associating endpoints devices to the IOMMU they are connected
to.

In DT you do it through "iommus", "iommu-map" properties, in ACPI
it is arch specific, doable nonetheless through ACPI (IORT on ARM)
static tables data.

> > - for resources
> > dependencies (eg power domains) it deserves some thought, keeping in
> > mind that IOMMUs are static table entries in ACPI and not device objects
> > so they are not even capable of expressing eg power resources and
> > suchlike.
> 
> If you can reword this sentence for me with more context or split it
> into separate sentences, I'd appreciate that very much. I'd help me
> understand this better and allow me to try to help out.

In ACPI (at least on ARM but on x86 I suspect that's the same story with
the DMAR table) an SMMU is presented in FW as an entry in a static
table (eg IORT on ARM). I noticed that your patch series takes into
account for instance eg clock dependencies in DT; this way the OS knows
the clock(s) the SMMU depends on to be activated.

In ACPI there is not a notion of "clock" (hopefully - unless someone
sneaked that in using _DSD properties) but rather every device in the
ACPI namespace (which is part of tables containing code that needs the
ACPI interpreter to be used such as SSDT/DSDT - it is AML code) has ACPI
objects describing power resources (ie ACPI specification 6.3, 7.2).

The SMMU, since it is not itself an ACPI object in the ACPI namespace
but rather an entry in a static ACPI table (IORT on ARM), can't have
PowerResource object in it which means that at the moment there is no
way you can detect a dependency on other power resources to be ON to
build the device links you require to sort out the probe dependencies,
which I *assume* that's the reason why you require to detect
clock dependencies in DT.

Maybe it is not even needed at all but in case it is I was giving
a heads-up to say that clocks (or rather an all encompassing "power
resource" dependency) dependencies in ACPI to build an SMMU as
a module are not straightforward and most certainly will require
firmware specifications updates.

*Hopefully* in the short term all you need to detect is how endpoint
devices are connected to an IOMMU and build device links to describe
that probe dependency, if we need to throw power management into
the picture there is more work to be done.

I hope that's clearer, if it is not please let me know and I will
try to be more precise.

Thanks,
Lorenzo
