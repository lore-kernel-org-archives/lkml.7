Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1DB2C32751
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 23:17:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF5E72086D
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 23:17:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731007AbfHEXRc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 19:17:32 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39269 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730875AbfHEXRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 19:17:31 -0400
Received: by mail-wr1-f65.google.com with SMTP id x4so32813305wrt.6
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 16:17:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PeMpHB1UaVYGh8oqL7/+H8waTPb/Jq8dxVIPc4CJ+Qk=;
        b=jr9QHnfZR7SVU5sK9TR9a2Rw0NmnoNMVsVZf8d1gW8GIw7C1ZYrhogxFgt4d8OGCQM
         7pLAjr1yCMktYUSPR5UkTOF9bwdSnO0yP7LV99Vx+SOD/TY6ceUYztx7igdyFSCsbBE2
         fR5Cf/bwDmush7+BvSsuFhL9syHCGQWuvAXiqrsoHELLewsBJ5hjWM5xV0y/uLQPFWku
         LewG2ppo6wvzGvwlwsyx1kk366jAzSdNgOEeTOfG/i9C4iCgW+KA+cJgLLcwWOg+0Xxm
         bUD8F+QL7/ysqgOSeLhRZcVqlshZIZU8aD95TW3DSSuEZ7qSWtOyu5c0KhPkHYnfON4v
         kZJg==
X-Gm-Message-State: APjAAAUs+uygcmGKPIuAmbqpPySGTROBXzFFfTdq+Sdk2eQQJG15lcEX
        uDLz+V7Zk4WMc81dhDl8Vm7hbA==
X-Google-Smtp-Source: APXvYqxCLIfa99wR63hAGf/aZH8p3Qjmcyz3+bBsnzEqVWm1qaEhqTrx+w5t3jeY/vvTd63LA9R0og==
X-Received: by 2002:a5d:67cd:: with SMTP id n13mr342350wrw.138.1565047049292;
        Mon, 05 Aug 2019 16:17:29 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:dc26:ed70:9e4c:3810? ([2001:b07:6468:f312:dc26:ed70:9e4c:3810])
        by smtp.gmail.com with ESMTPSA id h14sm85951308wrs.66.2019.08.05.16.17.28
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Aug 2019 16:17:28 -0700 (PDT)
Subject: Re: [PATCH v4 1/6] KVM: Fix leak vCPU's VMCS value into other pCPU
To:     Wanpeng Li <kernellwp@gmail.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Marc Zyngier <Marc.Zyngier@arm.com>, stable@vger.kernel.org
References: <1564970604-10044-1-git-send-email-wanpengli@tencent.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <9acbc733-442f-0f65-9b56-ff800a3fa0f5@redhat.com>
Date:   Tue, 6 Aug 2019 01:17:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1564970604-10044-1-git-send-email-wanpengli@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/08/19 04:03, Wanpeng Li wrote:
> From: Wanpeng Li <wanpengli@tencent.com>
> 
> After commit d73eb57b80b (KVM: Boost vCPUs that are delivering interrupts), a 
> five years old bug is exposed. Running ebizzy benchmark in three 80 vCPUs VMs 
> on one 80 pCPUs Skylake server, a lot of rcu_sched stall warning splatting 
> in the VMs after stress testing:
> 
>  INFO: rcu_sched detected stalls on CPUs/tasks: { 4 41 57 62 77} (detected by 15, t=60004 jiffies, g=899, c=898, q=15073)
>  Call Trace:
>    flush_tlb_mm_range+0x68/0x140
>    tlb_flush_mmu.part.75+0x37/0xe0
>    tlb_finish_mmu+0x55/0x60
>    zap_page_range+0x142/0x190
>    SyS_madvise+0x3cd/0x9c0
>    system_call_fastpath+0x1c/0x21
> 
> swait_active() sustains to be true before finish_swait() is called in 
> kvm_vcpu_block(), voluntarily preempted vCPUs are taken into account 
> by kvm_vcpu_on_spin() loop greatly increases the probability condition 
> kvm_arch_vcpu_runnable(vcpu) is checked and can be true, when APICv 
> is enabled the yield-candidate vCPU's VMCS RVI field leaks(by 
> vmx_sync_pir_to_irr()) into spinning-on-a-taken-lock vCPU's current 
> VMCS.
> 
> This patch fixes it by checking conservatively a subset of events.
> 
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Radim Krčmář <rkrcmar@redhat.com>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Cc: Marc Zyngier <Marc.Zyngier@arm.com>
> Cc: stable@vger.kernel.org
> Fixes: 98f4a1467 (KVM: add kvm_arch_vcpu_runnable() test to kvm_vcpu_on_spin() loop)
> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> ---
> v3 -> v4:
>  * just test KVM_REQ_*
>  * rename the hook to apicv_has_pending_interrupt
>  * wrap with #ifdef CONFIG_KVM_ASYNC_PF 
> v2 -> v3:
>  * check conservatively a subset of events
> v1 -> v2:
>  * checking swait_active(&vcpu->wq) for involuntary preemption
> 
>  arch/mips/kvm/mips.c            |  5 +++++
>  arch/powerpc/kvm/powerpc.c      |  5 +++++
>  arch/s390/kvm/kvm-s390.c        |  5 +++++
>  arch/x86/include/asm/kvm_host.h |  1 +
>  arch/x86/kvm/svm.c              |  6 ++++++
>  arch/x86/kvm/vmx/vmx.c          |  6 ++++++
>  arch/x86/kvm/x86.c              | 16 ++++++++++++++++
>  include/linux/kvm_host.h        |  1 +
>  virt/kvm/arm/arm.c              |  5 +++++
>  virt/kvm/kvm_main.c             | 16 +++++++++++++++-
>  10 files changed, 65 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
> index 2cfe839..95a4642 100644
> --- a/arch/mips/kvm/mips.c
> +++ b/arch/mips/kvm/mips.c
> @@ -98,6 +98,11 @@ int kvm_arch_vcpu_runnable(struct kvm_vcpu *vcpu)
>  	return !!(vcpu->arch.pending_exceptions);
>  }
>  
> +bool kvm_arch_dy_runnable(struct kvm_vcpu *vcpu)

Using a __weak definition for the default implementation is a bit more
concise.  Queued with that change.

Paolo
