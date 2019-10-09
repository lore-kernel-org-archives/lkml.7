Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88F1EC47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 16:38:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DC4C206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 16:38:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731767AbfJIQig (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 12:38:36 -0400
Received: from mga06.intel.com ([134.134.136.31]:9175 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730674AbfJIQif (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 12:38:35 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Oct 2019 09:38:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,276,1566889200"; 
   d="scan'208";a="205799690"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.41])
  by orsmga002.jf.intel.com with ESMTP; 09 Oct 2019 09:38:35 -0700
Date:   Wed, 9 Oct 2019 09:38:35 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Reto Buerki <reet@codelabs.ch>,
        Liran Alon <liran.alon@oracle.com>
Subject: Re: [PATCH v2 4/8] KVM: VMX: Optimize vmx_set_rflags() for
 unrestricted guest
Message-ID: <20191009163835.GB19952@linux.intel.com>
References: <20190927214523.3376-1-sean.j.christopherson@intel.com>
 <20190927214523.3376-5-sean.j.christopherson@intel.com>
 <99e57095-d855-99d7-e10e-a415c6ef13b2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99e57095-d855-99d7-e10e-a415c6ef13b2@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 09, 2019 at 12:40:53PM +0200, Paolo Bonzini wrote:
> On 27/09/19 23:45, Sean Christopherson wrote:
> > Rework vmx_set_rflags() to avoid the extra code need to handle emulation
> > of real mode and invalid state when unrestricted guest is disabled.  The
> > primary reason for doing so is to avoid the call to vmx_get_rflags(),
> > which will incur a VMREAD when RFLAGS is not already available.  When
> > running nested VMs, the majority of calls to vmx_set_rflags() will occur
> > without an associated vmx_get_rflags(), i.e. when stuffing GUEST_RFLAGS
> > during transitions between vmcs01 and vmcs02.
> > 
> > Note, vmx_get_rflags() guarantees RFLAGS is marked available.
> 
> Slightly nicer this way:
> 
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 8de9853d7ab6..62ab19d65efd 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -1431,9 +1431,17 @@ unsigned long vmx_get_rflags(struct kvm_vcpu *vcpu)
>  void vmx_set_rflags(struct kvm_vcpu *vcpu, unsigned long rflags)
>  {
>  	struct vcpu_vmx *vmx = to_vmx(vcpu);
> -	unsigned long old_rflags = vmx_get_rflags(vcpu);
> +	unsigned long old_rflags;
> +
> +	if (enable_unrestricted_guest) {
> +		__set_bit(VCPU_EXREG_RFLAGS, (ulong *)&vcpu->arch.regs_avail);
> +		vmx->rflags = rflags;
> +		vmcs_writel(GUEST_RFLAGS, rflags);
> +		return;
> +	}
> +
> +	old_rflags = vmx_get_rflags(vcpu);
>  
> -	__set_bit(VCPU_EXREG_RFLAGS, (ulong *)&vcpu->arch.regs_avail);
>  	vmx->rflags = rflags;
>  	if (vmx->rmode.vm86_active) {
>  		vmx->rmode.save_rflags = rflags;

Works for me.  Do you want me to spin a v3 to incorporate this and remove
the open coding of the RIP/RSP accessors?  Or are you planning on squashing
the changes as you apply?
