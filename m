Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52171C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 22:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 276FF2087C
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 22:59:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392554AbfHBW7m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 18:59:42 -0400
Received: from mga09.intel.com ([134.134.136.24]:36996 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729782AbfHBW7m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 18:59:42 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Aug 2019 15:59:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,339,1559545200"; 
   d="scan'208";a="191942944"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.41])
  by fmsmga001.fm.intel.com with ESMTP; 02 Aug 2019 15:59:41 -0700
Date:   Fri, 2 Aug 2019 15:59:40 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Krish Sadhukhan <krish.sadhukhan@oracle.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] KVM: x86: Unconditionally call x86 ops that are
 always implemented
Message-ID: <20190802225940.GC23165@linux.intel.com>
References: <20190802220617.10869-1-sean.j.christopherson@intel.com>
 <c2ebed86-9342-ab88-3751-318d2a256173@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2ebed86-9342-ab88-3751-318d2a256173@oracle.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 02, 2019 at 03:48:27PM -0700, Krish Sadhukhan wrote:
> 
> On 08/02/2019 03:06 PM, Sean Christopherson wrote:
> >Remove a few stale checks for non-NULL ops now that the ops in question
> >are implemented by both VMX and SVM.
> >
> >Note, this is **not** stable material, the Fixes tags are there purely
> >to show when a particular op was first supported by both VMX and SVM.
> >
> >Fixes: 74f169090b6f ("kvm/svm: Setup MCG_CAP on AMD properly")
> >Fixes: b31c114b82b2 ("KVM: X86: Provide a capability to disable PAUSE intercepts")
> >Fixes: 411b44ba80ab ("svm: Implements update_pi_irte hook to setup posted interrupt")
> >Cc: Krish Sadhukhan <krish.sadhukhan@oracle.com>
> >Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> >---
> >
> >v2: Give update_pi_iret the same treatment [Krish].
> >
> >  arch/x86/kvm/x86.c | 13 +++----------
> >  1 file changed, 3 insertions(+), 10 deletions(-)
> >
> >diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> >index 01e18caac825..e7c993f0cbed 100644
> >--- a/arch/x86/kvm/x86.c
> >+++ b/arch/x86/kvm/x86.c
> >@@ -3506,8 +3506,7 @@ static int kvm_vcpu_ioctl_x86_setup_mce(struct kvm_vcpu *vcpu,
> >  	for (bank = 0; bank < bank_num; bank++)
> >  		vcpu->arch.mce_banks[bank*4] = ~(u64)0;
> >-	if (kvm_x86_ops->setup_mce)
> >-		kvm_x86_ops->setup_mce(vcpu);
> >+	kvm_x86_ops->setup_mce(vcpu);
> >  out:
> >  	return r;
> >  }
> >@@ -9313,10 +9312,7 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
> >  	kvm_page_track_init(kvm);
> >  	kvm_mmu_init_vm(kvm);
> >-	if (kvm_x86_ops->vm_init)
> >-		return kvm_x86_ops->vm_init(kvm);
> >-
> >-	return 0;
> >+	return kvm_x86_ops->vm_init(kvm);
> >  }
> >  static void kvm_unload_vcpu_mmu(struct kvm_vcpu *vcpu)
> >@@ -9992,7 +9988,7 @@ EXPORT_SYMBOL_GPL(kvm_arch_has_noncoherent_dma);
> >  bool kvm_arch_has_irq_bypass(void)
> 
> Now that this is returning true always and that this is called only in
> kvm_irqfd_assign(), this can perhaps be removed altogether ?

No go, PowerPC has a conditional implementation.
