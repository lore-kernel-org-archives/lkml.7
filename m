Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34705C43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 20:19:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 046E8205C9
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 20:19:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbfLIUTi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 15:19:38 -0500
Received: from mga05.intel.com ([192.55.52.43]:34016 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726835AbfLIUTe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 15:19:34 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Dec 2019 12:19:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,296,1571727600"; 
   d="scan'208";a="220053131"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.202])
  by fmsmga001.fm.intel.com with ESMTP; 09 Dec 2019 12:19:33 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] KVM: x86: Fix potential put_fpu() w/o load_fpu() on MPX platform
Date:   Mon,  9 Dec 2019 12:19:31 -0800
Message-Id: <20191209201932.14259-2-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191209201932.14259-1-sean.j.christopherson@intel.com>
References: <20191209201932.14259-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unlike most state managed by XSAVE, MPX is initialized to zero on INIT.
Because INITs are usually recognized in the context of a VCPU_RUN call,
kvm_vcpu_reset() puts the guest's FPU so that the FPU state is resident
in memory, zeros the MPX state, and reloads FPU state to hardware.  But,
in the unlikely event that an INIT is recognized during
kvm_arch_vcpu_ioctl_get_mpstate() via kvm_apic_accept_events(),
kvm_vcpu_reset() will call kvm_put_guest_fpu() without a preceding
kvm_load_guest_fpu() and corrupt the guest's FPU state (and possibly
userspace's FPU state as well).

Given that MPX is being removed from the kernel[*], fix the bug with the
simple-but-ugly approach of loading the guest's FPU during
KVM_GET_MP_STATE.

[*] See commit f240652b6032b ("x86/mpx: Remove MPX APIs").

Fixes: f775b13eedee2 ("x86,kvm: move qemu/guest FPU switching out to vcpu_run")
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---

Tagged for stable since failure would trigger a WARN in the FPU subsystem.
I highly doubt anything outside of syzkaller would actually hit this.

 arch/x86/kvm/x86.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 3ed167e039e5..854ae27bb021 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -8712,6 +8712,8 @@ int kvm_arch_vcpu_ioctl_get_mpstate(struct kvm_vcpu *vcpu,
 				    struct kvm_mp_state *mp_state)
 {
 	vcpu_load(vcpu);
+	if (kvm_mpx_supported())
+		kvm_load_guest_fpu(vcpu);
 
 	kvm_apic_accept_events(vcpu);
 	if (vcpu->arch.mp_state == KVM_MP_STATE_HALTED &&
@@ -8720,6 +8722,8 @@ int kvm_arch_vcpu_ioctl_get_mpstate(struct kvm_vcpu *vcpu,
 	else
 		mp_state->mp_state = vcpu->arch.mp_state;
 
+	if (kvm_mpx_supported())
+		kvm_put_guest_fpu(vcpu);
 	vcpu_put(vcpu);
 	return 0;
 }
-- 
2.24.0

