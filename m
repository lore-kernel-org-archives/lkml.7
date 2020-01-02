Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03C02C2D0DC
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 10:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6EC12085B
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 10:35:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbgABKfe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 05:35:34 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2218 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728044AbgABKfe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 05:35:34 -0500
Received: from LHREML710-CAH.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 725601DF53ECFD410694;
        Thu,  2 Jan 2020 10:35:32 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 LHREML710-CAH.china.huawei.com (10.201.108.33) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 2 Jan 2020 10:35:32 +0000
Received: from [127.0.0.1] (10.202.226.43) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 2 Jan 2020
 10:35:31 +0000
Subject: Re: [PATCH RFC 1/1] genirq: Make threaded handler use irq affinity
 for managed interrupt
To:     Ming Lei <ming.lei@redhat.com>, Marc Zyngier <maz@kernel.org>
CC:     <tglx@linutronix.de>, "chenxiang (M)" <chenxiang66@hisilicon.com>,
        <bigeasy@linutronix.de>, <linux-kernel@vger.kernel.org>,
        <hare@suse.com>, <hch@lst.de>, <axboe@kernel.dk>,
        <bvanassche@acm.org>, <peterz@infradead.org>, <mingo@redhat.com>,
        Zhang Yi <yi.zhang@redhat.com>
References: <ac5b5a25-df2e-18e9-6b0f-60af8c7cec3b@huawei.com>
 <687cbcc4-89d9-63ea-a246-ce2abaae501a@huawei.com>
 <0fd543f8ffd90f90deb691aea1c275b4@www.loen.fr>
 <a5154365-59c5-429b-559e-94ad6dffcdb0@huawei.com>
 <20191220233138.GB12403@ming.t460p>
 <fffcd23dd8286615b6e2c99620836cb1@www.loen.fr>
 <d5774e2f-bb60-c27c-bf00-267b88400a12@huawei.com>
 <e815b5451ea86e99d42045f7067f455a@www.loen.fr>
 <20191224015926.GC13083@ming.t460p>
 <7a961950624c414bb9d0c11c914d5c62@www.loen.fr>
 <20191225004822.GA12280@ming.t460p>
From:   John Garry <john.garry@huawei.com>
Message-ID: <72a6a738-f04b-3792-627a-fbfcb7b297e1@huawei.com>
Date:   Thu, 2 Jan 2020 10:35:31 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20191225004822.GA12280@ming.t460p>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.43]
X-ClientProxiedBy: lhreml710-chm.china.huawei.com (10.201.108.61) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/12/2019 00:48, Ming Lei wrote:
> On Tue, Dec 24, 2019 at 11:20:25AM +0000, Marc Zyngier wrote:
>> On 2019-12-24 01:59, Ming Lei wrote:
>>> On Mon, Dec 23, 2019 at 10:47:07AM +0000, Marc Zyngier wrote:
>>>> On 2019-12-23 10:26, John Garry wrote:
>>>>>>>>> I've also managed to trigger some of them now that I have
>>>>>>>> access to
>>>>>>>>> a decent box with nvme storage.
>>>>>>>>
>>>>>>>> I only have 2x NVMe SSDs when this occurs - I should not be
>>>>>>>> hitting this...
>>>>>>>>
>>>>>>>> Out of curiosity, have you tried
>>>>>>>>> with the SMMU disabled? I'm wondering whether we hit some
>>>>>>>> livelock
>>>>>>>>> condition on unmapping buffers...
>>>>>>>>
>>>>>>>> No, but I can give it a try. Doing that should lower the CPU
>>>>>>>> usage, though,
>>>>>>>> so maybe masks the issue - probably not.
>>>>>>>
>>>>>>> Lots of CPU lockup can is performance issue if there isn't
>>>>>>> obvious bug.
>>>>>>>
>>>>>>> I am wondering if you may explain it a bit why enabling SMMU
>>>> may
>>>>>>> save
>>>>>>> CPU a it?
>>>>>> The other way around. mapping/unmapping IOVAs doesn't comes for
>>>>>> free.
>>>>>> I'm trying to find out whether the NVMe map/unmap patterns
>>>> trigger
>>>>>> something unexpected in the SMMU driver, but that's a very long
>>>>>> shot.
>>>>>
>>>>> So I tested v5.5-rc3 with and without the SMMU enabled, and
>>>> without
>>>>> the SMMU enabled I don't get the lockup.
>>>>
>>>> OK, so my hunch wasn't completely off... At least we have something
>>>> to look into.
>>>>
>>>> [...]
>>>>
>>>>> Obviously this is not conclusive, especially with such limited
>>>>> testing - 5 minute runs each. The CPU load goes up when disabling
>>>> the
>>>>> SMMU, but that could be attributed to extra throughput (1183K ->
>>>>> 1539K) loading.
>>>>>
>>>>> I do notice that since we complete the NVMe request in irq
>>>> context,
>>>>> we also do the DMA unmap, i.e. talk to the SMMU, in the same
>>>> context,
>>>>> which is less than ideal.
>>>>
>>>> It depends on how much overhead invalidating the TLB adds to the
>>>> equation, but we should be able to do some tracing and find out.
>>>>
>>>>> I need to finish for the Christmas break today, so can't check
>>>> this
>>>>> much further ATM.
>>>>
>>>> No worries. May I suggest creating a new thread in the new year,
>>>> maybe
>>>> involving Robin and Will as well?
>>>
>>> Zhang Yi has observed the CPU lockup issue once when running heavy IO on
>>> single nvme drive, and please CC him if you have new patch to try.
>>
>> On which architecture? John was indicating that this also happen on x86.
> 
> ARM64.
> 
> To be honest, I never see such CPU lockup issue on x86 in case of running
> heavy IO on single NVMe drive.
> 
>>
>>> Then looks the DMA unmap cost is too big on aarch64 if SMMU is involved.
>>
>> So far, we don't have any data suggesting that this is actually the case.
>> Also, other workloads (such as networking) do not exhibit this behaviour,
>> while being least as unmap-heavy as NVMe is.
> 
> Maybe it is because networking workloads usually completes IO in softirq
> context, instead of hard interrupt context.
> 
>>
>> If the cross-architecture aspect is confirmed, this points more into
>> the direction of an interaction between the NVMe subsystem and the
>> DMA API more than an architecture-specific problem.
>>
>> Given that we have so far very little data, I'd hold off any conclusion.
> 
> We can start to collect latency data of dma unmapping vs nvme_irq()
> on both x86 and arm64.
> 
> I will see if I can get a such box for collecting the latency data.

To reiterate what I mentioned before about IOMMU DMA unmap on x86, a key 
difference is that by default it uses the non-strict (lazy) mode unmap, 
i.e. we unmap in batches. ARM64 uses general default, which is strict 
mode, i.e. every unmap results in an IOTLB fluch.

In my setup, if I switch to lazy unmap (set iommu.strict=0 on cmdline), 
then no lockup.

Are any special IOMMU setups being used for x86, like enabling strict 
mode? I don't know...

Thanks,
John
