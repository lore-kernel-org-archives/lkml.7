Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0AD4C31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 09:08:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3B87206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 09:08:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729428AbfFRJIU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 05:08:20 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:18596 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728797AbfFRJIT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 05:08:19 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id E66459F3784AAA894D4A;
        Tue, 18 Jun 2019 17:08:17 +0800 (CST)
Received: from [127.0.0.1] (10.133.217.137) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Tue, 18 Jun 2019
 17:08:10 +0800
Subject: Re: [PATCH] irqchip/mbigen: stop printing kernel addresses
To:     Marc Zyngier <marc.zyngier@arm.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        <linux-kernel@vger.kernel.org>, <guohanjun@huawei.com>
References: <20190618032202.11087-1-wangkefeng.wang@huawei.com>
 <86h88npc47.wl-marc.zyngier@arm.com>
 <d529faf2-9edd-8362-c208-fd1902d539e7@huawei.com>
 <209f546b-8da2-982d-2f37-258da556f45c@arm.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
Message-ID: <26dccbb9-59b0-3e77-5bec-ac1719962135@huawei.com>
Date:   Tue, 18 Jun 2019 17:08:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <209f546b-8da2-982d-2f37-258da556f45c@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.217.137]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/6/18 16:42, Marc Zyngier wrote:
> On 18/06/2019 09:35, Kefeng Wang wrote:
>>
>>
>> On 2019/6/18 15:48, Marc Zyngier wrote:
>>> Hi Kefeng,
>>>
>>> On Tue, 18 Jun 2019 04:22:02 +0100,
>>> Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>>>>
>>>> After commit ad67b74d2469d9b8 ("printk: hash addresses printed with %p"),
>>>> it will print "____ptrval____" instead of actual addresses when mbigen
>>>> create domain fails,
>>>>
>>>>   Hisilicon MBIGEN-V2 HISI0152:00: Failed to create mbi-gen@(____ptrval____) irqdomain
>>>>   Hisilicon MBIGEN-V2: probe of HISI0152:00 failed with error -12
>>>>
>>>> Instead of changing the print to "%px", and leaking kernel addresses,
>>>> just remove the print completely.
>>>>
>>>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>>>> ---
>>>>  drivers/irqchip/irq-mbigen.c | 3 +--
>>>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/irqchip/irq-mbigen.c b/drivers/irqchip/irq-mbigen.c
>>>> index 98b6e1d4b1a6..d0cf596c801b 100644
>>>> --- a/drivers/irqchip/irq-mbigen.c
>>>> +++ b/drivers/irqchip/irq-mbigen.c
>>>> @@ -355,8 +355,7 @@ static int mbigen_device_probe(struct platform_device *pdev)
>>>>  		err = -EINVAL;
>>>>  
>>>>  	if (err) {
>>>> -		dev_err(&pdev->dev, "Failed to create mbi-gen@%p irqdomain",
>>>> -			mgn_chip->base);
>>>> +		dev_err(&pdev->dev, "Failed to create mbi-gen irqdomain");
>>>
>>> The alternative would be to print res as a resource, which would still
>>> help identifying the offending device by printing its physical
>>> layout, and still not reveal much.
>>
>> It's better to print res to show the physical layout, and add missing "\n",
>> will resend v2.
> 
> As Hanjun mentioned in a separate email, pdev->dev seems to be enough to
> identify which MBIGEN has failed to probe. So maybe all you need to do
> is to add the missing '\n', and tidy up the commit message to reflect that.

OK, done in v2.

> 
> Thanks,
> 
> 	M.
> 

