Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3CC8C10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 17:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFD1020818
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 17:56:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbfDLR4T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 13:56:19 -0400
Received: from mga09.intel.com ([134.134.136.24]:12904 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726808AbfDLR4T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 13:56:19 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Apr 2019 10:56:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,342,1549958400"; 
   d="scan'208";a="140078868"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga008.fm.intel.com with ESMTP; 12 Apr 2019 10:56:16 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hF0PP-0001gP-HO; Fri, 12 Apr 2019 20:56:15 +0300
Date:   Fri, 12 Apr 2019 20:56:15 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Yue Haibing <yuehaibing@huawei.com>
Cc:     linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v3] gpio: merrifield: Fix build err without CONFIG_ACPI
Message-ID: <20190412175615.GB9224@smile.fi.intel.com>
References: <20190405142112.26592-1-yuehaibing@huawei.com>
 <20190412151911.12084-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190412151911.12084-1-yuehaibing@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 12, 2019 at 11:19:11PM +0800, Yue Haibing wrote:
> From: YueHaibing <yuehaibing@huawei.com>
> 
> When building CONFIG_ACPI is not set
> gcc warn this:
> 
> drivers/gpio/gpio-merrifield.c: In function mrfld_gpio_get_pinctrl_dev_name:
> drivers/gpio/gpio-merrifield.c:388:19: error: dereferencing pointer to incomplete type struct acpi_device
>    put_device(&adev->dev);
>                    ^~
> 

Thank you.
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes:d00d2109c367 ("gpio: merrifield: Convert to use acpi_dev_get_first_match_dev()")
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
> v3: move helper to acpi_bus.h, and change name to acpi_dev_put
> ---
>  drivers/gpio/gpio-merrifield.c | 2 +-
>  include/acpi/acpi_bus.h        | 4 ++++
>  include/linux/acpi.h           | 2 ++
>  3 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpio/gpio-merrifield.c b/drivers/gpio/gpio-merrifield.c
> index 2383dc7..3302125 100644
> --- a/drivers/gpio/gpio-merrifield.c
> +++ b/drivers/gpio/gpio-merrifield.c
> @@ -385,7 +385,7 @@ static const char *mrfld_gpio_get_pinctrl_dev_name(struct mrfld_gpio *priv)
>  	adev = acpi_dev_get_first_match_dev("INTC1002", NULL, -1);
>  	if (adev) {
>  		name = devm_kstrdup(priv->dev, acpi_dev_name(adev), GFP_KERNEL);
> -		put_device(&adev->dev);
> +		acpi_dev_put(adev);
>  	} else {
>  		name = "pinctrl-merrifield";
>  	}
> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> index f798175..2a462cf 100644
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -687,6 +687,10 @@ static inline bool acpi_device_can_poweroff(struct acpi_device *adev)
>  		adev->power.states[ACPI_STATE_D3_HOT].flags.explicit_set);
>  }
>  
> +static inline void acpi_dev_put(struct acpi_device *adev)
> +{
> +	put_device(&adev->dev);
> +}
>  #else	/* CONFIG_ACPI */
>  
>  static inline int register_acpi_bus_type(void *bus) { return 0; }
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index a1bd789..e22c237 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -679,6 +679,8 @@ acpi_dev_get_first_match_dev(const char *hid, const char *uid, s64 hrv)
>  	return NULL;
>  }
>  
> +static inline void acpi_dev_put(struct acpi_device *adev) {}
> +
>  static inline bool is_acpi_node(struct fwnode_handle *fwnode)
>  {
>  	return false;
> -- 
> 2.7.4
> 
> 

-- 
With Best Regards,
Andy Shevchenko


