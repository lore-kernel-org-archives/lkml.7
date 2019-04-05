Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30AD2C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 14:50:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01D4821852
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 14:50:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731344AbfDEOuS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 10:50:18 -0400
Received: from mga12.intel.com ([192.55.52.136]:60091 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726594AbfDEOuR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 10:50:17 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Apr 2019 07:50:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,313,1549958400"; 
   d="scan'208";a="131759100"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga008.jf.intel.com with ESMTP; 05 Apr 2019 07:50:10 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hCQAT-0001v1-DC; Fri, 05 Apr 2019 17:50:09 +0300
Date:   Fri, 5 Apr 2019 17:50:09 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Yue Haibing <yuehaibing@huawei.com>
Cc:     linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v2] gpio: merrifield: Fix build err without CONFIG_ACPI
Message-ID: <20190405145009.GD9224@smile.fi.intel.com>
References: <20190404103925.25652-1-yuehaibing@huawei.com>
 <20190405142112.26592-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190405142112.26592-1-yuehaibing@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 05, 2019 at 10:21:12PM +0800, Yue Haibing wrote:
> From: YueHaibing <yuehaibing@huawei.com>
> 
> When building CONFIG_ACPI is not set
> gcc warn this:
> 
> drivers/gpio/gpio-merrifield.c: In function mrfld_gpio_get_pinctrl_dev_name:
> drivers/gpio/gpio-merrifield.c:388:19: error: dereferencing pointer to incomplete type struct acpi_device
>    put_device(&adev->dev);
>                    ^
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Fixes:d00d2109c367 ("gpio: merrifield: Convert to use acpi_dev_get_first_match_dev()")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Thank you for an update, I have a comment below, but before sending v3, let
Rafael to have a chance to look at it.

>  #ifdef CONFIG_ACPI
>  extern int acpi_platform_notify(struct device *dev, enum kobject_action action);
> +
> +static inline void put_acpi_device(struct acpi_device *adev)
> +{
> +	put_device(&adev->dev);
> +}

This should probably go to acpi_bus.h under acpi_dev_get_first_match_dev().
And talking to Mika we agreed that naming would be better as acpi_dev_put().

-- 
With Best Regards,
Andy Shevchenko


