Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAF73C10F00
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 13:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3F4E218FF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 13:21:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728330AbfCUNVw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 09:21:52 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5169 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728049AbfCUNVw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 09:21:52 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 516952E2750DC0DBCDD2;
        Thu, 21 Mar 2019 21:21:49 +0800 (CST)
Received: from [127.0.0.1] (10.74.177.192) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.408.0; Thu, 21 Mar 2019
 21:21:41 +0800
Subject: Re: [PATCH] mbigen: don't clear eventid when free_irq
To:     Marc Zyngier <marc.zyngier@arm.com>
References: <D08D06C366851D40A251D08BEEAA0F9A04367BD6@dggeml529-mbx.china.huawei.com>
 <20190321091135.5574b496@why.wild-wind.fr.eu.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Liyou (leeyou, RTOS)" <leeyou.li@huawei.com>,
        "Joey Yan(Bo)" <joey.yanbo@huawei.com>,
        "Xiaowei (C)" <xiaowei774@huawei.com>,
        "zhanghan (Q)" <zhanghan23@huawei.com>,
        Yangyingliang <yangyingliang@huawei.com>,
        yaohongbo <yaohongbo@huawei.com>, Linuxarm <linuxarm@huawei.com>
From:   Chen Jianguo <chenjianguo3@huawei.com>
Message-ID: <e433c506-33ad-28ce-89f8-27d6897387d2@huawei.com>
Date:   Thu, 21 Mar 2019 21:21:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20190321091135.5574b496@why.wild-wind.fr.eu.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.74.177.192]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Marc
On 2019/3/21 17:11, Marc Zyngier wrote:
> On Sat, 16 Mar 2019 11:15:03 +0000
> chenjianguo <chenjianguo3@huawei.com> wrote:
>
>> From: Jianguo Chen <chenjianguo3@huawei.com>
>>
>> mbigen_write_msg clears eventid bits of a mbigen register
>> when free a interrupt, because msi_domain_deactivate memset
>> struct msg to zero. Then multiple mbigen pins with zero eventid
>> will report the same interrupt number.
>>
>> The eventid clear call trace:
>>                 free_irq
>>                 __free_irq
>>                 irq_shutdown
>>                 irq_domain_deactivate_irq
>>                 __irq_domain_deactivate_irq
>>                 __irq_domain_deactivate_irq
>>                 msi_domain_deactivate
>>                 platform_msi_write_msg
>>                 mbigen_write_msg
>>
>> Signed-off-by: Jianguo Chen <chenjianguo3@huawei.com>
>> ---
>>   drivers/irqchip/irq-mbigen.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/irqchip/irq-mbigen.c b/drivers/irqchip/irq-mbigen.c
>> index 567b29c..fad7291 100644
>> --- a/drivers/irqchip/irq-mbigen.c
>> +++ b/drivers/irqchip/irq-mbigen.c
>> @@ -161,6 +161,9 @@ static void mbigen_write_msg(struct msi_desc *desc,
>> struct msi_msg *msg)
>>         void __iomem *base = d->chip_data;
>>         u32 val;
>>
>> +       if (!msg->address_lo && !msg->address_hi)
>> +               return;
>> +
>>         base += get_mbigen_vec_reg(d->hwirq);
>>         val = readl_relaxed(base);
>>
>
> For whatever reason, I couldn't apply this patch (even when fishing a
> copy of this email from the archives). It seems to be corrupted is
> various ways, so I had to write the patch from scratch, which is not the
> most reliable way to work. Good thing this was something trivial, I
> wouldn't do it for something more complicated.
>
> In the future, please make sure to use 'git send-email' to send your
> patches, as it is known to work correctly.
>
> Thanks,
>
> 	M.
>

  Mbigen vector register and pin structure shows as below:

	event id       0      1     2          127
    vector register    reg0  reg1  reg2       reg127
			|     |     |           |
	  MBIGEN	pin0  pin1  pin2  ...  pin127
         		|-----|-----|-----|-----|
			|     |     |     |     |
       device interrupt num0 num1  num2       num127

Suppose a device driver requested irq num0 and num1 at the beginning, 
and for some reason it freed irq num1, mbigen_write_msg will write reg1 
with event id 0. Then the pin1 probably mistakenly report interrupt num0 
to device driver if there is a signal on the pin.


	event id       0      0     2          127
    vector register    reg0  reg1  reg2       reg127
			|     |     |           |
	  MBIGEN	pin0  pin1  pin2  ...  pin127
         		|-----|-----|-----|-----|
			|     |     |     |     |
	device interrup num0 num1  num2       num127		

Thanks,
	Jianguo Chen

