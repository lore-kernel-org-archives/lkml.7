Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A45BAC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 13:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B8AC20854
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 13:57:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732301AbfDJN5z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 09:57:55 -0400
Received: from mga06.intel.com ([134.134.136.31]:10037 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731302AbfDJN5y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 09:57:54 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Apr 2019 06:57:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,332,1549958400"; 
   d="scan'208";a="159933940"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga002.fm.intel.com with ESMTP; 10 Apr 2019 06:57:53 -0700
Received: from [10.251.26.102] (kliang2-mobl.ccr.corp.intel.com [10.251.26.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 5A8F45807A6;
        Wed, 10 Apr 2019 06:57:52 -0700 (PDT)
Subject: Re: [PATCH 1/2] perf/x86/intel: Support adaptive PEBS for fixed
 counters
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        acme@kernel.org, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com
References: <1554858600-148296-1-git-send-email-kan.liang@linux.intel.com>
 <1554858600-148296-2-git-send-email-kan.liang@linux.intel.com>
 <20190410074139.GW11158@hirez.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <d23c9f80-b73e-693a-f4ab-507e4108c46b@linux.intel.com>
Date:   Wed, 10 Apr 2019 09:57:50 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190410074139.GW11158@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/10/2019 3:41 AM, Peter Zijlstra wrote:
> On Tue, Apr 09, 2019 at 06:09:59PM -0700, kan.liang@linux.intel.com wrote:
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> Fixed counters can also generate adaptive PEBS record, if the
>> corresponding bit in IA32_FIXED_CTR_CTRL is set.
>> Otherwise, only basic record is generated.
>>
>> Unconditionally set the bit when PEBS is enabled on fixed counters.
>> Let MSR_PEBS_CFG decide which format of PEBS record should be generated.
>> There is no harmful to leave the bit set.
> 
> I'll merge this back into:
> 
>    Subject: perf/x86/intel: Support adaptive PEBSv4
> 
> such that this bug never existed, ok?

Yes, please.

Thanks,
Kan

> 
>>
>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
>> ---
>>   arch/x86/events/intel/core.c      | 5 +++++
>>   arch/x86/include/asm/perf_event.h | 1 +
>>   2 files changed, 6 insertions(+)
>>
>> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
>> index 56df0f6..f34d92b 100644
>> --- a/arch/x86/events/intel/core.c
>> +++ b/arch/x86/events/intel/core.c
>> @@ -2174,6 +2174,11 @@ static void intel_pmu_enable_fixed(struct perf_event *event)
>>   	bits <<= (idx * 4);
>>   	mask = 0xfULL << (idx * 4);
>>   
>> +	if (x86_pmu.intel_cap.pebs_baseline && event->attr.precise_ip) {
>> +		bits |= ICL_FIXED_0_ADAPTIVE << (idx * 4);
>> +		mask |= ICL_FIXED_0_ADAPTIVE << (idx * 4);
>> +	}
>> +
>>   	rdmsrl(hwc->config_base, ctrl_val);
>>   	ctrl_val &= ~mask;
>>   	ctrl_val |= bits;
>> diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
>> index dcb8bac..ce0dc88 100644
>> --- a/arch/x86/include/asm/perf_event.h
>> +++ b/arch/x86/include/asm/perf_event.h
>> @@ -33,6 +33,7 @@
>>   #define HSW_IN_TX					(1ULL << 32)
>>   #define HSW_IN_TX_CHECKPOINTED				(1ULL << 33)
>>   #define ICL_EVENTSEL_ADAPTIVE				(1ULL << 34)
>> +#define ICL_FIXED_0_ADAPTIVE				(1ULL << 32)
>>   
>>   #define AMD64_EVENTSEL_INT_CORE_ENABLE			(1ULL << 36)
>>   #define AMD64_EVENTSEL_GUESTONLY			(1ULL << 40)
>> -- 
>> 2.7.4
>>
