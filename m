Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2894ECE588
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 13:03:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AEAA2064B
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 13:03:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729525AbfJONDJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 09:03:09 -0400
Received: from foss.arm.com ([217.140.110.172]:38382 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727525AbfJONDI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 09:03:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8903F337;
        Tue, 15 Oct 2019 06:03:07 -0700 (PDT)
Received: from dawn-kernel.cambridge.arm.com (unknown [10.1.197.116])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9FF533F718;
        Tue, 15 Oct 2019 06:03:06 -0700 (PDT)
Subject: Re: [PATCH 1/3] arm64: cpufeature: Fix the type of no FP/SIMD
 capability
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Dave Martin <Dave.Martin@arm.com>
Cc:     Mark Rutland <Mark.Rutland@arm.com>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "will@kernel.org" <will@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <20191010171517.28782-1-suzuki.poulose@arm.com>
 <20191010171517.28782-2-suzuki.poulose@arm.com>
 <20191011113620.GG27757@arm.com>
 <4ba5c423-4e2a-d810-cd36-32a16ad42c91@arm.com>
 <20191011142137.GH27757@arm.com>
 <418b0c4b-cbcd-4263-276d-1e9edc5eee0b@arm.com>
 <20191014145204.GS27757@arm.com>
 <12e002e7-42e8-c205-e42c-3348359d2f98@arm.com>
 <20191014155009.GM24047@e103592.cambridge.arm.com>
 <CAKv+Gu83oa3+DKNFowVkE=mZfLorAvGQ3GVPiZtsXzQBcsMCWg@mail.gmail.com>
 <20191015102459.GV27757@arm.com>
 <CAKv+Gu_=jw94Hj5Vo=5w+hb5RcPR4SQvxOM02WQr9hDhyzE67g@mail.gmail.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <4b4ead8e-383e-67ee-672d-247a52f6c7f3@arm.com>
Date:   Tue, 15 Oct 2019 14:03:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu_=jw94Hj5Vo=5w+hb5RcPR4SQvxOM02WQr9hDhyzE67g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15/10/2019 11:30, Ard Biesheuvel wrote:
> On Tue, 15 Oct 2019 at 12:25, Dave Martin <Dave.Martin@arm.com> wrote:
>>
>> On Mon, Oct 14, 2019 at 06:57:30PM +0200, Ard Biesheuvel wrote:
>>> On Mon, 14 Oct 2019 at 17:50, Dave P Martin <Dave.Martin@arm.com> wrote:
>>>>
>>>> On Mon, Oct 14, 2019 at 04:45:40PM +0100, Suzuki K Poulose wrote:
>>>>>
>>>>>
>>>>> On 14/10/2019 15:52, Dave Martin wrote:
>>>>>> On Fri, Oct 11, 2019 at 06:28:43PM +0100, Suzuki K Poulose wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 11/10/2019 15:21, Dave Martin wrote:
>>>>>>>> On Fri, Oct 11, 2019 at 01:13:18PM +0100, Suzuki K Poulose wrote: > Hi Dave
>>>>>>>>>
>>>>>>>>> On 11/10/2019 12:36, Dave Martin wrote:
>>>>>>>>>> On Thu, Oct 10, 2019 at 06:15:15PM +0100, Suzuki K Poulose wrote:
>>>>>>>>>>> The NO_FPSIMD capability is defined with scope SYSTEM, which implies
>>>>>>>>>>> that the "absence" of FP/SIMD on at least one CPU is detected only
>>>>>>>>>>> after all the SMP CPUs are brought up. However, we use the status
>>>>>>>>>>> of this capability for every context switch. So, let us change
>>>>>>>>>>> the scop to LOCAL_CPU to allow the detection of this capability
>>>>>>>>>>> as and when the first CPU without FP is brought up.
>>>>>>>>>>>
>>>>>>>>>>> Also, the current type allows hotplugged CPU to be brought up without
>>>>>>>>>>> FP/SIMD when all the current CPUs have FP/SIMD and we have the userspace
>>>>>>>>>>> up. Fix both of these issues by changing the capability to
>>>>>>>>>>> BOOT_RESTRICTED_LOCAL_CPU_FEATURE.
>>>>>>>>>>>
>>>>>>>>>>> Fixes: 82e0191a1aa11abf ("arm64: Support systems without FP/ASIMD")
>>>>>>>>>>> Cc: Will Deacon <will@kernel.org>
>>>>>>>>>>> Cc: Mark Rutland <mark.rutland@arm.com>
>>>>>>>>>>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>>>>>>>>>>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>>>>>>>>>>> ---
>>>>>>>>>>>    arch/arm64/kernel/cpufeature.c | 2 +-
>>>>>>>>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>>>>>>
>>>>>>>>>>> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
>>>>>>>>>>> index 9323bcc40a58..0f9eace6c64b 100644
>>>>>>>>>>> --- a/arch/arm64/kernel/cpufeature.c
>>>>>>>>>>> +++ b/arch/arm64/kernel/cpufeature.c
>>>>>>>>>>> @@ -1361,7 +1361,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
>>>>>>>>>>>         {
>>>>>>>>>>>                 /* FP/SIMD is not implemented */
>>>>>>>>>>>                 .capability = ARM64_HAS_NO_FPSIMD,
>>>>>>>>>>> -              .type = ARM64_CPUCAP_SYSTEM_FEATURE,
>>>>>>>>>>> +              .type = ARM64_CPUCAP_BOOT_RESTRICTED_CPU_LOCAL_FEATURE,
>>>>>>>>>>
>>>>>>>>>> ARM64_HAS_NO_FPSIMD is really a disability, not a capability.
>>>>>>>>>>
>>>>>>>>>> Although we have other things that smell like this (CPU errata for
>>>>>>>>>> example), I wonder whether inverting the meaning in the case would
>>>>>>>>>> make the situation easier to understand.
>>>>>>>>>
>>>>>>>>> Yes, it is indeed a disability, more on that below.
>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> So, we'd have ARM64_HAS_FPSIMD, with a minimum (signed) feature field
>>>>>>>>>> value of 0.  Then this just looks like an ARM64_CPUCAP_SYSTEM_FEATURE
>>>>>>>>>> IIUC.  We'd just need to invert the sense of the check in
>>>>>>>>>> system_supports_fpsimd().
>>>>>>>>>
>>>>>>>>> This is particularly something we want to avoid with this patch. We want
>>>>>>>>> to make sure that we have the up-to-date status of the disability right
>>>>>>>>> when it happens. i.e, a CPU without FP/SIMD is brought up. With SYSTEM_FEATURE
>>>>>>>>> you have to wait until we bring all the CPUs up. Also, for HAS_FPSIMD,
>>>>>>>>> you must wait until all the CPUs are up, unlike the negated capability.
>>>>>>>>
>>>>>>>> I don't see why waiting for the random defective early CPU to come up is
>>>>>>>> better than waiting for all the early CPUs to come up and then deciding.
>>>>>>>>
>>>>>>>> Kernel-mode NEON aside, the status of this cap should not matter until
>>>>>>>> we enter userspace for the first time.
>>>>>>>>
>>>>>>>> The only issue is if e.g., crypto drivers that can use kernel-mode NEON
>>>>>>>> probe for it before all early CPUs are up, and so cache the wrong
>>>>>>>> decision.  The current approach doesn't cope with that anyway AFAICT.
>>>>>>>
>>>>>>> This approach does in fact. With LOCAL_CPU scope, the moment a defective
>>>>>>> CPU turns up, we mark the "capability" and thus the kernel cannot use
>>>>>>> the neon then onwards, unlike the existing case where we have time till
>>>>>>> we boot all the CPUs (even when the boot CPU may be defective).
>>>>>>
>>>>>> I guess that makes sense.
>>>>>>
>>>>>> I'm now wondering what happens if anything tries to use kernel-mode NEON
>>>>>> before SVE is initialised -- which doesn't happen until cpufeatures
>>>>>> configures the system features.
>>>>>>
>>>>>> I don't think your proposed change makes anything worse here, but it may
>>>>>> need looking into.
>>>>>
>>>>> We could throw in a WARN_ON() in kernel_neon() to make sure that the SVE
>>>>> is initialised ?
>>>>
>>>> Could do, at least as an experiment.
>>>>
>>>> Ard, do you have any thoughts on this?
>>>>
>>>
>>> All in-kernel NEON code checks whether the NEON is usable, so I'd
>>> expect that check to return 'false' if it is too early in the boot for
>>> the NEON to be used at all.
>>
>> My concern is that the check may be done once, at probe time, for crypto
>> drivers.  If probing happens before system_supports_fpsimd() has
>> stabilised, we may be stuck with the wrong probe decision.
>>
>> So: are crypto drivers and kernel_mode_neon() users definitely only
>> probed _after_ all early CPUs are up?
>>
> 
> Isn't SMP already up when initcalls are processed?

Not all of them. Booting with initcall_debug=1 shows the following :

--

  // trimmed //

[    0.000000] NR_IRQS:64 nr_irqs:64 0 
 
 

[    0.000000] GIC: Using split EOI/Deactivate mode 
 
 

[    0.000000] CPU0: found redistributor 0 region 0:0x000000002f100000 
 
 

[    0.000000] Architected cp15 timer(s) running at 100.00MHz (phys). 
 
 

[    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff max_cycles: 
0x171024e7e0, max_idle_ns: 440795205315 ns
[    0.000029] sched_clock: 56 bits at 100MHz, resolution 10ns, wraps every 
4398046511100ns
[    0.000989] Console: colour dummy device 80x25 

[    0.001049] Calibrating delay loop (skipped), value calculated using timer 
frequency.. 200.00 BogoMIPS (lpj=400000)
[    0.001149] pid_max: default: 32768 minimum: 301 

[    0.001549] Security Framework initialized 

[    0.001802] Mount-cache hash table entries: 8192 (order: 4, 65536 bytes) 

[    0.001849] Mountpoint-cache hash table entries: 8192 (order: 4, 65536 bytes) 

[    0.004949] Initializing cgroup subsys io
[    0.005042] Initializing cgroup subsys memory
[    0.005079] Initializing cgroup subsys devices
[    0.005149] Initializing cgroup subsys perf_event
[    0.005255] Initializing cgroup subsys hugetlb
[    0.005255] Initializing cgroup subsys pids

[    0.006002] calling  cpu_suspend_init+0x0/0x78 @ 1 

[    0.006062] initcall cpu_suspend_init+0x0/0x78 returned 0 after 0 usecs
[    0.006149] calling  arm64_enable_runtime_services+0x0/0x200 @ 1
[    0.006225] EFI services will not be available. 

[    0.006249] initcall arm64_enable_runtime_services+0x0/0x200 returned 0 after 
0 usecs
[    0.006389] calling  asids_init+0x0/0xf8 @ 1
[    0.006449] ASID allocator initialised with 65536 entries 

[    0.006535] initcall asids_init+0x0/0xf8 returned 0 after 0 usecs
[    0.006553] calling  xen_guest_init+0x0/0x1d8 @ 1 

[    0.006649] initcall xen_guest_init+0x0/0x1d8 returned 0 after 0 usecs
[    0.006749] calling  spawn_ksoftirqd+0x0/0x40 @ 1 

[    0.007749] initcall spawn_ksoftirqd+0x0/0x40 returned 0 after 3906 usecs
[    0.007864] calling  init_workqueues+0x0/0x3ec @ 1 

[    0.019869] initcall init_workqueues+0x0/0x3ec returned 0 after 11718 usecs
[    0.019988] calling  migration_init+0x0/0x84 @ 1 

[    0.020082] initcall migration_init+0x0/0x84 returned 0 after 0 usecs
[    0.020189] calling  check_cpu_stall_init+0x0/0x28 @ 1 

[    0.020316] initcall check_cpu_stall_init+0x0/0x28 returned 0 after 0 usecs
[    0.020449] calling  rcu_spawn_gp_kthread+0x0/0x12c @ 1 

[    0.020971] initcall rcu_spawn_gp_kthread+0x0/0x12c returned 0 after 0 usecs
[    0.021049] calling  cpu_stop_init+0x0/0xe0 @ 1 

[    0.023815] initcall cpu_stop_init+0x0/0xe0 returned 0 after 3906 usecs
[    0.023922] calling  jump_label_init_module+0x0/0x20 @ 1 

[    0.023949] initcall jump_label_init_module+0x0/0x20 returned 0 after 0 usecs
[    0.024084] calling  its_pci_msi_init+0x0/0xec @ 1 

[    0.024249] /interrupt-controller@2f000000/its@2f020000: unable to locate ITS 
domain
[    0.024349] initcall its_pci_msi_init+0x0/0xec returned 0 after 0 usecs
[    0.024455] calling  its_pmsi_init+0x0/0xec @ 1 

[    0.024576] /interrupt-controller@2f000000/its@2f020000: unable to locate ITS 
domain
[    0.024669] initcall its_pmsi_init+0x0/0xec returned 0 after 0 usecs
[    0.024849] calling  tegra_init_fuse+0x0/0x150 @ 1 

[    0.025095] initcall tegra_init_fuse+0x0/0x150 returned 0 after 0 usecs
[    0.025231] calling  tegra_pmc_early_init+0x0/0xfc @ 1 

[    0.025749] initcall tegra_pmc_early_init+0x0/0xfc returned 0 after 0 usecs
[    0.025886] calling  rand_initialize+0x0/0x40 @ 1 

[    0.026849] initcall rand_initialize+0x0/0x40 returned 0 after 0 usecs
[    0.026949] calling  dummy_timer_register+0x0/0x54 @ 1 

[    0.027033] initcall dummy_timer_register+0x0/0x54 returned 0 after 0 usecs


[    0.035949] Detected PIPT I-cache on CPU1 

[    0.036049] CPU1: found redistributor 1 region 0:0x000000002f120000
[    0.036082] CPU1: Booted secondary processor [410fd0f0]
[    0.048049] Detected PIPT I-cache on CPU2 

[    0.048149] CPU2: found redistributor 2 region 0:0x000000002f140000
[    0.048168] CPU2: Booted secondary processor [410fd0f0]
[    0.060249] Detected PIPT I-cache on CPU3 

[    0.060349] CPU3: found redistributor 3 region 0:0x000000002f160000
[    0.060402] CPU3: Booted secondary processor [410fd0f0]
[    0.060620] Brought up 4 CPUs
[    0.060949] SMP: Total of 4 processors activated.


Cheers
Suzuki
