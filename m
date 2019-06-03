Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6FD2C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 16:14:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 871E227596
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 16:14:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728889AbfFCQO6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 12:14:58 -0400
Received: from mga18.intel.com ([134.134.136.126]:4337 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726521AbfFCQO6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 12:14:58 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jun 2019 09:14:56 -0700
X-ExtLoop1: 1
Received: from linux.intel.com ([10.54.29.200])
  by orsmga002.jf.intel.com with ESMTP; 03 Jun 2019 09:14:56 -0700
Received: from [10.251.11.94] (kliang2-mobl.ccr.corp.intel.com [10.251.11.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id EDE665801E6;
        Mon,  3 Jun 2019 09:14:50 -0700 (PDT)
Subject: Re: [PATCH 2/3] perf/x86/intel: Add more Icelake CPUIDs
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, bp@alien8.de, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, x86@kernel.org, qiuxu.zhuo@intel.com,
        tony.luck@intel.com, rui.zhang@intel.com
References: <20190603134122.13853-1-kan.liang@linux.intel.com>
 <20190603134122.13853-2-kan.liang@linux.intel.com>
 <20190603154750.GA3402@hirez.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <ae87acab-5dbe-25a8-93f8-1c8f8ecb547b@linux.intel.com>
Date:   Mon, 3 Jun 2019 12:14:49 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190603154750.GA3402@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/3/2019 11:47 AM, Peter Zijlstra wrote:
> On Mon, Jun 03, 2019 at 06:41:21AM -0700, kan.liang@linux.intel.com wrote:
>> @@ -4962,7 +4965,9 @@ __init int intel_pmu_init(void)
>>   		x86_pmu.cpu_events = get_icl_events_attrs();
>>   		x86_pmu.rtm_abort_event = X86_CONFIG(.event=0xca, .umask=0x02);
>>   		x86_pmu.lbr_pt_coexist = true;
>> -		intel_pmu_pebs_data_source_skl(false);
>> +		intel_pmu_pebs_data_source_skl(
>> +			(boot_cpu_data.x86_model == INTEL_FAM6_ICELAKE_X) ||
>> +			(boot_cpu_data.x86_model == INTEL_FAM6_ICELAKE_XEON_D));
> 
> That's pretty sad, a model switch inside a model switch :/
> 
>>   		pr_cont("Icelake events, ");
>>   		name = "icelake";
>>   		break;
> 
> Would something like so not be nicer?

Yes, it looks better. Thanks.

Should I combine your patch with mine, and send out V2?
Or are you prefer to add your patch on top of this patch set?

Thanks,
Kan

> 
> ---
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -4485,6 +4485,7 @@ __init int intel_pmu_init(void)
>   	struct event_constraint *c;
>   	unsigned int unused;
>   	struct extra_reg *er;
> +	bool pmem = false;
>   	int version, i;
>   	char *name;
>   
> @@ -4936,9 +4937,10 @@ __init int intel_pmu_init(void)
>   		name = "knights-landing";
>   		break;
>   
> +	case INTEL_FAM6_SKYLAKE_X:
> +		pmem = true;
>   	case INTEL_FAM6_SKYLAKE_MOBILE:
>   	case INTEL_FAM6_SKYLAKE_DESKTOP:
> -	case INTEL_FAM6_SKYLAKE_X:
>   	case INTEL_FAM6_KABYLAKE_MOBILE:
>   	case INTEL_FAM6_KABYLAKE_DESKTOP:
>   		x86_add_quirk(intel_pebs_isolation_quirk);
> @@ -4970,8 +4972,7 @@ __init int intel_pmu_init(void)
>   		td_attr  = hsw_events_attrs;
>   		mem_attr = hsw_mem_events_attrs;
>   		tsx_attr = hsw_tsx_events_attrs;
> -		intel_pmu_pebs_data_source_skl(
> -			boot_cpu_data.x86_model == INTEL_FAM6_SKYLAKE_X);
> +		intel_pmu_pebs_data_source_skl(pmem);
>   
>   		if (boot_cpu_has(X86_FEATURE_TSX_FORCE_ABORT)) {
>   			x86_pmu.flags |= PMU_FL_TFA;
> @@ -4985,7 +4986,11 @@ __init int intel_pmu_init(void)
>   		name = "skylake";
>   		break;
>   
> +	case INTEL_FAM6_ICELAKE_X:
> +	case INTEL_FAM6_ICELAKE_XEON_D:
> +		pmem = true;
>   	case INTEL_FAM6_ICELAKE_MOBILE:
> +	case INTEL_FAM6_ICELAKE_DESKTOP:
>   		x86_pmu.late_ack = true;
>   		memcpy(hw_cache_event_ids, skl_hw_cache_event_ids, sizeof(hw_cache_event_ids));
>   		memcpy(hw_cache_extra_regs, skl_hw_cache_extra_regs, sizeof(hw_cache_extra_regs));
> @@ -5009,7 +5014,7 @@ __init int intel_pmu_init(void)
>   		tsx_attr = icl_tsx_events_attrs;
>   		x86_pmu.rtm_abort_event = X86_CONFIG(.event=0xca, .umask=0x02);
>   		x86_pmu.lbr_pt_coexist = true;
> -		intel_pmu_pebs_data_source_skl(false);
> +		intel_pmu_pebs_data_source_skl(pmem);
>   		pr_cont("Icelake events, ");
>   		name = "icelake";
>   		break;
> 
