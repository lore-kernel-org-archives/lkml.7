Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 705A3C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 11:44:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CDD920657
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 11:44:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729254AbfDDLoN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 07:44:13 -0400
Received: from mga01.intel.com ([192.55.52.88]:38992 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726618AbfDDLoN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 07:44:13 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Apr 2019 04:44:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,308,1549958400"; 
   d="scan'208";a="333733590"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga006.fm.intel.com with ESMTP; 04 Apr 2019 04:44:10 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hC0mw-0004s7-5w; Thu, 04 Apr 2019 14:44:10 +0300
Date:   Thu, 4 Apr 2019 14:44:10 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Yue Haibing <yuehaibing@huawei.com>
Cc:     linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH] gpio: merrifield: Fix build err without CONFIG_ACPI
Message-ID: <20190404114410.GQ9224@smile.fi.intel.com>
References: <20190404103925.25652-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190404103925.25652-1-yuehaibing@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 04, 2019 at 06:39:25PM +0800, Yue Haibing wrote:
> From: YueHaibing <yuehaibing@huawei.com>
> 
> When building CONFIG_ACPI is not set
> gcc warn this:
> 
> drivers/gpio/gpio-merrifield.c: In function mrfld_gpio_get_pinctrl_dev_name:
> drivers/gpio/gpio-merrifield.c:388:19: error: dereferencing pointer to incomplete type struct acpi_device
>    put_device(&adev->dev);
>                    ^

Thanks for the patch. My comment below.

This patch went through ACPI subsystem, so, include Rafael and linux-acpi
mailing list in next iteration.

> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes:d00d2109c367 ("gpio: merrifield: Convert to use acpi_dev_get_first_match_dev()")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/gpio/gpio-merrifield.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-merrifield.c b/drivers/gpio/gpio-merrifield.c
> index 2383dc7..78ac32f 100644
> --- a/drivers/gpio/gpio-merrifield.c
> +++ b/drivers/gpio/gpio-merrifield.c
> @@ -379,17 +379,18 @@ static void mrfld_irq_init_hw(struct mrfld_gpio *priv)
>  
>  static const char *mrfld_gpio_get_pinctrl_dev_name(struct mrfld_gpio *priv)
>  {
> -	struct acpi_device *adev;
>  	const char *name;
> +#ifdef CONFIG_ACPI
> +	struct acpi_device *adev;
>  
>  	adev = acpi_dev_get_first_match_dev("INTC1002", NULL, -1);
>  	if (adev) {
>  		name = devm_kstrdup(priv->dev, acpi_dev_name(adev), GFP_KERNEL);
>  		put_device(&adev->dev);

> -	} else {
> -		name = "pinctrl-merrifield";
>  	}

This will break ACPI=y on non-ACPI platform, where we need to fallback to
the platform driver name.


Better to do the following in acpi.h

#ifdef CONFIG_ACPI
static inline void put_acpi_device(struct acpi_device *adev)
{
	put_device(&adev->dev);
}
#else
static inline void put_acpi_device(struct acpi_device *adev) {}
#endif

> -
> +#else
> +	name = "pinctrl-merrifield";
> +#endif
>  	return name;
>  }

-- 
With Best Regards,
Andy Shevchenko


