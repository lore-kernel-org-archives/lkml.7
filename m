Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C810CA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 15:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E65820679
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 15:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572448936;
	bh=FrgPUpJt9DSttRGiTsP8U1+/ZhfzRV/kofLgO/IQuVw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=C5yIlcJ97RCqGE/+sZcw2I/zr9zVydR9l4aVMeczb6kvqW53sumq08uv1Xpp99IlI
	 M8UXAEXChqAs3zQQqSjwivkW4Ae1ll+WO2NeEdet25XlEJHWyOrp00S9r/r2KCrP63
	 8O/pQLHxSDaMGUXnlKuenA3Vjp86pW3nSbY0Hm9Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbfJ3PWP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 11:22:15 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:43495 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbfJ3PWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 11:22:15 -0400
Received: by mail-oi1-f195.google.com with SMTP id s5so2275145oie.10
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 08:22:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ks/aDXETKL7/ewjtlGzGE6lh24DrchMHRBDEy0Btj3E=;
        b=MEBcvyV4k0zHNPrHcCfBZVu8dffcZ5lyV7v9TliFMtYbGNjLg9OQiZsBmMyVjUAhLt
         IkuUjQ8WHHz7JCTENZBwUrIpYpyDJbc14NPaC0STFtdO5spgUtQYJHXD2X6VMaLE13rJ
         O13vLjCU3XLXfoRP241gRYO2qi90z8PqnLphebtZboHo6NNwUpvDpN8X3wpEQA6CczDD
         b+C0oC3ZKuAlPP8o7Qv9JcgRmrDg/0jhrCh5iq0DAJziDwn3e3G+Ru+vJqa+9v4Plh07
         HEOipSRwwguryf9Q4wlsG6BzMg7c0/W7FTKs5+JXLwVODcU4lTJyjbSfQed5uAmaz2BB
         /+3g==
X-Gm-Message-State: APjAAAWafK4ONMPfKYTxDmilQ0R18gQgdtWhD0VvJIssj/6C9OCQdY2y
        mye5qu4LLX7P32BmrNEGH1xaioKGLw==
X-Google-Smtp-Source: APXvYqx6Kj/zkuW+wIRPdRkZqOqV/N47QSWRwvNNo72T68bbg7gUodLDkXU4GW9fmyM9615s+4cAgw==
X-Received: by 2002:aca:904:: with SMTP id 4mr9507441oij.25.1572448933984;
        Wed, 30 Oct 2019 08:22:13 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m50sm115746otc.80.2019.10.30.08.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2019 08:22:13 -0700 (PDT)
Date:   Wed, 30 Oct 2019 10:22:12 -0500
From:   Rob Herring <robh@kernel.org>
To:     Will Deacon <will@kernel.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH 7/7] iommu/arm-smmu: Allow building as a module
Message-ID: <20191030152212.ifzhl2w3knapc367@bogus>
References: <20191030145112.19738-1-will@kernel.org>
 <20191030145112.19738-8-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191030145112.19738-8-will@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 30, 2019 at 02:51:12PM +0000, Will Deacon wrote:
> By conditionally dropping support for the legacy binding and exporting
> the newly introduced 'arm_smmu_impl_init()' function we can allow the
> ARM SMMU driver to be built as a module.
> 
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>  drivers/iommu/Kconfig         | 14 ++++++++-
>  drivers/iommu/arm-smmu-impl.c |  6 ++++
>  drivers/iommu/arm-smmu.c      | 54 +++++++++++++++++++++--------------
>  3 files changed, 51 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index 7583d47fc4d5..02703f51e533 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -350,7 +350,7 @@ config SPAPR_TCE_IOMMU
>  
>  # ARM IOMMU support
>  config ARM_SMMU
> -	bool "ARM Ltd. System MMU (SMMU) Support"
> +	tristate "ARM Ltd. System MMU (SMMU) Support"
>  	depends on (ARM64 || ARM) && MMU
>  	select IOMMU_API
>  	select IOMMU_IO_PGTABLE_LPAE
> @@ -362,6 +362,18 @@ config ARM_SMMU
>  	  Say Y here if your SoC includes an IOMMU device implementing
>  	  the ARM SMMU architecture.
>  
> +config ARM_SMMU_LEGACY_DT_BINDINGS
> +	bool "Support the legacy \"mmu-masters\" devicetree bindings"

Can't we just remove this now? The only user is Seattle. Is anyone still 
using Seattle AND DT? There's been no real dts change since Feb '16.
There's a bit of clean-up needed in the Seattle dts files, so I'd like 
to remove them if there's not users.

If there are users, can't we just make them move to the new binding? 
Yes compatibility, but that really depends on the users caring.

I though Calxeda was using this too, but I guess we didn't get that 
finished. We should probably remove that secure mode flag as well.

Rob
