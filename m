Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA1AC32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 20:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7415B224FE
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 20:40:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732417AbfI3UkX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 16:40:23 -0400
Received: from mga07.intel.com ([134.134.136.100]:33889 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731113AbfI3UkX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 16:40:23 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Sep 2019 11:18:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,568,1559545200"; 
   d="scan'208";a="204894825"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga001.fm.intel.com with ESMTP; 30 Sep 2019 11:18:31 -0700
Received: from [10.251.2.197] (kliang2-mobl.ccr.corp.intel.com [10.251.2.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id E8BCA5803DA;
        Mon, 30 Sep 2019 11:18:30 -0700 (PDT)
Subject: Re: [PATCH V4 08/14] perf/x86/intel: Support per thread RDPMC TopDown
 metrics
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     acme@kernel.org, mingo@redhat.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com
References: <20190916134128.18120-1-kan.liang@linux.intel.com>
 <20190916134128.18120-9-kan.liang@linux.intel.com>
 <20190930155244.GP4553@hirez.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <74485793-b7a8-4c34-cdde-1f452b7b359f@linux.intel.com>
Date:   Mon, 30 Sep 2019 14:18:29 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20190930155244.GP4553@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/30/2019 11:52 AM, Peter Zijlstra wrote:
> On Mon, Sep 16, 2019 at 06:41:22AM -0700, kan.liang@linux.intel.com wrote:
>> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
>> index 71f3086a8adc..7ec0f350d2ac 100644
>> --- a/arch/x86/events/intel/core.c
>> +++ b/arch/x86/events/intel/core.c
>> @@ -2262,6 +2262,11 @@ static int icl_set_topdown_event_period(struct perf_event *event)
>>   		local64_set(&hwc->period_left, 0);
>>   	}
>>   
>> +	if ((hwc->saved_slots) && is_first_topdown_event_in_group(event)) {
>> +		wrmsrl(MSR_CORE_PERF_FIXED_CTR3, hwc->saved_slots);
>> +		wrmsrl(MSR_PERF_METRICS, hwc->saved_metric);
>> +	}
> 
>> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
>> index 61448c19a132..c125068f2e16 100644
>> --- a/include/linux/perf_event.h
>> +++ b/include/linux/perf_event.h
>> @@ -133,6 +133,9 @@ struct hw_perf_event {
>>   
>>   			struct hw_perf_event_extra extra_reg;
>>   			struct hw_perf_event_extra branch_reg;
>> +
>> +			u64		saved_slots;
>> +			u64		saved_metric;
>>   		};
>>   		struct { /* software */
>>   			struct hrtimer	hrtimer;
> 
> Normal counters save their counter value in hwc->period_left, why does
> slots need a new word for that?
> 

We have two values which have to be stored. Only period_left is not enough.

> And since using METRIC means non-sampling, why can't we stick that
> saved_metric field in one of the unused sampling fields?
>

Yes, I think we can re-use last_period and period_left for saved_metric 
and saved_slots. I will change it in V5.


@@ -202,17 +199,26 @@ struct hw_perf_event {
  	 */
  	u64				sample_period;

-	/*
-	 * The period we started this sample with.
-	 */
-	u64				last_period;
+	union {
+		struct { /* Sampling */

-	/*
-	 * However much is left of the current period; note that this is
-	 * a full 64bit value and allows for generation of periods longer
-	 * than hardware might allow.
-	 */
-	local64_t			period_left;
+			/*
+			 * The period we started this sample with.
+			 */
+			u64				last_period;
+
+			/*
+			 * However much is left of the current period; note that this is
+			 * a full 64bit value and allows for generation of periods longer
+			 * than hardware might allow.
+			 */
+			local64_t			period_left;
+		};
+		struct { /* Topdown events counting for context switch*/
+			u64				saved_metric;
+			u64				saved_slots;
+		};
+	};


Thanks,
Kan

> ISTR asking this before...
>

