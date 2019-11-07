Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D823C5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 09:34:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE3972084C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 09:34:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZNGbeu4q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387499AbfKGJek (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 04:34:40 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:47122 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727278AbfKGJej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 04:34:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=QG0HO8l7AP0o3zer/F4ohD8xuJyug3fKka00FDeAzM0=; b=ZNGbeu4qnZB1J0KjFZ3Uta5jL
        YdCIyJxnDvi75NQZ2GqqFkAaRwrJCfoPJiNz5+OQqAYFrZu+zQCHzskkhvZDE2JZUSEQb/Q+Ct1wF
        5zA2FmfNCHxkDRMv9GgOpTYAeNhJPSGSDjLlZG8FiQLyzo1fulogWDsgAM/r6rpFGfMgUFKrhpHIT
        HGxa8++BbK4QKKUeq1Qo194cOaWGJlyBDuw9e5u+tYyvkvmpi1+XMXL7hGRYQziZDBaSiTWabAAC9
        Z2KxHCEbXiS0I9y4UlyietBfTalAsOOjzrwqHs5iWpM6j9rGKrb8B7ewM/j4CA1b2f2+ruSxtXuFc
        OIifCiKqQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iSeBZ-0001qq-0W; Thu, 07 Nov 2019 09:34:37 +0000
Date:   Thu, 7 Nov 2019 01:34:36 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>, kevin.tian@intel.com,
        ashok.raj@intel.com, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, jacob.jun.pan@intel.com
Subject: Re: [PATCH 1/1] iommu/vt-d: Add Kconfig option to enable/disable
 scalable mode
Message-ID: <20191107093436.GA4342@infradead.org>
References: <20191106051130.485-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191106051130.485-1-baolu.lu@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 06, 2019 at 01:11:30PM +0800, Lu Baolu wrote:
> This adds a Kconfig option INTEL_IOMMU_SCALABLE_MODE_ON to make
> it easier for distributions to enable or disable the Intel IOMMU
> scalable mode during kernel build.



> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/Kconfig       | 10 ++++++++++
>  drivers/iommu/intel-iommu.c |  5 +++++
>  2 files changed, 15 insertions(+)
> 
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index e3842eabcfdd..32f30e27791c 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -242,6 +242,16 @@ config INTEL_IOMMU_FLOPPY_WA
>  	  workaround will setup a 1:1 mapping for the first
>  	  16MiB to make floppy (an ISA device) work.
>  
> +config INTEL_IOMMU_SCALABLE_MODE_ON

That should have a DEFAULT in the name as it is a default.

> +	def_bool n

n is the default default, so this can just be bool.

> +#ifdef CONFIG_INTEL_IOMMU_SCALABLE_MODE_ON
> +int intel_iommu_sm = 1;
> +#else
>  int intel_iommu_sm;
> +#endif /* CONFIG_INTEL_IOMMU_SCALABLE_MODE_ON */

This can use IS_ENABLED().

But then again the distro can just add iommu=sm_on to CONFIG_CMDLINE
and have the same effect, so I don't really get the point of the whole
patch.

Or why we can't just enable it by default for that matter.
