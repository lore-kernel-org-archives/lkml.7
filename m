Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EC8FC2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 09:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7300C206CB
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 09:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577092069;
	bh=5z7sWIpaYqMbvpg6MeavV3NbeplPVUOZHTBPGO86TS4=;
	h=To:Subject:Date:From:Cc:In-Reply-To:References:List-ID:From;
	b=glm7niBvS+QWfxtfDMsg2POMZZTt4mFKK+FShOn1Yg1EDje41gQad3xrioHD2oxRh
	 7WsS/uj4mwWxGID6VBnsk6wnvJqL3Qk6V74JuVleCsp+I7eDF5mTHTgBhVYYo41amt
	 gqpAWVA5iGj0dMYmb6lZGrKRfTEgE25KNp805uJA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbfLWJHs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 04:07:48 -0500
Received: from inca-roads.misterjones.org ([213.251.177.50]:36622 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725974AbfLWJHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 04:07:48 -0500
Received: from www-data by cheepnis.misterjones.org with local (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1ijJgh-0007yn-Sh; Mon, 23 Dec 2019 10:07:39 +0100
To:     Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH RFC 1/1] genirq: Make threaded handler use irq affinity  for managed interrupt
X-PHP-Originating-Script: 0:main.inc
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 23 Dec 2019 09:07:39 +0000
From:   Marc Zyngier <maz@kernel.org>
Cc:     John Garry <john.garry@huawei.com>, <tglx@linutronix.de>,
        "chenxiang (M)" <chenxiang66@hisilicon.com>,
        <bigeasy@linutronix.de>, <linux-kernel@vger.kernel.org>,
        <hare@suse.com>, <hch@lst.de>, <axboe@kernel.dk>,
        <bvanassche@acm.org>, <peterz@infradead.org>, <mingo@redhat.com>
In-Reply-To: <20191220233138.GB12403@ming.t460p>
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
Message-ID: <fffcd23dd8286615b6e2c99620836cb1@www.loen.fr>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/0.7.2
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Rcpt-To: ming.lei@redhat.com, john.garry@huawei.com, tglx@linutronix.de, chenxiang66@hisilicon.com, bigeasy@linutronix.de, linux-kernel@vger.kernel.org, hare@suse.com, hch@lst.de, axboe@kernel.dk, bvanassche@acm.org, peterz@infradead.org, mingo@redhat.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-12-20 23:31, Ming Lei wrote:
> On Fri, Dec 20, 2019 at 03:38:24PM +0000, John Garry wrote:
>> > > We've got some more results and it looks promising.
>> > >
>> > > So with your patch we get a performance boost of 3180.1K -> 
>> 3294.9K
>> > > IOPS in the D06 SAS env. Then when we change the driver to use
>> > > threaded interrupt handler (mainline currently uses tasklet), we 
>> get a
>> > > boost again up to 3415K IOPS.
>> > >
>> > > Now this is essentially the same figure we had with using 
>> threaded
>> > > handler + the gen irq change in spreading the handler CPU 
>> affinity. We
>> > > did also test your patch + gen irq change and got a performance 
>> drop,
>> > > to 3347K IOPS.
>> > >
>> > > So tentatively I'd say your patch may be all we need.
>> >
>> > OK.
>> >
>> > > FYI, here is how the effective affinity is looking for both SAS
>> > > controllers with your patch:
>> > >
>> > > 74:02.0
>> > > irq 81, cpu list 24-29, effective list 24 cq
>> > > irq 82, cpu list 30-35, effective list 30 cq
>> >
>> > Cool.
>> >
>> > [...]
>> >
>> > > As for your patch itself, I'm still concerned of possible 
>> regressions
>> > > if we don't apply this effective interrupt affinity spread 
>> policy to
>> > > only managed interrupts.
>> >
>> > I'll try and revise that as I post the patch, probably at some 
>> point
>> > between now and Christmas. I still think we should find a way to
>> > address this for the D05 SAS driver though, maybe by managing the
>> > affinity yourself in the driver. But this requires 
>> experimentation.
>>
>> I've already done something experimental for the driver to manage 
>> the
>> affinity, and performance is generally much better:
>>
>> 
>> https://github.com/hisilicon/kernel-dev/commit/e15bd404ed1086fed44da34ed3bd37a8433688a7
>>
>> But I still think it's wise to only consider managed interrupts for 
>> now.
>>
>> >
>> > > JFYI, about NVMe CPU lockup issue, there are 2 works on going 
>> here:
>> > >
>> > > 
>> https://lore.kernel.org/linux-nvme/20191209175622.1964-1-kbusch@kernel.org/T/#t
>> > >
>> > >
>> > > 
>> https://lore.kernel.org/linux-block/20191218071942.22336-1-ming.lei@redhat.com/T/#t
>> > >
>> >
>> > I've also managed to trigger some of them now that I have access 
>> to
>> > a decent box with nvme storage.
>>
>> I only have 2x NVMe SSDs when this occurs - I should not be hitting 
>> this...
>>
>> Out of curiosity, have you tried
>> > with the SMMU disabled? I'm wondering whether we hit some livelock
>> > condition on unmapping buffers...
>>
>> No, but I can give it a try. Doing that should lower the CPU usage, 
>> though,
>> so maybe masks the issue - probably not.
>
> Lots of CPU lockup can is performance issue if there isn't obvious 
> bug.
>
> I am wondering if you may explain it a bit why enabling SMMU may save
> CPU a it?

The other way around. mapping/unmapping IOVAs doesn't comes for free.
I'm trying to find out whether the NVMe map/unmap patterns trigger
something unexpected in the SMMU driver, but that's a very long shot.

         M.
-- 
Jazz is not dead. It just smells funny...
