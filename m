Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB4D6C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 11:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C1AC206EC
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 11:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576496435;
	bh=XCihIg3SQwOMrSlvcPQGDXCFCVuauYmhbKM1ey6NqkA=;
	h=To:Subject:Date:From:Cc:In-Reply-To:References:List-ID:From;
	b=rUGQjeSWg2pQSIZskiDwX9Cs6cXV6YATVXKytiUlprLhtyJPmC5SzGs7hj7yHydRw
	 tf+p3fGNGVL/v8KJr5bMzL+A+gnLu142uQn8XFrqZ9Xh+250NaEBp3B18g6zDVu7Bw
	 VFTWFo1jlqsby0p36GlcYrVNjA3/xR5Rp4pln/MU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727411AbfLPLke (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 06:40:34 -0500
Received: from inca-roads.misterjones.org ([213.251.177.50]:50119 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727316AbfLPLke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 06:40:34 -0500
Received: from www-data by cheepnis.misterjones.org with local (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1igojh-0005KY-25; Mon, 16 Dec 2019 12:40:25 +0100
To:     John Garry <john.garry@huawei.com>
Subject: Re: [PATCH RFC 1/1] genirq: Make threaded handler use irq affinity  for managed interrupt
X-PHP-Originating-Script: 0:main.inc
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 16 Dec 2019 11:40:24 +0000
From:   Marc Zyngier <maz@kernel.org>
Cc:     Ming Lei <ming.lei@redhat.com>, <tglx@linutronix.de>,
        "chenxiang (M)" <chenxiang66@hisilicon.com>,
        <bigeasy@linutronix.de>, <linux-kernel@vger.kernel.org>,
        <hare@suse.com>, <hch@lst.de>, <axboe@kernel.dk>,
        <bvanassche@acm.org>, <peterz@infradead.org>, <mingo@redhat.com>
In-Reply-To: <7db89b97-1b9e-8dd1-684a-3eef1b1af244@huawei.com>
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
Message-ID: <50d9ba606e1e3ee1665a0328ffac67ac@www.loen.fr>
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

On 2019-12-16 10:47, John Garry wrote:
> On 14/12/2019 13:56, Marc Zyngier wrote:
>> On Fri, 13 Dec 2019 15:43:07 +0000
>> John Garry <john.garry@huawei.com> wrote:
>> [...]
>>
>>> john@ubuntu:~$ ./dump-io-irq-affinity
>>> kernel version:
>>> Linux ubuntu 5.5.0-rc1-00003-g7adc5d7ec1ca-dirty #1440 SMP PREEMPT 
>>> Fri Dec 13 14:53:19 GMT 2019 aarch64 aarch64 aarch64 GNU/Linux
>>> PCI name is 04:00.0: nvme0n1
>>> irq 56, cpu list 75, effective list 5
>>> irq 60, cpu list 24-28, effective list 10
>> The NUMA selection code definitely gets in the way. And to be 
>> honest,
>> this NUMA thing is only there for the benefit of a terminally broken
>> implementation (Cavium ThunderX), which we should have never 
>> supported
>> the first place.
>> Let's rework this and simply use the managed affinity whenever
>> available instead. It may well be that it will break TX1, but I care
>> about it just as much as Cavium/Marvell does...
>
> I'm just wondering if non-managed interrupts should be included in
> the load balancing calculation? Couldn't irqbalance (if active) start
> moving non-managed interrupts around anyway?

But they are, aren't they? See what we do in irq_set_affinity:

+		atomic_inc(per_cpu_ptr(&cpu_lpi_count, cpu));
+		atomic_dec(per_cpu_ptr(&cpu_lpi_count,
+				       its_dev->event_map.col_map[id]));

We don't try to "rebalance" anything based on that though, not that
I think we should.

>
>> Please give this new patch a shot on your system (my D05 doesn't 
>> have
>> any managed devices):
>
> We could consider supporting platform msi managed interrupts, but I
> doubt the value.

It shouldn't be hard to do, and most of the existing code could be
moved to the generic level. As for the value, I'm not convinced
either. For example D05 uses the MBIGEN as an intermediate interrupt
controller, so MSIs are from the PoV of MBIGEN, and not the SAS device
attached to it. Not the best design...

>> 
>> https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git/commit/?h=irq/its-balance-mappings&id=1e987d83b8d880d56c9a2d8a86289631da94e55a
>>
>
> I quickly tested that in my NVMe env, and I see a performance boost
> of 1055K -> 1206K IOPS. Results at bottom.

OK, that's encouraging.

> Here's the irq mapping dump:

[...]

Looks good.

> I'm still getting the CPU lockup (even on CPUs which have a single
> NVMe completion interrupt assigned), which taints these results. That
> lockup needs to be fixed.

Is this interrupt screaming to the point where it prevents the 
completion
thread from making forward progress? What if you don't use threaded
interrupts?

> We'll check on our SAS env also. I did already hack something up
> similar to your change and again we saw a boost there.

OK. Please keep me posted. If the result is overall positive, I'll
push this into -next for some soaking.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
