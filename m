Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 909F1C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 14:07:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 452092245C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 14:07:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dZJZp7fM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729596AbfLEOHD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 09:07:03 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38167 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729236AbfLEOHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 09:07:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575554821;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=azQp6+u/OaRhFbUGciXV+zkPwn2tSlr6PlcS27y4L7s=;
        b=dZJZp7fMgCf2IRWlLeM7a7KMJwPmG5oLVK4No/D8FHBjZ9k18NRG40REk+NmRqjE/IaocV
        5rDOiaq+hzAyTcHtnStzyF15Nflhr7hxQoC7cszSgYMaNQcCt8KRpqhNdq+K8/UIGfxyoO
        DSFOPU1iJzSNfGfwbdAE6F4LmMsx7xk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-334-McVFv0HuOfSqDAGpiofMiA-1; Thu, 05 Dec 2019 09:07:00 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A455A593D7;
        Thu,  5 Dec 2019 14:06:58 +0000 (UTC)
Received: from [10.36.116.117] (ovpn-116-117.ams2.redhat.com [10.36.116.117])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4FE566012E;
        Thu,  5 Dec 2019 14:06:56 +0000 (UTC)
Subject: Re: [RFC 2/3] KVM: arm64: pmu: Fix chained SW_INCR counters
To:     Marc Zyngier <maz@kernel.org>
Cc:     eric.auger.pro@gmail.com, linux-kernel@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, james.morse@arm.com,
        andrew.murray@arm.com, suzuki.poulose@arm.com, drjones@redhat.com
References: <20191204204426.9628-1-eric.auger@redhat.com>
 <20191204204426.9628-3-eric.auger@redhat.com>
 <561ac6df385e977cc51d51a8ab28ee49@www.loen.fr>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <2b30c1ca-3bc0-9f73-4bea-ee42bb74cbac@redhat.com>
Date:   Thu, 5 Dec 2019 15:06:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <561ac6df385e977cc51d51a8ab28ee49@www.loen.fr>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: McVFv0HuOfSqDAGpiofMiA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On 12/5/19 10:43 AM, Marc Zyngier wrote:
> Hi Eric,
>=20
> On 2019-12-04 20:44, Eric Auger wrote:
>> At the moment a SW_INCR counter always overflows on 32-bit
>> boundary, independently on whether the n+1th counter is
>> programmed as CHAIN.
>>
>> Check whether the SW_INCR counter is a 64b counter and if so,
>> implement the 64b logic.
>>
>> Fixes: 80f393a23be6 ("KVM: arm/arm64: Support chained PMU counters")
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> ---
>> =C2=A0virt/kvm/arm/pmu.c | 16 +++++++++++++++-
>> =C2=A01 file changed, 15 insertions(+), 1 deletion(-)
>>
>> diff --git a/virt/kvm/arm/pmu.c b/virt/kvm/arm/pmu.c
>> index c3f8b059881e..7ab477db2f75 100644
>> --- a/virt/kvm/arm/pmu.c
>> +++ b/virt/kvm/arm/pmu.c
>> @@ -491,6 +491,8 @@ void kvm_pmu_software_increment(struct kvm_vcpu
>> *vcpu, u64 val)
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0 enable =3D __vcpu_sys_reg(vcpu, PMCNTENSET_EL0)=
;
>> =C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < ARMV8_PMU_CYCLE_IDX; i++) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool chained =3D test_bit(i =
>> 1, vcpu->arch.pmu.chained);
>> +
>=20
> I'd rather you use kvm_pmu_pmc_is_chained() rather than open-coding
> this. But see below:
>=20
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!(val & BIT(i)))
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 continue;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 type =3D __vcpu_sys_reg=
(vcpu, PMEVTYPER0_EL0 + i)
>> @@ -500,8 +502,20 @@ void kvm_pmu_software_increment(struct kvm_vcpu
>> *vcpu, u64 val)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 reg =3D __vcpu_sys_reg(vcpu, PMEVCNTR0_EL0 + i) + 1;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 reg =3D lower_32_bits(reg);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 __vcpu_sys_reg(vcpu, PMEVCNTR0_EL0 + i) =3D reg;
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (=
!reg)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (=
reg) /* no overflow */
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 continue;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (=
chained) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 reg =3D __vcpu_sys_reg(vcpu, PMEVCNTR0_EL0 + i + 1) +=
 1;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 reg =3D lower_32_bits(reg);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 __vcpu_sys_reg(vcpu, PMEVCNTR0_EL0 + i + 1) =3D reg;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 if (reg)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 continue;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 /* mark an overflow on high counter */
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 __vcpu_sys_reg(vcpu, PMOVSSET_EL0) |=3D BIT(i + 1);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } el=
se {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 /* mark an overflow */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 __vcpu_sys_reg(vcpu, PMOVSSET_EL0) |=3D BIT(i);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0}
>=20
> I think the whole function is a bit of a mess, and could be better
> structured to treat 64bit counters as a first class citizen.
>=20
> I'm suggesting something along those lines, which tries to
> streamline things a bit and keep the flow uniform between the
> two word sizes. IMHO, it helps reasonning about it and gives
> scope to the ARMv8.5 full 64bit counters... It is of course
> completely untested.

Looks OK to me as well. One remark though, don't we need to test if the
n+1th reg is enabled before incrementing it?

Thanks

Eric
>=20
> Thoughts?
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 M.
>=20
> diff --git a/virt/kvm/arm/pmu.c b/virt/kvm/arm/pmu.c
> index 8731dfeced8b..cf371f643ade 100644
> --- a/virt/kvm/arm/pmu.c
> +++ b/virt/kvm/arm/pmu.c
> @@ -480,26 +480,43 @@ static void kvm_pmu_perf_overflow(struct
> perf_event *perf_event,
> =C2=A0 */
> =C2=A0void kvm_pmu_software_increment(struct kvm_vcpu *vcpu, u64 val)
> =C2=A0{
> +=C2=A0=C2=A0=C2=A0 struct kvm_pmu *pmu =3D &vcpu->arch.pmu;
> =C2=A0=C2=A0=C2=A0=C2=A0 int i;
> -=C2=A0=C2=A0=C2=A0 u64 type, enable, reg;
>=20
> -=C2=A0=C2=A0=C2=A0 if (val =3D=3D 0)
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
> +=C2=A0=C2=A0=C2=A0 /* Weed out disabled counters */
> +=C2=A0=C2=A0=C2=A0 val &=3D __vcpu_sys_reg(vcpu, PMCNTENSET_EL0);
>=20
> -=C2=A0=C2=A0=C2=A0 enable =3D __vcpu_sys_reg(vcpu, PMCNTENSET_EL0);
> =C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < ARMV8_PMU_CYCLE_IDX; i++) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 type, reg;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ovs =3D i;
> +
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!(val & BIT(i)))
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
continue;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 type =3D __vcpu_sys_reg(vcpu,=
 PMEVTYPER0_EL0 + i)
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 & ARMV8_PMU_EVTYPE_EVENT;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if ((type =3D=3D ARMV8_PMUV3_=
PERFCTR_SW_INCR)
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 && (e=
nable & BIT(i))) {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reg =
=3D __vcpu_sys_reg(vcpu, PMEVCNTR0_EL0 + i) + 1;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reg =
=3D lower_32_bits(reg);
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __vcp=
u_sys_reg(vcpu, PMEVCNTR0_EL0 + i) =3D reg;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!=
reg)
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 __vcpu_sys_reg(vcpu, PMOVSSET_EL0) |=3D BIT(i);
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* PMSWINC only applies to ..=
. SW_INC! */
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 type =3D __vcpu_sys_reg(vcpu,=
 PMEVTYPER0_EL0 + i);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 type &=3D ARMV8_PMU_EVTYPE_EV=
ENT;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (type !=3D ARMV8_PMUV3_PER=
FCTR_SW_INCR)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 conti=
nue;
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Potential 64bit value */
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reg =3D kvm_pmu_get_counter_v=
alue(vcpu, i) + 1;
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Start by writing back the =
low 32bits */
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __vcpu_sys_reg(vcpu, PMEVCNTR=
0_EL0 + i) =3D lower_32_bits(reg);
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * 64bit counter? Write =
back the upper bits and target
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * the overflow bit at t=
he next counter
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (kvm_pmu_pmc_is_chained(&p=
mu->pmc[i])) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reg =
=3D upper_32_bits(reg);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __vcp=
u_sys_reg(vcpu, PMEVCNTR0_EL0 + i + 1) =3D reg;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ovs++=
;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!lower_32_bits(reg))
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __vcp=
u_sys_reg(vcpu, PMOVSSET_EL0) |=3D BIT(ovs);
> =C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0}
>=20
>=20

