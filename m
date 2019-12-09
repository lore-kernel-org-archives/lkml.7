Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78B3AC43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 15:09:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 533642077B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 15:09:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbfLIPJt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 10:09:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:48966 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725956AbfLIPJs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 10:09:48 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0FEA1AC3C;
        Mon,  9 Dec 2019 15:09:46 +0000 (UTC)
Subject: Re: [PATCH RFC 1/1] genirq: Make threaded handler use irq affinity
 for managed interrupt
To:     John Garry <john.garry@huawei.com>, Ming Lei <ming.lei@redhat.com>
Cc:     tglx@linutronix.de, chenxiang66@hisilicon.com,
        bigeasy@linutronix.de, linux-kernel@vger.kernel.org,
        maz@kernel.org, hare@suse.com, hch@lst.de, axboe@kernel.dk,
        bvanassche@acm.org, peterz@infradead.org, mingo@redhat.com
References: <1575642904-58295-1-git-send-email-john.garry@huawei.com>
 <1575642904-58295-2-git-send-email-john.garry@huawei.com>
 <20191207080335.GA6077@ming.t460p>
 <78a10958-fdc9-0576-0c39-6079b9749d39@huawei.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <305198e5-f76f-ded4-946b-9cfade18f08c@suse.de>
Date:   Mon, 9 Dec 2019 16:09:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <78a10958-fdc9-0576-0c39-6079b9749d39@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/9/19 3:30 PM, John Garry wrote:
> On 07/12/2019 08:03, Ming Lei wrote:
>> On Fri, Dec 06, 2019 at 10:35:04PM +0800, John Garry wrote:
>>> Currently the cpu allowed mask for the threaded part of a threaded irq
>>> handler will be set to the effective affinity of the hard irq.
>>>
>>> Typically the effective affinity of the hard irq will be for a single 
>>> cpu. As such,
>>> the threaded handler would always run on the same cpu as the hard irq.
>>>
>>> We have seen scenarios in high data-rate throughput testing that the cpu
>>> handling the interrupt can be totally saturated handling both the hard
>>> interrupt and threaded handler parts, limiting throughput.
>>
> 
> Hi Ming,
> 
>> Frankly speaking, I never observed that single CPU is saturated by one 
>> storage
>> completion queue's interrupt load. Because CPU is still much quicker than
>> current storage device.
>>
>> If there are more drives, one CPU won't handle more than one 
>> queue(drive)'s
>> interrupt if (nr_drive * nr_hw_queues) < nr_cpu_cores.
> 
> Are things this simple? I mean, can you guarantee that fio processes are 
> evenly distributed as such?
> 
I would assume that it does, seeing that that was the primary goal of 
fio ...

>>
>> So could you describe your case in a bit detail? Then we can confirm
>> if this change is really needed.
> 
> The issue is that the CPU is saturated in servicing the hard and 
> threaded part of the interrupt together - here's the sort of thing which 
> we saw previously:
> Before:
> CPU    %usr    %sys    %irq    %soft    %idle
> all    2.9    13.1    1.2    4.6    78.2
> 0    0.0    29.3    10.1    58.6    2.0
> 1    18.2    39.4    0.0    1.0    41.4
> 2    0.0    2.0    0.0    0.0    98.0
> 
> CPU0 has no effectively no idle.
> 
> Then, by allowing the threaded part to roam:
> After:
> CPU    %usr    %sys    %irq    %soft    %idle
> all    3.5    18.4    2.7    6.8    68.6
> 0    0.0    20.6    29.9    29.9    19.6
> 1    0.0    39.8    0.0    50.0    10.2
> 
> Note: I think that I may be able to reduce the irq hard part load in the 
> endpoint driver, but not that much such that we see still this issue.
> 
Well ... to get a _real_ comparison you would need to specify the number 
of irqs handled (and the resulting IOPS) alongside the cpu load.
It might well be that by spreading out the interrupts to other CPUs 
we're increasing the latency, thus trivially reducing the load ...

My idea here is slightly different: can't we leverage SMT?
Most modern CPUs do SMT (I guess even ARM does it nowadays)
(Yes, I know about spectre and things. We're talking performance here :-)

So for 2-way SMT one could move the submisson queue on one side, and the 
completion queue handling (ie the irq handling) on the other side.
Due to SMT we shouldn't suffer from cache misses (keep fingers crossed),
and might even get better performance.

John, would such a scenario work on your boxes?
IE can we tweak the interrupt and queue assignment?

Initially I would love to test things out, just to see what'll be 
happening; might be that it doesn't bring any benefit at all, but it'd 
be interesting to test out anyway.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke            Teamlead Storage & Networking
hare@suse.de                               +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
