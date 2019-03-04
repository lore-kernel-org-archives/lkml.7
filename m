Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E60E6C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A18D920823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:42:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y4xLHnYd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbfCDImc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 03:42:32 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37975 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbfCDIm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 03:42:29 -0500
Received: by mail-wm1-f67.google.com with SMTP id a188so3757972wmf.3;
        Mon, 04 Mar 2019 00:42:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:openpgp:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=30S083hNm5bzPjo2JVzG/E0bkXH5Uh7GRbmZ7o0lvjg=;
        b=Y4xLHnYdbF17qHoAkGWemw1GMkJbGRUSzLy7g93cNkskCE8u7sq9GuJ+7PcREbiPD9
         8leReAgJsnYPom8tLDR/uati2urxAYA5v+/p7QSsxb4etjoA6Gr062MNqRczFyPgmh4b
         jdiELRfXTNocSRqNdSWJz0iPRsynbaMydy5ZPg+hz4MQ0+g0WTW/f6lpyBFKuN8vw2Pv
         af16k/LqKovZaSH9qAzESAJx2gro8Sv/RUU5MB9/T7Qa1W5xXyH63yaghkA/kbfkS0+Y
         S8xyisElsAbgPZD6v/5CYMDWuEsxmJfwbNPC3pamIbQc6xmycfU6CvEH1f9y7ejp3DYb
         HCMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:openpgp
         :autocrypt:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=30S083hNm5bzPjo2JVzG/E0bkXH5Uh7GRbmZ7o0lvjg=;
        b=i36pHMOR4ZcWq+vJGoEsHKQFzsNuuPDlF5ea63ppXBcos4vmCsYOsPO7tkKmWcs4U6
         wLbUWROQSJAz/AsY0k3TV6GQt0fm3pD50gwvoNgDeKoJumkj7iQCjydoV6B8K+aVno3J
         75172+jqUgFU8rg5He/1AT/Za39/1MmMMQVTkokDo0zftZq5WFtrI8I4bgnov9AEUAj9
         tDIcvhNvKmN4d7dtXLieQrF91n4GYsbuwGqeGUG1mnsSYAJIypfIdfE6WrwHPjzf+beG
         217otEXYUu3dDwoc8xXUtWH6N+9FPZVovZV/R/nD64hzsZV3bQ4q0orKzfMDiHYhJV6F
         O0+g==
X-Gm-Message-State: AHQUAuaMaTgqwiDlCNDPS9ZAyiEJsmex0tcFVHf1pSOLXpTzm909faq4
        PRSaWYchyVwkbKZrvP/N6iHB/WfY
X-Google-Smtp-Source: APXvYqxxWTA8R0Rt13x/cv50wM3usZIq0ikjERVi/FVA/4OPD9/YsUq2Q/XWef72INPLPuyRq7fMBg==
X-Received: by 2002:a1c:4c1a:: with SMTP id z26mr10705376wmf.139.1551688946516;
        Mon, 04 Mar 2019 00:42:26 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:102e:b101:9b89:f7ef? ([2001:b07:6468:f312:102e:b101:9b89:f7ef])
        by smtp.googlemail.com with ESMTPSA id n3sm7338689wrs.10.2019.03.04.00.42.25
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Mar 2019 00:42:25 -0800 (PST)
Subject: Re: [PATCH v4 16/17] kvm: x86: Add support IA32_CORE_CAPABILITY MSR
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>,
        kvm@vger.kernel.org, Xiaoyao Li <xiaoyao.li@linux.intel.com>
References: <1551494711-213533-1-git-send-email-fenghua.yu@intel.com>
 <1551494711-213533-17-git-send-email-fenghua.yu@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
 uUHgL9dKIfvpm+rNXRn9wAwGjk0X/A==
Message-ID: <74630db9-2a83-cd72-73f6-8b9ef9b07313@redhat.com>
Date:   Mon, 4 Mar 2019 09:42:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1551494711-213533-17-git-send-email-fenghua.yu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/03/19 03:45, Fenghua Yu wrote:
> From: Xiaoyao Li <xiaoyao.li@linux.intel.com>
> 
> MSR IA32_CORE_CAPABILITY is a feature-enumerating MSR, bit 5 of which
> reports the capability of enabling detection of split locks (will be
> supported on future processors based on Tremont microarchitecture and
> later).
> 
> Please check the latest Intel Architecture Instruction Set Extensions
> and Future Features Programming Reference for more detailed information
> on the MSR and the split lock bit.
> 
> 1. Expose it to user space as a feature-enumerating MSR, so that user
> space can query it.
> 
> 2. Emualte MSR_IA32_CORE_CAPABILITY with vmx->core_capability. And add the
> get and set handler of MSR_IA32_CORE_CAPABILITY.
>    For uesrspace, it can set this MSR when customizing features of guest,
> also it can read the value of this MSR of guest.
>    For guest, as it's a feature-enumerating MSR, guest only can read it.
> 
> Signed-off-by: Xiaoyao Li <xiaoyao.li@linux.intel.com>
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> ---
>  arch/x86/include/asm/kvm_host.h |  1 +
>  arch/x86/kvm/vmx/vmx.c          | 23 +++++++++++++++++++++++
>  arch/x86/kvm/vmx/vmx.h          |  1 +
>  arch/x86/kvm/x86.c              | 17 ++++++++++++++++-
>  4 files changed, 41 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 180373360e34..208f15570d17 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -1527,6 +1527,7 @@ int kvm_pv_send_ipi(struct kvm *kvm, unsigned long ipi_bitmap_low,
>  		    unsigned long icr, int op_64_bit);
>  
>  u64 kvm_get_arch_capabilities(void);
> +u64 kvm_get_core_capability(void);
>  void kvm_define_shared_msr(unsigned index, u32 msr);
>  int kvm_set_shared_msr(unsigned index, u64 val, u64 mask);
>  
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 30a6bcd735ec..3e03c6e1e558 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -1679,6 +1679,12 @@ static int vmx_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  
>  		msr_info->data = to_vmx(vcpu)->spec_ctrl;
>  		break;
> +	case MSR_IA32_CORE_CAPABILITY:
> +		if (!msr_info->host_initiated &&
> +		    !guest_cpuid_has(vcpu, X86_FEATURE_CORE_CAPABILITY))
> +			return 1;
> +		msr_info->data = vmx->core_capability;
> +		break;
>  	case MSR_IA32_ARCH_CAPABILITIES:
>  		if (!msr_info->host_initiated &&
>  		    !guest_cpuid_has(vcpu, X86_FEATURE_ARCH_CAPABILITIES))
> @@ -1891,6 +1897,21 @@ static int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  		vmx_disable_intercept_for_msr(vmx->vmcs01.msr_bitmap, MSR_IA32_PRED_CMD,
>  					      MSR_TYPE_W);
>  		break;
> +	case MSR_IA32_CORE_CAPABILITY:
> +		if (!msr_info->host_initiated)
> +			return 1;
> +		if (data & ~CORE_CAP_SPLIT_LOCK_DETECT)
> +			return 1;
> +
> +		/*
> +		 * Since AC split lock is a hardware feature, and there is no
> +		 * software emulation yet, we cannot enable it for guest if
> +		 * host hardware doesn't support it.
> +		 */
> +		if (!boot_cpu_has(X86_FEATURE_SPLIT_LOCK_DETECT))
> +			data &= ~CORE_CAP_SPLIT_LOCK_DETECT;
> +		vmx->core_capability = data;
> +		break;
>  	case MSR_IA32_ARCH_CAPABILITIES:
>  		if (!msr_info->host_initiated)
>  			return 1;
> @@ -4083,6 +4104,8 @@ static void vmx_vcpu_setup(struct vcpu_vmx *vmx)
>  		++vmx->nmsrs;
>  	}
>  
> +	vmx->core_capability = kvm_get_core_capability();
> +
>  	vmx->arch_capabilities = kvm_get_arch_capabilities();
>  
>  	vm_exit_controls_init(vmx, vmx_vmexit_ctrl());
> diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
> index 0ac0a64c7790..cc22379991f3 100644
> --- a/arch/x86/kvm/vmx/vmx.h
> +++ b/arch/x86/kvm/vmx/vmx.h
> @@ -191,6 +191,7 @@ struct vcpu_vmx {
>  	u64		      msr_guest_kernel_gs_base;
>  #endif
>  
> +	u64		      core_capability;
>  	u64		      arch_capabilities;
>  	u64		      spec_ctrl;
>  
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 941f932373d0..c3c9e3f2d08a 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -1125,7 +1125,8 @@ static u32 msrs_to_save[] = {
>  #endif
>  	MSR_IA32_TSC, MSR_IA32_CR_PAT, MSR_VM_HSAVE_PA,
>  	MSR_IA32_FEATURE_CONTROL, MSR_IA32_BNDCFGS, MSR_TSC_AUX,
> -	MSR_IA32_SPEC_CTRL, MSR_IA32_ARCH_CAPABILITIES,
> +	MSR_IA32_SPEC_CTRL, MSR_IA32_CORE_CAPABILITY,
> +	MSR_IA32_ARCH_CAPABILITIES,
>  	MSR_IA32_RTIT_CTL, MSR_IA32_RTIT_STATUS, MSR_IA32_RTIT_CR3_MATCH,
>  	MSR_IA32_RTIT_OUTPUT_BASE, MSR_IA32_RTIT_OUTPUT_MASK,
>  	MSR_IA32_RTIT_ADDR0_A, MSR_IA32_RTIT_ADDR0_B,
> @@ -1197,11 +1198,22 @@ static u32 msr_based_features[] = {
>  
>  	MSR_F10H_DECFG,
>  	MSR_IA32_UCODE_REV,
> +	MSR_IA32_CORE_CAPABILITY,
>  	MSR_IA32_ARCH_CAPABILITIES,
>  };
>  
>  static unsigned int num_msr_based_features;
>  
> +u64 kvm_get_core_capability(void)
> +{
> +	u64 data;
> +
> +	rdmsrl_safe(MSR_IA32_CORE_CAPABILITY, &data);

This patch should be merged with the previous patch.  Also here you
should add:

	data &= CORE_CAP_SPLIT_LOCK_DETECT;

so that non-virtualizable features are hidden and

	if (boot_cpu_has(X86_FEATURE_SPLIT_LOCK_DETECT))
		data |= CORE_CAP_SPLIT_LOCK_DETECT;

so that userspace gets "for free" the FMS list that will be added
later to the kernel.

Thanks,

Paolo

> +
> +	return data;
> +}
> +EXPORT_SYMBOL_GPL(kvm_get_core_capability);
> +
>  u64 kvm_get_arch_capabilities(void)
>  {
>  	u64 data;
> @@ -1227,6 +1239,9 @@ EXPORT_SYMBOL_GPL(kvm_get_arch_capabilities);
>  static int kvm_get_msr_feature(struct kvm_msr_entry *msr)
>  {
>  	switch (msr->index) {
> +	case MSR_IA32_CORE_CAPABILITY:
> +		msr->data = kvm_get_core_capability();
> +		break;
>  	case MSR_IA32_ARCH_CAPABILITIES:
>  		msr->data = kvm_get_arch_capabilities();
>  		break;
> 

