Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ED51C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 20:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37E2F20715
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 20:50:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbfKNUuD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 15:50:03 -0500
Received: from mga14.intel.com ([192.55.52.115]:39957 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726567AbfKNUuC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 15:50:02 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Nov 2019 12:50:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,305,1569308400"; 
   d="scan'208";a="379703989"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga005.jf.intel.com with ESMTP; 14 Nov 2019 12:50:01 -0800
Received: from [10.251.18.41] (kliang2-mobl.ccr.corp.intel.com [10.251.18.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id F02235802B1;
        Thu, 14 Nov 2019 12:49:58 -0800 (PST)
Subject: Re: [PATCH v3 10/10] perf/cgroup: Do not switch system-wide events in
 cgroup switch
From:   "Liang, Kan" <kan.liang@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ian Rogers <irogers@google.com>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Petr Mladek <pmladek@suse.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Qian Cai <cai@lca.pw>, Joe Lawrence <joe.lawrence@redhat.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Sri Krishna chowdary <schowdary@nvidia.com>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Changbin Du <changbin.du@intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Gary Hook <Gary.Hook@amd.com>, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>
References: <20191114003042.85252-1-irogers@google.com>
 <20191114003042.85252-11-irogers@google.com>
 <20191114104340.GT4131@hirez.programming.kicks-ass.net>
 <710edaf6-2562-0f53-15d6-dc50885b8e08@linux.intel.com>
 <20191114135718.GX4131@hirez.programming.kicks-ass.net>
 <97cb578c-d302-9be3-5fe6-b2030b318bcc@linux.intel.com>
 <4bc51bf9-1d47-063a-e811-d05fb42c8838@linux.intel.com>
Message-ID: <94c8c876-f236-7052-24ef-536f6870a8d5@linux.intel.com>
Date:   Thu, 14 Nov 2019 15:49:57 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <4bc51bf9-1d47-063a-e811-d05fb42c8838@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/14/2019 10:24 AM, Liang, Kan wrote:
> 
> 
> On 11/14/2019 10:16 AM, Liang, Kan wrote:
>>
>>
>> On 11/14/2019 8:57 AM, Peter Zijlstra wrote:
>>> On Thu, Nov 14, 2019 at 08:46:51AM -0500, Liang, Kan wrote:
>>>>
>>>>
>>>> On 11/14/2019 5:43 AM, Peter Zijlstra wrote:
>>>>> On Wed, Nov 13, 2019 at 04:30:42PM -0800, Ian Rogers wrote:
>>>>>> From: Kan Liang <kan.liang@linux.intel.com>
>>>>>>
>>>>>> When counting system-wide events and cgroup events simultaneously, 
>>>>>> the
>>>>>> system-wide events are always scheduled out then back in during 
>>>>>> cgroup
>>>>>> switches, bringing extra overhead and possibly missing events. 
>>>>>> Switching
>>>>>> out system wide flexible events may be necessary if the scheduled in
>>>>>> task's cgroups have pinned events that need to be scheduled in at 
>>>>>> a higher
>>>>>> priority than the system wide flexible events.
>>>>>
>>>>> I'm thinking this patch is actively broken. groups->index 'group' wide
>>>>> and therefore across cpu/cgroup boundaries.
>>>>>
>>>>> There is no !cgroup to cgroup hierarchy as this patch seems to assume,
>>>>> specifically look at how the merge sort in visit_groups_merge() allows
>>>>> cgroup events to be picked before !cgroup events.
>>>>
>>>>
>>>> No, the patch intends to avoid switch !cgroup during cgroup context 
>>>> switch.
>>>
>>> Which is wrong.
>>>
>> Why we want to switch !cgroup system-wide event in context switch?
>>
>> How should current perf handle this case?
> 

It seems hard to find a simple case to explain why we should not switch 
!cgroup during cgroup context switch.

Let me try to explain it using ftrace.

Case 1:
User A do system-wide monitoring for 1 second. No other users.
      #perf stat -e branches -a -- sleep 1

The counter counts between 765531.617703 and 765532.620184.
Everything is collected.

            <...>-59160 [027] d.h. 765531.617697: write_msr: 
MSR_CORE_PERF_GLOBAL_CTRL(38f), value 0
            <...>-59160 [027] d.h. 765531.617701: write_msr: 
MSR_IA32_PMC0(4c1), value 800000000001
            <...>-59160 [027] d.h. 765531.617702: write_msr: 
MSR_P6_EVNTSEL0(186), value 5300c4
            <...>-59160 [027] d.h. 765531.617703: write_msr: 
MSR_CORE_PERF_GLOBAL_CTRL(38f), value 70000000f
           <idle>-0     [027] d.h. 765532.620184: write_msr: 
MSR_CORE_PERF_GLOBAL_CTRL(38f), value 0
           <idle>-0     [027] d.h. 765532.620185: write_msr: 
MSR_P6_EVNTSEL0(186), value 1300c4
           <idle>-0     [027] d.h. 765532.620186: rdpmc: 0, value 
80000b3e87a4
           <idle>-0     [027] d.h. 765532.620187: write_msr: 
MSR_CORE_PERF_GLOBAL_CTRL(38f), value 70000000f


Case 2:
User A do system-wide monitoring for 1 second.
      #perf stat -e branches -a -- sleep 1
At the meantime, User B do cgroup monitoring.
      #perf stat -e cycles -G cgroup

The User A expects to collect everything from 765580.196521 to 
765581.198150. But it doesn't.

Because of cgroup context switch, the system-wide event for user A stops 
counting at [765580.213882, 765580.213884],
[765580.213913, 765580.213915], ..., [765580.774304, 765580.774307].

I think it breaks the usage of User A.

Furthermore, switching !cgroup system-wide event also brings extra 
overhead, which is unnecessary.

            <...>-121292 [027] d.h. 765580.196514: write_msr: 
MSR_CORE_PERF_GLOBAL_CTRL(38f), value 0
            <...>-121292 [027] d.h. 765580.196519: write_msr: 
MSR_IA32_PMC0(4c1), value 800000000001
            <...>-121292 [027] d.h. 765580.196520: write_msr: 
MSR_P6_EVNTSEL0(186), value 5300c4
            <...>-121292 [027] d.h. 765580.196521: write_msr: 
MSR_CORE_PERF_GLOBAL_CTRL(38f), value 70000000f
           <idle>-0     [027] d... 765580.213878: write_msr: 
MSR_CORE_PERF_GLOBAL_CTRL(38f), value 0
           <idle>-0     [027] d... 765580.213880: write_msr: 
MSR_P6_EVNTSEL0(186), value 1300c4
           <idle>-0     [027] d... 765580.213880: rdpmc: 0, value 
800000357bc1
           <idle>-0     [027] d... 765580.213882: write_msr: 
MSR_CORE_PERF_GLOBAL_CTRL(38f), value 70000000f
      simics-poll-25601 [027] d... 765580.213884: write_msr: 
MSR_CORE_PERF_GLOBAL_CTRL(38f), value 0
      simics-poll-25601 [027] d... 765580.213888: write_msr: 
MSR_CORE_PERF_FIXED_CTR1(30a), value 800015820cbe
      simics-poll-25601 [027] d... 765580.213889: read_msr: 
MSR_CORE_PERF_FIXED_CTR_CTRL(38d), value 0
      simics-poll-25601 [027] d... 765580.213890: write_msr: 
MSR_CORE_PERF_FIXED_CTR_CTRL(38d), value b0
      simics-poll-25601 [027] d... 765580.213890: write_msr: 
MSR_IA32_PMC0(4c1), value 800000357bc1
      simics-poll-25601 [027] d... 765580.213891: write_msr: 
MSR_P6_EVNTSEL0(186), value 5300c4
      simics-poll-25601 [027] d... 765580.213892: write_msr: 
MSR_CORE_PERF_GLOBAL_CTRL(38f), value 70000000f
      simics-poll-25601 [027] d... 765580.213910: write_msr: 
MSR_CORE_PERF_GLOBAL_CTRL(38f), value 0
      simics-poll-25601 [027] d... 765580.213911: read_msr: 
MSR_CORE_PERF_FIXED_CTR_CTRL(38d), value b0
      simics-poll-25601 [027] d... 765580.213911: write_msr: 
MSR_CORE_PERF_FIXED_CTR_CTRL(38d), value 0
      simics-poll-25601 [027] d... 765580.213911: rdpmc: 40000001, value 
80001582b676
      simics-poll-25601 [027] d... 765580.213912: write_msr: 
MSR_P6_EVNTSEL0(186), value 1300c4
      simics-poll-25601 [027] d... 765580.213913: rdpmc: 0, value 
800000358491
      simics-poll-25601 [027] d... 765580.213913: write_msr: 
MSR_CORE_PERF_GLOBAL_CTRL(38f), value 70000000f
           <idle>-0     [027] d... 765580.213915: write_msr: 
MSR_CORE_PERF_GLOBAL_CTRL(38f), value 0
           <idle>-0     [027] d... 765580.213916: write_msr: 
MSR_IA32_PMC0(4c1), value 800000358491
           <idle>-0     [027] d... 765580.213916: write_msr: 
MSR_P6_EVNTSEL0(186), value 5300c4
           <idle>-0     [027] d... 765580.213917: write_msr: 
MSR_CORE_PERF_GLOBAL_CTRL(38f), value 70000000f

... ...

      simics-poll-25601 [027] d... 765580.774301: write_msr: 
MSR_CORE_PERF_GLOBAL_CTRL(38f), value 0
      simics-poll-25601 [027] d... 765580.774302: read_msr: 
MSR_CORE_PERF_FIXED_CTR_CTRL(38d), value b0
      simics-poll-25601 [027] d... 765580.774302: write_msr: 
MSR_CORE_PERF_FIXED_CTR_CTRL(38d), value 0
      simics-poll-25601 [027] d... 765580.774302: rdpmc: 40000001, value 
8000165e927b
      simics-poll-25601 [027] d... 765580.774303: write_msr: 
MSR_P6_EVNTSEL0(186), value 1300c4
      simics-poll-25601 [027] d... 765580.774303: rdpmc: 0, value 
8000059298ce
      simics-poll-25601 [027] d... 765580.774304: write_msr: 
MSR_CORE_PERF_GLOBAL_CTRL(38f), value 70000000f
            <...>-135379 [027] d... 765580.774307: write_msr: 
MSR_CORE_PERF_GLOBAL_CTRL(38f), value 0
            <...>-135379 [027] d... 765580.774308: write_msr: 
MSR_IA32_PMC0(4c1), value 8000059298ce
            <...>-135379 [027] d... 765580.774309: write_msr: 
MSR_P6_EVNTSEL0(186), value 5300c4
            <...>-135379 [027] d... 765580.774309: write_msr: 
MSR_CORE_PERF_GLOBAL_CTRL(38f), value 70000000f
            <...>-147127 [027] d.h. 765581.198150: write_msr: 
MSR_CORE_PERF_GLOBAL_CTRL(38f), value 0
            <...>-147127 [027] d.h. 765581.198153: write_msr: 
MSR_P6_EVNTSEL0(186), value 1300c4
            <...>-147127 [027] d.h. 765581.198153: rdpmc: 0, value 
80000a573368
            <...>-147127 [027] d.h. 765581.198155: write_msr: 
MSR_CORE_PERF_GLOBAL_CTRL(38f), value 70000000f


Thanks,
Kan





