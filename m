Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F5D4C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 13:26:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8C1A20855
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 13:26:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729658AbfDDN0v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 09:26:51 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5667 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726269AbfDDN0v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 09:26:51 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id DE104A8740BD1D5C9D77;
        Thu,  4 Apr 2019 21:26:48 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.96) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.408.0; Thu, 4 Apr 2019
 21:26:45 +0800
Subject: Re: [PATCH] extcon: axp288: Fix build err without CONFIG_ACPI
To:     Hans de Goede <hdegoede@redhat.com>, <myungjoo.ham@samsung.com>,
        <cw00.choi@samsung.com>, <wens@csie.org>
References: <20190404104222.23900-1-yuehaibing@huawei.com>
 <bc169cce-5503-f1ec-777f-3b92f3371daf@redhat.com>
CC:     <linux-kernel@vger.kernel.org>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <71adb924-a258-1cee-a463-50040d6226e0@huawei.com>
Date:   Thu, 4 Apr 2019 21:26:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <bc169cce-5503-f1ec-777f-3b92f3371daf@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/4/4 20:02, Hans de Goede wrote:
> Hi,
> 
> On 04-04-19 12:42, Yue Haibing wrote:
>> From: YueHaibing <yuehaibing@huawei.com>
>>
>> When building CONFIG_ACPI is not set
>> gcc warn this:
>>
>> drivers/extcon/extcon-axp288.c: In function 'axp288_extcon_probe':
>> drivers/extcon/extcon-axp288.c:363:20: error: dereferencing pointer to incomplete type
>>      put_device(&adev->dev);
>>
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Fixes: 0cf064db948a ("extcon: axp288: Convert to use acpi_dev_get_first_match_dev()")
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> 
> Using this driver without ACPI makes little sense, IMHO it would be better to add
> a depends on ACPI to the Kconfig entry, rather then adding #ifdef-s to the driver.

OK, thank for your commnet, I will send v2 as this.

> 
> Regards,
> 
> Hans
> 
> 
>> ---
>>   drivers/extcon/extcon-axp288.c | 8 +++++---
>>   1 file changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/extcon/extcon-axp288.c b/drivers/extcon/extcon-axp288.c
>> index 50f9402..ed8ac3f 100644
>> --- a/drivers/extcon/extcon-axp288.c
>> +++ b/drivers/extcon/extcon-axp288.c
>> @@ -333,7 +333,6 @@ static int axp288_extcon_probe(struct platform_device *pdev)
>>       struct axp288_extcon_info *info;
>>       struct axp20x_dev *axp20x = dev_get_drvdata(pdev->dev.parent);
>>       struct device *dev = &pdev->dev;
>> -    struct acpi_device *adev;
>>       int ret, i, pirq;
>>         info = devm_kzalloc(&pdev->dev, sizeof(*info), GFP_KERNEL);
>> @@ -357,6 +356,8 @@ static int axp288_extcon_probe(struct platform_device *pdev)
>>           if (ret)
>>               return ret;
>>   +#ifdef CONFIG_ACPI
>> +        struct acpi_device *adev;
>>           adev = acpi_dev_get_first_match_dev("INT3496", NULL, -1);
>>           if (adev) {
>>               info->id_extcon = extcon_get_extcon_dev(acpi_dev_name(adev));
>> @@ -365,9 +366,10 @@ static int axp288_extcon_probe(struct platform_device *pdev)
>>                   return -EPROBE_DEFER;
>>                 dev_info(dev, "controlling USB role\n");
>> -        } else {
>> -            dev_info(dev, "controlling USB role based on Vbus presence\n");
>>           }
>> +#else
>> +        dev_info(dev, "controlling USB role based on Vbus presence\n");
>> +#endif
>>       }
>>         info->vbus_attach = axp288_get_vbus_attach(info);
>>
> 
> .
> 

