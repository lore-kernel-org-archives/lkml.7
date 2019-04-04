Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A8CDC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 14:04:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 595A720657
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 14:04:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728594AbfDDOEJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 10:04:09 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:46714 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726618AbfDDOEJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 10:04:09 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 89005D91AB4F9D72CA65;
        Thu,  4 Apr 2019 22:04:06 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.96) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.408.0; Thu, 4 Apr 2019
 22:04:05 +0800
Subject: Re: [PATCH] gpio: merrifield: Fix build err without CONFIG_ACPI
To:     <andriy.shevchenko@linux.intel.com>, <linus.walleij@linaro.org>,
        <bgolaszewski@baylibre.com>, <rjw@rjwysocki.net>
References: <20190404103925.25652-1-yuehaibing@huawei.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <271a33ae-b4fc-0528-cf59-5053dc46cce0@huawei.com>
Date:   Thu, 4 Apr 2019 22:04:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20190404103925.25652-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+cc Rafael and linux-acpi

On 2019/4/4 18:39, Yue Haibing wrote:
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
> -
> +#else
> +	name = "pinctrl-merrifield";
> +#endif
>  	return name;
>  }
>  
> 

