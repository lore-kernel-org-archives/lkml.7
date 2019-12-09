Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 173BDC43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 14:31:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEEBD2077B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 14:31:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727566AbfLIObD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 09:31:03 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2167 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726687AbfLIObD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 09:31:03 -0500
Received: from lhreml705-cah.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 181F11164564CBDC2020;
        Mon,  9 Dec 2019 14:31:02 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 lhreml705-cah.china.huawei.com (10.201.108.46) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 9 Dec 2019 14:31:01 +0000
Received: from [127.0.0.1] (10.202.226.46) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 9 Dec 2019
 14:31:01 +0000
From:   John Garry <john.garry@huawei.com>
Subject: Re: [PATCH RFC 1/1] genirq: Make threaded handler use irq affinity
 for managed interrupt
To:     Ming Lei <ming.lei@redhat.com>
CC:     <tglx@linutronix.de>, <chenxiang66@hisilicon.com>,
        <bigeasy@linutronix.de>, <linux-kernel@vger.kernel.org>,
        <maz@kernel.org>, <hare@suse.com>, <hch@lst.de>, <axboe@kernel.dk>,
        <bvanassche@acm.org>, <peterz@infradead.org>, <mingo@redhat.com>
References: <1575642904-58295-1-git-send-email-john.garry@huawei.com>
 <1575642904-58295-2-git-send-email-john.garry@huawei.com>
 <20191207080335.GA6077@ming.t460p>
Message-ID: <78a10958-fdc9-0576-0c39-6079b9749d39@huawei.com>
Date:   Mon, 9 Dec 2019 14:30:59 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20191207080335.GA6077@ming.t460p>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.46]
X-ClientProxiedBy: lhreml728-chm.china.huawei.com (10.201.108.79) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/12/2019 08:03, Ming Lei wrote:
> On Fri, Dec 06, 2019 at 10:35:04PM +0800, John Garry wrote:
>> Currently the cpu allowed mask for the threaded part of a threaded irq
>> handler will be set to the effective affinity of the hard irq.
>>
>> Typically the effective affinity of the hard irq will be for a single cpu. As such,
>> the threaded handler would always run on the same cpu as the hard irq.
>>
>> We have seen scenarios in high data-rate throughput testing that the cpu
>> handling the interrupt can be totally saturated handling both the hard
>> interrupt and threaded handler parts, limiting throughput.
> 

Hi Ming,

> Frankly speaking, I never observed that single CPU is saturated by one storage
> completion queue's interrupt load. Because CPU is still much quicker than
> current storage device.
> 
> If there are more drives, one CPU won't handle more than one queue(drive)'s
> interrupt if (nr_drive * nr_hw_queues) < nr_cpu_cores.

Are things this simple? I mean, can you guarantee that fio processes are 
evenly distributed as such?

> 
> So could you describe your case in a bit detail? Then we can confirm
> if this change is really needed.

The issue is that the CPU is saturated in servicing the hard and 
threaded part of the interrupt together - here's the sort of thing which 
we saw previously:
Before:
CPU	%usr	%sys	%irq	%soft	%idle
all	2.9	13.1	1.2	4.6	78.2				
0	0.0	29.3	10.1	58.6	2.0
1	18.2	39.4	0.0	1.0	41.4
2	0.0	2.0	0.0	0.0	98.0

CPU0 has no effectively no idle.

Then, by allowing the threaded part to roam:
After:
CPU	%usr	%sys	%irq	%soft	%idle
all	3.5	18.4	2.7	6.8	68.6
0	0.0	20.6	29.9	29.9	19.6
1	0.0	39.8	0.0	50.0	10.2

Note: I think that I may be able to reduce the irq hard part load in the 
endpoint driver, but not that much such that we see still this issue.

> 
>>
>> For when the interrupt is managed, allow the threaded part to run on all
>> cpus in the irq affinity mask.
> 
> I remembered that performance drop is observed by this approach in some
> test.

 From checking the thread about the NVMe interrupt swamp, just switching 
to threaded handler alone degrades performance. I didn't see any 
specific results for this change from Long Li - 
https://lkml.org/lkml/2019/8/21/128

Thanks,
John

