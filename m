Return-Path: <SRS0=daYT=YG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 575F2C4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 14:17:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F78E206A3
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 14:17:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729282AbfJMORt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Oct 2019 10:17:49 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3743 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729032AbfJMORt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Oct 2019 10:17:49 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 18ED857509FEEFA08F42;
        Sun, 13 Oct 2019 22:17:45 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.68) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.439.0; Sun, 13 Oct 2019
 22:17:43 +0800
Message-ID: <5DA33206.6090104@huawei.com>
Date:   Sun, 13 Oct 2019 22:17:42 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <Jerome.Pouiller@silabs.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] staging: wfx: fix an undefined reference error when
 CONFIG_MMC=m
References: <1570877693-52711-1-git-send-email-zhongjiang@huawei.com> <20191012153245.GA2155778@kroah.com>
In-Reply-To: <20191012153245.GA2155778@kroah.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.68]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/10/12 23:32, Greg KH wrote:
> On Sat, Oct 12, 2019 at 06:54:53PM +0800, zhong jiang wrote:
>> I hit the following error when compile the kernel.
>>
>> drivers/staging/wfx/main.o: In function `wfx_core_init':
>> /home/z00352263/linux-next/linux-next/drivers/staging/wfx/main.c:488: undefined reference to `sdio_register_driver'
>> drivers/staging/wfx/main.o: In function `wfx_core_exit':
>> /home/z00352263/linux-next/linux-next/drivers/staging/wfx/main.c:496: undefined reference to `sdio_unregister_driver'
>> drivers/staging/wfx/main.o:(.debug_addr+0x1a8): undefined reference to `sdio_register_driver'
>> drivers/staging/wfx/main.o:(.debug_addr+0x6f0): undefined reference to `sdio_unregister_driver'
>>
>> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
>> ---
>> v2->v3:
>>     We'd better not use #ifdef in .c file to use IS_ENABLED instead.
>>
>> v1->v2:
>>     We should prefer to current dependencies rather than force to enable. 
>>
>>  drivers/staging/wfx/Makefile | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/staging/wfx/Makefile b/drivers/staging/wfx/Makefile
>> index 0d9c1ed..77d68b7 100644
>> --- a/drivers/staging/wfx/Makefile
>> +++ b/drivers/staging/wfx/Makefile
>> @@ -19,6 +19,6 @@ wfx-y := \
>>  	sta.o \
>>  	debug.o
>>  wfx-$(CONFIG_SPI) += bus_spi.o
>> -wfx-$(subst m,y,$(CONFIG_MMC)) += bus_sdio.o
>> +wfx-$(CONFIG_MMC) += bus_sdio.o
>>  
>>  obj-$(CONFIG_WFX) += wfx.o
> How does this change any of the existing logic?  What does this really
> change to solve the issue?  I thought you were going to fix this up as I
> suggested in my last email?
Yep,  It's my stupid fault.  I disable the CONFIG_SPI to test the issue.  :-(

Thanks,
zhong jiang
> thanks,
>
> greg k-h
>
> .
>


