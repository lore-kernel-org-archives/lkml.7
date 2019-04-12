Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E727C10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 08:07:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4261020651
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 08:07:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727209AbfDLIH2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 04:07:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33855 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725973AbfDLIH1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 04:07:27 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 559A6308625A;
        Fri, 12 Apr 2019 08:07:27 +0000 (UTC)
Received: from [10.36.112.36] (ovpn-112-36.ams2.redhat.com [10.36.112.36])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 35C0360C97;
        Fri, 12 Apr 2019 08:07:23 +0000 (UTC)
Subject: Re: [PATCH] x86/kvm: move kvm_load/put_guest_xcr0 into atomic context
To:     WANG Chao <chao.wang@ucloud.cn>, kvm@vger.kernel.org
Cc:     =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
References: <20190412075539.24624-1-chao.wang@ucloud.cn>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=pbonzini@redhat.com; prefer-encrypt=mutual; keydata=
 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
 uUHgL9dKIfvpm+rNXRn9wAwGjk0X/A==
Message-ID: <23f882f1-6477-3c18-c07f-873c24351cfc@redhat.com>
Date:   Fri, 12 Apr 2019 10:07:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190412075539.24624-1-chao.wang@ucloud.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Fri, 12 Apr 2019 08:07:27 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/04/19 09:55, WANG Chao wrote:
> guest xcr0 could leak into host when MCE happens in guest mode. Because
> do_machine_check() could schedule out at a few places.
> 
> For example:
> 
> kvm_load_guest_xcr0
> ...
> kvm_x86_ops->run(vcpu) {
>   vmx_vcpu_run
>     vmx_complete_atomic_exit
>       kvm_machine_check
>         do_machine_check
>           do_memory_failure
>             memory_failure
>               lock_page
> 
> In this case, host_xcr0 is 0x2ff, guest vcpu xcr0 is 0xff. After schedule
> out, host cpu has guest xcr0 loaded (0xff).
> 
> In __switch_to {
>      switch_fpu_finish
>        copy_kernel_to_fpregs
>          XRSTORS
> 
> If any bit i in XSTATE_BV[i] == 1 and xcr0[i] == 0, XRSTORS will
> generate #GP (In this case, bit 9). Then ex_handler_fprestore kicks in
> and tries to reinitialize fpu by restoring init fpu state. Same story as
> last #GP, except we get DOUBLE FAULT this time.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: WANG Chao <chao.wang@ucloud.cn>

Thanks for the detailed commit message.  Patch queued!.

Paolo

> ---
>  arch/x86/kvm/svm.c     |  2 ++
>  arch/x86/kvm/vmx/vmx.c |  4 ++++
>  arch/x86/kvm/x86.c     | 10 ++++------
>  arch/x86/kvm/x86.h     |  2 ++
>  4 files changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
> index e0a791c3d4fc..2bf73076de7f 100644
> --- a/arch/x86/kvm/svm.c
> +++ b/arch/x86/kvm/svm.c
> @@ -5621,6 +5621,7 @@ static void svm_vcpu_run(struct kvm_vcpu *vcpu)
>  	svm->vmcb->save.cr2 = vcpu->arch.cr2;
>  
>  	clgi();
> +	kvm_load_guest_xcr0(vcpu);
>  
>  	/*
>  	 * If this vCPU has touched SPEC_CTRL, restore the guest's value if
> @@ -5766,6 +5767,7 @@ static void svm_vcpu_run(struct kvm_vcpu *vcpu)
>  	if (unlikely(svm->vmcb->control.exit_code == SVM_EXIT_NMI))
>  		kvm_before_interrupt(&svm->vcpu);
>  
> +	kvm_put_guest_xcr0(vcpu);
>  	stgi();
>  
>  	/* Any pending NMI will happen here */
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index ab432a930ae8..3157598c52f1 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -6410,6 +6410,8 @@ static void vmx_vcpu_run(struct kvm_vcpu *vcpu)
>  	if (vcpu->guest_debug & KVM_GUESTDBG_SINGLESTEP)
>  		vmx_set_interrupt_shadow(vcpu, 0);
>  
> +	kvm_load_guest_xcr0(vcpu);
> +
>  	if (static_cpu_has(X86_FEATURE_PKU) &&
>  	    kvm_read_cr4_bits(vcpu, X86_CR4_PKE) &&
>  	    vcpu->arch.pkru != vmx->host_pkru)
> @@ -6506,6 +6508,8 @@ static void vmx_vcpu_run(struct kvm_vcpu *vcpu)
>  			__write_pkru(vmx->host_pkru);
>  	}
>  
> +	kvm_put_guest_xcr0(vcpu);
> +
>  	vmx->nested.nested_run_pending = 0;
>  	vmx->idt_vectoring_info = 0;
>  
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 099b851dabaf..22f66e9a7dc5 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -800,7 +800,7 @@ void kvm_lmsw(struct kvm_vcpu *vcpu, unsigned long msw)
>  }
>  EXPORT_SYMBOL_GPL(kvm_lmsw);
>  
> -static void kvm_load_guest_xcr0(struct kvm_vcpu *vcpu)
> +void kvm_load_guest_xcr0(struct kvm_vcpu *vcpu)
>  {
>  	if (kvm_read_cr4_bits(vcpu, X86_CR4_OSXSAVE) &&
>  			!vcpu->guest_xcr0_loaded) {
> @@ -810,8 +810,9 @@ static void kvm_load_guest_xcr0(struct kvm_vcpu *vcpu)
>  		vcpu->guest_xcr0_loaded = 1;
>  	}
>  }
> +EXPORT_SYMBOL_GPL(kvm_load_guest_xcr0);
>  
> -static void kvm_put_guest_xcr0(struct kvm_vcpu *vcpu)
> +void kvm_put_guest_xcr0(struct kvm_vcpu *vcpu)
>  {
>  	if (vcpu->guest_xcr0_loaded) {
>  		if (vcpu->arch.xcr0 != host_xcr0)
> @@ -819,6 +820,7 @@ static void kvm_put_guest_xcr0(struct kvm_vcpu *vcpu)
>  		vcpu->guest_xcr0_loaded = 0;
>  	}
>  }
> +EXPORT_SYMBOL_GPL(kvm_put_guest_xcr0);
>  
>  static int __kvm_set_xcr(struct kvm_vcpu *vcpu, u32 index, u64 xcr)
>  {
> @@ -7865,8 +7867,6 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
>  		goto cancel_injection;
>  	}
>  
> -	kvm_load_guest_xcr0(vcpu);
> -
>  	if (req_immediate_exit) {
>  		kvm_make_request(KVM_REQ_EVENT, vcpu);
>  		kvm_x86_ops->request_immediate_exit(vcpu);
> @@ -7919,8 +7919,6 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
>  	vcpu->mode = OUTSIDE_GUEST_MODE;
>  	smp_wmb();
>  
> -	kvm_put_guest_xcr0(vcpu);
> -
>  	kvm_before_interrupt(vcpu);
>  	kvm_x86_ops->handle_external_intr(vcpu);
>  	kvm_after_interrupt(vcpu);
> diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
> index 28406aa1136d..aedc5d0d4989 100644
> --- a/arch/x86/kvm/x86.h
> +++ b/arch/x86/kvm/x86.h
> @@ -347,4 +347,6 @@ static inline void kvm_after_interrupt(struct kvm_vcpu *vcpu)
>  	__this_cpu_write(current_vcpu, NULL);
>  }
>  
> +void kvm_load_guest_xcr0(struct kvm_vcpu *vcpu);
> +void kvm_put_guest_xcr0(struct kvm_vcpu *vcpu);
>  #endif
> 

