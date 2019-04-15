Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B9CFC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 17:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 272362073F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 17:35:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727991AbfDORfO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 13:35:14 -0400
Received: from mga18.intel.com ([134.134.136.126]:58065 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726956AbfDORfO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 13:35:14 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Apr 2019 10:35:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,354,1549958400"; 
   d="scan'208,223";a="291761535"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.181])
  by orsmga004.jf.intel.com with ESMTP; 15 Apr 2019 10:35:13 -0700
Date:   Mon, 15 Apr 2019 10:35:13 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH] KVM: nVMX: always use early vmcs check when EPT is
 disabled
Message-ID: <20190415173513.GF24010@linux.intel.com>
References: <1555337156-37142-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0F1p//8PRICkK4MW"
Content-Disposition: inline
In-Reply-To: <1555337156-37142-1-git-send-email-pbonzini@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 15, 2019 at 04:05:56PM +0200, Paolo Bonzini wrote:
> The remaining failures of vmx.flat when EPT is disabled are caused by
> incorrectly reflecting VMfails to the L1 hypervisor.  What happens is
> that nested_vmx_restore_host_state corrupts the guest CR3, reloading it
> with the host's shadow CR3 instead, because it blindly loads GUEST_CR3
> from the vmcs01.
> 
> For simplicity let's just always use hardware VMCS checks when EPT is
> disabled.  This way, nested_vmx_restore_host_state is not reached at
> all (or at least shouldn't be reached).

At the risk of getting too clever, we can handle this scenario by stashing
L1's CR3 in vmcs01.GUEST_CR3 immediately prior to loading L2's state.

The attached patch passes vmx.flat with ept=0, haven't tested it beyond
that.

Side topic, your patch was missing your SOB.

--0F1p//8PRICkK4MW
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="0001-KVM-nVMX-Stash-L1-s-CR3-in-vmcs01.GUEST_CR3-on-neste.patch"

From 32ee6be1ba6490c59db6843b2f88e18539a49961 Mon Sep 17 00:00:00 2001
From: Sean Christopherson <sean.j.christopherson@intel.com>
Date: Mon, 15 Apr 2019 10:06:22 -0700
Subject: [PATCH] KVM: nVMX: Stash L1's CR3 in vmcs01.GUEST_CR3 on nested entry
 w/o EPT

KVM does not have 100% coverage of VMX consistency checks, i.e. some
checks that cause VM-Fail may only be detected by hardware during a
nested VM-Entry.  In such a case, KVM must restore L1's state to the
pre-VM-Enter state as L2's state has already been loaded into KVM's
software model.

L1's CR3 and PDPTRs in particular are loaded from vmcs01.GUEST_*.  But
when EPT is disabled, the associated fields hold KVM's shadow values,
not L1's "real" values.  Fortunately, when EPT is disabled the PDPTRs
come from memory, i.e. are not cached in the VMCS.  Which leaves CR3
as the sole anomaly.  Handle CR3 by overwriting vmcs01.GUEST_CR3 with
L1's CR3 during the nested VM-Entry when EPT is disabled *and* nested
early checks are disabled, so that nested_vmx_restore_host_state() will
naturally restore the correct vcpu->arch.cr3 from vmcs01.GUEST_CR3.

Note, these shenanigans work because nested_vmx_restore_host_state()
does a full kvm_mmu_reset_context(), i.e. unloads the current MMU,
which guarantees vmcs01.GUEST_CR3 will be rewritten with a new shadow
CR3 prior to re-entering L1.  Writing vmcs01.GUEST_CR3 is done if and
only if nested early checks are disabled as "late" VM-Fail should never
happen in that case (KVM WARNs), and the conditional write avoids the
need to restore the correct GUEST_CR3 when nested_vmx_check_vmentry_hw()
fails.

Reported-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 arch/x86/kvm/vmx/nested.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index e5418f78a249..b974d2116f9e 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -2982,6 +2982,8 @@ int nested_vmx_enter_non_root_mode(struct kvm_vcpu *vcpu, bool from_vmentry)
 	if (kvm_mpx_supported() &&
 		!(vmcs12->vm_entry_controls & VM_ENTRY_LOAD_BNDCFGS))
 		vmx->nested.vmcs01_guest_bndcfgs = vmcs_read64(GUEST_BNDCFGS);
+	if (!enable_ept)
+		vmcs_writel(GUEST_CR3, vcpu->arch.cr3);
 
 	vmx_switch_vmcs(vcpu, &vmx->nested.vmcs02);
 
@@ -3802,7 +3804,8 @@ static void nested_vmx_restore_host_state(struct kvm_vcpu *vcpu)
 	 * VMFail, like everything else we just need to ensure our
 	 * software model is up-to-date.
 	 */
-	ept_save_pdptrs(vcpu);
+	if (enable_ept)
+		ept_save_pdptrs(vcpu);
 
 	kvm_mmu_reset_context(vcpu);
 
-- 
2.21.0


--0F1p//8PRICkK4MW--
