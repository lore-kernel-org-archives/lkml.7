Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C1E6C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 09:27:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A8E12133F
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 09:27:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729257AbfJCJ1H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 05:27:07 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3197 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727995AbfJCJ1H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 05:27:07 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 9741A5048084F65EC09C;
        Thu,  3 Oct 2019 17:27:04 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.179) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Thu, 3 Oct 2019
 17:26:57 +0800
Subject: Re: [PATCH 3/3] bus: hisi_lpc: Expand build test coverage
To:     Arnd Bergmann <arnd@arndb.de>
References: <1569945867-82243-1-git-send-email-john.garry@huawei.com>
 <1569945867-82243-4-git-send-email-john.garry@huawei.com>
 <CAK8P3a1rAKF2k0iuPirF+_La_VEmEbQ+D0XAfdcy=6K-Q1fu9g@mail.gmail.com>
 <4f96d830-a38d-5ecd-4f46-faf0306251f1@huawei.com>
 <CAK8P3a2LZnDfT_yNaDo4CgheC-1dZvK3DMrC8RY6qt4F6rEGvg@mail.gmail.com>
CC:     Wei Xu <xuwei5@hisilicon.com>, Linuxarm <linuxarm@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Olof Johansson <olof@lixom.net>
From:   John Garry <john.garry@huawei.com>
Message-ID: <8c969173-be79-b8c4-c871-982d22d4fc18@huawei.com>
Date:   Thu, 3 Oct 2019 10:26:53 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a2LZnDfT_yNaDo4CgheC-1dZvK3DMrC8RY6qt4F6rEGvg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.179]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/10/2019 19:22, Arnd Bergmann wrote:
> On Wed, Oct 2, 2019 at 6:25 PM John Garry <john.garry@huawei.com> wrote:
>> On 02/10/2019 16:43, Arnd Bergmann wrote:
>>> On Tue, Oct 1, 2019 at 6:07 PM John Garry <john.garry@huawei.com> wrote:
>>>>
>>>> Currently the driver will only ever be built for ARM64 because it selects
>>>> CONFIG_INDIRECT_PIO, which itself depends on ARM64.
>>>>
>>>> Expand build test coverage for the driver to other architectures by only
>>>> selecting CONFIG_INDIRECT_PIO for ARM64, when we really want it.
>>>>
>>>> Signed-off-by: John Garry <john.garry@huawei.com>
>>>
>>
>> Hi Arnd,
>>
>>> Good idea, but doesn't this cause a link failure against
>>> logic_pio_register_range() when INDIRECT_PIO is disabled?
>>
>> No, it shouldn't do. Function
>> lib/logic_pio.c::logic_pio_register_range() is built always, outside any
>> INDIRECT_PIO checking.
>
> Ok, I see.
>
>> A some stage, for completeness we should probably change
>> logic_pio_register_range() and friends to be under PCI_IOBASE. But then
>> we would need stubs for !PCI_IOBASE, due to this above change and also
>> references from the device tree code. I'd have to consider this a bit
>> more. Let me know what you think.
>
> It's probably not to do this with the usual 'static inline' stubs in the
> header files. There is no rush here, but it would be nice to not build
> this code when it is not needed.

Agreed, I'll add it to my todo list.

So we want to build logic_pio.c for archs which define PCI_IOBASE, but 
there is no specific config option for that.

>
> I wonder if this one-line change would take care of the !CONFIG_OF
> case already (it probably doesn't):
>
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -107,7 +107,7 @@ obj-$(CONFIG_HAS_IOMEM) += iomap_copy.o devres.o
>  obj-$(CONFIG_CHECK_SIGNATURE) += check_signature.o
>  obj-$(CONFIG_DEBUG_LOCKING_API_SELFTESTS) += locking-selftest.o
>
> -obj-y += logic_pio.o
> +lib-y += logic_pio.o

So that means that this obj will not be included in the vmlinux file for 
!CONFIG_OF (for archs with !PCI_IOBASE or !PCI).

It is an improvement, but I still would like to make the complete change 
and not to build at all for archs which don't define PCI_IOBASE.

>
>  obj-$(CONFIG_GENERIC_HWEIGHT) += hweight.o
>
> On a related note: At some point we may want to add an indirect
> method for readl()/writel(), to deal with some of the weirder 32-bit
> ARM platforms. We'll have to see how well this can fit into the
> infrastructure we already have for indirect PIO.

It should be possible. We would just need to manage 2 separate logical 
spaces instead of one: a. mmio b. pio

I'm guessing that all the code for logical <-> hw bus address 
translations would be the same.

Thanks,
John

>
>      Arnd
>
> .
>


