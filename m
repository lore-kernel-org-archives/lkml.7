Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F502C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 11:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7A8B20854
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 11:28:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbfCNL23 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 07:28:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37512 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727286AbfCNL22 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 07:28:28 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F111B3EDB6;
        Thu, 14 Mar 2019 11:28:27 +0000 (UTC)
Received: from [10.36.112.69] (ovpn-112-69.ams2.redhat.com [10.36.112.69])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AFA48282E3;
        Thu, 14 Mar 2019 11:28:24 +0000 (UTC)
Subject: Re: [PATCH] kvm/x86/vmx: switch MSR_MISC_FEATURES_ENABLES between
 host and guest
To:     Xiaoyao Li <xiaoyao.li@linux.intel.com>
Cc:     Kyle Huey <khuey@kylehuey.com>, Chao Gao <chao.gao@intel.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190314063858.18292-1-xiaoyao.li@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=pbonzini@redhat.com; prefer-encrypt=mutual; keydata=
 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
 uUHgL9dKIfvpm+rNXRn9wAwGjk0X/A==
Message-ID: <b9fcb873-8c8c-79d8-436e-058ba4f7966a@redhat.com>
Date:   Thu, 14 Mar 2019 12:28:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190314063858.18292-1-xiaoyao.li@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Thu, 14 Mar 2019 11:28:28 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/03/19 07:38, Xiaoyao Li wrote:
> CPUID Faulting is a feature about CPUID instruction. When CPUID Faulting is
> enabled, all execution of the CPUID instruction outside system-management
> mode (SMM) cause a general-protection (#GP) if the CPL > 0.
> 
> About this feature, detailed information can be found at
> https://www.intel.com/content/dam/www/public/us/en/documents/application-notes/virtualization-technology-flexmigration-application-note.pdf
> 
> There is an issue that current kvm doesn't switch the value of
> MSR_MISC_FEATURES_ENABLES between host and guest. If MSR_MISC_FEATURES_ENABLES
> exists on the hardware cpu, and host enables CPUID faulting (setting the bit 0
> of MSR_MISC_FEATURES_ENABLES), it will impact the guest's behavior because
> cpuid faulting is enabled by host and passed to guest.
> 
> From my tests, when host enables cpuid faulting, it causes guest boot failure
> when guest uses *modprobe* to load modules. Below is the error log:
> 
> [    1.233556] traps: modprobe[71] general protection fault ip:7f0077f6495c sp:7ffda148d808 error:0 in ld-2.17.so[7f0077f4d000+22000]
> [    1.237780] traps: modprobe[73] general protection fault ip:7fad5aba095c sp:7ffd36067378 error:0 in ld-2.17.so[7fad5ab89000+22000]
> [    1.241930] traps: modprobe[75] general protection fault ip:7f3edb89495c sp:7fffa1a81308 error:0 in ld-2.17.so[7f3edb87d000+22000]
> [    1.245998] traps: modprobe[77] general protection fault ip:7f91d670895c sp:7ffc25fa7f38 error:0 in ld-2.17.so[7f91d66f1000+22000]
> [    1.250016] traps: modprobe[79] general protection fault ip:7f0ddbbdc95c sp:7ffe9c34f8d8 error:0 in ld-2.17.so[7f0ddbbc5000+22000]
> 
> *modprobe* calls CPUID instruction thus causing cpuid faulting in guest.
> At the end, because guest cannot *modprobe* modules, it boots failure.
> 
> This patch switches MSR_MISC_FEATURES_ENABLES between host and guest when
> hardware has this MSR.
> 
> This patch doesn't confict with the commit db2336a80489 ("KVM: x86: virtualize
> cpuid faulting"), which provides a software emulation of cpuid faulting for
> x86 arch. Below analysing how cpuid faulting will work after applying this patch:
> 
> 1. If host cpu is AMD. It doesn't have MSR_MISC_FEATURES_ENABLES, so we can just
> use the software emulation of cpuid faulting.
> 
> 2. If host cpu is Intel and it doesn't have MSR_MISC_FEATURES_ENABLES. The same
> as case 1, we can just use the software emulation of cpuid faulting.
> 
> 3. If host cpu is Intel and it has MSR_MISC_FEATURES_ENABLES. With this patch,
> it will write guest's value into MSR_MISC_FEATURES_ENABLES when vm entry.
> If guest enables cpuid faulting and when guest calls CPUID instruction with
> CPL > 0, it will cause #GP exception in guest instead of VM exit because of
> CPUID, thus it doesn't go to the kvm emualtion path but ues the hardware
> feature. Also it's a benefit that we needn't use VM exit to inject #GP to
> emulate cpuid faulting feature.
> 
> Intel SDM vol3.25.1.1 specifies the priority between cpuid faulting
> and CPUID instruction.
> 
> Signed-off-by: Xiaoyao Li <xiaoyao.li@linux.intel.com>
> ---
>  arch/x86/kvm/vmx/vmx.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 30a6bcd735ec..90707fae688e 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -6321,6 +6321,23 @@ static void atomic_switch_perf_msrs(struct vcpu_vmx *vmx)
>  					msrs[i].host, false);
>  }
>  
> +static void atomic_switch_msr_misc_features_enables(struct kvm_vcpu *vcpu)
> +{
> +	u64 host_msr;
> +	struct vcpu_vmx *vmx = to_vmx(vcpu);
> +
> +	/* if MSR MISC_FEATURES_ENABLES doesn't exist on the hardware, do nothing*/
> +	if (rdmsrl_safe(MSR_MISC_FEATURES_ENABLES, &host_msr))
> +		return;
> +
> +	if (host_msr == vcpu->arch.msr_misc_features_enables)
> +		clear_atomic_switch_msr(vmx, MSR_MISC_FEATURES_ENABLES);
> +	else
> +		add_atomic_switch_msr(vmx, MSR_MISC_FEATURES_ENABLES,
> +				      vcpu->arch.msr_misc_features_enables,
> +				      host_msr, false);
> +}
> +
>  static void vmx_arm_hv_timer(struct vcpu_vmx *vmx, u32 val)
>  {
>  	vmcs_write32(VMX_PREEMPTION_TIMER_VALUE, val);
> @@ -6562,6 +6579,8 @@ static void vmx_vcpu_run(struct kvm_vcpu *vcpu)
>  
>  	atomic_switch_perf_msrs(vmx);
>  
> +	atomic_switch_msr_misc_features_enables(vcpu);
> +
>  	vmx_update_hv_timer(vcpu);
>  
>  	/*
> 

Adding a RDMSR for this to each vmentry is too heavy.  Since we emulate
MSR_MISC_FEATURES_ENABLES, you can just clear the MSR on vcpu_load and
restore it on vcpu_put.

Also, this needs a test in tools/testing/selftests/kvm.

Paolo
