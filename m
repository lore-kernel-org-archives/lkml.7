Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA666C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 21:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3550206B8
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 21:42:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731997AbfHAVmI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 17:42:08 -0400
Received: from mga18.intel.com ([134.134.136.126]:22989 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729708AbfHAVmI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 17:42:08 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Aug 2019 14:42:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,335,1559545200"; 
   d="scan'208";a="175382650"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.41])
  by orsmga003.jf.intel.com with ESMTP; 01 Aug 2019 14:42:07 -0700
Date:   Thu, 1 Aug 2019 14:42:07 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Krish Sadhukhan <krish.sadhukhan@oracle.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: x86: Unconditionally call x86 ops that are always
 implemented
Message-ID: <20190801214207.GF6783@linux.intel.com>
References: <20190801164606.20777-1-sean.j.christopherson@intel.com>
 <3337d56f-de99-6879-96c2-0255db68541d@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3337d56f-de99-6879-96c2-0255db68541d@oracle.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 01, 2019 at 02:39:38PM -0700, Krish Sadhukhan wrote:
> 
> 
> On 08/01/2019 09:46 AM, Sean Christopherson wrote:
> >Remove two stale checks for non-NULL ops now that they're implemented by
> >both VMX and SVM.
> >
> >Fixes: 74f169090b6f ("kvm/svm: Setup MCG_CAP on AMD properly")
> >Fixes: b31c114b82b2 ("KVM: X86: Provide a capability to disable PAUSE intercepts")
> >Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> >---
> >  arch/x86/kvm/x86.c | 8 ++------
> >  1 file changed, 2 insertions(+), 6 deletions(-)
> >
> >diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> >index 01e18caac825..2c25a19d436f 100644
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
> 
> The following two ops are also implemented by both VMX and SVM:
> 
>         update_cr8_intercept
>         update_pi_irte

Drat, I didn't think to grep for !kvm_x86_ops.  I'll spin a v2.  Thanks!
