Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74CE0C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 02:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45C1120851
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 02:35:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbfCICfP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 21:35:15 -0500
Received: from mga03.intel.com ([134.134.136.65]:5436 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726338AbfCICfO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 21:35:14 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Mar 2019 18:35:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,458,1544515200"; 
   d="scan'208";a="140439349"
Received: from lxy-dell.sh.intel.com ([10.239.159.147])
  by orsmga002.jf.intel.com with ESMTP; 08 Mar 2019 18:35:12 -0800
Message-ID: <58653d477d78b2a69927d8707522d91f091bcb52.camel@linux.intel.com>
Subject: Re: [PATCH v4 17/17] kvm: vmx: Emulate TEST_CTL MSR
From:   Xiaoyao Li <xiaoyao.li@linux.intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>,
        kvm@vger.kernel.org
Date:   Sat, 09 Mar 2019 10:31:57 +0800
In-Reply-To: <1551494711-213533-18-git-send-email-fenghua.yu@intel.com>
References: <1551494711-213533-1-git-send-email-fenghua.yu@intel.com>
         <1551494711-213533-18-git-send-email-fenghua.yu@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Paolo,

Do you have any comments on this patch?

We are preparing v5 patches for split lock detection, if you have any comments
about this one, please let me know.

Thanks,
Xiaoyao

On Fri, 2019-03-01 at 18:45 -0800, Fenghua Yu wrote:
> From: Xiaoyao Li <xiaoyao.li@linux.intel.com>
> 
> A control bit (bit 29) in TEST_CTL MSR 0x33 will be introduced in
> future x86 processors. When bit 29 is set, the processor causes #AC
> exception for split locked accesses at all CPL.
> 
> Please check the latest Intel Software Developer's Manual
> for more detailed information on the MSR and the split lock bit.
> 
> 1. Since the kernel chooses to enable AC split lock by default, which
> means if we don't emulate TEST_CTL MSR for guest, guest will run with
> this feature enable while does not known it. Thus existing guests with
> buggy firmware (like OVMF) and old kernels having the cross cache line
> issues will fail the boot due to #AC.
> 
> So we should emulate TEST_CTL MSR, and set it zero to disable AC split
> lock by default. Whether and when to enable it is left to guest firmware
> and guest kernel.
> 
> 2. Host and guest can enable AC split lock independently, so using
> msr autoload to switch it during VM entry/exit.
> 
> Signed-off-by: Xiaoyao Li <xiaoyao.li@linux.intel.com>
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> ---
>  arch/x86/kvm/vmx/vmx.c | 35 +++++++++++++++++++++++++++++++++++
>  arch/x86/kvm/vmx/vmx.h |  1 +
>  2 files changed, 36 insertions(+)
> 
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 3e03c6e1e558..c0c5e8621afa 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -1659,6 +1659,12 @@ static int vmx_get_msr(struct kvm_vcpu *vcpu, struct
> msr_data *msr_info)
>  	u32 index;
>  
>  	switch (msr_info->index) {
> +	case MSR_TEST_CTL:
> +		if (!msr_info->host_initiated &&
> +		    !(vmx->core_capability & CORE_CAP_SPLIT_LOCK_DETECT))
> +			return 1;
> +		msr_info->data = vmx->msr_test_ctl;
> +		break;
>  #ifdef CONFIG_X86_64
>  	case MSR_FS_BASE:
>  		msr_info->data = vmcs_readl(GUEST_FS_BASE);
> @@ -1805,6 +1811,14 @@ static int vmx_set_msr(struct kvm_vcpu *vcpu, struct
> msr_data *msr_info)
>  	u32 index;
>  
>  	switch (msr_index) {
> +	case MSR_TEST_CTL:
> +		if (!(vmx->core_capability & CORE_CAP_SPLIT_LOCK_DETECT))
> +			return 1;
> +
> +		if (data & ~TEST_CTL_ENABLE_SPLIT_LOCK_DETECT)
> +			return 1;
> +		vmx->msr_test_ctl = data;
> +		break;
>  	case MSR_EFER:
>  		ret = kvm_set_msr_common(vcpu, msr_info);
>  		break;
> @@ -4108,6 +4122,9 @@ static void vmx_vcpu_setup(struct vcpu_vmx *vmx)
>  
>  	vmx->arch_capabilities = kvm_get_arch_capabilities();
>  
> +	/* disable AC split lock by default */
> +	vmx->msr_test_ctl = 0;
> +
>  	vm_exit_controls_init(vmx, vmx_vmexit_ctrl());
>  
>  	/* 22.2.1, 20.8.1 */
> @@ -4145,6 +4162,7 @@ static void vmx_vcpu_reset(struct kvm_vcpu *vcpu, bool
> init_event)
>  
>  	vmx->rmode.vm86_active = 0;
>  	vmx->spec_ctrl = 0;
> +	vmx->msr_test_ctl = 0;
>  
>  	vcpu->arch.microcode_version = 0x100000000ULL;
>  	vmx->vcpu.arch.regs[VCPU_REGS_RDX] = get_rdx_init_val();
> @@ -6344,6 +6362,21 @@ static void atomic_switch_perf_msrs(struct vcpu_vmx
> *vmx)
>  					msrs[i].host, false);
>  }
>  
> +static void atomic_switch_msr_test_ctl(struct vcpu_vmx *vmx)
> +{
> +	u64 host_msr_test_ctl;
> +
> +	if (!boot_cpu_has(X86_FEATURE_SPLIT_LOCK_DETECT))
> +		return;
> +
> +	rdmsrl(MSR_TEST_CTL, host_msr_test_ctl);
> +	if (host_msr_test_ctl == vmx->msr_test_ctl)
> +		clear_atomic_switch_msr(vmx, MSR_TEST_CTL);
> +	else
> +		add_atomic_switch_msr(vmx, MSR_TEST_CTL, vmx->msr_test_ctl,
> +				      host_msr_test_ctl, false);
> +}
> +
>  static void vmx_arm_hv_timer(struct vcpu_vmx *vmx, u32 val)
>  {
>  	vmcs_write32(VMX_PREEMPTION_TIMER_VALUE, val);
> @@ -6585,6 +6618,8 @@ static void vmx_vcpu_run(struct kvm_vcpu *vcpu)
>  
>  	atomic_switch_perf_msrs(vmx);
>  
> +	atomic_switch_msr_test_ctl(vmx);
> +
>  	vmx_update_hv_timer(vcpu);
>  
>  	/*
> diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
> index cc22379991f3..e8831609c6c3 100644
> --- a/arch/x86/kvm/vmx/vmx.h
> +++ b/arch/x86/kvm/vmx/vmx.h
> @@ -191,6 +191,7 @@ struct vcpu_vmx {
>  	u64		      msr_guest_kernel_gs_base;
>  #endif
>  
> +	u64		      msr_test_ctl;
>  	u64		      core_capability;
>  	u64		      arch_capabilities;
>  	u64		      spec_ctrl;

