Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BA57C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 17:13:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30C7D22CF7
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 17:13:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730154AbfHTRNj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 13:13:39 -0400
Received: from mga04.intel.com ([192.55.52.120]:63147 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725971AbfHTRNi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 13:13:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Aug 2019 10:13:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,408,1559545200"; 
   d="scan'208";a="378642255"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga006.fm.intel.com with ESMTP; 20 Aug 2019 10:13:38 -0700
Received: from [10.254.94.232] (kliang2-mobl.ccr.corp.intel.com [10.254.94.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 89E43580144;
        Tue, 20 Aug 2019 10:13:37 -0700 (PDT)
Subject: Re: [PATCH] perf/x86: Consider pinned events for group validation
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, acme@kernel.org, linux-kernel@vger.kernel.org,
        eranian@google.com, ak@linux.intel.com
References: <1565977750-76693-1-git-send-email-kan.liang@linux.intel.com>
 <20190820141014.GU2332@hirez.programming.kicks-ass.net>
 <776c7bf0-d779-7d27-9e05-b46cd299813b@linux.intel.com>
 <20190820150950.GT2349@hirez.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <845ce006-8f0e-dc3e-cd45-d3ccb89e2a87@linux.intel.com>
Date:   Tue, 20 Aug 2019 13:13:36 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190820150950.GT2349@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>>> +	/*
>>>> +	 * The new group must can be scheduled
>>>> +	 * together with current pinned events.
>>>> +	 * Otherwise, it will never get a chance
>>>> +	 * to be scheduled later.
>>>
>>> That's wrapped short; also I don't think it is sufficient; what if you
>>> happen to have a pinned event on CPU1 (and not others) and happen to run
>>> validation for a new CPU1 event on CPUn ?
>>>
>>
>> The patch doesn't support this case.
> 
> Which makes the whole thing even more random.

Maybe we can use the cpuc on event->cpu. That could help a little here.
cpuc = per_cpu_ptr(&cpu_hw_events, event->cpu >= 0 ? event->cpu : 
raw_smp_processor_id());

> 
>> It is mentioned in the description.
>> The patch doesn't intend to catch all possible cases that cannot be
>> scheduled. I think it's impossible to catch all cases.
>> We only want to improve the validate_group() a little bit to catch some
>> common cases, e.g. NMI watchdog interacting with group.
>>
>>> Also; per that same; it is broken, you're accessing the cpu-local cpuc
>>> without serialization.
>>
>> Do you mean accessing all cpuc serially?
>> We only check the cpuc on current CPU here. It doesn't intend to access
>> other cpuc.
> 
> There's nothing preventing the cpuc you're looking at changing while
> you're looking at it. Heck, afaict it is possible to UaF here. Nothing
> prevents the events you're looking at from going away and getting freed.

You are right.
I think we can add a lock to prevent the event_list[] in x86_pmu_add() 
and x86_pmu_del().


Thanks,
Kan
