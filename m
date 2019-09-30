Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FFA7C388F4
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 08:48:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DFF22086A
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 08:48:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730303AbfI3Isc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 04:48:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43098 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730189AbfI3Isb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 04:48:31 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6CDA558E23
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2019 08:48:30 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id a15so4225902wrq.4
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2019 01:48:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=z2zHybU21osOisPlhNSom+TBjgJpL+1v6taEXtPzqtg=;
        b=GiIpqp3AEcKZK8pJTuH48cgCAIRBEBwxehx3wiDju6eUwXUHZ28P6XxWF3v8dLx6Wf
         Jbdey3yAkean/Zc9fyCjf0fhUVK+QoH88DXHVe1z8g1J826TGRiS3Nz67/oIE2YdSpmV
         NNyvoU/7aTzBjMADTY6dJd0NemmWIcNvTF2RyZB5XzMYjfOMh8Xsglncy6iNeql101Jt
         LVRsHvp1ZPpx0TsB4ci2/BiJs+wO7qq4N75wY1ZqNHhQUHmRLB6ITEWRp85+pQJVrqNx
         2HDTQS1h01MtHrCM0myon02OnwoTQwI0yVKvfzsrc2keBkST3TYcTbk8VniXb0F67yGS
         xUmw==
X-Gm-Message-State: APjAAAXhOFRH1K2jtziv++9tm5NRe0Xks4LAxEa132tUh76o8SN1wWIK
        vZeqFlAgihw5FSW40wkGBksDOmcN19lNRSY5PJ4ueewZv6lAzPzCyjAVcWiEQ1zODlCYCRuWD8L
        3tuhpi8IT1ptEPIXhAILzMara
X-Received: by 2002:a7b:c00e:: with SMTP id c14mr15719507wmb.158.1569833308871;
        Mon, 30 Sep 2019 01:48:28 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzKYydhyPSllr2kw+Hkb3I9DMukpo9Gxj9D4tgxaCb+MomXmOVx1GYs16JH8PvBVPcvxGLJ1A==
X-Received: by 2002:a7b:c00e:: with SMTP id c14mr15719495wmb.158.1569833308635;
        Mon, 30 Sep 2019 01:48:28 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id b7sm10175881wrj.28.2019.09.30.01.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2019 01:48:28 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Reto Buerki <reet@codelabs.ch>,
        Liran Alon <liran.alon@oracle.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Subject: Re: [PATCH v2 3/8] KVM: VMX: Consolidate to_vmx() usage in RFLAGS accessors
In-Reply-To: <20190927214523.3376-4-sean.j.christopherson@intel.com>
References: <20190927214523.3376-1-sean.j.christopherson@intel.com> <20190927214523.3376-4-sean.j.christopherson@intel.com>
Date:   Mon, 30 Sep 2019 10:48:27 +0200
Message-ID: <87pnji41b8.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> Capture struct vcpu_vmx in a local variable to improve the readability
> of vmx_{g,s}et_rflags().
>
> No functional change intended.
>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/kvm/vmx/vmx.c | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
>
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 0b8dd9c315f8..83fe8b02b732 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -1407,35 +1407,37 @@ static void vmx_decache_cr0_guest_bits(struct kvm_vcpu *vcpu);
>  
>  unsigned long vmx_get_rflags(struct kvm_vcpu *vcpu)
>  {
> +	struct vcpu_vmx *vmx = to_vmx(vcpu);
>  	unsigned long rflags, save_rflags;
>  
>  	if (!test_bit(VCPU_EXREG_RFLAGS, (ulong *)&vcpu->arch.regs_avail)) {
>  		__set_bit(VCPU_EXREG_RFLAGS, (ulong *)&vcpu->arch.regs_avail);
>  		rflags = vmcs_readl(GUEST_RFLAGS);
> -		if (to_vmx(vcpu)->rmode.vm86_active) {
> +		if (vmx->rmode.vm86_active) {
>  			rflags &= RMODE_GUEST_OWNED_EFLAGS_BITS;
> -			save_rflags = to_vmx(vcpu)->rmode.save_rflags;
> +			save_rflags = vmx->rmode.save_rflags;
>  			rflags |= save_rflags & ~RMODE_GUEST_OWNED_EFLAGS_BITS;
>  		}
> -		to_vmx(vcpu)->rflags = rflags;
> +		vmx->rflags = rflags;
>  	}
> -	return to_vmx(vcpu)->rflags;
> +	return vmx->rflags;
>  }
>  
>  void vmx_set_rflags(struct kvm_vcpu *vcpu, unsigned long rflags)
>  {
> +	struct vcpu_vmx *vmx = to_vmx(vcpu);
>  	unsigned long old_rflags = vmx_get_rflags(vcpu);
>  
>  	__set_bit(VCPU_EXREG_RFLAGS, (ulong *)&vcpu->arch.regs_avail);
> -	to_vmx(vcpu)->rflags = rflags;
> -	if (to_vmx(vcpu)->rmode.vm86_active) {
> -		to_vmx(vcpu)->rmode.save_rflags = rflags;
> +	vmx->rflags = rflags;
> +	if (vmx->rmode.vm86_active) {
> +		vmx->rmode.save_rflags = rflags;
>  		rflags |= X86_EFLAGS_IOPL | X86_EFLAGS_VM;
>  	}
>  	vmcs_writel(GUEST_RFLAGS, rflags);
>  
> -	if ((old_rflags ^ to_vmx(vcpu)->rflags) & X86_EFLAGS_VM)
> -		to_vmx(vcpu)->emulation_required = emulation_required(vcpu);
> +	if ((old_rflags ^ vmx->rflags) & X86_EFLAGS_VM)
> +		vmx->emulation_required = emulation_required(vcpu);
>  }
>  
>  u32 vmx_get_interrupt_shadow(struct kvm_vcpu *vcpu)

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly
