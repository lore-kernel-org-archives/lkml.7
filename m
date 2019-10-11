Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9AA1ECE58C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 14:49:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 970012089F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 14:49:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbfJKOtB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 10:49:01 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:40616 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726331AbfJKOtB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 10:49:01 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id EEBF05B08FA61B399531;
        Fri, 11 Oct 2019 22:48:58 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.68) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.439.0; Fri, 11 Oct 2019
 22:48:57 +0800
Message-ID: <5DA09659.9070401@huawei.com>
Date:   Fri, 11 Oct 2019 22:48:57 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     Jerome Pouiller <Jerome.Pouiller@silabs.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] staging: wfx: fix an undefined reference error when CONFIG_MMC=m
References: <1570762939-8735-1-git-send-email-zhongjiang@huawei.com> <20191011042609.GB938845@kroah.com> <3864047.FfxYVOUlJ1@pc-42> <20191011090256.GC1076760@kroah.com>
In-Reply-To: <20191011090256.GC1076760@kroah.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.68]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/10/11 17:02, Greg KH wrote:
> On Fri, Oct 11, 2019 at 08:40:08AM +0000, Jerome Pouiller wrote:
>> On Friday 11 October 2019 06:26:16 CEST Greg KH wrote:
>>> CAUTION: This email originated from outside of the organization. Do not 
>> click links or open attachments unless you recognize the sender and know the 
>> content is safe.
>>>
>>> On Fri, Oct 11, 2019 at 11:02:19AM +0800, zhong jiang wrote:
>>>> I hit the following error when compile the kernel.
>>>>
>>>> drivers/staging/wfx/main.o: In function `wfx_core_init':
>>>> /home/z00352263/linux-next/linux-next/drivers/staging/wfx/main.c:488: 
>> undefined reference to `sdio_register_driver'
>>>> drivers/staging/wfx/main.o: In function `wfx_core_exit':
>>>> /home/z00352263/linux-next/linux-next/drivers/staging/wfx/main.c:496: 
>> undefined reference to `sdio_unregister_driver'
>>>> drivers/staging/wfx/main.o:(.debug_addr+0x1a8): undefined reference to 
>> `sdio_register_driver'
>>>> drivers/staging/wfx/main.o:(.debug_addr+0x6f0): undefined reference to 
>> `sdio_unregister_driver'
>>>> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
>>>> ---
>>>>  drivers/staging/wfx/Kconfig  | 3 ++-
>>>>  drivers/staging/wfx/Makefile | 5 +++--
>>>>  2 files changed, 5 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/staging/wfx/Kconfig b/drivers/staging/wfx/Kconfig
>>>> index 9b8a1c7..4d045513 100644
>>>> --- a/drivers/staging/wfx/Kconfig
>>>> +++ b/drivers/staging/wfx/Kconfig
>>>> @@ -1,7 +1,8 @@
>>>>  config WFX
>>>>       tristate "Silicon Labs wireless chips WF200 and further"
>>>>       depends on MAC80211
>>>> -     depends on (SPI || MMC)
>>>> +     depends on SPI
>>>> +     select MMC
>>> How about:
>>>         depends on (SPI && MMC)
>> I dislike to force user to enable both buses while only one of them is 
>> sufficient. I would prefer to keep current dependencies and to add
>> #ifdef around problematic functions.
> Yes, that's the better thing to do here overall.
>
> zhong, can you work on that?
I will repost as Jerome said.  Thanks

Sincerely,
zhong jiang
> thanks,
>
> greg k-h
>
> .
>


