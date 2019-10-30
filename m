Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21012CA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 16:00:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5E4420679
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 16:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572451259;
	bh=IlRkfmxagkpK4XTHGe5bLRKa65DPVjT3hWJACHX0Xno=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=s1m5rdi4ADR8tAa2MFlTENPmaU5l6CKgGDDMt2+fpcZvj+o2O2tNMzbD2uTG2kRdo
	 YgjSJ0fruN9Na2/BYovLtiw2qfaMcoAw0dx0hiBqnRiIbw/rVP2DAW+e/UdGJr56aj
	 jnHDpfrYGc50oiwoyyskeRa4Y8/pixzYIFrcdTlM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728704AbfJ3QA5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 12:00:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:56372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728454AbfJ3Pyu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 11:54:50 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 839C0217D9;
        Wed, 30 Oct 2019 15:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572450889;
        bh=IlRkfmxagkpK4XTHGe5bLRKa65DPVjT3hWJACHX0Xno=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SrWB7Mk879bug3XRPDe3MAwhVgzgOcAAesPz2M8kHTWoLEToJxvpV1alV7Y2QuXdN
         ICdfTmCW1N9UyKURUBhdK22PqAZIywFSU/GQMYZNTG/nTOOh1v2tYbnpqX5A2dqOW6
         b02Q73I/Qd3cR0ywJqoCSkvGcEC4u1XbxHj/1Ci0=
Date:   Wed, 30 Oct 2019 15:54:45 +0000
From:   Will Deacon <will@kernel.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        saravanak@google.com
Subject: Re: [PATCH 0/7] iommu: Permit modular builds of ARM SMMU[v3] drivers
Message-ID: <20191030155444.GC19096@willie-the-truck>
References: <20191030145112.19738-1-will@kernel.org>
 <6e457227-ca06-2998-4ffa-a58ab171ce32@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e457227-ca06-2998-4ffa-a58ab171ce32@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

On Wed, Oct 30, 2019 at 03:35:55PM +0000, Robin Murphy wrote:
> On 30/10/2019 14:51, Will Deacon wrote:
> > As part of the work to enable a "Generic Kernel Image" across multiple
> > Android devices, there is a need to seperate shared, core kernel code
> > from modular driver code that may not be needed by all SoCs. This means
> > building IOMMU drivers as modules.
> > 
> > It turns out that most of the groundwork has already been done to enable
> > the ARM SMMU drivers to be 'tristate' options in drivers/iommu/Kconfig;
> > with a few symbols exported from the IOMMU/PCI core, everything builds
> > nicely out of the box. The one exception is support for the legacy SMMU
> > DT binding, which is not in widespread use and has never worked with
> > modules, so we can simply remove that when building as a module rather
> > than try to paper over it with even more hacks.
> > 
> > Obviously you need to be careful about using IOMMU drivers as modules,
> > since late loading of the driver for an IOMMU serving active DMA masters
> > is going to end badly in many cases. On Android, we're using device links
> > to ensure that the IOMMU probes first.
> 
> Out of curiosity, which device links are those? Clearly not the RPM links
> created by the IOMMU drivers themselves... Is this some special Android
> magic, or is there actually a chance of replacing all the
> of_iommu_configure() machinery with something more generic?

I'll admit that I haven't used them personally yet, but I'm referring to
this series from Saravana [CC'd]:

https://lore.kernel.org/linux-acpi/20190904211126.47518-1-saravanak@google.com/

which is currently sitting in linux-next now that we're upstreaming the
"special Android magic" ;)

Will
