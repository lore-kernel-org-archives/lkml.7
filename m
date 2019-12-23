Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2058FC2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 10:26:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6B4E206D3
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 10:26:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbfLWK0d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 05:26:33 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2213 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726638AbfLWK0d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 05:26:33 -0500
Received: from LHREML714-CAH.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id C53692E2E6C1B1C640BB;
        Mon, 23 Dec 2019 10:26:30 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 LHREML714-CAH.china.huawei.com (10.201.108.37) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 23 Dec 2019 10:26:30 +0000
Received: from [127.0.0.1] (10.202.227.179) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 23 Dec
 2019 10:26:30 +0000
Subject: Re: [PATCH RFC 1/1] genirq: Make threaded handler use irq affinity
 for managed interrupt
To:     Marc Zyngier <maz@kernel.org>, Ming Lei <ming.lei@redhat.com>
CC:     <tglx@linutronix.de>, "chenxiang (M)" <chenxiang66@hisilicon.com>,
        <bigeasy@linutronix.de>, <linux-kernel@vger.kernel.org>,
        <hare@suse.com>, <hch@lst.de>, <axboe@kernel.dk>,
        <bvanassche@acm.org>, <peterz@infradead.org>, <mingo@redhat.com>
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
 <fffcd23dd8286615b6e2c99620836cb1@www.loen.fr>
From:   John Garry <john.garry@huawei.com>
Message-ID: <d5774e2f-bb60-c27c-bf00-267b88400a12@huawei.com>
Date:   Mon, 23 Dec 2019 10:26:29 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <fffcd23dd8286615b6e2c99620836cb1@www.loen.fr>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.179]
X-ClientProxiedBy: lhreml727-chm.china.huawei.com (10.201.108.78) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> > I've also managed to trigger some of them now that I have access to
>>> > a decent box with nvme storage.
>>>
>>> I only have 2x NVMe SSDs when this occurs - I should not be hitting 
>>> this...
>>>
>>> Out of curiosity, have you tried
>>> > with the SMMU disabled? I'm wondering whether we hit some livelock
>>> > condition on unmapping buffers...
>>>
>>> No, but I can give it a try. Doing that should lower the CPU usage, 
>>> though,
>>> so maybe masks the issue - probably not.
>>
>> Lots of CPU lockup can is performance issue if there isn't obvious bug.
>>
>> I am wondering if you may explain it a bit why enabling SMMU may save
>> CPU a it?
> 
> The other way around. mapping/unmapping IOVAs doesn't comes for free.
> I'm trying to find out whether the NVMe map/unmap patterns trigger
> something unexpected in the SMMU driver, but that's a very long shot.

So I tested v5.5-rc3 with and without the SMMU enabled, and without the 
SMMU enabled I don't get the lockup.

fio summary SMMU enabled:

john@ubuntu:~$ dmesg | grep "Adding to iommu group"
[   10.550212] hisi_sas_v3_hw 0000:74:02.0: Adding to iommu group 0
[   14.773231] nvme 0000:04:00.0: Adding to iommu group 1
[   14.784000] nvme 0000:81:00.0: Adding to iommu group 2
[   14.794884] ahci 0000:74:03.0: Adding to iommu group 3

[snip]

sudo  sh create_fio_task_cpu_liuyifan_nvme.sh 4k read 20 1
Creat 4k_read_depth20_fiotest file sucessfully
job1: (g=0): rw=read, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 
4096B-4096B, ioengine=libaio, iodepth=20
...
job1: (g=0): rw=read, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 
4096B-4096B, ioengine=libaio, iodepth=20
...
fio-3.1
Starting 20 processes
[  110.155618] rcu: INFO: rcu_preempt self-detected stall on CPU0 
IOPS][eta 04m:11s]
[  110.161360] rcu: 4-....: (1 GPs behind) idle=00e/1/0x4000000000000004 
softirq=1284/4115 fqs=2625
[  173.167743] rcu: INFO: rcu_preempt self-detected stall on CPU0 
IOPS][eta 03m:08s]
[  173.173484] rcu: 29-....: (1 GPs behind) idle=e1e/0/0x3 
softirq=662/5436 fqs=10501
[  236.179623] rcu: INFO: rcu_preempt self-detected stall on CPU0 
IOPS][eta 02m:05s]
[  236.185362] rcu: 29-....: (1 GPs behind) idle=e1e/0/0x3 
softirq=662/5436 fqs=18220
[  271.735648] rcu: INFO: rcu_preempt self-detected stall on CPU0 
IOPS][eta 01m:30s]
[  271.741387] rcu: 16-....: (1 GPs behind) 
idle=fb6/1/0x4000000000000002 softirq=858/1168 fqs=2605
[  334.747590] rcu: INFO: rcu_preempt self-detected stall on CPU0 
IOPS][eta 00m:27s]
[  334.753328] rcu: 0-....: (1 GPs behind) idle=57a/1/0x4000000000000002 
softirq=1384/1384 fqs=10309
Jobs: 20 (f=20): [R(20)][100.0%][r=4230MiB/s,w=0KiB/s][r=1083k,w=0 
IOPS][eta 00m:00s]
job1: (groupid=0, jobs=20): err= 0: pid=1242: Mon Dec 23 09:45:12 2019
    read: IOPS=1183k, BW=4621MiB/s (4846MB/s)(1354GiB/300002msec)
     slat (usec): min=2, max=183172k, avg= 6.47, stdev=12846.53
     clat (usec): min=4, max=183173k, avg=330.40, stdev=63380.85
      lat (usec): min=20, max=183173k, avg=337.02, stdev=64670.18
     clat percentiles (usec):
      |  1.00th=[  104],  5.00th=[  112], 10.00th=[  137], 20.00th=[  182],
      | 30.00th=[  219], 40.00th=[  245], 50.00th=[  269], 60.00th=[  297],
      | 70.00th=[  338], 80.00th=[  379], 90.00th=[  429], 95.00th=[  482],
      | 99.00th=[  635], 99.50th=[  742], 99.90th=[ 1221], 99.95th=[ 1876],
      | 99.99th=[ 6194]
    bw (  KiB/s): min=   32, max=733328, per=5.75%, avg=272330.58, 
stdev=110721.72, samples=10435
    iops        : min=    8, max=183332, avg=68082.49, stdev=27680.43, 
samples=10435
   lat (usec)   : 10=0.01%, 20=0.01%, 50=0.01%, 100=0.46%, 250=41.97%
   lat (usec)   : 500=53.32%, 750=3.78%, 1000=0.31%
   lat (msec)   : 2=0.11%, 4=0.03%, 10=0.01%, 20=0.01%, 50=0.01%
   lat (msec)   : 100=0.01%, 250=0.01%, 500=0.01%, 750=0.01%, 1000=0.01%
   lat (msec)   : 2000=0.01%, >=2000=0.01%
   cpu          : usr=8.38%, sys=33.43%, ctx=134950965, majf=0, minf=4371
   IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=100.0%, 32=0.0%, 
 >=64=0.0%
      submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, 
 >=64=0.0%
      complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.1%, 64=0.0%, 
 >=64=0.0%
      issued rwt: total=354924097,0,0, short=0,0,0, dropped=0,0,0
      latency   : target=0, window=0, percentile=100.00%, depth=20

Run status group 0 (all jobs):
    READ: bw=4621MiB/s (4846MB/s), 4621MiB/s-4621MiB/s 
(4846MB/s-4846MB/s), io=1354GiB (1454GB), run=300002-300002msec

Disk stats (read/write):
   nvme0n1: ios=187325975/0, merge=0/0, ticks=49841664/0, 
in_queue=11620, util=100.00%
   nvme1n1: ios=167416192/0, merge=0/0, ticks=42280120/0, 
in_queue=194576, util=100.00%
john@ubuntu:~$


fio summary SMMU disabled:

john@ubuntu:~$ dmesg | grep "Adding to iommu group"
john@ubuntu:~$


sudo  sh create_fio_task_cpu_liuyifan_nvme.sh 4k read 20 1
Creat 4k_read_depth20_fiotest file sucessfully
job1: (g=0): rw=read, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 
4096B-4096B, ioengine=libaio, iodepth=20
...
job1: (g=0): rw=read, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 
4096B-4096B, ioengine=libaio, iodepth=20
...
fio-3.1
Starting 20 processes
Jobs: 20 (f=20): [R(20)][100.0%][r=6053MiB/s,w=0KiB/s][r=1550k,w=0 
IOPS][eta 00m:00s]
job1: (groupid=0, jobs=20): err= 0: pid=1221: Mon Dec 23 09:54:15 2019
    read: IOPS=1539k, BW=6011MiB/s (6303MB/s)(1761GiB/300001msec)
     slat (usec): min=2, max=224572, avg= 4.44, stdev=14.57
     clat (usec): min=11, max=238636, avg=254.59, stdev=140.45
      lat (usec): min=15, max=240025, avg=259.17, stdev=142.61
     clat percentiles (usec):
      |  1.00th=[   94],  5.00th=[  125], 10.00th=[  167], 20.00th=[  208],
      | 30.00th=[  221], 40.00th=[  227], 50.00th=[  237], 60.00th=[  247],
      | 70.00th=[  262], 80.00th=[  281], 90.00th=[  338], 95.00th=[  420],
      | 99.00th=[  701], 99.50th=[  857], 99.90th=[ 1270], 99.95th=[ 1483],
      | 99.99th=[ 2114]
    bw (  KiB/s): min= 2292, max=429480, per=5.01%, avg=308068.30, 
stdev=36800.42, samples=12000
    iops        : min=  573, max=107370, avg=77016.89, stdev=9200.10, 
samples=12000
   lat (usec)   : 20=0.01%, 50=0.04%, 100=1.56%, 250=61.54%, 500=33.86%
   lat (usec)   : 750=2.19%, 1000=0.53%
   lat (msec)   : 2=0.26%, 4=0.01%, 10=0.01%, 20=0.01%, 50=0.01%
   lat (msec)   : 100=0.01%, 250=0.01%
   cpu          : usr=11.50%, sys=40.49%, ctx=198764008, majf=0, minf=30760
   IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=100.0%, 32=0.0%, 
 >=64=0.0%
      submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, 
 >=64=0.0%
      complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.1%, 64=0.0%, 
 >=64=0.0%
      issued rwt: total=461640046,0,0, short=0,0,0, dropped=0,0,0
      latency   : target=0, window=0, percentile=100.00%, depth=20

Run status group 0 (all jobs):
    READ: bw=6011MiB/s (6303MB/s), 6011MiB/s-6011MiB/s 
(6303MB/s-6303MB/s), io=1761GiB (1891GB), run=300001-300001msec

Disk stats (read/write):
   nvme0n1: ios=229212121/0, merge=0/0, ticks=56349577/0, in_queue=2908, 
util=100.00%
   nvme1n1: ios=232165508/0, merge=0/0, ticks=56708137/0, in_queue=372, 
util=100.00%
john@ubuntu:~$

Obviously this is not conclusive, especially with such limited testing - 
5 minute runs each. The CPU load goes up when disabling the SMMU, but 
that could be attributed to extra throughput (1183K -> 1539K) loading.

I do notice that since we complete the NVMe request in irq context, we 
also do the DMA unmap, i.e. talk to the SMMU, in the same context, which 
is less than ideal.

I need to finish for the Christmas break today, so can't check this much 
further ATM.

Thanks,
John
