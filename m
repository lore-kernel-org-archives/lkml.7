Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B5C8C3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 06:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFAEA22CED
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 06:55:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728916AbfIDGzk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 02:55:40 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5752 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728108AbfIDGzj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 02:55:39 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id AF7C5289D78F9B0A6FE1;
        Wed,  4 Sep 2019 14:55:33 +0800 (CST)
Received: from [127.0.0.1] (10.133.217.236) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Wed, 4 Sep 2019
 14:55:24 +0800
Subject: Re: [PATCH 2/2] sched/debug: add sched_update_nr_running tracepoint
To:     Valentin Schneider <valentin.schneider@arm.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        <linux-kernel@vger.kernel.org>
CC:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        =?UTF-8?Q?Jirka_Hladk=c3=bd?= <jhladky@redhat.com>,
        =?UTF-8?B?SmnFmcOtIFZvesOhcg==?= <jvozar@redhat.com>,
        <x86@kernel.org>, "Qais Yousef" <qais.yousef@arm.com>,
        "chengjian (D)" <cj.chengjian@huawei.com>,
        "Xiexiuqi (Xie XiuQi)" <xiexiuqi@huawei.com>,
        Li Bin <huawei.libin@huawei.com>, <bobo.shaobowang@huawei.com>
References: <20190903154340.860299-1-rkrcmar@redhat.com>
 <20190903154340.860299-3-rkrcmar@redhat.com>
 <a2924d91-df68-42de-0709-af53649346d5@arm.com>
From:   "chengjian (D)" <cj.chengjian@huawei.com>
Message-ID: <0201ac65-5a0b-9222-ac2b-a3bc1366e2c1@huawei.com>
Date:   Wed, 4 Sep 2019 14:55:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <a2924d91-df68-42de-0709-af53649346d5@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.133.217.236]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/9/4 0:05, Valentin Schneider wrote:
> On 03/09/2019 16:43, Radim Krčmář wrote:
>> The paper "The Linux Scheduler: a Decade of Wasted Cores" used several
>> custom data gathering points to better understand what was going on in
>> the scheduler.
>> Red Hat adapted one of them for the tracepoint framework and created a
>> tool to plot a heatmap of nr_running, where the sched_update_nr_running
>> tracepoint is being used for fine grained monitoring of scheduling
>> imbalance.
>> The tool is available from https://github.com/jirvoz/plot-nr-running.
>>
>> The best place for the tracepoints is inside the add/sub_nr_running,
>> which requires some shenanigans to make it work as they are defined
>> inside sched.h.
>> The tracepoints have to be included from sched.h, which means that
>> CREATE_TRACE_POINTS has to be defined for the whole header and this
>> might cause problems if tree-wide headers expose tracepoints in sched.h
>> dependencies, but I'd argue it's the other side's misuse of tracepoints.
>>
>> Moving the import sched.h line lower would require fixes in s390 and ppc
>> headers, because they don't include dependecies properly and expect
>> sched.h to do it, so it is simpler to keep sched.h there and
>> preventively undefine CREATE_TRACE_POINTS right after.
>>
>> Exports of the pelt tracepoints remain because they don't need to be
>> protected by CREATE_TRACE_POINTS and moving them closer would be
>> unsightly.
>>
> Pure trace events are frowned upon in scheduler world, try going with
> trace points. Qais did something very similar recently:
>
> https://lore.kernel.org/lkml/20190604111459.2862-1-qais.yousef@arm.com/
>
> You'll have to implement the associated trace events in a module, which
> lets you define your own event format and doesn't form an ABI :).
>
> .


Hi Radim,


Why not try Chrome Tracing

1--Record trace data, scheduling, irq, etc.
     You can Produce a JSON file with the format expected by Chrome
     OR
     just save the captured data directly as "xxx.html", it can still work.
     cat /sys/kernel/debug/tracing/trace > trace.html
2--Go to chrome://tracing in Chrome,
3--Click "Load" and open your file, or alternatively drag the file into 
Chrome,
4--Profit!


Systrace (Android System Trace) captures and displays execution times of 
your app's
processes and other Android system processes, fortunately, there are 
some ported
versions for Linux Desktop/Server.

https://github.com/gatieme/systrace



references--
https://www.chromium.org/developers/how-tos/trace-event-profiling-tool
https://www.chromium.org/developers/how-tos/trace-event-profiling-tool/trace-event-reading


Thanks,
     - Cheng Jian.


