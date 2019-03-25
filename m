Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94624C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 06:07:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F00320850
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 06:07:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729623AbfCYGHX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 02:07:23 -0400
Received: from mga17.intel.com ([192.55.52.151]:11639 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729373AbfCYGHW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 02:07:22 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Mar 2019 23:07:21 -0700
X-IronPort-AV: E=Sophos;i="5.60,256,1549958400"; 
   d="scan'208";a="128373226"
Received: from likexu-mobl1.ccr.corp.intel.com (HELO [10.239.196.197]) ([10.239.196.197])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/AES128-SHA; 24 Mar 2019 23:07:18 -0700
Subject: Re: [RFC] [PATCH v2 0/5] Intel Virtual PMU Optimization
To:     Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        like.xu@intel.com, wei.w.wang@intel.com,
        Kan Liang <kan.liang@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <1553350688-39627-1-git-send-email-like.xu@linux.intel.com>
 <20190323172800.GD6058@hirez.programming.kicks-ass.net>
 <20190323231543.GE18020@tassilo.jf.intel.com>
From:   Like Xu <like.xu@linux.intel.com>
Organization: Intel OTC
Message-ID: <0559a810-c0e6-16f6-fa15-7baec707a2ad@linux.intel.com>
Date:   Mon, 25 Mar 2019 14:07:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <20190323231543.GE18020@tassilo.jf.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/3/24 7:15, Andi Kleen wrote:
>>> We optimize the current vPMU to work in this manner:
>>>
>>> (1) rely on the existing host perf (perf_event_create_kernel_counter)
>>>      to allocate counters for in-use vPMC and always try to reuse events;
>>> (2) vPMU captures guest accesses to the eventsel and fixctrl msr directly
>>>      to the hardware msr that the corresponding host event is scheduled on
>>>      and avoid pollution from host is also needed in its partial runtime;
>>
>> If you do pass-through; how do you deal with event constraints?
> 
> The guest has to deal with them. It already needs to know
> the model number to program the right events, can as well know
> the constraints too.
> 
> For architectural events that don't need the model number it's
> not a problem because they don't have constraints.
> 
> -Andi
> 

I agree this version doesn't seem to keep an eye on host perf event 
constraints deliberately:

1. Based on my limited knowledge, assuming the model number means hwc->idx.
2. The guest event constraints would be constructed into 
hwc->config_base value which is pmc->eventsel and pmu->fixed_ctr_ctrl 
from KVM point of view.
3. The guest PMU has same semantic model on virt hardware limitation as 
the host does with real PMU (related CPUID/PERF_MSR expose this part of 
information to guest).
3. Guest perf scheduler would make sure the guest event constraints 
could dance with right guest model number.
4. vPMU would make sure the guest vPMC get the right guest model number 
by hard-code EVENT_PINNED or just fail with creation.
5. This patch directly apply the guest hwc->config_base value to host 
assigned hardware without consent from host perf(a bit deceptive but 
practical for reducing the number of reprogram calls).

=== OR ====

If we insist on passing guest event constraints to host perf,
this proposal may need the following changes:

Because the guest configuration of hwc->config_base mostly only toggles 
the enable bit of eventsel or fixctrl,it is not necessary to do 
reprogram_counter because it's serving the same guest perf event.

The event creation is only needed when guest writes a complete new value 
to eventsel or fixctrl.Codes for guest MSR_P6_EVNTSEL0 trap for example 
may be modified to be like this:

	u64 diff = pmc->eventsel ^ data;
	if (intel_pmc_is_assigned(pmc)
		&& diff	!= ARCH_PERFMON_EVENTSEL_ENABLE) {
		intel_pmu_save_guest_pmc(pmu, pmc->idx);
		intel_pmc_stop_counter(pmc);
	}
	reprogram_gp_counter(pmc, data);

Does this seem to satisfy our needs?


It makes everything easier to correct me if I'm wrong.

