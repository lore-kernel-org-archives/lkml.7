Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96009C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 13:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 713412238C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 13:43:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390182AbfGYNnV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 09:43:21 -0400
Received: from mga01.intel.com ([192.55.52.88]:39768 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390141AbfGYNnU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 09:43:20 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jul 2019 06:43:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,306,1559545200"; 
   d="scan'208";a="193809262"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.145])
  by fmsmga004.fm.intel.com with ESMTP; 25 Jul 2019 06:43:19 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hqe1d-0004Y2-NO; Thu, 25 Jul 2019 16:43:17 +0300
Date:   Thu, 25 Jul 2019 16:43:17 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     lee.jones@linaro.org, jarkko.nikula@linux.intel.com,
        mika.westerberg@linux.intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: intel-lpss: Remove D3cold delay
Message-ID: <20190725134317.GD9224@smile.fi.intel.com>
References: <20190705045503.13379-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190705045503.13379-1-kai.heng.feng@canonical.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 05, 2019 at 12:55:03PM +0800, Kai-Heng Feng wrote:
> Goodix touchpad may drop its first couple input events when
> i2c-designware-platdrv and intel-lpss it connects to took too long to
> runtime resume from runtime suspended state.
> 
> This issue happens becuase the touchpad has a rather small buffer to
> store up to 13 input events, so if the host doesn't read those events in
> time (i.e. runtime resume takes too long), events are dropped from the
> touchpad's buffer.
> 
> The bottleneck is D3cold delay it waits when transitioning from D3cold
> to D0, hence remove the delay to make the resume faster. I've tested
> some systems with intel-lpss and haven't seen any regression.
> 

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=202683
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>  drivers/mfd/intel-lpss-pci.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/mfd/intel-lpss-pci.c b/drivers/mfd/intel-lpss-pci.c
> index aed2c0447966..3c271b14e7c6 100644
> --- a/drivers/mfd/intel-lpss-pci.c
> +++ b/drivers/mfd/intel-lpss-pci.c
> @@ -35,6 +35,8 @@ static int intel_lpss_pci_probe(struct pci_dev *pdev,
>  	info->mem = &pdev->resource[0];
>  	info->irq = pdev->irq;
>  
> +	pdev->d3cold_delay = 0;
> +
>  	/* Probably it is enough to set this for iDMA capable devices only */
>  	pci_set_master(pdev);
>  	pci_try_set_mwi(pdev);
> -- 
> 2.17.1
> 

-- 
With Best Regards,
Andy Shevchenko


