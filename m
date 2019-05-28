Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 484B9C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 18:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22300208CB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 18:25:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728107AbfE1SZh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 14:25:37 -0400
Received: from mga04.intel.com ([192.55.52.120]:16427 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728003AbfE1SZh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 14:25:37 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 May 2019 11:25:36 -0700
X-ExtLoop1: 1
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga007.fm.intel.com with ESMTP; 28 May 2019 11:25:36 -0700
Received: from [10.254.95.162] (kliang2-mobl.ccr.corp.intel.com [10.254.95.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 850E6580372;
        Tue, 28 May 2019 11:25:35 -0700 (PDT)
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Subject: Re: [PATCH 7/9] perf/x86/intel: Disable sampling read slots and
 topdown
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     acme@kernel.org, mingo@redhat.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com
References: <20190521214055.31060-1-kan.liang@linux.intel.com>
 <20190521214055.31060-8-kan.liang@linux.intel.com>
 <20190528135224.GS2623@hirez.programming.kicks-ass.net>
Message-ID: <27190331-6df7-239a-9ce7-f2e0a8c5d387@linux.intel.com>
Date:   Tue, 28 May 2019 14:25:34 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190528135224.GS2623@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/28/2019 9:52 AM, Peter Zijlstra wrote:
> On Tue, May 21, 2019 at 02:40:53PM -0700, kan.liang@linux.intel.com wrote:
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> To get correct PERF_METRICS value, the fixed counter 3 must start from
>> 0. It would bring problems when sampling read slots and topdown events.
>> For example,
>>          perf record -e '{slots, topdown-retiring}:S'
>> The slots would not overflow if it starts from 0.
>>
>> Add specific validate_group() support to reject the case and error out
>> for Icelake.
>>
>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
>> ---
>>   arch/x86/events/core.c       |  2 ++
>>   arch/x86/events/intel/core.c | 20 ++++++++++++++++++++
>>   arch/x86/events/perf_event.h |  2 ++
>>   3 files changed, 24 insertions(+)
>>
>> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
>> index 07ecfe75f0e6..a7eb842f8651 100644
>> --- a/arch/x86/events/core.c
>> +++ b/arch/x86/events/core.c
>> @@ -2065,6 +2065,8 @@ static int validate_group(struct perf_event *event)
>>   	fake_cpuc->n_events = 0;
>>   	ret = x86_pmu.schedule_events(fake_cpuc, n, NULL);
>>   
>> +	if (x86_pmu.validate_group)
>> +		ret = x86_pmu.validate_group(fake_cpuc, n);
>>   out:
>>   	free_fake_cpuc(fake_cpuc);
>>   	return ret;
>> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
>> index 79e9d05e047d..2bb90d652a35 100644
>> --- a/arch/x86/events/intel/core.c
>> +++ b/arch/x86/events/intel/core.c
>> @@ -4410,6 +4410,25 @@ static int icl_set_period(struct perf_event *event)
>>   	return 1;
>>   }
>>   
>> +static int icl_validate_group(struct cpu_hw_events *cpuc, int n)
>> +{
>> +	bool has_sampling_slots = false, has_metrics = false;
>> +	struct perf_event *e;
>> +	int i;
>> +
>> +	for (i = 0; i < n; i++) {
>> +		e = cpuc->event_list[i];
>> +		if (is_slots_event(e) && is_sampling_event(e))
>> +			has_sampling_slots = true;
>> +
>> +		if (is_perf_metrics_event(e))
>> +			has_metrics = true;
>> +	}
>> +	if (unlikely(has_sampling_slots && has_metrics))
>> +		return -EINVAL;
>> +	return 0;
>> +}
> 
> Why this special hack, why not disallow sampling on SLOTS on creation?

You mean unconditionally disable SLOTS sampling?

The SLOTS doesn't have to be with Topdown metrics event.
I think users may want to only sampling slot events. We should allow 
this usage.

Thanks,
Kan


