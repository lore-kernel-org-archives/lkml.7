Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F039AC43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 15:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9CD924659
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 15:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575646507;
	bh=rpB24Xs2DS8YUZCVtyvxGO5P67Tx7dzE6Pd3iNy2soU=;
	h=To:Subject:Date:From:Cc:In-Reply-To:References:List-ID:From;
	b=voz5GchLEJKLDMPrNAtQzDn+GTgz+ktQWJF1Yus3qfEvH4Nf8Yb9H+5duze9kZAzx
	 b55EP09CWBUPkOtkRtwE3Djx7GJEqlRl2f8023TvO21b/9sjtO2KdAaAj83S3ozwJ0
	 3QE3/7PSDEBhqwLrYMsz+SiWlLSUvGwj/JXpg4LI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbfLFPfG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 10:35:06 -0500
Received: from inca-roads.misterjones.org ([213.251.177.50]:58523 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726250AbfLFPfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 10:35:06 -0500
Received: from www-data by cheepnis.misterjones.org with local (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1idFdH-0005W9-6Z; Fri, 06 Dec 2019 16:35:03 +0100
To:     Andrew Murray <andrew.murray@arm.com>
Subject: Re: [RFC 2/3] KVM: arm64: pmu: Fix chained =?UTF-8?Q?SW=5FINCR=20?=  =?UTF-8?Q?counters?=
X-PHP-Originating-Script: 0:main.inc
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Fri, 06 Dec 2019 15:35:03 +0000
From:   Marc Zyngier <maz@kernel.org>
Cc:     Auger Eric <eric.auger@redhat.com>, <eric.auger.pro@gmail.com>,
        <linux-kernel@vger.kernel.org>, <kvmarm@lists.cs.columbia.edu>,
        <james.morse@arm.com>, <suzuki.poulose@arm.com>,
        <drjones@redhat.com>
In-Reply-To: <20191206152141.GN18399@e119886-lin.cambridge.arm.com>
References: <20191204204426.9628-1-eric.auger@redhat.com>
 <20191204204426.9628-3-eric.auger@redhat.com>
 <561ac6df385e977cc51d51a8ab28ee49@www.loen.fr>
 <2b30c1ca-3bc0-9f73-4bea-ee42bb74cbac@redhat.com>
 <15507faca89a980056df7119e105e82a@www.loen.fr>
 <20191206152141.GN18399@e119886-lin.cambridge.arm.com>
Message-ID: <ea510414e337a4cab8ed9df737959368@www.loen.fr>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/0.7.2
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Rcpt-To: andrew.murray@arm.com, eric.auger@redhat.com, eric.auger.pro@gmail.com, linux-kernel@vger.kernel.org, kvmarm@lists.cs.columbia.edu, james.morse@arm.com, suzuki.poulose@arm.com, drjones@redhat.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-12-06 15:21, Andrew Murray wrote:
> On Thu, Dec 05, 2019 at 02:52:26PM +0000, Marc Zyngier wrote:
>> On 2019-12-05 14:06, Auger Eric wrote:
>> > Hi Marc,
>> >
>> > On 12/5/19 10:43 AM, Marc Zyngier wrote:
>> > > Hi Eric,
>> > >
>> > > On 2019-12-04 20:44, Eric Auger wrote:
>> > > > At the moment a SW_INCR counter always overflows on 32-bit
>> > > > boundary, independently on whether the n+1th counter is
>> > > > programmed as CHAIN.
>> > > >
>> > > > Check whether the SW_INCR counter is a 64b counter and if so,
>> > > > implement the 64b logic.
>> > > >
>> > > > Fixes: 80f393a23be6 ("KVM: arm/arm64: Support chained PMU
>> > > > counters")
>> > > > Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> > > > ---
>> > > >  virt/kvm/arm/pmu.c | 16 +++++++++++++++-
>> > > >  1 file changed, 15 insertions(+), 1 deletion(-)
>> > > >
>> > > > diff --git a/virt/kvm/arm/pmu.c b/virt/kvm/arm/pmu.c
>> > > > index c3f8b059881e..7ab477db2f75 100644
>> > > > --- a/virt/kvm/arm/pmu.c
>> > > > +++ b/virt/kvm/arm/pmu.c
>> > > > @@ -491,6 +491,8 @@ void kvm_pmu_software_increment(struct 
>> kvm_vcpu
>> > > > *vcpu, u64 val)
>> > > >
>> > > >      enable = __vcpu_sys_reg(vcpu, PMCNTENSET_EL0);
>> > > >      for (i = 0; i < ARMV8_PMU_CYCLE_IDX; i++) {
>> > > > +        bool chained = test_bit(i >> 1, 
>> vcpu->arch.pmu.chained);
>> > > > +
>> > >
>> > > I'd rather you use kvm_pmu_pmc_is_chained() rather than 
>> open-coding
>> > > this. But see below:
>> > >
>> > > >          if (!(val & BIT(i)))
>> > > >              continue;
>> > > >          type = __vcpu_sys_reg(vcpu, PMEVTYPER0_EL0 + i)
>> > > > @@ -500,8 +502,20 @@ void kvm_pmu_software_increment(struct
>> > > > kvm_vcpu
>> > > > *vcpu, u64 val)
>> > > >              reg = __vcpu_sys_reg(vcpu, PMEVCNTR0_EL0 + i) + 
>> 1;
>> > > >              reg = lower_32_bits(reg);
>> > > >              __vcpu_sys_reg(vcpu, PMEVCNTR0_EL0 + i) = reg;
>> > > > -            if (!reg)
>> > > > +            if (reg) /* no overflow */
>> > > > +                continue;
>> > > > +            if (chained) {
>> > > > +                reg = __vcpu_sys_reg(vcpu, PMEVCNTR0_EL0 + i 
>> +
>> > > > 1) + 1;
>> > > > +                reg = lower_32_bits(reg);
>> > > > +                __vcpu_sys_reg(vcpu, PMEVCNTR0_EL0 + i + 1) = 
>> reg;
>> > > > +                if (reg)
>> > > > +                    continue;
>> > > > +                /* mark an overflow on high counter */
>> > > > +                __vcpu_sys_reg(vcpu, PMOVSSET_EL0) |= BIT(i + 
>> 1);
>> > > > +            } else {
>> > > > +                /* mark an overflow */
>> > > >                  __vcpu_sys_reg(vcpu, PMOVSSET_EL0) |= BIT(i);
>> > > > +            }
>> > > >          }
>> > > >      }
>> > > >  }
>> > >
>> > > I think the whole function is a bit of a mess, and could be 
>> better
>> > > structured to treat 64bit counters as a first class citizen.
>> > >
>> > > I'm suggesting something along those lines, which tries to
>> > > streamline things a bit and keep the flow uniform between the
>> > > two word sizes. IMHO, it helps reasonning about it and gives
>> > > scope to the ARMv8.5 full 64bit counters... It is of course
>> > > completely untested.
>> >
>> > Looks OK to me as well. One remark though, don't we need to test 
>> if the
>> > n+1th reg is enabled before incrementing it?
>
> Indeed - we don't want to indicate an overflow on a disabled counter.
>
>
>>
>> Hmmm. I'm not sure. I think we should make sure that we don't flag
>> a counter as being chained if the odd counter is disabled, rather
>> than checking it here. As long as the odd counter is not chained
>> *and* enabled, we shouldn't touch it.
>
> Does this mean that we don't care if the low counter is enabled or 
> not
> when deciding if the pair is chained?
>
> I would find the code easier to follow if we had an explicit 'is the
> high counter enabled here' check (at the point of deciding where to
> put the overflow).

Sure. But the point is that we're spreading that kind of checks all 
over
the map, and that we don't have a way to even reason about the state of
a 64bit counter. Doesn't it strike you as being mildly broken?

>
>
>>
>> Again, untested:
>>
>> diff --git a/virt/kvm/arm/pmu.c b/virt/kvm/arm/pmu.c
>> index cf371f643ade..47366817cd2a 100644
>> --- a/virt/kvm/arm/pmu.c
>> +++ b/virt/kvm/arm/pmu.c
>> @@ -15,6 +15,7 @@
>>  #include <kvm/arm_vgic.h>
>>
>>  static void kvm_pmu_create_perf_event(struct kvm_vcpu *vcpu, u64
>> select_idx);
>> +static void kvm_pmu_update_pmc_chained(struct kvm_vcpu *vcpu, u64
>> select_idx);
>>
>>  #define PERF_ATTR_CFG1_KVM_PMU_CHAINED 0x1
>>
>> @@ -298,6 +299,7 @@ void kvm_pmu_enable_counter_mask(struct kvm_vcpu 
>> *vcpu,
>> u64 val)
>>  		 * For high counters of chained events we must recreate the
>>  		 * perf event with the long (64bit) attribute set.
>>  		 */
>> +		kvm_pmu_update_pmc_chained(vcpu, i);
>>  		if (kvm_pmu_pmc_is_chained(pmc) &&
>>  		    kvm_pmu_idx_is_high_counter(i)) {
>>  			kvm_pmu_create_perf_event(vcpu, i);
>> @@ -645,7 +647,8 @@ static void kvm_pmu_update_pmc_chained(struct 
>> kvm_vcpu
>> *vcpu, u64 select_idx)
>>  	struct kvm_pmu *pmu = &vcpu->arch.pmu;
>>  	struct kvm_pmc *pmc = &pmu->pmc[select_idx];
>>
>> -	if (kvm_pmu_idx_has_chain_evtype(vcpu, pmc->idx)) {
>> +	if (kvm_pmu_idx_has_chain_evtype(vcpu, pmc->idx) &&
>> +	    kvm_pmu_counter_is_enabled(vcpu, pmc->idx)) {
>
> I.e. here we don't care what the state of enablement is for the low 
> counter.
>
> Also at present, this may break the following use-case
>
>  - User creates and uses a pair of chained counters
>  - User disables odd/high counter
>  - User reads values of both counters
>  - User rewrites CHAIN event to odd/high counter OR user re-enables
> just the even/low counter
>  - User reads value of both counters <- this may now different to the
> last read

Hey, I didn't say it was perfect ;-). But for sure we can't let the
PMU bitrot more than it already has, and I'm not sure this is heading
the right way.

I'm certainly going to push back on new PMU features until we can 
properly
reason about 64bit counters as a top-level entity (as opposed to a 
bunch
of discrete counters).

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
