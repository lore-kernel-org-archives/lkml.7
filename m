Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1AD2C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 10:55:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 892252089C
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 10:55:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731578AbfJOKzr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 06:55:47 -0400
Received: from mga14.intel.com ([192.55.52.115]:53449 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726054AbfJOKzq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 06:55:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Oct 2019 03:55:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,299,1566889200"; 
   d="scan'208";a="370421259"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga005.jf.intel.com with ESMTP; 15 Oct 2019 03:55:45 -0700
Received: from [10.125.253.10] (abudanko-mobl.ccr.corp.intel.com [10.125.253.10])
        by linux.intel.com (Postfix) with ESMTP id 512B0580379;
        Tue, 15 Oct 2019 03:55:42 -0700 (PDT)
Subject: Re: [PATCH v1] perf/core: fix restoring of Intel LBR call stack on a
 context switch
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>,
        Song Liu <songliubraving@fb.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <cf5b18f6-3de5-0826-15ac-8fc87b153127@linux.intel.com>
 <20191015091617.GF2311@hirez.programming.kicks-ass.net>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <aa8db567-d090-52cd-516b-e6c0002e5b23@linux.intel.com>
Date:   Tue, 15 Oct 2019 13:55:41 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191015091617.GF2311@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 15.10.2019 12:16, Peter Zijlstra wrote:
> On Mon, Oct 14, 2019 at 09:08:34AM +0300, Alexey Budankov wrote:
>>
>> Restore Intel LBR call stack from cloned inactive task perf context on
>> a context switch. This change inherently addresses inconsistency in LBR 
>> call stack data provided on a sample in record profiling mode for 
>> example like this:
>>
>>   $ perf record -N -B -T -R --call-graph lbr \
>>          -e cpu/period=0xcdfe60,event=0x3c,name=\'CPU_CLK_UNHALTED.THREAD\'/Duk \
>>          --clockid=monotonic_raw -- ./miniFE.x nx 25 ny 25 nz 25
>>
>> Let's assume threads A, B, C belonging to the same process. 
>> B and C are siblings of A and their perf contexts are treated as equivalent.
>> At some point B blocks on a futex (non preempt context switch).
>> B's LBRs are preserved at B's perf context task_ctx_data and B's events 
>> are removed from PMU and disabled. B's perf context becomes inactive.
>>
>> Later C gets on a cpu, runs, gets profiled and eventually switches to 
>> the awaken but not yet running B. The optimized context switch path is 
>> executed coping B's task_ctx_data to C's one and updating B's perf context 
>> pointer to refer to C's task_ctx_data that contains preserved B's LBRs 
>> after coping.
>>
>> However, as far B's perf context is inactive there is no enabled events
>> in there and B's task_ctx_data->lbr_callstack_users is equal to 0.
>> When B gets on the cpu B's events reviving is skipped following
>> the optimized context switch path and B's task_ctx_data->lbr_callstack_users
>> remains 0. Thus B's LBR's are not restored by pmu sched_task() code called 
>> in the end of perf context switch sched_in callback for B.
>>
>> In the report that manifests as having short fragments of B's
>> call stack, still tracked by LBR's HW between adjacent samples,
>> but the whole thread call tree doesn't aggregate.
>>
> 
>> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
>> ---
>>  kernel/events/core.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>> index 2aad959e6def..74c2ff38e079 100644
>> --- a/kernel/events/core.c
>> +++ b/kernel/events/core.c
>> @@ -3181,7 +3181,7 @@ static void perf_event_context_sched_out(struct task_struct *task, int ctxn,
>>  
>>  	rcu_read_lock();
>>  	next_ctx = next->perf_event_ctxp[ctxn];
>> -	if (!next_ctx)
>> +	if (!next_ctx || !next_ctx->is_active)
>>  		goto unlock;
> 
> AFAICT this completely kills off the optimization. next_ctx->is_active
> cannot be set at this point.

Hmm, the intention was to skip optimization path only once when switching 
to just resumed thread. Thanks for observation.

~Alexey
