Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74901C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 11:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B616206DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 11:48:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Tm7fFYEd";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="SZZMPKZ/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729277AbfDDLsD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 07:48:03 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:54644 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbfDDLsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 07:48:02 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B1CCF60850; Thu,  4 Apr 2019 11:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554378481;
        bh=B1w0o3Nzhiec6LNozyeMwrtbHIsUCSc7vN3P4LoXAmY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Tm7fFYEdAJ96PZfhiBkiUt5bh4Tj9tz8O/YPruJvXFEgiafMkT7zTXivhwTc6L2R7
         vC2ZjA2dBN3Wje94+i/YDwxiA09trf0rSfUOOIOm6yeYOOBUPHoW6tf8u6p/WQfZrN
         22xz7HOlKIajmzRhUrwvkyWeZhrWi92yKgaLv8K8=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0ADF760712;
        Thu,  4 Apr 2019 11:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554378480;
        bh=B1w0o3Nzhiec6LNozyeMwrtbHIsUCSc7vN3P4LoXAmY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=SZZMPKZ/dxb3qiMTr7uIQE44H7+4qjjuJY4H20UL8YkGefZ2AOxseBUBUq5X8o77n
         hH1Yqfhvpub7oOh7wDwWpscn+qBcxw30i+z6aQcHr/NFZlYrEcVTavlejbIQOgEnCE
         IV0rcZ1+ojjwH/2GjhpWMKYD6GpKN2cSqPJq4ZqQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0ADF760712
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] extcon: axp288: Fix build err without CONFIG_ACPI
To:     Yue Haibing <yuehaibing@huawei.com>, myungjoo.ham@samsung.com,
        cw00.choi@samsung.com, wens@csie.org, hdegoede@redhat.com
Cc:     linux-kernel@vger.kernel.org
References: <20190404104222.23900-1-yuehaibing@huawei.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <81bcf9f0-9ff9-b9c4-975f-594ea2de0d77@codeaurora.org>
Date:   Thu, 4 Apr 2019 17:17:56 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190404104222.23900-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/4/2019 4:12 PM, Yue Haibing wrote:
> From: YueHaibing <yuehaibing@huawei.com>
>
> When building CONFIG_ACPI is not set
> gcc warn this:
>
> drivers/extcon/extcon-axp288.c: In function 'axp288_extcon_probe':
> drivers/extcon/extcon-axp288.c:363:20: error: dereferencing pointer to incomplete type
>      put_device(&adev->dev);
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: 0cf064db948a ("extcon: axp288: Convert to use acpi_dev_get_first_match_dev()")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>


Looks fine to me.
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
-Mukesh

> ---
>   drivers/extcon/extcon-axp288.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/extcon/extcon-axp288.c b/drivers/extcon/extcon-axp288.c
> index 50f9402..ed8ac3f 100644
> --- a/drivers/extcon/extcon-axp288.c
> +++ b/drivers/extcon/extcon-axp288.c
> @@ -333,7 +333,6 @@ static int axp288_extcon_probe(struct platform_device *pdev)
>   	struct axp288_extcon_info *info;
>   	struct axp20x_dev *axp20x = dev_get_drvdata(pdev->dev.parent);
>   	struct device *dev = &pdev->dev;
> -	struct acpi_device *adev;
>   	int ret, i, pirq;
>   
>   	info = devm_kzalloc(&pdev->dev, sizeof(*info), GFP_KERNEL);
> @@ -357,6 +356,8 @@ static int axp288_extcon_probe(struct platform_device *pdev)
>   		if (ret)
>   			return ret;
>   
> +#ifdef CONFIG_ACPI
> +		struct acpi_device *adev;
>   		adev = acpi_dev_get_first_match_dev("INT3496", NULL, -1);
>   		if (adev) {
>   			info->id_extcon = extcon_get_extcon_dev(acpi_dev_name(adev));
> @@ -365,9 +366,10 @@ static int axp288_extcon_probe(struct platform_device *pdev)
>   				return -EPROBE_DEFER;
>   
>   			dev_info(dev, "controlling USB role\n");
> -		} else {
> -			dev_info(dev, "controlling USB role based on Vbus presence\n");
>   		}
> +#else
> +		dev_info(dev, "controlling USB role based on Vbus presence\n");
> +#endif
>   	}
>   
>   	info->vbus_attach = axp288_get_vbus_attach(info);
