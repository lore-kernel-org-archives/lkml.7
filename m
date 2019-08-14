Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC197C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 07:02:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0BE82084F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 07:02:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727693AbfHNHCs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 03:02:48 -0400
Received: from mga04.intel.com ([192.55.52.120]:42220 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727651AbfHNHCm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 03:02:42 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Aug 2019 00:02:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,384,1559545200"; 
   d="scan'208";a="181427244"
Received: from unknown (HELO local-michael-cet-test.sh.intel.com) ([10.239.159.128])
  by orsmga006.jf.intel.com with ESMTP; 14 Aug 2019 00:02:40 -0700
From:   Yang Weijiang <weijiang.yang@intel.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        pbonzini@redhat.com, sean.j.christopherson@intel.com
Cc:     mst@redhat.com, rkrcmar@redhat.com, jmattson@google.com,
        yu.c.zhang@intel.com, alazar@bitdefender.com,
        Yang Weijiang <weijiang.yang@intel.com>
Subject: [PATCH RESEND v4 8/9] KVM: MMU: Enable Lazy mode SPPT setup
Date:   Wed, 14 Aug 2019 15:04:02 +0800
Message-Id: <20190814070403.6588-9-weijiang.yang@intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190814070403.6588-1-weijiang.yang@intel.com>
References: <20190814070403.6588-1-weijiang.yang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If SPP subpages are set while the physical page are not
available in EPT leaf entry, the mapping is first stored
in SPP access bitmap buffer. SPPT setup is deferred to
access to the protected page, in EPT page fault handler,
the SPPT enries are set up.

Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
---
 arch/x86/kvm/mmu.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index 419878301375..f017fe6cd67b 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -4304,6 +4304,26 @@ check_hugepage_cache_consistency(struct kvm_vcpu *vcpu, gfn_t gfn, int level)
 	return kvm_mtrr_check_gfn_range_consistency(vcpu, gfn, page_num);
 }
 
+static int kvm_enable_spp_protection(struct kvm *kvm, u64 gfn)
+{
+	struct kvm_subpage spp_info = {0};
+	struct kvm_memory_slot *slot;
+
+	slot = gfn_to_memslot(kvm, gfn);
+	if (!slot)
+		return -EFAULT;
+
+	spp_info.base_gfn = gfn;
+	spp_info.npages = 1;
+
+	if (kvm_mmu_get_subpages(kvm, &spp_info, true) < 0)
+		return -EFAULT;
+
+	if (spp_info.access_map[0] != FULL_SPP_ACCESS)
+		kvm_mmu_set_subpages(kvm, &spp_info, true);
+
+	return 0;
+}
 static int tdp_page_fault(struct kvm_vcpu *vcpu, gva_t gpa, u32 error_code,
 			  bool prefault)
 {
@@ -4355,6 +4375,10 @@ static int tdp_page_fault(struct kvm_vcpu *vcpu, gva_t gpa, u32 error_code,
 	if (likely(!force_pt_level))
 		transparent_hugepage_adjust(vcpu, &gfn, &pfn, &level);
 	r = __direct_map(vcpu, write, map_writable, level, gfn, pfn, prefault);
+
+	if (vcpu->kvm->arch.spp_active && level == PT_PAGE_TABLE_LEVEL)
+		kvm_enable_spp_protection(vcpu->kvm, gfn);
+
 	spin_unlock(&vcpu->kvm->mmu_lock);
 
 	return r;
-- 
2.17.2

