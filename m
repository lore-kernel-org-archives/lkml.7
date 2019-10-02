Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6847C35280
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 16:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 852DB21A4C
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 16:25:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbfJBQZQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 12:25:16 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:52264 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726152AbfJBQZQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 12:25:16 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 55687C1D7E1F42236CE0;
        Thu,  3 Oct 2019 00:25:09 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.179) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Thu, 3 Oct 2019
 00:25:03 +0800
Subject: Re: [PATCH 3/3] bus: hisi_lpc: Expand build test coverage
To:     Arnd Bergmann <arnd@arndb.de>
References: <1569945867-82243-1-git-send-email-john.garry@huawei.com>
 <1569945867-82243-4-git-send-email-john.garry@huawei.com>
 <CAK8P3a1rAKF2k0iuPirF+_La_VEmEbQ+D0XAfdcy=6K-Q1fu9g@mail.gmail.com>
CC:     Wei Xu <xuwei5@hisilicon.com>, Linuxarm <linuxarm@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Olof Johansson <olof@lixom.net>
From:   John Garry <john.garry@huawei.com>
Message-ID: <4f96d830-a38d-5ecd-4f46-faf0306251f1@huawei.com>
Date:   Wed, 2 Oct 2019 17:24:58 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a1rAKF2k0iuPirF+_La_VEmEbQ+D0XAfdcy=6K-Q1fu9g@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.179]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/10/2019 16:43, Arnd Bergmann wrote:
> On Tue, Oct 1, 2019 at 6:07 PM John Garry <john.garry@huawei.com> wrote:
>>
>> Currently the driver will only ever be built for ARM64 because it selects
>> CONFIG_INDIRECT_PIO, which itself depends on ARM64.
>>
>> Expand build test coverage for the driver to other architectures by only
>> selecting CONFIG_INDIRECT_PIO for ARM64, when we really want it.
>>
>> Signed-off-by: John Garry <john.garry@huawei.com>
>

Hi Arnd,

> Good idea, but doesn't this cause a link failure against
> logic_pio_register_range() when INDIRECT_PIO is disabled?

No, it shouldn't do. Function 
lib/logic_pio.c::logic_pio_register_range() is built always, outside any 
INDIRECT_PIO checking.

A some stage, for completeness we should probably change 
logic_pio_register_range() and friends to be under PCI_IOBASE. But then 
we would need stubs for !PCI_IOBASE, due to this above change and also 
references from the device tree code. I'd have to consider this a bit 
more. Let me know what you think.

Thanks,
John

>
>       Arnd
>
>


