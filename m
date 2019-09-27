Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ABAFC4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 21:45:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B2152146E
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 21:45:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728719AbfI0Vpp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 17:45:45 -0400
Received: from mga12.intel.com ([192.55.52.136]:45953 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726029AbfI0Vp1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 17:45:27 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Sep 2019 14:45:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,557,1559545200"; 
   d="scan'208";a="196852074"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.41])
  by FMSMGA003.fm.intel.com with ESMTP; 27 Sep 2019 14:45:26 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Reto Buerki <reet@codelabs.ch>,
        Liran Alon <liran.alon@oracle.com>
Subject: [PATCH v2 6/8] KVM: x86: Fold 'enum kvm_ex_reg' definitions into 'enum kvm_reg'
Date:   Fri, 27 Sep 2019 14:45:21 -0700
Message-Id: <20190927214523.3376-7-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190927214523.3376-1-sean.j.christopherson@intel.com>
References: <20190927214523.3376-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that indexing into arch.regs is either protected by WARN_ON_ONCE or
done with hardcoded enums, combine all definitions for registers that
are tracked by regs_avail and regs_dirty into 'enum kvm_reg'.  Having a
single enum type will simplify additional cleanup related to regs_avail
and regs_dirty.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 arch/x86/include/asm/kvm_host.h | 4 +---
 arch/x86/kvm/kvm_cache_regs.h   | 2 +-
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 23edf56cf577..a27f7f6b6b7a 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -156,10 +156,8 @@ enum kvm_reg {
 	VCPU_REGS_R15 = __VCPU_REGS_R15,
 #endif
 	VCPU_REGS_RIP,
-	NR_VCPU_REGS
-};
+	NR_VCPU_REGS,
 
-enum kvm_reg_ex {
 	VCPU_EXREG_PDPTR = NR_VCPU_REGS,
 	VCPU_EXREG_CR3,
 	VCPU_EXREG_RFLAGS,
diff --git a/arch/x86/kvm/kvm_cache_regs.h b/arch/x86/kvm/kvm_cache_regs.h
index 3972e1b65635..b85fc4b4e04f 100644
--- a/arch/x86/kvm/kvm_cache_regs.h
+++ b/arch/x86/kvm/kvm_cache_regs.h
@@ -95,7 +95,7 @@ static inline u64 kvm_pdptr_read(struct kvm_vcpu *vcpu, int index)
 
 	if (!test_bit(VCPU_EXREG_PDPTR,
 		      (unsigned long *)&vcpu->arch.regs_avail))
-		kvm_x86_ops->cache_reg(vcpu, (enum kvm_reg)VCPU_EXREG_PDPTR);
+		kvm_x86_ops->cache_reg(vcpu, VCPU_EXREG_PDPTR);
 
 	return vcpu->arch.walk_mmu->pdptrs[index];
 }
-- 
2.22.0

