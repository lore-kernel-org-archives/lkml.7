Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 672F6C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 14:17:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 417D420830
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 14:17:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfDCORd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 10:17:33 -0400
Received: from foss.arm.com ([217.140.101.70]:41530 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725959AbfDCORc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 10:17:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1A197EBD;
        Wed,  3 Apr 2019 07:17:32 -0700 (PDT)
Received: from e112269-lin.arm.com (e112269-lin.cambridge.arm.com [10.1.196.69])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F06A03F68F;
        Wed,  3 Apr 2019 07:17:27 -0700 (PDT)
From:   Steven Price <steven.price@arm.com>
To:     linux-mm@kvack.org
Cc:     Steven Price <steven.price@arm.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        James Morse <james.morse@arm.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Rutland <Mark.Rutland@arm.com>,
        "Liang, Kan" <kan.liang@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@ozlabs.org>, kvm-ppc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v8 05/20] KVM: PPC: Book3S HV: Remove pmd_is_leaf()
Date:   Wed,  3 Apr 2019 15:16:12 +0100
Message-Id: <20190403141627.11664-6-steven.price@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190403141627.11664-1-steven.price@arm.com>
References: <20190403141627.11664-1-steven.price@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since pmd_large() is now always available, pmd_is_leaf() is redundant.
Replace all uses with calls to pmd_large().

CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Michael Ellerman <mpe@ellerman.id.au>
CC: Paul Mackerras <paulus@ozlabs.org>
CC: kvm-ppc@vger.kernel.org
CC: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Steven Price <steven.price@arm.com>
---
 arch/powerpc/kvm/book3s_64_mmu_radix.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_64_mmu_radix.c b/arch/powerpc/kvm/book3s_64_mmu_radix.c
index f55ef071883f..1b57b4e3f819 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_radix.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_radix.c
@@ -363,12 +363,6 @@ static void kvmppc_pte_free(pte_t *ptep)
 	kmem_cache_free(kvm_pte_cache, ptep);
 }
 
-/* Like pmd_huge() and pmd_large(), but works regardless of config options */
-static inline int pmd_is_leaf(pmd_t pmd)
-{
-	return !!(pmd_val(pmd) & _PAGE_PTE);
-}
-
 static pmd_t *kvmppc_pmd_alloc(void)
 {
 	return kmem_cache_alloc(kvm_pmd_cache, GFP_KERNEL);
@@ -460,7 +454,7 @@ static void kvmppc_unmap_free_pmd(struct kvm *kvm, pmd_t *pmd, bool full,
 	for (im = 0; im < PTRS_PER_PMD; ++im, ++p) {
 		if (!pmd_present(*p))
 			continue;
-		if (pmd_is_leaf(*p)) {
+		if (pmd_large(*p)) {
 			if (full) {
 				pmd_clear(p);
 			} else {
@@ -593,7 +587,7 @@ int kvmppc_create_pte(struct kvm *kvm, pgd_t *pgtable, pte_t pte,
 	else if (level <= 1)
 		new_pmd = kvmppc_pmd_alloc();
 
-	if (level == 0 && !(pmd && pmd_present(*pmd) && !pmd_is_leaf(*pmd)))
+	if (level == 0 && !(pmd && pmd_present(*pmd) && !pmd_large(*pmd)))
 		new_ptep = kvmppc_pte_alloc();
 
 	/* Check if we might have been invalidated; let the guest retry if so */
@@ -662,7 +656,7 @@ int kvmppc_create_pte(struct kvm *kvm, pgd_t *pgtable, pte_t pte,
 		new_pmd = NULL;
 	}
 	pmd = pmd_offset(pud, gpa);
-	if (pmd_is_leaf(*pmd)) {
+	if (pmd_large(*pmd)) {
 		unsigned long lgpa = gpa & PMD_MASK;
 
 		/* Check if we raced and someone else has set the same thing */
-- 
2.20.1

