Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DDB3CA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 11:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64B4C207FC
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 11:40:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388764AbfJVLkK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 07:40:10 -0400
Received: from mga01.intel.com ([192.55.52.88]:6512 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387965AbfJVLkJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 07:40:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Oct 2019 04:40:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,326,1566889200"; 
   d="scan'208";a="349030713"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga004.jf.intel.com with ESMTP; 22 Oct 2019 04:40:09 -0700
Received: from [10.125.253.19] (abudanko-mobl.ccr.corp.intel.com [10.125.253.19])
        by linux.intel.com (Postfix) with ESMTP id 7508758048F;
        Tue, 22 Oct 2019 04:40:06 -0700 (PDT)
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
Message-ID: <50f1e2d5-3960-015c-c7e3-e850a17207ef@linux.intel.com>
Date:   Tue, 22 Oct 2019 14:40:05 +0300
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

Argh, and that is why it is documented as the optional one.
Undoubtedly, we have to avoid crashes on other architectures.
So "if (pmu->sync_task_ctx)" has to be a part of v5.

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

I would name the method sync_task_ctx not swap_task_ctx because sync reserves 
broader meaning, IMHO.

~Alexey
