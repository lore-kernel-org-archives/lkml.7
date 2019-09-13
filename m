Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A272C4CEC8
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 02:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CE132084D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 02:47:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728506AbfIMCrO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 22:47:14 -0400
Received: from mga07.intel.com ([134.134.136.100]:58605 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726074AbfIMCqO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 22:46:14 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Sep 2019 19:46:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,492,1559545200"; 
   d="scan'208";a="176159510"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.41])
  by orsmga007.jf.intel.com with ESMTP; 12 Sep 2019 19:46:13 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        James Harvey <jamespharvey20@gmail.com>,
        Alex Willamson <alex.williamson@redhat.com>
Subject: [PATCH 03/11] KVM: x86/mmu: Use fast invalidate mechanism to zap MMIO sptes
Date:   Thu, 12 Sep 2019 19:46:04 -0700
Message-Id: <20190913024612.28392-4-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190913024612.28392-1-sean.j.christopherson@intel.com>
References: <20190913024612.28392-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the fast invalidate mechasim to zap MMIO sptes on a MMIO generation
wrap.  The fast invalidate flow was reintroduced to fix a livelock bug
in kvm_mmu_zap_all() that can occur if kvm_mmu_zap_all() is invoked when
the guest has live vCPUs.  I.e. using kvm_mmu_zap_all() to handle the
MMIO generation wrap is theoretically susceptible to the livelock bug.

This effectively reverts commit 4771450c345dc ("Revert "KVM: MMU: drop
kvm_mmu_zap_mmio_sptes""), i.e. restores the behavior of commit
a8eca9dcc656a ("KVM: MMU: drop kvm_mmu_zap_mmio_sptes").

Note, this actually fixes commit 571c5af06e303 ("KVM: x86/mmu:
Voluntarily reschedule as needed when zapping MMIO sptes"), but there
is no need to incrementally revert back to using fast invalidate, e.g.
doing so doesn't provide any bisection or stability benefits.

Fixes: 571c5af06e303 ("KVM: x86/mmu: Voluntarily reschedule as needed when zapping MMIO sptes")
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 arch/x86/include/asm/kvm_host.h |  1 -
 arch/x86/kvm/mmu.c              | 17 +++--------------
 2 files changed, 3 insertions(+), 15 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index fc279b513446..ef378abac00f 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -320,7 +320,6 @@ struct kvm_mmu_page {
 	struct list_head link;
 	struct hlist_node hash_link;
 	bool unsync;
-	bool mmio_cached;
 
 	/*
 	 * The following two entries are used to key the shadow page in the
diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index 373e6f052f9f..8d3fbc48d1be 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -403,8 +403,6 @@ static void mark_mmio_spte(struct kvm_vcpu *vcpu, u64 *sptep, u64 gfn,
 	mask |= (gpa & shadow_nonpresent_or_rsvd_mask)
 		<< shadow_nonpresent_or_rsvd_mask_len;
 
-	page_header(__pa(sptep))->mmio_cached = true;
-
 	trace_mark_mmio_spte(sptep, gfn, access, gen);
 	mmu_spte_set(sptep, mask);
 }
@@ -5947,7 +5945,7 @@ void kvm_mmu_slot_set_dirty(struct kvm *kvm,
 }
 EXPORT_SYMBOL_GPL(kvm_mmu_slot_set_dirty);
 
-static void __kvm_mmu_zap_all(struct kvm *kvm, bool mmio_only)
+void kvm_mmu_zap_all(struct kvm *kvm)
 {
 	struct kvm_mmu_page *sp, *node;
 	LIST_HEAD(invalid_list);
@@ -5956,14 +5954,10 @@ static void __kvm_mmu_zap_all(struct kvm *kvm, bool mmio_only)
 	spin_lock(&kvm->mmu_lock);
 restart:
 	list_for_each_entry_safe(sp, node, &kvm->arch.active_mmu_pages, link) {
-		if (mmio_only && !sp->mmio_cached)
-			continue;
 		if (sp->role.invalid && sp->root_count)
 			continue;
-		if (__kvm_mmu_prepare_zap_page(kvm, sp, &invalid_list, &ign)) {
-			WARN_ON_ONCE(mmio_only);
+		if (__kvm_mmu_prepare_zap_page(kvm, sp, &invalid_list, &ign))
 			goto restart;
-		}
 		if (cond_resched_lock(&kvm->mmu_lock))
 			goto restart;
 	}
@@ -5972,11 +5966,6 @@ static void __kvm_mmu_zap_all(struct kvm *kvm, bool mmio_only)
 	spin_unlock(&kvm->mmu_lock);
 }
 
-void kvm_mmu_zap_all(struct kvm *kvm)
-{
-	return __kvm_mmu_zap_all(kvm, false);
-}
-
 void kvm_mmu_invalidate_mmio_sptes(struct kvm *kvm, u64 gen)
 {
 	WARN_ON(gen & KVM_MEMSLOT_GEN_UPDATE_IN_PROGRESS);
@@ -5998,7 +5987,7 @@ void kvm_mmu_invalidate_mmio_sptes(struct kvm *kvm, u64 gen)
 	 */
 	if (unlikely(gen == 0)) {
 		kvm_debug_ratelimited("kvm: zapping shadow pages for mmio generation wraparound\n");
-		__kvm_mmu_zap_all(kvm, true);
+		kvm_mmu_zap_all_fast(kvm);
 	}
 }
 
-- 
2.22.0

