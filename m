Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59107C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 11:06:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BA0B208E4
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 11:06:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730366AbfDBLGe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 07:06:34 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:48892 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728748AbfDBLGd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 07:06:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 484C01688;
        Tue,  2 Apr 2019 04:06:33 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 71DAE3F59C;
        Tue,  2 Apr 2019 04:06:31 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, eric.auger@redhat.com,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Chirstoffer Dall <christoffer.dall@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Zheng Xiang <zhengxiang9@huawei.com>
Subject: [PATCH] kvm: arm: Skip stage2 huge mappings for unaligned ipa backed by THP
Date:   Tue,  2 Apr 2019 12:06:16 +0100
Message-Id: <1554203176-3958-1-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With commit a80868f398554842b14, we no longer ensure that the
THP page is properly aligned in the guest IPA. Skip the stage2
huge mapping for unaligned IPA backed by transparent hugepages.

Fixes: a80868f398554842b14 ("KVM: arm/arm64: Enforce PTE mappings at stage2 when needed")
Reported-by: Eric Auger <eric.auger@redhat.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Chirstoffer Dall <christoffer.dall@arm.com>
Cc: Zenghui Yu <yuzenghui@huawei.com>
Cc: Zheng Xiang <zhengxiang9@huawei.com>
Tested-by: Eric Auger <eric.auger@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 virt/kvm/arm/mmu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
index 27c9583..4a22f5b 100644
--- a/virt/kvm/arm/mmu.c
+++ b/virt/kvm/arm/mmu.c
@@ -1412,7 +1412,9 @@ static bool transparent_hugepage_adjust(kvm_pfn_t *pfnp, phys_addr_t *ipap)
 		 * page accordingly.
 		 */
 		mask = PTRS_PER_PMD - 1;
-		VM_BUG_ON((gfn & mask) != (pfn & mask));
+		/* Skip memslots with unaligned IPA and user address */
+		if ((gfn & mask) != (pfn & mask))
+			return false;
 		if (pfn & mask) {
 			*ipap &= PMD_MASK;
 			kvm_release_pfn_clean(pfn);
-- 
2.7.4

