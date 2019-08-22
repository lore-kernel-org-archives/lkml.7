Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6672C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 16:32:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7067A23400
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 16:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566491556;
	bh=I04z+ddymY5cY5iHreAhwy1C27cr7ZlQmFoupVvJDAM=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=Pku63Aqp1132HiZPRH6UC0uyppr9Md5Iq3tdBSPQVbtdpvASbirJhjoe6O/JTTsoH
	 28PigYZXp0A7igiUg9UiFMNKWaVOQ5zyagW8aDoRfO3lg818SzL0kPU0euh7KyqzK4
	 qLex0YyNX0pw6Xl/eBZvVr2Lsz2OpnoG6FfO6FsE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389984AbfHVQcf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 12:32:35 -0400
Received: from foss.arm.com ([217.140.110.172]:48772 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728591AbfHVQcd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 12:32:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A7AFD28;
        Thu, 22 Aug 2019 09:32:32 -0700 (PDT)
Received: from [10.1.197.61] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 877293F718;
        Thu, 22 Aug 2019 09:32:31 -0700 (PDT)
Subject: Re: [PATCH v2 05/12] irqchip/gic: Prepare for more than 16 PPIs
To:     Julien <julien.thierry.kdev@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Rob Herring <robh+dt@kernel.org>
Cc:     John Garry <john.garry@huawei.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20190806100121.240767-1-maz@kernel.org>
 <20190806100121.240767-6-maz@kernel.org>
 <1b2675f6-f839-80f8-b7d8-a7d402085745@gmail.com>
From:   Marc Zyngier <maz@kernel.org>
Organization: Approximate
Message-ID: <ccd1a1f2-d1a5-4f35-eb5e-ba5acd33e3ea@kernel.org>
Date:   Thu, 22 Aug 2019 17:32:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1b2675f6-f839-80f8-b7d8-a7d402085745@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Julien,

On 22/08/2019 17:11, Julien wrote:
> Hi Marc,
> 
> On 06/08/19 11:01, Marc Zyngier wrote:
>> GICv3.1 allows up to 80 PPIs (16 legaci PPIs and 64 Extended PPIs),
>> meaning we can't just leave the old 16 hardcoded everywhere.
>>
>> We also need to add the infrastructure to discover the number of PPIs
>> on a per redistributor basis, although we still pretend there is only
>> 16 of them for now.
>>
>> No functional change.
>>
>> Signed-off-by: Marc Zyngier <maz@kernel.org>
>> ---
>>   drivers/irqchip/irq-gic-common.c | 19 ++++++++++++-------
>>   drivers/irqchip/irq-gic-common.h |  2 +-
>>   drivers/irqchip/irq-gic-v3.c     | 22 +++++++++++++++-------
>>   drivers/irqchip/irq-gic.c        |  2 +-
>>   drivers/irqchip/irq-hip04.c      |  2 +-
>>   5 files changed, 30 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/irqchip/irq-gic-common.c b/drivers/irqchip/irq-gic-common.c
>> index 6900b6f0921c..14110db01c05 100644
>> --- a/drivers/irqchip/irq-gic-common.c
>> +++ b/drivers/irqchip/irq-gic-common.c
>> @@ -128,26 +128,31 @@ void gic_dist_config(void __iomem *base, int gic_irqs,
>>   		sync_access();
>>   }
>>   
>> -void gic_cpu_config(void __iomem *base, void (*sync_access)(void))
>> +void gic_cpu_config(void __iomem *base, int nr, void (*sync_access)(void))
>>   {
>>   	int i;
>>   
>>   	/*
>>   	 * Deal with the banked PPI and SGI interrupts - disable all
>> -	 * PPI interrupts, ensure all SGI interrupts are enabled.
>> -	 * Make sure everything is deactivated.
>> +	 * private interrupts. Make sure everything is deactivated.
>>   	 */
>> -	writel_relaxed(GICD_INT_EN_CLR_X32, base + GIC_DIST_ACTIVE_CLEAR);
>> -	writel_relaxed(GICD_INT_EN_CLR_PPI, base + GIC_DIST_ENABLE_CLEAR);
>> -	writel_relaxed(GICD_INT_EN_SET_SGI, base + GIC_DIST_ENABLE_SET);
>> +	for (i = 0; i < nr; i += 32) {
> 
> You added "nr" as argument but if "nr" isn't a multiple of 32 weird 
> things might happen, no?
>
> It would be worth specifying that somewhere, and checking it with a WARN().

TBH, I'm unsure whether that's worth it. The architecture is completely
built around having the private interrupts in blocks of 32, and you can
only get something wrong if you misdecode the number of interrupts from
the registers.

> Maybe it might be worth reducing the granularity to manipulating 16 irqs 
> since there are 16 SGI + 16 PPI + 64 EPPI, but that might not be very 
> useful right now.

I don't see what this brings us at this point. The architecture doesn't
seem to go in the direction of adding more SGIs, so we're pretty safe on
that front...

Thanks,

	M.
-- 
Jazz is not dead, it just smells funny...
