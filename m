Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 965FEC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 13:48:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C1CB2075C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 13:48:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731617AbfCZNs5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 09:48:57 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55647 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbfCZNs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 09:48:56 -0400
Received: by mail-wm1-f65.google.com with SMTP id o25so12702686wmf.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 06:48:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=QiJbQvSHBCbGCD5t5jd7+Hcmn1iGjUUzGhMiihRmbhU=;
        b=KtiC/qCu/AKUPj4Bz5Zcr9vhB81jf/Szy1Eg6hEl2lzVlto/ZZeHaaUf6LGQ+b3VUK
         Nj8a3eU7R0BSxN+F+l4XMoy7ZYTSQMcf7meSGqD7YP3iRvlmHkTS2wmw+3j/6xnDZkVe
         D9F/8Gkla46mSaq2rzgrb8YE6tZDgiP1fuokhuZpFQ4vxe+qDQBg6gaYL7/Wo6N32isu
         bFiJN1QrZn8AHs8g+IFWBzZkdnu4dlDgWw0cFPZkAjR4d7sW/ZKhEDa+rc8zqeVfsUrY
         5sctw4C672cW7KEeLI25QNQhU/Cl1/Ez3vhhdYUPOO+p5Q55iXHRNP5vThxDt3F1Dczq
         J7Mw==
X-Gm-Message-State: APjAAAVqwE9y9JoHFH0vQNpfSMJ3ZwmJcqlDEInHcT7y6rfPNoT0YpCl
        qqEudBYOPTEFAgWEtjyMGqxUvXZ/c+c=
X-Google-Smtp-Source: APXvYqwmpGqC2v1B21C/RZaQvnUmpFpmGo+M452Oq+FIvhSZCnAEHzTOFeSZlyJ14Uhq3aG624jxPQ==
X-Received: by 2002:a1c:5546:: with SMTP id j67mr8712052wmb.95.1553608133942;
        Tue, 26 Mar 2019 06:48:53 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id b134sm39188403wmd.26.2019.03.26.06.48.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Mar 2019 06:48:53 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Liran Alon <liran.alon@oracle.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Jon Doron <arilou@gmail.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: x86: nVMX: allow RSM to restore VMXE CR4 flag
In-Reply-To: <DFD60850-CD9B-4FF3-9C46-EF4AF53C76CA@oracle.com>
References: <20190326130746.28748-1-vkuznets@redhat.com> <DFD60850-CD9B-4FF3-9C46-EF4AF53C76CA@oracle.com>
Date:   Tue, 26 Mar 2019 14:48:52 +0100
Message-ID: <87k1glagqj.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Liran Alon <liran.alon@oracle.com> writes:

>> On 26 Mar 2019, at 15:07, Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>> 
>> Commit 5bea5123cbf0 ("KVM: VMX: check nested state and CR4.VMXE against
>> SMM") introduced a check to vmx_set_cr4() forbidding to set VMXE from SMM.
>> The check is correct, however, there is a special case when RSM is called
>> to leave SMM: rsm_enter_protected_mode() is called with HF_SMM_MASK still
>> set and in case VMXE was set before entering SMM we're failing to return.
>> 
>> Resolve the issue by temporary dropping HF_SMM_MASK around set_cr4() calls
>> when ops->set_cr() is called from RSM.
>> 
>> Reported-by: Jon Doron <arilou@gmail.com>
>> Suggested-by: Liran Alon <liran.alon@oracle.com>
>> Fixes: 5bea5123cbf0 ("KVM: VMX: check nested state and CR4.VMXE against SMM")
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>
> Patch looks good to me.
> Reviewed-by: Liran Alon <liran.alon@oracle.com>

Thanks!

>
>> ---
>> - Instread of putting the temporary HF_SMM_MASK drop to
>>  rsm_enter_protected_mode() (as was suggested by Liran), move it to
>>  emulator_set_cr() modifying its interface. emulate.c seems to be
>>  vcpu-specifics-free at this moment, we may want to keep it this way.
>> - It seems that Hyper-V+UEFI on KVM is still broken, I'm observing sporadic
>>  hangs even with this patch. These hangs, however, seem to be unrelated to
>>  rsm.
>
> Feel free to share details on these hangs ;)
>

You've asked for it)

The immediate issue I'm observing is some sort of a lockup which is easy
to trigger with e.g. "-usb -device usb-tablet" on Qemu command line; it
seems we get too many interrupts and combined with preemtion timer for
L2 we're not making any progress:

kvm_userspace_exit:   reason KVM_EXIT_IOAPIC_EOI (26)
kvm_set_irq:          gsi 18 level 1 source 0
kvm_msi_set_irq:      dst 0 vec 177 (Fixed|physical|level)
kvm_apic_accept_irq:  apicid 0 vec 177 (Fixed|edge)
kvm_fpu:              load
kvm_entry:            vcpu 0
kvm_exit:             reason VMRESUME rip 0xfffff80000848115 info 0 0
kvm_entry:            vcpu 0
kvm_exit:             reason PREEMPTION_TIMER rip 0xfffff800f4448e01 info 0 0
kvm_nested_vmexit:    rip fffff800f4448e01 reason PREEMPTION_TIMER info1 0 info2 0 int_info 0 int_info_err 0
kvm_nested_vmexit_inject: reason EXTERNAL_INTERRUPT info1 0 info2 0 int_info 800000b1 int_info_err 0
kvm_entry:            vcpu 0
kvm_exit:             reason APIC_ACCESS rip 0xfffff8000081fe11 info 10b0 0
kvm_apic:             apic_write APIC_EOI = 0x0
kvm_eoi:              apicid 0 vector 177
kvm_fpu:              unload
kvm_userspace_exit:   reason KVM_EXIT_IOAPIC_EOI (26)
...
(and the pattern repeats)

Maybe it is a usb-only/Qemu-only problem, maybe not.

-- 
Vitaly
