Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 168F0C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 20:55:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6F3921848
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 20:55:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393053AbfHWUzq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 16:55:46 -0400
Received: from mga14.intel.com ([192.55.52.115]:48804 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392742AbfHWUzq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 16:55:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Aug 2019 13:55:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,422,1559545200"; 
   d="scan'208";a="330833026"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.41])
  by orsmga004.jf.intel.com with ESMTP; 23 Aug 2019 13:55:45 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nadav Amit <nadav.amit@gmail.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH] KVM: x86: Don't update RIP or do single-step on faulting emulation
Date:   Fri, 23 Aug 2019 13:55:44 -0700
Message-Id: <20190823205544.24052-1-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't advance RIP or inject a single-step #DB if emulation signals a
fault.  This logic applies to all state updates that are conditional on
clean retirement of the emulation instruction, e.g. updating RFLAGS was
previously handled by commit 38827dbd3fb85 ("KVM: x86: Do not update
EFLAGS on faulting emulation").

Not advancing RIP is likely a nop, i.e. ctxt->eip isn't updated with
ctxt->_eip until emulation "retires" anyways.  Skipping #DB injection
fixes a bug reported by Andy Lutomirski where a #UD on SYSCALL due to
invalid state with RFLAGS.RF=1 would loop indefinitely due to emulation
overwriting the #UD with #DB and thus restarting the bad SYSCALL over
and over.

Cc: Nadav Amit <nadav.amit@gmail.com>
Cc: stable@vger.kernel.org
Reported-by: Andy Lutomirski <luto@kernel.org>
Fixes: 663f4c61b803 ("KVM: x86: handle singlestep during emulation")
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---

Note, this has minor conflict with my recent series to cleanup the
emulator return flows[*].  The end result should look something like:

                if (!ctxt->have_exception ||
                    exception_type(ctxt->exception.vector) == EXCPT_TRAP) {
                        kvm_rip_write(vcpu, ctxt->eip);
                        if (r && ctxt->tf)
                                r = kvm_vcpu_do_singlestep(vcpu);
                        __kvm_set_rflags(vcpu, ctxt->eflags);
                }

[*] https://lkml.kernel.org/r/20190823010709.24879-1-sean.j.christopherson@intel.com

 arch/x86/kvm/x86.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index b4cfd786d0b6..d2962671c3d3 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -6611,12 +6611,13 @@ int x86_emulate_instruction(struct kvm_vcpu *vcpu,
 		unsigned long rflags = kvm_x86_ops->get_rflags(vcpu);
 		toggle_interruptibility(vcpu, ctxt->interruptibility);
 		vcpu->arch.emulate_regs_need_sync_to_vcpu = false;
-		kvm_rip_write(vcpu, ctxt->eip);
-		if (r == EMULATE_DONE && ctxt->tf)
-			kvm_vcpu_do_singlestep(vcpu, &r);
 		if (!ctxt->have_exception ||
-		    exception_type(ctxt->exception.vector) == EXCPT_TRAP)
+		    exception_type(ctxt->exception.vector) == EXCPT_TRAP) {
+			kvm_rip_write(vcpu, ctxt->eip);
+			if (r == EMULATE_DONE && ctxt->tf)
+				kvm_vcpu_do_singlestep(vcpu, &r);
 			__kvm_set_rflags(vcpu, ctxt->eflags);
+		}
 
 		/*
 		 * For STI, interrupts are shadowed; so KVM_REQ_EVENT will
-- 
2.22.0

