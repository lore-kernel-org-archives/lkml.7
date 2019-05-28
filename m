Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06FA7C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 18:24:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0C0F21721
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 18:24:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728063AbfE1SYl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 14:24:41 -0400
Received: from mga02.intel.com ([134.134.136.20]:33222 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726576AbfE1SYl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 14:24:41 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 May 2019 11:24:41 -0700
X-ExtLoop1: 1
Received: from linux.intel.com ([10.54.29.200])
  by FMSMGA003.fm.intel.com with ESMTP; 28 May 2019 11:24:40 -0700
Received: from [10.254.95.162] (kliang2-mobl.ccr.corp.intel.com [10.254.95.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id B814F580372;
        Tue, 28 May 2019 11:24:39 -0700 (PDT)
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Subject: Re: [PATCH 4/9] perf/x86/intel: Support hardware TopDown metrics
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     acme@kernel.org, mingo@redhat.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com
References: <20190521214055.31060-1-kan.liang@linux.intel.com>
 <20190521214055.31060-5-kan.liang@linux.intel.com>
 <20190528134354.GP2623@hirez.programming.kicks-ass.net>
Message-ID: <561ec469-2e0b-4749-c184-d07e4f4eaf40@linux.intel.com>
Date:   Tue, 28 May 2019 14:24:38 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190528134354.GP2623@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/28/2019 9:43 AM, Peter Zijlstra wrote:
> On Tue, May 21, 2019 at 02:40:50PM -0700, kan.liang@linux.intel.com wrote:
>> @@ -3287,6 +3304,13 @@ static int core_pmu_hw_config(struct perf_event *event)
>>   	return intel_pmu_bts_config(event);
>>   }
>>   
>> +#define EVENT_CODE(e)	(e->attr.config & INTEL_ARCH_EVENT_MASK)
>> +#define is_slots_event(e)	(EVENT_CODE(e) == 0x0400)
>> +#define is_perf_metrics_event(e)				\
>> +		(((EVENT_CODE(e) & 0xff) == 0xff) &&		\
>> +		 (EVENT_CODE(e) >= 0x01ff) &&			\
>> +		 (EVENT_CODE(e) <= 0x04ff))
>> +
> 
> That is horrific.. (e & INTEL_ARCH_EVENT_MASK) & 0xff is just daft,
> that should be: (e & ARCH_PERFMON_EVENTSEL_EVENT).
> 
> Also, we already have fake events for event=0, see FIXED2, why are we
> now using event=0xff ?

I think event=0 is for genuine fixed events. Metrics events are fake events.
I didn't find FIXED2 in the code. Could you please share more hints?

Thanks,
Kan
