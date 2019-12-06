Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F284FC43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 09:56:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE6E520659
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 09:56:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cqv67j4s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbfLFJ41 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 04:56:27 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38403 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726070AbfLFJ41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 04:56:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575626185;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VOvbHJVSDRI4m0IXeh03+Ff7np0GCFp67dk4huZAiEc=;
        b=cqv67j4sttSY5qTjMR33vCJgrOxoREULo1mrzjngDUf4bUEzmqqBcRtr/qIMjio0AWx9f3
        DwISxd8aAzVSZkyNx7vJJGiLCMvm0+Y9CcdPzIEnLuJRLhZXtjNAGJw/300GJ3mKom60/S
        re5zg/SWmu+Vm6VsQVBlG0G/FsDJwfw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-377-VidzrRDDPNqgK98wMd65Qg-1; Fri, 06 Dec 2019 04:56:22 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 81B07107ACC4;
        Fri,  6 Dec 2019 09:56:20 +0000 (UTC)
Received: from [10.36.116.117] (ovpn-116-117.ams2.redhat.com [10.36.116.117])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 07E96A4B8F;
        Fri,  6 Dec 2019 09:56:17 +0000 (UTC)
Subject: Re: [RFC 2/3] KVM: arm64: pmu: Fix chained SW_INCR counters
From:   Auger Eric <eric.auger@redhat.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     eric.auger.pro@gmail.com, linux-kernel@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, james.morse@arm.com,
        andrew.murray@arm.com, suzuki.poulose@arm.com, drjones@redhat.com
References: <20191204204426.9628-1-eric.auger@redhat.com>
 <20191204204426.9628-3-eric.auger@redhat.com>
 <561ac6df385e977cc51d51a8ab28ee49@www.loen.fr>
 <2b30c1ca-3bc0-9f73-4bea-ee42bb74cbac@redhat.com>
 <15507faca89a980056df7119e105e82a@www.loen.fr>
 <145cdd1c-266c-6252-9688-e9e4c6809dfd@redhat.com>
Message-ID: <ef4d407e-94e5-a13f-8e06-beda1d3d6459@redhat.com>
Date:   Fri, 6 Dec 2019 10:56:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <145cdd1c-266c-6252-9688-e9e4c6809dfd@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: VidzrRDDPNqgK98wMd65Qg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/5/19 8:01 PM, Auger Eric wrote:
> Hi Marc,
>=20
> On 12/5/19 3:52 PM, Marc Zyngier wrote:
>> On 2019-12-05 14:06, Auger Eric wrote:
>>> Hi Marc,
>>>
>>> On 12/5/19 10:43 AM, Marc Zyngier wrote:
>>>> Hi Eric,
>>>>
>>>> On 2019-12-04 20:44, Eric Auger wrote:
>>>>> At the moment a SW_INCR counter always overflows on 32-bit
>>>>> boundary, independently on whether the n+1th counter is
>>>>> programmed as CHAIN.
>>>>>
>>>>> Check whether the SW_INCR counter is a 64b counter and if so,
>>>>> implement the 64b logic.
>>>>>
>>>>> Fixes: 80f393a23be6 ("KVM: arm/arm64: Support chained PMU counters")
>>>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>>>> ---
>>>>> =C2=A0virt/kvm/arm/pmu.c | 16 +++++++++++++++-
>>>>> =C2=A01 file changed, 15 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/virt/kvm/arm/pmu.c b/virt/kvm/arm/pmu.c
>>>>> index c3f8b059881e..7ab477db2f75 100644
>>>>> --- a/virt/kvm/arm/pmu.c
>>>>> +++ b/virt/kvm/arm/pmu.c
>>>>> @@ -491,6 +491,8 @@ void kvm_pmu_software_increment(struct kvm_vcpu
>>>>> *vcpu, u64 val)
>>>>>
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 enable =3D __vcpu_sys_reg(vcpu, PMCNTENSET_E=
L0);
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < ARMV8_PMU_CYCLE_IDX; i++) =
{
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool chained =3D test_bit=
(i >> 1, vcpu->arch.pmu.chained);
>>>>> +
>>>>
>>>> I'd rather you use kvm_pmu_pmc_is_chained() rather than open-coding
>>>> this. But see below:
>>>>
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!(val & BIT(i)))
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 continue;
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 type =3D __vcpu_sys_=
reg(vcpu, PMEVTYPER0_EL0 + i)
>>>>> @@ -500,8 +502,20 @@ void kvm_pmu_software_increment(struct kvm_vcpu
>>>>> *vcpu, u64 val)
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 reg =3D __vcpu_sys_reg(vcpu, PMEVCNTR0_EL0 + i) + 1;
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 reg =3D lower_32_bits(reg);
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 __vcpu_sys_reg(vcpu, PMEVCNTR0_EL0 + i) =3D reg;
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 i=
f (!reg)
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 i=
f (reg) /* no overflow */
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 continue;
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 i=
f (chained) {
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 reg =3D __vcpu_sys_reg(vcpu, PMEVCNTR0_EL0 + i + 1=
) + 1;
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 reg =3D lower_32_bits(reg);
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 __vcpu_sys_reg(vcpu, PMEVCNTR0_EL0 + i + 1) =3D re=
g;
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 if (reg)
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 continue;
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 /* mark an overflow on high counter */
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 __vcpu_sys_reg(vcpu, PMOVSSET_EL0) |=3D BIT(i + 1)=
;
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }=
 else {
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 /* mark an overflow */
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 __vcpu_sys_reg(vcpu, PMOVSSET_EL0) |=3D BIT(i);
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>> =C2=A0}
>>>>
>>>> I think the whole function is a bit of a mess, and could be better
>>>> structured to treat 64bit counters as a first class citizen.
>>>>
>>>> I'm suggesting something along those lines, which tries to
>>>> streamline things a bit and keep the flow uniform between the
>>>> two word sizes. IMHO, it helps reasonning about it and gives
>>>> scope to the ARMv8.5 full 64bit counters... It is of course
>>>> completely untested.
>>>
>>> Looks OK to me as well. One remark though, don't we need to test if the
>>> n+1th reg is enabled before incrementing it?
>>
>> Hmmm. I'm not sure. I think we should make sure that we don't flag
>> a counter as being chained if the odd counter is disabled, rather
>> than checking it here. As long as the odd counter is not chained
>> *and* enabled, we shouldn't touch it.>
>> Again, untested:
>>
>> diff --git a/virt/kvm/arm/pmu.c b/virt/kvm/arm/pmu.c
>> index cf371f643ade..47366817cd2a 100644
>> --- a/virt/kvm/arm/pmu.c
>> +++ b/virt/kvm/arm/pmu.c
>> @@ -15,6 +15,7 @@
>> =C2=A0#include <kvm/arm_vgic.h>
>>
>> =C2=A0static void kvm_pmu_create_perf_event(struct kvm_vcpu *vcpu, u64
>> select_idx);
>> +static void kvm_pmu_update_pmc_chained(struct kvm_vcpu *vcpu, u64
>> select_idx);
>>
>> =C2=A0#define PERF_ATTR_CFG1_KVM_PMU_CHAINED 0x1
>>
>> @@ -298,6 +299,7 @@ void kvm_pmu_enable_counter_mask(struct kvm_vcpu
>> *vcpu, u64 val)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * For high counte=
rs of chained events we must recreate the
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * perf event with=
 the long (64bit) attribute set.
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kvm_pmu_update_pmc_chained(v=
cpu, i);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (kvm_pmu_pmc_is_chai=
ned(pmc) &&
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 kvm_pmu_idx_is_high_counter(i)) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 kvm_pmu_create_perf_event(vcpu, i);
>> @@ -645,7 +647,8 @@ static void kvm_pmu_update_pmc_chained(struct
>> kvm_vcpu *vcpu, u64 select_idx)
>> =C2=A0=C2=A0=C2=A0=C2=A0 struct kvm_pmu *pmu =3D &vcpu->arch.pmu;
>> =C2=A0=C2=A0=C2=A0=C2=A0 struct kvm_pmc *pmc =3D &pmu->pmc[select_idx];
>>
>> -=C2=A0=C2=A0=C2=A0 if (kvm_pmu_idx_has_chain_evtype(vcpu, pmc->idx)) {
>> +=C2=A0=C2=A0=C2=A0 if (kvm_pmu_idx_has_chain_evtype(vcpu, pmc->idx) &&
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kvm_pmu_counter_is_enabled(v=
cpu, pmc->idx)) {
>=20
> In create_perf_event(), has_chain_evtype() is used and a 64b sample
> period would be chosen even if the counters are disjoined (since the odd
> is disabled). We would need to use pmc_is_chained() instead.
>=20
> With perf_events, the check of whether the odd register is enabled is
> properly done (create_perf_event).

Hum that's not fully true. If we do not enable the CHAIN odd one but
only the event one, the correct 32b perf counter is created. But when
reading the odd reg after overflow we get the incremented value
(get_counter_value).

Thanks

Eric

 Then I understand whenever there is a
> change in enable state or type we delete the previous perf event and
> re-create a new one. Enable state check just is missing for SW_INCR.
>=20
> Some other questions:
> - do we need a perf event to be created even if the counter is not
> enabled? For instance on counter resets, create_perf_events get called.
> - also actions are made for counters which are not implemented. loop
> until ARMV8_PMU_MAX_COUNTERS. Do you think it is valuable to have a
> bitmask of supported counters stored before pmu readiness?
> I can propose such changes if you think they are valuable.
>=20
> Thanks
>=20
> Eric
>=20
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * During promotio=
n from !chained to chained we must ensure
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * the adjacent co=
unter is stopped and its event destroyed
>>
>> What do you think?
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 M.

