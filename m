Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26790C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 12:27:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F201F21897
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 12:27:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394703AbfHWM1n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 08:27:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48437 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392572AbfHWM1m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 08:27:42 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9920AC054C52
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 12:27:41 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id r1so4301442wmr.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 05:27:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=7h0x9rgASWk8qPjUOaS/mZJRiG6RBmB84OOVjwHTOWM=;
        b=GEuRcs+xH4ci/bvgg8JeQs2f0lmlbSAuoGusxi3T7xzOGm4gym1424OuYL87pKZQUF
         7bW/souq7t9a6YmQhzCZTINQC8yJhGq0hNSrudRE8TafQZTOrOMfE+0elLSbnt2Wq2bc
         lkwbvLN0KxU6axe0mdwgFktpsNCrjut13DYmVe+fBCWsCMdF0XmdqsRjQmqxqAi80T+b
         SHMZmvgrNjPlxOiBv0ndrC95jVLBAFLUe+bW7ZmIbUL6tm/znjaF/UUIReTa5ne36KtT
         mnIkJogJLny96W3XVp8VvzTqtjMsI8DHkMBK+U8aH5nst77Y3194unt5lFmSksxQ22Ve
         DzrQ==
X-Gm-Message-State: APjAAAXytNNkLCMMp8jeIoSPMsr3aGB5DpE9Kru8CX27wd4O8R62iIwi
        Fl0Xmt+RixMleXGkTILbnsdcM/r0bZF+2KzrI6NdKBlSzYSIDoXov85Pud8SRfw+rpHzlDU12o5
        atOBBmDZRsKm6I/WvEyBvedBR
X-Received: by 2002:a7b:c95a:: with SMTP id i26mr5108341wml.175.1566563260071;
        Fri, 23 Aug 2019 05:27:40 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwm7PSBjTdOngOg1paE0LxSJSXRFPKcTRzm90yeu4pMk3McP3Wrxfg4UUz+GWbSSVRnQX4R9A==
X-Received: by 2002:a7b:c95a:: with SMTP id i26mr5108313wml.175.1566563259845;
        Fri, 23 Aug 2019 05:27:39 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id r11sm2186226wrt.84.2019.08.23.05.27.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2019 05:27:39 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH 06/13] KVM: x86: Move #GP injection for VMware into x86_emulate_instruction()
In-Reply-To: <20190823010709.24879-7-sean.j.christopherson@intel.com>
References: <20190823010709.24879-1-sean.j.christopherson@intel.com> <20190823010709.24879-7-sean.j.christopherson@intel.com>
Date:   Fri, 23 Aug 2019 14:27:38 +0200
Message-ID: <87sgpsnk1x.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> Immediately inject a #GP when VMware emulation fails and return
> EMULATE_DONE instead of propagating EMULATE_FAIL up the stack.  This
> helps pave the way for removing EMULATE_FAIL altogether.
>
> Rename EMULTYPE_VMWARE to EMULTYPE_VMWARE_GP to help document why a #GP
> is injected on emulation failure.

Hm, maybe it's just me but I would've assumed _GP suffix means 'called
from #GP intercept' and not '#GP is injected on failure'. This is no
different here because we only do #GP intercepts for vmware backdoor
emulation and this emulation only happens on #GP.

>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/include/asm/kvm_host.h |  2 +-
>  arch/x86/kvm/svm.c              |  9 ++-------
>  arch/x86/kvm/vmx/vmx.c          |  9 ++-------
>  arch/x86/kvm/x86.c              | 14 +++++++++-----
>  4 files changed, 14 insertions(+), 20 deletions(-)
>
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index dd6bd9ed0839..d1d5b5ca1195 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -1318,7 +1318,7 @@ enum emulation_result {
>  #define EMULTYPE_TRAP_UD	    (1 << 1)
>  #define EMULTYPE_SKIP		    (1 << 2)
>  #define EMULTYPE_ALLOW_RETRY	    (1 << 3)
> -#define EMULTYPE_VMWARE		    (1 << 5)
> +#define EMULTYPE_VMWARE_GP	    (1 << 5)
>  int kvm_emulate_instruction(struct kvm_vcpu *vcpu, int emulation_type);
>  int kvm_emulate_instruction_from_buffer(struct kvm_vcpu *vcpu,
>  					void *insn, int insn_len);
> diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
> index b96a119690f4..97562c2c8b7b 100644
> --- a/arch/x86/kvm/svm.c
> +++ b/arch/x86/kvm/svm.c
> @@ -2768,7 +2768,6 @@ static int gp_interception(struct vcpu_svm *svm)
>  {
>  	struct kvm_vcpu *vcpu = &svm->vcpu;
>  	u32 error_code = svm->vmcb->control.exit_info_1;
> -	int er;
>  
>  	WARN_ON_ONCE(!enable_vmware_backdoor);
>  
> @@ -2776,12 +2775,8 @@ static int gp_interception(struct vcpu_svm *svm)
>  		kvm_queue_exception_e(vcpu, GP_VECTOR, error_code);
>  		return 1;
>  	}
> -	er = kvm_emulate_instruction(vcpu, EMULTYPE_VMWARE);
> -	if (er == EMULATE_USER_EXIT)
> -		return 0;
> -	else if (er != EMULATE_DONE)
> -		kvm_queue_exception_e(vcpu, GP_VECTOR, 0);
> -	return 1;
> +	return kvm_emulate_instruction(vcpu, EMULTYPE_VMWARE_GP) !=
> +						EMULATE_USER_EXIT;
>  }
>  
>  static bool is_erratum_383(void)
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 3ee0dd304bc7..25410c58c758 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -4492,7 +4492,6 @@ static int handle_exception_nmi(struct kvm_vcpu *vcpu)
>  	u32 intr_info, ex_no, error_code;
>  	unsigned long cr2, rip, dr6;
>  	u32 vect_info;
> -	enum emulation_result er;
>  
>  	vect_info = vmx->idt_vectoring_info;
>  	intr_info = vmx->exit_intr_info;
> @@ -4514,12 +4513,8 @@ static int handle_exception_nmi(struct kvm_vcpu *vcpu)
>  			kvm_queue_exception_e(vcpu, GP_VECTOR, error_code);
>  			return 1;
>  		}
> -		er = kvm_emulate_instruction(vcpu, EMULTYPE_VMWARE);
> -		if (er == EMULATE_USER_EXIT)
> -			return 0;
> -		else if (er != EMULATE_DONE)
> -			kvm_queue_exception_e(vcpu, GP_VECTOR, 0);
> -		return 1;
> +		return kvm_emulate_instruction(vcpu, EMULTYPE_VMWARE_GP) !=
> +							EMULATE_USER_EXIT;
>  	}
>  
>  	/*
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index e0f0e14d8fac..228ca71d5b01 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -6210,8 +6210,10 @@ static int handle_emulation_failure(struct kvm_vcpu *vcpu, int emulation_type)
>  	++vcpu->stat.insn_emulation_fail;
>  	trace_kvm_emulate_insn_failed(vcpu);
>  
> -	if (emulation_type & EMULTYPE_VMWARE)
> -		return EMULATE_FAIL;
> +	if (emulation_type & EMULTYPE_VMWARE_GP) {
> +		kvm_queue_exception_e(vcpu, GP_VECTOR, 0);
> +		return EMULATE_DONE;
> +	}
>  
>  	kvm_queue_exception(vcpu, UD_VECTOR);
>  
> @@ -6543,9 +6545,11 @@ int x86_emulate_instruction(struct kvm_vcpu *vcpu,
>  		}
>  	}
>  
> -	if ((emulation_type & EMULTYPE_VMWARE) &&
> -	    !is_vmware_backdoor_opcode(ctxt))
> -		return EMULATE_FAIL;
> +	if ((emulation_type & EMULTYPE_VMWARE_GP) &&
> +	    !is_vmware_backdoor_opcode(ctxt)) {
> +		kvm_queue_exception_e(vcpu, GP_VECTOR, 0);
> +		return EMULATE_DONE;
> +	}
>  
>  	if (emulation_type & EMULTYPE_SKIP) {
>  		kvm_rip_write(vcpu, ctxt->_eip);

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly
