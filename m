Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AEA4C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:39:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1228F2086C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:39:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732195AbfDAIjo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 04:39:44 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33216 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731953AbfDAIjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 04:39:43 -0400
Received: by mail-wm1-f65.google.com with SMTP id z6so14937549wmi.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 01:39:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=ajJgSj05Q75RJs4Hi7V5gRMHUWOx6wWW82KZDOFsVTg=;
        b=cIKM5GiIELNl6wQpMNBWLqo5bqGw1qS8EBzSS/82FCkjzBVxEiWca0xcamGmBcsxiv
         ILyc7wGUC5XRA2V/WAQC6lz2nskN+hnncyBdTb2RcAR8R83ZBiWyB3DOGK1WIRDqEAjA
         CUAcnMqTeYNzyOj3yjwW8RBPvksqzMRZn1u2j4UdKK+aVuL1xToYqSiGaGr/np2USJ71
         srfZyg+VU3PbLhtpHK4I5IeW24/n80dtyOBvI2/lKEjNdlP/+vPLA9An/W2wUvmB5twb
         jZElJM4kPnoQlhv2FgnR2cIc/LMsLG9bY08/X8QYhquIx474OHgmiZdemqw63LswXKpF
         2FLg==
X-Gm-Message-State: APjAAAVkBabE9znkEyhzIzA+tZ9349FM8WbH15fI+hhWDJ0D65sjSKoS
        SUpYZxKGoVolpOf5TZeq1tTEiONaDSY=
X-Google-Smtp-Source: APXvYqzohFaEJphuWynYv12yVtcuvMKS30w85qOtk5VbHwP8pzbMOqRSyQTM0WrrBTztOxGmK7i/eQ==
X-Received: by 2002:a1c:720a:: with SMTP id n10mr11286733wmc.107.1554107981073;
        Mon, 01 Apr 2019 01:39:41 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id i18sm9847458wrm.7.2019.04.01.01.39.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Apr 2019 01:39:40 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Liran Alon <liran.alon@oracle.com>
Cc:     kvm@vger.kernel.org,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] KVM: x86: vmx: throttle immediate exit through preemtion timer to assist buggy guests
In-Reply-To: <32296de3-8ce0-c20a-5948-a7eef267a328@redhat.com>
References: <20190328203110.20655-1-vkuznets@redhat.com> <f64742ef-c67d-db0f-d812-2b6f5048d7ee@redhat.com> <87d0m93frp.fsf@vitty.brq.redhat.com> <89d4189b-de6a-7634-de8b-29a044a86e12@redhat.com> <63F1B6AE-F7A0-40D9-9582-558723800682@oracle.com> <32296de3-8ce0-c20a-5948-a7eef267a328@redhat.com>
Date:   Mon, 01 Apr 2019 10:39:39 +0200
Message-ID: <87v9zy15mc.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 29/03/19 16:32, Liran Alon wrote:
>> Paolo I am not sure this is the case here. Please read my other
>> replies in this email thread.
>> 
>> I think this is just a standard issue of a level-triggered interrupt
>> handler in L1 (Hyper-V) that performs EOI before it lowers the
>> irq-line. I don’t think vector 96 is even related to the issue at
>> hand here. This is why after it was already handled, the loop of
>> EXTERNAL_INTERRUPT happens on vector 80 and not vector 96.
>
> Hmm... Vitaly, what machine were you testing on---does it have APIC-v?
> If not, then you should have seen either an EOI for irq 96 or a TPR
> below threshold vmexit.  However, if it has APIC-v then you wouldn't
> have seen any of this (you only see the EOI for irq 80 because it's
> level triggered) and Liran is probably right.
>

It does, however, the issue is reproducible with and without
it. Moreover, I think the second simultaneous IRQ is just a red herring;
Here is another trace (enable_apicv). Posting it non-stripped and hope
your eyes will catch something I'm missing:

[001] 513675.736316: kvm_exit:             reason VMRESUME rip 0xfffff80002cae115 info 0 0
[001] 513675.736321: kvm_entry:            vcpu 0
[001] 513675.736565: kvm_exit:             reason EXTERNAL_INTERRUPT rip 0xfffff80362dcd26d info 0 800000ec
[001] 513675.736566: kvm_nested_vmexit:    rip fffff80362dcd26d reason EXTERNAL_INTERRUPT info1 0 info2 0 int_info 800000ec int_info_err 0
[001] 513675.736568: kvm_entry:            vcpu 0
[001] 513675.736650: kvm_exit:             reason EPT_VIOLATION rip 0xfffff80362dcd230 info 182 0
[001] 513675.736651: kvm_nested_vmexit:    rip fffff80362dcd230 reason EPT_VIOLATION info1 182 info2 0 int_info 0 int_info_err 0
[001] 513675.736651: kvm_page_fault:       address 261200000 error_code 182

-> injecting

[008] 513675.737059: kvm_set_irq:          gsi 23 level 1 source 0
[008] 513675.737061: kvm_msi_set_irq:      dst 0 vec 80 (Fixed|physical|level)
[008] 513675.737062: kvm_apic_accept_irq:  apicid 0 vec 80 (Fixed|edge)
[001] 513675.737233: kvm_nested_vmexit_inject: reason EXTERNAL_INTERRUPT info1 0 info2 0 int_info 80000050 int_info_err 0
[001] 513675.737239: kvm_entry:            vcpu 0
[001] 513675.737243: kvm_exit:             reason EOI_INDUCED rip 0xfffff80002c85e1a info 50 0

-> immediate EOI causing re-injection (even preemption timer is not
involved here).

[001] 513675.737244: kvm_eoi:              apicid 0 vector 80
[001] 513675.737245: kvm_fpu:              unload
[001] 513675.737246: kvm_userspace_exit:   reason KVM_EXIT_IOAPIC_EOI (26)
[001] 513675.737256: kvm_set_irq:          gsi 23 level 1 source 0
[001] 513675.737259: kvm_msi_set_irq:      dst 0 vec 80 (Fixed|physical|level)
[001] 513675.737260: kvm_apic_accept_irq:  apicid 0 vec 80 (Fixed|edge)
[001] 513675.737264: kvm_fpu:              load
[001] 513675.737265: kvm_entry:            vcpu 0
[001] 513675.737271: kvm_exit:             reason VMRESUME rip 0xfffff80002cae115 info 0 0
[001] 513675.737278: kvm_entry:            vcpu 0
[001] 513675.737282: kvm_exit:             reason PREEMPTION_TIMER rip 0xfffff80362dcc2d0 info 0 0
[001] 513675.737283: kvm_nested_vmexit:    rip fffff80362dcc2d0 reason PREEMPTION_TIMER info1 0 info2 0 int_info 0 int_info_err 0
[001] 513675.737285: kvm_nested_vmexit_inject: reason EXTERNAL_INTERRUPT info1 0 info2 0 int_info 80000050 int_info_err 0
[001] 513675.737289: kvm_entry:            vcpu 0
[001] 513675.737293: kvm_exit:             reason EOI_INDUCED rip 0xfffff80002c85e1a info 50 0
[001] 513675.737293: kvm_eoi:              apicid 0 vector 80
[001] 513675.737294: kvm_fpu:              unload
[001] 513675.737295: kvm_userspace_exit:   reason KVM_EXIT_IOAPIC_EOI (26)
[001] 513675.737299: kvm_set_irq:          gsi 23 level 1 source 0
[001] 513675.737299: kvm_msi_set_irq:      dst 0 vec 80 (Fixed|physical|level)
[001] 513675.737300: kvm_apic_accept_irq:  apicid 0 vec 80 (Fixed|edge)
[001] 513675.737302: kvm_fpu:              load
[001] 513675.737303: kvm_entry:            vcpu 0
[001] 513675.737307: kvm_exit:             reason VMRESUME rip 0xfffff80002cae115 info 0 0

...

-- 
Vitaly
