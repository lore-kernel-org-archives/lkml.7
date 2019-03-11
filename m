Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AED6C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 17:02:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E589B206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 17:02:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727674AbfCKRCC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 13:02:02 -0400
Received: from mga05.intel.com ([192.55.52.43]:21689 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727008AbfCKRCB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 13:02:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Mar 2019 10:02:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,468,1544515200"; 
   d="scan'208";a="121720581"
Received: from lxy-dell.sh.intel.com ([10.239.159.147])
  by orsmga007.jf.intel.com with ESMTP; 11 Mar 2019 10:01:59 -0700
Message-ID: <b31a91e8e79673f6f547826caae37b329d72b5a3.camel@linux.intel.com>
Subject: Re: [PATCH v4 17/17] kvm: vmx: Emulate TEST_CTL MSR
From:   Xiaoyao Li <xiaoyao.li@linux.intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>,
        kvm@vger.kernel.org
Date:   Tue, 12 Mar 2019 00:58:45 +0800
In-Reply-To: <330cd5ec-813b-8835-2178-32e14190b9e6@redhat.com>
References: <1551494711-213533-1-git-send-email-fenghua.yu@intel.com>
         <1551494711-213533-18-git-send-email-fenghua.yu@intel.com>
         <58653d477d78b2a69927d8707522d91f091bcb52.camel@linux.intel.com>
         <7a10bb11-e9bf-f49c-6575-25c3da08cfac@redhat.com>
         <b7a879103eb409bea3f2664d7e7a8b1787768cf2.camel@linux.intel.com>
         <330cd5ec-813b-8835-2178-32e14190b9e6@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-03-11 at 16:21 +0100, Paolo Bonzini wrote:
> On 11/03/19 16:10, Xiaoyao Li wrote:
> > On Mon, 2019-03-11 at 14:31 +0100, Paolo Bonzini wrote:
> > > On 09/03/19 03:31, Xiaoyao Li wrote:
> > > > Hi, Paolo,
> > > > 
> > > > Do you have any comments on this patch?
> > > > 
> > > > We are preparing v5 patches for split lock detection, if you have any
> > > > comments
> > > > about this one, please let me know.
> > > 
> > > No, my only comment is that it should be placed _before_ the other two
> > > for bisectability.  I think I have already sent that small remark.
> > > 
> > > Thanks,
> > > 
> > > Paolo
> > 
> > I cannot find the small remark you sent before. Maybe I missed something.
> > But I'am confused why it should be placed _before_ the other two. This patch
> > just use the vmx->core_capability that defined it the previous patch.
> 
> Because otherwise the guest can see core_capability != 0 and will #GP
> when trying to use split lock detection.
> 
> But you are right, this patch must be the last.  Instead,
> kvm-get_core_capability() should always return  0 until the previous
> patch.  Then in this patch you add the rdmsr and boot_cpu_has() tests.
> 
> Paolo

Hi, Paolo

Thanks a lot for your explanation. It makes me better understand the
bisectability of a patchset. I really appreciate you and I love the community. I
can learn a lot here and it makes me better.

I will fix the bisectability issue following your comments.

> > > > > +		if (!(vmx->core_capability &
> > > > > CORE_CAP_SPLIT_LOCK_DETECT))
> > > > > +			return 1;
> > > > > +
> > > > > +		if (data & ~TEST_CTL_ENABLE_SPLIT_LOCK_DETECT)
> > > > > +			return 1;
> > > > > +		vmx->msr_test_ctl = data;
> > > > > +		break;
> > > > >  	case MSR_EFER:
> > > > >  		ret = kvm_set_msr_common(vcpu, msr_info);
> > > > >  		break;
> > > > > @@ -4108,6 +4122,9 @@ static void vmx_vcpu_setup(struct vcpu_vmx *vmx)
> > > > >  
> > > > >  	vmx->arch_capabilities = kvm_get_arch_capabilities();
> > > > >  
> > > > > +	/* disable AC split lock by default */
> > > > > +	vmx->msr_test_ctl = 0;
> > > > > +
> > > > >  	vm_exit_controls_init(vmx, vmx_vmexit_ctrl());
> > > > >  
> > > > >  	/* 22.2.1, 20.8.1 */
> > > > > @@ -4145,6 +4162,7 @@ static void vmx_vcpu_reset(struct kvm_vcpu
> > > > > *vcpu,
> > > > > bool
> > > > > init_event)
> > > > >  
> > > > >  	vmx->rmode.vm86_active = 0;
> > > > >  	vmx->spec_ctrl = 0;
> > > > > +	vmx->msr_test_ctl = 0;
> > > > >  
> > > > >  	vcpu->arch.microcode_version = 0x100000000ULL;
> > > > >  	vmx->vcpu.arch.regs[VCPU_REGS_RDX] = get_rdx_init_val();
> > > > > @@ -6344,6 +6362,21 @@ static void atomic_switch_perf_msrs(struct
> > > > > vcpu_vmx
> > > > > *vmx)
> > > > >  					msrs[i].host, false);
> > > > >  }
> > > > >  
> > > > > +static void atomic_switch_msr_test_ctl(struct vcpu_vmx *vmx)
> > > > > +{
> > > > > +	u64 host_msr_test_ctl;
> > > > > +
> > > > > +	if (!boot_cpu_has(X86_FEATURE_SPLIT_LOCK_DETECT))
> > > > > +		return;
> > > > > +
> > > > > +	rdmsrl(MSR_TEST_CTL, host_msr_test_ctl);
> > > > > +	if (host_msr_test_ctl == vmx->msr_test_ctl)
> > > > > +		clear_atomic_switch_msr(vmx, MSR_TEST_CTL);
> > > > > +	else
> > > > > +		add_atomic_switch_msr(vmx, MSR_TEST_CTL, vmx-
> > > > > >msr_test_ctl,
> > > > > +				      host_msr_test_ctl, false);
> > > > > +}
> > > > > +
> > > > >  static void vmx_arm_hv_timer(struct vcpu_vmx *vmx, u32 val)
> > > > >  {
> > > > >  	vmcs_write32(VMX_PREEMPTION_TIMER_VALUE, val);
> > > > > @@ -6585,6 +6618,8 @@ static void vmx_vcpu_run(struct kvm_vcpu *vcpu)
> > > > >  
> > > > >  	atomic_switch_perf_msrs(vmx);
> > > > >  
> > > > > +	atomic_switch_msr_test_ctl(vmx);
> > > > > +
> > > > >  	vmx_update_hv_timer(vcpu);
> > > > >  
> > > > >  	/*
> > > > > diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
> > > > > index cc22379991f3..e8831609c6c3 100644
> > > > > --- a/arch/x86/kvm/vmx/vmx.h
> > > > > +++ b/arch/x86/kvm/vmx/vmx.h
> > > > > @@ -191,6 +191,7 @@ struct vcpu_vmx {
> > > > >  	u64		      msr_guest_kernel_gs_base;
> > > > >  #endif
> > > > >  
> > > > > +	u64		      msr_test_ctl;
> > > > >  	u64		      core_capability;
> > > > >  	u64		      arch_capabilities;
> > > > >  	u64		      spec_ctrl;
> > > 
> > > 
> 
> 

