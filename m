Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 618B1C43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 20:19:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 250AF205C9
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 20:19:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbfLIUTg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 15:19:36 -0500
Received: from mga05.intel.com ([192.55.52.43]:34016 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726354AbfLIUTe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 15:19:34 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Dec 2019 12:19:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,296,1571727600"; 
   d="scan'208";a="220053135"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.202])
  by fmsmga001.fm.intel.com with ESMTP; 09 Dec 2019 12:19:34 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] KVM: x86: Skip zeroing of MPX state on reset event
Date:   Mon,  9 Dec 2019 12:19:32 -0800
Message-Id: <20191209201932.14259-3-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191209201932.14259-1-sean.j.christopherson@intel.com>
References: <20191209201932.14259-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't bother zeroing out MPX state in the guest's FPU on a reset event,
the guest's FPU is always zero allocated and there is no path between
kvm_arch_vcpu_create() and kvm_arch_vcpu_setup() that can lead to guest
MPX state being modified.

No functional change intended.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 arch/x86/kvm/x86.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 854ae27bb021..e6f4174f55cd 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -9194,15 +9194,14 @@ void kvm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
 	kvm_async_pf_hash_reset(vcpu);
 	vcpu->arch.apf.halted = false;
 
-	if (kvm_mpx_supported()) {
+	if (kvm_mpx_supported() && init_event) {
 		void *mpx_state_buffer;
 
 		/*
-		 * To avoid have the INIT path from kvm_apic_has_events() that be
-		 * called with loaded FPU and does not let userspace fix the state.
+		 * Temporarily flush the guest's FPU to memory so that zeroing
+		 * out the MPX areas is done using up-to-date state.
 		 */
-		if (init_event)
-			kvm_put_guest_fpu(vcpu);
+		kvm_put_guest_fpu(vcpu);
 		mpx_state_buffer = get_xsave_addr(&vcpu->arch.guest_fpu->state.xsave,
 					XFEATURE_BNDREGS);
 		if (mpx_state_buffer)
@@ -9211,8 +9210,7 @@ void kvm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
 					XFEATURE_BNDCSR);
 		if (mpx_state_buffer)
 			memset(mpx_state_buffer, 0, sizeof(struct mpx_bndcsr));
-		if (init_event)
-			kvm_load_guest_fpu(vcpu);
+		kvm_load_guest_fpu(vcpu);
 	}
 
 	if (!init_event) {
-- 
2.24.0

