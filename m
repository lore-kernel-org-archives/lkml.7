Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B86C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E6CB20828
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:51:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728007AbfDAIvD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 04:51:03 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50781 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726637AbfDAIvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 04:51:02 -0400
Received: by mail-wm1-f66.google.com with SMTP id z11so9511406wmi.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 01:51:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=uLmSmos+VfbRw6RvrGeNTGCyKyv3dmO8Id/z0iVFb9U=;
        b=lng66LLWGii5QLTkxDpMLyONum8d3zRX6A/Y51AN41XR9U1ZHuNFZPj4kkKZzk67r0
         +z802ZjN81KjaikmB5rptTtt89xUMe6c1wHn2irg5ASJgH/UT2L2wNXldNCC0VFuPm4+
         qOCfQ/9cAcwIvB/6xNhABxwMf562XxHorIiCBbak5QdbcT0QeaX1oNS8Mea5/Nkyj9p9
         QWGN7xC4sVNK2zaxyMOplKaahGXTnQu72c23Yz34OFs+iSyGIaylUNZpPlaMSqbMI9hr
         SvwAMmbPGnAOAFbzED8/GATrsEiZjLMJGXS7k51K0eykVi0TmkBQKeclbItV8iSQpe34
         SU+A==
X-Gm-Message-State: APjAAAU38nPJVLf1v3oBgt2gGVhjSeWoa9dofh4r6Pz0hGRcqOIAPfhS
        YqnqwEjFyiuUUaExQ3FZX4QsBfxtz0Q=
X-Google-Smtp-Source: APXvYqwVD+HZwsvphM+aJAnG7kckV8vMwFx078tn1GlydGHC2oXAHUfT2onO16pTj41wq+YjL/2FAw==
X-Received: by 2002:a05:600c:2309:: with SMTP id 9mr12108240wmo.52.1554108659648;
        Mon, 01 Apr 2019 01:50:59 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id t15sm14162778wmt.2.2019.04.01.01.50.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Apr 2019 01:50:58 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Cc:     Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Liran Alon <liran.alon@oracle.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] KVM: x86: vmx: throttle immediate exit through preemtion timer to assist buggy guests
In-Reply-To: <89d4189b-de6a-7634-de8b-29a044a86e12@redhat.com>
References: <20190328203110.20655-1-vkuznets@redhat.com> <f64742ef-c67d-db0f-d812-2b6f5048d7ee@redhat.com> <87d0m93frp.fsf@vitty.brq.redhat.com> <89d4189b-de6a-7634-de8b-29a044a86e12@redhat.com>
Date:   Mon, 01 Apr 2019 10:50:57 +0200
Message-ID: <87sgv2153i.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Bonzini <pbonzini@redhat.com> writes:

>
> IIRC there was an enlightenment to tell Windows "I support auto-EOI but
> please don't use it".  If this is what's happening, that would also fix it.
>

Unfortunately this doesn't save the day, Hyper-V behaves the
same. I'm more and move convinced that the secord IRQ was completely
unrelated:

 [011] 515003.517644: kvm_exit:             reason EPT_MISCONFIG rip 0xfffff80ca6bf1a5e info 0 0
 [011] 515003.517645: kvm_nested_vmexit:    rip fffff80ca6bf1a5e reason EPT_MISCONFIG info1 0 info2 0 int_info 0 int_info_err 0
 [011] 515003.517649: kvm_emulate_insn:     0:fffff80ca6bf1a5e: 8b 08
 [011] 515003.517652: vcpu_match_mmio:      gva 0xffffd300eb0a8008 gpa 0x91044008 Read GPA
 [011] 515003.517653: kvm_mmio:             mmio unsatisfied-read len 4 gpa 0x91044008 val 0x0
 [011] 515003.517654: kvm_fpu:              unload
 [011] 515003.517655: kvm_userspace_exit:   reason KVM_EXIT_MMIO (6)

-> injecting

 [007] 515003.517664: kvm_set_irq:          gsi 23 level 1 source 0
 [007] 515003.517666: kvm_msi_set_irq:      dst 0 vec 80 (Fixed|physical|level)
 [007] 515003.517667: kvm_apic_accept_irq:  apicid 0 vec 80 (Fixed|edge)
 [011] 515003.517688: kvm_fpu:              load
 [011] 515003.517689: kvm_mmio:             mmio read len 4 gpa 0x91044008 val 0x1
 [011] 515003.517692: kvm_nested_vmexit_inject: reason EXTERNAL_INTERRUPT info1 0 info2 0 int_info 80000050 int_info_err 0
 [011] 515003.517696: kvm_entry:            vcpu 0

-> immediate EOI

 [011] 515003.517702: kvm_exit:             reason EOI_INDUCED rip 0xfffff80002427e1a info 50 0
 [011] 515003.517703: kvm_eoi:              apicid 0 vector 80
 [011] 515003.517704: kvm_fpu:              unload
 [011] 515003.517705: kvm_userspace_exit:   reason KVM_EXIT_IOAPIC_EOI (26)
 [011] 515003.517710: kvm_set_irq:          gsi 23 level 1 source 0
 [011] 515003.517711: kvm_msi_set_irq:      dst 0 vec 80 (Fixed|physical|level)
 [011] 515003.517712: kvm_apic_accept_irq:  apicid 0 vec 80 (Fixed|edge)
 [011] 515003.517714: kvm_fpu:              load
 [011] 515003.517716: kvm_entry:            vcpu 0
 [011] 515003.517720: kvm_exit:             reason VMRESUME rip 0xfffff80002450115 info 0 0
 [011] 515003.517726: kvm_entry:            vcpu 0
 [011] 515003.517729: kvm_exit:             reason PREEMPTION_TIMER rip 0xfffff80ca6bf1a60 info 0 0
 [011] 515003.517730: kvm_nested_vmexit:    rip fffff80ca6bf1a60 reason PREEMPTION_TIMER info1 0 info2 0 int_info 0 int_info_err 0
 [011] 515003.517732: kvm_nested_vmexit_inject: reason EXTERNAL_INTERRUPT info1 0 info2 0 int_info 80000050 int_info_err 0
 [011] 515003.517735: kvm_entry:            vcpu 0
 [011] 515003.517739: kvm_exit:             reason EOI_INDUCED rip 0xfffff80002427e1a info 50 0
 [011] 515003.517739: kvm_eoi:              apicid 0 vector 80
 [011] 515003.517740: kvm_fpu:              unload
 [011] 515003.517741: kvm_userspace_exit:   reason KVM_EXIT_IOAPIC_EOI (26)
 [011] 515003.517743: kvm_set_irq:          gsi 23 level 1 source 0
 [011] 515003.517744: kvm_msi_set_irq:      dst 0 vec 80 (Fixed|physical|level)
 [011] 515003.517744: kvm_apic_accept_irq:  apicid 0 vec 80 (Fixed|edge)
 [011] 515003.517746: kvm_fpu:              load
 [011] 515003.517747: kvm_entry:            vcpu 0
 [011] 515003.517751: kvm_exit:             reason VMRESUME rip 0xfffff80002450115 info 0 0

...

-- 
Vitaly
