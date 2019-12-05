Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15D46C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 09:43:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC1512464D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 09:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575538993;
	bh=VduUfVfA8PM37btz6X32oexkSwdeJa5kpENuaCbHiV8=;
	h=To:Subject:Date:From:Cc:In-Reply-To:References:List-ID:From;
	b=EelkgKDZF4QB5D3ummk1YRTldQktdTkEuGwGMmDTry22hAnu8cB8pH4DTh/3+lI3P
	 xGgs1+pjS4f062Hizdjjt30XCLWKafuUWOqZsOR3Y1gjdxpvxrSDv56Hyxmi7q+h3D
	 Mz9a4I5BthGip3RWFHzzPDGY1NcwwZa0aplBNJLA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729212AbfLEJnN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 04:43:13 -0500
Received: from inca-roads.misterjones.org ([213.251.177.50]:56981 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726239AbfLEJnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 04:43:12 -0500
Received: from www-data by cheepnis.misterjones.org with local (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1icnfB-0003Vq-GN; Thu, 05 Dec 2019 10:43:09 +0100
To:     Eric Auger <eric.auger@redhat.com>
Subject: Re: [RFC 2/3] KVM: arm64: pmu: Fix chained =?UTF-8?Q?SW=5FINCR=20?=  =?UTF-8?Q?counters?=
X-PHP-Originating-Script: 0:main.inc
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 05 Dec 2019 09:43:09 +0000
From:   Marc Zyngier <maz@kernel.org>
Cc:     <eric.auger.pro@gmail.com>, <linux-kernel@vger.kernel.org>,
        <kvmarm@lists.cs.columbia.edu>, <james.morse@arm.com>,
        <andrew.murray@arm.com>, <suzuki.poulose@arm.com>,
        <drjones@redhat.com>
In-Reply-To: <20191204204426.9628-3-eric.auger@redhat.com>
References: <20191204204426.9628-1-eric.auger@redhat.com>
 <20191204204426.9628-3-eric.auger@redhat.com>
Message-ID: <561ac6df385e977cc51d51a8ab28ee49@www.loen.fr>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/0.7.2
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Rcpt-To: eric.auger@redhat.com, eric.auger.pro@gmail.com, linux-kernel@vger.kernel.org, kvmarm@lists.cs.columbia.edu, james.morse@arm.com, andrew.murray@arm.com, suzuki.poulose@arm.com, drjones@redhat.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

On 2019-12-04 20:44, Eric Auger wrote:
> At the moment a SW_INCR counter always overflows on 32-bit
> boundary, independently on whether the n+1th counter is
> programmed as CHAIN.
>
> Check whether the SW_INCR counter is a 64b counter and if so,
> implement the 64b logic.
>
> Fixes: 80f393a23be6 ("KVM: arm/arm64: Support chained PMU counters")
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>  virt/kvm/arm/pmu.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/virt/kvm/arm/pmu.c b/virt/kvm/arm/pmu.c
> index c3f8b059881e..7ab477db2f75 100644
> --- a/virt/kvm/arm/pmu.c
> +++ b/virt/kvm/arm/pmu.c
> @@ -491,6 +491,8 @@ void kvm_pmu_software_increment(struct kvm_vcpu
> *vcpu, u64 val)
>
>  	enable = __vcpu_sys_reg(vcpu, PMCNTENSET_EL0);
>  	for (i = 0; i < ARMV8_PMU_CYCLE_IDX; i++) {
> +		bool chained = test_bit(i >> 1, vcpu->arch.pmu.chained);
> +

I'd rather you use kvm_pmu_pmc_is_chained() rather than open-coding
this. But see below:

>  		if (!(val & BIT(i)))
>  			continue;
>  		type = __vcpu_sys_reg(vcpu, PMEVTYPER0_EL0 + i)
> @@ -500,8 +502,20 @@ void kvm_pmu_software_increment(struct kvm_vcpu
> *vcpu, u64 val)
>  			reg = __vcpu_sys_reg(vcpu, PMEVCNTR0_EL0 + i) + 1;
>  			reg = lower_32_bits(reg);
>  			__vcpu_sys_reg(vcpu, PMEVCNTR0_EL0 + i) = reg;
> -			if (!reg)
> +			if (reg) /* no overflow */
> +				continue;
> +			if (chained) {
> +				reg = __vcpu_sys_reg(vcpu, PMEVCNTR0_EL0 + i + 1) + 1;
> +				reg = lower_32_bits(reg);
> +				__vcpu_sys_reg(vcpu, PMEVCNTR0_EL0 + i + 1) = reg;
> +				if (reg)
> +					continue;
> +				/* mark an overflow on high counter */
> +				__vcpu_sys_reg(vcpu, PMOVSSET_EL0) |= BIT(i + 1);
> +			} else {
> +				/* mark an overflow */
>  				__vcpu_sys_reg(vcpu, PMOVSSET_EL0) |= BIT(i);
> +			}
>  		}
>  	}
>  }

I think the whole function is a bit of a mess, and could be better
structured to treat 64bit counters as a first class citizen.

I'm suggesting something along those lines, which tries to
streamline things a bit and keep the flow uniform between the
two word sizes. IMHO, it helps reasonning about it and gives
scope to the ARMv8.5 full 64bit counters... It is of course
completely untested.

Thoughts?

         M.

diff --git a/virt/kvm/arm/pmu.c b/virt/kvm/arm/pmu.c
index 8731dfeced8b..cf371f643ade 100644
--- a/virt/kvm/arm/pmu.c
+++ b/virt/kvm/arm/pmu.c
@@ -480,26 +480,43 @@ static void kvm_pmu_perf_overflow(struct 
perf_event *perf_event,
   */
  void kvm_pmu_software_increment(struct kvm_vcpu *vcpu, u64 val)
  {
+	struct kvm_pmu *pmu = &vcpu->arch.pmu;
  	int i;
-	u64 type, enable, reg;

-	if (val == 0)
-		return;
+	/* Weed out disabled counters */
+	val &= __vcpu_sys_reg(vcpu, PMCNTENSET_EL0);

-	enable = __vcpu_sys_reg(vcpu, PMCNTENSET_EL0);
  	for (i = 0; i < ARMV8_PMU_CYCLE_IDX; i++) {
+		u64 type, reg;
+		int ovs = i;
+
  		if (!(val & BIT(i)))
  			continue;
-		type = __vcpu_sys_reg(vcpu, PMEVTYPER0_EL0 + i)
-		       & ARMV8_PMU_EVTYPE_EVENT;
-		if ((type == ARMV8_PMUV3_PERFCTR_SW_INCR)
-		    && (enable & BIT(i))) {
-			reg = __vcpu_sys_reg(vcpu, PMEVCNTR0_EL0 + i) + 1;
-			reg = lower_32_bits(reg);
-			__vcpu_sys_reg(vcpu, PMEVCNTR0_EL0 + i) = reg;
-			if (!reg)
-				__vcpu_sys_reg(vcpu, PMOVSSET_EL0) |= BIT(i);
+
+		/* PMSWINC only applies to ... SW_INC! */
+		type = __vcpu_sys_reg(vcpu, PMEVTYPER0_EL0 + i);
+		type &= ARMV8_PMU_EVTYPE_EVENT;
+		if (type != ARMV8_PMUV3_PERFCTR_SW_INCR)
+			continue;
+
+		/* Potential 64bit value */
+		reg = kvm_pmu_get_counter_value(vcpu, i) + 1;
+
+		/* Start by writing back the low 32bits */
+		__vcpu_sys_reg(vcpu, PMEVCNTR0_EL0 + i) = lower_32_bits(reg);
+
+		/*
+		 * 64bit counter? Write back the upper bits and target
+		 * the overflow bit at the next counter
+		 */
+		if (kvm_pmu_pmc_is_chained(&pmu->pmc[i])) {
+			reg = upper_32_bits(reg);
+			__vcpu_sys_reg(vcpu, PMEVCNTR0_EL0 + i + 1) = reg;
+			ovs++;
  		}
+
+		if (!lower_32_bits(reg))
+			__vcpu_sys_reg(vcpu, PMOVSSET_EL0) |= BIT(ovs);
  	}
  }


-- 
Jazz is not dead. It just smells funny...
