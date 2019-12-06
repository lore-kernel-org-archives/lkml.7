Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AF84C2D0C2
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 23:58:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00CFB2245C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 23:58:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbfLFX6T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 18:58:19 -0500
Received: from mga07.intel.com ([134.134.136.100]:55585 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726578AbfLFX5k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 18:57:40 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Dec 2019 15:57:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,286,1571727600"; 
   d="scan'208";a="219530355"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.202])
  by fmsmga001.fm.intel.com with ESMTP; 06 Dec 2019 15:57:38 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 10/16] KVM: x86/mmu: Rename lpage_disallowed to account_disallowed_nx_lpage
Date:   Fri,  6 Dec 2019 15:57:23 -0800
Message-Id: <20191206235729.29263-11-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191206235729.29263-1-sean.j.christopherson@intel.com>
References: <20191206235729.29263-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename __direct_map()'s param that controls whether or not a disallowed
NX large page should be accounted to match what it actually does.  The
nonpaging_page_fault() case unconditionally passes %false for the param
even though it locally sets lpage_disallowed.

No functional change intended.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 arch/x86/kvm/mmu/mmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 8782a70abe78..a09a3bc0b6ae 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -3349,7 +3349,7 @@ static void disallowed_hugepage_adjust(struct kvm_shadow_walk_iterator it,
 
 static int __direct_map(struct kvm_vcpu *vcpu, gpa_t gpa, int write,
 			int map_writable, int level, kvm_pfn_t pfn,
-			bool prefault, bool lpage_disallowed)
+			bool prefault, bool account_disallowed_nx_lpage)
 {
 	struct kvm_shadow_walk_iterator it;
 	struct kvm_mmu_page *sp;
@@ -3378,7 +3378,7 @@ static int __direct_map(struct kvm_vcpu *vcpu, gpa_t gpa, int write,
 					      it.level - 1, true, ACC_ALL);
 
 			link_shadow_page(vcpu, it.sptep, sp);
-			if (lpage_disallowed)
+			if (account_disallowed_nx_lpage)
 				account_huge_nx_page(vcpu->kvm, sp);
 		}
 	}
-- 
2.24.0

