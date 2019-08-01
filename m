Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DF01C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 20:35:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF2FD206A2
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 20:35:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728726AbfHAUfc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 16:35:32 -0400
Received: from mga05.intel.com ([192.55.52.43]:47474 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725846AbfHAUf0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 16:35:26 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Aug 2019 13:35:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,335,1559545200"; 
   d="scan'208";a="191701859"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.41])
  by fmsmga001.fm.intel.com with ESMTP; 01 Aug 2019 13:35:25 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] KVM: x86/mmu: Consolidate "is MMIO SPTE" code
Date:   Thu,  1 Aug 2019 13:35:23 -0700
Message-Id: <20190801203523.5536-4-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190801203523.5536-1-sean.j.christopherson@intel.com>
References: <20190801203523.5536-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the open-coded "is MMIO SPTE" checks in the MMU warnings
related to software-based access/dirty tracking to make the code
slightly more self-documenting.

No functional change intended.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 arch/x86/kvm/mmu.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index 9ab6ff9e491b..745cbf45b32a 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -310,6 +310,11 @@ void kvm_mmu_set_mmio_spte_mask(u64 mmio_mask, u64 mmio_value, u64 access_mask)
 }
 EXPORT_SYMBOL_GPL(kvm_mmu_set_mmio_spte_mask);
 
+static bool is_mmio_spte(u64 spte)
+{
+	return (spte & shadow_mmio_mask) == shadow_mmio_value;
+}
+
 static inline bool sp_ad_disabled(struct kvm_mmu_page *sp)
 {
 	return sp->role.ad_disabled;
@@ -317,19 +322,19 @@ static inline bool sp_ad_disabled(struct kvm_mmu_page *sp)
 
 static inline bool spte_ad_enabled(u64 spte)
 {
-	MMU_WARN_ON((spte & shadow_mmio_mask) == shadow_mmio_value);
+	MMU_WARN_ON(is_mmio_spte(spte));
 	return !(spte & shadow_acc_track_value);
 }
 
 static inline u64 spte_shadow_accessed_mask(u64 spte)
 {
-	MMU_WARN_ON((spte & shadow_mmio_mask) == shadow_mmio_value);
+	MMU_WARN_ON(is_mmio_spte(spte));
 	return spte_ad_enabled(spte) ? shadow_accessed_mask : 0;
 }
 
 static inline u64 spte_shadow_dirty_mask(u64 spte)
 {
-	MMU_WARN_ON((spte & shadow_mmio_mask) == shadow_mmio_value);
+	MMU_WARN_ON(is_mmio_spte(spte));
 	return spte_ad_enabled(spte) ? shadow_dirty_mask : 0;
 }
 
@@ -404,11 +409,6 @@ static void mark_mmio_spte(struct kvm_vcpu *vcpu, u64 *sptep, u64 gfn,
 	mmu_spte_set(sptep, mask);
 }
 
-static bool is_mmio_spte(u64 spte)
-{
-	return (spte & shadow_mmio_mask) == shadow_mmio_value;
-}
-
 static gfn_t get_mmio_spte_gfn(u64 spte)
 {
 	u64 gpa = spte & shadow_nonpresent_or_rsvd_lower_gfn_mask;
-- 
2.22.0

