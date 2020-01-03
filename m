Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D14D7C2D0C2
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 10:41:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADB4A217F4
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 10:41:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727569AbgACKlw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 05:41:52 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2223 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727220AbgACKlw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 05:41:52 -0500
Received: from lhreml705-cah.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 0A298D0611181D171E88;
        Fri,  3 Jan 2020 10:41:50 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 lhreml705-cah.china.huawei.com (10.201.108.46) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 3 Jan 2020 10:41:49 +0000
Received: from [127.0.0.1] (10.202.226.43) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 3 Jan 2020
 10:41:49 +0000
Subject: Re: [PATCH RFC 1/1] genirq: Make threaded handler use irq affinity
 for managed interrupt
To:     Ming Lei <ming.lei@redhat.com>
CC:     Marc Zyngier <maz@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "chenxiang (M)" <chenxiang66@hisilicon.com>,
        "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hare@suse.com" <hare@suse.com>, "hch@lst.de" <hch@lst.de>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        Zhang Yi <yi.zhang@redhat.com>
References: <0fd543f8ffd90f90deb691aea1c275b4@www.loen.fr>
 <a5154365-59c5-429b-559e-94ad6dffcdb0@huawei.com>
 <20191220233138.GB12403@ming.t460p>
 <fffcd23dd8286615b6e2c99620836cb1@www.loen.fr>
 <d5774e2f-bb60-c27c-bf00-267b88400a12@huawei.com>
 <e815b5451ea86e99d42045f7067f455a@www.loen.fr>
 <20191224015926.GC13083@ming.t460p>
 <7a961950624c414bb9d0c11c914d5c62@www.loen.fr>
 <20191225004822.GA12280@ming.t460p>
 <72a6a738-f04b-3792-627a-fbfcb7b297e1@huawei.com>
 <20200103004625.GA5219@ming.t460p>
From:   John Garry <john.garry@huawei.com>
Message-ID: <2b070d25-ee35-aa1f-3254-d086c6b872b1@huawei.com>
Date:   Fri, 3 Jan 2020 10:41:48 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200103004625.GA5219@ming.t460p>
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

On 03/01/2020 00:46, Ming Lei wrote:
>>>> d the
>>>> DMA API more than an architecture-specific problem.
>>>>
>>>> Given that we have so far very little data, I'd hold off any conclusion.
>>> We can start to collect latency data of dma unmapping vs nvme_irq()
>>> on both x86 and arm64.
>>>
>>> I will see if I can get a such box for collecting the latency data.
>> To reiterate what I mentioned before about IOMMU DMA unmap on x86, a key
>> difference is that by default it uses the non-strict (lazy) mode unmap, i.e.
>> we unmap in batches. ARM64 uses general default, which is strict mode, i.e.
>> every unmap results in an IOTLB fluch.
>>
>> In my setup, if I switch to lazy unmap (set iommu.strict=0 on cmdline), then
>> no lockup.
>>
>> Are any special IOMMU setups being used for x86, like enabling strict mode?
>> I don't know...
> BTW, I have run the test on one 224-core ARM64 with one 32-hw_queue NVMe, the
> softlock issue can be triggered in one minute.
> 
> nvme_irq() often takes ~5us to complete on this machine, then there is really
> risk of cpu lockup when IOPS is > 200K.

Do you have a typical nvme_irq() completion time for a mid-range x86 server?

> 
> The soft lockup can be triggered too if 'iommu.strict=0' is passed in,
> just takes a bit longer by starting more IO jobs.
> 
> In above test, I submit IO to one single NVMe drive from 4 CPU cores via 8 or
> 12 jobs(iommu.strict=0), meantime make the nvme interrupt handled just in one
> dedicated CPU core.

Well a problem with so many CPUs is that it does not scale (well) with 
MQ devices, like NVMe.

As CPU count goes up, device queue count doesn't and we get more contention.

> 
> Is there lock contention among iommu dma map and unmap callback?

There would be the IOVA management, but that would be common to x86. 
Each CPU keeps an IOVA cache, and there is a central pool of cached 
IOVAs, so that reduces any contention, unless the caches are exhausted.

I think most contention/bottleneck is at the SMMU HW interface, which 
has a single queue interface.

Thanks,
John
