Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C1EAC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 08:03:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D494A20830
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 08:03:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729931AbfCYIDu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 04:03:50 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5746 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729874AbfCYIDu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 04:03:50 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id BC1D8D8CD2BD9733582F;
        Mon, 25 Mar 2019 16:03:45 +0800 (CST)
Received: from HGHY2Y004646261.china.huawei.com (10.184.12.158) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.408.0; Mon, 25 Mar 2019 16:03:36 +0800
From:   Zenghui Yu <yuzenghui@huawei.com>
To:     <christoffer.dall@arm.com>, <marc.zyngier@arm.com>
CC:     <james.morse@arm.com>, <julien.thierry@arm.com>,
        <suzuki.poulose@arm.com>, <wanghaibin.wang@huawei.com>,
        <kvmarm@lists.cs.columbia.edu>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH] KVM: arm/arm64: Comments cleanup in mmu.c
Date:   Mon, 25 Mar 2019 08:02:05 +0000
Message-ID: <1553500925-26000-1-git-send-email-yuzenghui@huawei.com>
X-Mailer: git-send-email 2.6.4.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.184.12.158]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some comments in virt/kvm/arm/mmu.c are outdated and incorrect.
Get rid of these comments, to keep the code&comment correct and
current as a whole.

Only a cleanup here, no functional change.

Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
---
 virt/kvm/arm/mmu.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
index ffd7acd..0a6efe7 100644
--- a/virt/kvm/arm/mmu.c
+++ b/virt/kvm/arm/mmu.c
@@ -102,8 +102,7 @@ static bool kvm_is_device_pfn(unsigned long pfn)
  * @addr:	IPA
  * @pmd:	pmd pointer for IPA
  *
- * Function clears a PMD entry, flushes addr 1st and 2nd stage TLBs. Marks all
- * pages in the range dirty.
+ * Function clears a PMD entry, flushes addr 1st and 2nd stage TLBs.
  */
 static void stage2_dissolve_pmd(struct kvm *kvm, phys_addr_t addr, pmd_t *pmd)
 {
@@ -121,8 +120,7 @@ static void stage2_dissolve_pmd(struct kvm *kvm, phys_addr_t addr, pmd_t *pmd)
  * @addr:	IPA
  * @pud:	pud pointer for IPA
  *
- * Function clears a PUD entry, flushes addr 1st and 2nd stage TLBs. Marks all
- * pages in the range dirty.
+ * Function clears a PUD entry, flushes addr 1st and 2nd stage TLBs.
  */
 static void stage2_dissolve_pud(struct kvm *kvm, phys_addr_t addr, pud_t *pudp)
 {
@@ -899,9 +897,8 @@ int create_hyp_exec_mappings(phys_addr_t phys_addr, size_t size,
  * kvm_alloc_stage2_pgd - allocate level-1 table for stage-2 translation.
  * @kvm:	The KVM struct pointer for the VM.
  *
- * Allocates only the stage-2 HW PGD level table(s) (can support either full
- * 40-bit input addresses or limited to 32-bit input addresses). Clears the
- * allocated pages.
+ * Allocates only the stage-2 HW PGD level table(s) of size defined by
+ * stage2_pgd_size(kvm).
  *
  * Note we don't need locking here as this is only called when the VM is
  * created, which can only be done once.
@@ -1451,13 +1448,11 @@ static void stage2_wp_pmds(struct kvm *kvm, pud_t *pud,
 }
 
 /**
-  * stage2_wp_puds - write protect PGD range
-  * @pgd:	pointer to pgd entry
-  * @addr:	range start address
-  * @end:	range end address
-  *
-  * Process PUD entries, for a huge PUD we cause a panic.
-  */
+ * stage2_wp_puds - write protect PGD range
+ * @pgd:	pointer to pgd entry
+ * @addr:	range start address
+ * @end:	range end address
+ */
 static void  stage2_wp_puds(struct kvm *kvm, pgd_t *pgd,
 			    phys_addr_t addr, phys_addr_t end)
 {
-- 
1.8.3.1


