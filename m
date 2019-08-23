Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ABCDC3A5A3
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 01:08:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6617321743
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 01:08:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387500AbfHWBII (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 21:08:08 -0400
Received: from mga01.intel.com ([192.55.52.88]:37991 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732535AbfHWBHM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 21:07:12 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Aug 2019 18:07:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,419,1559545200"; 
   d="scan'208";a="186733492"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.41])
  by FMSMGA003.fm.intel.com with ESMTP; 22 Aug 2019 18:07:11 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RESEND PATCH 03/13] KVM: x86: Refactor kvm_vcpu_do_singlestep() to remove out param
Date:   Thu, 22 Aug 2019 18:06:59 -0700
Message-Id: <20190823010709.24879-4-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190823010709.24879-1-sean.j.christopherson@intel.com>
References: <20190823010709.24879-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Return the single-step emulation result directly instead of via an out
param.  Presumably at some point in the past kvm_vcpu_do_singlestep()
could be called with *r==EMULATE_USER_EXIT, but that is no longer the
case, i.e. all callers are happy to overwrite their own return variable.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 arch/x86/kvm/x86.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index c6de5bc4fa5e..fe847f8eb947 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -6377,7 +6377,7 @@ static int kvm_vcpu_check_hw_bp(unsigned long addr, u32 type, u32 dr7,
 	return dr6;
 }
 
-static void kvm_vcpu_do_singlestep(struct kvm_vcpu *vcpu, int *r)
+static int kvm_vcpu_do_singlestep(struct kvm_vcpu *vcpu)
 {
 	struct kvm_run *kvm_run = vcpu->run;
 
@@ -6386,10 +6386,10 @@ static void kvm_vcpu_do_singlestep(struct kvm_vcpu *vcpu, int *r)
 		kvm_run->debug.arch.pc = vcpu->arch.singlestep_rip;
 		kvm_run->debug.arch.exception = DB_VECTOR;
 		kvm_run->exit_reason = KVM_EXIT_DEBUG;
-		*r = EMULATE_USER_EXIT;
-	} else {
-		kvm_queue_exception_p(vcpu, DB_VECTOR, DR6_BS);
+		return EMULATE_USER_EXIT;
 	}
+	kvm_queue_exception_p(vcpu, DB_VECTOR, DR6_BS);
+	return EMULATE_DONE;
 }
 
 int kvm_skip_emulated_instruction(struct kvm_vcpu *vcpu)
@@ -6410,7 +6410,7 @@ int kvm_skip_emulated_instruction(struct kvm_vcpu *vcpu)
 	 * that sets the TF flag".
 	 */
 	if (unlikely(rflags & X86_EFLAGS_TF))
-		kvm_vcpu_do_singlestep(vcpu, &r);
+		r = kvm_vcpu_do_singlestep(vcpu);
 	return r == EMULATE_DONE;
 }
 EXPORT_SYMBOL_GPL(kvm_skip_emulated_instruction);
@@ -6613,7 +6613,7 @@ int x86_emulate_instruction(struct kvm_vcpu *vcpu,
 		vcpu->arch.emulate_regs_need_sync_to_vcpu = false;
 		kvm_rip_write(vcpu, ctxt->eip);
 		if (r == EMULATE_DONE && ctxt->tf)
-			kvm_vcpu_do_singlestep(vcpu, &r);
+			r = kvm_vcpu_do_singlestep(vcpu);
 		if (!ctxt->have_exception ||
 		    exception_type(ctxt->exception.vector) == EXCPT_TRAP)
 			__kvm_set_rflags(vcpu, ctxt->eflags);
-- 
2.22.0

