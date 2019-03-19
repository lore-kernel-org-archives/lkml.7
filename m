Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB82EC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 21:20:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A52952085A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 21:20:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbfCSVUK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 17:20:10 -0400
Received: from mga01.intel.com ([192.55.52.88]:9348 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726712AbfCSVUK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 17:20:10 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Mar 2019 14:20:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,246,1549958400"; 
   d="scan'208";a="215631438"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP; 19 Mar 2019 14:20:06 -0700
Received: from [10.254.88.173] (kliang2-mobl1.ccr.corp.intel.com [10.254.88.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id C90795804B6;
        Tue, 19 Mar 2019 14:20:05 -0700 (PDT)
Subject: Re: [PATCH 03/22] perf/x86/intel: Support adaptive PEBSv4
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     acme@kernel.org, mingo@redhat.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com
References: <20190318214144.4639-1-kan.liang@linux.intel.com>
 <20190318214144.4639-4-kan.liang@linux.intel.com>
 <20190319144748.GH5996@hirez.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <948ed187-bfe8-c8f2-83b1-88db7af88c03@linux.intel.com>
Date:   Tue, 19 Mar 2019 17:20:04 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190319144748.GH5996@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/19/2019 10:47 AM, Peter Zijlstra wrote:
>> @@ -933,6 +998,19 @@ pebs_update_state(bool needed_cb, struct cpu_hw_events *cpuc, struct pmu *pmu)
>>   		update = true;
>>   	}
>>   
>> +	if (x86_pmu.intel_cap.pebs_baseline && add) {
>> +		u64 pebs_data_cfg;
>> +
>> +		pebs_data_cfg = pebs_update_adaptive_cfg(event);
>> +
>> +		/* Update pebs_record_size if new event requires more data. */
>> +		if (pebs_data_cfg & ~cpuc->pebs_data_cfg) {
>> +			cpuc->pebs_data_cfg |= pebs_data_cfg;
>> +			adaptive_pebs_record_size_update();
>> +			update = true;
>> +		}
>> +	}
>> +
>>   	if (update)
>>   		pebs_update_threshold(cpuc);
>>   }
> Hurmph.. this only grows the PEBS record.
>

Yes, the PEBS record doesn't shrink on the del. Because we have to go 
through all the existing pebs events for an accurate config. I think it 
doesn't worth it. There is no harmful for a bigger PEBS record, except 
little performance impacts. But that's rare case. For most cases, we 
usually apply the same pebs config for all pebs events.

> 
>> @@ -947,7 +1025,7 @@ void intel_pmu_pebs_add(struct perf_event *event)
>>   	if (hwc->flags & PERF_X86_EVENT_LARGE_PEBS)
>>   		cpuc->n_large_pebs++;
>>   
>> -	pebs_update_state(needed_cb, cpuc, event->ctx->pmu);
>> +	pebs_update_state(needed_cb, cpuc, event, true);
>>   }
>>   
>>   void intel_pmu_pebs_enable(struct perf_event *event)
>> @@ -965,6 +1043,14 @@ void intel_pmu_pebs_enable(struct perf_event *event)
>>   	else if (event->hw.flags & PERF_X86_EVENT_PEBS_ST)
>>   		cpuc->pebs_enabled |= 1ULL << 63;
>>   
>> +	if (x86_pmu.intel_cap.pebs_baseline) {
>> +		hwc->config |= ICL_EVENTSEL_ADAPTIVE;
>> +		if (cpuc->pebs_data_cfg != cpuc->active_pebs_data_cfg) {
>> +			wrmsrl(MSR_PEBS_DATA_CFG, cpuc->pebs_data_cfg);
>> +			cpuc->active_pebs_data_cfg = cpuc->pebs_data_cfg;
>> +		}
>> +	}
>> +
>>   	/*
>>   	 * Use auto-reload if possible to save a MSR write in the PMI.
>>   	 * This must be done in pmu::start(), because PERF_EVENT_IOC_PERIOD.
>> @@ -991,7 +1077,12 @@ void intel_pmu_pebs_del(struct perf_event *event)
>>   	if (hwc->flags & PERF_X86_EVENT_LARGE_PEBS)
>>   		cpuc->n_large_pebs--;
>>   
>> -	pebs_update_state(needed_cb, cpuc, event->ctx->pmu);
>> +	/* Clear both pebs_data_cfg and pebs_record_size for first PEBS. */
> Weird comment..
> 
>> +	if (x86_pmu.intel_cap.pebs_baseline && !cpuc->n_pebs) {
>> +		cpuc->pebs_data_cfg = 0;
>> +		cpuc->pebs_record_size = sizeof(struct pebs_basic);
>> +	}
>> +	pebs_update_state(needed_cb, cpuc, event, false);
> Why do we have to reset record_size? That'll be updated in
> pebs_update_state() on the next add.
> 

The record_size should be reset for the first PEBS events.
Right, I can move the reset in pebs_update_state().


Thanks,
Kan


