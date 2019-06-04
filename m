Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3888C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 20:39:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1CE420848
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 20:39:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbfFDUjM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 16:39:12 -0400
Received: from mga02.intel.com ([134.134.136.20]:2470 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726293AbfFDUjL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 16:39:11 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jun 2019 13:39:11 -0700
X-ExtLoop1: 1
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga007.fm.intel.com with ESMTP; 04 Jun 2019 13:39:10 -0700
Received: from [10.254.95.103] (kliang2-mobl.ccr.corp.intel.com [10.254.95.103])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id A5B775803EA;
        Tue,  4 Jun 2019 13:39:09 -0700 (PDT)
Subject: Re: [PATCH 4/9] perf/x86/intel: Support hardware TopDown metrics
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     acme@kernel.org, mingo@redhat.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com
References: <20190521214055.31060-1-kan.liang@linux.intel.com>
 <20190521214055.31060-5-kan.liang@linux.intel.com>
 <20190528134354.GP2623@hirez.programming.kicks-ass.net>
 <561ec469-2e0b-4749-c184-d07e4f4eaf40@linux.intel.com>
 <20190529075426.GA2623@hirez.programming.kicks-ass.net>
 <110d6e3e-9f50-ad47-5a12-1ccf0b756602@linux.intel.com>
 <20190529165813.GC2623@hirez.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <4315f4af-9357-e967-947e-ff7c3005ab85@linux.intel.com>
Date:   Tue, 4 Jun 2019 16:39:08 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190529165813.GC2623@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/29/2019 12:58 PM, Peter Zijlstra wrote:
> On Wed, May 29, 2019 at 10:42:10AM -0400, Liang, Kan wrote:
>> On 5/29/2019 3:54 AM, Peter Zijlstra wrote:
> 
>>> cd09c0c40a97 ("perf events: Enable raw event support for Intel unhalted_reference_cycles event")
>>>
>>> We used the fake event=0x00, umask=0x03 for CPU_CLK_UNHALTED.REF_TSC,
>>> because that was not available as a generic event, *until now* it seems.
>>> I see ICL actually has it as a generic event, which means we need to fix
>>> up the constraint mask for that differently.
>>>
>>
>> There is no change for REF_TSC on ICL.
> 
> Well, if I look at the SDM for May'19 (latest afaict), Volume 3, Chapter
> 19.3 'Performance Monitoring Events for Future Intel (C) Core(tm)
> Processors' the table lists:
> 
>   Event Num.	Umask Value	Event Mask Mnemonic
> 
>   00H		03H		CPU_CLK_UNHALTED.REF_TSC
> 
> as a generic event, without constraints, unlike any of the preceding
> uarchs, where that event was not available except through FIXED2.
> 
> That is most certainly a change.

I checked with our internal team. They confirmed that there is no change 
for REF_TSC on ICL.
They will fix the comment in the next SDM update.
Thanks for bringing this up.

> 
>>> But note that for all previous uarchs this event did not in fact exist.
>>>
>>> It appears the TOPDOWN.SLOTS thing, which is available in in FIXED3 is
>>> event=0x00, umask=0x04, is indeed a generic event too.
>>
>> The SLOTS do have a generic event, TOPDOWN.SLOTS_P, event=0xA4, umask=0x1.
>>
>> I think we need a fix as below for ICL, so the SLOT event can be extended to
>> generic event.
>> -	FIXED_EVENT_CONSTRAINT(0x0400, 3),	/* SLOTS */
>> +	FIXED_EVENT_CONSTRAINT(0x01a4, 3),	/* TOPDOWN.SLOTS */
> 
> Then WTH is that 00H, 04H event listed in the table? Note the distinct
> lack of 'Fixed Counter' or any other contraints in the 'Comments'
> column.
>

TOPDOWN.SLOTS(0x0400) is only available on FIXED3. It's not a generic 
event. The equivalent event for GP counters is TOPDOWN.SLOTS_P (0x01a4).
But it's not architectural event.
So I think the best way is to force TOPDOWN.SLOTS(0x0400) only in 
FIXED3. The patch as below will do so.


 From 22e3ed25340e4f46685a059cf2184747a3e02a47 Mon Sep 17 00:00:00 2001
From: Kan Liang <kan.liang@linux.intel.com>
Date: Tue, 4 Jun 2019 10:36:08 -0700
Subject: [PATCH] perf/x86/intel: Set correct mask for TOPDOWN.SLOTS

TOPDOWN.SLOTS(0x0400) is not a generic event. It is only available on
fixed counter3.

Don't extend its mask to generic counters.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
  arch/x86/events/intel/core.c      | 6 ++++--
  arch/x86/include/asm/perf_event.h | 5 +++++
  2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 4377bf6a6f82..f30d02830921 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -5066,12 +5066,14 @@ __init int intel_pmu_init(void)

  	if (x86_pmu.event_constraints) {
  		/*
-		 * event on fixed counter2 (REF_CYCLES) only works on this
+		 * event on fixed counter2 (REF_CYCLES) and
+		 * fixed counter3 (TOPDOWN.SLOTS) only work on this
  		 * counter, so do not extend mask to generic counters
  		 */
  		for_each_event_constraint(c, x86_pmu.event_constraints) {
  			if (c->cmask == FIXED_EVENT_FLAGS
-			    && c->idxmsk64 != INTEL_PMC_MSK_FIXED_REF_CYCLES) {
+			    && c->idxmsk64 != INTEL_PMC_MSK_FIXED_REF_CYCLES
+			    && c->idxmsk64 != INTEL_PMC_MSK_FIXED_SLOTS) {
  				c->idxmsk64 |= (1ULL << x86_pmu.num_counters) - 1;
  			}
  			c->idxmsk64 &=
diff --git a/arch/x86/include/asm/perf_event.h 
b/arch/x86/include/asm/perf_event.h
index 1392d5e6e8d6..457d35a75ad3 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -167,6 +167,11 @@ struct x86_pmu_capability {
  #define INTEL_PMC_IDX_FIXED_REF_CYCLES	(INTEL_PMC_IDX_FIXED + 2)
  #define INTEL_PMC_MSK_FIXED_REF_CYCLES	(1ULL << 
INTEL_PMC_IDX_FIXED_REF_CYCLES)

+/* TOPDOWN.SLOTS: */
+#define MSR_ARCH_PERFMON_FIXED_CTR3	0x30c
+#define INTEL_PMC_IDX_FIXED_SLOTS	(INTEL_PMC_IDX_FIXED + 3)
+#define INTEL_PMC_MSK_FIXED_SLOTS	(1ULL << INTEL_PMC_IDX_FIXED_SLOTS)
+
  /*
   * We model BTS tracing as another fixed-mode PMC.
   *
-- 
2.14.5

Thanks,
Kan



