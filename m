Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9E0EC10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 16:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2E9920818
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 16:28:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727643AbfDOQ2M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 12:28:12 -0400
Received: from mga14.intel.com ([192.55.52.115]:17796 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726034AbfDOQ2M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 12:28:12 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Apr 2019 09:28:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,354,1549958400"; 
   d="scan'208";a="140856676"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga008.fm.intel.com with ESMTP; 15 Apr 2019 09:28:10 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1hG4Sn-0005D1-25; Mon, 15 Apr 2019 19:28:09 +0300
Date:   Mon, 15 Apr 2019 19:28:09 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
Cc:     rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org, srinivas.pandruvada@linux.intel.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] thermal: intel: int340x: processor_thermal_device:
 simplify to get driver data
Message-ID: <20190415162809.GU9224@smile.fi.intel.com>
References: <1555339710-28028-1-git-send-email-sumeet.r.pawnikar@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1555339710-28028-1-git-send-email-sumeet.r.pawnikar@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2019 at 08:18:30PM +0530, Sumeet Pawnikar wrote:
> From: "Pawnikar, Sumeet R" <sumeet.r.pawnikar@intel.com>
> 
> This simplifies getting the 'driver_data' from 'struct device' directly.
> Going through platform_device or pci_dev is not required. Also removes
> condition check as the private data stored with dev pointer, means
> irrespective of enumeration mode, we can use dev_get_drvdata().
> This removes the unnecessary step back and forth.
> 

Indeed, good clean up!
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

> Signed-off-by: Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
> ---
>  .../int340x_thermal/processor_thermal_device.c     |   11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)
> 
> diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
> index 8e1cf4d..2a7cbaa 100644
> --- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
> +++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
> @@ -81,22 +81,13 @@ enum proc_thermal_emum_mode_type {
>  					struct device_attribute *attr, \
>  					char *buf) \
>  { \
> -	struct pci_dev *pci_dev; \
> -	struct platform_device *pdev; \
> -	struct proc_thermal_device *proc_dev; \
> +	struct proc_thermal_device *proc_dev = dev_get_drvdata(dev); \
>  	\
>  	if (proc_thermal_emum_mode == PROC_THERMAL_NONE) { \
>  		dev_warn(dev, "Attempted to get power limit before device was initialized!\n"); \
>  		return 0; \
>  	} \
>  	\
> -	if (proc_thermal_emum_mode == PROC_THERMAL_PLATFORM_DEV) { \
> -		pdev = to_platform_device(dev); \
> -		proc_dev = platform_get_drvdata(pdev); \
> -	} else { \
> -		pci_dev = to_pci_dev(dev); \
> -		proc_dev = pci_get_drvdata(pci_dev); \
> -	} \
>  	return sprintf(buf, "%lu\n",\
>  	(unsigned long)proc_dev->power_limits[index].suffix * 1000); \
>  }
> -- 
> 1.7.9.5
> 

-- 
With Best Regards,
Andy Shevchenko


