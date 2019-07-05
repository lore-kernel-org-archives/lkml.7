Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3B49C0650E
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 00:23:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB56D21850
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 00:23:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727717AbfGEAXk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 20:23:40 -0400
Received: from mga06.intel.com ([134.134.136.31]:39797 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727093AbfGEAXk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 20:23:40 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jul 2019 17:23:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,453,1557212400"; 
   d="scan'208";a="187679730"
Received: from yjin15-mobl.ccr.corp.intel.com (HELO [10.239.196.80]) ([10.239.196.80])
  by fmsmga004.fm.intel.com with ESMTP; 04 Jul 2019 17:23:38 -0700
Subject: Re: [PATCH] perf/x86/intel: Fix spurious NMI on fixed counter
To:     Jiri Olsa <jolsa@redhat.com>, kan.liang@linux.intel.com
Cc:     mingo@redhat.com, jolsa@kernel.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, ak@linux.intel.com
References: <20190625142135.22112-1-kan.liang@linux.intel.com>
 <20190625145834.GA8480@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <a0722e4d-4cae-7212-c8ec-a8d0c9edc08c@linux.intel.com>
Date:   Fri, 5 Jul 2019 08:23:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190625145834.GA8480@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/25/2019 10:58 PM, Jiri Olsa wrote:
> On Tue, Jun 25, 2019 at 07:21:35AM -0700, kan.liang@linux.intel.com wrote:
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> If a user first sample a PEBS event on a fixed counter, then sample a
>> non-PEBS event on the same fixed counter on Icelake, it will trigger
>> spurious NMI. For example,
>>
>>    perf record -e 'cycles:p' -a
>>    perf record -e 'cycles' -a
>>
>> The error message for spurious NMI.
>>
>>    [June 21 15:38] Uhhuh. NMI received for unknown reason 30 on CPU 2.
>>    [  +0.000000] Do you have a strange power saving mode enabled?
>>    [  +0.000000] Dazed and confused, but trying to continue
>>
>> The issue was introduced by the following commit:
>>
>>    commit 6f55967ad9d9 ("perf/x86/intel: Fix race in intel_pmu_disable_event()")
>>
>> The commit moves the intel_pmu_pebs_disable() after
>> intel_pmu_disable_fixed(), which returns immediately.
>> The related bit of PEBS_ENABLE MSR will never be cleared for the fixed
>> counter. Then a non-PEBS event runs on the fixed counter, but the bit
>> on PEBS_ENABLE is still set, which trigger spurious NMI.
>>
>> Check and disable PEBS for fixed counter after intel_pmu_disable_fixed().
>>
>> Reported-by: Yi, Ammy <ammy.yi@intel.com>
>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
>> Fixes: 6f55967ad9d9 ("perf/x86/intel: Fix race in intel_pmu_disable_event()")
>> ---
>>   arch/x86/events/intel/core.c | 8 +++-----
>>   1 file changed, 3 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
>> index 4377bf6a6f82..464316218b77 100644
>> --- a/arch/x86/events/intel/core.c
>> +++ b/arch/x86/events/intel/core.c
>> @@ -2160,12 +2160,10 @@ static void intel_pmu_disable_event(struct perf_event *event)
>>   	cpuc->intel_ctrl_host_mask &= ~(1ull << hwc->idx);
>>   	cpuc->intel_cp_status &= ~(1ull << hwc->idx);
>>   
>> -	if (unlikely(hwc->config_base == MSR_ARCH_PERFMON_FIXED_CTR_CTRL)) {
>> +	if (unlikely(hwc->config_base == MSR_ARCH_PERFMON_FIXED_CTR_CTRL))
>>   		intel_pmu_disable_fixed(hwc);
>> -		return;
>> -	}
>> -
>> -	x86_pmu_disable_event(event);
>> +	else
>> +		x86_pmu_disable_event(event);
>>   
> 
> oops, I overlooed this, looks good
> 
> Acked-by: Jiri Olsa <jolsa@kernel.org>
> 
> thanks,
> jirka
> 

Hi,

Could this fix be accepted?

Thanks
Jin Yao

>>   	/*
>>   	 * Needs to be called after x86_pmu_disable_event,
>> -- 
>> 2.14.5
>>
