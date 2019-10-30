Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF243CA9EC7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 15:26:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0ECD2087F
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 15:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572449172;
	bh=XcPD3xE6chl5TShbhycG8IYFjMN9avqjqETDunPqgSQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YSdoQ7eXdhqvg/nKb0HQ87KlsZXGbffQBWKgvMVEw1TJ3VueCiyF2u8oyUZUeISJz
	 DDG9hoVbvo41NninBt9mhEv4vbxKmg8JMjR7s6Uzg1KnyZToobqwnvAr607wGBXux4
	 OGEP+v7aIE/14+vucn+0o+MfrAZFt/4IWJw82Bvk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbfJ3P0L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 11:26:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:40056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726246AbfJ3P0L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 11:26:11 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A5DF20679;
        Wed, 30 Oct 2019 15:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572449170;
        bh=XcPD3xE6chl5TShbhycG8IYFjMN9avqjqETDunPqgSQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CP0+bW9f19MhlLE1t+Pl7Gx9d90rr4NBUDe7X4lm9LMte0Y0INnpMPk8Z0v3ZkRNV
         8p1W9ZGNVsxaKqb/e/k+UX8N9LZ0sfmrpYsApOMyse1zMqPf3XamTW3i+c2hDFh0u8
         jlNrZEjE+w9V8ob44EM8Gat4/AgH5RtY4kGRnHO4=
Date:   Wed, 30 Oct 2019 15:26:05 +0000
From:   Will Deacon <will@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH 7/7] iommu/arm-smmu: Allow building as a module
Message-ID: <20191030152605.GA19096@willie-the-truck>
References: <20191030145112.19738-1-will@kernel.org>
 <20191030145112.19738-8-will@kernel.org>
 <20191030152212.ifzhl2w3knapc367@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191030152212.ifzhl2w3knapc367@bogus>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Wed, Oct 30, 2019 at 10:22:12AM -0500, Rob Herring wrote:
> On Wed, Oct 30, 2019 at 02:51:12PM +0000, Will Deacon wrote:
> > By conditionally dropping support for the legacy binding and exporting
> > the newly introduced 'arm_smmu_impl_init()' function we can allow the
> > ARM SMMU driver to be built as a module.
> > 
> > Signed-off-by: Will Deacon <will@kernel.org>
> > ---
> >  drivers/iommu/Kconfig         | 14 ++++++++-
> >  drivers/iommu/arm-smmu-impl.c |  6 ++++
> >  drivers/iommu/arm-smmu.c      | 54 +++++++++++++++++++++--------------
> >  3 files changed, 51 insertions(+), 23 deletions(-)
> > 
> > diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> > index 7583d47fc4d5..02703f51e533 100644
> > --- a/drivers/iommu/Kconfig
> > +++ b/drivers/iommu/Kconfig
> > @@ -350,7 +350,7 @@ config SPAPR_TCE_IOMMU
> >  
> >  # ARM IOMMU support
> >  config ARM_SMMU
> > -	bool "ARM Ltd. System MMU (SMMU) Support"
> > +	tristate "ARM Ltd. System MMU (SMMU) Support"
> >  	depends on (ARM64 || ARM) && MMU
> >  	select IOMMU_API
> >  	select IOMMU_IO_PGTABLE_LPAE
> > @@ -362,6 +362,18 @@ config ARM_SMMU
> >  	  Say Y here if your SoC includes an IOMMU device implementing
> >  	  the ARM SMMU architecture.
> >  
> > +config ARM_SMMU_LEGACY_DT_BINDINGS
> > +	bool "Support the legacy \"mmu-masters\" devicetree bindings"
> 
> Can't we just remove this now? The only user is Seattle. Is anyone still 
> using Seattle AND DT? There's been no real dts change since Feb '16.
> There's a bit of clean-up needed in the Seattle dts files, so I'd like 
> to remove them if there's not users.
> 
> If there are users, can't we just make them move to the new binding? 
> Yes compatibility, but that really depends on the users caring.
> 
> I though Calxeda was using this too, but I guess we didn't get that 
> finished. We should probably remove that secure mode flag as well.

There was a recent mail from somebody using TX1 with this binding, although
it didn't actually appear to be working (but I'm not sure how much of that
is the bindings fault):

http://lists.infradead.org/pipermail/linux-arm-kernel/2019-October/683992.html

However, I agree with you, which is why the new Kconfig option actually
disables the legacy bindings by default in the hope that we can remove it
in a few releases time, with an easy "get things sorta working" option in
the meantime.

Will
