Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57F41C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 08:48:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 399C521D7B
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 08:48:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727598AbfKSIsR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 03:48:17 -0500
Received: from mga17.intel.com ([192.55.52.151]:26340 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727407AbfKSIsO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 03:48:14 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Nov 2019 00:48:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,322,1569308400"; 
   d="scan'208";a="196427121"
Received: from unknown (HELO local-michael-cet-test.sh.intel.com) ([10.239.159.128])
  by orsmga007.jf.intel.com with ESMTP; 19 Nov 2019 00:48:09 -0800
From:   Yang Weijiang <weijiang.yang@intel.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        pbonzini@redhat.com, jmattson@google.com,
        sean.j.christopherson@intel.com
Cc:     yu.c.zhang@linux.intel.com, alazar@bitdefender.com,
        edwin.zhai@intel.com, Yang Weijiang <weijiang.yang@intel.com>
Subject: [PATCH v7 7/9] mmu: spp: Enable Lazy mode SPP protection
Date:   Tue, 19 Nov 2019 16:49:47 +0800
Message-Id: <20191119084949.15471-8-weijiang.yang@intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20191119084949.15471-1-weijiang.yang@intel.com>
References: <20191119084949.15471-1-weijiang.yang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To deal with SPP protected 4KB pages within hugepage(2MB,1GB etc),
the hugepage entry is first zapped when set subpage permission, then
in tdp_page_fault(), it checks whether the gfn should be mapped to
PT_PAGE_TABLE_LEVEL or PT_DIRECTORY_LEVEL level depending on gfn
inclusion of SPP protected page range.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
---
 arch/x86/kvm/mmu.c     | 14 ++++++++++++++
 arch/x86/kvm/vmx/spp.c | 39 +++++++++++++++++++++++++++++++++++++++
 arch/x86/kvm/vmx/spp.h |  4 ++++
 3 files changed, 57 insertions(+)

diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index a632c6b3c326..9c5be402a0b2 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -3240,6 +3240,17 @@ static int __direct_map(struct kvm_vcpu *vcpu, gpa_t gpa, int write,
 			   map_writable);
 	direct_pte_prefetch(vcpu, it.sptep);
 	++vcpu->stat.pf_fixed;
+	if (level == PT_PAGE_TABLE_LEVEL) {
+		struct kvm_subpage sbp = {0};
+		int pages;
+
+		sbp.base_gfn = gfn;
+		sbp.npages = 1;
+		pages = kvm_spp_get_permission(vcpu->kvm, &sbp);
+		if (pages == 1  && sbp.access_map[0] != FULL_SPP_ACCESS)
+			kvm_spp_mark_protection(vcpu->kvm, &sbp);
+	}
+
 	return ret;
 }
 
@@ -4183,6 +4194,9 @@ static int tdp_page_fault(struct kvm_vcpu *vcpu, gva_t gpa, u32 error_code,
 		if (level > PT_DIRECTORY_LEVEL &&
 		    !check_hugepage_cache_consistency(vcpu, gfn, level))
 			level = PT_DIRECTORY_LEVEL;
+
+		check_spp_protection(vcpu, gfn, &force_pt_level, &level);
+
 		gfn &= ~(KVM_PAGES_PER_HPAGE(level) - 1);
 	}
 
diff --git a/arch/x86/kvm/vmx/spp.c b/arch/x86/kvm/vmx/spp.c
index 0ff23b97970a..111e11bb2598 100644
--- a/arch/x86/kvm/vmx/spp.c
+++ b/arch/x86/kvm/vmx/spp.c
@@ -550,6 +550,45 @@ inline u64 construct_spptp(unsigned long root_hpa)
 }
 EXPORT_SYMBOL_GPL(construct_spptp);
 
+bool is_spp_protected(struct kvm_memory_slot *slot, gfn_t gfn, int level)
+{
+	int page_num = KVM_PAGES_PER_HPAGE(level);
+	int i;
+
+	gfn &= ~(page_num - 1);
+	for (i = 0; i < page_num; ++i) {
+		if (*gfn_to_subpage_wp_info(slot, gfn + i) != FULL_SPP_ACCESS)
+			return true;
+	}
+	return false;
+}
+
+bool check_spp_protection(struct kvm_vcpu *vcpu, gfn_t gfn,
+			  bool *force_pt_level, int *level)
+{
+	struct kvm *kvm = vcpu->kvm;
+	struct kvm_memory_slot *slot;
+	bool protected;
+	int old_level = *level;
+
+	if (!kvm->arch.spp_active)
+		return false;
+
+	slot = gfn_to_memslot(kvm, gfn);
+
+	if (!slot)
+		return false;
+	protected = is_spp_protected(slot, gfn, PT_DIRECTORY_LEVEL);
+
+	if (protected) {
+		*level = PT_PAGE_TABLE_LEVEL;
+		*force_pt_level = true;
+	} else if (is_spp_protected(slot, gfn, PT_PDPE_LEVEL))
+		*level = PT_DIRECTORY_LEVEL;
+
+	return (old_level != *level);
+}
+
 int kvm_vm_ioctl_get_subpages(struct kvm *kvm,
 			      struct kvm_subpage *spp_info)
 {
diff --git a/arch/x86/kvm/vmx/spp.h b/arch/x86/kvm/vmx/spp.h
index 208b557cac7d..1ad526866977 100644
--- a/arch/x86/kvm/vmx/spp.h
+++ b/arch/x86/kvm/vmx/spp.h
@@ -4,9 +4,13 @@
 
 #define FULL_SPP_ACCESS		((u32)((1ULL << 32) - 1))
 
+int kvm_spp_get_permission(struct kvm *kvm, struct kvm_subpage *spp_info);
+int kvm_spp_mark_protection(struct kvm *kvm, struct kvm_subpage *spp_info);
 bool is_spp_spte(struct kvm_mmu_page *sp);
 void restore_spp_bit(u64 *spte);
 bool was_spp_armed(u64 spte);
+bool check_spp_protection(struct kvm_vcpu *vcpu, gfn_t gfn,
+			  bool *force_pt_level, int *level);
 inline u64 construct_spptp(unsigned long root_hpa);
 int kvm_vm_ioctl_get_subpages(struct kvm *kvm,
 			      struct kvm_subpage *spp_info);
-- 
2.17.2

