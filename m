Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 666F6C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 21:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 339BD21582
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 21:33:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728472AbfLQVdH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 16:33:07 -0500
Received: from mga04.intel.com ([192.55.52.120]:17437 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728051AbfLQVcp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 16:32:45 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Dec 2019 13:32:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,326,1571727600"; 
   d="scan'208";a="227639449"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.202])
  by orsmga002.jf.intel.com with ESMTP; 17 Dec 2019 13:32:42 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/5] KVM: x86: Move bit() helper to cpuid.h
Date:   Tue, 17 Dec 2019 13:32:39 -0800
Message-Id: <20191217213242.11712-3-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191217213242.11712-1-sean.j.christopherson@intel.com>
References: <20191217213242.11712-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move bit() to cpuid.h in preparation for incorporating the reverse_cpuid
array in bit() build-time assertions.  Opportunistically use the BIT()
macro instead of open-coding the shift.

No functional change intended.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 arch/x86/kvm/cpuid.h | 5 +++++
 arch/x86/kvm/x86.h   | 5 -----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/cpuid.h b/arch/x86/kvm/cpuid.h
index d78a61408243..a631329ebec7 100644
--- a/arch/x86/kvm/cpuid.h
+++ b/arch/x86/kvm/cpuid.h
@@ -55,6 +55,11 @@ static const struct cpuid_reg reverse_cpuid[] = {
 	[CPUID_7_EDX]         = {         7, 0, CPUID_EDX},
 };
 
+static inline u32 bit(int bitno)
+{
+	return BIT(bitno & 31);
+}
+
 static __always_inline struct cpuid_reg x86_feature_cpuid(unsigned x86_feature)
 {
 	unsigned x86_leaf = x86_feature / 32;
diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index cab5e71f0f0f..5f6b8f9a385c 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -144,11 +144,6 @@ static inline bool is_pae_paging(struct kvm_vcpu *vcpu)
 	return !is_long_mode(vcpu) && is_pae(vcpu) && is_paging(vcpu);
 }
 
-static inline u32 bit(int bitno)
-{
-	return 1 << (bitno & 31);
-}
-
 static inline u8 vcpu_virt_addr_bits(struct kvm_vcpu *vcpu)
 {
 	return kvm_read_cr4_bits(vcpu, X86_CR4_LA57) ? 57 : 48;
-- 
2.24.1

