Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A823DC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 16:24:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89A6024650
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 16:24:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727740AbfLRQYp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 11:24:45 -0500
Received: from foss.arm.com ([217.140.110.172]:52038 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726980AbfLRQYm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 11:24:42 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1C28E1396;
        Wed, 18 Dec 2019 08:24:42 -0800 (PST)
Received: from e112269-lin.arm.com (e112269-lin.cambridge.arm.com [10.1.196.56])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0B4883F719;
        Wed, 18 Dec 2019 08:24:38 -0800 (PST)
From:   Steven Price <steven.price@arm.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
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
        Will Deacon <will@kernel.org>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Rutland <Mark.Rutland@arm.com>,
        "Liang, Kan" <kan.liang@linux.intel.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org
Subject: [PATCH v17 06/23] powerpc: mm: Add p?d_leaf() definitions
Date:   Wed, 18 Dec 2019 16:23:45 +0000
Message-Id: <20191218162402.45610-7-steven.price@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191218162402.45610-1-steven.price@arm.com>
References: <20191218162402.45610-1-steven.price@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

walk_page_range() is going to be allowed to walk page tables other than
those of user space. For this it needs to know when it has reached a
'leaf' entry in the page tables. This information is provided by the
p?d_leaf() functions/macros.

For powerpc p?d_is_leaf() functions already exist. Export them using the
new p?d_leaf() name.

CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Paul Mackerras <paulus@samba.org>
CC: Michael Ellerman <mpe@ellerman.id.au>
CC: linuxppc-dev@lists.ozlabs.org
CC: kvm-ppc@vger.kernel.org
Signed-off-by: Steven Price <steven.price@arm.com>
---
 arch/powerpc/include/asm/book3s/64/pgtable.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index b01624e5c467..201a69e6a355 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -1355,18 +1355,21 @@ static inline bool is_pte_rw_upgrade(unsigned long old_val, unsigned long new_va
  * Like pmd_huge() and pmd_large(), but works regardless of config options
  */
 #define pmd_is_leaf pmd_is_leaf
+#define pmd_leaf pmd_is_leaf
 static inline bool pmd_is_leaf(pmd_t pmd)
 {
 	return !!(pmd_raw(pmd) & cpu_to_be64(_PAGE_PTE));
 }
 
 #define pud_is_leaf pud_is_leaf
+#define pud_leaf pud_is_leaf
 static inline bool pud_is_leaf(pud_t pud)
 {
 	return !!(pud_raw(pud) & cpu_to_be64(_PAGE_PTE));
 }
 
 #define pgd_is_leaf pgd_is_leaf
+#define pgd_leaf pgd_is_leaf
 static inline bool pgd_is_leaf(pgd_t pgd)
 {
 	return !!(pgd_raw(pgd) & cpu_to_be64(_PAGE_PTE));
-- 
2.20.1

