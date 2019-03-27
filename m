Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7D5EC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 10:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A497B21741
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 10:08:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733085AbfC0KIj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 06:08:39 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33734 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731668AbfC0KIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 06:08:38 -0400
Received: by mail-wm1-f68.google.com with SMTP id z6so4430162wmi.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 03:08:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=dm1nAqrQ2eDc7/NHQLvkR1hQh9mhXxFusCiz+41GEEY=;
        b=U8J15u4bgU7kLxrtohkP9b1718AhhXgdupdDVxoKVHSckc4JSw+awJOlhTcwhmp4KO
         Ha8EBDa6Onvg6ESQHPKvqTimyXY7s/ufApktsmrronn7XO0B+MZWqsl2lY89JNNra9aH
         QP8RM3Jv2ijIk2B5WUmANeZ414xwFh8kEB4wpWzM1RdnODmaAVTAlgxzWpUdtDLDKVNZ
         U/u88pPctgKcvoJdArUBsXk0uVdCLs9tts1W/enxALSed68mu4VClQpdzxPtoJCrNwaQ
         XrccuAgI4xdapGY3gT8TQs0YffEJR2+8pvMvWgGJBJdq7tRja61KJgwHxnxSFX1j1Nww
         6UIA==
X-Gm-Message-State: APjAAAXz+wUQUJp0ISJ9JZai6AHuaX6qDjHRa8wIV48EMEvTWzgRUIQM
        HYJeAGJlqMVL/2Fy5c8nN41rDc49Z9k=
X-Google-Smtp-Source: APXvYqwpYDNtugIcDVDXMmHfdFt+/KrBqAtzo7YsUsblPzG5jqokMAOeRU8ME8aw8//wepPu125+Cw==
X-Received: by 2002:a7b:cc10:: with SMTP id f16mr17069316wmh.49.1553681315987;
        Wed, 27 Mar 2019 03:08:35 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id y3sm21826218wrh.18.2019.03.27.03.08.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Mar 2019 03:08:35 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Liran Alon <liran.alon@oracle.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Jon Doron <arilou@gmail.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: x86: nVMX: allow RSM to restore VMXE CR4 flag
In-Reply-To: <06E50BD4-B3AC-4DBB-B700-80C30F2DC8BB@oracle.com>
References: <20190326130746.28748-1-vkuznets@redhat.com> <DFD60850-CD9B-4FF3-9C46-EF4AF53C76CA@oracle.com> <87k1glagqj.fsf@vitty.brq.redhat.com> <06E50BD4-B3AC-4DBB-B700-80C30F2DC8BB@oracle.com>
Date:   Wed, 27 Mar 2019 11:08:34 +0100
Message-ID: <8736n8aau5.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Liran Alon <liran.alon@oracle.com> writes:

>> On 26 Mar 2019, at 15:48, Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>> 
>> Liran Alon <liran.alon@oracle.com> writes:
>> 
>>>> On 26 Mar 2019, at 15:07, Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>>>> - Instread of putting the temporary HF_SMM_MASK drop to
>>>> rsm_enter_protected_mode() (as was suggested by Liran), move it to
>>>> emulator_set_cr() modifying its interface. emulate.c seems to be
>>>> vcpu-specifics-free at this moment, we may want to keep it this way.
>>>> - It seems that Hyper-V+UEFI on KVM is still broken, I'm observing sporadic
>>>> hangs even with this patch. These hangs, however, seem to be unrelated to
>>>> rsm.
>>> 
>>> Feel free to share details on these hangs ;)
>>> 
>> 
>> You've asked for it)
>> 
>> The immediate issue I'm observing is some sort of a lockup which is easy
>> to trigger with e.g. "-usb -device usb-tablet" on Qemu command line; it
>> seems we get too many interrupts and combined with preemtion timer for
>> L2 we're not making any progress:
>> 
>> kvm_userspace_exit:   reason KVM_EXIT_IOAPIC_EOI (26)
>> kvm_set_irq:          gsi 18 level 1 source 0
>> kvm_msi_set_irq:      dst 0 vec 177 (Fixed|physical|level)
>> kvm_apic_accept_irq:  apicid 0 vec 177 (Fixed|edge)
>> kvm_fpu:              load
>> kvm_entry:            vcpu 0
>> kvm_exit:             reason VMRESUME rip 0xfffff80000848115 info 0 0
>> kvm_entry:            vcpu 0
>> kvm_exit:             reason PREEMPTION_TIMER rip 0xfffff800f4448e01 info 0 0
>> kvm_nested_vmexit:    rip fffff800f4448e01 reason PREEMPTION_TIMER info1 0 info2 0 int_info 0 int_info_err 0
>> kvm_nested_vmexit_inject: reason EXTERNAL_INTERRUPT info1 0 info2 0 int_info 800000b1 int_info_err 0
>> kvm_entry:            vcpu 0
>> kvm_exit:             reason APIC_ACCESS rip 0xfffff8000081fe11 info 10b0 0
>> kvm_apic:             apic_write APIC_EOI = 0x0
>> kvm_eoi:              apicid 0 vector 177
>> kvm_fpu:              unload
>> kvm_userspace_exit:   reason KVM_EXIT_IOAPIC_EOI (26)
>> ...
>> (and the pattern repeats)
>> 
>> Maybe it is a usb-only/Qemu-only problem, maybe not.
>> 
>> -- 
>> Vitaly
>
> The trace of kvm_apic_accept_irq should indicate that __apic_accept_irq() was called to inject an interrupt to L1 guest.
> (I know that now we are running in L1 because next exit is a VMRESUME).
>
> However, it is surprising to see that on next entry to guest, no interrupt was injected by vmx_inject_irq().
> It may be because L1 guest is currently running with interrupt disabled and therefore only an IRQ-window was requested.
> (Too bad we don’t have a trace for this…)
>
> Next, we got an exit from L1 guest on VMRESUME. As part of it’s handling, active VMCS was changed from vmcs01 to vmcs02.
> I believe the immediate exit later on preemption-timer was because the immediate-exit-request mechanism was invoked
> which is now implemented by setting a VMX preemption-timer with value of 0 (Thanks to Sean).
> (See vmx_vcpu_run() -> vmx_update_hv_timer() -> vmx_arm_hv_timer(vmx, 0)).
> (Note that the pending interrupt was evaluated because of a recent patch of mine to nested_vmx_enter_non_root_mode()
> to request KVM_REQ_EVENT when vmcs01 have requested an IRQ-window)
>
> Therefore when entering L2, you immediately get an exit on PREEMPTION_TIMER which will cause eventually L0 to call
> vmx_check_nested_events() which notices now the pending interrupt that should have been injected before to L1
> and now exit from L2 to L1 on EXTERNAL_INTERRUPT on vector 0xb1.
>
> Then L1 handles the interrupt by performing an EOI to LAPIC which propagate an EOI to IOAPIC which immediately re-inject
> the interrupt (after clearing the remote_irr) as the irq-line is still set. i.e. QEMU’s ioapic_eoi_broadcast() calls ioapic_service() immediate after it clears remote-irr for this pin.
>
> Also note that in trace we see only a single kvm_set_irq to level 1 but we don’t see immediately another kvm_set_irq to level 0.
> This should indicate that in QEMU’s IOAPIC redirection-table, this pin is configured as level-triggered interrupt.
> However, the trace of kvm_apic_accept_irq indicates that this interrupt is raised as an edge-triggered interrupt.
>
> To sum up:
> 1) I would create a patch to add a trace to vcpu_enter_guest() when calling enable_smi_window() / enable_nmi_window() / enable_irq_window().
> 2) It is worth investigating why MSI trigger-mode is edge-triggered instead of level-triggered.
> 3) If this is indeed a level-triggered interrupt, it is worth investigating how the interrupt source behaves. i.e. What cause this device to lower the irq-line?
> (As we don’t see any I/O Port or MMIO access by L1 guest interrupt-handler before performing the EOI)
> 4) Does this issue reproduce also when running with kernel-irqchip? (Instead of split-irqchip)
>

Thank you Liran,

all are valuable suggestions. It seems the isssue doesn't reproduce with
'kernel-irqchip=on' but reproduces with "kernel-irqchip=split". My first
guess would then be that we're less picky with in-kernel implementation
about the observed edge/level discrepancy. I'll be investigating and
share my findings.

-- 
Vitaly
