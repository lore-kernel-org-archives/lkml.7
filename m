Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DD15C43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 16:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 450F2206DF
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 16:16:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbfLFQQl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 11:16:41 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2162 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726261AbfLFQQk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 11:16:40 -0500
Received: from lhreml701-cah.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 5BC419C4375195B38833;
        Fri,  6 Dec 2019 16:16:38 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 lhreml701-cah.china.huawei.com (10.201.108.42) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 6 Dec 2019 16:16:38 +0000
Received: from [127.0.0.1] (10.202.226.46) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5; Fri, 6 Dec 2019
 16:16:37 +0000
Subject: Re: [PATCH RFC 1/1] genirq: Make threaded handler use irq affinity
 for managed interrupt
To:     Marc Zyngier <maz@kernel.org>
CC:     <tglx@linutronix.de>, <chenxiang66@hisilicon.com>,
        <bigeasy@linutronix.de>, <linux-kernel@vger.kernel.org>,
        <hare@suse.com>, <ming.lei@redhat.com>, <hch@lst.de>,
        <axboe@kernel.dk>, <bvanassche@acm.org>, <peterz@infradead.org>,
        <mingo@redhat.com>
References: <1575642904-58295-1-git-send-email-john.garry@huawei.com>
 <1575642904-58295-2-git-send-email-john.garry@huawei.com>
 <e44ca3b9684277bb6659b2676ef72ad8@www.loen.fr>
From:   John Garry <john.garry@huawei.com>
Message-ID: <6a004f9d-bcfd-378c-8b62-051e1f4e09b4@huawei.com>
Date:   Fri, 6 Dec 2019 16:16:36 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <e44ca3b9684277bb6659b2676ef72ad8@www.loen.fr>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.202.226.46]
X-ClientProxiedBy: lhreml702-chm.china.huawei.com (10.201.108.51) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/12/2019 15:22, Marc Zyngier wrote:

Hi Marc,

> 
> On 2019-12-06 14:35, John Garry wrote:
>> Currently the cpu allowed mask for the threaded part of a threaded irq
>> handler will be set to the effective affinity of the hard irq.
>>
>> Typically the effective affinity of the hard irq will be for a single
>> cpu. As such,
>> the threaded handler would always run on the same cpu as the hard irq.
>>
>> We have seen scenarios in high data-rate throughput testing that the cpu
>> handling the interrupt can be totally saturated handling both the hard
>> interrupt and threaded handler parts, limiting throughput.
>>
>> For when the interrupt is managed, allow the threaded part to run on all
>> cpus in the irq affinity mask.
>>
>> Signed-off-by: John Garry <john.garry@huawei.com>
>> ---
>>  kernel/irq/manage.c | 6 +++++-
>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
>> index 1753486b440c..8e7f8e758a88 100644
>> --- a/kernel/irq/manage.c
>> +++ b/kernel/irq/manage.c
>> @@ -968,7 +968,11 @@ irq_thread_check_affinity(struct irq_desc *desc,
>> struct irqaction *action)
>>      if (cpumask_available(desc->irq_common_data.affinity)) {
>>          const struct cpumask *m;
>>
>> -        m = irq_data_get_effective_affinity_mask(&desc->irq_data);
>> +        if (irqd_affinity_is_managed(&desc->irq_data))
>> +            m = desc->irq_common_data.affinity;
>> +        else
>> +            m = irq_data_get_effective_affinity_mask(
>> +                    &desc->irq_data);
>>          cpumask_copy(mask, m);
>>      } else {
>>          valid = false;
> 
> Although I completely understand that there are cases where you
> really want to let your thread roam all CPUs, I feel like changing
> this based on a seemingly unrelated property is likely to trigger
> yet another whack-a-mole episode. I'd feel much more comfortable
> if there was a way to let the IRQ subsystem know about what is best.
> 
> Shouldn't the endpoint driver know better about it? 

I did propose that same idea here:
https://lore.kernel.org/lkml/fd7d6101-37f4-2d34-f2f7-cfeade610278@huawei.com/

And that fits my agenda to get best throughput figures, while not 
possibly affecting others.

But it seems that we could do better to make this a common policy: allow 
the threaded part to roam when that CPU is overloaded, but how...?

Note that
> I have no data supporting an approach or the other, hence playing
> the role of the village idiot here.
> 

Understood. My data is that we get an ~11% throughput boost for our 
storage test with this change.

> Thanks,
> 
>          M.

Thanks,
John
