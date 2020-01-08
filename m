Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54313C33C99
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 00:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E0D420656
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 00:12:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbgAHAMM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 19:12:12 -0500
Received: from mga03.intel.com ([134.134.136.65]:19849 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726462AbgAHAML (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 19:12:11 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jan 2020 16:12:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,407,1571727600"; 
   d="scan'208";a="395574291"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.202])
  by orsmga005.jf.intel.com with ESMTP; 07 Jan 2020 16:12:11 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] KVM: x86/mmu: Apply max PA check for MMIO sptes to 32-bit KVM
Date:   Tue,  7 Jan 2020 16:12:10 -0800
Message-Id: <20200108001210.12913-1-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the bogus 64-bit only condition from the check that disables MMIO
spte optimization when the system supports the max PA, i.e. doesn't have
any reserved PA bits.  32-bit KVM always uses PAE paging for the shadow
MMU, and per Intel's SDM:

  PAE paging translates 32-bit linear addresses to 52-bit physical
  addresses.

The kernel's restrictions on max physical addresses are limits on how
much memory the kernel can reasonably use, not what physical addresses
are supported by hardware.

Fixes: ce88decffd17 ("KVM: MMU: mmio page fault support")
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 arch/x86/kvm/mmu/mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 7269130ea5e2..d9c07343d979 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -6191,7 +6191,7 @@ static void kvm_set_mmio_spte_mask(void)
 	 * If reserved bit is not supported, clear the present bit to disable
 	 * mmio page fault.
 	 */
-	if (IS_ENABLED(CONFIG_X86_64) && shadow_phys_bits == 52)
+	if (shadow_phys_bits == 52)
 		mask &= ~1ull;
 
 	kvm_mmu_set_mmio_spte_mask(mask, mask, ACC_WRITE_MASK | ACC_USER_MASK);
-- 
2.24.1

