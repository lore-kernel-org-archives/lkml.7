Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81526C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 09:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 561B420851
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 09:50:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733236AbfCAJuo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 04:50:44 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:57174 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727915AbfCAJuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 04:50:44 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id AF0FB260C28
Subject: Re: [PATCH v3] mfd: cros_ec: instantiate properly CrOS ISH MCU device
To:     Rushikesh S Kadam <rushikesh.s.kadam@intel.com>,
        lee.jones@linaro.org, bleung@chromium.org, groeck@chromium.org
Cc:     linux-kernel@vger.kernel.org, gwendal@google.com,
        jettrink@chromium.org, andriy.shevchenko@intel.com
References: <1551428454-596-1-git-send-email-rushikesh.s.kadam@intel.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <18369e10-4611-2237-d58c-e6526dc74544@collabora.com>
Date:   Fri, 1 Mar 2019 10:50:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1551428454-596-1-git-send-email-rushikesh.s.kadam@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rushikesh,

On 1/3/19 9:20, Rushikesh S Kadam wrote:
> Integrated Sensor Hub (ISH) is also a MCU running EC
> having feature bit EC_FEATURE_ISH. Instantiate it as
> a special CrOS EC device with device name 'cros_ish'.
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
> 

Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

