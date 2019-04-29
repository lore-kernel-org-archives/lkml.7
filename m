Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86146C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 15:31:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FD8720656
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 15:31:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728692AbfD2Pb3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 11:31:29 -0400
Received: from mga05.intel.com ([192.55.52.43]:4512 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728249AbfD2Pb2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 11:31:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Apr 2019 08:31:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,409,1549958400"; 
   d="scan'208";a="168984187"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga001.fm.intel.com with ESMTP; 29 Apr 2019 08:31:28 -0700
Received: from [10.254.90.51] (kliang2-mobl.ccr.corp.intel.com [10.254.90.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 4A450580349;
        Mon, 29 Apr 2019 08:31:27 -0700 (PDT)
Subject: Re: [PATCH 2/4] perf: Add filter_match() as a parameter for
 pinned/flexible_sched_in()
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     peterz@infradead.org, tglx@linutronix.de, mingo@redhat.com,
        linux-kernel@vger.kernel.org, eranian@google.com, tj@kernel.org,
        ak@linux.intel.com
References: <1556549045-71814-1-git-send-email-kan.liang@linux.intel.com>
 <1556549045-71814-3-git-send-email-kan.liang@linux.intel.com>
 <20190429151225.GC2182@lakrids.cambridge.arm.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <b00952cd-9af1-3e4f-45cb-11a692e9b722@linux.intel.com>
Date:   Mon, 29 Apr 2019 11:31:26 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190429151225.GC2182@lakrids.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/29/2019 11:12 AM, Mark Rutland wrote:
> On Mon, Apr 29, 2019 at 07:44:03AM -0700, kan.liang@linux.intel.com wrote:
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> A fast path will be introduced in the following patches to speed up the
>> cgroup events sched in, which only needs a simpler filter_match().
>>
>> Add filter_match() as a parameter for pinned/flexible_sched_in().
>>
>> No functional change.
> 
> I suspect that the cost you're trying to avoid is pmu_filter_match()
> iterating over the entire group, which arm systems rely upon for correct
> behaviour on big.LITTLE systems.
> 
> Is that the case?

No. In X86, we don't use pmu_filter_match(). The fast path still keeps 
this filter.
perf_cgroup_match() is the one I want to avoid.

Thanks,
Kan

> 
> Thanks,
> Mark.
> 
>>
>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
>> ---
>>   kernel/events/core.c | 15 +++++++++------
>>   1 file changed, 9 insertions(+), 6 deletions(-)
>>
>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>> index 388dd42..782fd86 100644
>> --- a/kernel/events/core.c
>> +++ b/kernel/events/core.c
>> @@ -3251,7 +3251,8 @@ static void cpu_ctx_sched_out(struct perf_cpu_context *cpuctx,
>>   }
>>   
>>   static int visit_groups_merge(struct perf_event_groups *groups, int cpu,
>> -			      int (*func)(struct perf_event *, void *), void *data)
>> +			      int (*func)(struct perf_event *, void *, int (*)(struct perf_event *)),
>> +			      void *data)
>>   {
>>   	struct perf_event **evt, *evt1, *evt2;
>>   	int ret;
>> @@ -3271,7 +3272,7 @@ static int visit_groups_merge(struct perf_event_groups *groups, int cpu,
>>   			evt = &evt2;
>>   		}
>>   
>> -		ret = func(*evt, data);
>> +		ret = func(*evt, data, event_filter_match);
>>   		if (ret)
>>   			return ret;
>>   
>> @@ -3287,7 +3288,8 @@ struct sched_in_data {
>>   	int can_add_hw;
>>   };
>>   
>> -static int pinned_sched_in(struct perf_event *event, void *data)
>> +static int pinned_sched_in(struct perf_event *event, void *data,
>> +			   int (*filter_match)(struct perf_event *))
>>   {
>>   	struct sched_in_data *sid = data;
>>   
>> @@ -3300,7 +3302,7 @@ static int pinned_sched_in(struct perf_event *event, void *data)
>>   		return 0;
>>   #endif
>>   
>> -	if (!event_filter_match(event))
>> +	if (!filter_match(event))
>>   		return 0;
>>   
>>   	if (group_can_go_on(event, sid->cpuctx, sid->can_add_hw)) {
>> @@ -3318,7 +3320,8 @@ static int pinned_sched_in(struct perf_event *event, void *data)
>>   	return 0;
>>   }
>>   
>> -static int flexible_sched_in(struct perf_event *event, void *data)
>> +static int flexible_sched_in(struct perf_event *event, void *data,
>> +			     int (*filter_match)(struct perf_event *))
>>   {
>>   	struct sched_in_data *sid = data;
>>   
>> @@ -3331,7 +3334,7 @@ static int flexible_sched_in(struct perf_event *event, void *data)
>>   		return 0;
>>   #endif
>>   
>> -	if (!event_filter_match(event))
>> +	if (!filter_match(event))
>>   		return 0;
>>   
>>   	if (group_can_go_on(event, sid->cpuctx, sid->can_add_hw)) {
>> -- 
>> 2.7.4
>>
