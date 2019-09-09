Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80624C433EF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 10:18:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 548FF21920
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 10:18:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="IvjpG6Bo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390460AbfIIKSi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 06:18:38 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:15689 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390297AbfIIKSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 06:18:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1568024316; x=1599560316;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=PftOWRoYjF16gzp8Wil4H6jd2iHitkZNVA6hQVM9wzQ=;
  b=IvjpG6Boe/cGwYPyNAyMGZvjw2a60ZIkPjGH/sQQHQb6g/l5hyCTOqqC
   FsM9zLb3SQuxWFrDiH4W6JWzWHrZZvrp9T+6iMS55rk6AMLb+z8GgLGw9
   b3b4jree6pJsboJa4x9jZu90pXyoyxkcCk2jmC40vZJfywe+2yEqPMItk
   Q=;
X-IronPort-AV: E=Sophos;i="5.64,484,1559520000"; 
   d="scan'208";a="420172978"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2b-859fe132.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 09 Sep 2019 10:18:33 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2b-859fe132.us-west-2.amazon.com (Postfix) with ESMTPS id 4E97E221E48;
        Mon,  9 Sep 2019 10:18:32 +0000 (UTC)
Received: from EX13D01EUB001.ant.amazon.com (10.43.166.194) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 9 Sep 2019 10:18:31 +0000
Received: from [10.125.238.52] (10.43.161.217) by EX13D01EUB001.ant.amazon.com
 (10.43.166.194) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Mon, 9 Sep
 2019 10:18:26 +0000
Subject: Re: [UNVERIFIED SENDER] Re: [PATCH 1/1] irqchip: al-fic: add support
 for irq retrigger
To:     Marc Zyngier <maz@kernel.org>
CC:     <tglx@linutronix.de>, <jason@lakedaemon.net>,
        <linux-kernel@vger.kernel.org>, <dwmw@amazon.co.uk>,
        <benh@kernel.crashing.org>, <hhhawa@amazon.com>,
        <ronenk@amazon.com>, <jonnyc@amazon.com>, <hanochu@amazon.com>,
        <barakw@amazon.com>
References: <1568018358-18985-1-git-send-email-talel@amazon.com>
 <86d0g9st7m.wl-maz@kernel.org>
From:   "Shenhar, Talel" <talel@amazon.com>
Message-ID: <3efe33a5-3ddb-aa77-8a62-bd011ae23110@amazon.com>
Date:   Mon, 9 Sep 2019 13:18:21 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <86d0g9st7m.wl-maz@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.43.161.217]
X-ClientProxiedBy: EX13D07UWB003.ant.amazon.com (10.43.161.66) To
 EX13D01EUB001.ant.amazon.com (10.43.166.194)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/9/2019 12:40 PM, Marc Zyngier wrote:
> On Mon, 09 Sep 2019 09:39:18 +0100,
> Talel Shenhar <talel@amazon.com> wrote:
>
> Hi Talel,
>
>> Introduce interrupts retrigger support for Amazon's Annapurna Labs Fabric
>> Interrupt Controller.
>>
>> Signed-off-by: Talel Shenhar <talel@amazon.com>
>> ---
>>   drivers/irqchip/irq-al-fic.c | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/drivers/irqchip/irq-al-fic.c b/drivers/irqchip/irq-al-fic.c
>> index 1a57cee..0b0a737 100644
>> --- a/drivers/irqchip/irq-al-fic.c
>> +++ b/drivers/irqchip/irq-al-fic.c
>> @@ -15,6 +15,7 @@
>>   
>>   /* FIC Registers */
>>   #define AL_FIC_CAUSE		0x00
>> +#define AL_FIC_SET_CAUSE	0x08
>>   #define AL_FIC_MASK		0x10
>>   #define AL_FIC_CONTROL		0x28
>>   
>> @@ -126,6 +127,16 @@ static void al_fic_irq_handler(struct irq_desc *desc)
>>   	chained_irq_exit(irqchip, desc);
>>   }
>>   
>> +static int al_fic_irq_retrigger(struct irq_data *data)
>> +{
>> +	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(data);
>> +	struct al_fic *fic = gc->private;
>> +
>> +	writel_relaxed(BIT(data->hwirq), fic->base + AL_FIC_SET_CAUSE);
>> +
>> +	return 1;
>> +}
>> +
>>   static int al_fic_register(struct device_node *node,
>>   			   struct al_fic *fic)
>>   {
>> @@ -159,6 +170,7 @@ static int al_fic_register(struct device_node *node,
>>   	gc->chip_types->chip.irq_unmask = irq_gc_mask_clr_bit;
>>   	gc->chip_types->chip.irq_ack = irq_gc_ack_clr_bit;
>>   	gc->chip_types->chip.irq_set_type = al_fic_irq_set_type;
>> +	gc->chip_types->chip.irq_retrigger = al_fic_irq_retrigger;
>>   	gc->chip_types->chip.flags = IRQCHIP_SKIP_SET_WAKE;
>>   	gc->private = fic;
> Looks good to me. Is this a fix or a new feature? If the former, I can
> queue it up for -rc1.
>
> 	M.

This is an enhancement to the merged al-fic driver. queuing it up sounds 
good.

Thanks Marc!


