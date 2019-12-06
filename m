Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D7EC43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 15:48:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 652E020659
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 15:48:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbfLFPsn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 10:48:43 -0500
Received: from foss.arm.com ([217.140.110.172]:48578 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726251AbfLFPsn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 10:48:43 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 29A7231B;
        Fri,  6 Dec 2019 07:48:42 -0800 (PST)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 956AF3F718;
        Fri,  6 Dec 2019 07:48:41 -0800 (PST)
Date:   Fri, 6 Dec 2019 15:48:39 +0000
From:   Andrew Murray <andrew.murray@arm.com>
To:     Auger Eric <eric.auger@redhat.com>
Cc:     Marc Zyngier <maz@kernel.org>, eric.auger.pro@gmail.com,
        linux-kernel@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
        james.morse@arm.com, suzuki.poulose@arm.com, drjones@redhat.com
Subject: Re: [RFC 2/3] KVM: arm64: pmu: Fix chained SW_INCR counters
Message-ID: <20191206154839.GO18399@e119886-lin.cambridge.arm.com>
References: <20191204204426.9628-1-eric.auger@redhat.com>
 <20191204204426.9628-3-eric.auger@redhat.com>
 <561ac6df385e977cc51d51a8ab28ee49@www.loen.fr>
 <2b30c1ca-3bc0-9f73-4bea-ee42bb74cbac@redhat.com>
 <15507faca89a980056df7119e105e82a@www.loen.fr>
 <145cdd1c-266c-6252-9688-e9e4c6809dfd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <145cdd1c-266c-6252-9688-e9e4c6809dfd@redhat.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 05, 2019 at 08:01:42PM +0100, Auger Eric wrote:
> Hi Marc,
> 
> On 12/5/19 3:52 PM, Marc Zyngier wrote:
> > On 2019-12-05 14:06, Auger Eric wrote:
> >> Hi Marc,
> >>
> >> On 12/5/19 10:43 AM, Marc Zyngier wrote:
> >>> Hi Eric,
> >>>
> >>> On 2019-12-04 20:44, Eric Auger wrote:
> >>>> At the moment a SW_INCR counter always overflows on 32-bit
> >>>> boundary, independently on whether the n+1th counter is
> >>>> programmed as CHAIN.
> >>>>
> >>>> Check whether the SW_INCR counter is a 64b counter and if so,
> >>>> implement the 64b logic.
> >>>>
> >>>> Fixes: 80f393a23be6 ("KVM: arm/arm64: Support chained PMU counters")
> >>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> >>>> ---
> >>>>  virt/kvm/arm/pmu.c | 16 +++++++++++++++-
> >>>>  1 file changed, 15 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/virt/kvm/arm/pmu.c b/virt/kvm/arm/pmu.c
> >>>> index c3f8b059881e..7ab477db2f75 100644
> >>>> --- a/virt/kvm/arm/pmu.c
> >>>> +++ b/virt/kvm/arm/pmu.c
> >>>> @@ -491,6 +491,8 @@ void kvm_pmu_software_increment(struct kvm_vcpu
> >>>> *vcpu, u64 val)
> >>>>
> >>>>      enable = __vcpu_sys_reg(vcpu, PMCNTENSET_EL0);
> >>>>      for (i = 0; i < ARMV8_PMU_CYCLE_IDX; i++) {
> >>>> +        bool chained = test_bit(i >> 1, vcpu->arch.pmu.chained);
> >>>> +
> >>>
> >>> I'd rather you use kvm_pmu_pmc_is_chained() rather than open-coding
> >>> this. But see below:
> >>>
> >>>>          if (!(val & BIT(i)))
> >>>>              continue;
> >>>>          type = __vcpu_sys_reg(vcpu, PMEVTYPER0_EL0 + i)
> >>>> @@ -500,8 +502,20 @@ void kvm_pmu_software_increment(struct kvm_vcpu
> >>>> *vcpu, u64 val)
> >>>>              reg = __vcpu_sys_reg(vcpu, PMEVCNTR0_EL0 + i) + 1;
> >>>>              reg = lower_32_bits(reg);
> >>>>              __vcpu_sys_reg(vcpu, PMEVCNTR0_EL0 + i) = reg;
> >>>> -            if (!reg)
> >>>> +            if (reg) /* no overflow */
> >>>> +                continue;
> >>>> +            if (chained) {
> >>>> +                reg = __vcpu_sys_reg(vcpu, PMEVCNTR0_EL0 + i + 1) + 1;
> >>>> +                reg = lower_32_bits(reg);
> >>>> +                __vcpu_sys_reg(vcpu, PMEVCNTR0_EL0 + i + 1) = reg;
> >>>> +                if (reg)
> >>>> +                    continue;
> >>>> +                /* mark an overflow on high counter */
> >>>> +                __vcpu_sys_reg(vcpu, PMOVSSET_EL0) |= BIT(i + 1);
> >>>> +            } else {
> >>>> +                /* mark an overflow */
> >>>>                  __vcpu_sys_reg(vcpu, PMOVSSET_EL0) |= BIT(i);
> >>>> +            }
> >>>>          }
> >>>>      }
> >>>>  }
> >>>
> >>> I think the whole function is a bit of a mess, and could be better
> >>> structured to treat 64bit counters as a first class citizen.
> >>>
> >>> I'm suggesting something along those lines, which tries to
> >>> streamline things a bit and keep the flow uniform between the
> >>> two word sizes. IMHO, it helps reasonning about it and gives
> >>> scope to the ARMv8.5 full 64bit counters... It is of course
> >>> completely untested.
> >>
> >> Looks OK to me as well. One remark though, don't we need to test if the
> >> n+1th reg is enabled before incrementing it?
> > 
> > Hmmm. I'm not sure. I think we should make sure that we don't flag
> > a counter as being chained if the odd counter is disabled, rather
> > than checking it here. As long as the odd counter is not chained
> > *and* enabled, we shouldn't touch it.>
> > Again, untested:
> > 
> > diff --git a/virt/kvm/arm/pmu.c b/virt/kvm/arm/pmu.c
> > index cf371f643ade..47366817cd2a 100644
> > --- a/virt/kvm/arm/pmu.c
> > +++ b/virt/kvm/arm/pmu.c
> > @@ -15,6 +15,7 @@
> >  #include <kvm/arm_vgic.h>
> > 
> >  static void kvm_pmu_create_perf_event(struct kvm_vcpu *vcpu, u64
> > select_idx);
> > +static void kvm_pmu_update_pmc_chained(struct kvm_vcpu *vcpu, u64
> > select_idx);
> > 
> >  #define PERF_ATTR_CFG1_KVM_PMU_CHAINED 0x1
> > 
> > @@ -298,6 +299,7 @@ void kvm_pmu_enable_counter_mask(struct kvm_vcpu
> > *vcpu, u64 val)
> >           * For high counters of chained events we must recreate the
> >           * perf event with the long (64bit) attribute set.
> >           */
> > +        kvm_pmu_update_pmc_chained(vcpu, i);
> >          if (kvm_pmu_pmc_is_chained(pmc) &&
> >              kvm_pmu_idx_is_high_counter(i)) {
> >              kvm_pmu_create_perf_event(vcpu, i);
> > @@ -645,7 +647,8 @@ static void kvm_pmu_update_pmc_chained(struct
> > kvm_vcpu *vcpu, u64 select_idx)
> >      struct kvm_pmu *pmu = &vcpu->arch.pmu;
> >      struct kvm_pmc *pmc = &pmu->pmc[select_idx];
> > 
> > -    if (kvm_pmu_idx_has_chain_evtype(vcpu, pmc->idx)) {
> > +    if (kvm_pmu_idx_has_chain_evtype(vcpu, pmc->idx) &&
> > +        kvm_pmu_counter_is_enabled(vcpu, pmc->idx)) {
> 
> In create_perf_event(), has_chain_evtype() is used and a 64b sample
> period would be chosen even if the counters are disjoined (since the odd
> is disabled). We would need to use pmc_is_chained() instead.

So in this use-case, someone has configured a pair of chained counters
but only enabled the lower half. In this case we only create a 32bit backing
event (no PERF_ATTR_CFG1_KVM_PMU_CHAINED flag) - I guess this means the
perf event will trigger on 64bit period(?) despite the high counter being
disabled. The guest will see an interrupt in their disabled high counter.

This is a know limitation - see the comment "For
chained counters we only support overflow interrupts on the high counter"

Though upon looking at this it seems a little more broken. I guess where
both counters are enabled we want to overflow at 64bits and raise the
overflow to the high counter. When the high counter is disabled we want to
overflow on 32bits and raise the overflow to the low counter.

Perhaps something like the following would help:

--- a/virt/kvm/arm/pmu.c
+++ b/virt/kvm/arm/pmu.c
@@ -585,15 +585,16 @@ static void kvm_pmu_create_perf_event(struct kvm_vcpu *vcpu, u64 select_idx)
 
        counter = kvm_pmu_get_pair_counter_value(vcpu, pmc);
 
-       if (kvm_pmu_idx_has_chain_evtype(vcpu, pmc->idx)) {
+       if (kvm_pmu_idx_has_chain_evtype(vcpu, pmc->idx) &&
+           kvm_pmu_counter_is_enabled(vcpu, pmc->idx + 1))
+
                /**
                 * The initial sample period (overflow count) of an event. For
                 * chained counters we only support overflow interrupts on the
                 * high counter.
                 */
                attr.sample_period = (-counter) & GENMASK(63, 0);
-               if (kvm_pmu_counter_is_enabled(vcpu, pmc->idx + 1))
-                       attr.config1 |= PERF_ATTR_CFG1_KVM_PMU_CHAINED;
+               attr.config1 |= PERF_ATTR_CFG1_KVM_PMU_CHAINED;
 
                event = perf_event_create_kernel_counter(&attr, -1, current,
                                                         kvm_pmu_perf_overflow,


It's not clear to me what is supposed to happen with overflow handling on the
low counter on chained counters (where the high counter is disabled).


> 
> With perf_events, the check of whether the odd register is enabled is
> properly done (create_perf_event). Then I understand whenever there is a
> change in enable state or type we delete the previous perf event and
> re-create a new one. Enable state check just is missing for SW_INCR.
> 
> Some other questions:
> - do we need a perf event to be created even if the counter is not
> enabled? For instance on counter resets, create_perf_events get called.

That would suggest we create and destroy them each time the guest enables
and disables the counters - I would expect them to do that a lot (every
context switch) - my assumption would be that the current approach has
less overhead for a running guest.


> - also actions are made for counters which are not implemented. loop
> until ARMV8_PMU_MAX_COUNTERS. Do you think it is valuable to have a
> bitmask of supported counters stored before pmu readiness?
> I can propose such changes if you think they are valuable.

Are they? Many of the calls into this file come from
arch/arm64/kvm/sys_regs.c where we apply a mask (value from
kvm_pmu_valid_counter_mask) to ignore unsupported counters.

Thanks,

Andrew Murray


> 
> Thanks
> 
> Eric
> 
> >          /*
> >           * During promotion from !chained to chained we must ensure
> >           * the adjacent counter is stopped and its event destroyed
> > 
> > What do you think?
> > 
> >         M.
> 
