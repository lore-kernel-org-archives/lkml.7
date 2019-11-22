Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 942A3C43215
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 22:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 735DB20708
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 22:41:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727275AbfKVWlB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 17:41:01 -0500
Received: from mga01.intel.com ([192.55.52.88]:61220 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726089AbfKVWkC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 17:40:02 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Nov 2019 14:40:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,231,1571727600"; 
   d="scan'208";a="409029646"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.41])
  by fmsmga006.fm.intel.com with ESMTP; 22 Nov 2019 14:40:01 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 03/13] KVM: x86: Move emulation-only helpers to emulate.c
Date:   Fri, 22 Nov 2019 14:39:49 -0800
Message-Id: <20191122223959.13545-4-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122223959.13545-1-sean.j.christopherson@intel.com>
References: <20191122223959.13545-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move ctxt_virt_addr_bits() and emul_is_noncanonical_address() from x86.h
to emulate.c.  This eliminates all references to struct x86_emulate_ctxt
from x86.h, and sets the stage for a future patch to stop including
kvm_emulate.h in asm/kvm_host.h.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 arch/x86/kvm/emulate.c | 15 +++++++++++++++
 arch/x86/kvm/x86.h     | 15 ---------------
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index 952d1a4f4d7e..596fa52e5ecb 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -670,6 +670,21 @@ static void set_segment_selector(struct x86_emulate_ctxt *ctxt, u16 selector,
 	ctxt->ops->set_segment(ctxt, selector, &desc, base3, seg);
 }
 
+static inline u8 ctxt_virt_addr_bits(struct x86_emulate_ctxt *ctxt)
+{
+	return (ctxt->ops->get_cr(ctxt, 4) & X86_CR4_LA57) ? 57 : 48;
+}
+
+static inline bool emul_is_noncanonical_address(u64 la,
+						struct x86_emulate_ctxt *ctxt)
+{
+#ifdef CONFIG_X86_64
+	return get_canonical(la, ctxt_virt_addr_bits(ctxt)) != la;
+#else
+	return false;
+#endif
+}
+
 /*
  * x86 defines three classes of vector instructions: explicitly
  * aligned, explicitly unaligned, and the rest, which change behaviour
diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index 29391af8871d..84649ec1b7f5 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -154,11 +154,6 @@ static inline u8 vcpu_virt_addr_bits(struct kvm_vcpu *vcpu)
 	return kvm_read_cr4_bits(vcpu, X86_CR4_LA57) ? 57 : 48;
 }
 
-static inline u8 ctxt_virt_addr_bits(struct x86_emulate_ctxt *ctxt)
-{
-	return (ctxt->ops->get_cr(ctxt, 4) & X86_CR4_LA57) ? 57 : 48;
-}
-
 static inline u64 get_canonical(u64 la, u8 vaddr_bits)
 {
 	return ((int64_t)la << (64 - vaddr_bits)) >> (64 - vaddr_bits);
@@ -173,16 +168,6 @@ static inline bool is_noncanonical_address(u64 la, struct kvm_vcpu *vcpu)
 #endif
 }
 
-static inline bool emul_is_noncanonical_address(u64 la,
-						struct x86_emulate_ctxt *ctxt)
-{
-#ifdef CONFIG_X86_64
-	return get_canonical(la, ctxt_virt_addr_bits(ctxt)) != la;
-#else
-	return false;
-#endif
-}
-
 static inline void vcpu_cache_mmio_info(struct kvm_vcpu *vcpu,
 					gva_t gva, gfn_t gfn, unsigned access)
 {
-- 
2.24.0

