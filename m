Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB178C341A4
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:36:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3682824731
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:36:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbfLMMI5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 07:08:57 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2187 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726856AbfLMMI5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 07:08:57 -0500
Received: from lhreml708-cah.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id E8B3AEB9742DB66BDA0C;
        Fri, 13 Dec 2019 12:08:55 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 lhreml708-cah.china.huawei.com (10.201.108.49) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 13 Dec 2019 12:08:55 +0000
Received: from [127.0.0.1] (10.202.226.46) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 13 Dec
 2019 12:08:55 +0000
Subject: Re: [PATCH RFC 1/1] genirq: Make threaded handler use irq affinity
 for managed interrupt
To:     Marc Zyngier <maz@kernel.org>
CC:     Ming Lei <ming.lei@redhat.com>, <tglx@linutronix.de>,
        "chenxiang (M)" <chenxiang66@hisilicon.com>,
        <bigeasy@linutronix.de>, <linux-kernel@vger.kernel.org>,
        <hare@suse.com>, <hch@lst.de>, <axboe@kernel.dk>,
        <bvanassche@acm.org>, <peterz@infradead.org>, <mingo@redhat.com>
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
 <214947849a681fc702d018383a3f95ac@www.loen.fr>
From:   John Garry <john.garry@huawei.com>
Message-ID: <174bfdbe-0c44-298b-35e9-8466e77528df@huawei.com>
Date:   Fri, 13 Dec 2019 12:08:54 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <214947849a681fc702d018383a3f95ac@www.loen.fr>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.202.226.46]
X-ClientProxiedBy: lhreml728-chm.china.huawei.com (10.201.108.79) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

>> JFYI, we're still testing this and the patch itself seems to work as
>> intended.
>>
>> Here's the kernel log if you just want to see how the interrupts are
>> getting assigned:
>> https://pastebin.com/hh3r810g
> 
> It is a bit hard to make sense of this dump, specially on such a wide
> machine (I want one!) 

So do I :) That's the newer "D06CS" board.

without really knowing the topology of the system.

So it's 2x socket, each socket has 2x CPU dies, and each die has 6 
clusters of 4 CPUs, which gives 96 in total.

> 
>> For me, I did get a performance boost for NVMe testing, but my
>> colleague Xiang Chen saw a drop for our storage test of interest  -
>> that's the HiSi SAS controller. We're trying to make sense of it now.
> 
> One of the difference is that with this patch, the initial affinity
> is picked inside the NUMA node that matches the ITS. 

Is that even for managed interrupts? We're testing the storage 
controller which uses managed interrupts. I should have made that clearer.

In your case,
> that's either node 0 or 2. But it is unclear whether which CPUs these
> map to.
> 
> Given that I see interrupts mapped to CPUs 0-23 on one side, and 48-71
> on the other, it looks like half of your machine gets starved, 

Seems that way.

So this is a mystery to me:

[   23.584192] picked CPU62 IRQ147

147:          0          0          0          0          0          0 
        0          0          0          0          0          0 
  0          0          0          0          0          0          0 
       0          0          0          0          0          0 
0          0          0          0          0          0          0 
     0          0          0          0          0          0          0 
          0          0          0          0          0          0 
    0          0          0          0          0          0          0 
         0          0          0          0          0          0 
   0          0          0          0          0          0          0 
        0          0          0          0          0          0 
  0          0          0          0          0          0          0 
       0          0          0          0          0          0 
0          0          0          0          0          0          0 
     0          0          0          0          0   ITS-MSI 94404626 
Edge      hisi_sas_v3_hw cq


and

[   25.896728] picked CPU62 IRQ183

183:          0          0          0          0          0          0 
        0          0          0          0          0          0 
  0          0          0          0          0          0          0 
       0          0          0          0          0          0 
0          0          0          0          0          0          0 
     0          0          0          0          0          0          0 
          0          0          0          0          0          0 
    0          0          0          0          0          0          0 
         0          0          0          0          0          0 
   0          0          0          0          0          0          0 
        0          0          0          0          0          0 
  0          0          0          0          0          0          0 
       0          0          0          0          0          0 
0          0          0          0          0          0          0 
     0          0          0          0          0   ITS-MSI 94437398 
Edge      hisi_sas_v3_hw cq


But mpstat reports for CPU62:

12:44:58 AM  CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal 
  %guest  %gnice   %idle
12:45:00 AM   62    6.54    0.00   42.99    0.00    6.54   12.15    0.00 
    0.00    6.54   25.23

I don't know what interrupts they are...

It's the "hisi_sas_v3_hw cq" interrupts which we're interested in.

and that
> may be because no ITS targets the NUMA nodes they are part of.

So both storage controllers (which we're interested in for this test) 
are on socket #0, node #0.

  It would
> be interesting to see what happens if you manually set the affinity
> of the interrupts outside of the NUMA node.
> 

Again, managed, so I don't think it's possible.

Thanks,
John
