Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 751F3C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 15:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F4B421655
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 15:38:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727491AbfLTPib (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 10:38:31 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2212 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726808AbfLTPib (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 10:38:31 -0500
Received: from lhreml702-cah.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 5D4369A1CA2D908B3AD6;
        Fri, 20 Dec 2019 15:38:29 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 lhreml702-cah.china.huawei.com (10.201.108.43) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 20 Dec 2019 15:38:28 +0000
Received: from [127.0.0.1] (10.210.166.34) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5; Fri, 20 Dec
 2019 15:38:27 +0000
Subject: Re: [PATCH RFC 1/1] genirq: Make threaded handler use irq affinity
 for managed interrupt
To:     Marc Zyngier <maz@kernel.org>
CC:     Ming Lei <ming.lei@redhat.com>, <tglx@linutronix.de>,
        "chenxiang (M)" <chenxiang66@hisilicon.com>,
        <bigeasy@linutronix.de>, <linux-kernel@vger.kernel.org>,
        <hare@suse.com>, <hch@lst.de>, <axboe@kernel.dk>,
        <bvanassche@acm.org>, <peterz@infradead.org>, <mingo@redhat.com>
References: <1575642904-58295-1-git-send-email-john.garry@huawei.com>
 <1575642904-58295-2-git-send-email-john.garry@huawei.com>
 <20191207080335.GA6077@ming.t460p>
 <78a10958-fdc9-0576-0c39-6079b9749d39@huawei.com>
 <20191210014335.GA25022@ming.t460p>
 <0ad37515-c22d-6857-65a2-cc28256a8afa@huawei.com>
 <20191212223805.GA24463@ming.t460p>
 <d4b89ecf-7ced-d5d6-fc02-6d4257580465@huawei.com>
 <20191213131822.GA19876@ming.t460p>
 <b7f3bcea-84ec-f9f6-a3aa-007ae712415f@huawei.com>
 <20191214135641.5a817512@why>
 <7db89b97-1b9e-8dd1-684a-3eef1b1af244@huawei.com>
 <50d9ba606e1e3ee1665a0328ffac67ac@www.loen.fr>
 <a5f6a542-2dbc-62de-52e2-bd5413b5db51@huawei.com>
 <68058fd28c939b8e065524715494de95@www.loen.fr>
 <ac5b5a25-df2e-18e9-6b0f-60af8c7cec3b@huawei.com>
 <687cbcc4-89d9-63ea-a246-ce2abaae501a@huawei.com>
 <0fd543f8ffd90f90deb691aea1c275b4@www.loen.fr>
From:   John Garry <john.garry@huawei.com>
Message-ID: <a5154365-59c5-429b-559e-94ad6dffcdb0@huawei.com>
Date:   Fri, 20 Dec 2019 15:38:24 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <0fd543f8ffd90f90deb691aea1c275b4@www.loen.fr>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.166.34]
X-ClientProxiedBy: lhreml703-chm.china.huawei.com (10.201.108.52) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> We've got some more results and it looks promising.
>>
>> So with your patch we get a performance boost of 3180.1K -> 3294.9K
>> IOPS in the D06 SAS env. Then when we change the driver to use
>> threaded interrupt handler (mainline currently uses tasklet), we get a
>> boost again up to 3415K IOPS.
>>
>> Now this is essentially the same figure we had with using threaded
>> handler + the gen irq change in spreading the handler CPU affinity. We
>> did also test your patch + gen irq change and got a performance drop,
>> to 3347K IOPS.
>>
>> So tentatively I'd say your patch may be all we need.
> 
> OK.
> 
>> FYI, here is how the effective affinity is looking for both SAS
>> controllers with your patch:
>>
>> 74:02.0
>> irq 81, cpu list 24-29, effective list 24 cq
>> irq 82, cpu list 30-35, effective list 30 cq
> 
> Cool.
> 
> [...]
> 
>> As for your patch itself, I'm still concerned of possible regressions
>> if we don't apply this effective interrupt affinity spread policy to
>> only managed interrupts.
> 
> I'll try and revise that as I post the patch, probably at some point
> between now and Christmas. I still think we should find a way to
> address this for the D05 SAS driver though, maybe by managing the
> affinity yourself in the driver. But this requires experimentation.

I've already done something experimental for the driver to manage the 
affinity, and performance is generally much better:

https://github.com/hisilicon/kernel-dev/commit/e15bd404ed1086fed44da34ed3bd37a8433688a7

But I still think it's wise to only consider managed interrupts for now.

> 
>> JFYI, about NVMe CPU lockup issue, there are 2 works on going here:
>>
>> https://lore.kernel.org/linux-nvme/20191209175622.1964-1-kbusch@kernel.org/T/#t 
>>
>>
>> https://lore.kernel.org/linux-block/20191218071942.22336-1-ming.lei@redhat.com/T/#t 
>>
> 
> I've also managed to trigger some of them now that I have access to
> a decent box with nvme storage. 

I only have 2x NVMe SSDs when this occurs - I should not be hitting this...

Out of curiosity, have you tried
> with the SMMU disabled? I'm wondering whether we hit some livelock
> condition on unmapping buffers...

No, but I can give it a try. Doing that should lower the CPU usage, 
though, so maybe masks the issue - probably not.

Much appreciated,
John
