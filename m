Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACB14C35280
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 11:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88CAA21855
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 11:05:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730948AbfI3LF0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 07:05:26 -0400
Received: from mga03.intel.com ([134.134.136.65]:12730 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730345AbfI3LF0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 07:05:26 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Sep 2019 04:05:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,567,1559545200"; 
   d="scan'208";a="215669119"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga004.fm.intel.com with ESMTP; 30 Sep 2019 04:05:23 -0700
Received: from andy by smile with local (Exim 4.92.1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1iEtUY-0000Ry-4j; Mon, 30 Sep 2019 14:05:22 +0300
Date:   Mon, 30 Sep 2019 14:05:22 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Tuowen Zhao <ztuowen@gmail.com>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc:     lee.jones@linaro.org, linux-kernel@vger.kernel.org,
        mika.westerberg@linux.intel.com, acelan.kao@canonical.com,
        bhelgaas@google.com, kai.heng.feng@canonical.com
Subject: Re: [PATCH] mfd: intel-lpss: use devm_ioremap_uc for mmio
Message-ID: <20190930110522.GT32742@smile.fi.intel.com>
References: <20190927175513.31054-1-ztuowen@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190927175513.31054-1-ztuowen@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 27, 2019 at 11:55:13AM -0600, Tuowen Zhao wrote:
> Write-combining BAR for intel-lpss-pci in MTRR causes system hangs
> during boot.
> 
> This patch adds devm_ioremap_uc as a new managed wrapper to ioremap_uc
> and with it forces the use of strongly uncachable mmio in intel-lpss.
> 
> This bahavior is seen on Dell XPS 13 7390 2-in-1:
> 
> [    0.001734]   5 base 4000000000 mask 6000000000 write-combining
> 
> 4000000000-7fffffffff : PCI Bus 0000:00
>   4000000000-400fffffff : 0000:00:02.0 (i915)
>   4010000000-4010000fff : 0000:00:15.0 (intel-lpss-pci)

+Cc: Luis as author of UC flavour of ioremap.

Luis, some BIOSes in the wild have wrong MTRR setting for PCI resource window
and thus when Linux tries to allocate 64-bit MMIO address space (and in
opposite to Windows, which does this from the end of available space towards
beginning, Linux do this from the beginning towards end). Ideally we have to
push vendors to fix firmware.

This patch AFAIU overrides MTTR/PAT settings for those pages and makes it
possible to workaround firmware bug.

What do you think is the best approach here?

> Link: https://bugzilla.kernel.org/show_bug.cgi?id=203485
> Signed-off-by: Tuowen Zhao <ztuowen@gmail.com>
> ---
>  drivers/mfd/intel-lpss.c |  2 +-
>  include/linux/io.h       |  2 ++
>  lib/devres.c             | 19 +++++++++++++++++++
>  3 files changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mfd/intel-lpss.c b/drivers/mfd/intel-lpss.c
> index 277f48f1cc1c..06106c9320bb 100644
> --- a/drivers/mfd/intel-lpss.c
> +++ b/drivers/mfd/intel-lpss.c
> @@ -395,7 +395,7 @@ int intel_lpss_probe(struct device *dev,
>  	if (!lpss)
>  		return -ENOMEM;
>  
> -	lpss->priv = devm_ioremap(dev, info->mem->start + LPSS_PRIV_OFFSET,
> +	lpss->priv = devm_ioremap_uc(dev, info->mem->start + LPSS_PRIV_OFFSET,
>  				  LPSS_PRIV_SIZE);
>  	if (!lpss->priv)
>  		return -ENOMEM;
> diff --git a/include/linux/io.h b/include/linux/io.h
> index accac822336a..a59834bc0a11 100644
> --- a/include/linux/io.h
> +++ b/include/linux/io.h
> @@ -64,6 +64,8 @@ static inline void devm_ioport_unmap(struct device *dev, void __iomem *addr)
>  
>  void __iomem *devm_ioremap(struct device *dev, resource_size_t offset,
>  			   resource_size_t size);
> +void __iomem *devm_ioremap_uc(struct device *dev, resource_size_t offset,
> +				   resource_size_t size);
>  void __iomem *devm_ioremap_nocache(struct device *dev, resource_size_t offset,
>  				   resource_size_t size);
>  void __iomem *devm_ioremap_wc(struct device *dev, resource_size_t offset,
> diff --git a/lib/devres.c b/lib/devres.c
> index 6a0e9bd6524a..beb0a064b891 100644
> --- a/lib/devres.c
> +++ b/lib/devres.c
> @@ -9,6 +9,7 @@
>  enum devm_ioremap_type {
>  	DEVM_IOREMAP = 0,
>  	DEVM_IOREMAP_NC,
> +	DEVM_IOREMAP_UC,
>  	DEVM_IOREMAP_WC,
>  };
>  
> @@ -39,6 +40,9 @@ static void __iomem *__devm_ioremap(struct device *dev, resource_size_t offset,
>  	case DEVM_IOREMAP_NC:
>  		addr = ioremap_nocache(offset, size);
>  		break;
> +	case DEVM_IOREMAP_UC:
> +		addr = ioremap_uc(offset, size);
> +		break;
>  	case DEVM_IOREMAP_WC:
>  		addr = ioremap_wc(offset, size);
>  		break;
> @@ -68,6 +72,21 @@ void __iomem *devm_ioremap(struct device *dev, resource_size_t offset,
>  }
>  EXPORT_SYMBOL(devm_ioremap);
>  
> +/**
> + * devm_ioremap_uc - Managed ioremap_uc()
> + * @dev: Generic device to remap IO address for
> + * @offset: Resource address to map
> + * @size: Size of map
> + *
> + * Managed ioremap_uc().  Map is automatically unmapped on driver detach.
> + */
> +void __iomem *devm_ioremap_uc(struct device *dev, resource_size_t offset,
> +			      resource_size_t size)
> +{
> +	return __devm_ioremap(dev, offset, size, DEVM_IOREMAP_UC);
> +}
> +EXPORT_SYMBOL(devm_ioremap_uc);
> +
>  /**
>   * devm_ioremap_nocache - Managed ioremap_nocache()
>   * @dev: Generic device to remap IO address for
> -- 
> 2.23.0
> 

-- 
With Best Regards,
Andy Shevchenko


