Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F2D1C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 14:53:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68B5E214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 14:53:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730178AbfHTOxA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 10:53:00 -0400
Received: from mga05.intel.com ([192.55.52.43]:55911 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729351AbfHTOw7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 10:52:59 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Aug 2019 07:52:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,408,1559545200"; 
   d="scan'208";a="329728868"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga004.jf.intel.com with ESMTP; 20 Aug 2019 07:52:59 -0700
Received: from [10.254.94.232] (kliang2-mobl.ccr.corp.intel.com [10.254.94.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 884AF580144;
        Tue, 20 Aug 2019 07:52:58 -0700 (PDT)
Subject: Re: [PATCH] perf/x86: Consider pinned events for group validation
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, acme@kernel.org, linux-kernel@vger.kernel.org,
        eranian@google.com, ak@linux.intel.com
References: <1565977750-76693-1-git-send-email-kan.liang@linux.intel.com>
 <20190820141014.GU2332@hirez.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <776c7bf0-d779-7d27-9e05-b46cd299813b@linux.intel.com>
Date:   Tue, 20 Aug 2019 10:52:57 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190820141014.GU2332@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/20/2019 10:10 AM, Peter Zijlstra wrote:
> On Fri, Aug 16, 2019 at 10:49:10AM -0700, kan.liang@linux.intel.com wrote:
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> perf stat -M metrics relies on weak groups to reject unschedulable
>> groups and run them as non-groups.
>> This uses the group validation code in the kernel. Unfortunately
>> that code doesn't take pinned events, such as the NMI watchdog, into
>> account. So some groups can pass validation, but then later still
>> never schedule.
> 
> But if you first create the group and then a pinned event it 'works',
> which is inconsistent and makes all this timing dependent.

I don't think so. The pinned event will be validated by 
validate_event(), which doesn't simulate the schedule.
So the validation still pass, but the group still never schedule.

> 
>> @@ -2011,9 +2011,11 @@ static int validate_event(struct perf_event *event)
>>    */
>>   static int validate_group(struct perf_event *event)
>>   {
>> +	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
>>   	struct perf_event *leader = event->group_leader;
>>   	struct cpu_hw_events *fake_cpuc;
>> -	int ret = -EINVAL, n;
>> +	struct perf_event *pinned_event;
>> +	int ret = -EINVAL, n, i;
>>   
>>   	fake_cpuc = allocate_fake_cpuc();
>>   	if (IS_ERR(fake_cpuc))
>> @@ -2033,6 +2035,24 @@ static int validate_group(struct perf_event *event)
>>   	if (n < 0)
>>   		goto out;
>>   
>> +	/*
>> +	 * The new group must can be scheduled
>> +	 * together with current pinned events.
>> +	 * Otherwise, it will never get a chance
>> +	 * to be scheduled later.
> 
> That's wrapped short; also I don't think it is sufficient; what if you
> happen to have a pinned event on CPU1 (and not others) and happen to run
> validation for a new CPU1 event on CPUn ?
>

The patch doesn't support this case. It is mentioned in the description.
The patch doesn't intend to catch all possible cases that cannot be 
scheduled. I think it's impossible to catch all cases.
We only want to improve the validate_group() a little bit to catch some 
common cases, e.g. NMI watchdog interacting with group.


> Also; per that same; it is broken, you're accessing the cpu-local cpuc
> without serialization.

Do you mean accessing all cpuc serially?
We only check the cpuc on current CPU here. It doesn't intend to access 
other cpuc.


Thanks,
Kan

> 
>> +	 */
>> +	for (i = 0; i < cpuc->n_events; i++) {
>> +		pinned_event = cpuc->event_list[i];
>> +		if (WARN_ON_ONCE(!pinned_event))
>> +			continue;
>> +		if (!pinned_event->attr.pinned)
>> +			continue;
>> +		fake_cpuc->n_events = n;
>> +		n = collect_events(fake_cpuc, pinned_event, false);
>> +		if (n < 0)
>> +			goto out;
>> +	}
>> +
>>   	fake_cpuc->n_events = 0;
>>   	ret = x86_pmu.schedule_events(fake_cpuc, n, NULL);
>>   
>> -- 
>> 2.7.4
>>
