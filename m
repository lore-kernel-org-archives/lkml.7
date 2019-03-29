Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C1C8C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 09:14:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0BAD21773
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 09:14:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729325AbfC2JOu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 05:14:50 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53683 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728770AbfC2JOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 05:14:49 -0400
Received: by mail-wm1-f65.google.com with SMTP id q16so1699116wmj.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 02:14:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=yvu9fFTJDGcuW/GONY57yUYENXoi1bptfqjcZYD2Egg=;
        b=HfOkyz+GIws89yeQJKhzb1v/PE2lA80Zi3imQxUuncGQZK2O3JKmlxqDgZgczPDoPr
         86gzZsBivCI7ZlVB/N+77XCYR/yX1yNsjwIG7cGGboTo3GozDtD+BYmQ9uKsxFMUMx53
         OXBXh+sSKufTamcD0Tp8hpqoOg/XqsgfKQbYsXtvK6T4Ihl9fmD8G8Bzvy1QAG7ug4gl
         pCpvDBrz1wZHslVS+R0xSPbC2Dp66wk4cN54rovTy1Hw4/8gZHFsA+LeNiyUfbtdbdSu
         uvxKFWM9Uli0UNyYp65+JRtTEr51VmLcoUC7ZPALExb0fibTxj8EA5DjQaou9Q/4rpkh
         ulcQ==
X-Gm-Message-State: APjAAAX8fHUE0usIVeuQmFXHid07honz0TbB5EREr6CwSizjnNUj0KXY
        thT9vsU8DKCYKVkpAMN2aOFhYkpN1ps=
X-Google-Smtp-Source: APXvYqxQ9jH6LSe8Be1JGGSYligKK/0egjz7VceRI6hUZKsAZsjEjN7msr/3yP4LiI4qFxuOr+4gIg==
X-Received: by 2002:a1c:1d49:: with SMTP id d70mr2874223wmd.36.1553850887266;
        Fri, 29 Mar 2019 02:14:47 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id r9sm1429778wrv.82.2019.03.29.02.14.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Mar 2019 02:14:46 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Liran Alon <liran.alon@oracle.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] KVM: x86: vmx: throttle immediate exit through preemtion timer to assist buggy guests
In-Reply-To: <025FEE7C-C807-4451-8E57-1EE368A96069@oracle.com>
References: <20190328203110.20655-1-vkuznets@redhat.com> <025FEE7C-C807-4451-8E57-1EE368A96069@oracle.com>
Date:   Fri, 29 Mar 2019 10:14:45 +0100
Message-ID: <87k1gim48q.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Liran Alon <liran.alon@oracle.com> writes:

>> On 28 Mar 2019, at 22:31, Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>> 
>> This is embarassing but we have another Windows/Hyper-V issue to workaround
>> in KVM (or QEMU). Hope "RFC" makes it less offensive.
>> 
>> It was noticed that Hyper-V guest on q35 KVM/QEMU VM hangs on boot if e.g.
>> 'piix4-usb-uhci' device is attached. The problem with this device is that
>> it uses level-triggered interrupts.
>> 
>> The 'hang' scenario develops like this:
>> 1) Hyper-V boots and QEMU is trying to inject two irq simultaneously. One
>> of them is level-triggered. KVM injects the edge-triggered one and
>> requests immediate exit to inject the level-triggered:
>> 
>> kvm_set_irq:          gsi 23 level 1 source 0
>> kvm_msi_set_irq:      dst 0 vec 80 (Fixed|physical|level)
>> kvm_apic_accept_irq:  apicid 0 vec 80 (Fixed|edge)
>> kvm_msi_set_irq:      dst 0 vec 96 (Fixed|physical|edge)
>> kvm_apic_accept_irq:  apicid 0 vec 96 (Fixed|edge)
>> kvm_nested_vmexit_inject: reason EXTERNAL_INTERRUPT info1 0 info2 0 int_info 80000060 int_info_err 0
>
> There is no immediate-exit here.
> Here QEMU just set two pending irqs: vector 80 and vector 96.
> Because vCPU 0 is running at non-root-mode, KVM emulates an exit from L2 to L1 on EXTERNAL_INTERRUPT.
> Note that EXTERNAL_INTERRUPT is emulated on vector 0x60==96 which is the higher vector which is pending which is correct.
>
> BTW, I don’t know why both are set in LAPIC as edge-triggered and not level-triggered.
> But it can be seen from trace pattern that these interrupts are both level-triggered. (See QEMU’s ioapic_service()).
> How did you deduce that one is edge-triggered and the other is
> level-triggered?

"kvm_apic_accept_irq" event misreports level-triggered interrupts as
edge-triggered, see my "KVM: x86: avoid misreporting level-triggered
irqs as edge-triggered in tracing" patch.

Other than that I double-checked, both in Qemu and KVM (and there's a
lot of additional debug prints stripped) and I'm certain there's no
disagreement anywhere: gsi 23/vec 80 is a level-triggered interrupt.

>
>> 
>> 2) Hyper-V requires one of its VMs to run to handle the situation but
>> immediate exit happens:
>> 
>> kvm_entry:            vcpu 0
>> kvm_exit:             reason VMRESUME rip 0xfffff80006a40115 info 0 0
>> kvm_entry:            vcpu 0
>> kvm_exit:             reason PREEMPTION_TIMER rip 0xfffff8022f3d8350 info 0 0
>> kvm_nested_vmexit:    rip fffff8022f3d8350 reason PREEMPTION_TIMER info1 0 info2 0 int_info 0 int_info_err 0
>> kvm_nested_vmexit_inject: reason EXTERNAL_INTERRUPT info1 0 info2 0 int_info 80000050 int_info_err 0
>
> I assume that as part of Hyper-V VMExit handler for EXTERNAL_INTERRUPT, it will forward the interrupt to the host.
> As done in KVM vcpu_enter_guest() calling kvm_x86_ops->handle_external_intr().
> Because vmcs->vm_exit_intr_info specifies vector 96, we are still left with vector 80 pending.
>
> I also assume that Hyper-V utilise VM_EXIT_ACK_INTR_ON_EXIT and thus vector 96 is cleared from LAPIC IRR
> and the bit in LAPIC ISR for vector 96 is set.
> This is emulated by L0 KVM at nested_vmx_vmexit() -> kvm_cpu_get_interrupt().
>
> I further assume that at the point that vector 96 runs in L1, interrupts are disabled.
> Afterwards I would expect L1 to enable interrupts (Similar to vcpu_enter_guest() calling local_irq_enable() after kvm_x86_ops->handle_external_intr()).
>
> I would expect Hyper-V handler for vector 96 at some point to do EOI such that when interrupts are later enabled, vector 80 will also get injected.
> All of this before attempting to resume back into L2.
>
> However, it can be seen that indeed at this resume, you receive, after an immediate-exit, an injection of EXTERNAL_INTERRUPT on vector 0x50==80.
> As if Hyper-V never enabled interrupts after handling vector 96 before doing a resume again to L2.
>
> This is still valid of course but just a bit bizarre and
> inefficient. Oh well. :)

Reverse-engineering is always fun :-)

>
>> 
>> 3) Hyper-V doesn't want to deal with the second irq (as its VM still didn't
>> process the first one)
>
> Both interrupts are for L1 not L2.
>
>> so it just does 'EOI' for level-triggered interrupt
>> and this causes re-injection:
>> 
>> kvm_exit:             reason EOI_INDUCED rip 0xfffff80006a17e1a info 50 0
>> kvm_eoi:              apicid 0 vector 80
>> kvm_userspace_exit:   reason KVM_EXIT_IOAPIC_EOI (26)
>> kvm_set_irq:          gsi 23 level 1 source 0
>> kvm_msi_set_irq:      dst 0 vec 80 (Fixed|physical|level)
>> kvm_apic_accept_irq:  apicid 0 vec 80 (Fixed|edge)
>> kvm_entry:            vcpu 0
>
> What happens here is that Hyper-V as a response to second EXTERNAL_INTERRUPT on vector 80,
> it invokes vector 80 handler which performs EOI which is configured in ioapic_exit_bitmap to cause EOI_INDUCED exit to L0.
> The EOI_INDUCED handler will reach handle_apic_eoi_induced() -> kvm_apic_set_eoi_accelerated() -> kvm_ioapic_send_eoi() -> kvm_make_request(KVM_REQ_IOAPIC_EOI_EXIT),
> which will cause the exit on KVM_EXIT_IOAPIC_EOI to QEMU as required.
>
> As part of QEMU handling for this exit (ioapic_eoi_broadcast()), it will note that pin’s irr is still set (irq-line was not lowered by vector 80 interrupt handler before EOI),
> and thus vector 80 is re-injected by IOAPIC at ioapic_service().
>
> If this is indeed a level-triggered interrupt, then it seems buggy to me that vector 80 handler haven’t lowered the irq-line before EOI.
> I would suggest adding a trace to QEMU’s ioapic_set_irq() for when vector=80 and level=0 and ioapic_eoi_broadcast() to verify if this is what happens.
> Another option is that even though vector 80 handler lowered irq-line, it got re-set by device between when it lowered the irq-line and until it did an EOI. Which is legit.
>
> If the former is what happens and vector 80 handler haven’t lowered
> the irq-line before EOI, this is the real root-cause of your issue at
> hand here.

Yes, exactly - and sorry if I wasn't clear about that. Hyper-V does EOI
for a still pending level-triggered interrupt (as it can't actually fix
the reason - in needs Windows partition - L2 VM - to run and do the
job).

As a pure speculation I can guess: they don't want to keep a queue of
interrupts which need L2 handling and they count on the fact that doing
EOI with interrupts disabled in L1 -> VMRESUME will actually allow L2 VM
to run for some time and make some progress. 

>
>> 
>> 4) As we arm preemtion timer again we get stuck in the infinite loop:
>> 
>> kvm_exit:             reason VMRESUME rip 0xfffff80006a40115 info 0 0
>> kvm_entry:            vcpu 0
>> kvm_exit:             reason PREEMPTION_TIMER rip 0xfffff8022f3d8350 info 0 0
>> kvm_nested_vmexit:    rip fffff8022f3d8350 reason PREEMPTION_TIMER info1 0 info2 0 int_info 0 int_info_err 0
>> kvm_nested_vmexit_inject: reason EXTERNAL_INTERRUPT info1 0 info2 0 int_info 80000050 int_info_err 0
>> kvm_entry:            vcpu 0
>> kvm_exit:             reason EOI_INDUCED rip 0xfffff80006a17e1a info 50 0
>> kvm_eoi:              apicid 0 vector 80
>> kvm_userspace_exit:   reason KVM_EXIT_IOAPIC_EOI (26)
>> kvm_set_irq:          gsi 23 level 1 source 0
>> kvm_msi_set_irq:      dst 0 vec 80 (Fixed|physical|level)
>> kvm_apic_accept_irq:  apicid 0 vec 80 (Fixed|edge)
>> kvm_entry:            vcpu 0
>> kvm_exit:             reason VMRESUME rip 0xfffff80006a40115 info 0 0
>> ...
>> 
>> How does this work on hardware? I don't really know but it seems that we
>> were dealing with similar issues before, see commit 184564efae4d7 ("kvm:
>> ioapic: conditionally delay irq delivery duringeoi broadcast"). In case EOI
>> doesn't always cause an *immediate* interrupt re-injection some progress
>> can be made.
>
> This commit tries to handle with a bug exactly as I have described above.
> In case a level-triggered interrupt handler in guest performs EOI before it lowers the irq-line, it will be re-injected in a loop forever with the level-triggered interrupt.
> The reason this doesn’t happen on real hardware is because there is a very short delay between when an EOI is performed to IOAPIC and until IOAPIC attempts to serve a new interrupt.
>
> To handle this, this commit delays the evaluation of IOAPIC new pending interrupts when it receives an EOI for a level-triggered interrupt.
>
>> 
>> An alternative approach would be to port the above mentioned commit to
>> QEMU's ioapic implementation. I'm, however, not sure that level-triggered
>> interrupts is a must to trigger the issue.
>
> This seems like the right solution to me.
> It seems to me that I have actually pinpointed it in this analysis
> directly to level-triggered interrupts and it is a must to trigger the
> issue.

Yes, in this particular case it is directly linked to (mis-)handling of
a level-triggered interrupt.

>
> This also explains why the issue doesn’t reproduce when you are using in-kernel irqchip.
> It also explains why "piix4-usb-uhci” must be present to re-produce
> this issue as probably the bug is in that device interrupt handler.

Level-triggered interrupts are rather rare but still present, I think
that any device using them can cause similar hang.

> (We should probably report this bug to Microsoft. Do we have any
> contacts for this?)

Yes, I just wanted to get KVM people's opinion first.

>
> Do you agree with above analysis?

Thank you for it! I think we're in violent agreement here :-)

> -Liran
>
>> 
>> HV_TIMER_THROTTLE/HV_TIMER_DELAY are more or less arbitrary. I haven't
>> looked at SVM yet but their immediate exit implementation does
>> smp_send_reschedule(), I'm not sure this can cause the above described
>> lockup.
>> 
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>
> As mentioned above, I think this patch should be dropped.
>

Yes, of course, I never expected it to be merged. I am, however, afraid
that we'll have to get back to this discussion if another scenario with
'immediate eoi storm' appears. I can't think of anything in particular
right away so I'm going to implement the throttling for level-triggred
interrupt re-assertion in Qemu first.

>> ---
>> arch/x86/kvm/vmx/vmcs.h |  2 ++
>> arch/x86/kvm/vmx/vmx.c  | 24 +++++++++++++++++++++++-
>> 2 files changed, 25 insertions(+), 1 deletion(-)
>> 
>> diff --git a/arch/x86/kvm/vmx/vmcs.h b/arch/x86/kvm/vmx/vmcs.h
>> index cb6079f8a227..983dfc60c30c 100644
>> --- a/arch/x86/kvm/vmx/vmcs.h
>> +++ b/arch/x86/kvm/vmx/vmcs.h
>> @@ -54,6 +54,8 @@ struct loaded_vmcs {
>> 	bool launched;
>> 	bool nmi_known_unmasked;
>> 	bool hv_timer_armed;
>> +	unsigned long hv_timer_lastrip;
>> +	int hv_timer_lastrip_cnt;
>> 	/* Support for vnmi-less CPUs */
>> 	int soft_vnmi_blocked;
>> 	ktime_t entry_time;
>> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
>> index 617443c1c6d7..8a49ec14dd3a 100644
>> --- a/arch/x86/kvm/vmx/vmx.c
>> +++ b/arch/x86/kvm/vmx/vmx.c
>> @@ -6321,14 +6321,36 @@ static void vmx_arm_hv_timer(struct vcpu_vmx *vmx, u32 val)
>> 	vmx->loaded_vmcs->hv_timer_armed = true;
>> }
>> 
>> +#define HV_TIMER_THROTTLE 100
>> +#define HV_TIMER_DELAY 1000
>> +
>> static void vmx_update_hv_timer(struct kvm_vcpu *vcpu)
>> {
>> 	struct vcpu_vmx *vmx = to_vmx(vcpu);
>> 	u64 tscl;
>> 	u32 delta_tsc;
>> 
>> +	/*
>> +	 * Some guests are buggy and may behave in a way that causes KVM to
>> +	 * always request immediate exit (e.g. of a nested guest). At the same
>> +	 * time guest progress may be required to resolve the condition.
>> +	 * Throttling below makes sure we never get stuck completely.
>> +	 */
>> 	if (vmx->req_immediate_exit) {
>> -		vmx_arm_hv_timer(vmx, 0);
>> +		unsigned long rip = kvm_rip_read(vcpu);
>> +
>> +		if (vmx->loaded_vmcs->hv_timer_lastrip == rip) {
>> +			++vmx->loaded_vmcs->hv_timer_lastrip_cnt;
>> +		} else {
>> +			vmx->loaded_vmcs->hv_timer_lastrip_cnt = 0;
>> +			vmx->loaded_vmcs->hv_timer_lastrip = rip;
>> +		}
>> +
>> +		if (vmx->loaded_vmcs->hv_timer_lastrip_cnt > HV_TIMER_THROTTLE)
>> +			vmx_arm_hv_timer(vmx, HV_TIMER_DELAY);
>> +		else
>> +			vmx_arm_hv_timer(vmx, 0);
>> +
>> 		return;
>> 	}
>> 
>> -- 
>> 2.20.1
>> 
>

-- 
Vitaly
