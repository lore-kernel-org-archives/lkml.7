Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 978B5C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 10:31:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 672BD206DA
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 10:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576233081;
	bh=GJk7r5sFhgotA+HhYX4QBT99MTNkZi/lGJRCC5noxeA=;
	h=To:Subject:Date:From:Cc:In-Reply-To:References:List-ID:From;
	b=qIcos2gh3O/sucTxIr06rdYw554TPyoVGo+ZtFoojQCjoekdvm2kjdPSX+iI8ISzF
	 QkV1TrL1hARXLkhGdqUqjvVXUa6vxV7rdKQrRaiDDn7G/dMbRAHEs4n5tgWjlQNULD
	 SMsqp2JxST+CqsFMxXZY7yTQ6YqH1WeZ9PyfbEzM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbfLMKbU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 05:31:20 -0500
Received: from inca-roads.misterjones.org ([213.251.177.50]:38954 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725747AbfLMKbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 05:31:20 -0500
Received: from www-data by cheepnis.misterjones.org with local (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1ifiE2-0003Za-PE; Fri, 13 Dec 2019 11:31:10 +0100
To:     John Garry <john.garry@huawei.com>
Subject: Re: [PATCH RFC 1/1] genirq: Make threaded handler use irq affinity  for managed interrupt
X-PHP-Originating-Script: 0:main.inc
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Fri, 13 Dec 2019 10:31:10 +0000
From:   Marc Zyngier <maz@kernel.org>
Cc:     Ming Lei <ming.lei@redhat.com>, <tglx@linutronix.de>,
        "chenxiang (M)" <chenxiang66@hisilicon.com>,
        <bigeasy@linutronix.de>, <linux-kernel@vger.kernel.org>,
        <hare@suse.com>, <hch@lst.de>, <axboe@kernel.dk>,
        <bvanassche@acm.org>, <peterz@infradead.org>, <mingo@redhat.com>
In-Reply-To: <2443e657-2ccd-bf85-072c-284ea0b3ce40@huawei.com>
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
 <2443e657-2ccd-bf85-072c-284ea0b3ce40@huawei.com>
Message-ID: <214947849a681fc702d018383a3f95ac@www.loen.fr>
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

On 2019-12-13 10:07, John Garry wrote:
> On 11/12/2019 09:41, John Garry wrote:
>> On 10/12/2019 18:32, Marc Zyngier wrote:
>>>>>> The ITS code will make the lowest online CPU in the affinity 
>>>>>> mask
>>>>>> the
>>>>>> target CPU for the interrupt, which may result in some CPUs
>>>>>> handling
>>>>>> so many interrupts.
>>>>> If what you want is for the*default*  affinity to be spread 
>>>>> around,
>>>>> that should be achieved pretty easily. Let me have a think about 
>>>>> how
>>>>> to do that.
>>>> Cool, I anticipate that it should help my case.
>>>>
>>>> I can also seek out some NVMe cards to see how it would help a 
>>>> more
>>>> "generic" scenario.
>>> Can you give the following a go? It probably has all kind of warts 
>>> on
>>> top of the quality debug information, but I managed to get my D05 
>>> and
>>> a couple of guests to boot with it. It will probably eat your data,
>>> so use caution!;-)
>>>
>> Hi Marc,
>> Ok, we'll give it a spin.
>> Thanks,
>> John
>
> Hi Marc,
>
> JFYI, we're still testing this and the patch itself seems to work as
> intended.
>
> Here's the kernel log if you just want to see how the interrupts are
> getting assigned:
> https://pastebin.com/hh3r810g

It is a bit hard to make sense of this dump, specially on such a wide
machine (I want one!) without really knowing the topology of the 
system.

> For me, I did get a performance boost for NVMe testing, but my
> colleague Xiang Chen saw a drop for our storage test of interest  -
> that's the HiSi SAS controller. We're trying to make sense of it now.

One of the difference is that with this patch, the initial affinity
is picked inside the NUMA node that matches the ITS. In your case,
that's either node 0 or 2. But it is unclear whether which CPUs these
map to.

Given that I see interrupts mapped to CPUs 0-23 on one side, and 48-71
on the other, it looks like half of your machine gets starved, and that
may be because no ITS targets the NUMA nodes they are part of. It would
be interesting to see what happens if you manually set the affinity
of the interrupts outside of the NUMA node.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
