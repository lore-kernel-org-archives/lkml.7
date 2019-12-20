Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B932C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 14:43:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B40C2064B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 14:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576853029;
	bh=S59CQz92lK6cTKLy+LMYP1JuavcZQE0Ms5W6p7qnzwg=;
	h=To:Subject:Date:From:Cc:In-Reply-To:References:List-ID:From;
	b=Vkr47Zn4tyZKgmkW/u8omhSESmRDVapwpM2hZ6mNAPXlgROzStqrgwonN5hBQIYgH
	 CVqgTJPLQpJ9ixc3o1tUz75Q9EeQPtx4lWoiZ3ZLEa3ZZnj/Wghy2UL9VlkK8EpCoN
	 K1t03w8bFOT1MXonQV1yBY3kSevinUoUKXMF7wWQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727422AbfLTOns (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 09:43:48 -0500
Received: from inca-roads.misterjones.org ([213.251.177.50]:49172 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727233AbfLTOns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 09:43:48 -0500
Received: from www-data by cheepnis.misterjones.org with local (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1iiJVA-0007vs-AK; Fri, 20 Dec 2019 15:43:36 +0100
To:     John Garry <john.garry@huawei.com>
Subject: Re: [PATCH RFC 1/1] genirq: Make threaded handler use irq affinity  for managed interrupt
X-PHP-Originating-Script: 0:main.inc
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 20 Dec 2019 14:43:36 +0000
From:   Marc Zyngier <maz@kernel.org>
Cc:     Ming Lei <ming.lei@redhat.com>, <tglx@linutronix.de>,
        "chenxiang (M)" <chenxiang66@hisilicon.com>,
        <bigeasy@linutronix.de>, <linux-kernel@vger.kernel.org>,
        <hare@suse.com>, <hch@lst.de>, <axboe@kernel.dk>,
        <bvanassche@acm.org>, <peterz@infradead.org>, <mingo@redhat.com>
In-Reply-To: <687cbcc4-89d9-63ea-a246-ce2abaae501a@huawei.com>
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
Message-ID: <0fd543f8ffd90f90deb691aea1c275b4@www.loen.fr>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/0.7.2
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Rcpt-To: john.garry@huawei.com, ming.lei@redhat.com, tglx@linutronix.de, chenxiang66@hisilicon.com, bigeasy@linutronix.de, linux-kernel@vger.kernel.org, hare@suse.com, hch@lst.de, axboe@kernel.dk, bvanassche@acm.org, peterz@infradead.org, mingo@redhat.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

On 2019-12-20 11:30, John Garry wrote:
>>> So you enqueue requests from CPU0 only? It seems a bit odd...
>> No, but maybe I wasn't clear enough. I'll give an overview:
>> For D06 SAS controller - which is a multi-queue PCI device - we use 
>> managed interrupts. The HW has 16 submission/completion queues, so for 
>> 96 cores, we have an even spread of 6 CPUs assigned per queue; and 
>> this per-queue CPU mask is the interrupt affinity mask. So CPU0-5 
>> would submit any IO on queue0, CPU6-11 on queue2, and so on. PCI NVMe 
>> is essentially the same.
>> These are the environments which we're trying to promote 
>> performance.
>> Then for D05 SAS controller - which is multi-queue platform device 
>> (mbigen) - we don't use managed interrupts. We still submit IO from 
>> any CPU, but we choose the queue to submit IO on a round-robin basis 
>> to promote some isolation, i.e. reduce inter-queue lock contention, so 
>> the queue chosen has nothing to do with the CPU.
>> And with your change we may submit on cpu4 but service the interrupt 
>> on cpu30, as an example. While previously we would always service on 
>> cpu0. The old way still isn't ideal, I'll admit.
>> For this env, we would just like to maintain the same performance. 
>> And it's here that we see the performance drop.
>>
>
> Hi Marc,
>
> We've got some more results and it looks promising.
>
> So with your patch we get a performance boost of 3180.1K -> 3294.9K
> IOPS in the D06 SAS env. Then when we change the driver to use
> threaded interrupt handler (mainline currently uses tasklet), we get 
> a
> boost again up to 3415K IOPS.
>
> Now this is essentially the same figure we had with using threaded
> handler + the gen irq change in spreading the handler CPU affinity. 
> We
> did also test your patch + gen irq change and got a performance drop,
> to 3347K IOPS.
>
> So tentatively I'd say your patch may be all we need.

OK.

> FYI, here is how the effective affinity is looking for both SAS
> controllers with your patch:
>
> 74:02.0
> irq 81, cpu list 24-29, effective list 24 cq
> irq 82, cpu list 30-35, effective list 30 cq

Cool.

[...]

> As for your patch itself, I'm still concerned of possible regressions
> if we don't apply this effective interrupt affinity spread policy to
> only managed interrupts.

I'll try and revise that as I post the patch, probably at some point
between now and Christmas. I still think we should find a way to
address this for the D05 SAS driver though, maybe by managing the
affinity yourself in the driver. But this requires experimentation.

> JFYI, about NVMe CPU lockup issue, there are 2 works on going here:
> 
> https://lore.kernel.org/linux-nvme/20191209175622.1964-1-kbusch@kernel.org/T/#t
> 
> https://lore.kernel.org/linux-block/20191218071942.22336-1-ming.lei@redhat.com/T/#t

I've also managed to trigger some of them now that I have access to
a decent box with nvme storage. Out of curiosity, have you tried
with the SMMU disabled? I'm wondering whether we hit some livelock
condition on unmapping buffers...

> Cheers,
> John
>
> Ps. Thanks to Xiang Chen for all the work here in getting these 
> results.

Yup, much appreciated!

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
