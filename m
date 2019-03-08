Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46ECDC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 17:30:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01D9320868
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 17:30:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbfCHRaq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 12:30:46 -0500
Received: from mga14.intel.com ([192.55.52.115]:21557 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726375AbfCHRaq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 12:30:46 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Mar 2019 09:30:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,456,1544515200"; 
   d="scan'208,223";a="120870335"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.181])
  by orsmga007.jf.intel.com with ESMTP; 08 Mar 2019 09:30:44 -0800
Date:   Fri, 8 Mar 2019 09:30:45 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Yang Weijiang <weijiang.yang@intel.com>
Cc:     pbonzini@redhat.com, rkrcmar@redhat.com, jmattson@google.com,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org, mst@redhat.com,
        yu-cheng.yu@intel.com
Subject: Re: [PATCH v3 8/8] KVM:X86: Add user-space read/write interface for
 CET MSRs.
Message-ID: <20190308173044.GD2528@linux.intel.com>
References: <20190225132716.6982-1-weijiang.yang@intel.com>
 <20190225132716.6982-9-weijiang.yang@intel.com>
 <20190228163249.GH6166@linux.intel.com>
 <20190228094152.GE12006@local-michael-cet-test.sh.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ReaqsoxgOBHFXBhH"
Content-Disposition: inline
In-Reply-To: <20190228094152.GE12006@local-michael-cet-test.sh.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 28, 2019 at 05:41:52PM +0800, Yang Weijiang wrote:
> On Thu, Feb 28, 2019 at 08:32:49AM -0800, Sean Christopherson wrote:
> > On Mon, Feb 25, 2019 at 09:27:16PM +0800, Yang Weijiang wrote:

...

> > >  static int __msr_io(struct kvm_vcpu *vcpu, struct kvm_msrs *msrs,
> > > -		    struct kvm_msr_entry *entries,
> > > +		    struct kvm_msr_entry *entries, bool read,
> > >  		    int (*do_msr)(struct kvm_vcpu *vcpu,
> > >  				  unsigned index, u64 *data))
> > >  {
> > >  	int i;
> > >  
> > > -	for (i = 0; i < msrs->nmsrs; ++i)
> > > +	for (i = 0; i < msrs->nmsrs; ++i) {
> > > +		/* If it comes to CET related MSRs, read them together. */
> > > +		if (entries[i].index == MSR_IA32_U_CET) {
> > > +			i += do_cet_msrs(vcpu, i, entries, read) - 1;
> > 
> > This wrong, not to mention horribly buggy.  The correct way to handle
> > MSRs that are switched via the VMCS is to read/write the VMCS in
> > vmx_{get,set}_msr() as needed, e.g. vmcs_writel(GUEST_GS_BASE, data).
> >
> The code is barely for migration purpose since they're passed through
> to guest, I have no intent to expose them just like normal MSRs.
> I double checked the spec.:
> MSR_IA32_U_CET                  0x6a0
> MSR_IA32_PL0_SSP                0x6a4
> MSR_IA32_PL3_SSP                0x6a7
> should come from xsave area.
> 
> MSR_IA32_S_CET                  0x6a2
> MSR_IA32_INTR_SSP_TABL          0x6a8
> should come from VMCS guest fields.
> 
> for the former, they're stored in guest fpu area, need
> to restore them with xrstors temporarily before read, while the later is stored in
> VMCS guest fields, I can read them out via vmcs_read() directly.
> 
> I'd like to read them out as a whole(all or nothing) due to cost induced 
> by xsaves/xrstors, in Qemu I put these MSRs as sequential fields.
> 
> what do you think of it?

It doesn't need to be all or nothing, it should be simple enough to set
a flag when we load guest state and use it to skip reloading guest state
and to load host state before returning.  I think the attached patch
does the trick.

--ReaqsoxgOBHFXBhH
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="0001-KVM-x86-load-guest-fpu-state-when-accessing-MSRs-man.patch"

From dc3064e6a73951feae52b47dc1b44a50ae589339 Mon Sep 17 00:00:00 2001
From: Sean Christopherson <sean.j.christopherson@intel.com>
Date: Fri, 8 Mar 2019 09:12:07 -0800
Subject: [PATCH] KVM: x86: load guest fpu state when accessing MSRs managed by
 XSAVES

A handful of CET MSRs are not context switched through "traditional"
methods, e.g. VMCS or manual switching, but rather are passed through
to the guest and are saved and restored by XSAVES/XRSTORS, i.e. the
guest's FPU state.

Load the guest's FPU state if userspace is accessing MSRs whose values
are managed by XSAVES so that the MSR helper, e.g. vmx_{get,set}_msr(),
can simply do {RD,WR}MSR to access the guest's value.

Note that guest_cpuid_has() is not queried as host userspace is allowed
to access MSRs that have not been exposed to the guest, e.g. it might do
KVM_SET_MSRS prior to KVM_SET_CPUID2.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 arch/x86/kvm/x86.c | 65 +++++++++++++++++++++++++++++-----------------
 1 file changed, 41 insertions(+), 24 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index d90f011f3e32..e0d48f22edd9 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2901,6 +2901,38 @@ int kvm_get_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 }
 EXPORT_SYMBOL_GPL(kvm_get_msr_common);
 
+static bool is_xsaves_msr(u32 index)
+{
+	if (!kvm_x86_ops->xsaves_supported())
+		return false;
+
+	return index == MSR_IA32_U_CET ||
+	       (index >= MSR_IA32_PL0_SSP && index <= MSR_IA32_PL3_SSP);
+}
+
+/* Swap (qemu) user FPU context for the guest FPU context. */
+static void kvm_load_guest_fpu(struct kvm_vcpu *vcpu)
+{
+	preempt_disable();
+	copy_fpregs_to_fpstate(&current->thread.fpu);
+	/* PKRU is separately restored in kvm_x86_ops->run.  */
+	__copy_kernel_to_fpregs(&vcpu->arch.guest_fpu->state,
+				~XFEATURE_MASK_PKRU);
+	preempt_enable();
+	trace_kvm_fpu(1);
+}
+
+/* When vcpu_run ends, restore user space FPU context. */
+static void kvm_put_guest_fpu(struct kvm_vcpu *vcpu)
+{
+	preempt_disable();
+	copy_fpregs_to_fpstate(vcpu->arch.guest_fpu);
+	copy_kernel_to_fpregs(&current->thread.fpu.state);
+	preempt_enable();
+	++vcpu->stat.fpu_reload;
+	trace_kvm_fpu(0);
+}
+
 /*
  * Read or write a bunch of msrs. All parameters are kernel addresses.
  *
@@ -2911,11 +2943,19 @@ static int __msr_io(struct kvm_vcpu *vcpu, struct kvm_msrs *msrs,
 		    int (*do_msr)(struct kvm_vcpu *vcpu,
 				  unsigned index, u64 *data))
 {
+	bool fpu_loaded = false;
 	int i;
 
-	for (i = 0; i < msrs->nmsrs; ++i)
+	for (i = 0; i < msrs->nmsrs; ++i) {
+		if (!fpu_loaded && is_xsaves_msr(entries[i].index)) {
+			kvm_load_guest_fpu(vcpu);
+			fpu_loaded = true;
+		}
 		if (do_msr(vcpu, entries[i].index, &entries[i].data))
 			break;
+	}
+	if (fpu_loaded)
+		kvm_put_guest_fpu(vcpu);
 
 	return i;
 }
@@ -8116,29 +8156,6 @@ static int complete_emulated_mmio(struct kvm_vcpu *vcpu)
 	return 0;
 }
 
-/* Swap (qemu) user FPU context for the guest FPU context. */
-static void kvm_load_guest_fpu(struct kvm_vcpu *vcpu)
-{
-	preempt_disable();
-	copy_fpregs_to_fpstate(&current->thread.fpu);
-	/* PKRU is separately restored in kvm_x86_ops->run.  */
-	__copy_kernel_to_fpregs(&vcpu->arch.guest_fpu->state,
-				~XFEATURE_MASK_PKRU);
-	preempt_enable();
-	trace_kvm_fpu(1);
-}
-
-/* When vcpu_run ends, restore user space FPU context. */
-static void kvm_put_guest_fpu(struct kvm_vcpu *vcpu)
-{
-	preempt_disable();
-	copy_fpregs_to_fpstate(vcpu->arch.guest_fpu);
-	copy_kernel_to_fpregs(&current->thread.fpu.state);
-	preempt_enable();
-	++vcpu->stat.fpu_reload;
-	trace_kvm_fpu(0);
-}
-
 int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
 {
 	int r;
-- 
2.21.0


--ReaqsoxgOBHFXBhH--
