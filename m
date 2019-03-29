Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EA70C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 15:14:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 367CD2184C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 15:14:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729049AbfC2POi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 11:14:38 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43145 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728839AbfC2POh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 11:14:37 -0400
Received: by mail-wr1-f68.google.com with SMTP id k17so3014702wrx.10
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 08:14:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=ad3FU1K6R0fG6gBLiNPRbbseS3w6abTKqPSmwInCleY=;
        b=PYT8p5KZGhFwEzDf1P5V6uzzNd+4MKaDVXl02Mo7SzbWZptnQnfszhLMUIc/haMEov
         GJYI8xjLipN/prQZsJ5L3/HvkGR/fRAzVUyWXa7mooyRSAr4KnAqK75iK1en3E+ZoDPn
         jIb4l9Sz6b+ZKzzojF8LcYeHLL4HSZSK/Vn0VlkITugpxv8eMURdAAGD57hb1O0hfe6z
         LWOPzmPjBZrqDu31KS8jByHzr+I+KahOoZqSKvF9OoTemWBuloZ/lBUJIoiWszr2FGUp
         S3SNJ5Re6M+xD5sfC5l8eO442mHh3VeBiImSsxB6QT2foBEV0oROtHpa2Qyd8ax3FTFe
         vTHg==
X-Gm-Message-State: APjAAAV0qFOTFHyCGON8BtaPh8mtE8NtJMbSuqphvV8OoV5AqVWqxdoL
        6DmJ1IbdX+irGkTJsQGzgFtGJFhm5Go=
X-Google-Smtp-Source: APXvYqwp9cqqNQGeeiFe1sv4z5Ex+WVaYGyWQRD7HDk9kOYqxBgGdYV7P9uF8WFlG24+vqmq0/hTIg==
X-Received: by 2002:adf:f8c1:: with SMTP id f1mr33102513wrq.151.1553872475819;
        Fri, 29 Mar 2019 08:14:35 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id f9sm2924957wmb.36.2019.03.29.08.14.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Mar 2019 08:14:35 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Cc:     Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Liran Alon <liran.alon@oracle.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] KVM: x86: vmx: throttle immediate exit through preemtion timer to assist buggy guests
In-Reply-To: <89d4189b-de6a-7634-de8b-29a044a86e12@redhat.com>
References: <20190328203110.20655-1-vkuznets@redhat.com> <f64742ef-c67d-db0f-d812-2b6f5048d7ee@redhat.com> <87d0m93frp.fsf@vitty.brq.redhat.com> <89d4189b-de6a-7634-de8b-29a044a86e12@redhat.com>
Date:   Fri, 29 Mar 2019 16:14:34 +0100
Message-ID: <877ech3e79.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 29/03/19 15:40, Vitaly Kuznetsov wrote:
>> Paolo Bonzini <pbonzini@redhat.com> writes:
>> 
>>> On 28/03/19 21:31, Vitaly Kuznetsov wrote:
>>>>
>>>> The 'hang' scenario develops like this:
>>>> 1) Hyper-V boots and QEMU is trying to inject two irq simultaneously. One
>>>>  of them is level-triggered. KVM injects the edge-triggered one and
>>>>  requests immediate exit to inject the level-triggered:
>>>>
>>>>  kvm_set_irq:          gsi 23 level 1 source 0
>>>>  kvm_msi_set_irq:      dst 0 vec 80 (Fixed|physical|level)
>>>>  kvm_apic_accept_irq:  apicid 0 vec 80 (Fixed|edge)
>>>>  kvm_msi_set_irq:      dst 0 vec 96 (Fixed|physical|edge)
>>>>  kvm_apic_accept_irq:  apicid 0 vec 96 (Fixed|edge)
>>>>  kvm_nested_vmexit_inject: reason EXTERNAL_INTERRUPT info1 0 info2 0 int_info 80000060 int_info_err 0
>>>>
>>>> 2) Hyper-V requires one of its VMs to run to handle the situation but
>>>>  immediate exit happens:
>>>>
>>>>  kvm_entry:            vcpu 0
>>>>  kvm_exit:             reason VMRESUME rip 0xfffff80006a40115 info 0 0
>>>>  kvm_entry:            vcpu 0
>>>>  kvm_exit:             reason PREEMPTION_TIMER rip 0xfffff8022f3d8350 info 0 0
>>>>  kvm_nested_vmexit:    rip fffff8022f3d8350 reason PREEMPTION_TIMER info1 0 info2 0 int_info 0 int_info_err 0
>>>>  kvm_nested_vmexit_inject: reason EXTERNAL_INTERRUPT info1 0 info2 0 int_info 80000050 int_info_err 0
>>>
>>> I supposed before this there was an eoi for vector 96?
>> 
>> AFAIR: no, it seems that it is actually the VM it is trying to resume
>> (Windows partition?) which needs to do some work and with the preemtion
>> timer of 0 we don't allow it to.
>
> kvm_apic_accept_irq placed IRQ 96 in IRR, and Hyper-V should be running
> with "acknowledge interrupt on exit" since int_info is nonzero in
> kvm_nested_vmexit_inject.
>
> Therefore, at the kvm_nested_vmexit_inject tracepoint KVM should have
> set bit 96 in ISR; and because PPR is now 96, interrupt 80 should have
> never been delivered.  Unless 96 is an auto-EOI interrupt, in which case
> this comment would apply
>
>           /*
>            * For auto-EOI interrupts, there might be another pending
>            * interrupt above PPR, so check whether to raise another
>            * KVM_REQ_EVENT.
>            */
>
> IIRC there was an enlightenment to tell Windows "I support auto-EOI but
> please don't use it".  If this is what's happening, that would also fix it.
>

Oh, that's actually an interesting thought, thanks!

Indeed, there is CPUID 0x40000004.EAX Bit 9: Recommend deprecating
AutoEOI which we don't currently set. I'll try and report back.

-- 
Vitaly
