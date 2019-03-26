Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 989D3C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 13:07:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6231720823
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 13:07:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731451AbfCZNH5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 09:07:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47190 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726111AbfCZNH5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 09:07:57 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 764F2C0021CA;
        Tue, 26 Mar 2019 13:07:51 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.43.2.155])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9E2408386F;
        Tue, 26 Mar 2019 13:07:48 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Jon Doron <arilou@gmail.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Liran Alon <liran.alon@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] KVM: x86: nVMX: allow RSM to restore VMXE CR4 flag
Date:   Tue, 26 Mar 2019 14:07:46 +0100
Message-Id: <20190326130746.28748-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Tue, 26 Mar 2019 13:07:56 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 5bea5123cbf0 ("KVM: VMX: check nested state and CR4.VMXE against
SMM") introduced a check to vmx_set_cr4() forbidding to set VMXE from SMM.
The check is correct, however, there is a special case when RSM is called
to leave SMM: rsm_enter_protected_mode() is called with HF_SMM_MASK still
set and in case VMXE was set before entering SMM we're failing to return.

Resolve the issue by temporary dropping HF_SMM_MASK around set_cr4() calls
when ops->set_cr() is called from RSM.

Reported-by: Jon Doron <arilou@gmail.com>
Suggested-by: Liran Alon <liran.alon@oracle.com>
Fixes: 5bea5123cbf0 ("KVM: VMX: check nested state and CR4.VMXE against SMM")
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
- Instread of putting the temporary HF_SMM_MASK drop to
  rsm_enter_protected_mode() (as was suggested by Liran), move it to
  emulator_set_cr() modifying its interface. emulate.c seems to be
  vcpu-specifics-free at this moment, we may want to keep it this way.
- It seems that Hyper-V+UEFI on KVM is still broken, I'm observing sporadic
  hangs even with this patch. These hangs, however, seem to be unrelated to
  rsm.
---
 arch/x86/include/asm/kvm_emulate.h |  3 ++-
 arch/x86/kvm/emulate.c             | 27 ++++++++++++++-------------
 arch/x86/kvm/x86.c                 | 12 +++++++++++-
 3 files changed, 27 insertions(+), 15 deletions(-)

diff --git a/arch/x86/include/asm/kvm_emulate.h b/arch/x86/include/asm/kvm_emulate.h
index 93c4bf598fb0..6c33caa82fa5 100644
--- a/arch/x86/include/asm/kvm_emulate.h
+++ b/arch/x86/include/asm/kvm_emulate.h
@@ -203,7 +203,8 @@ struct x86_emulate_ops {
 	void (*set_gdt)(struct x86_emulate_ctxt *ctxt, struct desc_ptr *dt);
 	void (*set_idt)(struct x86_emulate_ctxt *ctxt, struct desc_ptr *dt);
 	ulong (*get_cr)(struct x86_emulate_ctxt *ctxt, int cr);
-	int (*set_cr)(struct x86_emulate_ctxt *ctxt, int cr, ulong val);
+	int (*set_cr)(struct x86_emulate_ctxt *ctxt, int cr, ulong val,
+		      bool from_rsm);
 	int (*cpl)(struct x86_emulate_ctxt *ctxt);
 	int (*get_dr)(struct x86_emulate_ctxt *ctxt, int dr, ulong *dest);
 	int (*set_dr)(struct x86_emulate_ctxt *ctxt, int dr, ulong value);
diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index c338984c850d..a6204105d4d7 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -2413,7 +2413,7 @@ static int rsm_enter_protected_mode(struct x86_emulate_ctxt *ctxt,
 		cr3 &= ~0xfff;
 	}
 
-	bad = ctxt->ops->set_cr(ctxt, 3, cr3);
+	bad = ctxt->ops->set_cr(ctxt, 3, cr3, true);
 	if (bad)
 		return X86EMUL_UNHANDLEABLE;
 
@@ -2422,20 +2422,20 @@ static int rsm_enter_protected_mode(struct x86_emulate_ctxt *ctxt,
 	 * Then enable protected mode.	However, PCID cannot be enabled
 	 * if EFER.LMA=0, so set it separately.
 	 */
-	bad = ctxt->ops->set_cr(ctxt, 4, cr4 & ~X86_CR4_PCIDE);
+	bad = ctxt->ops->set_cr(ctxt, 4, cr4 & ~X86_CR4_PCIDE, true);
 	if (bad)
 		return X86EMUL_UNHANDLEABLE;
 
-	bad = ctxt->ops->set_cr(ctxt, 0, cr0);
+	bad = ctxt->ops->set_cr(ctxt, 0, cr0, true);
 	if (bad)
 		return X86EMUL_UNHANDLEABLE;
 
 	if (cr4 & X86_CR4_PCIDE) {
-		bad = ctxt->ops->set_cr(ctxt, 4, cr4);
+		bad = ctxt->ops->set_cr(ctxt, 4, cr4, true);
 		if (bad)
 			return X86EMUL_UNHANDLEABLE;
 		if (pcid) {
-			bad = ctxt->ops->set_cr(ctxt, 3, cr3 | pcid);
+			bad = ctxt->ops->set_cr(ctxt, 3, cr3 | pcid, true);
 			if (bad)
 				return X86EMUL_UNHANDLEABLE;
 		}
@@ -2581,7 +2581,7 @@ static int em_rsm(struct x86_emulate_ctxt *ctxt)
 
 		/* Zero CR4.PCIDE before CR0.PG.  */
 		if (cr4 & X86_CR4_PCIDE) {
-			ctxt->ops->set_cr(ctxt, 4, cr4 & ~X86_CR4_PCIDE);
+			ctxt->ops->set_cr(ctxt, 4, cr4 & ~X86_CR4_PCIDE, true);
 			cr4 &= ~X86_CR4_PCIDE;
 		}
 
@@ -2595,11 +2595,12 @@ static int em_rsm(struct x86_emulate_ctxt *ctxt)
 	/* For the 64-bit case, this will clear EFER.LMA.  */
 	cr0 = ctxt->ops->get_cr(ctxt, 0);
 	if (cr0 & X86_CR0_PE)
-		ctxt->ops->set_cr(ctxt, 0, cr0 & ~(X86_CR0_PG | X86_CR0_PE));
+		ctxt->ops->set_cr(ctxt, 0, cr0 & ~(X86_CR0_PG | X86_CR0_PE),
+				  true);
 
 	/* Now clear CR4.PAE (which must be done before clearing EFER.LME).  */
 	if (cr4 & X86_CR4_PAE)
-		ctxt->ops->set_cr(ctxt, 4, cr4 & ~X86_CR4_PAE);
+		ctxt->ops->set_cr(ctxt, 4, cr4 & ~X86_CR4_PAE, true);
 
 	/* And finally go back to 32-bit mode.  */
 	efer = 0;
@@ -3131,7 +3132,7 @@ static int load_state_from_tss32(struct x86_emulate_ctxt *ctxt,
 	int ret;
 	u8 cpl;
 
-	if (ctxt->ops->set_cr(ctxt, 3, tss->cr3))
+	if (ctxt->ops->set_cr(ctxt, 3, tss->cr3, false))
 		return emulate_gp(ctxt, 0);
 	ctxt->_eip = tss->eip;
 	ctxt->eflags = tss->eflags | 2;
@@ -3331,7 +3332,7 @@ static int emulator_do_task_switch(struct x86_emulate_ctxt *ctxt,
 		write_segment_descriptor(ctxt, tss_selector, &next_tss_desc);
 	}
 
-	ops->set_cr(ctxt, 0,  ops->get_cr(ctxt, 0) | X86_CR0_TS);
+	ops->set_cr(ctxt, 0,  ops->get_cr(ctxt, 0) | X86_CR0_TS, false);
 	ops->set_segment(ctxt, tss_selector, &next_tss_desc, 0, VCPU_SREG_TR);
 
 	if (has_error_code) {
@@ -3633,7 +3634,7 @@ static int em_movbe(struct x86_emulate_ctxt *ctxt)
 
 static int em_cr_write(struct x86_emulate_ctxt *ctxt)
 {
-	if (ctxt->ops->set_cr(ctxt, ctxt->modrm_reg, ctxt->src.val))
+	if (ctxt->ops->set_cr(ctxt, ctxt->modrm_reg, ctxt->src.val, false))
 		return emulate_gp(ctxt, 0);
 
 	/* Disable writeback. */
@@ -3766,7 +3767,7 @@ static int em_clts(struct x86_emulate_ctxt *ctxt)
 
 	cr0 = ctxt->ops->get_cr(ctxt, 0);
 	cr0 &= ~X86_CR0_TS;
-	ctxt->ops->set_cr(ctxt, 0, cr0);
+	ctxt->ops->set_cr(ctxt, 0, cr0, false);
 	return X86EMUL_CONTINUE;
 }
 
@@ -3866,7 +3867,7 @@ static int em_smsw(struct x86_emulate_ctxt *ctxt)
 static int em_lmsw(struct x86_emulate_ctxt *ctxt)
 {
 	ctxt->ops->set_cr(ctxt, 0, (ctxt->ops->get_cr(ctxt, 0) & ~0x0eul)
-			  | (ctxt->src.val & 0x0f));
+			  | (ctxt->src.val & 0x0f), false);
 	ctxt->dst.type = OP_NONE;
 	return X86EMUL_CONTINUE;
 }
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index a419656521b6..f2745e3170b6 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -5739,7 +5739,8 @@ static unsigned long emulator_get_cr(struct x86_emulate_ctxt *ctxt, int cr)
 	return value;
 }
 
-static int emulator_set_cr(struct x86_emulate_ctxt *ctxt, int cr, ulong val)
+static int emulator_set_cr(struct x86_emulate_ctxt *ctxt, int cr, ulong val,
+			   bool from_rsm)
 {
 	struct kvm_vcpu *vcpu = emul_to_vcpu(ctxt);
 	int res = 0;
@@ -5755,7 +5756,16 @@ static int emulator_set_cr(struct x86_emulate_ctxt *ctxt, int cr, ulong val)
 		res = kvm_set_cr3(vcpu, val);
 		break;
 	case 4:
+		/*
+		 * set_cr4() may forbid to set certain flags (e.g. VMXE) from
+		 * SMM but we're actually leaving it; temporary drop HF_SMM_MASK
+		 * when setting CR4.
+		 */
+		if (from_rsm)
+			vcpu->arch.hflags &= ~HF_SMM_MASK;
 		res = kvm_set_cr4(vcpu, mk_cr_64(kvm_read_cr4(vcpu), val));
+		if (from_rsm)
+			vcpu->arch.hflags |= HF_SMM_MASK;
 		break;
 	case 8:
 		res = kvm_set_cr8(vcpu, val);
-- 
2.20.1

