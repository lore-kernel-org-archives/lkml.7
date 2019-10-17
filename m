Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 854DAECE58E
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 09:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58BE320869
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 09:24:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405351AbfJQJYM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 05:24:12 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4238 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733031AbfJQJYL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 05:24:11 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 2190D78F2197008800FB;
        Thu, 17 Oct 2019 17:24:10 +0800 (CST)
Received: from [127.0.0.1] (10.133.213.239) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Thu, 17 Oct 2019
 17:24:03 +0800
Subject: =?UTF-8?B?UmU6IOetlOWkjTogW1BBVENIXSB1c2UgZGV2bV9wbGF0Zm9ybV9pb3Jl?=
 =?UTF-8?Q?map=5fresource=28=29_for_irqchip_drivers?=
To:     huangdaode <huangdaode@hisilicon.com>,
        Marc Zyngier <maz@kernel.org>
References: <1571296423-208359-1-git-send-email-huangdaode@hisilicon.com>
 <9bbcce19c777583815c92ce3c2ff2586@www.loen.fr>
 <E20AE017F0DBA04DA661272787510F9813D297B0@DGGEMM527-MBX.china.huawei.com>
CC:     "jason@lakedaemon.net" <jason@lakedaemon.net>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
        "sebastian.hesselbarth@gmail.com" <sebastian.hesselbarth@gmail.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        "alexandre.torgue@st.com" <alexandre.torgue@st.com>,
        "nm@ti.com" <nm@ti.com>, "t-kristo@ti.com" <t-kristo@ti.com>,
        "ssantosh@kernel.org" <ssantosh@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>
From:   Yuehaibing <yuehaibing@huawei.com>
Message-ID: <3a98da01-4f69-2624-e49f-5e2316c433e0@huawei.com>
Date:   Thu, 17 Oct 2019 17:24:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <E20AE017F0DBA04DA661272787510F9813D297B0@DGGEMM527-MBX.china.huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/10/17 17:20, huangdaode wrote:
> Hi Marc
> I am just doing the coccicheck using the command "make coccicheck M=drivers/irqchip/", and it report 
> $ make coccicheck M=drivers/irqchip/
> .......
> drivers/irqchip//irq-mvebu-icu.c:361:1-10: WARNING: Use devm_platform_ioremap_resource for icu -> base
> drivers/irqchip//irq-ts4800.c:105:1-11: WARNING: Use devm_platform_ioremap_resource for data -> base
> drivers/irqchip//irq-mvebu-pic.c:134:1-10: WARNING: Use devm_platform_ioremap_resource for pic -> base
> drivers/irqchip//irq-ti-sci-inta.c:571:1-11: WARNING: Use devm_platform_ioremap_resource for inta -> base
> drivers/irqchip//irq-stm32-exti.c:853:1-16: WARNING: Use devm_platform_ioremap_resource for host_data -> base
> 
> so just fix the WARNING. 
> 
> And after  apply the patch, I do the compile, it's OK, but I lack of hardware to test it. 
> That's the case. 
> 
> MBR.
> Thanks
> 
> -----邮件原件-----
> 发件人: Marc Zyngier [mailto:maz@kernel.org] 
> 发送时间: 2019年10月17日 16:24
> 收件人: huangdaode <huangdaode@hisilicon.com>
> 抄送: jason@lakedaemon.net; andrew@lunn.ch; gregory.clement@bootlin.com; sebastian.hesselbarth@gmail.com; tglx@linutronix.de; mcoquelin.stm32@gmail.com; alexandre.torgue@st.com; nm@ti.com; t-kristo@ti.com; ssantosh@kernel.org; linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org; linux-stm32@st-md-mailman.stormreply.com
> 主题: Re: [PATCH] use devm_platform_ioremap_resource() for irqchip drivers
> 
> On 2019-10-17 08:13, Daode Huang wrote:
>> From: Daode Huang <huangdaode@hislicon.com>
>>
>> Use the new helper that wraps the calls to platform_get_resource() and 
>> devm_ioremap_resource() together
>>
>> Signed-off-by: Daode Huang <huangdaode@hislicon.com>
>> ---
>>  drivers/irqchip/irq-mvebu-icu.c   | 3 +--
>>  drivers/irqchip/irq-mvebu-pic.c   | 3 +--
>>  drivers/irqchip/irq-stm32-exti.c  | 3 +--  
>> drivers/irqchip/irq-ti-sci-inta.c | 3 +--
>>  drivers/irqchip/irq-ts4800.c      | 3 +--
>>  5 files changed, 5 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/irqchip/irq-mvebu-icu.c 
>> b/drivers/irqchip/irq-mvebu-icu.c index 547045d..ddf9b0d 100644
>> --- a/drivers/irqchip/irq-mvebu-icu.c
>> +++ b/drivers/irqchip/irq-mvebu-icu.c
>> @@ -357,8 +357,7 @@ static int mvebu_icu_probe(struct platform_device
>> *pdev)
>>
>>  	icu->dev = &pdev->dev;
>>
>> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> -	icu->base = devm_ioremap_resource(&pdev->dev, res);
>> +	icu->base = devm_platform_ioremap_resource(pdev, res);

It should be :

+	icu->base = devm_platform_ioremap_resource(pdev, 0);

> 
> void __iomem *devm_platform_ioremap_resource(struct platform_device *pdev,
>                                               unsigned int index)
> 
> What could possibly go wrong? I'd suggest you start compiling (and possibly
> testing) the code you change before sending patches...
> 
>          M.
> --
> Jazz is not dead. It just smells funny...
> 

