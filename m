Return-Path: <SRS0=c662=XX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01504C4360C
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Sep 2019 03:08:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4BEC20872
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Sep 2019 03:08:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728488AbfI1DIn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 23:08:43 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:40124 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726673AbfI1DIm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 23:08:42 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 9C14E220DCCF11C7AA3F;
        Sat, 28 Sep 2019 11:08:40 +0800 (CST)
Received: from [127.0.0.1] (10.184.12.158) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Sat, 28 Sep 2019
 11:08:31 +0800
Subject: Re: [PATCH 24/35] irqchip/gic-v4.1: Add initial SGI configuration
From:   Zenghui Yu <yuzenghui@huawei.com>
To:     Marc Zyngier <maz@kernel.org>, <kvmarm@lists.cs.columbia.edu>,
        <linux-kernel@vger.kernel.org>
CC:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20190923182606.32100-1-maz@kernel.org>
 <20190923182606.32100-25-maz@kernel.org>
 <4ad002e2-1b3c-3420-98a5-0bedf067cfd9@huawei.com>
Message-ID: <c94061be-d029-69c8-d34f-4d21081d5aba@huawei.com>
Date:   Sat, 28 Sep 2019 11:07:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:64.0) Gecko/20100101
 Thunderbird/64.0
MIME-Version: 1.0
In-Reply-To: <4ad002e2-1b3c-3420-98a5-0bedf067cfd9@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.184.12.158]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/9/28 10:20, Zenghui Yu wrote:
> Hi Marc,
> 
> On 2019/9/24 2:25, Marc Zyngier wrote:
>> The GICv4.1 ITS has yet another new command (VSGI) which allows
>> a VPE-targeted SGI to be configured (or have its pending state
>> cleared). Add support for this command and plumb it into the
>> activate irqdomain callback so that it is ready to be used.
>>
>> Signed-off-by: Marc Zyngier <maz@kernel.org>
>> ---
>>   drivers/irqchip/irq-gic-v3-its.c   | 88 ++++++++++++++++++++++++++++++
>>   include/linux/irqchip/arm-gic-v3.h |  3 +-
>>   2 files changed, 90 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/irqchip/irq-gic-v3-its.c 
>> b/drivers/irqchip/irq-gic-v3-its.c
>> index 69c26be709be..5234b9eef8ad 100644
>> --- a/drivers/irqchip/irq-gic-v3-its.c
>> +++ b/drivers/irqchip/irq-gic-v3-its.c
> 
> [...]
> 
>> @@ -3574,6 +3628,38 @@ static struct irq_chip its_vpe_4_1_irq_chip = {
>>       .irq_set_vcpu_affinity    = its_vpe_4_1_set_vcpu_affinity,
>>   };
>> +static struct its_node *find_4_1_its(void)
>> +{
>> +    static struct its_node *its = NULL;
>> +
>> +    if (!its) {
>> +        list_for_each_entry(its, &its_nodes, entry) {
>> +            if (is_v4_1(its))
>> +                return its;
>> +        }
>> +
>> +        /* Oops? */
>> +        its = NULL;
>> +    }
>> +
>> +    return its;
>> +}
>> +
>> +static void its_configure_sgi(struct irq_data *d, bool clear)
>> +{
>> +    struct its_vpe *vpe = irq_data_get_irq_chip_data(d);
>> +    struct its_cmd_desc desc;
>> +
>> +    desc.its_vsgi_cmd.vpe = vpe;
>> +    desc.its_vsgi_cmd.sgi = d->hwirq;
>> +    desc.its_vsgi_cmd.priority = vpe->sgi_config[d->hwirq].priority;
>> +    desc.its_vsgi_cmd.enable = vpe->sgi_config[d->hwirq].enabled;
>> +    desc.its_vsgi_cmd.group = vpe->sgi_config[d->hwirq].group;
>> +    desc.its_vsgi_cmd.clear = clear;
>> +
>> +    its_send_single_vcommand(find_4_1_its(), its_build_vsgi_cmd, &desc);
> 
> I can't follow the logic in find_4_1_its().  We simply use the first ITS
> with GICv4.1 support, but what if the vPE is not mapped on this ITS?
> We will fail the valid_vpe() check when building this command and will
> have no effect on HW in the end?

I guess I find the answer in patch#31 ("Eagerly vmap vPEs").

I missed the important point in GICv4.1 that we have to map vPEs at all
times for VSGI delivery, and we currently choose to map vPEs on all ITSs
when requesting per vPE irq (instead of mapping them on demand, before
mapping VLPI, which could happen at a pretty late stage).
So it's OK to use the first GICv4.1 ITS when configuring VSGI for this
specified vPE, given that it is already mapped on all ITSs.


Thanks,
zenghui

