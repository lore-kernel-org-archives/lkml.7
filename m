Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8433DC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 14:21:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CF6A206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 14:21:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbfCTOVA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 10:21:00 -0400
Received: from mga05.intel.com ([192.55.52.43]:29772 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725966AbfCTOVA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 10:21:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Mar 2019 07:20:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,249,1549958400"; 
   d="scan'208";a="153452168"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga002.fm.intel.com with ESMTP; 20 Mar 2019 07:20:59 -0700
Received: from [10.254.87.179] (kliang2-mobl1.ccr.corp.intel.com [10.254.87.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 845FA5804B6;
        Wed, 20 Mar 2019 07:20:58 -0700 (PDT)
Subject: Re: [PATCH 06/22] perf/x86/intel: Add Icelake support
To:     Stephane Eranian <eranian@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>
References: <20190318214144.4639-1-kan.liang@linux.intel.com>
 <20190318214144.4639-7-kan.liang@linux.intel.com>
 <CABPqkBR-2e47Anf2RhMcmFmACpvxPTgNLGGPQU2VXdbES=EkaA@mail.gmail.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <8e935e1d-dbbe-6e02-bda0-8b217bdbb5b8@linux.intel.com>
Date:   Wed, 20 Mar 2019 10:20:57 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <CABPqkBR-2e47Anf2RhMcmFmACpvxPTgNLGGPQU2VXdbES=EkaA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/19/2019 8:08 PM, Stephane Eranian wrote:
> On Mon, Mar 18, 2019 at 2:44 PM <kan.liang@linux.intel.com> wrote:
>>
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> Add Icelake core PMU perf code, including constraint tables and the main
>> enable code.
>>
>> Icelake expanded the generic counters to always 8 even with HT on, but a
>> range of events cannot be scheduled on the extra 4 counters.
>> Add new constraint ranges to describe this to the scheduler.
>> The number of constraints that need to be checked is larger now than
>> with earlier CPUs.
>> At some point we may need a new data structure to look them up more
>> efficiently than with linear search. So far it still seems to be
>> acceptable however.
>>
>> Icelake added a new fixed counter SLOTS. Full support for it is added
>> later in the patch series.
>>
>> The cache events table is identical to Skylake.
>>
>> Compare to PEBS instruction event on generic counter, fixed counter 0
>> has less skid. Force instruction:ppp always in fixed counter 0.
>>
>> Originally-by: Andi Kleen <ak@linux.intel.com>
>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
>> ---
>>   arch/x86/events/intel/core.c      | 111 ++++++++++++++++++++++++++++++
>>   arch/x86/events/intel/ds.c        |  26 ++++++-
>>   arch/x86/events/perf_event.h      |   2 +
>>   arch/x86/include/asm/intel_ds.h   |   2 +-
>>   arch/x86/include/asm/perf_event.h |   2 +-
>>   5 files changed, 139 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
>> index 8486ab87f8f8..87dafac87520 100644
>> --- a/arch/x86/events/intel/core.c
>> +++ b/arch/x86/events/intel/core.c
>> @@ -239,6 +239,35 @@ static struct extra_reg intel_skl_extra_regs[] __read_mostly = {
>>          EVENT_EXTRA_END
>>   };
>>
>> +static struct event_constraint intel_icl_event_constraints[] = {
>> +       FIXED_EVENT_CONSTRAINT(0x00c0, 0),      /* INST_RETIRED.ANY */
>> +       INTEL_UEVENT_CONSTRAINT(0x1c0, 0),      /* INST_RETIRED.PREC_DIST */
>> +       FIXED_EVENT_CONSTRAINT(0x003c, 1),      /* CPU_CLK_UNHALTED.CORE */
>> +       FIXED_EVENT_CONSTRAINT(0x0300, 2),      /* CPU_CLK_UNHALTED.REF */
>> +       FIXED_EVENT_CONSTRAINT(0x0400, 3),      /* SLOTS */
>> +       INTEL_EVENT_CONSTRAINT_RANGE(0x03, 0x0a, 0xf),
>> +       INTEL_EVENT_CONSTRAINT_RANGE(0x1f, 0x28, 0xf),
>> +       INTEL_EVENT_CONSTRAINT(0x32, 0xf),      /* SW_PREFETCH_ACCESS.* */
>> +       INTEL_EVENT_CONSTRAINT_RANGE(0x48, 0x54, 0xf),
>> +       INTEL_EVENT_CONSTRAINT_RANGE(0x60, 0x8b, 0xf),
>> +       INTEL_UEVENT_CONSTRAINT(0x04a3, 0xff),  /* CYCLE_ACTIVITY.STALLS_TOTAL */
>> +       INTEL_UEVENT_CONSTRAINT(0x10a3, 0xff),  /* CYCLE_ACTIVITY.STALLS_MEM_ANY */
>> +       INTEL_EVENT_CONSTRAINT(0xa3, 0xf),      /* CYCLE_ACTIVITY.* */
>> +       INTEL_EVENT_CONSTRAINT_RANGE(0xa8, 0xb0, 0xf),
>> +       INTEL_EVENT_CONSTRAINT_RANGE(0xb7, 0xbd, 0xf),
>> +       INTEL_EVENT_CONSTRAINT_RANGE(0xd0, 0xe6, 0xf),
>> +       INTEL_EVENT_CONSTRAINT_RANGE(0xf0, 0xf4, 0xf),
>> +       EVENT_CONSTRAINT_END
>> +};
>> +
>> +static struct extra_reg intel_icl_extra_regs[] __read_mostly = {
>> +       INTEL_UEVENT_EXTRA_REG(0x01b7, MSR_OFFCORE_RSP_0, 0x3fffff9fffull, RSP_0),
>> +       INTEL_UEVENT_EXTRA_REG(0x01bb, MSR_OFFCORE_RSP_1, 0x3fffff9fffull, RSP_1),
>> +       INTEL_UEVENT_PEBS_LDLAT_EXTRA_REG(0x01cd),
>> +       INTEL_UEVENT_EXTRA_REG(0x01c6, MSR_PEBS_FRONTEND, 0x7fff17, FE),
>> +       EVENT_EXTRA_END
>> +};
>> +
>>   EVENT_ATTR_STR(mem-loads,      mem_ld_nhm,     "event=0x0b,umask=0x10,ldlat=3");
>>   EVENT_ATTR_STR(mem-loads,      mem_ld_snb,     "event=0xcd,umask=0x1,ldlat=3");
>>   EVENT_ATTR_STR(mem-stores,     mem_st_snb,     "event=0xcd,umask=0x2");
>> @@ -3324,6 +3353,9 @@ static struct event_constraint counter0_constraint =
>>   static struct event_constraint counter2_constraint =
>>                          EVENT_CONSTRAINT(0, 0x4, 0);
>>
>> +static struct event_constraint fixed_counter0_constraint =
>> +                       FIXED_EVENT_CONSTRAINT(0x00c0, 0);
>> +
>>   static struct event_constraint *
>>   hsw_get_event_constraints(struct cpu_hw_events *cpuc, int idx,
>>                            struct perf_event *event)
>> @@ -3342,6 +3374,21 @@ hsw_get_event_constraints(struct cpu_hw_events *cpuc, int idx,
>>          return c;
>>   }
>>
>> +static struct event_constraint *
>> +icl_get_event_constraints(struct cpu_hw_events *cpuc, int idx,
>> +                         struct perf_event *event)
>> +{
>> +       /*
>> +        * Fixed counter 0 has less skid.
>> +        * Force instruction:ppp in Fixed counter 0
>> +        */
>> +       if ((event->attr.precise_ip == 3) &&
>> +           ((event->hw.config & X86_RAW_EVENT_MASK) == 0x00c0))
>> +               return &fixed_counter0_constraint;
>> +
> Not clear to me why you need to treat this one separately from the
> PEBS constraints, if you check that you have
> :ppp (precise_ip > 0)?
> 
> 

There is no model specific get_pebs_constrains, so I have to put the 
checking here for Icelake.
We only want to force the :ppp case in fixed counter 0, which has less 
skid.

Thanks,
Kan
