Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE8E8C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 15:23:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A597920863
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 15:23:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbfCRPXH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 11:23:07 -0400
Received: from mga01.intel.com ([192.55.52.88]:15929 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726757AbfCRPXG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 11:23:06 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Mar 2019 08:23:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,494,1544515200"; 
   d="scan'208";a="308206979"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga005.jf.intel.com with ESMTP; 18 Mar 2019 08:23:03 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1h5u6P-0003Tq-6J; Mon, 18 Mar 2019 17:23:01 +0200
Date:   Mon, 18 Mar 2019 17:23:01 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Rushikesh S Kadam <rushikesh.s.kadam@intel.com>
Cc:     lee.jones@linaro.org, bleung@chromium.org,
        enric.balletbo@collabora.com, groeck@chromium.org,
        linux-kernel@vger.kernel.org, gwendal@google.com,
        jettrink@chromium.org
Subject: Re: [PATCH v3] mfd: cros_ec: instantiate properly CrOS ISH MCU device
Message-ID: <20190318152301.GW9224@smile.fi.intel.com>
References: <1551428454-596-1-git-send-email-rushikesh.s.kadam@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1551428454-596-1-git-send-email-rushikesh.s.kadam@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 01, 2019 at 01:50:54PM +0530, Rushikesh S Kadam wrote:
> Integrated Sensor Hub (ISH) is also a MCU running EC
> having feature bit EC_FEATURE_ISH. Instantiate it as
> a special CrOS EC device with device name 'cros_ish'.

FWIW,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

> 
> Signed-off-by: Rushikesh S Kadam <rushikesh.s.kadam@intel.com>
> ---
> v3
> - Dropped "Intel" in commments in cros_ec header file. CrOS EC ISH
>   device is a generic ISH. This was missed earlier. 
> v2
> - Addressed review comments to term the CrOS EC device as a generic
>   Integrated Sensor Hub. 
> v1
> - Initial version.
> 
>  drivers/mfd/cros_ec_dev.c            | 13 +++++++++++++
>  include/linux/mfd/cros_ec.h          |  1 +
>  include/linux/mfd/cros_ec_commands.h |  2 ++
>  3 files changed, 16 insertions(+)
> 
> diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
> index 2d0fee4..46963c2 100644
> --- a/drivers/mfd/cros_ec_dev.c
> +++ b/drivers/mfd/cros_ec_dev.c
> @@ -415,6 +415,19 @@ static int ec_device_probe(struct platform_device *pdev)
>  	cdev_init(&ec->cdev, &fops);
>  
>  	/*
> +	 * Check whether this is actually an Integrated Sensor Hub (ISH)
> +	 * rather than an EC.
> +	 */
> +	if (cros_ec_check_features(ec, EC_FEATURE_ISH)) {
> +		dev_info(dev, "CrOS ISH MCU detected.\n");
> +		/*
> +		 * Help userspace differentiating ECs from ISH MCU,
> +		 * regardless of the probing order.
> +		 */
> +		ec_platform->ec_name = CROS_EC_DEV_ISH_NAME;
> +	}
> +
> +	/*
>  	 * Add the class device
>  	 * Link to the character device for creating the /dev entry
>  	 * in devtmpfs.
> diff --git a/include/linux/mfd/cros_ec.h b/include/linux/mfd/cros_ec.h
> index de8b588..00c5765 100644
> --- a/include/linux/mfd/cros_ec.h
> +++ b/include/linux/mfd/cros_ec.h
> @@ -24,6 +24,7 @@
>  
>  #define CROS_EC_DEV_NAME "cros_ec"
>  #define CROS_EC_DEV_PD_NAME "cros_pd"
> +#define CROS_EC_DEV_ISH_NAME "cros_ish"
>  
>  /*
>   * The EC is unresponsive for a time after a reboot command.  Add a
> diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
> index fc91082..43bee4f 100644
> --- a/include/linux/mfd/cros_ec_commands.h
> +++ b/include/linux/mfd/cros_ec_commands.h
> @@ -856,6 +856,8 @@ enum ec_feature_code {
>  	EC_FEATURE_RTC = 27,
>  	/* EC supports CEC commands */
>  	EC_FEATURE_CEC = 35,
> +	/* The MCU is an Integrated Sensor Hub */
> +	EC_FEATURE_ISH = 40,
>  };
>  
>  #define EC_FEATURE_MASK_0(event_code) (1UL << (event_code % 32))
> -- 
> 1.9.1
> 

-- 
With Best Regards,
Andy Shevchenko


