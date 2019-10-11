Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BADCECE58C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 16:14:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CE56206CD
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 16:14:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728138AbfJKQOD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 12:14:03 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:42720 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726692AbfJKQOC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 12:14:02 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 4D07B7877898D923F68F;
        Sat, 12 Oct 2019 00:14:00 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.68) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0; Sat, 12 Oct 2019
 00:13:55 +0800
Message-ID: <5DA0AA42.1090403@huawei.com>
Date:   Sat, 12 Oct 2019 00:13:54 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     Jerome Pouiller <Jerome.Pouiller@silabs.com>
CC:     Greg KH <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] staging: wfx: fix an undefined reference error when CONFIG_MMC=m
References: <1570762939-8735-1-git-send-email-zhongjiang@huawei.com> <20191011090256.GC1076760@kroah.com> <5DA0A4F4.4050103@huawei.com> <25343442.QKQdTnp5z4@pc-42>
In-Reply-To: <25343442.QKQdTnp5z4@pc-42>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.68]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/10/11 23:55, Jerome Pouiller wrote:
> On Friday 11 October 2019 17:51:29 CEST zhong jiang wrote:
> [...]
>> How about the following patch ?
>>
>> diff --git a/drivers/staging/wfx/Makefile b/drivers/staging/wfx/Makefile
>> index 0d9c1ed..77d68b7 100644
>> --- a/drivers/staging/wfx/Makefile
>> +++ b/drivers/staging/wfx/Makefile
>> @@ -19,6 +19,6 @@ wfx-y := \
>>         sta.o \
>>         debug.o
>>  wfx-$(CONFIG_SPI) += bus_spi.o
>> -wfx-$(subst m,y,$(CONFIG_MMC)) += bus_sdio.o
>> +wfx-$(CONFIG_MMC) += bus_sdio.o
>>
>>  obj-$(CONFIG_WFX) += wfx.o
>> diff --git a/drivers/staging/wfx/main.c b/drivers/staging/wfx/main.c
>> index d2508bc..26720a4 100644
>> --- a/drivers/staging/wfx/main.c
>> +++ b/drivers/staging/wfx/main.c
>> @@ -484,16 +484,19 @@ static int __init wfx_core_init(void)
>>
>>         if (IS_ENABLED(CONFIG_SPI))
>>                 ret = spi_register_driver(&wfx_spi_driver);
>> -       if (IS_ENABLED(CONFIG_MMC) && !ret)
>> +#ifdef CONFIG_MMC
>> +       if (!ret)
>>                 ret = sdio_register_driver(&wfx_sdio_driver);
>> +#endif
>>         return ret
>>  }
>>  module_init(wfx_core_init);
>>
>>  static void __exit wfx_core_exit(void)
>>  {
>> -       if (IS_ENABLED(CONFIG_MMC))
>> -               sdio_unregister_driver(&wfx_sdio_driver);
>> +#ifdef CONFIG_MMC
>> +       sdio_unregister_driver(&wfx_sdio_driver);
>> +#endif
>>         if (IS_ENABLED(CONFIG_SPI))
>>                 spi_unregister_driver(&wfx_spi_driver);
>>  }
> Hello zhong,
>
> Can you also check the case where CONFIG_SPI is not set?
I have tested the case and it works well when CONFIG_SPI is not set.

Thanks,
zhong jiang
> Thank you,
>


