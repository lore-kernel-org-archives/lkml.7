Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A236EC3A5A4
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 17:19:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 782E62077B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 17:19:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="B+w/8WIE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbfH1RTE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 13:19:04 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49198 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbfH1RTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 13:19:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=AlcDejLqus5Zm1OgF/D2SbvMaWMC14kOcgweWFWp9ZA=; b=B+w/8WIEq/ywgCOsUw4odPUMy
        ps2chauyCPQzUBgmya2bROQT1+PiK1XymDN795xLmreUBGPot/+UQngUl/CXdKe04MK8IU4eNsZfd
        C9toGqTeTN4sJKkcSTczneF6hKKDF/4OzCBCje/XHIaUmeWs20OrRZZU1GGkcjXrVJpWh4Vph8RpC
        O4cM7B2gVc9xjD7paUtk1/jKtaDQnUb8KyG1VJ8f/TS1KNSTHp2rS5dV5XEhf4bGWBNiJr2yztAuU
        fEqZRam7ypGa+8+X+FRpUqB0z8IJknqg8RwVZnn0dOB9zpiu8V2CYbCMIyc+K5k/R5Z3YdrROSOPm
        2WSeqJmuw==;
Received: from [2601:1c0:6200:6e8::4f71]
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i31b0-0001fj-4R; Wed, 28 Aug 2019 17:18:58 +0000
Subject: Re: [PATCH -next] rtc: pcf2127: Fix build error without
 CONFIG_WATCHDOG_CORE
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        YueHaibing <yuehaibing@huawei.com>
Cc:     a.zummo@towertech.it, bruno.thomsen@gmail.com, linux@roeck-us.net,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190823124553.19364-1-yuehaibing@huawei.com>
 <20190823140513.GB9844@piout.net>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <36720fae-ef20-61d4-1d9d-421e7199a0eb@infradead.org>
Date:   Wed, 28 Aug 2019 10:18:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190823140513.GB9844@piout.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/23/19 7:05 AM, Alexandre Belloni wrote:
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
> 
> 

No, that's not a fix.  The build error still happens with that patch applied.

-- 
~Randy
