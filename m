Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 171EEC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 11:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDB272073B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 11:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575977822;
	bh=16RcxnjGRu8LlXaJIegmZltRI06Ot9kt45SGFDCR1+g=;
	h=To:Subject:Date:From:Cc:In-Reply-To:References:List-ID:From;
	b=xggjLKUp6rbvYtskodGVsTHdgNL6/E4V4GpR9tOjaftz68n+QisU71BTx8o3s9+q9
	 xkWeZ2nTr6cSCE9BoEFPq47m89X991dBqQNQ/kUiQh1fI9jcbRqa2apQQJG1qM8LWt
	 +IiUDc9JCm79ZKvofoOscwOZKr+9GcJwxy8L5CPo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727314AbfLJLhB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 06:37:01 -0500
Received: from inca-roads.misterjones.org ([213.251.177.50]:57132 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727131AbfLJLhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 06:37:01 -0500
Received: from www-data by cheepnis.misterjones.org with local (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1iedow-0005Ab-5d; Tue, 10 Dec 2019 12:36:50 +0100
To:     John Garry <john.garry@huawei.com>
Subject: Re: [PATCH RFC 1/1] genirq: Make threaded handler use irq affinity  for managed interrupt
X-PHP-Originating-Script: 0:main.inc
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 10 Dec 2019 11:36:50 +0000
From:   Marc Zyngier <maz@kernel.org>
Cc:     Ming Lei <ming.lei@redhat.com>, <tglx@linutronix.de>,
        <chenxiang66@hisilicon.com>, <bigeasy@linutronix.de>,
        <linux-kernel@vger.kernel.org>, <hare@suse.com>, <hch@lst.de>,
        <axboe@kernel.dk>, <bvanassche@acm.org>, <peterz@infradead.org>,
        <mingo@redhat.com>
In-Reply-To: <ce1b93c6-8ff9-6106-84af-909ec52d49e5@huawei.com>
References: <1575642904-58295-1-git-send-email-john.garry@huawei.com>
 <1575642904-58295-2-git-send-email-john.garry@huawei.com>
 <20191207080335.GA6077@ming.t460p>
 <78a10958-fdc9-0576-0c39-6079b9749d39@huawei.com>
 <20191210014335.GA25022@ming.t460p>
 <28424a58-1159-c3f9-1efb-f1366993afcf@huawei.com>
 <048746c22898849d28985c0f65cf2c2a@www.loen.fr>
 <ce1b93c6-8ff9-6106-84af-909ec52d49e5@huawei.com>
Message-ID: <6e513d25d8b0c6b95d37a64df0c27b78@www.loen.fr>
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

On 2019-12-10 10:59, John Garry wrote:
>>>
>>> There is no lockup, just a potential performance boost in this 
>>> change.
>>>
>>> My colleague Xiang Chen can provide specifics of the test, as he is
>>> the one running it.
>>>
>>> But one key bit of info - which I did not think most relevant 
>>> before
>>> - that is we have 2x SAS controllers running the throughput test on
>>> the same host.
>>>
>>> As such, the completion queue interrupts would be spread 
>>> identically
>>> over the CPUs for each controller. I notice that ARM GICv3 ITS
>>> interrupt controller (which we use) does not use the generic irq
>>> matrix allocator, which I think would really help with this.
>>>
>>> Hi Marc,
>>>
>>> Is there any reason for which we couldn't utilise of the generic 
>>> irq
>>> matrix allocator for GICv3?
>>
>
> Hi Marc,
>
>> For a start, the ITS code predates the matrix allocator by about 
>> three
>> years. Also, my understanding of this allocator is that it allows
>> x86 to cope with a very small number of possible interrupt vectors
>> per CPU. The ITS doesn't have such issue, as:
>> 1) the namespace is global, and not per CPU
>> 2) the namespace is *huge*
>> Now, what property of the matrix allocator is the ITS code missing?
>> I'd be more than happy to improve it.
>
> I think specifically the property that the matrix allocator will try
> to find a CPU for irq affinity which "has the lowest number of 
> managed
> IRQs allocated" - I'm quoting the comment on 
> matrix_find_best_cpu_managed().

But that decision is due to allocation constraints. You can have at 
most
256 interrupts per CPU, so the allocator tries to balance it.

On the contrary, the ITS does care about how many interrupt target any
given CPU. The whole 2^24 interrupt namespace can be thrown at a single
CPU.

> The ITS code will make the lowest online CPU in the affinity mask the
> target CPU for the interrupt, which may result in some CPUs handling
> so many interrupts.

If what you want is for the *default* affinity to be spread around,
that should be achieved pretty easily. Let me have a think about how
to do that.

         M.
-- 
Jazz is not dead. It just smells funny...
