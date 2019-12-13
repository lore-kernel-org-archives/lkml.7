Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE074C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 10:07:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB6102073D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 10:07:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbfLMKHZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 05:07:25 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2184 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725747AbfLMKHZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 05:07:25 -0500
Received: from lhreml706-cah.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 80148902FA778704197D;
        Fri, 13 Dec 2019 10:07:23 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 lhreml706-cah.china.huawei.com (10.201.108.47) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 13 Dec 2019 10:07:22 +0000
Received: from [127.0.0.1] (10.202.226.46) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 13 Dec
 2019 10:07:22 +0000
Subject: Re: [PATCH RFC 1/1] genirq: Make threaded handler use irq affinity
 for managed interrupt
From:   John Garry <john.garry@huawei.com>
To:     Marc Zyngier <maz@kernel.org>
CC:     Ming Lei <ming.lei@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "chenxiang (M)" <chenxiang66@hisilicon.com>,
        "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hare@suse.com" <hare@suse.com>, "hch@lst.de" <hch@lst.de>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>
References: <1575642904-58295-1-git-send-email-john.garry@huawei.com>
 <1575642904-58295-2-git-send-email-john.garry@huawei.com>
 <20191207080335.GA6077@ming.t460p>
 <78a10958-fdc9-0576-0c39-6079b9749d39@huawei.com>
 <20191210014335.GA25022@ming.t460p>
 <28424a58-1159-c3f9-1efb-f1366993afcf@huawei.com>
 <048746c22898849d28985c0f65cf2c2a@www.loen.fr>
 <ce1b93c6-8ff9-6106-84af-909ec52d49e5@huawei.com>
 <6e513d25d8b0c6b95d37a64df0c27b78@www.loen.fr>
 <06d1e2ff-9ec7-2262-25a0-4503cb204b0b@huawei.com>
 <5caa8414415ab35e74662ac0a30bb4ac@www.loen.fr>
 <f58c3ae0-9807-bea8-4570-28d975336090@huawei.com>
Message-ID: <2443e657-2ccd-bf85-072c-284ea0b3ce40@huawei.com>
Date:   Fri, 13 Dec 2019 10:07:21 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <f58c3ae0-9807-bea8-4570-28d975336090@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.202.226.46]
X-ClientProxiedBy: lhreml728-chm.china.huawei.com (10.201.108.79) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/12/2019 09:41, John Garry wrote:
> On 10/12/2019 18:32, Marc Zyngier wrote:
>>>>> The ITS code will make the lowest online CPU in the affinity mask
>>>>> the
>>>>> target CPU for the interrupt, which may result in some CPUs
>>>>> handling
>>>>> so many interrupts.
>>>> If what you want is for the*default*  affinity to be spread around,
>>>> that should be achieved pretty easily. Let me have a think about how
>>>> to do that.
>>> Cool, I anticipate that it should help my case.
>>>
>>> I can also seek out some NVMe cards to see how it would help a more
>>> "generic" scenario.
>> Can you give the following a go? It probably has all kind of warts on
>> top of the quality debug information, but I managed to get my D05 and
>> a couple of guests to boot with it. It will probably eat your data,
>> so use caution!;-)
>>
> 
> Hi Marc,
> 
> Ok, we'll give it a spin.
> 
> Thanks,
> John

Hi Marc,

JFYI, we're still testing this and the patch itself seems to work as 
intended.

Here's the kernel log if you just want to see how the interrupts are 
getting assigned:
https://pastebin.com/hh3r810g

For me, I did get a performance boost for NVMe testing, but my colleague 
Xiang Chen saw a drop for our storage test of interest  - that's the 
HiSi SAS controller. We're trying to make sense of it now.

Thanks,
John

> 
>> Thanks,
>>
>>           M.
>>
>> diff --git a/drivers/irqchip/irq-gic-v3-its.c
>> b/drivers/irqchip/irq-gic-v3-its.c
>> index e05673bcd52b..301ee3bc0602 100644
>> --- a/drivers/irqchip/irq-gic-v3-its.c
>> +++ b/drivers/irqchip/irq-gic-v3-its.c
>> @@ -177,6 +177,8 @@ static DEFINE_IDA(its_vpeid_ida);
> 

