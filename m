Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96FF4C48BE7
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 11:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C30D214AF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 11:46:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbfGILqv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 07:46:51 -0400
Received: from mga11.intel.com ([192.55.52.93]:56384 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726060AbfGILqu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 07:46:50 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jul 2019 04:46:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,470,1557212400"; 
   d="scan'208";a="165742050"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.145])
  by fmsmga008.fm.intel.com with ESMTP; 09 Jul 2019 04:46:49 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hkoa8-0002Zo-02; Tue, 09 Jul 2019 14:46:48 +0300
Date:   Tue, 9 Jul 2019 14:46:47 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     lee.jones@linaro.org, jarkko.nikula@linux.intel.com,
        mika.westerberg@linux.intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: intel-lpss: Remove D3cold delay
Message-ID: <20190709114647.GX9224@smile.fi.intel.com>
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

Thank you for the patch. I took it to our internal testing and will tell
the result within couple of weeks.

> 
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


