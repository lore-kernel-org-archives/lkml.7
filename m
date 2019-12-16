Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BE08C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 10:47:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 355DC206D3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 10:47:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727549AbfLPKrs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 05:47:48 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2193 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727099AbfLPKrs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 05:47:48 -0500
Received: from lhreml705-cah.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 28D6D5EDDC0C66F1B3B5;
        Mon, 16 Dec 2019 10:47:47 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 lhreml705-cah.china.huawei.com (10.201.108.46) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 16 Dec 2019 10:47:46 +0000
Received: from [127.0.0.1] (10.202.226.46) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 16 Dec
 2019 10:47:46 +0000
Subject: Re: [PATCH RFC 1/1] genirq: Make threaded handler use irq affinity
 for managed interrupt
To:     Marc Zyngier <maz@kernel.org>
CC:     Ming Lei <ming.lei@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "chenxiang (M)" <chenxiang66@hisilicon.com>,
        "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hare@suse.com" <hare@suse.com>, "hch@lst.de" <hch@lst.de>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>
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
From:   John Garry <john.garry@huawei.com>
Message-ID: <7db89b97-1b9e-8dd1-684a-3eef1b1af244@huawei.com>
Date:   Mon, 16 Dec 2019 10:47:45 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20191214135641.5a817512@why>
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

On 14/12/2019 13:56, Marc Zyngier wrote:
> On Fri, 13 Dec 2019 15:43:07 +0000
> John Garry <john.garry@huawei.com> wrote:
> 
> [...]
> 
>> john@ubuntu:~$ ./dump-io-irq-affinity
>> kernel version:
>> Linux ubuntu 5.5.0-rc1-00003-g7adc5d7ec1ca-dirty #1440 SMP PREEMPT Fri Dec 13 14:53:19 GMT 2019 aarch64 aarch64 aarch64 GNU/Linux
>> PCI name is 04:00.0: nvme0n1
>> irq 56, cpu list 75, effective list 5
>> irq 60, cpu list 24-28, effective list 10
> 
> The NUMA selection code definitely gets in the way. And to be honest,
> this NUMA thing is only there for the benefit of a terminally broken
> implementation (Cavium ThunderX), which we should have never supported
> the first place.
> 
> Let's rework this and simply use the managed affinity whenever
> available instead. It may well be that it will break TX1, but I care
> about it just as much as Cavium/Marvell does...

I'm just wondering if non-managed interrupts should be included in the 
load balancing calculation? Couldn't irqbalance (if active) start moving 
non-managed interrupts around anyway?

> 
> Please give this new patch a shot on your system (my D05 doesn't have
> any managed devices):

We could consider supporting platform msi managed interrupts, but I 
doubt the value.

> 
> https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git/commit/?h=irq/its-balance-mappings&id=1e987d83b8d880d56c9a2d8a86289631da94e55a
> 

I quickly tested that in my NVMe env, and I see a performance boost of 
1055K -> 1206K IOPS. Results at bottom.

Here's the irq mapping dump:

PCI name is 04:00.0: nvme0n1
irq 56, cpu list 75, effective list 75
irq 60, cpu list 24-28, effective list 26
irq 61, cpu list 29-33, effective list 30
irq 62, cpu list 34-38, effective list 35
irq 63, cpu list 39-43, effective list 40
irq 64, cpu list 44-47, effective list 45
irq 65, cpu list 48-51, effective list 49
irq 66, cpu list 52-55, effective list 55
irq 67, cpu list 56-59, effective list 57
irq 68, cpu list 60-63, effective list 61
irq 69, cpu list 64-67, effective list 65
irq 70, cpu list 68-71, effective list 69
irq 71, cpu list 72-75, effective list 73
irq 72, cpu list 76-79, effective list 77
irq 73, cpu list 80-83, effective list 81
irq 74, cpu list 84-87, effective list 85
irq 75, cpu list 88-91, effective list 89
irq 76, cpu list 92-95, effective list 93
irq 77, cpu list 0-3, effective list 1
irq 78, cpu list 4-7, effective list 6
irq 79, cpu list 8-11, effective list 9
irq 80, cpu list 12-15, effective list 13
irq 81, cpu list 16-19, effective list 17
irq 82, cpu list 20-23, effective list 21
PCI name is 81:00.0: nvme1n1
irq 100, cpu list 0-3, effective list 0
irq 101, cpu list 4-7, effective list 4
irq 102, cpu list 8-11, effective list 8
irq 103, cpu list 12-15, effective list 12
irq 104, cpu list 16-19, effective list 16
irq 105, cpu list 20-23, effective list 20
irq 57, cpu list 63, effective list 63
irq 83, cpu list 24-28, effective list 26
irq 84, cpu list 29-33, effective list 29
irq 85, cpu list 34-38, effective list 34
irq 86, cpu list 39-43, effective list 39
irq 87, cpu list 44-47, effective list 44
irq 88, cpu list 48-51, effective list 48
irq 89, cpu list 52-55, effective list 54
irq 90, cpu list 56-59, effective list 56
irq 91, cpu list 60-63, effective list 60
irq 92, cpu list 64-67, effective list 64
irq 93, cpu list 68-71, effective list 68
irq 94, cpu list 72-75, effective list 72
irq 95, cpu list 76-79, effective list 76
irq 96, cpu list 80-83, effective list 80
irq 97, cpu list 84-87, effective list 84
irq 98, cpu list 88-91, effective list 88
irq 99, cpu list 92-95, effective list 92

I'm still getting the CPU lockup (even on CPUs which have a single NVMe 
completion interrupt assigned), which taints these results. That lockup 
needs to be fixed.

We'll check on our SAS env also. I did already hack something up similar 
to your change and again we saw a boost there.

Thanks,
John


before

job1: (groupid=0, jobs=20): err= 0: pid=1328: Mon Dec 16 10:03:35 2019
    read: IOPS=1055k, BW=4121MiB/s (4322MB/s)(994GiB/246946msec)
     slat (usec): min=2, max=36747k, avg= 6.08, stdev=4018.85
     clat (usec): min=13, max=145774k, avg=369.87, stdev=50221.38
      lat (usec): min=22, max=145774k, avg=376.12, stdev=50387.08
     clat percentiles (usec):
      |  1.00th=[  105],  5.00th=[  128], 10.00th=[  149], 20.00th=[  178],
      | 30.00th=[  210], 40.00th=[  243], 50.00th=[  281], 60.00th=[  326],
      | 70.00th=[  396], 80.00th=[  486], 90.00th=[  570], 95.00th=[  619],
      | 99.00th=[  775], 99.50th=[  906], 99.90th=[ 1254], 99.95th=[ 1631],
      | 99.99th=[ 3884]
    bw (  KiB/s): min=    8, max=715687, per=5.65%, avg=238518.42, 
stdev=115795.80, samples=8726
    iops        : min=    2, max=178921, avg=59629.49, stdev=28948.95, 
samples=8726
   lat (usec)   : 20=0.01%, 50=0.01%, 100=0.60%, 250=41.66%, 500=39.19%
   lat (usec)   : 750=17.36%, 1000=0.95%
   lat (msec)   : 2=0.20%, 4=0.02%, 10=0.01%, 20=0.01%, 50=0.01%
   lat (msec)   : 100=0.01%, 250=0.01%, 500=0.01%, 750=0.01%, 1000=0.01%
   lat (msec)   : 2000=0.01%, >=2000=0.01%
   cpu          : usr=8.26%, sys=33.56%, ctx=132171506, majf=0, minf=6774
   IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=100.0%, 32=0.0%, 
 >=64=0.0%
      submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, 
 >=64=0.0%
      complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.1%, 64=0.0%, 
 >=64=0.0%
      issued rwt: total=260541724,0,0, short=0,0,0, dropped=0,0,0
      latency   : target=0, window=0, percentile=100.00%, depth=20

Run status group 0 (all jobs):
    READ: bw=4121MiB/s (4322MB/s), 4121MiB/s-4121MiB/s 
(4322MB/s-4322MB/s), io=994GiB (1067GB), run=246946-246946msec

Disk stats (read/write):
   nvme0n1: ios=136993553/0, merge=0/0, ticks=42019997/0, 
in_queue=14168, util=100.00%
   nvme1n1: ios=123408538/0, merge=0/0, ticks=37371364/0, 
in_queue=44672, util=100.00%
john@ubuntu:~$ dmesg | grep "Linux v"
[    0.000000] Linux version 5.5.0-rc1-dirty 
(john@john-ThinkCentre-M93p) (gcc version 7.3.1 20180425 
[linaro-7.3-2018.05-rc1 revision 
38aec9a676236eaa42ca03ccb3a6c1dd0182c29f] (Linaro GCC 7.3-2018.05-rc1)) 
#546 SMP PREEMPT Mon Dec 16 09:47:44 GMT 2019
john@ubuntu:~$


after

Creat 4k_read_depth20_fiotest file sucessfully_cpu_liuyifan_nvme.sh 4k 
read 20 1
job1: (g=0): rw=read, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 
4096B-4096B, ioengine=libaio, iodepth=20
...
job1: (g=0): rw=read, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 
4096B-4096B, ioengine=libaio, iodepth=20
...
fio-3.1
Starting 20 processes
[  318.569268] rcu: INFO: rcu_preempt self-detected stall on CPU0 
IOPS][eta 04m:30s]
[  318.575010] rcu: 26-....: (1 GPs behind) 
idle=b82/1/0x4000000000000004 softirq=842/843 fqs=2508
[  355.781759] rcu: INFO: rcu_preempt self-detected stall on CPU0 
IOPS][eta 03m:53s]
[  355.787499] rcu: 34-....: (1 GPs behind) 
idle=35a/1/0x4000000000000004 softirq=10395/11729 fqs=2623
[  407.805329] rcu: INFO: rcu_preempt self-detected stall on CPU0 
IOPS][eta 03m:01s]
[  407.811069] rcu: 0-....: (1 GPs behind) idle=0ba/0/0x3 
softirq=10830/14926 fqs=2625
Jobs: 20 (f=20): [R(20)][61.0%][r=4747MiB/s,w=0KiB/s][r=1215k,w=0[ 
470.817317] rcu: INFO: rcu_preempt self-detected stall on CPU
[  470.824912] rcu: 0-....: (2779 ticks this GP) idle=0ba/0/0x3 
softirq=14927/14927 fqs=10501
[  533.829618] rcu: INFO: rcu_preempt self-detected stall on CPU0 
IOPS][eta 00m:54s]
[  533.835360] rcu: 39-....: (1 GPs behind) 
idle=74e/1/0x4000000000000004 softirq=3422/3422 fqs=17226
Jobs: 20 (f=20): [R(20)][100.0%][r=4822MiB/s,w=0KiB/s][r=1234k,w=0 
IOPS][eta 00m:00s]
job1: (groupid=0, jobs=20): err= 0: pid=1273: Mon Dec 16 10:15:55 2019
    read: IOPS=1206k, BW=4712MiB/s (4941MB/s)(1381GiB/300002msec)
     slat (usec): min=2, max=165648k, avg= 7.26, stdev=10373.59
     clat (usec): min=12, max=191808k, avg=323.17, stdev=57005.77
      lat (usec): min=19, max=191808k, avg=330.59, stdev=58014.79
     clat percentiles (usec):
      |  1.00th=[  106],  5.00th=[  151], 10.00th=[  174], 20.00th=[  194],
      | 30.00th=[  212], 40.00th=[  231], 50.00th=[  247], 60.00th=[  262],
      | 70.00th=[  285], 80.00th=[  330], 90.00th=[  457], 95.00th=[  537],
      | 99.00th=[  676], 99.50th=[  807], 99.90th=[ 1647], 99.95th=[ 2376],
      | 99.99th=[ 6915]
    bw (  KiB/s): min=    8, max=648593, per=5.73%, avg=276597.82, 
stdev=98174.89, samples=10475
    iops        : min=    2, max=162148, avg=69149.31, stdev=24543.72, 
samples=10475
   lat (usec)   : 20=0.01%, 50=0.01%, 100=0.67%, 250=51.48%, 500=41.68%
   lat (usec)   : 750=5.54%, 1000=0.33%
   lat (msec)   : 2=0.23%, 4=0.05%, 10=0.02%, 20=0.01%, 50=0.01%
   lat (msec)   : 100=0.01%, 250=0.01%, 500=0.01%, 750=0.01%, 1000=0.01%
   lat (msec)   : 2000=0.01%, >=2000=0.01%
   cpu          : usr=9.77%, sys=41.68%, ctx=218155976, majf=0, minf=6376
   IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=100.0%, 32=0.0%, 
 >=64=0.0%
      submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, 
 >=64=0.0%
      complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.1%, 64=0.0%, 
 >=64=0.0%
      issued rwt: total=361899317,0,0, short=0,0,0, dropped=0,0,0
      latency   : target=0, window=0, percentile=100.00%, depth=20

Run status group 0 (all jobs):
    READ: bw=4712MiB/s (4941MB/s), 4712MiB/s-4712MiB/s 
(4941MB/s-4941MB/s), io=1381GiB (1482GB), run=300002-300002msec

Disk stats (read/write):
   nvme0n1: ios=188627578/0, merge=0/0, ticks=50365208/0, 
in_queue=55380, util=100.00%
   nvme1n1: ios=173066657/0, merge=0/0, ticks=38804419/0, 
in_queue=151212, util=100.00%
john@ubuntu:~$ dmesg | grep "Linux v"
[    0.000000] Linux version 5.5.0-rc1-00001-g1e987d83b8d8-dirty 
(john@john-ThinkCentre-M93p) (gcc version 7.3.1 20180425 
[linaro-7.3-2018.05-rc1 revision 
38aec9a676236eaa42ca03ccb3a6c1dd0182c29f] (Linaro GCC 7.3-2018.05-rc1)) 
#547 SMP PREEMPT Mon Dec 16 10:02:27 GMT 2019
