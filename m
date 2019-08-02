Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0CEFC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 14:49:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96C7321726
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 14:49:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="X3CE34Tf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395025AbfHBOtJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 10:49:09 -0400
Received: from mail-wr1-f46.google.com ([209.85.221.46]:44064 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732813AbfHBOtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 10:49:07 -0400
Received: by mail-wr1-f46.google.com with SMTP id p17so77451837wrf.11
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2019 07:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=zboALHEERCLSxzGPBCjmKgc3t4RCReUNx6d5MiXxDPU=;
        b=X3CE34TfQUbRGi5YNfQqiHQkuXrXBVBdUBm8wUhl9FtAVDmpOsymRFaIQW/4ER4PsJ
         8l3VXTKzfHZ/Mys8zWdbJo2e286/Aiec57VZsvq17ucA8vo0rr8ntcc1aO+1XM6dcJHG
         rSIVcfYjE4nvQcFkKW1INC6H7fKYN/Erg7wHVIh7U4bnE48XVhxFFUSksrz3VaoswaCu
         ljVEZCOcig0fxPVxfwskuHWgBKgQwJn/N3kWG3/P/3kIF3uLU4bPIBmqWOb0iNTcK45E
         CKaaqvKT7/CVQDOm79dSNKGaeyNCmklzfRxV6gRHPHIL64iJmPr0lj7RrecHXcrYEnGS
         SEQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=zboALHEERCLSxzGPBCjmKgc3t4RCReUNx6d5MiXxDPU=;
        b=qXjIHCPvSNi877Fd8bWkAFkwMOhC4k1PAWuejwcTKqGPX8THqOzieQIkTKwJTBf583
         AwQ5q5VokK/N0LbJ93tvHSB6ma37z1+PnuLP694UHcI00i92E+c/EvmDPemZMDC0mmdf
         2nqvuHAnWQwxrdMlx5vFsMIYxoNn6IBRzfWrd0r3FO9awhETIStkeqe4DV5/pizwpzAC
         ibQMc2Qr3mzJe1bYG7TZA+MNmKNZNdNWfaLv3Gg4pOEQvEomDiOUEQxk8OWcAp5Dui9y
         iUuCWwY0U3a54z/AjWb2Cd+7gts4mWXtV96zOnCaD8HOnfD+lLCuxeYMXkNg3Mxat5cX
         3e1g==
X-Gm-Message-State: APjAAAUTdDuQa97ynO3Hr67MXgHi8QwGfa+N0RKJlcamLdHZnn5oaeqo
        3wQ1ZuNXFDd6NlLIXXl94DkWg+pA/ZRRBmWp9WedhUNjtUQ=
X-Google-Smtp-Source: APXvYqyX9d7iiFZt4QRUEQuT0PA5YG2fJnO0fblRI3mzOB1hLJ6N3ON3Am+TNMdGurZr/O7KQ5yWrYlhTaBggZ9wbaM=
X-Received: by 2002:adf:f204:: with SMTP id p4mr28901387wro.317.1564757344346;
 Fri, 02 Aug 2019 07:49:04 -0700 (PDT)
MIME-Version: 1.0
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Fri, 2 Aug 2019 16:48:53 +0200
Message-ID: <CAMGffEkotpvVz8FA78vNFh0qZv3kEMNrXXfVPEUC=MhH0pMCZA@mail.gmail.com>
Subject: Kernel 4.14 + has 100 times higher IO latency than Kernel 4.4 with raid1
To:     linux-kernel@vger.kernel.org,
        linux-raid <linux-raid@vger.kernel.org>
Cc:     Alexandr Iarygin <alexandr.iarygin@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

We found a problem regarding much higher IO latency when running
kernel 4.4.131 compare to 4.14.133, tried with latest upstream
5.3-rc2, same result.

Reproducer:
1 create md raid1 with 2 ram disks:
sudo mdadm -C /dev/md0 -l1 -n2 -e1.2 --bitmap=internal /dev/ram[0-1]
2 run fio command with rate_iops:
fio  --rw=write --ioengine=libaio --iodepth=32  --size=1000MB
--rate_iops=5000 --direct=1 --numjobs=1 --runtime=20 --time_based
--name=write-test --filename=/dev/md0

result on 4.4 kernel:
root@ib2:~# fio  --rw=write --ioengine=libaio --iodepth=32
--size=1000MB --rate_iops=5000 --direct=1 --numjobs=1 --runtime=20
--time_based --name=write-test --filename=/dev/md0
write-test: (g=0): rw=write, bs=4K-4K/4K-4K/4K-4K, ioengine=libaio, iodepth=32
fio-2.2.10
Starting 1 process
Jobs: 1 (f=1), CR=5000/0 IOPS: [W(1)] [100.0% done] [0KB/20008KB/0KB
/s] [0/5002/0 iops] [eta 00m:00s]
write-test: (groupid=0, jobs=1): err= 0: pid=3351: Fri Aug  2 15:31:26 2019
  write: io=400004KB, bw=19999KB/s, iops=4999, runt= 20001msec
    slat (usec): min=3, max=26, avg= 3.12, stdev= 0.36
    clat (usec): min=0, max=116, avg= 2.04, stdev= 1.33
     lat (usec): min=3, max=141, avg= 5.19, stdev= 1.39
    clat percentiles (usec):
     |  1.00th=[    1],  5.00th=[    2], 10.00th=[    2], 20.00th=[    2],
     | 30.00th=[    2], 40.00th=[    2], 50.00th=[    2], 60.00th=[    2],
     | 70.00th=[    2], 80.00th=[    2], 90.00th=[    2], 95.00th=[    3],
     | 99.00th=[    3], 99.50th=[    3], 99.90th=[    3], 99.95th=[    3],
     | 99.99th=[   86]
    bw (KB  /s): min=20000, max=20008, per=100.00%, avg=20005.54, stdev= 3.74
    lat (usec) : 2=3.37%, 4=96.60%, 10=0.01%, 20=0.01%, 50=0.01%
    lat (usec) : 100=0.01%, 250=0.01%
  cpu          : usr=4.25%, sys=0.00%, ctx=198550, majf=0, minf=11
  IO depths    : 1=100.0%, 2=0.1%, 4=0.1%, 8=0.1%, 16=0.1%, 32=0.1%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued    : total=r=0/w=100001/d=0, short=r=0/w=0/d=0, drop=r=0/w=0/d=0
     latency   : target=0, window=0, percentile=100.00%, depth=32

Run status group 0 (all jobs):
  WRITE: io=400004KB, aggrb=19999KB/s, minb=19999KB/s, maxb=19999KB/s,
mint=20001msec, maxt=20001msec

Disk stats (read/write):
    md0: ios=61/99539, merge=0/0, ticks=0/0, in_queue=0, util=0.00%,
aggrios=0/0, aggrmerge=0/0, aggrticks=0/0, aggrin_queue=0,
aggrutil=0.00%

result on 5.3 kernel
root@ib1:/home/jwang# fio  --rw=write --ioengine=libaio --iodepth=32
--size=1000MB --rate_iops=5 --direct=1 --numjobs=1 --runtime=20
--time_based --name=write-test --filename=/dev/md0
write-test: (g=0): rw=write, bs=4K-4K/4K-4K/4K-4K, ioengine=libaio, iodepth=32
fio-2.2.10
Starting 1 process
Jobs: 1 (f=1), CR=5/0 IOPS: [W(1)] [100.0% done] [0KB/20KB/0KB /s]
[0/5/0 iops] [eta 00m:00s]
write-test: (groupid=0, jobs=1): err= 0: pid=1651: Fri Aug  2 17:16:18 2019
  write: io=413696B, bw=20683B/s, iops=5, runt= 20001msec
    slat (usec): min=2, max=51803, avg=1028.62, stdev=7250.96
    clat (usec): min=0, max=91, avg=17.76, stdev=28.07
     lat (usec): min=3, max=51892, avg=1046.50, stdev=7254.89
    clat percentiles (usec):
     |  1.00th=[    0],  5.00th=[    0], 10.00th=[    0], 20.00th=[    0],
     | 30.00th=[    1], 40.00th=[    1], 50.00th=[    1], 60.00th=[    1],
     | 70.00th=[   19], 80.00th=[   44], 90.00th=[   68], 95.00th=[   80],
     | 99.00th=[   88], 99.50th=[   91], 99.90th=[   91], 99.95th=[   91],
     | 99.99th=[   91]
    bw (KB  /s): min=   20, max=   21, per=100.00%, avg=20.04, stdev= 0.21
    lat (usec) : 2=67.33%, 10=0.99%, 20=1.98%, 50=11.88%, 100=17.82%
  cpu          : usr=0.00%, sys=0.00%, ctx=77, majf=0, minf=10
  IO depths    : 1=68.3%, 2=2.0%, 4=4.0%, 8=7.9%, 16=15.8%, 32=2.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued    : total=r=0/w=101/d=0, short=r=0/w=0/d=0, drop=r=0/w=0/d=0
     latency   : target=0, window=0, percentile=100.00%, depth=32

Run status group 0 (all jobs):
  WRITE: io=404KB, aggrb=20KB/s, minb=20KB/s, maxb=20KB/s,
mint=20001msec, maxt=20001msec

Disk stats (read/write):
    md0: ios=0/100, merge=0/0, ticks=0/0, in_queue=0, util=0.00%,
aggrios=0/0, aggrmerge=0/0, aggrticks=0/0, aggrin_queue=0,
aggrutil=0.00%
  ram0: ios=0/0, merge=0/0, ticks=0/0, in_queue=0, util=0.00%
  ram1: ios=0/0, merge=0/0, ticks=0/0, in_queue=0, util=0.00%

During the tests the following kernel parameters are applied:
processor.max_cstate=0 idle=poll mitigations=off

Could anyone give us a hint, what could lead to such a huge difference?

Thank you!
Jack Wang
