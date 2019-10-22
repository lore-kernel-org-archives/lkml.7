Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24CA5CA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 12:49:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01CFF2075A
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 12:49:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388819AbfJVMtO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 08:49:14 -0400
Received: from mga05.intel.com ([192.55.52.43]:27473 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388069AbfJVMtO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 08:49:14 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Oct 2019 05:49:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,327,1566889200"; 
   d="scan'208";a="349047112"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga004.jf.intel.com with ESMTP; 22 Oct 2019 05:49:13 -0700
Received: from [10.125.253.19] (abudanko-mobl.ccr.corp.intel.com [10.125.253.19])
        by linux.intel.com (Postfix) with ESMTP id B9B1758029F;
        Tue, 22 Oct 2019 05:49:10 -0700 (PDT)
Subject: Re: [PATCH v4 4/4] perf/core,x86: synchronize PMU task contexts on
 optimized context switches
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
References: <f4662ac9-e72e-d141-bead-da07e29f81e8@linux.intel.com>
 <4d6320bb-0d15-0028-aefb-a176c986b8db@linux.intel.com>
 <20191022094300.GL1817@hirez.programming.kicks-ass.net>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <fa9ffa1f-21d0-b918-d66f-b0a20af00eab@linux.intel.com>
Date:   Tue, 22 Oct 2019 15:49:09 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191022094300.GL1817@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 22.10.2019 12:43, Peter Zijlstra wrote:
> On Tue, Oct 22, 2019 at 09:01:11AM +0300, Alexey Budankov wrote:
> 
>>  			swap(ctx->task_ctx_data, next_ctx->task_ctx_data);
>>  
>> +			/*
>> +			 * PMU specific parts of task perf context can require
>> +			 * additional synchronization which makes sense only if
>> +			 * both next_ctx->task_ctx_data and ctx->task_ctx_data
>> +			 * pointers are allocated. As an example of such
>> +			 * synchronization see implementation details of Intel
>> +			 * LBR call stack data profiling;
>> +			 */
>> +			if (ctx->task_ctx_data && next_ctx->task_ctx_data)
>> +				pmu->sync_task_ctx(next_ctx->task_ctx_data,
>> +						   ctx->task_ctx_data);
> 
> This still does not check if pmu->sync_task_ctx is set. If any other
> arch ever uses task_ctx_data without then also supplying this method
> things will go *bang*.
> 
> Also, I think I prefer the variant I gave you yesterday:
> 
>   https://lkml.kernel.org/r/20191021103745.GF1800@hirez.programming.kicks-ass.net
> 
> 	if (pmu->swap_task_ctx)
> 		pmu->swap_task_ctx(ctx, next_ctx);
> 	else
> 		swap(ctx->task_ctx_data, next_ctx->task_ctx_data);
> 
> That also unconfuses the argument order in your above patch (where you
> have to undo thw swap).
> 
> Alternatively, since there currently is no other arch using
> task_ctx_data, we can make the pmu::swap_task_ctx() thing mandatory when
> having it and completely replace the swap(), write it like so:
> 
> 
> -	swap(ctx->task_ctx_data, next_ctx->task_ctx_data);

It still has to be swapped unconditionally. Thus, it will be a part of 
architecture specific implementation:

void intel_pmu_lbr_sync_task_ctx(struct x86_perf_task_context **prev,
				 struct x86_perf_task_context **next)
{
	if (*prev && *next) {
		swap(*prev->lbr_callstack_users, *next->lbr_callstack_users);
                ...
        }
	swap(prev, next);
}


> +	if (pmu->swap_task_ctx)
> +		pmu->swap_task_ctx(ctx, next_ctx);
> 
> Hmm?

This option above looks attractive because it pushes complexity down 
towards architecture specific implementation.

However, in order to keep the existing performance at the same level
if (ctx->task_ctx_data && next_ctx->task_ctx_data) check has to be 
preserved as closer to the top layer as possible. So the fastest version
appears to look like this:

swap(ctx->task_ctx_data, next_ctx->task_ctx_data);
if (ctx->task_ctx_data && next_ctx->task_ctx_data && pmu->sync_task_ctx)
	pmu->sync_task_ctx(next_ctx->task_ctx_data, ctx->task_ctx_data);

If some architecture needs specific synchronization then it is enough 
to implement sync_task_ctx() without changing the core.

~Alexey
