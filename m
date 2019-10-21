Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADE49CA9EB0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 10:00:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 852CF20684
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 10:00:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbfJUKAg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 06:00:36 -0400
Received: from mga14.intel.com ([192.55.52.115]:59418 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726725AbfJUKAe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 06:00:34 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Oct 2019 03:00:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,323,1566889200"; 
   d="scan'208";a="209298198"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga002.jf.intel.com with ESMTP; 21 Oct 2019 03:00:34 -0700
Received: from [10.125.253.9] (abudanko-mobl.ccr.corp.intel.com [10.125.253.9])
        by linux.intel.com (Postfix) with ESMTP id D85C158029D;
        Mon, 21 Oct 2019 03:00:30 -0700 (PDT)
Subject: Re: [PATCH v3 4/4] perf/core,x86: synchronize PMU task contexts on
 optimized context switches
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
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
References: <0b20a07f-d074-d3da-7551-c9a4a94fe8e3@linux.intel.com>
 <f3253a36-c174-8051-a462-9728ef721766@linux.intel.com>
 <20191021075942.GA8809@gmail.com>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <63666e0d-176a-0780-97b8-9be7ef6f7aed@linux.intel.com>
Date:   Mon, 21 Oct 2019 13:00:29 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191021075942.GA8809@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 21.10.2019 10:59, Ingo Molnar wrote:
> 
> * Alexey Budankov <alexey.budankov@linux.intel.com> wrote:
> 
>> +			/*
>> +			 * PMU specific parts of task perf context may require
>> +			 * additional synchronization, at least for proper Intel
>> +			 * LBR callstack data profiling;
>> +			 */
>> +			pmu->sync_task_ctx(ctx->task_ctx_data,
>> +					   next_ctx->task_ctx_data);
> 
> Firstly, I'm pretty sure you never run this on a CPU where 
> pmu->sync_task_ctx is NULL, right? ;-)

Yes, right.

> 
> Secondly, even on Intel CPUs in many cases we'll just call into a ~2 deep 
> function pointer based call hierarchy, just to find that nothing needs to 
> be done, because there's no LBR call stack maintained:
> 
> +       if (!one || !another)
> +               return;
> 
> So while it's technically a layering violation, it might make sense to 
> elevate this check to the generic layer and say that synchronization 
> calls by the core layer will always provide two valid pointers?

This would also keep performance benefit of avoiding double indirect 
pointer calls for cases when LBR callstack is not requested.

As far it has the comment saying that check is intentionally placed 
at the core layer it doesn't look like a violation but rather 
performance optimization.

Let me come up with v4 to see how it would look like.

Thanks for observation, 
Alexey

> 
> Thanks,
> 
> 	Ingo
> 
