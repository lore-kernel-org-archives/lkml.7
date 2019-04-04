Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEF97C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 11:40:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A86AE206C0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 11:40:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Ije3EEPq";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Ije3EEPq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729067AbfDDLka (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 07:40:30 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:52668 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728543AbfDDLka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 07:40:30 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id A9631602F2; Thu,  4 Apr 2019 11:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554378028;
        bh=IfzG6zjZReSc8oTjZzlI1OEOYTP8nHYDf/5c0VfkZ/0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Ije3EEPqT9SLRnUYeoBxHawtx8SgmiQZpKrdqIsr4en15expdA3iOK+2zOuDZuPgD
         7tn4wAiFQ4yVRGt4wXXkeGbGwbedVLE93N+2rvP2oBe+1zeLpa5Ws3YJMBaoMZUufN
         k8ktF/GOmealcA2GfKZ0Kf+ZhqoMlsqvtr2Sw7A8=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 218BE6044E;
        Thu,  4 Apr 2019 11:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554378028;
        bh=IfzG6zjZReSc8oTjZzlI1OEOYTP8nHYDf/5c0VfkZ/0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Ije3EEPqT9SLRnUYeoBxHawtx8SgmiQZpKrdqIsr4en15expdA3iOK+2zOuDZuPgD
         7tn4wAiFQ4yVRGt4wXXkeGbGwbedVLE93N+2rvP2oBe+1zeLpa5Ws3YJMBaoMZUufN
         k8ktF/GOmealcA2GfKZ0Kf+ZhqoMlsqvtr2Sw7A8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 218BE6044E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] gpio: merrifield: Fix build err without CONFIG_ACPI
To:     Yue Haibing <yuehaibing@huawei.com>,
        andriy.shevchenko@linux.intel.com, linus.walleij@linaro.org,
        bgolaszewski@baylibre.com
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
References: <20190404103925.25652-1-yuehaibing@huawei.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <3b6d3845-90df-3898-76b2-646d7c4eb50a@codeaurora.org>
Date:   Thu, 4 Apr 2019 17:10:23 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190404103925.25652-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/4/2019 4:09 PM, Yue Haibing wrote:
> From: YueHaibing <yuehaibing@huawei.com>
>
> When building CONFIG_ACPI is not set
> gcc warn this:
>
> drivers/gpio/gpio-merrifield.c: In function mrfld_gpio_get_pinctrl_dev_name:
> drivers/gpio/gpio-merrifield.c:388:19: error: dereferencing pointer to incomplete type struct acpi_device
>     put_device(&adev->dev);
>                     ^
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes:d00d2109c367 ("gpio: merrifield: Convert to use acpi_dev_get_first_match_dev()")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
-Mukesh
> ---
>   drivers/gpio/gpio-merrifield.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpio/gpio-merrifield.c b/drivers/gpio/gpio-merrifield.c
> index 2383dc7..78ac32f 100644
> --- a/drivers/gpio/gpio-merrifield.c
> +++ b/drivers/gpio/gpio-merrifield.c
> @@ -379,17 +379,18 @@ static void mrfld_irq_init_hw(struct mrfld_gpio *priv)
>   
>   static const char *mrfld_gpio_get_pinctrl_dev_name(struct mrfld_gpio *priv)
>   {
> -	struct acpi_device *adev;
>   	const char *name;
> +#ifdef CONFIG_ACPI
> +	struct acpi_device *adev;
>   
>   	adev = acpi_dev_get_first_match_dev("INTC1002", NULL, -1);
>   	if (adev) {
>   		name = devm_kstrdup(priv->dev, acpi_dev_name(adev), GFP_KERNEL);
>   		put_device(&adev->dev);
> -	} else {
> -		name = "pinctrl-merrifield";
>   	}
> -
> +#else
> +	name = "pinctrl-merrifield";
> +#endif
>   	return name;
>   }
>   
