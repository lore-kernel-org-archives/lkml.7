Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DB15C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 21:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2F93206E0
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 21:41:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730842AbfH0Vks (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 17:40:48 -0400
Received: from mga04.intel.com ([192.55.52.120]:50844 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730693AbfH0Vkr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 17:40:47 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Aug 2019 14:40:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,438,1559545200"; 
   d="scan'208";a="182919741"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.41])
  by orsmga003.jf.intel.com with ESMTP; 27 Aug 2019 14:40:45 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Liran Alon <liran.alon@oracle.com>
Subject: [PATCH v2 02/14] KVM: x86: Clean up handle_emulation_failure()
Date:   Tue, 27 Aug 2019 14:40:28 -0700
Message-Id: <20190827214040.18710-3-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190827214040.18710-1-sean.j.christopherson@intel.com>
References: <20190827214040.18710-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When handling emulation failure, return the emulation result directly
instead of capturing it in a local variable.  Future patches will move
additional cases into handle_emulation_failure(), clean up the cruft
before so there isn't an ugly mix of setting a local variable and
returning directly.

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Reviewed-by: Liran Alon <liran.alon@oracle.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 arch/x86/kvm/x86.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index cd425f54096a..c6de5bc4fa5e 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -6207,24 +6207,22 @@ EXPORT_SYMBOL_GPL(kvm_inject_realmode_interrupt);
 
 static int handle_emulation_failure(struct kvm_vcpu *vcpu, int emulation_type)
 {
-	int r = EMULATE_DONE;
-
 	++vcpu->stat.insn_emulation_fail;
 	trace_kvm_emulate_insn_failed(vcpu);
 
 	if (emulation_type & EMULTYPE_NO_UD_ON_FAIL)
 		return EMULATE_FAIL;
 
+	kvm_queue_exception(vcpu, UD_VECTOR);
+
 	if (!is_guest_mode(vcpu) && kvm_x86_ops->get_cpl(vcpu) == 0) {
 		vcpu->run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
 		vcpu->run->internal.suberror = KVM_INTERNAL_ERROR_EMULATION;
 		vcpu->run->internal.ndata = 0;
-		r = EMULATE_USER_EXIT;
+		return EMULATE_USER_EXIT;
 	}
 
-	kvm_queue_exception(vcpu, UD_VECTOR);
-
-	return r;
+	return EMULATE_DONE;
 }
 
 static bool reexecute_instruction(struct kvm_vcpu *vcpu, gva_t cr2,
-- 
2.22.0

