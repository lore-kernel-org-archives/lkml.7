Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEE14C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 18:04:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABDAF20803
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 18:04:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbfKOSEx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 13:04:53 -0500
Received: from mga11.intel.com ([192.55.52.93]:31139 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726182AbfKOSEx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 13:04:53 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Nov 2019 10:04:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,309,1569308400"; 
   d="scan'208";a="203644131"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga007.fm.intel.com with ESMTP; 15 Nov 2019 10:04:52 -0800
Received: from [10.251.5.106] (kliang2-mobl.ccr.corp.intel.com [10.251.5.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id AE057580472;
        Fri, 15 Nov 2019 10:04:51 -0800 (PST)
Subject: Re: [PATCH] perf/x86/intel: Avoid PEBS_ENABLE MSR access in PMI
From:   "Liang, Kan" <kan.liang@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     acme@redhat.com, mingo@kernel.org, linux-kernel@vger.kernel.org,
        ak@linux.intel.com, eranian@google.com
References: <20191115133917.24424-1-kan.liang@linux.intel.com>
 <20191115140739.GM4131@hirez.programming.kicks-ass.net>
 <c0f562aa-39f3-1291-edd7-17c46178d1e3@linux.intel.com>
Message-ID: <3e117702-c07f-bd58-9931-766c2698b5d7@linux.intel.com>
Date:   Fri, 15 Nov 2019 13:04:50 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <c0f562aa-39f3-1291-edd7-17c46178d1e3@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/15/2019 9:46 AM, Liang, Kan wrote:
> 
> 
> On 11/15/2019 9:07 AM, Peter Zijlstra wrote:
>> On Fri, Nov 15, 2019 at 05:39:17AM -0800, kan.liang@linux.intel.com 
>> wrote:
>>> From: Kan Liang <kan.liang@linux.intel.com>
>>>
>>> The perf PMI handler, intel_pmu_handle_irq(), currently does
>>> unnecessary MSR accesses when PEBS is enabled.
>>>
>>> When entering the handler, global ctrl is explicitly disabled. All
>>> counters do not count anymore. It doesn't matter if the PEBS is
>>> enabled or disabled. Furthermore, cpuc->pebs_enabled is not changed
>>> in PMI. The PEBS status doesn't change. The PEBS_ENABLE MSR doesn't need
>>> to be changed either.
>>
>> PMI can throttle, and iirc x86_pmu_stop() ends up in
>> intel_pmu_pebs_disable()
>>
> 
> Right, the declaration is inaccurate. I will fix it in v2.
> But the patch still works for the case of PMI throttle.
> The intel_pmu_pebs_disable() will update cpuc->pebs_enabled and 
> unconditionally modify MSR_IA32_PEBS_ENABLE.

It seems not true for a corner case.
PMI may land after cpuc->enabled=0 in x86_pmu_disable() and PMI throttle 
may be triggered for the PMI. For this rare case, 
intel_pmu_pebs_disable() will not touch MSR_IA32_PEBS_ENABLE.

I don't have a test case for this rare corner case. But I think we may 
have to handle it in PMI handler as well. I will add the codes as below 
to V2.

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index bc6468329c52..7198a372a5ab 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2620,6 +2624,15 @@ static int handle_pmi_common(struct pt_regs 
*regs, u64 status)
                 handled++;
                 x86_pmu.drain_pebs(regs);
                 status &= x86_pmu.intel_ctrl | GLOBAL_STATUS_TRACE_TOPAPMI;
+
+               /*
+                * PMI may land after cpuc->enabled=0 in 
x86_pmu_disable() and
+                * PMI throttle may be triggered for the PMI.
+                * For this rare case, intel_pmu_pebs_disable() will not 
touch
+                * MSR_IA32_PEBS_ENABLE. Explicitly disable the PEBS here.
+                */
+               if (unlikely(!cpuc->enabled && !cpuc->pebs_enabled))
+                       wrmsrl(MSR_IA32_PEBS_ENABLE, 0);
         }


Thanks,
Kan

> When exiting the handler, current perf re-write the PEBS MSR according 
> to the updated cpuc->pebs_enabled, which is still unnecessary.
> 

