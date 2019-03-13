Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B5F5C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 11:59:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD5EA20693
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 11:59:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbfCML71 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 07:59:27 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:56730 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725836AbfCML71 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 07:59:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E54C580D;
        Wed, 13 Mar 2019 04:59:25 -0700 (PDT)
Received: from [10.1.196.92] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 867FC3F71D;
        Wed, 13 Mar 2019 04:59:23 -0700 (PDT)
Subject: Re: [PATCH] KVM: arm/arm64: Set ICH_HCR_EN in guest anyway when using
 gicv4
From:   Marc Zyngier <marc.zyngier@arm.com>
To:     "Tangnianyao (ICT)" <tangnianyao@huawei.com>,
        Christoffer Dall <christoffer.dall@arm.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "julien.thierry@arm.com" <julien.thierry@arm.com>,
        "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "alex.bennee@linaro.org" <alex.bennee@linaro.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "andre.przywara@arm.com" <andre.przywara@arm.com>,
        Zhangshaokun <zhangshaokun@hisilicon.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <F348A9E21A573744858FF7E5D32E29D81FEFA462@DGGEMI529-MBX.china.huawei.com>
 <3993685d-a78f-2e73-e22a-8ade3b6a6279@arm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=marc.zyngier@arm.com; prefer-encrypt=mutual; keydata=
 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
Organization: ARM Ltd
Message-ID: <d97bd073-8775-f0cf-637a-ea1b04afbd8f@arm.com>
Date:   Wed, 13 Mar 2019 11:59:21 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <3993685d-a78f-2e73-e22a-8ade3b6a6279@arm.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/03/2019 15:48, Marc Zyngier wrote:
> Nianyao,
> 
> Please do not send patches as HTML. Or any email as HTML. Please make
> sure that you only send plain text emails on any mailing list (see point
> #6 in Documentation/process/submitting-patches.rst).
> 
> On 12/03/2019 12:22, Tangnianyao (ICT) wrote:
>> In gicv4, direct vlpi may be forward to PE without using LR or ap_list. If
>>
>> ICH_HCR_EL2.En is 0 in guest, direct vlpi cannot be accepted by PE.
>>
>> It will take long time for direct vlpi to be forwarded in some cases.
>>
>> Direct vlpi has to wait for ICH_HCR_EL2.En=1 where some other interrupts
>>
>> using LR need to be forwarded, because in kvm_vgic_flush_hwstate,
>>
>> if ap_list is empty, it will return quickly not setting ICH_HCR_EL2.En.
>>
>> To fix this, set ICH_HCR_EL2.En to 1 before returning to guest when
>>
>> using GICv4.
>>
>>  
>>
>> Signed-off-by: Nianyao Tang <tangnianyao@huawei.com>
>>
>> ---
>>
>> arch/arm64/include/asm/kvm_asm.h |  1 +
>>
>> virt/kvm/arm/hyp/vgic-v3-sr.c    | 10 ++++++++++
>>
>> virt/kvm/arm/vgic/vgic-v4.c      |  8 ++++++++
>>
>> 3 files changed, 19 insertions(+)
>>
>>  
>>
>> diff --git a/arch/arm64/include/asm/kvm_asm.h
>> b/arch/arm64/include/asm/kvm_asm.h
>>
>> index f5b79e9..0581c4d 100644
>>
>> --- a/arch/arm64/include/asm/kvm_asm.h
>>
>> +++ b/arch/arm64/include/asm/kvm_asm.h
>>
>> @@ -79,6 +79,7 @@
>>
>> extern void __vgic_v3_init_lrs(void);
>>
>>  extern u32 __kvm_get_mdcr_el2(void);
>>
>> +extern void __vgic_v3_write_hcr(u32 vmcr);
>>
>>  /* Home-grown __this_cpu_{ptr,read} variants that always work at HYP */
>>
>> #define
>> __hyp_this_cpu_ptr(sym)                                                       
>> \
>>
>> diff --git a/virt/kvm/arm/hyp/vgic-v3-sr.c b/virt/kvm/arm/hyp/vgic-v3-sr.c
>>
>> index 264d92d..12027af 100644
>>
>> --- a/virt/kvm/arm/hyp/vgic-v3-sr.c
>>
>> +++ b/virt/kvm/arm/hyp/vgic-v3-sr.c
>>
>> @@ -434,6 +434,16 @@ void __hyp_text __vgic_v3_write_vmcr(u32 vmcr)
>>
>>        write_gicreg(vmcr, ICH_VMCR_EL2);
>>
>> }
>>
>> +u64 __hyp_text __vgic_v3_read_hcr(void)
>>
>> +{
>>
>> +       return read_gicreg(ICH_HCR_EL2);
>>
>> +}
>>
>> +
>>
>> +void __hyp_text __vgic_v3_write_hcr(u32 vmcr)
>>
>> +{
>>
>> +       write_gicreg(vmcr, ICH_HCR_EL2);
>>
>> +}
> 
> This is HYP code...
> 
>>
>> +
>>
>> #ifdef CONFIG_ARM64
>>
>>  static int __hyp_text __vgic_v3_bpr_min(void)
>>
>> diff --git a/virt/kvm/arm/vgic/vgic-v4.c b/virt/kvm/arm/vgic/vgic-v4.c
>>
>> index 1ed5f22..515171a 100644
>>
>> --- a/virt/kvm/arm/vgic/vgic-v4.c
>>
>> +++ b/virt/kvm/arm/vgic/vgic-v4.c
>>
>> @@ -208,6 +208,8 @@ int vgic_v4_sync_hwstate(struct kvm_vcpu *vcpu)
>>
>>        if (!vgic_supports_direct_msis(vcpu->kvm))
>>
>>                 return 0;
>>
>> +       __vgic_v3_write_hcr(vcpu->arch.vgic_cpu.vgic_v3.vgic_hcr &
>> ~ICH_HCR_EN);
> 
> And you've now crashed your non-VHE system by branching directly to code
> that cannot be executed at EL1.
> 
>>
>> +
>>
>>        return its_schedule_vpe(&vcpu->arch.vgic_cpu.vgic_v3.its_vpe, false);
>>
>> }
>>
>> @@ -220,6 +222,12 @@ int vgic_v4_flush_hwstate(struct kvm_vcpu *vcpu)
>>
>>                 return 0;
>>
>>         /*
>>
>> +       * Enable ICH_HCR_EL.En so that guest can accpet and handle direct
>>
>> +       * vlpi.
>>
>> +       */
>>
>> +       __vgic_v3_write_hcr(vcpu->arch.vgic_cpu.vgic_v3.vgic_hcr);
>>
>> +
>>
>> +       /*
>>
>>         * Before making the VPE resident, make sure the redistributor
>>
>>         * corresponding to our current CPU expects us here. See the
>>
>>         * doc in drivers/irqchip/irq-gic-v4.c to understand how this
>>
>> -- 
>>
>> 1.9.1
>>
>>  
>>
>>  
>>
> 
> Overall, this looks like the wrong approach. It is not the GICv4 code's
> job to do this, but the low-level code (either the load/put code for VHE
> or the save/restore code for non-VHE).
> 
> It would certainly help if you could describe which context you're in
> (VHE, non-VHE). I suppose the former...

Can you please give the following patch a go? I can't test it, but hopefully
you can.

Thanks,

	M.

diff --git a/virt/kvm/arm/hyp/vgic-v3-sr.c b/virt/kvm/arm/hyp/vgic-v3-sr.c
index 9652c453480f..3c3f7cda95c7 100644
--- a/virt/kvm/arm/hyp/vgic-v3-sr.c
+++ b/virt/kvm/arm/hyp/vgic-v3-sr.c
@@ -222,7 +222,7 @@ void __hyp_text __vgic_v3_save_state(struct kvm_vcpu *vcpu)
 		}
 	}
 
-	if (used_lrs) {
+	if (used_lrs || cpu_if->its_vpe.its_vm) {
 		int i;
 		u32 elrsr;
 
@@ -247,7 +247,7 @@ void __hyp_text __vgic_v3_restore_state(struct kvm_vcpu *vcpu)
 	u64 used_lrs = vcpu->arch.vgic_cpu.used_lrs;
 	int i;
 
-	if (used_lrs) {
+	if (used_lrs || cpu_if->its_vpe.its_vm) {
 		write_gicreg(cpu_if->vgic_hcr, ICH_HCR_EL2);
 
 		for (i = 0; i < used_lrs; i++)
diff --git a/virt/kvm/arm/vgic/vgic.c b/virt/kvm/arm/vgic/vgic.c
index abd9c7352677..3af69f2a3866 100644
--- a/virt/kvm/arm/vgic/vgic.c
+++ b/virt/kvm/arm/vgic/vgic.c
@@ -867,15 +867,21 @@ void kvm_vgic_flush_hwstate(struct kvm_vcpu *vcpu)
 	 * either observe the new interrupt before or after doing this check,
 	 * and introducing additional synchronization mechanism doesn't change
 	 * this.
+	 *
+	 * Note that we still need to go through the whole thing if anything
+	 * can be directly injected (GICv4).
 	 */
-	if (list_empty(&vcpu->arch.vgic_cpu.ap_list_head))
+	if (list_empty(&vcpu->arch.vgic_cpu.ap_list_head) &&
+	    !vgic_supports_direct_msis(vcpu->kvm))
 		return;
 
 	DEBUG_SPINLOCK_BUG_ON(!irqs_disabled());
 
-	raw_spin_lock(&vcpu->arch.vgic_cpu.ap_list_lock);
-	vgic_flush_lr_state(vcpu);
-	raw_spin_unlock(&vcpu->arch.vgic_cpu.ap_list_lock);
+	if (!list_empty(&vcpu->arch.vgic_cpu.ap_list_head)) {
+		raw_spin_lock(&vcpu->arch.vgic_cpu.ap_list_lock);
+		vgic_flush_lr_state(vcpu);
+		raw_spin_unlock(&vcpu->arch.vgic_cpu.ap_list_lock);
+	}
 
 	if (can_access_vgic_from_kernel())
 		vgic_restore_state(vcpu);


-- 
Jazz is not dead. It just smells funny...
