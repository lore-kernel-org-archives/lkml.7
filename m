Return-Path: <SRS0=//ty=TS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E640FC04AAF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 07:42:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDA102166E
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 07:42:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728074AbfERHm2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 May 2019 03:42:28 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:42080 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725268AbfERHm2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 May 2019 03:42:28 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 34126ADB15A41BF69D89;
        Sat, 18 May 2019 15:42:26 +0800 (CST)
Received: from [127.0.0.1] (10.177.19.180) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Sat, 18 May 2019
 15:42:19 +0800
Subject: Re: [PATCH] ipmi_si: fix unexpected driver unregister warning
To:     <minyard@acm.org>
CC:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <openipmi-developer@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, Hulk Robot <hulkci@huawei.com>
References: <20190517101245.4341-1-wangkefeng.wang@huawei.com>
 <20190517161821.GB11017@minyard.net>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
Message-ID: <e2bc308b-49d3-7a17-08b7-dce504898969@huawei.com>
Date:   Sat, 18 May 2019 15:40:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20190517161821.GB11017@minyard.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.177.19.180]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/5/18 0:18, Corey Minyard wrote:
> On Fri, May 17, 2019 at 06:12:44PM +0800, Kefeng Wang wrote:
>> If ipmi_si_platform_init()->platform_driver_register() fails,
>> platform_driver_unregister() called unconditionally will trigger
>> following warning,
>>
>> ipmi_platform: Unable to register driver: -12
>> ------------[ cut here ]------------
>> Unexpected driver unregister!
>> WARNING: CPU: 1 PID: 7210 at drivers/base/driver.c:193 driver_unregister+0x60/0x70 drivers/base/driver.c:193
>>
>> Fix it by adding platform_registered variable, only unregister platform
>> driver when it is already successfully registered.
> This is good, but have you found out why the driver was unable to
> register in the first place?  That really shouldn't happen.

Yes, it is hard to happen in  real scene, the test robot found this issue

when FAULT_INJECTION enabled.

>
> This patch is queued for 5.3.
>
> -corey
>
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>> ---
>>  drivers/char/ipmi/ipmi_si_platform.c | 6 +++++-
>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/char/ipmi/ipmi_si_platform.c b/drivers/char/ipmi/ipmi_si_platform.c
>> index f2a91c4d8cab..0cd849675d99 100644
>> --- a/drivers/char/ipmi/ipmi_si_platform.c
>> +++ b/drivers/char/ipmi/ipmi_si_platform.c
>> @@ -19,6 +19,7 @@
>>  #include "ipmi_si.h"
>>  #include "ipmi_dmi.h"
>>  
>> +static bool platform_registered;
>>  static bool si_tryplatform = true;
>>  #ifdef CONFIG_ACPI
>>  static bool          si_tryacpi = true;
>> @@ -469,9 +470,12 @@ void ipmi_si_platform_init(void)
>>  	int rv = platform_driver_register(&ipmi_platform_driver);
>>  	if (rv)
>>  		pr_err("Unable to register driver: %d\n", rv);
>> +	else
>> +		platform_registered = true;
>>  }
>>  
>>  void ipmi_si_platform_shutdown(void)
>>  {
>> -	platform_driver_unregister(&ipmi_platform_driver);
>> +	if (platform_registered)
>> +		platform_driver_unregister(&ipmi_platform_driver);
>>  }
>> -- 
>> 2.20.1
>>
> .
>

