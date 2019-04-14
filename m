Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 324ECC10F11
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 00:09:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE68D21721
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 00:09:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbfDNAJV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 20:09:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38234 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727052AbfDNAJV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 20:09:21 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B4C9C3082A4C;
        Sun, 14 Apr 2019 00:09:20 +0000 (UTC)
Received: from [10.10.120.173] (ovpn-120-173.rdu2.redhat.com [10.10.120.173])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C7D0419C77;
        Sun, 14 Apr 2019 00:09:19 +0000 (UTC)
Subject: Re: perf tools:Is there any tools to found out the max latency by irq
 or cpu idle
To:     Linhaifeng <haifeng.lin@huawei.com>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <4099DE2E54AFAD489356C6C9161D53339591D64A@DGGEML502-MBX.china.huawei.com>
 <8ce8c596-123e-1342-5ccc-06a5fd8a60ec@redhat.com>
 <4099DE2E54AFAD489356C6C9161D53339591DE6D@DGGEML502-MBX.china.huawei.com>
From:   William Cohen <wcohen@redhat.com>
Message-ID: <5b1fc7cf-ddd5-ab2e-d87c-976c914bb01b@redhat.com>
Date:   Sat, 13 Apr 2019 20:09:19 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <4099DE2E54AFAD489356C6C9161D53339591DE6D@DGGEML502-MBX.china.huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Sun, 14 Apr 2019 00:09:20 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/13/19 2:01 AM, Linhaifeng wrote:
> Sorry, the value 131081408 is just for example. Actually the result is like this:
>  sqrt 2019-04-10 23:53:50: 43968
>  sqrt 2019-04-10 23:53:51: 44060
>  sqrt 2019-04-10 23:53:52: 49012
>  sqrt 2019-04-10 23:53:53: 38172
>  sqrt 2019-04-10 23:53:54: 131081408
>  sqrt 2019-04-10 23:53:55: 43600
>  sqrt 2019-04-10 23:53:56: 46704
>  sqrt 2019-04-10 23:53:57: 46880
>  sqrt 2019-04-10 23:53:58: 44332
>  ……
>  sqrt 2019-04-10 02:17:15: 136345876
>  ……
>  sqrt 2019-04-10 04:40:35: 136335644
>  ……

Hi,

Still it would be interesting to look at the two raw values used to compute the delta to better diagnose what is going on.

-Will
> 
> -----Original Message-----
> From: William Cohen [mailto:wcohen@redhat.com] 
> Sent: 2019年4月12日 22:06
> To: Linhaifeng <haifeng.lin@huawei.com>; linux-perf-users@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: perf tools:Is there any tools to found out the max latency by irq or cpu idle
> 
> On 4/11/19 8:57 PM, Linhaifeng wrote:
>> Hi,
>> I have a single thread application like this:
>>
>> While (1) {
>>     start = rdtsc();
>>     sqrt (1024);      
>> 　　end = rdtsc();
>> 　　cycles = end – start;
>> 　　printf("cycles: %d-%02d-%02d %02d:%02d:%02d: %lu\n", 
>> 　　　　　　1900+timeinfo->tm_year, 1+timeinfo->tm_mon, timeinfo->tm_mday, timeinfo->tm_hour, timeinfo->tm_min, timeinfo->tm_sec,
>> 　　　　　　cycles);
>> }
>> It print the cycles of sqrt every second and run with taskset –c 1 ./sqrt.
>> The result of test is:
>>
>> sqrt 2019-04-10 23:53:50: 43968
>> sqrt 2019-04-10 23:53:51: 44060
>> sqrt 2019-04-10 23:53:52: 49012
>> sqrt 2019-04-10 23:53:53: 38172
>> sqrt 2019-04-10 23:53:54: 131081408
>> sqrt 2019-04-10 23:53:55: 43600
>> sqrt 2019-04-10 23:53:56: 46704
>> sqrt 2019-04-10 23:53:57: 46880
>> sqrt 2019-04-10 23:53:58: 44332
>> ……
>> sqrt 2019-04-10 02:17:15: 131081408
>> ……
>> sqrt 2019-04-10 04:40:35: 131081408
>> ……
>>
>> Every 2hour23min there would be a large cycles. I use perf sched not found any sched_switch events.
> 
> Hi,
> 
> The fact that it is the same value 131081408 every 2 hours 23 minutes looks suspect. One would expect some variation in the counts.  It looks like there is some rollover or overflow issue.  It would be helpful to print out the start and end values to see what is going on with the raw rdstc values.  Maybe the thread is being moved between processors and the TSC are out of sync.  What particular processor model was this running on? Was this running on physical hardware or inside a kvm guest? 
> 
> According to the Intel 64 and IA-32 Architecture Software Devloper's Manual Volume 3 (325384-sdm-vol-3abcd.pdf):
> 
> The RDTSC instruction reads the time-stamp counter and is guaranteed to return a monotonically increasing unique value whenever executed, except for a 64-bit counter wraparound. Intel guarantees that the time-stamp counter will not wraparound within 10 years after being reset. The period for counter wrap is longer for Pentium 4, Intel Xeon, P6 family, and Pentium processors.
> 
> -Will Cohen
> 
> 
>>
>> L2GW_2680:/home/fsp/zn # perf sched record -C 6-11 -o perf.sched ^C[ 
>> perf record: Woken up 64 times to write data ] [ perf record: Captured 
>> and wrote 204.878 MB perf.sched (1911189 samples) ]
>>
>> L2GW_2680:/home/fsp/zn # perf sched latency -i perf.sched
>>
>> ----------------------------------------------------------------------
>> -------------------------------------------
>>   Task                  |   Runtime ms  | Switches | Average delay ms 
>> | Maximum delay ms | Maximum delay at       |
>> ----------------------------------------------------------------------
>> -------------------------------------------
>> ----------------------------------------------------------------------
>> -------------------------------------------
>>   TOTAL:                |      0.000 ms |        0 |
>> ---------------------------------------------------
>>
>>
>>
>> Is there any other tools of perf to found out the max latency by irq or cpu idle ?
>>
>>
> 

