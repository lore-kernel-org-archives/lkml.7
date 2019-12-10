Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4F78C2D0C4
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 10:59:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 839332073B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 10:59:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727349AbfLJK7w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 05:59:52 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2169 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727227AbfLJK7v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 05:59:51 -0500
Received: from lhreml704-cah.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 7663FC5F3FC24E60EDEE;
        Tue, 10 Dec 2019 10:59:50 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 lhreml704-cah.china.huawei.com (10.201.108.45) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 10 Dec 2019 10:59:50 +0000
Received: from [127.0.0.1] (10.202.226.46) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 10 Dec
 2019 10:59:49 +0000
Subject: Re: [PATCH RFC 1/1] genirq: Make threaded handler use irq affinity
 for managed interrupt
To:     Marc Zyngier <maz@kernel.org>
CC:     Ming Lei <ming.lei@redhat.com>, <tglx@linutronix.de>,
        <chenxiang66@hisilicon.com>, <bigeasy@linutronix.de>,
        <linux-kernel@vger.kernel.org>, <hare@suse.com>, <hch@lst.de>,
        <axboe@kernel.dk>, <bvanassche@acm.org>, <peterz@infradead.org>,
        <mingo@redhat.com>
References: <1575642904-58295-1-git-send-email-john.garry@huawei.com>
 <1575642904-58295-2-git-send-email-john.garry@huawei.com>
 <20191207080335.GA6077@ming.t460p>
 <78a10958-fdc9-0576-0c39-6079b9749d39@huawei.com>
 <20191210014335.GA25022@ming.t460p>
 <28424a58-1159-c3f9-1efb-f1366993afcf@huawei.com>
 <048746c22898849d28985c0f65cf2c2a@www.loen.fr>
From:   John Garry <john.garry@huawei.com>
Message-ID: <ce1b93c6-8ff9-6106-84af-909ec52d49e5@huawei.com>
Date:   Tue, 10 Dec 2019 10:59:48 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <048746c22898849d28985c0f65cf2c2a@www.loen.fr>
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


>>
>> There is no lockup, just a potential performance boost in this change.
>>
>> My colleague Xiang Chen can provide specifics of the test, as he is
>> the one running it.
>>
>> But one key bit of info - which I did not think most relevant before
>> - that is we have 2x SAS controllers running the throughput test on
>> the same host.
>>
>> As such, the completion queue interrupts would be spread identically
>> over the CPUs for each controller. I notice that ARM GICv3 ITS
>> interrupt controller (which we use) does not use the generic irq
>> matrix allocator, which I think would really help with this.
>>
>> Hi Marc,
>>
>> Is there any reason for which we couldn't utilise of the generic irq
>> matrix allocator for GICv3?
> 

Hi Marc,

> For a start, the ITS code predates the matrix allocator by about three
> years. Also, my understanding of this allocator is that it allows
> x86 to cope with a very small number of possible interrupt vectors
> per CPU. The ITS doesn't have such issue, as:
> 
> 1) the namespace is global, and not per CPU
> 2) the namespace is *huge*
> 
> Now, what property of the matrix allocator is the ITS code missing?
> I'd be more than happy to improve it.

I think specifically the property that the matrix allocator will try to 
find a CPU for irq affinity which "has the lowest number of managed IRQs 
allocated" - I'm quoting the comment on matrix_find_best_cpu_managed().

The ITS code will make the lowest online CPU in the affinity mask the 
target CPU for the interrupt, which may result in some CPUs handling so 
many interrupts.

Thanks,
John
