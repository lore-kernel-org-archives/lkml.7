Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ADEEC43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 03:39:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0797120838
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 03:39:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727717AbfCBDi7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 22:38:59 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:53560 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726412AbfCBDi7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 22:38:59 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A4143D35FE599429F0AD;
        Sat,  2 Mar 2019 11:38:54 +0800 (CST)
Received: from HGHY2Y004646261.china.huawei.com (10.184.12.158) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.408.0; Sat, 2 Mar 2019 11:38:48 +0800
From:   Zenghui Yu <yuzenghui@huawei.com>
To:     <christoffer.dall@arm.com>, <marc.zyngier@arm.com>
CC:     <james.morse@arm.com>, <julien.thierry@arm.com>,
        <suzuki.poulose@arm.com>, <wanghaibin.wang@huawei.com>,
        <kvmarm@lists.cs.columbia.edu>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Zenghui Yu <yuzenghui@huawei.com>,
        Punit Agrawal <punit.agrawal@arm.com>
Subject: [RFC PATCH] KVM: arm64: Force a PTE mapping when logging is enabled
Date:   Sat, 2 Mar 2019 03:35:28 +0000
Message-ID: <1551497728-12576-1-git-send-email-yuzenghui@huawei.com>
X-Mailer: git-send-email 2.6.4.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.184.12.158]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The idea behind this is: we don't want to keep tracking of huge pages when
logging_active is true, which will result in performance degradation.  We
still need to set vma_pagesize to PAGE_SIZE, so that we can make use of it
to force a PTE mapping.

Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Punit Agrawal <punit.agrawal@arm.com>
Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>

---
Atfer looking into https://patchwork.codeaurora.org/patch/647985/ , the
"vma_pagesize = PAGE_SIZE" logic was not intended to be deleted. As far
as I can tell, we used to have "hugetlb" to force the PTE mapping, but
we have "vma_pagesize" currently instead. We should set it properly for
performance reasons (e.g, in VM migration). Did I miss something important?

---
 virt/kvm/arm/mmu.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
index 30251e2..7d41b16 100644
--- a/virt/kvm/arm/mmu.c
+++ b/virt/kvm/arm/mmu.c
@@ -1705,6 +1705,13 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 	     (vma_pagesize == PUD_SIZE && kvm_stage2_has_pmd(kvm))) &&
 	    !force_pte) {
 		gfn = (fault_ipa & huge_page_mask(hstate_vma(vma))) >> PAGE_SHIFT;
+	} else {
+		/*
+		 * Fallback to PTE if it's not one of the stage2
+		 * supported hugepage sizes or the corresponding level
+		 * doesn't exist, or logging is enabled.
+		 */
+		vma_pagesize = PAGE_SIZE;
 	}
 	up_read(&current->mm->mmap_sem);
 
-- 
1.8.3.1


