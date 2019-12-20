Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BE07C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 16:16:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A18B24679
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 16:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576858600;
	bh=22QyY9532vr12y+0PtvJvxVDhuNAmjmvc1WQQAi03cE=;
	h=To:Subject:Date:From:Cc:In-Reply-To:References:List-ID:From;
	b=yIPKSPsdZwnfMUo50J2t5LZLxjeHI8p1/b76EG9Nza0zr0f2/NrH29xtNOJ6WChvA
	 qsfrEgGI6yEmQ6cNFqJpYf4k0ROOnU12q8QUqb/GGMnPchas2LoU/AhMVpqBUuGdNX
	 6/nY1iDJIMN3wVOFSJ8BKVwy1iCfj4B6nzD2QCN0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727404AbfLTQQj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 11:16:39 -0500
Received: from inca-roads.misterjones.org ([213.251.177.50]:51493 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727233AbfLTQQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 11:16:38 -0500
Received: from www-data by cheepnis.misterjones.org with local (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1iiKx5-0001gJ-Gq; Fri, 20 Dec 2019 17:16:31 +0100
To:     John Garry <john.garry@huawei.com>
Subject: Re: [PATCH RFC 1/1] genirq: Make threaded handler use irq affinity  for managed interrupt
X-PHP-Originating-Script: 0:main.inc
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 20 Dec 2019 16:16:31 +0000
From:   Marc Zyngier <maz@kernel.org>
Cc:     Ming Lei <ming.lei@redhat.com>, <tglx@linutronix.de>,
        "chenxiang (M)" <chenxiang66@hisilicon.com>,
        <bigeasy@linutronix.de>, <linux-kernel@vger.kernel.org>,
        <hare@suse.com>, <hch@lst.de>, <axboe@kernel.dk>,
        <bvanassche@acm.org>, <peterz@infradead.org>, <mingo@redhat.com>
In-Reply-To: <a5154365-59c5-429b-559e-94ad6dffcdb0@huawei.com>
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
 <a5154365-59c5-429b-559e-94ad6dffcdb0@huawei.com>
Message-ID: <a46aaad9e00dbfa5817b3698450ae7be@www.loen.fr>
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

On 2019-12-20 15:38, John Garry wrote:

> I've already done something experimental for the driver to manage the
> affinity, and performance is generally much better:
>
> 
> https://github.com/hisilicon/kernel-dev/commit/e15bd404ed1086fed44da34ed3bd37a8433688a7
>
> But I still think it's wise to only consider managed interrupts for 
> now.

Sure. We've lived with it so far, we can make it last a bit longer... 
;-)

>>
>>> JFYI, about NVMe CPU lockup issue, there are 2 works on going here:
>>>
>>> 
>>> https://lore.kernel.org/linux-nvme/20191209175622.1964-1-kbusch@kernel.org/T/#t
>>>
>>>
>>> 
>>> https://lore.kernel.org/linux-block/20191218071942.22336-1-ming.lei@redhat.com/T/#t
>>>
>> I've also managed to trigger some of them now that I have access to
>> a decent box with nvme storage.
>
> I only have 2x NVMe SSDs when this occurs - I should not be hitting 
> this...

Same configuration here. And the number of interrupts is pretty
low (less that 20k/s per CPU), so I doubt this is interrupt related.

> Out of curiosity, have you tried
>> with the SMMU disabled? I'm wondering whether we hit some livelock
>> condition on unmapping buffers...
>
> No, but I can give it a try. Doing that should lower the CPU usage,
> though, so maybe masks the issue - probably not.

I wonder whether we could end-up in some form of unmap storm on
completion, with a CPU being starved trying to insert its TLBI
command into the queue.

Anyway, more digging in perspective.

         M.
-- 
Jazz is not dead. It just smells funny...
