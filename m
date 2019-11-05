Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CEE9CA9ED9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 07:51:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B039206BA
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 07:51:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387931AbfKEHvn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 02:51:43 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:6152 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387711AbfKEHvm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 02:51:42 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 2FCA26BAC3E25437A584;
        Tue,  5 Nov 2019 15:51:38 +0800 (CST)
Received: from [127.0.0.1] (10.74.221.148) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Tue, 5 Nov 2019
 15:51:29 +0800
Subject: Re: [RFC] About perf-mem command support on arm64 platform
To:     Will Deacon <will@kernel.org>
References: <74f8ddb5-13cc-5dce-82a6-ca8bd02f8175@hisilicon.com>
 <20191104142654.GA24609@willie-the-truck>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, <liuqi115@hisilicon.com>,
        <huangdaode@hisilicon.com>, <john.garry@huawei.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:   Shaokun Zhang <zhangshaokun@hisilicon.com>
Message-ID: <76664d1a-cc8f-cd27-bc04-ddc687880b1f@hisilicon.com>
Date:   Tue, 5 Nov 2019 15:51:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.1
MIME-Version: 1.0
In-Reply-To: <20191104142654.GA24609@willie-the-truck>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.74.221.148]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

Thanks your reply firstly.

On 2019/11/4 22:26, Will Deacon wrote:
> On Mon, Nov 04, 2019 at 05:18:00PM +0800, Shaokun Zhang wrote:
>> perf-mem is used to profile memory access which has been implemented on x86
>> platform. It needs mem-stores events and mem-loads/load-latency.
>> For mem-stores events, it is MEM_INST_RETIRED_ALL_STORES whose raw number
>> is r82d0, and mem-loads/load-latency is from PEBS if I follow its code.
>>
>> Now, for some arm64 cores, like HiSilicon's tsv110 and ARM's Neoverse N1,
>> has supported the SPE(Statistical Profiling Extensions), so is it a
>> possibility that perf-mem is supported on arm64?
>> https://developer.arm.com/ip-products/processors/neoverse/neoverse-n1
> 
> I don't understand the relationship you're trying to draw between mem-stores

There may be some misunderstanding if I don't describe it correctly. From
the implementation of perf-mem on x86, it needs:
a. mem-stores PMU events;
b. mem-loads/load-latency from PEBS;

If arm64 plans to support perf-mem, we need to support mem-stores and
mem-loads/load-latency, and we can derive the latter from SPE.

> and SPE. How does perf-mem work and what does it actually require from the
> CPU?

An excellent question, I don't check the perf-mem carefully. Just from my
understanding, it needs the mentioned events and PEBS sampled data that is
filtered by desired latency for loads event.

> 
> One thing that may be worth noting is that SPE isn't generally able to
> capture information about all instructions being executed by the CPU:

Got it and I have used SPE on Huawei Kunpeng 920 SoC.

> instead, it instructions (most likely micro-ops) are sampled based on
> some user-specified period. The CPU advertises a minimum recommended

Ok, If I follow it right, perf record -c XXX to define the period for SPE.

> period which we expose under /sys and enforce when programming events.
> 
>> For arm64 PMU, it has 'st_retired' event that the event number is 0x0007
>> which is equal to mem-stores on x86, if we want support perf-mem, it seems
>> that 'st_retired' shall be replaced by 'mem-stores'
>> in arch/arm64/kernel/perf_event.c file. Of course, the cpu core should
>> support st_retired event. I'm not sure Will/Mark are happy on this.;-)
>>
>> For mem-loads/load-latency, we can derive them from SPE sampled data which
>> supports by load_filter and min_latency in SPE driver. and we may do some
>> work on tools/perf/builtin-mem.c.
> 
> I don't see how you could reconcile the sampling nature of SPE with a
> CPU PMU counter, particularly as filtering in SPE happens /after/ sampling.
> 

Jiri, can you give some implementations of perf-mem on mem-stores and
PEBS please?

>> From the above conditions, it seems that we may have the opportunity to
>> support the perf-mem command on arm64.
>> I'm not very sure about it, so I send this RFC and any comments are welcome.
> 
> I don't think there's enough information here to comment meaningfully more
> than SPE != PEBS.

We can get load-latency from SPE now and want to throw the thoughts whether
we should do perf-mem on arm64.

Thanks,
Shaokun

> 
> Will
> 
> .
> 

