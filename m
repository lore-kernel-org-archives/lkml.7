Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F30DC4360C
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 08:57:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE6C32086A
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 08:57:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730272AbfI3I5V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 04:57:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37814 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729968AbfI3I5V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 04:57:21 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A2A9081F07
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2019 08:57:20 +0000 (UTC)
Received: by mail-wm1-f69.google.com with SMTP id c188so3640139wmd.9
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2019 01:57:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=UcGS+56mom6fO6gLbiJPlRBT9sCimqwfenBjQlqeMP8=;
        b=phckIGAg3oKto84YG7vw+r2ub5TO/kqKOiGp7b37929S6lT/ZZIMfdlS4aTw2vP4Gt
         QQdf8ronHyhNADHPkXAvVJGdnXRmJ3StRquf310Sf+o4aa5+y72p9jJkiidCoVtB0Ra5
         kGBDGGk3NzdvFEyP4F++sYAxUAG+4Qlaa4A/mrjyDBvaS+8ROxAV44+i/NRFTywByGQ2
         YCiUx9s0Tcr/8WXOCZygUQL3XwsOyDYSvppMYqJker/BspTMRNgtIjw1EJpFa5KMS4zW
         mLV/QWkJPjx6VU1FfXzd2PVQ2S1jp+6YEE9vy9ds+IH7HTONrcdWx2Z47AeyVQwchQjX
         4q+w==
X-Gm-Message-State: APjAAAVjVgHxg31vFShvq2hzMlnf7CWwdpl4Tj6tSV7XnoQiREmaE9WY
        nxaCnzi2/foDd6LBzbweu5mtPLiL3Hs3GyWzMhZUVAziz6mi72crOjj5W94qnMK4vsXGIzkm/cn
        mRRd9oy7SI+5DdufrTK8Is8Iv
X-Received: by 2002:a5d:43d0:: with SMTP id v16mr12498660wrr.390.1569833839415;
        Mon, 30 Sep 2019 01:57:19 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyqL/jNuwbLiXJECMuYDQFS2oi5pGvfRx0tVhTeQLsW0ZtP4yOYtHzkJVvLfzz5xWcWat0nuQ==
X-Received: by 2002:a5d:43d0:: with SMTP id v16mr12498621wrr.390.1569833838927;
        Mon, 30 Sep 2019 01:57:18 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id a14sm16815711wmm.44.2019.09.30.01.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2019 01:57:18 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Reto Buerki <reet@codelabs.ch>,
        Liran Alon <liran.alon@oracle.com>
Subject: Re: [PATCH v2 4/8] KVM: VMX: Optimize vmx_set_rflags() for unrestricted guest
In-Reply-To: <20190927214523.3376-5-sean.j.christopherson@intel.com>
References: <20190927214523.3376-1-sean.j.christopherson@intel.com> <20190927214523.3376-5-sean.j.christopherson@intel.com>
Date:   Mon, 30 Sep 2019 10:57:17 +0200
Message-ID: <87muem40wi.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> Rework vmx_set_rflags() to avoid the extra code need to handle emulation
> of real mode and invalid state when unrestricted guest is disabled.  The
> primary reason for doing so is to avoid the call to vmx_get_rflags(),
> which will incur a VMREAD when RFLAGS is not already available.  When
> running nested VMs, the majority of calls to vmx_set_rflags() will occur
> without an associated vmx_get_rflags(), i.e. when stuffing GUEST_RFLAGS
> during transitions between vmcs01 and vmcs02.
>
> Note, vmx_get_rflags() guarantees RFLAGS is marked available.
>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/kvm/vmx/vmx.c | 28 ++++++++++++++++++----------
>  1 file changed, 18 insertions(+), 10 deletions(-)
>
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 83fe8b02b732..814d3e6d0264 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -1426,18 +1426,26 @@ unsigned long vmx_get_rflags(struct kvm_vcpu *vcpu)
>  void vmx_set_rflags(struct kvm_vcpu *vcpu, unsigned long rflags)
>  {
>  	struct vcpu_vmx *vmx = to_vmx(vcpu);
> -	unsigned long old_rflags = vmx_get_rflags(vcpu);
> +	unsigned long old_rflags;
>  
> -	__set_bit(VCPU_EXREG_RFLAGS, (ulong *)&vcpu->arch.regs_avail);
> -	vmx->rflags = rflags;
> -	if (vmx->rmode.vm86_active) {
> -		vmx->rmode.save_rflags = rflags;
> -		rflags |= X86_EFLAGS_IOPL | X86_EFLAGS_VM;
> +	if (enable_unrestricted_guest) {
> +		__set_bit(VCPU_EXREG_RFLAGS, (ulong *)&vcpu->arch.regs_avail);
> +
> +		vmx->rflags = rflags;
> +		vmcs_writel(GUEST_RFLAGS, rflags);
> +	} else {
> +		old_rflags = vmx_get_rflags(vcpu);
> +
> +		vmx->rflags = rflags;
> +		if (vmx->rmode.vm86_active) {
> +			vmx->rmode.save_rflags = rflags;
> +			rflags |= X86_EFLAGS_IOPL | X86_EFLAGS_VM;
> +		}
> +		vmcs_writel(GUEST_RFLAGS, rflags);
> +
> +		if ((old_rflags ^ vmx->rflags) & X86_EFLAGS_VM)
> +			vmx->emulation_required = emulation_required(vcpu);
>  	}
> -	vmcs_writel(GUEST_RFLAGS, rflags);

We're doing vmcs_writel() in both branches so it could've stayed here, right?

> -
> -	if ((old_rflags ^ vmx->rflags) & X86_EFLAGS_VM)
> -		vmx->emulation_required = emulation_required(vcpu);
>  }
>  
>  u32 vmx_get_interrupt_shadow(struct kvm_vcpu *vcpu)

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly
