Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B21C5C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 14:40:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BE612183F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 14:40:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729382AbfC2Okt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 10:40:49 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40067 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729021AbfC2Okq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 10:40:46 -0400
Received: by mail-wm1-f67.google.com with SMTP id z24so3114947wmi.5
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 07:40:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=m1U/9No1om/xpwk+9c7FZnuMILDfo7dttqFsNyKRglk=;
        b=uHYznqsNI9LkTImzhS1LE4WDmDQ571IvSFjVsNE9TPLiprAw+JmkTgsXZbk3VIFRoM
         TgjKQN6Tndr8DDKzTuZvb/Do4FrA0AJepdhMiX0Y0aDM3DS/QD1PwfGXJZA58PkXHwFr
         coxVSQ+6R69YtUj7DJY/stt6nqxrB0hDZ7+lIuUOVHOYsAe3JvmuUconTihtfgukXYO0
         p/S+1EHXAX7f+/rErdgiCZ0o+dTJuZwSDQGsucLI1G/B/mjX5VAyHXf31AYBTXmwfmDY
         2hg+0NKfV2FrUIn9YPSICSfGg7HKTAPYYFRUmmRAffLtVtpeL/asGfskC3sz1a3oHuBG
         g7RQ==
X-Gm-Message-State: APjAAAUy0HLesVmf7yqTPosnmTMl+U2beJSWQvkRvy2weDe9BC8Nvezb
        nmaPTUlbiUE6FZgd8nTWerJkDiYh2pk=
X-Google-Smtp-Source: APXvYqxMKtln2NpOYAyiATnKBycJsavwKdUsU1Rx+/W5dqsqJmVZQHeCNC2mJ3TS6J4OcsDJqV5FWw==
X-Received: by 2002:a7b:cd08:: with SMTP id f8mr3803304wmj.86.1553870444620;
        Fri, 29 Mar 2019 07:40:44 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id z13sm2998735wrw.36.2019.03.29.07.40.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Mar 2019 07:40:43 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Cc:     Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Liran Alon <liran.alon@oracle.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] KVM: x86: vmx: throttle immediate exit through preemtion timer to assist buggy guests
In-Reply-To: <f64742ef-c67d-db0f-d812-2b6f5048d7ee@redhat.com>
References: <20190328203110.20655-1-vkuznets@redhat.com> <f64742ef-c67d-db0f-d812-2b6f5048d7ee@redhat.com>
Date:   Fri, 29 Mar 2019 15:40:42 +0100
Message-ID: <87d0m93frp.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 28/03/19 21:31, Vitaly Kuznetsov wrote:
>> 
>> The 'hang' scenario develops like this:
>> 1) Hyper-V boots and QEMU is trying to inject two irq simultaneously. One
>>  of them is level-triggered. KVM injects the edge-triggered one and
>>  requests immediate exit to inject the level-triggered:
>> 
>>  kvm_set_irq:          gsi 23 level 1 source 0
>>  kvm_msi_set_irq:      dst 0 vec 80 (Fixed|physical|level)
>>  kvm_apic_accept_irq:  apicid 0 vec 80 (Fixed|edge)
>>  kvm_msi_set_irq:      dst 0 vec 96 (Fixed|physical|edge)
>>  kvm_apic_accept_irq:  apicid 0 vec 96 (Fixed|edge)
>>  kvm_nested_vmexit_inject: reason EXTERNAL_INTERRUPT info1 0 info2 0 int_info 80000060 int_info_err 0
>> 
>> 2) Hyper-V requires one of its VMs to run to handle the situation but
>>  immediate exit happens:
>> 
>>  kvm_entry:            vcpu 0
>>  kvm_exit:             reason VMRESUME rip 0xfffff80006a40115 info 0 0
>>  kvm_entry:            vcpu 0
>>  kvm_exit:             reason PREEMPTION_TIMER rip 0xfffff8022f3d8350 info 0 0
>>  kvm_nested_vmexit:    rip fffff8022f3d8350 reason PREEMPTION_TIMER info1 0 info2 0 int_info 0 int_info_err 0
>>  kvm_nested_vmexit_inject: reason EXTERNAL_INTERRUPT info1 0 info2 0 int_info 80000050 int_info_err 0
>
> I supposed before this there was an eoi for vector 96?

AFAIR: no, it seems that it is actually the VM it is trying to resume
(Windows partition?) which needs to do some work and with the preemtion
timer of 0 we don't allow it to.

>
> The main issue with your patch is that the preemption timer is buggy on
> some processors (it runs too fast) and on those processors we shouldn't
> use it with nonzero deadline.  In particular because it runs too fast it
> may not hide the bug.
>
> I think level-triggered interrupts are required for the bug to show.
> Edge-triggered interrupts usually have to be acknowledged with a device
> register before the host device will trigger another interrupt; or at
> least the interrupt event, for example an incoming network packet, must
> happen again.  This way, when the guest hangs it puts some back pressure
> on the host.
>
> I think we should do in QEMU the same fix that was done in the in-kernel
> IOAPIC.

Yes, I have this in my plan. Stay tuned!

-- 
Vitaly
