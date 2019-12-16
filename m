Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7BE9C2D0CD
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F0D9206A5
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576521739;
	bh=1monKWtH0unLvQloc7m3GeCJo/xcklceeF75zAdoe6U=;
	h=To:Subject:Date:From:Cc:In-Reply-To:References:List-ID:From;
	b=hLnnfGZbY0mONlaWts4Qd43ujhez2txODhSr/QwYeZrBIAnfKhkVF/X/O5ooYL/z+
	 BJT7J1R5DfLQW3980BYwq2vArjexgce9GUcadp1FhDgZemDzZKM2BcsIzUqJjUJRSu
	 lonrvhNaF3ArOpxxxA3UQ1mttMKyUJH7foyEal4s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728931AbfLPSAZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 13:00:25 -0500
Received: from inca-roads.misterjones.org ([213.251.177.50]:53267 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726784AbfLPSAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 13:00:19 -0500
Received: from www-data by cheepnis.misterjones.org with local (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1igufD-0005zW-IO; Mon, 16 Dec 2019 19:00:11 +0100
To:     John Garry <john.garry@huawei.com>
Subject: Re: [PATCH RFC 1/1] genirq: Make threaded handler use irq affinity  for managed interrupt
X-PHP-Originating-Script: 0:main.inc
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Mon, 16 Dec 2019 18:00:11 +0000
From:   Marc Zyngier <maz@kernel.org>
Cc:     Ming Lei <ming.lei@redhat.com>, <tglx@linutronix.de>,
        "chenxiang (M)" <chenxiang66@hisilicon.com>,
        <bigeasy@linutronix.de>, <linux-kernel@vger.kernel.org>,
        <hare@suse.com>, <hch@lst.de>, <axboe@kernel.dk>,
        <bvanassche@acm.org>, <peterz@infradead.org>, <mingo@redhat.com>
In-Reply-To: <a5f6a542-2dbc-62de-52e2-bd5413b5db51@huawei.com>
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
Message-ID: <68058fd28c939b8e065524715494de95@www.loen.fr>
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

On 2019-12-16 14:17, John Garry wrote:
> Hi Marc,
>
>>>
>>> I'm just wondering if non-managed interrupts should be included in
>>> the load balancing calculation? Couldn't irqbalance (if active) 
>>> start
>>> moving non-managed interrupts around anyway?
>> But they are, aren't they? See what we do in irq_set_affinity:
>> +        atomic_inc(per_cpu_ptr(&cpu_lpi_count, cpu));
>> +        atomic_dec(per_cpu_ptr(&cpu_lpi_count,
>> +                       its_dev->event_map.col_map[id]));
>> We don't try to "rebalance" anything based on that though, not that
>> I think we should.
>
> Ah sorry, I meant whether they should not be included. In
> its_irq_domain_activate(), we increment the per-cpu lpi count and 
> also
> use its_pick_target_cpu() to find the least loaded cpu. I am asking
> whether we should just stick with the old policy for non-managed
> interrupts here.
>
> After checking D05, I see a very significant performance hit for SAS
> controller performance - ~40% throughout lowering.

-ETOOMANYMOVINGPARTS.

> With this patch, now we have effective affinity targeted at seemingly
> "random" CPUs, as opposed to all just using CPU0. This affects
> performance.

And piling all interrupts on the same CPU does help?

> The difference is that when we use managed interrupts - like for NVME
> or D06 SAS controller - the irq cpu affinity mask matches the CPUs
> which enqueue the requests to the queue associated with the 
> interrupt.
> So there is an efficiency is enqueuing and deqeueing on same CPU 
> group
> - all related to blk multi-queue. And this is not the case for
> non-managed interrupts.

So you enqueue requests from CPU0 only? It seems a bit odd...

>>>> Please give this new patch a shot on your system (my D05 doesn't 
>>>> have
>>>> any managed devices):
>>>
>>> We could consider supporting platform msi managed interrupts, but I
>>> doubt the value.
>> It shouldn't be hard to do, and most of the existing code could be
>> moved to the generic level. As for the value, I'm not convinced
>> either. For example D05 uses the MBIGEN as an intermediate interrupt
>> controller, so MSIs are from the PoV of MBIGEN, and not the SAS 
>> device
>> attached to it. Not the best design...
>
> JFYI, I did raise this following topic before, but that's as far as I 
> got:
>
> https://marc.info/?l=linux-block&m=150722088314310&w=2

Yes. And that's probably not very hard, but the problem in your case is
that the D05 HW is not using MSIs... You'd have to provide an 
abstraction
for wired interrupts (please don't).

You'd be better off directly setting the affinity of the interrupts 
from
the driver, but I somehow can't believe that you're only submitting 
requests
from the same CPU, always. There must be something I'm missing.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
