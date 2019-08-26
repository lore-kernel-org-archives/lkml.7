Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0155DC3A5A4
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 08:12:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2B8E206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 08:12:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730397AbfHZIM2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 04:12:28 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:36370 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729582AbfHZIM2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 04:12:28 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id E48CEA667BA6D685D08A;
        Mon, 26 Aug 2019 16:12:24 +0800 (CST)
Received: from [127.0.0.1] (10.133.213.239) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Mon, 26 Aug 2019
 16:12:20 +0800
Subject: Re: [PATCH -next] rtc: pcf2127: Fix build error without
 CONFIG_WATCHDOG_CORE
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
References: <20190823124553.19364-1-yuehaibing@huawei.com>
 <20190823140513.GB9844@piout.net>
CC:     <a.zummo@towertech.it>, <bruno.thomsen@gmail.com>,
        <linux@roeck-us.net>, <linux-rtc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
From:   Yuehaibing <yuehaibing@huawei.com>
Message-ID: <4b608c55-2541-30cf-ad88-c19a5c0cc84f@huawei.com>
Date:   Mon, 26 Aug 2019 16:12:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20190823140513.GB9844@piout.net>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/8/23 22:05, Alexandre Belloni wrote:
> On 23/08/2019 20:45:53+0800, YueHaibing wrote:
>> If WATCHDOG_CORE is not set, build fails:
>>
>> drivers/rtc/rtc-pcf2127.o: In function `pcf2127_probe.isra.6':
>> drivers/rtc/rtc-pcf2127.c:478: undefined reference to `devm_watchdog_register_device'
>>
>> Add WATCHDOG_CORE Kconfig dependency to fix this.
>>
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Fixes: bbc597561ce1 ("rtc: pcf2127: add watchdog feature support")
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>> ---
>>  drivers/rtc/Kconfig | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
>> index 25af63d..9dce7dc 100644
>> --- a/drivers/rtc/Kconfig
>> +++ b/drivers/rtc/Kconfig
>> @@ -886,6 +886,8 @@ config RTC_DRV_DS3232_HWMON
>>  config RTC_DRV_PCF2127
>>  	tristate "NXP PCF2127"
>>  	depends on RTC_I2C_AND_SPI
>> +	depends on WATCHDOG
> 
> Definitively not, I fixed it that way:
> +       select WATCHDOG_CORE if WATCHDOG


No, this still fails while WATCHDOG is not set

> 
> 

