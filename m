Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA989C2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 11:35:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98B5C207FF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 11:35:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727337AbfLWLfY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 06:35:24 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2216 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726680AbfLWLfX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 06:35:23 -0500
Received: from lhreml708-cah.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id D2E5EF876470CA6CCA8E;
        Mon, 23 Dec 2019 11:35:21 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 lhreml708-cah.china.huawei.com (10.201.108.49) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 23 Dec 2019 11:35:20 +0000
Received: from [127.0.0.1] (10.202.227.179) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 23 Dec
 2019 11:35:21 +0000
Subject: Re: [PATCH RFC 1/1] genirq: Make threaded handler use irq affinity
 for managed interrupt
To:     Marc Zyngier <maz@kernel.org>
CC:     Ming Lei <ming.lei@redhat.com>, <tglx@linutronix.de>,
        "chenxiang (M)" <chenxiang66@hisilicon.com>,
        <bigeasy@linutronix.de>, <linux-kernel@vger.kernel.org>,
        <hare@suse.com>, <hch@lst.de>, <axboe@kernel.dk>,
        <bvanassche@acm.org>, <peterz@infradead.org>, <mingo@redhat.com>
References: <b7f3bcea-84ec-f9f6-a3aa-007ae712415f@huawei.com>
 <20191214135641.5a817512@why>
 <7db89b97-1b9e-8dd1-684a-3eef1b1af244@huawei.com>
 <50d9ba606e1e3ee1665a0328ffac67ac@www.loen.fr>
 <a5f6a542-2dbc-62de-52e2-bd5413b5db51@huawei.com>
 <68058fd28c939b8e065524715494de95@www.loen.fr>
 <ac5b5a25-df2e-18e9-6b0f-60af8c7cec3b@huawei.com>
 <687cbcc4-89d9-63ea-a246-ce2abaae501a@huawei.com>
 <0fd543f8ffd90f90deb691aea1c275b4@www.loen.fr>
 <a5154365-59c5-429b-559e-94ad6dffcdb0@huawei.com>
 <20191220233138.GB12403@ming.t460p>
 <fffcd23dd8286615b6e2c99620836cb1@www.loen.fr>
 <d5774e2f-bb60-c27c-bf00-267b88400a12@huawei.com>
 <e815b5451ea86e99d42045f7067f455a@www.loen.fr>
From:   John Garry <john.garry@huawei.com>
Message-ID: <0ac2a416-3059-db1d-f4a6-4e350825299d@huawei.com>
Date:   Mon, 23 Dec 2019 11:35:20 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <e815b5451ea86e99d42045f7067f455a@www.loen.fr>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.179]
X-ClientProxiedBy: lhreml727-chm.china.huawei.com (10.201.108.78) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/12/2019 10:47, Marc Zyngier wrote:
> On 2019-12-23 10:26, John Garry wrote:
>>>>> > I've also managed to trigger some of them now that I have access to
>>>>> > a decent box with nvme storage.
>>>>>
>>>>> I only have 2x NVMe SSDs when this occurs - I should not be hitting 
>>>>> this...
>>>>>
>>>>> Out of curiosity, have you tried
>>>>> > with the SMMU disabled? I'm wondering whether we hit some livelock
>>>>> > condition on unmapping buffers...
>>>>>
>>>>> No, but I can give it a try. Doing that should lower the CPU usage, 
>>>>> though,
>>>>> so maybe masks the issue - probably not.
>>>>
>>>> Lots of CPU lockup can is performance issue if there isn't obvious bug.
>>>>
>>>> I am wondering if you may explain it a bit why enabling SMMU may save
>>>> CPU a it?
>>> The other way around. mapping/unmapping IOVAs doesn't comes for free.
>>> I'm trying to find out whether the NVMe map/unmap patterns trigger
>>> something unexpected in the SMMU driver, but that's a very long shot.
>>
>> So I tested v5.5-rc3 with and without the SMMU enabled, and without
>> the SMMU enabled I don't get the lockup.
> 
> OK, so my hunch wasn't completely off... At least we have something
> to look into.
> 
> [...]
> 
>> Obviously this is not conclusive, especially with such limited
>> testing - 5 minute runs each. The CPU load goes up when disabling the
>> SMMU, but that could be attributed to extra throughput (1183K ->
>> 1539K) loading.
>>
>> I do notice that since we complete the NVMe request in irq context,
>> we also do the DMA unmap, i.e. talk to the SMMU, in the same context,
>> which is less than ideal.
> 
> It depends on how much overhead invalidating the TLB adds to the
> equation, but we should be able to do some tracing and find out.

ok, but let's remember that x86 iommu uses non-strict unmapping by 
default, and they also see this issue.

> 
>> I need to finish for the Christmas break today, so can't check this
>> much further ATM.
> 
> No worries. May I suggest creating a new thread in the new year, maybe
> involving Robin and Will as well?

Can do, but would be good to know how x86 fairs and the IOMMU config 
used for testing also when the lockup occurs.

Cheers,
John

