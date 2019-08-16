Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 537F0C3A59E
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 08:41:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3596C205C9
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 08:41:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbfHPIlw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 04:41:52 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:57554 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726810AbfHPIlv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 04:41:51 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 15731BB44AE410066264;
        Fri, 16 Aug 2019 16:41:50 +0800 (CST)
Received: from [127.0.0.1] (10.57.101.250) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Fri, 16 Aug 2019
 16:41:40 +0800
Subject: Re: [PATCH] gpio: pl061: Fix the issue failed to register the ACPI
 interruption
To:     Linus Walleij <linus.walleij@linaro.org>
References: <5D514D6F.4090904@hisilicon.com>
 <CACRpkdbi21mV5quTmur6egb6FJMFrD-Lg1EUKtk+HejyWjzmUA@mail.gmail.com>
CC:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linuxarm <linuxarm@huawei.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        "Jonathan Cameron" <jonathan.cameron@huawei.com>,
        John Garry <john.garry@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        Shiju Jose <shiju.jose@huawei.com>, <jinying@hisilicon.com>,
        Zhangyi ac <zhangyi.ac@huawei.com>,
        "Liguozhu (Kenneth)" <liguozhu@hisilicon.com>,
        Tangkunshan <tangkunshan@huawei.com>,
        huangdaode <huangdaode@hisilicon.com>
From:   Wei Xu <xuwei5@hisilicon.com>
Message-ID: <5D566C44.5080106@hisilicon.com>
Date:   Fri, 16 Aug 2019 16:41:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
MIME-Version: 1.0
In-Reply-To: <CACRpkdbi21mV5quTmur6egb6FJMFrD-Lg1EUKtk+HejyWjzmUA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.57.101.250]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On 2019/8/14 17:04, Linus Walleij wrote:
> Hi Wei,
>
> thanks for your patch!
>
> This doesn't apply for my "devel" branch, can you rebase
> on this:
> https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git/log/?h=devel
>
> We have moved some ACPI headers around recently.

Thanks to review!
I just sent out the v2 based on that.

> On Mon, Aug 12, 2019 at 1:28 PM Wei Xu <xuwei5@hisilicon.com> wrote:
>
>> Invoke acpi_gpiochip_request_interrupts after the acpi data has been
>> attached to the pl061 acpi node to register interruption.
> Makes sense.
>
>> Fixes: 04ce935c6b2a ("gpio: pl061: Pass irqchip when adding gpiochip")
> I doubt this is a regression since I haven't seen anyone use this
> gpiochip with ACPI before.
>
> Please rename the patch "gpio: pl061: Add ACPI support" unless
> you can convince me it worked without changes before.

In the v2, I attached the log on QEMU v3.0.0 and Linux kernel v5.2.0-rc7 
and
the pl061 driver can register ACPI interruption.
Based on that, I did not rename the patch but I am OK to rename it if 
you have
any doubt.

> Please include some ACPI people on review of this. From
> MAINTAINERS:
> ACPI
> M:      "Rafael J. Wysocki" <rjw@rjwysocki.net>
> M:      Len Brown <lenb@kernel.org>
> L:      linux-acpi@vger.kernel.org
>
> I would also include Andy Shevchenko and Mika Westerberg for
> the GPIO aspects.
Copied to all of them in the v2.
Thanks!

Best Regards,
Wei

> Thanks!
> Linus Walleij
>
> .
>


