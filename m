Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43877C3A5A1
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 01:07:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A9C723402
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 01:07:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733086AbfHWBH3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 21:07:29 -0400
Received: from mga01.intel.com ([192.55.52.88]:38007 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732771AbfHWBHP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 21:07:15 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Aug 2019 18:07:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,419,1559545200"; 
   d="scan'208";a="186733521"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.41])
  by FMSMGA003.fm.intel.com with ESMTP; 22 Aug 2019 18:07:13 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RESEND PATCH 12/13] KVM: VMX: Remove EMULATE_FAIL handling in handle_invalid_guest_state()
Date:   Thu, 22 Aug 2019 18:07:08 -0700
Message-Id: <20190823010709.24879-13-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190823010709.24879-1-sean.j.christopherson@intel.com>
References: <20190823010709.24879-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that EMULATE_FAIL is completely unused, remove the last remaning
usage where KVM does something functional in response to EMULATE_FAIL.
Leave the check in place as a WARN_ON_ONCE to provide a better paper
trail when EMULATE_{DONE,FAIL,USER_EXIT} are completely removed.

Opportunistically remove the gotos in handle_invalid_guest_state().
With the EMULATE_FAIL handling gone there is no need to have a common
handler for emulation failure and the gotos only complicate things,
e.g. the signal_pending() check always returns '1', but this is far
from obvious when glancing through the code.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 arch/x86/kvm/vmx/vmx.c | 39 +++++++++++++++++++--------------------
 1 file changed, 19 insertions(+), 20 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index efc2f913ca19..5b5f622cc092 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -5164,7 +5164,6 @@ static int handle_invalid_guest_state(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	enum emulation_result err = EMULATE_DONE;
-	int ret = 1;
 	bool intr_window_requested;
 	unsigned count = 130;
 
@@ -5187,38 +5186,38 @@ static int handle_invalid_guest_state(struct kvm_vcpu *vcpu)
 
 		err = kvm_emulate_instruction(vcpu, 0);
 
-		if (err == EMULATE_USER_EXIT) {
-			ret = 0;
-			goto out;
-		}
+		if (err == EMULATE_USER_EXIT)
+			return 0;
 
-		if (err != EMULATE_DONE)
-			goto emulation_error;
+		if (WARN_ON_ONCE(err == EMULATE_FAIL))
+			return 1;
 
 		if (vmx->emulation_required && !vmx->rmode.vm86_active &&
-		    vcpu->arch.exception.pending)
-			goto emulation_error;
+		    vcpu->arch.exception.pending) {
+			vcpu->run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
+			vcpu->run->internal.suberror =
+						KVM_INTERNAL_ERROR_EMULATION;
+			vcpu->run->internal.ndata = 0;
+			return 0;
+		}
 
 		if (vcpu->arch.halt_request) {
 			vcpu->arch.halt_request = 0;
-			ret = kvm_vcpu_halt(vcpu);
-			goto out;
+			return kvm_vcpu_halt(vcpu);
 		}
 
+		/*
+		 * Note, return 1 and not 0, vcpu_run() is responsible for
+		 * morphing the pending signal into the proper return code.
+		 */
 		if (signal_pending(current))
-			goto out;
+			return 1;
+
 		if (need_resched())
 			schedule();
 	}
 
-out:
-	return ret;
-
-emulation_error:
-	vcpu->run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
-	vcpu->run->internal.suberror = KVM_INTERNAL_ERROR_EMULATION;
-	vcpu->run->internal.ndata = 0;
-	return 0;
+	return 1;
 }
 
 static void grow_ple_window(struct kvm_vcpu *vcpu)
-- 
2.22.0

