Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F8C9CA9ECB
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 15:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D537B2086D
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 15:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572536577;
	bh=GRreUt5vILq8iwJLnTWSsnpWtfLL+f+wCy2zYdNxf6o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Q1aJKquVchuU9hc9d3fwceUAdP9OcWQ9DkzfSC9eYy58MMPBn0tis2xkBnzzpbWo5
	 sZE8tpneleer19tR3a1+3n8ylc/WhDNZyuY+v38ZnH7IMI/rQb7PGcGE7bgn0vMMTm
	 lO452WZpTl6tT2OEnfsIfh6k3S0DRHuYtEw+kICc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728446AbfJaPm4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 11:42:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:50140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727579AbfJaPmw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 11:42:52 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DECD82086D;
        Thu, 31 Oct 2019 15:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572536572;
        bh=GRreUt5vILq8iwJLnTWSsnpWtfLL+f+wCy2zYdNxf6o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qaAJ8XcWGfT4LUOvU811aRsvOWAxezJATr7Uk9nzN23oXUvKxtHZVcY0AqzVTOyjZ
         Epk2/3n2IWDhuOaWcOoDQDWApaqgYgldCxMrpckQEgKjPXnL2Tv96+pJVdwc1WPwcm
         ftKHIyiFmV9Fi/cSBRpiXvhFrSLJm+8Fm2Mkj3Fg=
Date:   Thu, 31 Oct 2019 15:42:47 +0000
From:   Will Deacon <will@kernel.org>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Robin Murphy <robin.murphy@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH 5/7] iommu/arm-smmu-v3: Allow building as a module
Message-ID: <20191031154247.GB28061@willie-the-truck>
References: <20191030145112.19738-1-will@kernel.org>
 <20191030145112.19738-6-will@kernel.org>
 <20191030193148.GA8432@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191030193148.GA8432@8bytes.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joerg,

On Wed, Oct 30, 2019 at 08:31:48PM +0100, Joerg Roedel wrote:
> On Wed, Oct 30, 2019 at 02:51:10PM +0000, Will Deacon wrote:
> > By removing the redundant call to 'pci_request_acs()' we can allow the
> > ARM SMMUv3 driver to be built as a module.
> > 
> > Signed-off-by: Will Deacon <will@kernel.org>
> > ---
> >  drivers/iommu/Kconfig       | 2 +-
> >  drivers/iommu/arm-smmu-v3.c | 1 -
> >  2 files changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> > index e3842eabcfdd..7583d47fc4d5 100644
> > --- a/drivers/iommu/Kconfig
> > +++ b/drivers/iommu/Kconfig
> > @@ -388,7 +388,7 @@ config ARM_SMMU_DISABLE_BYPASS_BY_DEFAULT
> >  	  config.
> >  
> >  config ARM_SMMU_V3
> > -	bool "ARM Ltd. System MMU Version 3 (SMMUv3) Support"
> > +	tristate "ARM Ltd. System MMU Version 3 (SMMUv3) Support"
> >  	depends on ARM64
> >  	select IOMMU_API
> >  	select IOMMU_IO_PGTABLE_LPAEa
> 
> Sorry for the stupid question, but what prevents the iommu module from
> being unloaded when there are active users? There are no symbol
> dependencies to endpoint device drivers, because the interface is only
> exposed through the iommu-api, right? Is some sort of manual module
> reference counting needed?

Generally, I think unloading the IOMMU driver module while there are
active users is a pretty bad idea, much like unbinding the driver via
/sys in the same situation would also be fairly daft. However, I *think*
the code in __device_release_driver() tries to deal with this by
iterating over the active consumers and ->remove()ing them first.

I'm without hardware access at the moment, so I haven't been able to
test this myself. We could nobble the module_exit() hook, but there's
still the "force unload" option depending on the .config.

Will
