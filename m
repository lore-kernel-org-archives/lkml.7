Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40A40C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E6B2218E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555962177;
	bh=ecGIazeDWL2MqxytT8tCGjYl5Rs0qaq/kqXtuaFnTbE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=u0I4zLbKr/7nUqaYGZvBZkMhRTwjs6b3oy1jiB3erxq0ud6c/vf1KiNYoa8xEEsP6
	 1EnMO9KWRVx3FhpWvagdKYP1QlB/5mmGBS3c8sdYlpPeUTnwyLSiqvryhf1BBIdeHq
	 t89O9+GyBI9BfPsC7OQ5EIsQ2BfApXZdDhgi94iE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729035AbfDVTm4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 15:42:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:43338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728995AbfDVTmx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 15:42:53 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 915D021738;
        Mon, 22 Apr 2019 19:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555962171;
        bh=ecGIazeDWL2MqxytT8tCGjYl5Rs0qaq/kqXtuaFnTbE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gi9iIL6DZSfXLgeshb2FdJ9XWTuSv+zZktnM1z6kLcIflqmF9rIswD7EfUyddOdQG
         KHzI/V6wCfRJFX0ljoXHCXRQv9vHyslKh3iOOLIZ9YmDrbxpEsZlSOlhM/Ccj/ZkZ/
         IJ32XKDRK8HTIEuAEIQGp53taVSliXhpPdjzXpOQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Christoffer Dall <christoffer.dall@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Sasha Levin <sashal@kernel.org>, kvmarm@lists.cs.columbia.edu
Subject: [PATCH AUTOSEL 5.0 29/98] KVM: arm/arm64: Enforce PTE mappings at stage2 when needed
Date:   Mon, 22 Apr 2019 15:40:56 -0400
Message-Id: <20190422194205.10404-29-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190422194205.10404-1-sashal@kernel.org>
References: <20190422194205.10404-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

[ Upstream commit a80868f398554842b14d07060012c06efb57c456 ]

commit 6794ad5443a2118 ("KVM: arm/arm64: Fix unintended stage 2 PMD mappings")
made the checks to skip huge mappings, stricter. However it introduced
a bug where we still use huge mappings, ignoring the flag to
use PTE mappings, by not reseting the vma_pagesize to PAGE_SIZE.

Also, the checks do not cover the PUD huge pages, that was
under review during the same period. This patch fixes both
the issues.

Fixes : 6794ad5443a2118 ("KVM: arm/arm64: Fix unintended stage 2 PMD mappings")
Reported-by: Zenghui Yu <yuzenghui@huawei.com>
Cc: Zenghui Yu <yuzenghui@huawei.com>
Cc: Christoffer Dall <christoffer.dall@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
---
 virt/kvm/arm/mmu.c | 43 +++++++++++++++++++++----------------------
 1 file changed, 21 insertions(+), 22 deletions(-)

diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
index 5cc22cdaa5ba..6dccb36465e6 100644
--- a/virt/kvm/arm/mmu.c
+++ b/virt/kvm/arm/mmu.c
@@ -1595,8 +1595,9 @@ static void kvm_send_hwpoison_signal(unsigned long address,
 	send_sig_mceerr(BUS_MCEERR_AR, (void __user *)address, lsb, current);
 }
 
-static bool fault_supports_stage2_pmd_mappings(struct kvm_memory_slot *memslot,
-					       unsigned long hva)
+static bool fault_supports_stage2_huge_mapping(struct kvm_memory_slot *memslot,
+					       unsigned long hva,
+					       unsigned long map_size)
 {
 	gpa_t gpa_start, gpa_end;
 	hva_t uaddr_start, uaddr_end;
@@ -1612,34 +1613,34 @@ static bool fault_supports_stage2_pmd_mappings(struct kvm_memory_slot *memslot,
 
 	/*
 	 * Pages belonging to memslots that don't have the same alignment
-	 * within a PMD for userspace and IPA cannot be mapped with stage-2
-	 * PMD entries, because we'll end up mapping the wrong pages.
+	 * within a PMD/PUD for userspace and IPA cannot be mapped with stage-2
+	 * PMD/PUD entries, because we'll end up mapping the wrong pages.
 	 *
 	 * Consider a layout like the following:
 	 *
 	 *    memslot->userspace_addr:
 	 *    +-----+--------------------+--------------------+---+
-	 *    |abcde|fgh  Stage-1 PMD    |    Stage-1 PMD   tv|xyz|
+	 *    |abcde|fgh  Stage-1 block  |    Stage-1 block tv|xyz|
 	 *    +-----+--------------------+--------------------+---+
 	 *
 	 *    memslot->base_gfn << PAGE_SIZE:
 	 *      +---+--------------------+--------------------+-----+
-	 *      |abc|def  Stage-2 PMD    |    Stage-2 PMD     |tvxyz|
+	 *      |abc|def  Stage-2 block  |    Stage-2 block   |tvxyz|
 	 *      +---+--------------------+--------------------+-----+
 	 *
-	 * If we create those stage-2 PMDs, we'll end up with this incorrect
+	 * If we create those stage-2 blocks, we'll end up with this incorrect
 	 * mapping:
 	 *   d -> f
 	 *   e -> g
 	 *   f -> h
 	 */
-	if ((gpa_start & ~S2_PMD_MASK) != (uaddr_start & ~S2_PMD_MASK))
+	if ((gpa_start & (map_size - 1)) != (uaddr_start & (map_size - 1)))
 		return false;
 
 	/*
 	 * Next, let's make sure we're not trying to map anything not covered
-	 * by the memslot. This means we have to prohibit PMD size mappings
-	 * for the beginning and end of a non-PMD aligned and non-PMD sized
+	 * by the memslot. This means we have to prohibit block size mappings
+	 * for the beginning and end of a non-block aligned and non-block sized
 	 * memory slot (illustrated by the head and tail parts of the
 	 * userspace view above containing pages 'abcde' and 'xyz',
 	 * respectively).
@@ -1648,8 +1649,8 @@ static bool fault_supports_stage2_pmd_mappings(struct kvm_memory_slot *memslot,
 	 * userspace_addr or the base_gfn, as both are equally aligned (per
 	 * the check above) and equally sized.
 	 */
-	return (hva & S2_PMD_MASK) >= uaddr_start &&
-	       (hva & S2_PMD_MASK) + S2_PMD_SIZE <= uaddr_end;
+	return (hva & ~(map_size - 1)) >= uaddr_start &&
+	       (hva & ~(map_size - 1)) + map_size <= uaddr_end;
 }
 
 static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
@@ -1678,12 +1679,6 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 		return -EFAULT;
 	}
 
-	if (!fault_supports_stage2_pmd_mappings(memslot, hva))
-		force_pte = true;
-
-	if (logging_active)
-		force_pte = true;
-
 	/* Let's check if we will get back a huge page backed by hugetlbfs */
 	down_read(&current->mm->mmap_sem);
 	vma = find_vma_intersection(current->mm, hva, hva + 1);
@@ -1694,6 +1689,12 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 	}
 
 	vma_pagesize = vma_kernel_pagesize(vma);
+	if (logging_active ||
+	    !fault_supports_stage2_huge_mapping(memslot, hva, vma_pagesize)) {
+		force_pte = true;
+		vma_pagesize = PAGE_SIZE;
+	}
+
 	/*
 	 * The stage2 has a minimum of 2 level table (For arm64 see
 	 * kvm_arm_setup_stage2()). Hence, we are guaranteed that we can
@@ -1701,11 +1702,9 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 	 * As for PUD huge maps, we must make sure that we have at least
 	 * 3 levels, i.e, PMD is not folded.
 	 */
-	if ((vma_pagesize == PMD_SIZE ||
-	     (vma_pagesize == PUD_SIZE && kvm_stage2_has_pmd(kvm))) &&
-	    !force_pte) {
+	if (vma_pagesize == PMD_SIZE ||
+	    (vma_pagesize == PUD_SIZE && kvm_stage2_has_pmd(kvm)))
 		gfn = (fault_ipa & huge_page_mask(hstate_vma(vma))) >> PAGE_SHIFT;
-	}
 	up_read(&current->mm->mmap_sem);
 
 	/* We need minimum second+third level pages */
-- 
2.19.1

