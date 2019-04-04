Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79BF1C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 12:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F5222082E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 12:02:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729706AbfDDMCN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 08:02:13 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43522 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbfDDMCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 08:02:12 -0400
Received: by mail-ed1-f67.google.com with SMTP id d26so1923330ede.10
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 05:02:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Trk4lNTIfJr4C379Y22+2fc0bBNFnEW/D6OXfGGl9ig=;
        b=YIqjljbOuF0WtOaEvL9L0xpbaLyQ7sokYQXdhvz4cz0MNdTb743PaKrfuHLRuuo78B
         zbIVNoHRbFlckaxfOuZPYmiDPxDQ1tl9hutIfxCN/ZKjQ6KYuvfw7SU7OFFxB4Lnc5L9
         H3LOTfqPQ2E7q2wpW1XUQBHH1qByp1VRkE0o5+AaCHLYvWCnQYmba/Q7o9K7IHN/hREe
         1idmUUDO37972JGNVnfhlJUeN6yY8OKS6cNiQ9L9ev5qqx7zveKezvOz7GK57j6qoVSd
         4SjoND1F9RMij+Vxoq7Xl4XAY77dMZtn2aHBooEajKFr06BLdsULHrzGp0hRB83mp6/t
         0e8w==
X-Gm-Message-State: APjAAAWmgk6UJ6MzKbZYW6mwsUtIDHG5DzNa8r3/MlaCCZMFnWrHmDQs
        qZ15qXJ96JMrHItJLjjgJfPkI/LNBRc=
X-Google-Smtp-Source: APXvYqwpWOwq6oMp/rl1zWcxvVpIw9wsOMlCLKpE1Dna3xWHidHGeB9fvA5RwqHNaUDilQv/61H2Og==
X-Received: by 2002:aa7:c70a:: with SMTP id i10mr3614542edq.153.1554379330471;
        Thu, 04 Apr 2019 05:02:10 -0700 (PDT)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id n16sm2489254ejb.28.2019.04.04.05.02.09
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Apr 2019 05:02:09 -0700 (PDT)
Subject: Re: [PATCH] extcon: axp288: Fix build err without CONFIG_ACPI
To:     Yue Haibing <yuehaibing@huawei.com>, myungjoo.ham@samsung.com,
        cw00.choi@samsung.com, wens@csie.org
Cc:     linux-kernel@vger.kernel.org
References: <20190404104222.23900-1-yuehaibing@huawei.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <bc169cce-5503-f1ec-777f-3b92f3371daf@redhat.com>
Date:   Thu, 4 Apr 2019 14:02:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190404104222.23900-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 04-04-19 12:42, Yue Haibing wrote:
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

Using this driver without ACPI makes little sense, IMHO it would be better to add
a depends on ACPI to the Kconfig entry, rather then adding #ifdef-s to the driver.

Regards,

Hans


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
> 
