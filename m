Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3D18C7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 15:29:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6A9922543
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 15:29:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731384AbfGWP33 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 11:29:29 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2704 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726463AbfGWP33 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 11:29:29 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 412D997F3EFE87C7DD27;
        Tue, 23 Jul 2019 23:29:26 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.238) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Tue, 23 Jul 2019
 23:29:19 +0800
Subject: Re: About threaded interrupt handler CPU affinity
To:     Thomas Gleixner <tglx@linutronix.de>
References: <e0e9478e-62a5-ca24-3b12-58f7d056383e@huawei.com>
 <a98ba3d0-5596-664a-a1ee-5777cff0ddd9@kernel.org>
 <6fd4d706-b66d-6390-749a-8a06b17cb487@huawei.com>
 <alpine.DEB.2.21.1907221723450.2082@nanos.tec.linutronix.de>
 <8e1201a7-3e69-e048-6aa3-3b87e86d55ac@huawei.com>
CC:     Marc Zyngier <maz@kernel.org>, <bigeasy@linutronix.de>,
        chenxiang <chenxiang66@hisilicon.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <e5cb48fc-081a-f47c-810f-cc649c765ae6@huawei.com>
Date:   Tue, 23 Jul 2019 16:29:15 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <8e1201a7-3e69-e048-6aa3-3b87e86d55ac@huawei.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
>  Probably because the other CPU(s)
>> in the affinity set are less loaded than the one which handles the hard
>> interrupt.
>
> I will look to get some figures for CPU loading to back this up.
>

As promised, here are some CPU loading figures before and after the 
change to make the thread CPU affinity same as the interrupt affinity:

Before:
CPU	%usr	%sys	%irq	%soft	%idle
all	2.9	13.1	1.2	4.6	78.2				
0	0.0	29.3	10.1	58.6	2.0
1	18.2	39.4	0.0	1.0	41.4
2	0.0	2.0	0.0	0.0	98.0
3	16.0	40.0	0.0	0.0	44.0
4	9.7	56.3	0.0	0.0	34.0
5	0.0	0.0	0.0	0.0	100.0
6	0.0	36.0	12.0	45.0	7.0
7	12.5	35.4	0.0	0.0	52.1
8	10.3	38.1	0.0	0.0	51.6
9	0.0	0.0	0.0	0.0	100.0
10	8.2	41.8	0.0	0.0	50.0
11	0.0	0.0	0.0	0.0	100.0
					
After:
CPU	%usr	%sys	%irq	%soft	%idle
all	3.5	18.4	2.7	6.8	68.6
0	0.0	20.6	29.9	29.9	19.6
1	0.0	39.8	0.0	50.0	10.2
2	18.6	45.4	0.0	0.0	36.1
3	19.6	48.9	0.0	0.0	31.5
4	0.0	0.0	0.0	0.0	100.0
5	14.9	51.1	0.0	0.0	34.0
6	0.0	20.4	24.5	36.7	18.4
7	0.0	36.0	0.0	63.0	1.0
8	12.2	55.1	0.0	0.0	32.7
9	15.0	57.0	0.0	0.0	28.0
10	13.0	54.0	0.0	0.0	33.0
11	14.6	52.1	0.0	0.0	33.3


The system has 96 cores, and we have 6x CPUs set per interrupt affinity 
mask. I'm only showing 2 clusters of 6 CPUs, but the loading pattern is 
common across all clusters, albeit higher clusters are generally much 
less loaded.

We can see that CPU0,6 are almost 100% loaded before, taking on all the 
irq and softirq processing.

With the change, CPU0,6 are much less loaded, and CPU1,7 take on much 
softirq processing.

In total, irq and softirq processing has increased - I suppose that the 
reason is that we're just pumping through more IO.

We'll do some more testing at lower loads - but from limited testing we 
see no regression here. In the above test we're using many disks on the 
storage controller (> 20).

Please let me know your thoughts.

Cheers,
John

>>
>> This is heavily use case dependent I assume, so making this a general
>> change is perhaps not a good idea, but we could surely make this
>> optional.
>
> That sounds reasonable. So would the idea be to enable this optionally
> at the request threaded irq call?
>
> Thanks,
> John
>
>>
>> Thanks,
>>
>>     tglx
>>
>> .
>>
>


