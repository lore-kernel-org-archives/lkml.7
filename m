Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 607E6C5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 12:48:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21EBF2187F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 12:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573130907;
	bh=CsU4m13XWIFTtMoZN2G9/jcV1LU2ZEOp3TgoYZ0+WzU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NxATBw3/ObVSdxAvo8+fIVHqwXy4qH375N2lfHan1hQ+bmAE8sgsCKqxCM3l33O98
	 xqbFOKrjzTd9euM1wFGiwVH6NC4fCuv+TI2DtuG+gpOziwakowpynITl6C4zrR386x
	 nJwZlIl5xrietusakK48a3mkvHtP4RGmLcS7itfg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388818AbfKGMs0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 07:48:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:36792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733250AbfKGMsZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 07:48:25 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A82DC2178F;
        Thu,  7 Nov 2019 12:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573130904;
        bh=CsU4m13XWIFTtMoZN2G9/jcV1LU2ZEOp3TgoYZ0+WzU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2qZGpLRXalDMWfpBsoJCG+ufQ92m+LvQFtbiJ6TuH2j14oih7aZJ8jywjEiUYAgRr
         /c1kyoPCYrcbTNxVzBIHStyoLx4kFLxPtq4VKYtZffR5XFIxkoi5l2LuL0IMTu8dXp
         60xkzXzfG5dR62xaF/b8UWJxhMcnV27q54cHlA5Y=
Date:   Thu, 7 Nov 2019 12:48:20 +0000
From:   Will Deacon <will@kernel.org>
To:     "Isaac J. Manjarres" <isaacm@codeaurora.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 7/7] iommu/arm-smmu: Allow building as a module
Message-ID: <20191107124819.GB12385@willie-the-truck>
References: <20191030145112.19738-1-will@kernel.org>
 <20191030145112.19738-8-will@kernel.org>
 <20191104193400.GA24983@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191104193400.GA24983@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Isaac,

On Mon, Nov 04, 2019 at 11:34:00AM -0800, Isaac J. Manjarres wrote:
> On Wed, Oct 30, 2019 at 02:51:12PM +0000, Will Deacon wrote:
> > diff --git a/drivers/iommu/arm-smmu-impl.c b/drivers/iommu/arm-smmu-impl.c
> > index 5c87a38620c4..2f82d40317d6 100644
> > --- a/drivers/iommu/arm-smmu-impl.c
> > +++ b/drivers/iommu/arm-smmu-impl.c
> > @@ -5,6 +5,7 @@
> >  #define pr_fmt(fmt) "arm-smmu: " fmt
> >  
> >  #include <linux/bitfield.h>
> > +#include <linux/module.h>
> >  #include <linux/of.h>
> >  
> >  #include "arm-smmu.h"
> > @@ -172,3 +173,8 @@ struct arm_smmu_device *arm_smmu_impl_init(struct arm_smmu_device *smmu)
> >  
> >  	return smmu;
> >  }
> > +EXPORT_SYMBOL_GPL(arm_smmu_impl_init);
> > +
> > +MODULE_DESCRIPTION("IOMMU quirks for ARM architected SMMU implementations");
> > +MODULE_AUTHOR("Robin Murphy <robin.murphy@arm.com>");
> > +MODULE_LICENSE("GPL v2");
> 
> A minor comment: I was curious about why arm-smmu.c and arm-smmu-impl.c
> were being compiled as two separate modules, as opposed to combining
> them into one module? The latter approach seemed more appropriate, given
> that arm-smmu-impl doesn't offer much as a module on its own. Thoughts?

Yes, you're right. The simple answer is that I couldn't come up with a good
name for the combined module, since "arm-smmu" is already taken by the core
part of the driver and I don't want to rename that file. Looking at what a
few other drivers do, it seems that "arm-smmu-mod" might be the best bet
so I'll incorporate that change for v2 and put you on cc.

Thanks!

Will
