Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 432DBC10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 11:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F5F021A4C
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 11:15:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729733AbfJCLPr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 07:15:47 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3237 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729241AbfJCLPr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 07:15:47 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id B6B522487246D09D5E84;
        Thu,  3 Oct 2019 19:15:38 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.179) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Thu, 3 Oct 2019
 19:15:37 +0800
Subject: Re: [PATCH 3/3] arm64: configs: unset CPU_BIG_ENDIAN
To:     Anders Roxell <anders.roxell@linaro.org>
References: <20190926193030.5843-1-anders.roxell@linaro.org>
 <20190926193030.5843-5-anders.roxell@linaro.org>
 <bf5db3a5-96da-752c-49ea-d0de899882d5@huawei.com>
 <CADYN=9LB9RHgRkQj=HcKDz1x9jqmT464Kseh2wZU5VvcLit+bQ@mail.gmail.com>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Olof Johansson" <olof@lixom.net>
From:   John Garry <john.garry@huawei.com>
Message-ID: <d978673e-cbd1-5ab5-b2a4-cdb407d0f98c@huawei.com>
Date:   Thu, 3 Oct 2019 12:15:32 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <CADYN=9LB9RHgRkQj=HcKDz1x9jqmT464Kseh2wZU5VvcLit+bQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.179]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/10/2019 08:40, Anders Roxell wrote:
> On Tue, 1 Oct 2019 at 16:04, John Garry <john.garry@huawei.com> wrote:
>>
>> On 26/09/2019 20:30, Anders Roxell wrote:
>>> When building allmodconfig KCONFIG_ALLCONFIG=$(pwd)/arch/arm64/configs/defconfig
>>> CONFIG_CPU_BIG_ENDIAN gets enabled. Which tends not to be what most
>>> people wants.
>>
>> Today allmodconfig does not enable CONFIG_ACPI due to BE config, which
>> is quite unfortunate, I'd say.
>
> right.
>
>>
>>>
>>> Rework so that we disable CONFIG_CPU_BIG_ENDIAN in the defcinfig file so
>>
>> defconfig
>
> thanks.
>
>>
>>> it doesn't get enabled when building allmodconfig kernels. When doing a
>>> 'make savedefconfig' CONFIG_CPU_BIG_ENDIAN will be dropped.
>>
>> So without having to pass KCONFIG_ALLCONFIG or do anything else, what
>> about a config for CONFIG_CPU_LITTLE_ENDIAN instead? I'm not sure if
>> that was omitted for a specific reason.
>
> Oh, I tried to elaborate on the idea in the cover letter, that using
> the defconfig
> as base and then configure the rest as modules is to get a bootable kernel
> that have as many features turned on as possible. That will make it possible
> to run as wide a range of testsuites as possible on a single kernel.
>
> Does that make it clearer ?

Hi Anders,

Yeah, I got the idea.

So when you say "'make savedefconfig' CONFIG_CPU_BIG_ENDIAN will be 
dropped", I don't know what the rules are in terms of resyncing the 
common defconfig (I was under the impression that it's done per release 
cycle by the arm soc maintainers, but can't find evidence as such), but 
your change may be easily lost in this way.

Thanks,
John

>
> Cheers,
> Anders
>
>
>>
>> Thanks,
>> John
>>
>>>
>>> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
>>> ---
>>>  arch/arm64/configs/defconfig | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
>>> index 878f379d8d84..c9aa6b9ee996 100644
>>> --- a/arch/arm64/configs/defconfig
>>> +++ b/arch/arm64/configs/defconfig
>>> @@ -855,3 +855,4 @@ CONFIG_DEBUG_KERNEL=y
>>>  # CONFIG_SCHED_DEBUG is not set
>>>  CONFIG_MEMTEST=y
>>>  # CONFIG_CMDLINE_FORCE is not set
>>> +# CONFIG_CPU_BIG_ENDIAN is not set
>>>
>>
>>
>
> .
>


