Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7A89C48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 12:48:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A20182084B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 12:48:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbfF0Ms4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 08:48:56 -0400
Received: from foss.arm.com ([217.140.110.172]:53658 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726620AbfF0Msz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 08:48:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BDB732B;
        Thu, 27 Jun 2019 05:48:54 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.1.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7A9973F718;
        Thu, 27 Jun 2019 05:48:51 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC 1/2] arm64/mm: Change THP helpers to comply with generic MM semantics
Date:   Thu, 27 Jun 2019 18:18:15 +0530
Message-Id: <1561639696-16361-2-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1561639696-16361-1-git-send-email-anshuman.khandual@arm.com>
References: <1561639696-16361-1-git-send-email-anshuman.khandual@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pmd_present() and pmd_trans_huge() are expected to behave in the following
manner during various phases of a given PMD. It is derived from a previous
detailed discussion on this topic [1] and present THP documentation [2].

pmd_present(pmd):

- Returns true if pmd refers to system RAM with a valid pmd_page(pmd)
- Returns false if pmd does not refer to system RAM - Invalid pmd_page(pmd)

pmd_trans_huge(pmd):

- Returns true if pmd refers to system RAM and is a trans huge mapping

-------------------------------------------------------------------------
|	PMD states	|	pmd_present	|	pmd_trans_huge	|
-------------------------------------------------------------------------
|	Mapped		|	Yes		|	Yes		|
-------------------------------------------------------------------------
|	Splitting	|	Yes		|	Yes		|
-------------------------------------------------------------------------
|	Migration/Swap	|	No		|	No		|
-------------------------------------------------------------------------

The problem:

PMD is first invalidated with pmdp_invalidate() before it's splitting. This
invalidation clears PMD_SECT_VALID as below.

PMD Split -> pmdp_invalidate() -> pmd_mknotpresent -> Clears PMD_SECT_VALID

Once PMD_SECT_VALID gets cleared, it results in pmd_present() return false
on the PMD entry. It will need another bit apart from PMD_SECT_VALID to re-
affirm pmd_present() as true during the THP split process. To comply with
above mentioned semantics, pmd_trans_huge() should also check pmd_present()
first before testing presence of an actual transparent huge mapping.

The solution:

Ideally PMD_TYPE_SECT should have been used here instead. But it shares the
bit position with PMD_SECT_VALID which is used for THP invalidation. Hence
it will not be there for pmd_present() check after pmdp_invalidate().

PTE_SPECIAL never gets used for PMD mapping i.e there is no pmd_special().
Hence this bit can be set on the PMD entry during invalidation which can
help in making pmd_present() return true and in recognizing the fact that
it still points to memory.

This bit is transient. During the split is process it will be overridden
by a page table page representing the normal pages in place of erstwhile
huge page. Other pmdp_invalidate() callers always write a fresh PMD value
on the entry overriding this transient PTE_SPECIAL making it safe. In the
past former pmd_[mk]splitting() functions used PTE_SPECIAL.

[1]: https://lkml.org/lkml/2018/10/17/231
[2]: https://www.kernel.org/doc/Documentation/vm/transhuge.txt

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Suzuki Poulose <suzuki.poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org

Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/include/asm/pgtable.h | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 87a4b2d..90d4e24 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -368,15 +368,31 @@ static inline int pmd_protnone(pmd_t pmd)
 }
 #endif
 
+static inline int pmd_present(pmd_t pmd)
+{
+	if (pte_present(pmd_pte(pmd)))
+		return 1;
+
+	return pte_special(pmd_pte(pmd));
+}
+
 /*
  * THP definitions.
  */
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-#define pmd_trans_huge(pmd)	(pmd_val(pmd) && !(pmd_val(pmd) & PMD_TABLE_BIT))
+static inline int pmd_trans_huge(pmd_t pmd)
+{
+	if (!pmd_val(pmd))
+		return 0;
+
+	if (!pmd_present(pmd))
+		return 0;
+
+	return !(pmd_val(pmd) & PMD_TABLE_BIT);
+}
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
-#define pmd_present(pmd)	pte_present(pmd_pte(pmd))
 #define pmd_dirty(pmd)		pte_dirty(pmd_pte(pmd))
 #define pmd_young(pmd)		pte_young(pmd_pte(pmd))
 #define pmd_valid(pmd)		pte_valid(pmd_pte(pmd))
@@ -386,7 +402,12 @@ static inline int pmd_protnone(pmd_t pmd)
 #define pmd_mkclean(pmd)	pte_pmd(pte_mkclean(pmd_pte(pmd)))
 #define pmd_mkdirty(pmd)	pte_pmd(pte_mkdirty(pmd_pte(pmd)))
 #define pmd_mkyoung(pmd)	pte_pmd(pte_mkyoung(pmd_pte(pmd)))
-#define pmd_mknotpresent(pmd)	(__pmd(pmd_val(pmd) & ~PMD_SECT_VALID))
+
+static inline pmd_t pmd_mknotpresent(pmd_t pmd)
+{
+	pmd = pte_pmd(pte_mkspecial(pmd_pte(pmd)));
+	return __pmd(pmd_val(pmd) & ~PMD_SECT_VALID);
+}
 
 #define pmd_thp_or_huge(pmd)	(pmd_huge(pmd) || pmd_trans_huge(pmd))
 
-- 
2.7.4

