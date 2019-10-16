Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55791FA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 13:39:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 336322168B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 13:39:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391950AbfJPNjJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 09:39:09 -0400
Received: from mga14.intel.com ([192.55.52.115]:23925 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730940AbfJPNjI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 09:39:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Oct 2019 06:39:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,303,1566889200"; 
   d="scan'208";a="189680155"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP; 16 Oct 2019 06:39:07 -0700
Received: from [10.125.252.157] (abudanko-mobl.ccr.corp.intel.com [10.125.252.157])
        by linux.intel.com (Postfix) with ESMTP id C2EF75804A1;
        Wed, 16 Oct 2019 06:39:04 -0700 (PDT)
Subject: Re: [PATCH v2 3/4] perf/x86/intel: implement LBR callstacks context
 synchronization
To:     "Liang, Kan" <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>,
        Song Liu <songliubraving@fb.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <5964c7e9-ab6f-c0d0-3dca-31196606e337@linux.intel.com>
 <79b0e201-479e-0e35-4ef4-3f6410ee28e4@linux.intel.com>
 <56c5408c-a217-18f3-8a0d-c0bb0886f2d3@linux.intel.com>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <b40cfea3-6df4-f7ea-b47a-c0ccf8a241f4@linux.intel.com>
Date:   Wed, 16 Oct 2019 16:39:03 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <56c5408c-a217-18f3-8a0d-c0bb0886f2d3@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.10.2019 15:20, Liang, Kan wrote:
> 
> 
> On 10/16/2019 5:50 AM, Alexey Budankov wrote:
>>
>> Implement intel_pmu_lbr_sync_task_ctx() method that updates counter
>> of the events that requested LBR callstack data on a sample.
>>
>> The counter can be zero for the case when task context belongs to
>> a thread that has just come from a block on a futex and the context
>> contains saved (lbr_stack_state == LBR_VALID) LBR register values.
>>
>> For the values to be restored at LBR registers on the next thread's
>> switch-in event it copies the counter value that is expected to be
>> non zero from the previous equivalent task perf event context.
>>
>> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
>> ---
>>   arch/x86/events/intel/lbr.c  | 9 +++++++++
>>   arch/x86/events/perf_event.h | 3 +++
>>   2 files changed, 12 insertions(+)
>>
>> diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
>> index ea54634eabf3..152a3f8b516a 100644
>> --- a/arch/x86/events/intel/lbr.c
>> +++ b/arch/x86/events/intel/lbr.c
>> @@ -417,6 +417,15 @@ static void __intel_pmu_lbr_save(struct x86_perf_task_context *task_ctx)
>>       cpuc->last_log_id = ++task_ctx->log_id;
>>   }
>>   +void intel_pmu_lbr_sync_task_ctx(struct x86_perf_task_context *one,
>> +                 struct x86_perf_task_context *another)
>> +{
>> +    if (!one || !another)
>> +        return;
>> +
>> +    one->lbr_callstack_users = another->lbr_callstack_users;
> 
> We may want to swap here?

Well, in this particular case lbr_callstack_users has to stay consistent 
with the amount of events in task perf event context that requested 
LBR callstack.

~Alexey

> 
> Thanks,
> Kan
> 
>> +}
>> +
>>   void intel_pmu_lbr_sched_task(struct perf_event_context *ctx, bool sched_in)
>>   {
>>       struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
>> diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
>> index a25e6d7eb87b..3e0087c06fc9 100644
>> --- a/arch/x86/events/perf_event.h
>> +++ b/arch/x86/events/perf_event.h
>> @@ -1024,6 +1024,9 @@ void intel_pmu_store_pebs_lbrs(struct pebs_lbr *lbr);
>>     void intel_ds_init(void);
>>   +void intel_pmu_lbr_sync_task_ctx(struct x86_perf_task_context *one,
>> +                 struct x86_perf_task_context *another);
>> +
>>   void intel_pmu_lbr_sched_task(struct perf_event_context *ctx, bool sched_in);
>>     u64 lbr_from_signext_quirk_wr(u64 val);
>>
> 
