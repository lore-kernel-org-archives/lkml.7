Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 244FDC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 06:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC38720854
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 06:47:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729761AbfCYGrh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 02:47:37 -0400
Received: from mga03.intel.com ([134.134.136.65]:40682 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729373AbfCYGrh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 02:47:37 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Mar 2019 23:47:37 -0700
X-IronPort-AV: E=Sophos;i="5.60,256,1549958400"; 
   d="scan'208";a="128381479"
Received: from likexu-mobl1.ccr.corp.intel.com (HELO [10.239.196.197]) ([10.239.196.197])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/AES128-SHA; 24 Mar 2019 23:47:34 -0700
Subject: Re: [RFC] [PATCH v2 0/5] Intel Virtual PMU Optimization
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        like.xu@intel.com, wei.w.wang@intel.com,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <1553350688-39627-1-git-send-email-like.xu@linux.intel.com>
 <20190323172800.GD6058@hirez.programming.kicks-ass.net>
From:   Like Xu <like.xu@linux.intel.com>
Organization: Intel OTC
Message-ID: <28851e9d-5ed4-8ce1-8ff4-9d6c04180388@linux.intel.com>
Date:   Mon, 25 Mar 2019 14:47:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <20190323172800.GD6058@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/3/24 1:28, Peter Zijlstra wrote:
> On Sat, Mar 23, 2019 at 10:18:03PM +0800, Like Xu wrote:
>> === Brief description ===
>>
>> This proposal for Intel vPMU is still committed to optimize the basic
>> functionality by reducing the PMU virtualization overhead and not a blind
>> pass-through of the PMU. The proposal applies to existing models, in short,
>> is "host perf would hand over control to kvm after counter allocation".
>>
>> The pmc_reprogram_counter is a heavyweight and high frequency operation
>> which goes through the host perf software stack to create a perf event for
>> counter assignment, this could take millions of nanoseconds. The current
>> vPMU always does reprogram_counter when the guest changes the eventsel,
>> fixctrl, and global_ctrl msrs. This brings too much overhead to the usage
>> of perf inside the guest, especially the guest PMI handling and context
>> switching of guest threads with perf in use.
> 
> I think I asked for starting with making pmc_reprogram_counter() less
> retarded. I'm not seeing that here.

Do you mean pass perf_event_attr to refactor pmc_reprogram_counter
via paravirt ? Please share more details.

> 
>> We optimize the current vPMU to work in this manner:
>>
>> (1) rely on the existing host perf (perf_event_create_kernel_counter)
>>      to allocate counters for in-use vPMC and always try to reuse events;
>> (2) vPMU captures guest accesses to the eventsel and fixctrl msr directly
>>      to the hardware msr that the corresponding host event is scheduled on
>>      and avoid pollution from host is also needed in its partial runtime;
> 
> If you do pass-through; how do you deal with event constraints >
>> (3) save and restore the counter state during vCPU scheduling in hooks;
>> (4) apply a lazy approach to release the vPMC's perf event. That is, if
>>      the vPMC isn't used in a fixed sched slice, its event will be released.
>>
>> In the use of vPMC, the vPMU always focus on the assigned resources and
>> guest perf would significantly benefit from direct access to hardware and
>> may not care about runtime state of perf_event created by host and always
>> try not to pay for their maintenance. However to avoid events entering into
>> any unexpected state, calling pmc_read_counter in appropriate is necessary.
> 
> what?!

The patch will reuse the created events as much as possible for same 
guest vPMC which may has different config_base in its partial runtime.

The pmc_read_counter is designed to be called in kvm_pmu_rdpmc and 
pmc_stop_counter as legacy does and it's not for vPMU functionality but 
for host perf maintenance (seems to be gone in code,Oops).

> 
> I can't follow that, and the quick look I had at the patches doesn't
> seem to help. I did note it is intel only and that is really sad.

The basic idea of optimization is x86 generic, and the implementation is 
not intentional cause I could not access non-Intel machines and verified it.

> 
> It also makes a mess of who programs what msr when.
> 

who programs: vPMU does as usual in pmc_reprogram_counter

what msr: host perf scheduler make decisions and I'm not sure the hosy 
perf would do cross-mapping scheduling which means to assign a host 
fixed counter to guest gp counter and vice versa.

when programs: every time to call reprogram_gp/fixed_counter && 
pmc_is_assigned(pmc) is false; check the fifth pacth for details.
